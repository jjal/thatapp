$(document).ready(function () {
  $("input#question_content").bind('railsAutocomplete.select', function(event, data) {
    window.location = "/questions/"+data.item.value;
  });
});