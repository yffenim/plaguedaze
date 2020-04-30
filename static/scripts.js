alert("be present");

// document.addEventListener("DOMContentLoaded", function(event) {
//
//   document.getElementById("click").onclick = function() {clickFunction()};
//   function clickFunction() {
//     document.getElementById("show-text").innerHTML = "RENDER TEXT HERE";
//   };

// get data from toronto site (not an api)

// var request = function clickFunction() {
//   var url =  "https://data.ontario.ca/dataset/confirmed-positive-cases-of-covid-19-in-ontario";
//   window.location.href = url
//   var click = window.document.getElementsByClassName("resource-url-analytics btn btn-primary dataset-download-link")[1].href
// }





// google maps api
  function initMap() {
// The location of Uluru
var uluru = {lat: -25.344, lng: 131.036};
// The map, centered at Uluru
var map = new google.maps.Map(
    document.getElementById('map'), {zoom: 4, center: uluru});
// The marker, positioned at Uluru
var marker = new google.maps.Marker({position: uluru, map: map});
}

//

// go to the ontario covid page and
// bring back the inner html of the set_header
// and display it when page loads

// });
