#!/bin/bash
for i in insertion selection; do for j in comparisons time; do ruby sort_demo.rb $i $j > ${i}_${j}.dat; done; done;
gnuplot sort_demo.p
