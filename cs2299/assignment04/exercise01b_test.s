      .data
A:    .word 1,2,3,4  # some test data
B:    .word 5,6,7,8
      .text
main:
      # Here we set the registers specified in the assignment.
      li    $s0, 1  # Set f to 1. Note that f is not divisible by 4.
      li    $s1, 2  # Set g to 2.
      # Note that both A and B are word aligned by the assembler.
      # I.e. both A and B are divisible by 4.
      la    $s6, A
      la    $s7, B
      
      # The code from the assignment starts here.
      # With the values set, we want it to compute compute B[g] = A[f + 1] + A[f]
      add   $t0, $s6, $s0  # Add f to the address of A (without concern for
                           # byte alignment!). Supposedly f is an array index.
                           # By adding f without shifting first, 
      add   $t1, $s7, $s1  # Add g to the address of B.
      lw    $s0, 0($t0)  # Attempt to load a word at the address stored in $t0,
                         # which is not word aligned.
      #### Address Error ####
      # From MIPS Architecture For Programmers Volume II-A, Revision 3.02, page 152:
      # The effective address [of load word] must be naturally-aligned. If
      # either of the 2 least-significant bits of the address is non-zero, an
      # Address Error exception occurs.

      addi  $t2, $t0, 4
      lw    $t0, 0($t2)
      add   $t0, $t0, $s0
      sw    $t0, 0($t1)
