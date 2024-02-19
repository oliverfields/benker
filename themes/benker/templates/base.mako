<!DOCTYPE html>
<html lang="no">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="apple-touch-icon" sizes="180x180" href="/assets/theme/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/theme/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/theme/favicon-16x16.png">
    <link rel="manifest" href="/assets/theme/site.webmanifest">
    <link rel="mask-icon" href="/assets/theme/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="/assets/theme/favicon.ico">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-config" content="/assets/theme/browserconfig.xml">
    <meta name="theme-color" content="#ffffff">
    <link rel="canonical" href="${page.absolute_url}" />
    <title>${page.title}</title>
    <meta name="description" content="${page.headers['description']}"/>
    <base href="${site.base_url}" />
    <meta name="Generator" content="pagegen.phnd.net" />
    <link rel="stylesheet" href="${site.base_url}/assets/theme/site.css" type="text/css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    % if page.headers['template'] == 'benk.mako':
      <meta property="fb:admins" content="oliverjfields"/>
      <% og = site.shortcodes['opengraph'](site, page) %>
      ${og}
    % elif page.headers['template'] == 'homepage.mako':
      <% og = site.shortcodes['opengraph'](site, page) %>
      ${og}
    % endif
  </head>
  <body>
    <nav>
      <a href="https://krakeroy.lions.no"><img width="41" height="40" src="/assets/theme/lions-logo.png" id="header-logo" /></a>
      <a href="/">Benkene</a>
      <a href="/prosjektet.html">Prosjektet</a>
    </nav>
    <%block name="content" />
    <footer>
      <p>Lions Club Kråkerøy &copy; ${year} | Generert av <a href="https://pagegen.phnd.net"><img src="/assets/theme/pagegen_54x10.png" /></a>
    </footer>
  </body>
</html>
