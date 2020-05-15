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

var heatmapData = [
  new google.maps.LatLng(43.6565, -79.3793)
  // new google.maps.LatLng(45.3456, -75.7639),
  // new google.maps.LatLng(44.0480, -79.4802),
  // new google.maps.LatLng(42.9814, -81.2540),
  // new google.maps.LatLng(43.8986, -78.9403)
];

var covidToronto = new google.maps.LatLng(43.6532, -79.3832);

map = new google.maps.Map(document.getElementById('map'), {
  center: covidToronto,
  zoom: 13,
  mapTypeId: 'satellite'
});

var heatmap = new google.maps.visualization.HeatmapLayer({
  data: heatmapData
});
heatmap.setMap(map);





//

// go to the ontario covid page and
// bring back the inner html of the set_header
// and display it when page loads

// });
