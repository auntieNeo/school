set terminal svg enhanced size 1000 1000
set output "sort_demo.svg"
plot "selection.dat" using 1:2 with lines, "insertion.dat" using 1:2 with lines;
