#!/usr/bin/env python3
# coding: utf-8
import csv

from glob import glob

from matplotlib import pyplot as plt

label_map = {
    '{derv_sz: "rnd_region"}': "Random region",
    '{derv_sz: "tile"}': "Random tile",
    '{derv_sz: 1024}': "Full frame 1024 px",
    '{derv_sz: 128}': "Full frame 128 px",
    '{derv_sz: 4096}': "Full frame 4096 px",
}


def print_labels(p, values):
    for i in range(len(values)):
        label = f"{values[i]:.2f}"
        p.text(i, values[i], label, ha="center")


stats = {}
files = sorted(glob("./*_stats.csv"))
for fname in files:
    with open(fname, 'r') as fh:
        reader = csv.DictReader(fh)
        stats[fname] = []
        for row in reader:
            stats[fname].append(row)
tags = [r["Name"] for r in stats['./kdu_htj2k_lossless_stats.csv']][:-1]
labels = [label_map[t] for t in tags]
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

for i in range(len(medians)):
    plt.figure(figsize=(12, 7))

    median_plt = plt.subplot(211)
    median_plt.set_yscale("log")
    median_plt.bar(x, medians[i])
    median_plt.set_title(f"{labels[i]}: median response times (ms)")
    print_labels(median_plt, medians[i])

    avg_plt = plt.subplot(212)
    avg_plt.set_yscale("log")
    avg_plt.bar(x, avg[i])
    avg_plt.set_title(f"{labels[i]}: average response times (ms)")
    print_labels(avg_plt, avg[i])

    title = labels[i].lower().replace(" ", "_")
    plt.savefig(f"./stats_{title}.png", dpi=200)
