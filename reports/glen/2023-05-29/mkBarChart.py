#!/usr/bin/python3
import numpy as np
import pandas as pd
from pandas import Series, DataFrame
import matplotlib.pyplot as plt
import csv
import os

log_dir="data"
runs = ["info-jsons.txt", "full.txt","50.txt","1024.txt", "500.txt", 
        "3000.txt", "custom_region-100-100-200-200.txt", "custom_region-100-100-2000-2000.txt", 
        "uv_urls.txt","mirador_urls.txt","iiif_urls_unique.txt"]
for run in runs:
    name = run.replace('.txt','')

    data = {}
    if os.path.exists(f"{log_dir}/{run}_stats.csv"):
        with open(f"{log_dir}/{run}_stats.csv") as csvfile:
            csvreader = csv.reader(csvfile)
            for line in csvreader:
                if 'GET' in line[0]:
                    data[line[1]] = round(float(line[5]))

        title=f"Testing configs - {name}" 
            
        print (data)
        titles = [  'ptiff-lossless-round1', 
                    'ptiff-lossy-round1', 
                    'htj2k-bodelian-lossless', 
                    'j2k_bodelian_lossless', 
                    'htj2k_bodelian_lossy', 
                    'j2k1_bodelian_lossy',
                    'htj2k_lossless',  
                    'htj2k_lossless_plt',
                    'j2k1_lossless_plt', 
                    'htj2k_lossy_3bpp_plt',
                    'j2k1_lossy_3bpp_plt',
                    'htj2k_lossy_Qfactor_90_plt', 
                    'j2k1_lossy_Qfactor_90_plt',
                    'htj2k-lossless-round1',  
                    'jp2-lossless-round1', 
                    'htj2k-lossy-round1',  
                    'jp2-lossy-round1'] #data.keys()
        values = []
        colours = []
        for key in titles:
            values.append(int(data[key]))
            if 'htj2k' in key:
                colours.append("#bf132d")
            elif 'ptiff' in key:
                colours.append('#827d7d')    
            else:
                colours.append("#2d3a75")

        labels = list(titles)
        data = values
        print (labels)
        print(data)

        plt.yticks(range(len(data)), labels)
        plt.ylabel(None)
        #plt.yticks(fontsize=4, rotation=90)
        plt.xlabel('Response in ms')
        plt.title(title)
        plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
        bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
        for i in range(len(labels)):
            plt.text(data[i] + 3, i, f"({data[i]})", va = 'center')
        plt.tight_layout()

        filename=f"{name}.png" 

        plt.savefig('charts/{}'.format(filename), dpi=300)
        fig = plt.figure()
        fig.clear()

        print ('Markdown:')
        print ('![{}](charts/{})'.format(title, filename))
    else:
        print (f'Missing file: {log_dir}/{run}_stats.csv')
