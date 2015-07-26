class QuestionsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
	
  def index
		@questions = Question.all
	end

	def show
    @question = Question.find(params[:id])
  end

	def new
    @question = Question.new
	end

  def edit
    @question = current_user.questions.find(params[:id]) rescue nil
    # @question = Question.find(params[:id])
    if @question == nil
        redirect_to questions_path, notice: "Can not change another User's Question"
    else
      @question = current_user.questions.find(params[:id])
    end
  end

	def create
		@question = current_user.questions.new(question_params) rescue nil
    # @question = Question.new(question_params)
    if @question == nil
        redirect_to questions_path, notice: "Must be signed in"
    else
    	if @question.save
    	  redirect_to @question, notice: "Question created"
      else
        render 'new'
      end
    end
  end

  def update
    @question = current_user.questions.find(params[:id]) 
    # @question = Question.find(params[:id])
    
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = current_user.questions.find params[:id] rescue nil 
    # @question = Question.find(params[:id])
    if @question == nil
        redirect_to questions_path, notice: "Can not delete another User's Question"
    else
      @question.destroy
        redirect_to questions_path
    end
  end

  private
  	def question_params
    	params.require(:question).permit(:title, :text)
  	end

end
