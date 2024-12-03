<%!
import urllib.parse
from pagegen.utility_no_deps import report_warning
%>
<%inherit file="base.mako"/>

<%block name="content">

<%
    sum_benker = -2
    for p in site.page_list:
        if p.url_path.startswith('/benker/'):
            sum_benker += 1
%>

  <article>

  ##<a href="http://www.openstreetmap.org/?mlat=${page.custom_headers['latitude']}&mlon=${page.custom_headers['longitude']}&zoom=12">map</a>

  <h1>${page.title}</h1>

  <p>Denne benken, og <a href="/">${sum_benker} andre benker</a> i nærområdet, er satt opp av Lions Club Kråkerøy.</p>

  <%
    img_desktop = site.shortcodes['benk_image_path'](site, page, image_class='desktop')
    img_mobile = site.shortcodes['benk_image_path'](site, page, image_class='mobile')
  %>
  <figure class="hero-image">
    <picture>
      <source media="(min-width: 600px)" srcset="${img_desktop}" />
      <img src="${img_mobile}" />
    </picture>
  % if 'hero caption' in page.custom_headers.keys():
    <figcaption>${page.custom_headers['hero caption']}</figcaption>
  % else:
    <% report_warning(page.source_path.lstrip(site.site_dir) + ' is missing hero caption header') %>
  % endif
  </figure>
  <%
    url_encoded_title = urllib.parse.quote(page.title, safe='')
    url_encoded_url = urllib.parse.quote(page.absolute_url, safe='')
  %>

  ${page.html}

  <div class="sharing">

    <a class="share-button" href="https://www.facebook.com/sharer/sharer.php?u=${url_encoded_url}" target="_blank"><img src="/assets/theme/facebook-logo.svg" alt="Facebook" title="Facebook" /></a>

    <a class="share-button" href="https://bsky.app/intent/compose?text=${url_encoded_url}" target="_blank"><img src="/assets/theme/bluesky-logo.svg" alt="Bluesky" title="Bluesky" /></a>

    <a class="share-button" href="http://pinterest.com/pin/create/button/?url=${url_encoded_url}" target="_blank"><img src="/assets/theme/pinterest-logo.svg" alt="Pinterest" title="Pinterest" /></a>

    <a class="share-button" href="https://www.linkedin.com/sharing/share-offsite/?url=${url_encoded_url}" target="_blank"><img src="/assets/theme/linkedin-logo.svg" alt="LinkedIn" title="LinkedIn" /></a>

    <a class="share-button" href="https://www.reddit.com/submit?url=${url_encoded_url}&title=${url_encoded_title}" target="_blank"><img src="/assets/theme/reddit-logo.svg" alt="Reddit" title="Reddit" /></a>

  </div><!-- sharing -->

  </article>
</%block>
