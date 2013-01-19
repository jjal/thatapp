$(document).ready(function () {
  $("select.question").change(function() {
    window.location = "/questions/"+$(this).val();
  });
});