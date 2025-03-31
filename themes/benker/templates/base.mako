<!DOCTYPE html>
<html lang="no">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="apple-touch-icon" sizes="180x180" href="/theme/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/theme/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/theme/favicon-16x16.png">
    <link rel="manifest" href="/theme/site.webmanifest">
    <link rel="mask-icon" href="/theme/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="/theme/favicon.ico">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-config" content="/theme/browserconfig.xml">
    <meta name="theme-color" content="#ffffff">
    <link rel="canonical" href="${page.absolute_url}" />
    %if page.relative_url.startswith('/benker/'):
<%
    benk_title_postfix = site.plugins['shortcodes']['get_setting'](site, page, 'benk_title_postfix')
    benk_desc_postfix = site.plugins['shortcodes']['get_setting'](site, page, 'benk_desc_postfix')
%>
      <title>${page.headers['title']}${benk_title_postfix}</title>
      <meta name="description" content="${page.headers['title']}${benk_desc_postfix}"/>
    %else:
      <title>${page.headers['title']}</title>
      % if 'description' in page.headers.keys():
        <meta name="description" content="${page.headers['description']}"/>
      % endif
    %endif
    <base href="${site.base_url}" />
    <meta name="Generator" content="pagegen.phnd.net" />
    <link rel="stylesheet" href="${site.base_url}/theme/site.css" type="text/css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    % if 'template' in page.headers.keys() and page.headers['template'] == 'benk.mako':
      <meta property="fb:admins" content="oliverjfields"/>
      <% og = site.plugins['shortcodes']['opengraph'](site, page, benk_title_postfix=benk_title_postfix, benk_desc_postfix=benk_desc_postfix) %>
      ${og}
    % elif 'template' in page.headers.keys() and page.headers['template'] == 'homepage.mako':
      <% og = site.plugins['shortcodes']['opengraph'](site, page) %>
      ${og}
    % endif
  </head>
  <body>
<% tracking = site.plugins['shortcodes']['tracking'](site, page) %>
${tracking}
    <nav>
      <a href="/"><img width="41" height="40" src="/theme/lions-logo.png" id="header-logo" /></a>
      <a href="/">Benkene</a>
      <a href="/krakeroy-guiden.html">Kråkerøy guiden</a>
      <a href="/dikt.html">Dikt</a>
      <a href="/om-lions.html">Om Lions</a>
    </nav>
    <%block name="content" />
    <footer>
      <p>Lions Club Kråkerøy &copy; ${year} | Generert av <a href="https://pagegen.phnd.net"><img src="/theme/pagegen_54x10.png" /></a>
    </footer>
  </body>
</html>

