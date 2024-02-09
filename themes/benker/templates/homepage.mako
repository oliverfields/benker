<%inherit file="base.mako"/>

<%block name="content">
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
  window.open('${p.url_path}', '_blank');
}));
  % endif
% endfor
  </script>
</%block>
