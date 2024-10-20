from pagegen.utility_no_deps import report_warning, report_error, report_notice
from pathlib import Path
from PIL import Image


def benk_image_path(site, page, image_class="desktop"):

    # Get page name without path and extension
    img_name = page.source_path.rpartition('/')[2]

    if img_name.startswith('index'):
        return ''

    img_name = img_name.rpartition('.')[0]

    if image_class == 'desktop':
        width=994
    elif image_class == 'mobile':
        width=450

    # Work out paths for url and file paths
    src_img_path_full = site.content_dir + '/assets/benk-' + img_name + '.jpg'

    # Warn if image seems to small
    img_size_bytes = Path(src_img_path_full).stat().st_size
    if img_size_bytes < 1500000:
        img_size_mb = round(img_size_bytes / (1024*1024), 2)
        report_warning('Probable low resolution: ' + str(img_size_mb) + 'mb ' + src_img_path_full)

    # Calculates height so that aspect ratio is maintained
    im = Image.open(src_img_path_full)
    height = round(int(width) * im.size[1]/im.size[0])

    resized_img_relative_url_path = '/assets/benk-' + img_name + '-' + str(width) + 'x' + str(height) + '.jpg'

    img_tag = site.shortcodes['image'](site, page, src_img_path_full, 'Benk', image_size=str(width)+'x'+str(height))

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
        report_warning('Setting ' + name + ' not found')
        return ''
