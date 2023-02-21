#!/usr/bin/python3

# Usage: mkBarChart.py <input file>
# Where <input file> is a CSV output file from Locust.

import csv

from os import argv

import matplotlib.pyplot as plt


fname = argv[1]

title=input('Chart title: ').strip()
data = {}
with open(fname, newline="") as fh:
    reader = csv.reader(fh)
    for line in reader:
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
