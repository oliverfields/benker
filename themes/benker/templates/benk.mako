<%! import urllib.parse %>
<%inherit file="base.mako"/>

<%block name="content">
  <article>
  <h1>${page.title}</h1>
  ${page.html}
  Lat ${page.custom_headers['latitude']}
  Lon ${page.custom_headers['longitude']}

  <%
    url_encoded_title = urllib.parse.quote(page.title, safe='')
    url_encoded_url = urllib.parse.quote(page.absolute_url, safe='')
  %>

  <div class="sharing">

    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/nb_NO/sdk.js#xfbml=1&version=v19.0&appId=189030531161063" nonce="0qFDXtAd"></script>

    <div class="fb-like" data-href="${url_encoded_url}" data-width="300" data-layout="" data-action="" data-size="" data-share="false"></div>

    <p>Del gjerne på sosialemedier:</p>

    <a class="share-button" href="https://www.facebook.com/sharer/sharer.php?u=${url_encoded_url}" target="_blank"><img src="/assets/theme/facebook-logo.svg" alt="Facebook" title="Facebook" /></a>

    <a class="share-button" href="https://twitter.com/share?text=${url_encoded_title}&url=${url_encoded_url}" target="_blank"><img src="/assets/theme/x-twitter-logo.svg" alt="X (Twitter)" title="X (Twitter)" /></a>

    <a class="share-button" href="http://pinterest.com/pin/create/button/?url=${url_encoded_url}" target="_blank"><img src="/assets/theme/pinterest-logo.svg" alt="Pinterest" title="Pinterest" /></a>

    <a class="share-button" href="https://www.linkedin.com/sharing/share-offsite/?url=${url_encoded_url}" target="_blank"><img src="/assets/theme/linkedin-logo.svg" alt="LinkedIn" title="LinkedIn" /></a>

    <a class="share-button" href="https://www.reddit.com/submit?url=${url_encoded_url}&title=${url_encoded_title}" target="_blank"><img src="/assets/theme/reddit-logo.svg" alt="Reddit" title="Reddit" /></a>

  </div><!-- sharing -->

  % if site.environment == 'prod':
  <div class="fb-comments" data-href="${page.absolute_url}" data-width="" data-numposts="5"></div>
  % else:
  <div style="font-weight: bold; color: red">Comments disabled in test environment</div>
  % endif


  </article>
</%block>
