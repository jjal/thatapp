class QuestionsController < ApplicationController
  
	def index
		@questions = Question.paginate(page: params[:page])
    render 'index'
	end
	
	def show
		@question = Question.find(params[:id])
    render 'show'
	end
	
	def edit
		#defined in correct_question
    
  end
	
	def new
		@question = Question.new
  end
	
	def create
    @question = Question.new(params[:question])
    if @question.save
			sign_in @question
      flash[:success] = "Question created"
      redirect_to @question
    else
      render 'new'
    end
  end
	
	def update
    #defined in correct question
		#@question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
			flash[:success] = "Question updated"
			sign_in @question
      redirect_to @question
    else
      render 'edit'
    end
  end
	 
	def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "Question destroyed."
    redirect_to questions_url
  end
	
		
end
