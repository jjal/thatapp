class AnswersController < ApplicationController
  
	def index
    @game = Game.find(params[:game_id])
		@answers = @game.current_question.answers.all
    
    render 'index', layout: false
	end
	
	def show
		@answer = Answer.find(params[:id])
    render 'show', layout: false
	end
	
	def edit
		#defined in correct_answer
    #@answer = Answer.find(params[:id])
  end
	
	def new
		@answer = Answer.new
  end
  
  def success
    @game = Game.find(params[:game_id])
    @question = Question.find(params[:game_question_id])
    @answer = Answer.find(params[:answer_id])
    render "success", layout: false
  end
  
  def fail
    @game = Game.find(params[:game_id])
    @question = Question.find(params[:game_question_id])
    @answer = Answer.find(params[:answer_id])
    render "fail", layout: false
  end
	
	def create
    @answer = Answer.new(params[:answer])
    if @answer.save
			sign_in @answer
      flash[:success] = "Answer created"
      redirect_to @answer
    else
      render 'new', layout: false
    end
  end
	
	def update
    #defined in correct answer
		#@answer = Answer.find(params[:id])
    if @answer.update_attributes(params[:answer])
			flash[:success] = "Answer updated"
			sign_in @answer
      redirect_to @answer
    else
      render 'edit'
    end
  end
	 
	def destroy
    Answer.find(params[:id]).destroy
    flash[:success] = "Answer destroyed."
    redirect_to answers_url
  end
	
		
end
