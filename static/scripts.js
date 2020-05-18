alert("be present");

// *** google heat map ***

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

// *** amCharts pie chart ***


// });
