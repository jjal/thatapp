class GameQuestionsController < ApplicationController
  
	def index
		@questions = GameQuestion.paginate(page: params[:page])
    @game = Game.find(params[:game_id])
    render 'index', layout: false
	end
	
	def show
		@question = GameQuestion.find(params[:id])
    render 'show', layout: false
	end
	
	def edit
		#defined in correct_question
    #@question = GameQuestion.find(params[:id])
  end
	
	def new
		@question = GameQuestion.new
  end
	
	def create
    @question = GameQuestion.new(params[:question])
    if @question.save
			sign_in @question
      flash[:success] = "GameQuestion created"
      redirect_to @question
    else
      render 'new'
    end
  end
	
	def update
    #defined in correct question
		#@question = GameQuestion.find(params[:id])
    if @question.update_attributes(params[:question])
			flash[:success] = "GameQuestion updated"
			sign_in @question
      redirect_to @question
    else
      render 'edit'
    end
  end
	 
	def destroy
    GameQuestion.find(params[:id]).destroy
    flash[:success] = "GameQuestion destroyed."
    redirect_to questions_url
  end
	
		
end
