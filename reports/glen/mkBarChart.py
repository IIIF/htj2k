#!/usr/bin/python3
import numpy as np
import pandas as pd
from pandas import Series, DataFrame
import matplotlib.pyplot as plt

print("Enter/Paste your content. Ctrl-D  to save it.")
contents = []
#"Type     Name                                                                          # reqs      # fails |    Avg     Min     Max    Med |   req/s  failures/s",
#            "--------|----------------------------------------------------------------------------|-------|-------------|-------|-------|-------|-------|--------|-----------",
#            "GET      htj2k-lossless                                                                  3086     0(0.00%) |     35       7     146     25 |    4.41        0.00",
#            "GET      htj2k-lossy                                                                     3086     0(0.00%) |     29       7     637     25 |    4.41        0.00",
#            "GET      jp2-lossless                                                                    3086     0(0.00%) |     68       7     229     65 |    4.41        0.00",
#            "GET      jp2-lossy                                                                       3086     0(0.00%) |     66       9     189     66 |    4.41        0.00",
#            "GET      ptiff-lossless                                                              3086     0(0.00%) |     12       5      43     12 |    4.41        0.00",
#            "GET      ptiff-lossy                                                                     3086     0(0.00%) |     12       6      44     12 |    4.41        0.00",
#            "--------|----------------------------------------------------------------------------|-------|-------------|-------|-------|-------|-------|--------|-----------",
#            "         Aggregated                                                                     18516     0(0.00%) |     37       5     637     24 |   26.49        0.00"]
         #[]
while True:
    try:
        line = input()
    except EOFError:
        break
    contents.append(line)

title=input('Chart title: ').strip()
data = {}
for line in contents:
    print (line)
    if "GET" in line:
        dataLine = line.split()
        data[dataLine[1]] = dataLine[5]
        

print (data)
titles = data.keys()
values = []
for key in titles:
    values.append(int(data[key]))

labels = list(titles)
data = values
print (labels)
print(data)

plt.xticks(range(len(data)), labels)
plt.xlabel(None)
plt.xticks(fontsize=8, rotation=30)
plt.ylabel('Response in ms')
plt.title(title)
plt.grid(True, axis='y', linestyle='--', linewidth=0.5, zorder=3 )
plt.bar(range(len(data)), data, zorder=0,color=['#bd2b2b', '#d48787', '#5e69e0', '#9da3e3', '#77777d', '#939496'] )
plt.tight_layout()

filename=input('Enter filename: ').strip()

plt.savefig('charts/{}'.format(filename), dpi=300)

print ('Markdown:')
print ('![{}](charts/{})'.format(title, filename))
#print ('<img src="charts/{}" alt="{}" width="250" />'.format(filename, title))
