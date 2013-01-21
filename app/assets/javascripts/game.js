var currentWindow;
var currentQuestionId = 0;
function Game(gameId, userId) {

  this.id = gameId;
  this.currentUserId = userId;
  
  this.tick = function()
  {
    $.getJSON( "/games/"+this.getGameId()+".json", function(data) {
      game.update(data);
    });
  }
  
  this.update = function(gameData)
  { 
    this.showCurrentQuestion(gameData.current_question_id);
    switch(gameData.state)
    {
      case 0: //open
        // i'm the questionner and it's open so show the questions
        if(gameData.current_user_id == this.getCurrentUserId())
        {
          this.showQuestions();
        } else {
          this.showWaitForQuestionMessage();
        }
      break;
      case 1: //question given - show wait and answers
        // i'm the questionner and it's closed so show the wait for answer message
        if(gameData.current_user_id == this.getCurrentUserId())
        {
          this.showWaitForAnswerMessage();
        } else {
          this.showAnswers();
        }
      break;
      case 3: //correct answer
        this.currentAnswerId = gameData.answer_id;
        this.showSuccess();
        this.showNextButton(gameData.current_user_id);
      break;
      case 4: //incorrect answer
        this.currentAnswerId = gameData.answer_id;
        this.showFail(game.answer_id);
        this.showNextButton(gameData.current_user_id);
      break;
      default:
      break;
    }
  }

  this.getGameId = function()
  {
    return this.id;
  }

  this.getCurrentUserId = function()
  {
    return this.currentUserId;
  }

  this.showNextButton = function(current_user)
  {
    if(current_user == this.getCurrentUserId())
      $("#next_question").show();
    else
      $("#next_question").hide();
  }

  this.showCurrentQuestion = function(id)
  {
    if(!id)
      return;
    if(id != this.currentQuestionId)
      $.get("/game_questions/"+id, function(html) {
        $("#question_space").html(html);
      });
    this.currentQuestionId = id;
  }

  this.showQuestions = function()
  {
    $("#next_question").hide();
    if(this.currentWindow == "questions")
      return;
    $("#question_space").html("");
    $.get("/game_questions?game_id="+this.getGameId(), function (html) {
      $("#action_space").html(html);
    });
    $("#status_space").html("Choose a question!");
    this.currentWindow = "questions";
  }

  this.showAnswers = function()
  {
    if(this.currentWindow == "answers")
      return;
    $.get("/game_questions/"+this.currentQuestionId+"/answers?game_id="+this.getGameId(), function (html) {
      $("#action_space").html(html);
    });
    $("#status_space").html("Choose an answer!");
    this.currentWindow = "answers";
  }

  this.showWaitForQuestionMessage = function()
  {
    if(currentWindow == "waitQuestion")
      return;
    $("#status_space").html("Wait for a question from the other player...");
    currentWindow = "waitQuestion";
    $("#action_space").html("");
  }

  this.showWaitForAnswerMessage = function()
  {
    if(currentWindow == "waitAnswer")
      return;
    $("#status_space").html("Ok wait for an answer");
    currentWindow = "waitAnswer";
    $("#action_space").html("");
  }

  this.showSuccess = function()
  {
    if(this.currentWindow != "Success")
    {
      this.currentWindow = "Success";
       $.get("/game_questions/"+this.currentQuestionId+"/answers/"+this.currentAnswerId+"/success?game_id="+this.getGameId(), function (html) {
        $("#status_space").html(html);
      });
      
      $("#action_space").html("");
      
    }
  }
  this.showFail = function(id)
  {
    if(this.currentWindow != "Fail")
    {
      this.currentWindow = "Fail";
      $.get("/game_questions/"+this.currentQuestionId+"/answers/"+this.currentAnswerId+"/fail?game_id="+this.getGameId(), function (html) {
        $("#status_space").html(html);
      });
     
      //$.get("/questions/"+currentQuestionId+"/answers/"+id+"?game_id="+getGameId(), function(html)
      //{  
        $("#action_space").html("");
      //});
    }
  }
}
