<%inherit file="base.mako"/>

<%block name="content">
<article>
  <h1>${page.title}</h1>
  ${page.html}
  <ol class="bench-list">
  % for c in page.children:
    <li><a href="${c.url_path}">${c.title}</a></li>
  % endfor
  </ol>
</article>
</%block>

