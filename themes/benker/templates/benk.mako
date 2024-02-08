<%inherit file="base.mako"/>

<%block name="content">
  Lat ${page.custom_headers['latitude']}
  Lon ${page.custom_headers['longitude']}
  ${page.html}
</%block>
