class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id]) 
    @answer = current_user.answers.create(answer_params) rescue nil
    # @answer = @question.answers.create(answer_params)
    if @answer == nil
      redirect_to question_path(@question), notice: "Must be signed in"
    else
      @answer.create
        redirect_to question_path(@question)
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.find(params[:id]) rescue nil
    # @answer = @question.answers.find(params[:id])
    if @answer == nil
      redirect_to question_path(@question), notice: "Can not delete another User's Answer"
    else 
      @answer.destroy
        redirect_to question_path(@question)
    end
  end
 
  private
    def answer_params
      params.require(:answer).permit(:response)
    end
end
