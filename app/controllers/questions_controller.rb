class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @questions = Question.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:info] = "Question created."
      redirect_to @question
    else
      flash[:warning] = @question.errors.full_messages.join(".  ")
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      flash[:info] = "Question Updated."
      redirect_to @question
    else
      flash[:warning] = @question.errors.full_messages.join(".  ")
      render 'edit'
    end
  end

  def destroy
    Question.destroy(params[:id])
    flash[:info] = "Question Deleted."
    redirect_to :action => "index"
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end


end
