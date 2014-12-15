class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_path(@question)
    else
      flash[:warning] = @answer.errors.full_messages.join(".  ")
      redirect_to question_path(@question)
    end

  end

  private
  def answer_params
    params.require(:answer).permit(:description)
  end
end
