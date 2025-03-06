from pathlib import Path
from PIL import Image
from os.path import isfile
import pagegen.logger_setup
import logging

logger = logging.getLogger('pagegen.' + __name__)


def resize_and_crop(image, config):

    # Resize image to max width, maintaining aspect ratio
    wpercent = (config['width'] / float(image.size[0]))
    ratio_height = int((float(image.size[1]) * float(wpercent)))
    image = image.resize((config['width'], ratio_height))

    # Crop
    image = image.crop((config['crop_left'], config['crop_top'], config['crop_right'], config['crop_bottom']))

    return image


def benk_image_path(site, page, image_class="desktop"):

    # Get page name without path and extension
    img_name = page.source_path.split('/')[-1].rstrip('.html')

    if img_name.startswith('index'):
        return ''

    # Work out paths for url and file paths
    src_img_path_full = site.site_dir + '/assets/benk-' + img_name + '.jpg'
    tgt_img_path_full = site.site_dir + '/assets/benk-' + img_name + '-' + image_class + '.jpg'
    resized_img_relative_url_path = '/assets/benk-' + img_name + '-' + image_class + '.jpg'

    # Warn if image seems to small
    img_size_bytes = Path(src_img_path_full).stat().st_size
    if img_size_bytes < 1500000:
        img_size_mb = round(img_size_bytes / (1024*1024), 2)
        logger.warning('Probable low resolution: ' + str(img_size_mb) + 'mb ' + src_img_path_full)

    # Skip image processing if already exists
    if isfile(tgt_img_path_full):
        logger.debug('Using cached image: ' + tgt_img_path_full)
        return resized_img_relative_url_path

    img_name = img_name.rpartition('.')[0]
    golden_ratio = 1.61803399

    try:
        crop_top_percent = float(page.custom_headers['hero crop top mobile'])
    except Exception as e:
        crop_top_percent = 0

    if image_class == 'desktop':
        width = 994

    elif image_class == 'mobile':
        width = 600

    height = int(width / golden_ratio)
    crop_top = int(height * crop_top_percent)

    conf = {
        'width': width,
        'height': height,
        'crop_left': 0,
        'crop_top': crop_top,
        'crop_right': width,
        'crop_bottom': crop_top + height
    }

    img = Image.open(src_img_path_full)
    img = resize_and_crop(img, conf)
    img.save(tgt_img_path_full, format='JPEG', subsampling=0, quality=95)

    return resized_img_relative_url_path


def opengraph(site, page, benk_title_postfix='', benk_desc_postfix=''):
    img_url = site.base_url + benk_image_path(site, page, image_class='desktop')
    desc = str(page.headers['description'])

    domain = site.base_url.replace('https://', '')
    domain = site.base_url.replace('http://', '')

    # Facebook
    html = '<meta property="og:url" content="' + page.absolute_url + '" />\n'

    ogtitle = page.title
    ogdesc = desc

    if page.url_path.startswith('/benker/'):
        ogtitle = page.title + benk_title_postfix
        ogdesc = page.title + benk_desc_postfix

    html += '<meta property="og:title" content="' + ogtitle + '" />\n'
    html += '<meta property="og:description" content="' + ogdesc + '" />\n'
    html += '<meta property="og:image" content="' + img_url + '" />\n'

    # Twitter
    html += '<meta name="twitter:card" content="summary_large_image" />\n'
    html += '<meta property="twitter:domain" content="' + domain + '" />\n'
    html += '<meta property="twitter:url" content="' + page.absolute_url + '" />\n'
    html += '<meta name="twitter:title" content="' + page.title + '" />\n'
    html += '<meta name="twitter:description" content="' + desc + '" />\n'
    html += '<meta name="twitter:image" content="' + img_url + '" />\n'

    return html


def get_setting(site, page, name):
    settings = {
        'benk_desc_postfix': ' - en av Lions Club Kråkerøy benkene',
        'benk_title_postfix': ' benken'
    }

    try:
        return settings[name]
    except:
        logger.warning('Setting ' + name + ' not found')
        return ''


def tracking(site, page):

    if site.base_url.startswith('http://localhost'):
        return ''
    else:
        return '''
<script>
var queryStrings;
(window.onpopstate = function () {
  var match,
    pl   = /\+/g,  // Regex for replacing addition symbol with a space
    search = /([^&=]+)=?([^&]*)/g,
    decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); },
    query  = window.location.search.substring(1);

  queryStrings = {};
  while (match = search.exec(query))
     queryStrings[decode(match[1])] = decode(match[2]);
})();

if(queryStrings['tracking'] == 'off') {
  if(localStorage.getItem('tracking') != 'off') {
    localStorage.setItem('tracking', 'off');
    alert('Tracking is now turned off for this device🙈');
  }
}

if(queryStrings['tracking'] == 'on') localStorage.removeItem('tracking');


if (localStorage.getItem('tracking') != 'off') {

(function(window, document, dataLayerName, id) {
window[dataLayerName]=window[dataLayerName]||[],window[dataLayerName].push({start:(new Date).getTime(),event:"stg.start"});var scripts=document.getElementsByTagName('script')[0],tags=document.createElement('script');
function stgCreateCookie(a,b,c){var d="";if(c){var e=new Date;e.setTime(e.getTime()+24*c*60*60*1e3),d="; expires="+e.toUTCString();f="; SameSite=Strict"}document.cookie=a+"="+b+d+f+"; path=/"}
var isStgDebug=(window.location.href.match("stg_debug")||document.cookie.match("stg_debug"))&&!window.location.href.match("stg_disable_debug");stgCreateCookie("stg_debug",isStgDebug?1:"",isStgDebug?14:-1);
var qP=[];dataLayerName!=="dataLayer"&&qP.push("data_layer_name="+dataLayerName),isStgDebug&&qP.push("stg_debug");var qPString=qP.length>0?("?"+qP.join("&")):"";
tags.async=!0,tags.src="https://krakeroylions.containers.piwik.pro/"+id+".js"+qPString,scripts.parentNode.insertBefore(tags,scripts);
!function(a,n,i){a[n]=a[n]||{};for(var c=0;c<i.length;c++)!function(i){a[n][i]=a[n][i]||{},a[n][i].api=a[n][i].api||function(){var a=[].slice.call(arguments,0);"string"==typeof a[0]&&window[dataLayerName].push({event:n+"."+i+":"+a[0],parameters:[].slice.call(arguments,1)})}}(i[c])}(window,"ppms",["tm","cm"]);
})(window, document, 'dataLayer', 'ba53ab4b-44f4-4aac-8837-e72d2cbb83d9');
}
else {
  console.log('Tracking is disabled on this device, /?tracking=on to enable');
  let notrack = document.createElement('a');
  notrack.setAttribute('href', '/?tracking=on');
  notrack.setAttribute('title', 'Enable tracking');
  notrack.style.position = 'fixed';
  notrack.style.right = '0';
  notrack.style.top = '0';
  notrack.style.padding = '.5em';
  notrack.style.textDecoration = 'none';
  notrack.style.zIndex = '99999';

  notrack.appendChild(document.createTextNode('🙈'));

  document.body.appendChild(notrack);
}
</script>'''
