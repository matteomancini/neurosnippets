#!/usr/bin/env python3
# coding: utf-8
# Script to generate bundle-wise connectome
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 10/03/2021

import numpy as np
import sys

def usage():
    # Shows the general usage
    print('Usage: '+sys.argv[0]+' in_assignment_file in_weight_file operation out_matrix')


def process(data, action):
    # Process the data using the related action from numpy
    if action == "--mean":
        result = np.mean(data)
    elif action == "--median":
        result = np.median(data)
    return result


if len(sys.argv) < 4:
    usage()
    sys.exit(1)
assert sys.argv[3] in ['--mean', '--median'], \
    f"Unknown operation: {sys.argv[3]}. Must be one of: --mean, --median"

sparsemat = {}
with open(sys.argv[1], 'r') as f, open(sys.argv[2], 'r') as w:
    # loop in parallel over the two files
    for pair, values in zip(f,w):
        row, col = [int(p) for p in pair.split(' ')]
        if row > col:
            # symmetric connectivity
            row, col = col, row
        key = (row, col)
        dist = [float(v) for v in values.split(' ') if not np.isnan(float(v))]
        sparsemat.setdefault(key,[]).extend(dist)

n = np.max([*sparsemat.keys()])
fullmat = np.zeros((n, n))
for ix in range(n):
    for jx in range(ix+1, n):
        fullmat[ix, jx] = process(sparsemat.get((ix+1, jx+1), 0), sys.argv[3])
        fullmat[jx, ix] = fullmat[ix, jx]

np.savetxt(sys.argv[4], fullmat)
