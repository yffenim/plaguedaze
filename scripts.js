document.addEventListener("DOMContentLoaded", function(event) {
  alert("hi!");
  document.getElementById("demo").onclick = function() {myFunction()};
  function myFunction() {
    document.getElementById("demo").innerHTML = "YOU CLICKED ME!";
  }
});
