<%inherit file="base.mako"/>

<%block name="content">
  <style>
body {
height: 100vh;
overflow: hidden;
}

nav {
z-index: 9999;
}

#map {
width: 100%;
height: 100%;
}

.leaflet-top {
top: 60px !important;
}

.leaflet-bottom {
bottom: 40px !important;
}
  </style>
  <div id="map"></div>
  <script>
var map = L.map('map').setView([59.2133614, 10.9361604], 11);
L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
}).addTo(map);

map.zoomControl.setPosition('topright');

var benchIcon = L.icon({
  iconUrl: '/assets/theme/bench.svg',
  shadowUrl: '/assets/theme/bench-shadow.svg',

  //iconSize:     [61, 43], // size of the icon
  //shadowSize:   [57, 30], // size of the shadow
  iconSize:     [49, 34], // size of the icon
  shadowSize:   [46, 24], // size of the shadow
  iconAnchor:   [12, 34], // point of the icon which will correspond to marker's location
  shadowAnchor: [8, 23],  // the same for the shadow
  popupAnchor:  [-10, -10] // point from which the popup should open relative to the iconAnchor
});


const markers = []

% for p in site.page_list:
   % if p.headers['template'] == 'benk.mako':
markers.push(L.marker([${p.custom_headers['latitude']}, ${p.custom_headers['longitude']}]).addTo(map).on('click', function(evt) {
  window.open('${p.url_path}', '_self');
}));
  % endif
% endfor

map.on('click', function(e){
  var coord = e.latlng;
  var lat = coord.lat;
  var lng = coord.lng;
  console.log(lat + ", " + lng);
  });

  </script>
</%block>
