
from locust import HttpUser, task, events
import json

locations = {
    'ptiff-lossy-round1': {
        'loc': 'ptiff/lossy',
        'ext': 'tif'
    },
    'ptiff-lossless-round1': {
        'loc': 'ptiff/lossless',
        'ext': 'tif'
    },
    'jp2-lossy-round1': {
        'loc': 'jp2/lossy',
        'ext': 'jp2'
    },
    'jp2-lossless-round1': {
        'loc': 'jp2/lossless',
        'ext': 'jp2'
    },
    'htj2k-lossy-round1': {
        'loc': 'htj2k/lossy',
        'ext': 'htj2k.jp2'
    },
    'htj2k-lossless-round1': {
        'loc': 'htj2k/lossless',
        'ext': 'htj2k.jp2'
    },
    'htj2k-bodelian-lossless': {
        'loc': 'params/htj2k_digital_bodelian_lossless_codeblock_64,64',
        'ext': 'jph'
    },
    'htj2k_bodelian_lossy': {
        'loc': 'params/htj2k_digital_bodelian_lossy_codeblock_64,64',
        'ext': 'jph'
    },
    'htj2k_lossless': {
        'loc': 'params/htj2k_lossless_codeblock_64,64',
        'ext': 'jph'
    },
    'htj2k_lossless_plt': {
        'loc': 'params/htj2k_lossless_plt_codeblock_64,64',
        'ext': 'jph'
    },
    'htj2k_lossy_3bpp_plt': {
        'loc': 'params/htj2k_lossy_3bpp_plt_codeblock_64,64',
        'ext': 'jph'
    },
    'htj2k_lossy_Qfactor_90_plt': {
        'loc': 'params/htj2k_lossy_Qfactor_90_plt_codeblock_64,64',
        'ext': 'jph'
    },
    'j2k_bodelian_lossless': {
        'loc': 'params/j2k1_digital_bodelian_lossless_codeblock_64,64',
        'ext': 'jp2'
    },
    'j2k1_bodelian_lossy': {
        'loc': 'params/j2k1_digital_bodelian_lossy_codeblock_64,64',
        'ext': 'jp2'
    },
    'j2k1_lossless_plt': {
        'loc': 'params/j2k1_lossless_plt_codeblock_64,64',
        'ext': 'jp2'
    },
    'j2k1_lossy_3bpp_plt': {
        'loc': 'params/j2k1_lossy_3bpp_plt_codeblock_64,64',
        'ext': 'jp2'
    }
}

urls = []

@events.init_command_line_parser.add_listener
def _(parser):
    parser.add_argument("--url-list", type=str, env_var="URL_LIST", default="", help="File of IIIF URLs")
    parser.add_argument("--limit", type=int, env_var="LIMIT", default="-1", help="Limit the number of URLs to test")
    parser.add_argument("--mode", type=str, env_var="MODE", default="aggregate", help="Either full or aggregate")
    parser.add_argument("--locations", type=str, env_var="locations", default=None, help="Path to json file containing images")
   
@events.test_start.add_listener
def on_test_start(environment, **kwargs):
    with open(environment.parsed_options.url_list, 'r') as fh:
        # example line: gm_00002701.tif/10240,8192,588,34/!73,4/0/default.jpg
        limit = int(environment.parsed_options.limit)
        print ('Limit {}'.format(limit))
        count = 0
        for line in fh:
            count += 1
            url = line.replace('\n', '')
            urls.append({
                'id': url.split('/')[0].split(".")[0],
                'params': "/".join(url.split('/')[1:])
            })
            if limit != -1 and count >= limit:
                print ('Breaking as {} is greater or equal to {}'.format(count, limit))
                break

   

class IIIFURLTester(HttpUser):

    @task
    def getURLs(self):
        if self.environment.parsed_options.locations:            
            with open(self.environment.parsed_options.locations, 'r') as fh:
                print (f'Loading {self.environment.parsed_options.locations}')
                locations = json.load(fh)        
                print (locations)
        for urlInfo in urls:
            for imgType, details in locations.items():
                url = "/iiif/{}/{}.{}/{}".format(details['loc'], urlInfo['id'], details['ext'], urlInfo['params'])
                print ('URL: ' + url)
                name= ""
                if self.environment.parsed_options.mode == "aggregate":
                    name = imgType
                else:
                    name="{}:{}".format(imgType,url)

                self.client.get(url,name=name) 

        print ('finished tests')
        self.environment.runner.quit()        
        print ('Quitting')
