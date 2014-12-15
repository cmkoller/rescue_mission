require 'pry'

class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at)
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
      redirect_to @question, info: "Question created"
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
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    Question.destroy(params[:id])
    redirect_to :action => "index"
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end


end
