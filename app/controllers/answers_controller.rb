class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question_id)
    else
      @question = @answer.question
      @answers = @prototype.answers
      render "question/show"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
