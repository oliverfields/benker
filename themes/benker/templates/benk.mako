<%! import urllib.parse %>
<%inherit file="base.mako"/>

<%block name="content">

<%
    sum_benker = 0
    for p in site.page_list:
        if p.url_path.startswith('/benker/'):
            sum_benker += 1
%>



  <article>
  <h1>${page.title}</h1>

  <p>Benken du hviler deg på nå er satt opp av Lions Club Kråkerøy, det finnes <a href="/">${sum_benker} andre Lions benker</a> i området.</p>

  ${page.html}

  <%
    img_desktop = site.shortcodes['benk_image_path'](site, page, 'desktop')
    img_mobile = site.shortcodes['benk_image_path'](site, page, 'mobile')
  %>
  <div class="hero-image">
    <picture class="article-picture">
      <source media="(min-width: 600px)" srcset="${img_desktop}" />
      <img src="${img_mobile}" alt="${page.custom_headers['hero img alt text']}" />
    </picture>
  % if 'hero caption' in page.custom_headers.keys():
    <p>${page.custom_headers['hero caption']}</p>
  % else:
    <% print('Warning: ' + page.source_path + ' is missing hero caption header') %>
  % endif
  </div>
  <%
    url_encoded_title = urllib.parse.quote(page.title, safe='')
    url_encoded_url = urllib.parse.quote(page.absolute_url, safe='')
  %>

  <pre class="dikt">
Ein benk dukkar opp
langs vegen eg går på,
står der inviterande,
meir som ein gamal ven,
og nærast nøyer ein
vandrande skrott
å setja seg nedpå,
rart korleis tankane
smyg lettare rundt i hausen
når ein sit,
sitjande på ein benk
langs vegen
kan ein få
det for seg at
altor mange strenar i veg
utan å ta seg tid
til setja seg på
benker langs vegen,
som om tankar på ein benk
langs vegen
skulle vera fårlege.
  </pre>

  <div class="sharing">

    <a class="share-button" href="https://www.facebook.com/sharer/sharer.php?u=${url_encoded_url}" target="_blank"><img src="/assets/theme/facebook-logo.svg" alt="Facebook" title="Facebook" /></a>

    <a class="share-button" href="https://twitter.com/share?text=${url_encoded_title}&url=${url_encoded_url}" target="_blank"><img src="/assets/theme/x-twitter-logo.svg" alt="X (Twitter)" title="X (Twitter)" /></a>

    <a class="share-button" href="http://pinterest.com/pin/create/button/?url=${url_encoded_url}" target="_blank"><img src="/assets/theme/pinterest-logo.svg" alt="Pinterest" title="Pinterest" /></a>

    <a class="share-button" href="https://www.linkedin.com/sharing/share-offsite/?url=${url_encoded_url}" target="_blank"><img src="/assets/theme/linkedin-logo.svg" alt="LinkedIn" title="LinkedIn" /></a>

    <a class="share-button" href="https://www.reddit.com/submit?url=${url_encoded_url}&title=${url_encoded_title}" target="_blank"><img src="/assets/theme/reddit-logo.svg" alt="Reddit" title="Reddit" /></a>

  </div><!-- sharing -->

  </article>
</%block>
