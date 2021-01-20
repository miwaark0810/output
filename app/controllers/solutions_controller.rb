class SolutionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @solution = current_user.solutions.create(question_id: params[:question_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @question = Question.find(params[:question_id])
    @solution = current_user.solutions.find_by(question_id: @question.id)
    @solution.destroy
    redirect_back(fallback_location: root_path)
  end
end
