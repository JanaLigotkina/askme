class QuestionsController < ApplicationController	

	before_action :set_question, only: %i[update show destroy edit hide]

	def create
		@question = Question.new(question_params)

	    if @question.save
				redirect_to question_path(@question), notice: 'New question has been created!'
	    else 
	      flash.now[:alert] = 'Question length must be less than 280 characters'

	      render :new
	    end   
	end 

	def update
		#   @question.update(question_params)

		#   redirect_to question_path(@question), notice: 'The question has been changed!'
		# end 
		@question = Question.find(params[:id]) 

		if @question.update(question_params)
      redirect_to question_path(@question), notice: 'The question has been changed!'
    else
      flash.now[:alert] = 'Invalid question field'

      render :edit 
    end 
  end

	def destroy
		@question.destroy

		redirect_to questions_path, notice: 'Question has been removed!'
	end 	

	def show 
	end

	def index
		@question = Question.new
		@questions = Question.all
	end

	def new
		@question = Question.new
	end 	

	def edit
	end 

	def hide
		@question.update(hidden: true)
		redirect_to questions_path
	end 	

	private

	def question_params
		params.require(:question).permit(:body, :user_id)
	end

	def set_question
		@question = Question.find(params[:id])
	end 	
end
