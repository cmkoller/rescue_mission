class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_question_author, only: [:destroy, :edit]
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
    # Is there a better way to do this?
    def question_params
      question_hash = params.require(:question).permit(:title, :description)
      question_hash[:user_id] = current_user.id
      question_hash
    end

    def authenticate_question_author
      @question = Question.find(params[:id])
      unless current_user == @question.user_id
        flash[:error] = "You must be the owner of the question to do that."
        redirect_to question_path(@question)
      end

    end

end
