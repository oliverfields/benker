<%!
import urllib.parse
import pagegen.logger_setup
import logging

logger = logging.getLogger('pagegen.' + __name__)

%>
<%inherit file="base.mako"/>

<%block name="content">

<%
    sum_benker = -1
    for p in site.index.values():
        if p.relative_url.startswith('/benker/'):
            sum_benker += 1
%>

  <article>

  ##<a href="http://www.openstreetmap.org/?mlat=${page.headers['latitude']}&mlon=${page.headers['longitude']}&zoom=12">map</a>

  <h1>${page.headers['title']}</h1>

  <p>Denne benken, og <a href="/">${sum_benker} andre benker</a> i nærområdet, er satt opp av Lions Club Kråkerøy.</p>

  <%
    img_desktop = site.plugins['shortcodes']['benk_image_path'](site, page, image_class='desktop')
    img_mobile = site.plugins['shortcodes']['benk_image_path'](site, page, image_class='mobile')
  %>

  <figure class="hero-image">
    <picture>
      <source media="(min-width: 600px)" srcset="${img_desktop}" />
      <img src="${img_mobile}" />
    </picture>
  % if 'hero caption' in page.headers.keys():
    <figcaption>${page.headers['hero caption']}</figcaption>
  % else:
    <% logger.warning(page.source_path.lstrip(site.site_dir) + ' is missing hero caption header') %>
  % endif
  </figure>
  <%
    url_encoded_title = urllib.parse.quote(page.headers['title'], safe='')
    url_encoded_url = urllib.parse.quote(page.absolute_url, safe='')
    share_prefix = urllib.parse.quote('Kråkerøy Lions benken', safe='')
  %>

  ${page.out}

  <div class="sharing">

    <a class="share-button" href="https://www.facebook.com/sharer/sharer.php?u=${url_encoded_url}" target="_blank"><img src="/theme/facebook-logo.svg" alt="Facebook" title="Facebook" /></a>

    <a class="share-button" href="https://bsky.app/intent/compose?text=${share_prefix} ${url_encoded_title} ${url_encoded_url}" target="_blank"><img src="/theme/bluesky-logo.svg" alt="Bluesky" title="Bluesky" /></a>

    <a class="share-button" href="http://pinterest.com/pin/create/button/?url=${url_encoded_url}" target="_blank"><img src="/theme/pinterest-logo.svg" alt="Pinterest" title="Pinterest" /></a>

    <a class="share-button" href="https://www.linkedin.com/sharing/share-offsite/?url=${url_encoded_url}" target="_blank"><img src="/theme/linkedin-logo.svg" alt="LinkedIn" title="LinkedIn" /></a>

    <a class="share-button" href="https://www.reddit.com/submit?url=${url_encoded_url}&title=${url_encoded_title}" target="_blank"><img src="/theme/reddit-logo.svg" alt="Reddit" title="Reddit" /></a>

  </div><!-- sharing -->

  </article>
</%block>
