document.addEventListener("DOMContentLoaded", function(event) {

  alert("hi cupho!!! YOU GOT THIS!!!");
  document.getElementById("click").onclick = function() {clickFunction()};
  function clickFunction() {
    document.getElementById("show-text").innerHTML = "RENDER TEXT HERE";
  };
//
// var url =  "https://data.ontario.ca/dataset/confirmed-positive-cases-of-covid-19-in-ontario";
// window.location.href = url
// var click = window.document.getElementsByClassName("resource-url-analytics btn btn-primary dataset-download-link")[1].href

// go to the ontario covid page and
// bring back the inner html of the set_header
// and display it when page loads

});
