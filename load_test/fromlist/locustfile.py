
from locust import HttpUser, task, events

locations = {
    'ptiff-lossy': {
        'loc': 'ptiff/lossy',
        'ext': 'tif'
    },
    'ptiff-lossless': {
        'loc': 'ptiff/lossless',
        'ext': 'tif'
    },
    'jp2-lossy': {
        'loc': 'jp2/lossy',
        'ext': 'jp2'
    },
    'jp2-lossless': {
        'loc': 'jp2/lossless',
        'ext': 'jp2'
    },
    'htj2k-lossy': {
        'loc': 'htj2k/lossy',
        'ext': 'htj2k.jp2'
    },
    'htj2k-lossless': {
        'loc': 'htj2k/lossless',
        'ext': 'htj2k.jp2'
    }
}

urls = []

@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--url-list", type=str, env_var="URL_LIST", default="", help="File of IIIF URLs")
   
@events.test_start.add_listener
def on_test_start(environment, **kwargs):
    with open(environment.parsed_options.url_list, 'r') as fh:
        # example line: gm_00002701.tif/10240,8192,588,34/!73,4/0/default.jpg
        for line in fh:
            url = line.replace('\n', '')
            urls.append({
                'id': url.split('/')[0].split(".")[0],
                'params': "/".join(url.split('/')[1:])
            })


class IIIFURLTester(HttpUser):

    @task
    def getURLs(self):
        for urlInfo in urls:
            for imgType, details in locations.items():
                url = "/iiif/{}/{}.{}/{}".format(details['loc'], urlInfo['id'], details['ext'], urlInfo['params'])
                print ('URL: ' + url)
                self.client.get(url, name=imgType)

