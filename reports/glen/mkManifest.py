import os
import sys
import urllib.request, json

def main():
    """Create Manifest from list of image files
    """
    if len(sys.argv) != 4:
        print ('Usage:\n\t{} [directory of images] [url_format] [output.json]'.format(sys.argv[0]))
        sys.exit(0)
    
    canvases = []
    count = 0
    for filename in os.listdir(sys.argv[1]):
         name, file_extension = os.path.splitext(filename)
         if file_extension in ['.tif','.jp2']:
            count += 1
            imageURI = sys.argv[2].format(filename)
            with urllib.request.urlopen(imageURI + "/info.json") as url:
                infoJson = json.loads(url.read().decode())

                canvases.append({
                    "@id": "http://example.org/iiif/book1/canvas/{}".format(filename),
                    "@type": "sc:Canvas",
                    "label": "Canvas: {} ({})".format(count, filename),
                    "height": infoJson['height'],
                    "width": infoJson['width'],
                    "images": [
                      {
                        "@type": "oa:Annotation",
                        "motivation": "sc:painting",
                        "resource":{
                            "@id": "{}/full/1024,/0/default.jpg".format(imageURI),
                            "@type": "dctypes:Image",
                            "format": "image/jpeg",
                            "height": infoJson['height'],
                            "width": infoJson['width'],
                            "service": {
                                "@context": "http://iiif.io/api/image/2/context.json",
                                "@id": imageURI,
                                "profile": infoJson['profile'],
                                "height": infoJson['height'],
                                "width": infoJson['width']
                            }
                        },
                        "on": "http://example.org/iiif/book1/canvas/{}".format(filename)
                      }
                    ],
                })
         else:
            print ('Ignoring: {} ({})'.format(filename, file_extension))
    
    
    manifest = {
        "@context": "http://iiif.io/api/presentation/2/context.json",
        "@id": "http://example.org/iiif/book1/manifest",
        "@type": "sc:Manifest",
        "label": "All Images",
        "sequences": [
            {
                "@id": "http://example.org/iiif/book1/sequence/normal",
                "@type": "sc:Sequence",
                "label": "Current Page Order",
                "viewingDirection": "left-to-right",
                "viewingHint": "non-paged",
                "canvases": canvases
            }
        ]    
    }

    with open(sys.argv[3], 'w') as f:
        json.dump(manifest, f, indent=4)

    print ('Written manifest to: {}'.format(sys.argv[3]))

if __name__ == '__main__':
    main()
