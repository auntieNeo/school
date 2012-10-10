#  CS 2299, MIPS Assignment #5

#  Example program to find the mimimum and maximum.


###########################################################
#  data segment

.data

array: 	.word -123, 193, 982, -339, 564, -631, 421, -148, 936, -157
		.word -117, 171, -697, 161, -147, 137, -327, 151, -147, 354
		.word 432, -551, 176, -487, 490, -810, 111, -523, 532, -445
		.word -163, 745, -571, 529, -218, 219, -122, 934, -370, 121
		.word 315, -145, 313, -174, 118, -259, 672, -126, 230, -135
		.word -199, 104, -106, 107, -124, 625, -126, 229, -248, 992
		.word 132, -133, 936, 136, 338, -941, 843, -645, 447, -449
		.word -171, 271, -477, -228, 178, 184, -586, 186, -388, 188
		.word 950, -852, 754, 256, -658, -760, 161, -562, 263, -764
		.word -199, 213, -124, -366, 740, 356, -375, 387, -115, 426

len:	.word	100
min:	.word	0
max:	.word	0

hdr:	.asciiz	"\nExample program to find max/min\n\n"
new_ln:	.asciiz	"\n"
a1_msg:	.asciiz	"min = "
a2_msg:	.asciiz	"max = "

###########################################################
#  text/code segment

#  This program will use pointers.
#	t0 - array address
#	t1 - count of elements
#	t2 - min
#	t3 - max
#	t4 - each word from array

.text
.globl	main
.ent	main
main:

# -----
#  Display header.
	la	$a0, hdr
	li	$v0, 4
	syscall				# print header
# -----

#  Find max and min of the array.
	la	$t0, array		# set $t0 addr of array
	lw	$t1, len		# set $t1 to length

	lw	$t2, ($t0)		# set min, $t2 to array[0]
	lw	$t3, ($t0)		# set max, $t3 to array[0]
	add	$t0, $t0, 4		# skip array[0]
	add	$t1, $t1, -1	# length=length-1

loop:	
	lw	$t4, ($t0)		# get array[n]

  andi $t5, $t4, 1
  beq  $t5, $0, noMax  # ignore evens

	bge	$t4, $t2, noMin		# is new min?
	move	$t2, $t4		# set new min

noMin:	
	ble	$t4, $t3, noMax		# is new max?
	move	$t3, $t4		# set new max

noMax:	
	add	$t1, $t1, -1		# decrement counter
	add	$t0, $t0, 4			# increment addr by word
	bnez	$t1, loop

	sw	$t2, min		# save min
	sw	$t3, max		# save max

# -----
#  Display results.

#  Note, some of the system calls utilize/alter the
#        temporary registers.

	la	$a0, a1_msg
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, min
	li	$v0, 1
	syscall				# print min

	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

	la	$a0, a2_msg
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, max
	li	$v0, 1
	syscall				# print max

	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall				# all done!

.end main
