.data 
square1: .word 2, 9, 4, 7, 5, 3, 6, 1, 8
square1_n: .word 3
square1_colMajor: .word 1

.text
.globl main
.ent main
main:
  la $a0, square1
  lw $a1, square1_n
  lw $a2, square1_colMajor
  addi $sp, -16
  jal prt_sqr
  addi $sp, 16
  
  li $v0, 10
  syscall
.end main

################################################################################
# This routine prints an n by n square matrix with the given dimension n. If the
# transpose flag is true, the matrix is treated as being in column major format
# and transposed before it is printed. Otherwise it is treated as being in row
# major format.
#
# Arguments:
# $a0 - address of the first element in the matrix
# $a1 - n dimension of the matrix
# $a2 - transpose flag
################################################################################

.globl prt_sqr
.ent prt_sqr
prt_sqr:
  mult $a1, $a1
  mflo $s0  # matrix size

  li $s1, 0  # stack offset

  or $s3, $a0, $zero  # address of matrix to ultimately print

  # transpose the matrix if transpose flag is true
  beq $a2, $zero, transpose_end

    # allocate stack space for the transposed matrix
    sll $s1, $s0, 2
    andi $t0, $s1, 0x00000004
    beq $t0, $zero, b0
    addi $s1, 4  # make sure the stack pointer remains a multiple of 8
    b0:
    or $s3, $sp, $zero
    addi $s3, -4
    sub $sp, $sp, $s1

    # loop through the matrix to transpose it
    li $s2, 0  # index i
    loop0:
      slt $t0, $s2, $s0
      beq $t0, $zero, loop0_end

      div $s2, $a1  # (index / n) in LO, (index % n) in HI
      mflo $t2  # index / n, col of old matrix, row of new matrix
      mfhi $t3  # index % n, row of old matrix, col of new matrix

      sll $t0, $s2, 2
      or $t1, $a0, $zero
      add $t1, $t1, $t0
      lw $t1, ($t1)  # matrix.col(index / n).row(index % n)

      # place value at index j of new matrix
      # j = row * n + col = $t2 * $a1 + $t3
      mult $t2, $a1
      mflo $t4
      add $t4, $t4, $t3  # index j
      sll $t0, $t4, 2
      add $t0, $s3, $t0
      sw $t1, ($t0)

      addi $s2, 1
      j loop0
    loop0_end:
  transpose_end:

  # loop to print the matrix
  loop1:
  loop1_end:

  # de-allocate any memory on the stack
  add $sp, $sp, $s1
  jr $ra
.end prt_sqr

.globl chk_magic_sqr
.ent chk_magic_sqr
chk_magic_sqr:
.end chk_magic_sqr
