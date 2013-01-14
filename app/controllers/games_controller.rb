class GamesController < ApplicationController
  include UsersHelper
	before_filter :signed_in_user, only: [:create, :destroy, :show, :index]
  before_filter :correct_user,   only: [:destroy, :show]
	
  #0 = open
  #1 = question
  #2 = answer
  #3 = correct
  #4 = incorrect
  
  # GET /Games
  # GET /Games.json
  def index
    @games = Game.find(:all, conditions: ["user_a_id = ? OR user_b_id = ?", current_user.id, current_user.id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /Games/1
  # GET /Games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /Games/new
  # GET /Games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /Games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /Games
  # POST /Games.json
  def create
    @game = current_user.games_created.build(params[:game])
    @game.user_b_id = params[:user_b_id].nil? ? current_user.random_other_user.id : params[:user_b_id]
    @game.state = 0
    @game.current_user_id = current_user.id
    if @game.save!
      flash[:success] = "Game created!"
      redirect_to @game
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # PUT /Games/1
  # PUT /Games/1.json
  def update
    @game = Game.find(params[:id])
    game_state = params[:state].to_i
    q_id = params[:current_question_id].to_i
    if(game_state == 2)
      answer = Answer.find(params[:answer_id])
      q_id = answer.question_id
      #if the answer is wrong, game state 4 - otherwise 3
      game_state = answer.score == 0 ? 4 : 3
      #if game state 2 and correct answer, switch the current user
      #debugger
      if(answer.score != 0)
        @game.current_user_id = (@game.current_user_id == @game.user_a_id) ? @game.user_b_id : @game.user_a_id
      end
    end
    
    respond_to do |format|
      if @game.update_attributes(
          current_question_id: q_id, 
          state: game_state, 
          answer_id: params[:answer_id]
        )
        #debugger
        format.html { render text: "ok" }
        format.json { head :no_content }
      else
        format.html { render text: "ok" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Games/1
  # DELETE /Games/1.json
  def destroy
     @game.destroy
    redirect_to root_url
  end
	
	private

    def correct_user
      redirect_to root_url if current_user.nil?
    end
end
