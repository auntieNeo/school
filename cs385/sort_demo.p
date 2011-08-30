set terminal svg enhanced size 1000 1000
set output "sort_demo_comparisons.svg"
plot "selection_comparisons.dat" using 1:2 with lines, "insertion_comparisons.dat" using 1:2 with lines;
set output "sort_demo_time.svg"
plot "selection_time.dat" using 1:2 with lines, "insertion_time.dat" using 1:2 with lines;
