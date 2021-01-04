class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update]

  def index
    @questions = Question.includes(:user)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
     if @question.save
       redirect_to questions_path
     else
       render :new
     end
  end

  def show 
  end

  def edit
    unless @question.user_id == current_user.id
      redirect_to question_path
    end
  end

  def update
     if @question.update(question_params)
      redirect_to question_path
     else
      render :edit
     end
  end

  private
  
  def question_params
    params.require(:question).permit(:subject, :title, :text).merge(user_id: current_user.id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
