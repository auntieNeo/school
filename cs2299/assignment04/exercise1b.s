add $t0, $s6, $s0
add $t1, $s7, $s1
lw $s0, 0($t0)
addi $t2, $t0, 4
lw $t0, 0($t2)
add $t0, $t0, $s0
sw $t0, 0($t1)
