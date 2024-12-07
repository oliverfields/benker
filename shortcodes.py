from pagegen.utility_no_deps import report_warning, report_error, report_notice
from pathlib import Path
from PIL import Image
from os.path import isfile


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
    src_img_path_full = site.content_dir + '/assets/benk-' + img_name + '.jpg'
    tgt_img_path_full = site.content_dir + '/assets/benk-' + img_name + '-' + image_class + '.jpg'
    resized_img_relative_url_path = '/assets/benk-' + img_name + '-' + image_class + '.jpg'

    # Warn if image seems to small
    img_size_bytes = Path(src_img_path_full).stat().st_size
    if img_size_bytes < 1500000:
        img_size_mb = round(img_size_bytes / (1024*1024), 2)
        report_warning('Probable low resolution: ' + str(img_size_mb) + 'mb ' + src_img_path_full)

    # Skip image processing if already exists
    if isfile(tgt_img_path_full):
        report_notice('Using cached image: ' + tgt_img_path_full)
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
        report_warning('Setting ' + name + ' not found')
        return ''
