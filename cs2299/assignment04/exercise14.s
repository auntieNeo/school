LOOP:   slt $t2, $0, $t1
        beq $t2, $0, DONE
        subi $t1, $t1, 1
        addi $s2, $s2, 2
        j LOOP
DONE:
