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
    question_params = {title: params[:title], description: params[:description]}

    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      # @question.errors.messages
      render :action => 'new'
    end
  end

end
