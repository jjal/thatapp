class QuestionsController < ApplicationController
  autocomplete nil, :content
  before_filter :load_questions, only: [:show, :new, :index]
  
	def index
    @most_popular = Question.most_popular
    respond_to do |format|
      format.html 
      format.json  { render json: @questions.map {|q| {:label => q.content, :value => q.id}}}
    end
	end
	
	def show
		@question = Question.find(params[:id])
    respond_to do |format|
      format.html 
      format.json  { render json: @questions.map {|q| {:label => q.content, :value => q.id}}}
    end
	end
	
	def edit
		#defined in correct_question
    
  end
	
	def new
    respond_to do |format|
      format.html 
      format.json  { render json: @questions.map {|q| {:label => q.content, :value => q.id}}}
    end
  end
	
	def create
    @question = Question.new(params[:question])
    if @question.save
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
	
  private 
    def load_questions
      @new_question = Question.new
      if(!params[:term].nil?)
        @questions = Question.find(:all, conditions: ["content LIKE ?", "%#{params[:term]}%"])
      else
        @questions = Question.all
      end
		end
end
