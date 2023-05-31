#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function restartIIP {
    current=`pwd`
    if docker ps |grep iipsrv > /dev/null; then 
        echo "Stopping docker"
        docker stop iipimage > /dev/null
    fi
    cd $SCRIPT_DIR/../../../image_server
    docker run --detach --name iipimage  -e "IIPSRV_ENGINE=kakadu"  --rm -p 8000:8000 -v ~/development/htj2k/imgs/50:/data/images iipsrv_htj2k:latest > /dev/null
    http_code=100
    while [ "$http_code" != "200" ]
    do 
        sleep 2
        http_code=`curl --write-out %{http_code} --silent --output /dev/null "http://localhost:8000"`
        echo "$http_code";
    done
    echo "Docker started"
    cd $current
}


if [ ! -d $SCRIPT_DIR/data ]; then
    mkdir $SCRIPT_DIR/data
fi

cd $SCRIPT_DIR/../../../load_test/fromlist

restartIIP
filename="info-jsons.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="full.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="50.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="1024.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="500.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="3000.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
# stopped 
filename="custom_region-100-100-200-200.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="custom_region-100-100-2000-2000.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="uv_urls.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="mirador_urls.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP
filename="iiif_urls_unique.txt"; locust -u  1 --autostart --url-list ../../data/50_images/$filename --locations $SCRIPT_DIR/images.json --host http://0.0.0.0:8000  --autoquit 0 --headless --only-summary --csv $SCRIPT_DIR/data/$filename 
restartIIP

cd $SCRIPT_DIR;

if [ ! -d charts ]; then
    mkdir charts
fi
python ./mkBarChart.py