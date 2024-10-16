from pagegen.utility_no_deps import report_warning, report_error


def benk_image_path(site, page, image_class):

    # Get page name without path and extension
    img_name = page.source_path.rpartition('/')[2]
    img_name = img_name.rpartition('.')[0]

    img_cache_name = 'benk-' + img_name + '_' + image_class + '.jpg'

    # Return if we have this cached already
    try:
        return page.cache[img_cache_name]
    except AttributeError:
        page.cache = {}
    except KeyError:
        page.cache[img_cache_name] = False
    except Exception as e:
        report_error(img_cache_name + ': ' + e)

    # Work out paths for url and file paths
    img_path_relative_url = '/assets/benk-' + img_name + '.jpg'
    img_path_relative_url_class = '/assets/' + img_cache_name
    img_path_full = site.content_dir + img_path_relative_url


    # Create image by class
    try:
        img_tag = site.shortcodes['image'](site, page, img_path_full, 'Benk', image_class=image_class)
    except Exception as e:
        img_tag = ''

    # Save to cache
    page.cache[img_cache_name] = img_path_relative_url_class

    return page.cache[img_cache_name]


def opengraph(site, page, benk_title_postfix='', benk_desc_postfix=''):
    img_url = site.base_url + benk_image_path(site, page, 'desktop')
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
