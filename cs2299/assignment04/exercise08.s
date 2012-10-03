         move $t0, $zero
loop:    beq $a1, $zero, finish
         add $t0, $t0, $a0
         sub $a1, $a1, 1
         j lp
finish:  addi $t0, $t0, 10
         add $v0, $t0, $zero
