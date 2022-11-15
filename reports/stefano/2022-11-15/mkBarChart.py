#!/usr/bin/python
import numpy as np
import pandas as pd
from pandas import Series, DataFrame
import matplotlib.pyplot as plt
from os import listdir
import json
import csv

# Type     Name                                                                          # reqs      # fails |    Avg     Min     Max    Med |   req/s  failures/s
# --------|----------------------------------------------------------------------------|-------|-------------|-------|-------|-------|-------|--------|-----------
# GET      {derv_sz: "rnd_region"}                                                         2120     0(0.00%) |     14       5      63     13 |    3.02        0.00
# GET      {derv_sz: "tile"}                                                               2120     0(0.00%) |      8       3     199      7 |    3.02        0.00
# GET      {derv_sz: 1024}                                                                 1062     0(0.00%) |    107      39     467     88 |    1.51        0.00
# GET      {derv_sz: 128}                                                                  5300     0(0.00%) |      9       4      44      9 |    7.54        0.00
# GET      {derv_sz: 4096}                                                                  266     0(0.00%) |   1835     701    5524   1200 |    0.38        0.00
# --------|----------------------------------------------------------------------------|-------|-------------|-------|-------|-------|-------|--------|-----------
#          Aggregated                                                                     10868     0(0.00%) |     64       3    5524     10 |   15.46        0.00

# missing: 'htj2k-lossy',
files = ['kdu_htj2k_lossless',  'j2k1_lossless', 'j2k1_lossy', 'ptiff_lossless', 'ptiff_lossy']

data = {}
for results in files:
    with open("data/{}_stats.csv".format(results)) as csvfile:
        csvreader = csv.reader(csvfile)
        for line in csvreader:
            if "GET" in line[0]:
                key = line[1].replace('"',"").replace('}','').replace("{derv_sz: ",'')
                if key not in data:
                    data[key] = []
                    
                data[key].append({
                    'type': results,
                    'value' : float(line[5])
                })

print (json.dumps(data, indent=4))
for graph in data.keys():        
    labels = []
    values = []
    title = graph
    for bar in data[graph]:
        labels.append("{}: {}".format(bar['type'],int(bar['value'])))
        values.append(bar['value'])

    print(labels)
    print (values)
    plt.xticks(range(len(labels)), labels)
    plt.xticks(fontsize=6, rotation=30)
    plt.ylabel('Response in ms')
    plt.title(title)
    #plt.grid(True, axis='y', linestyle='--', linewidth=0.5, zorder=3 )
    plt.bar(labels, values, color=['#bd2b2b', '#d48787', '#5e69e0', '#9da3e3', '#77777d', '#939496'] )
    #plt.tight_layout()

    filename = '{}.png'.format(graph)
    plt.savefig('charts/{}'.format(filename), dpi=300)
    fig = plt.figure()
    fig.clear()


    print ('Markdown:')
    print ('![{}](charts/{})'.format(title, filename))#!/usr/bin/python
