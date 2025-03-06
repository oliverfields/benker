<%inherit file="base.mako"/>

<%block name="content">
  <article>
  <h1>${page.headers['title']}</h1>
  ${page.out}
  </article>
</%block>
