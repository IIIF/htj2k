#!/usr/bin/python3

import csv
import sys

def isFloat(element):
    if element is None: 
        return False
    try:
        float(element)
        return True
    except ValueError:
        return False

if __name__ == "__main__":
    filename = sys.argv[1]
    with open(filename) as csvfile:
        csvreader = csv.reader(csvfile)
        firstLine=True
        for row in csvreader:
            line = "|"
            for col in row:
                if isFloat(col):
                    col = round(float(col))
                line += f" {col} |"

            print (line)    
            if firstLine:
                sep = "|"
                for col in row:
                    sep += " --- |"
                print (sep)
                firstLine=False