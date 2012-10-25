      .data
A:    .word 1,2,3,4  # some test data
B:    .word 5,6,7,8
      .text
main:
      # Here we set the registers specified in the assignment.
      li    $s0, 1
      li    $s1, 42
      # Note that both A and B are word aligned by the assembler.
      # I.e. both A and B are divisible by 4.
      la    $s6, A
      la    $s7, B
      
      # The code from the assignment starts here.
      sll   $t0, $s0, 2  # Shift by two to keep word alignment.
      add   $t0, $s6, $t0
      sll   $t1, $s1, 2  # Shift by two to keep word alignment.
      add   $t1, $s7, $t1
      lw    $s0, 0($t0)
      addi  $t2, $t0, 4  # Again, adding four keeps word alignment.
      lw    $t0, 0($t2)
      add   $t0, $t0, $s0
      sw    $t0, 0($t1)
