#!/usr/bin/env python3
# coding: utf-8
import csv

from glob import glob

from matplotlib import pyplot as plt


plt.figure(figsize=(12, 7))

stats = {}
files = sorted(glob("./*_stats.csv"))
for fname in files:
    with open(fname, 'r') as fh:
        reader = csv.DictReader(fh)
        stats[fname] = []
        for row in reader:
            stats[fname].append(row)
labels = [r["Name"] for r in stats['./kdu_htj2k_lossless_stats.csv']][:-1]
x = [i[2:-10] for i in stats.keys()]
inv_medians = [
    [float(row["Median Response Time"]) for row in tbl][:-1]
    for tbl in stats.values()
]
inv_avg = [
    [float(row["Average Response Time"]) for row in tbl][:-1]
    for tbl in stats.values()
]
# Rotate array
medians = list(zip(*inv_medians[::1]))
avg = list(zip(*inv_avg[::1]))

median_plt = plt.subplot(211)
median_plt.stackplot(x, medians, labels=labels)
median_plt.legend(labels, loc="upper left")
median_plt.set_title("Median response times (ms)")

avg_plt = plt.subplot(212)
avg_plt.stackplot(x, avg, labels=labels)
avg_plt.legend(labels, loc="upper left")
avg_plt.set_title("Average response times (ms)")

plt.savefig("./stats.png", dpi=200)
