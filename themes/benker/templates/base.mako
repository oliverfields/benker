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
    %if page.url_path.startswith('/benker/'):
<%
    benk_title_postfix = site.shortcodes['get_setting'](site, page, 'benk_title_postfix')
    benk_desc_postfix = site.shortcodes['get_setting'](site, page, 'benk_desc_postfix')
%>
      <title>${page.title}${benk_title_postfix}</title>
      <meta name="description" content="${page.title}${benk_desc_postfix}"/>
    %else:
      <title>${page.title}</title>
      <meta name="description" content="${page.headers['description']}"/>
    %endif
    <base href="${site.base_url}" />
    <meta name="Generator" content="pagegen.phnd.net" />
    <link rel="stylesheet" href="${site.base_url}/assets/theme/site.css" type="text/css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    % if page.headers['template'] == 'benk.mako':
      <meta property="fb:admins" content="oliverjfields"/>
      <% og = site.shortcodes['opengraph'](site, page, benk_title_postfix=benk_title_postfix, benk_desc_postfix=benk_desc_postfix) %>
      ${og}
    % elif page.headers['template'] == 'homepage.mako':
      <% og = site.shortcodes['opengraph'](site, page) %>
      ${og}
    % endif
  </head>
  <body>
    <script type="text/javascript">
(function(window, document, dataLayerName, id) {
window[dataLayerName]=window[dataLayerName]||[],window[dataLayerName].push({start:(new Date).getTime(),event:"stg.start"});var scripts=document.getElementsByTagName('script')[0],tags=document.createElement('script');
function stgCreateCookie(a,b,c){var d="";if(c){var e=new Date;e.setTime(e.getTime()+24*c*60*60*1e3),d="; expires="+e.toUTCString();f="; SameSite=Strict"}document.cookie=a+"="+b+d+f+"; path=/"}
var isStgDebug=(window.location.href.match("stg_debug")||document.cookie.match("stg_debug"))&&!window.location.href.match("stg_disable_debug");stgCreateCookie("stg_debug",isStgDebug?1:"",isStgDebug?14:-1);
var qP=[];dataLayerName!=="dataLayer"&&qP.push("data_layer_name="+dataLayerName),isStgDebug&&qP.push("stg_debug");var qPString=qP.length>0?("?"+qP.join("&")):"";
tags.async=!0,tags.src="https://krakeroylions.containers.piwik.pro/"+id+".js"+qPString,scripts.parentNode.insertBefore(tags,scripts);
!function(a,n,i){a[n]=a[n]||{};for(var c=0;c<i.length;c++)!function(i){a[n][i]=a[n][i]||{},a[n][i].api=a[n][i].api||function(){var a=[].slice.call(arguments,0);"string"==typeof a[0]&&window[dataLayerName].push({event:n+"."+i+":"+a[0],parameters:[].slice.call(arguments,1)})}}(i[c])}(window,"ppms",["tm","cm"]);
})(window, document, 'dataLayer', 'ba53ab4b-44f4-4aac-8837-e72d2cbb83d9');
    </script>
    <nav>
      <a href="/"><img width="41" height="40" src="/assets/theme/lions-logo.png" id="header-logo" /></a>
      <a href="/">Benkene</a>
      <a href="/om-lions.html">Om Lions</a>
    </nav>
    <%block name="content" />
    <footer>
      <p>Lions Club Kråkerøy &copy; ${year} | Generert av <a href="https://pagegen.phnd.net"><img src="/assets/theme/pagegen_54x10.png" /></a>
    </footer>
  </body>
</html>

