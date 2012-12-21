var currentWindow;
var currentQuestionId = 0;

function loop()
{
  $.getJSON( "/games/"+getGameId()+".json", function(data) {
    update(data);
  });
  setTimeout(loop, 2000);
}

function update(game)
{
  showCurrentQuestion(game.current_question_id);
  switch(game.state)
  {
    case 0: //open
      // i'm the questionner and it's open so show the questions
      if(game.current_user_id == getCurrentUserId())
      {
        showQuestions();
      } else {
        showWaitForQuestionMessage();
      }
    break;
    case 1:
      // i'm the questionner and it's closed so show the wait for answer message
      if(game.current_user_id == getCurrentUserId())
      {
        showWaitForAnswerMessage();
      } else {
        showAnswers();
      }
    break;
    case 3:
      showSuccess();
      showNextButton(game.current_user_id);
    break;
    case 4:
      showFail(game.answer_id);
      showNextButton(game.current_user_id);
    break;
    default:
    break;
  }
}

function getGameId()
{
  return <%= @game.id %>
}

function getCurrentUserId()
{
  return <%= current_user.id %>
}

function showNextButton(current_user)
{
  if(current_user == getCurrentUserId())
    $("#next_question").show();
  else
    $("#next_question").hide();
}

function showCurrentQuestion(id)
{

  if(!id)
    return;
  if(id != currentQuestionId)
    $.get("/questions/"+id, function(html) {
      $("#question_space").html(html);
    });
  currentQuestionId = id;
}

function showQuestions()
{
  $("#next_question").hide();
  if(currentWindow == "questions")
    return;
  
  $.get("/questions?game_id="+getGameId(), function (html) {
    $("#action_space").html(html);
  });
  $("#status_space").html("Choose a question!");
  currentWindow = "questions";
}

function showAnswers()
{
  if(currentWindow == "answers")
    return;
  $.get("/questions/"+currentQuestionId+"/answers?game_id="+getGameId(), function (html) {
    $("#action_space").html(html);
  });
  $("#status_space").html("Choose an answer!");
  currentWindow = "answers";
}

function showWaitForQuestionMessage()
{
  if(currentWindow == "waitQuestion")
    return;
  $("#status_space").html("Wait for a question from the other player...");
  currentWindow = "waitQuestion";
  $("#action_space").html("");
}

function showWaitForAnswerMessage()
{
  if(currentWindow == "waitAnswer")
    return;
  $("#status_space").html("Ok wait for an answer");
  currentWindow = "waitAnswer";
  $("#action_space").html("");
}

function showSuccess()
{
  $("#status_space").html("<div class='alert alert-success'>WINNER</div>");
  $("#action_space").html("");
}
function showFail(id)
{
  $("#status_space").html("<div class='alert alert-error'>FAIL</div>");
  //$.get("/questions/"+currentQuestionId+"/answers/"+id+"?game_id="+getGameId(), function(html)
  //{  
    $("#action_space").html("");
  //});
}