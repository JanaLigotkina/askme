class QuestionsController < ApplicationController	
	before_action :ensure_current_user, only: %i[update destroy edit hide]
	before_action :set_question_for_current_user, only: %i[update destroy edit hide]

	def create
		question_params = params.require(:question).permit(:body, :user_id)
		@question = Question.new(question_params)
		@question.author = current_user

	    if @question.save
				redirect_to user_path(@question.user), notice: 'New question has been created!'
	    else 
	      flash.now[:alert] = 'Question length must be less than 280 characters'

	      render :new
	    end   
	end 

	def update
		question_params = params.require(:question).permit(:body, :answer)
		@question = Question.find(params[:id]) 

		if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'The question has been changed!'
    else
      flash.now[:alert] = 'Invalid question field'

      render :edit 
    end 
  end

	def destroy
		@user = @question.user
		@question.destroy

		redirect_to user_path(@user), notice: 'Question has been removed!'
	end 	

	def show 
		@question = Question.find(params[:id])
	end

	def index
		@questions = Question.order(created_at: :desc).last(10)
		@users = User.order(created_at: :desc).last(10)
	end

	def new
		@user = User.find(params[:user_id])
		@question = Question.new(user: @user)
	end 	

	def edit
	end 

	def hide
		@question.update(hidden: true)
		redirect_to questions_path
	end 	

	private

	def ensure_current_user
		redirect_with_alert unless current_user.present?
	end 	

	def set_question_for_current_user
		@question = current_user.questions.find(params[:id])
	end 	
end
