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
var map = L.map('map').setView([59.16801093952555, 10.924186706542969], 12);
L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
}).addTo(map);

map.zoomControl.setPosition('topright');

var benchIcon = L.icon({
  iconUrl: '/theme/bench.svg',
  shadowUrl: '/theme/bench-shadow.svg',

  //iconSize:     [61, 43], // size of the icon
  //shadowSize:   [57, 30], // size of the shadow
  iconSize:     [49, 34], // size of the icon
  shadowSize:   [46, 24], // size of the shadow
  iconAnchor:   [12, 34], // point of the icon which will correspond to marker's location
  shadowAnchor: [8, 23],  // the same for the shadow
  popupAnchor:  [-10, -10] // point from which the popup should open relative to the iconAnchor
});


const markers = []

% for p in site.index.values():
   % if 'template' in p.headers.keys() and p.headers['template'] == 'benk':
markers.push(L.marker([${p.headers['latitude']}, ${p.headers['longitude']}],{title:"${p.headers['title']} benken"}).addTo(map).on('click', function(evt) {
  window.open('${p.relative_url}', '_self');
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
