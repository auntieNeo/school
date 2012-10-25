# CS 2299, Assignment #6

#  data segment
.data
#---------------------- Data declarations ----------------------

#---------------------- First Data Set ----------------------
list1:    .word  1,   2,  3,  4,  5,   6,   7,   8,   9,   10
      .word 20, 19, 18, 17, 16, 15, 14, 13, 12, 11

len1:   .word 20
min1:   .word 0
med1:   .word 0
max1:   .word 0
sum1:   .word 0
scalar1:  .word 0
ave1:   .float  0.0
#END---------------------- End of First Data Set ----------------------

#---------------------- Second Data Set ----------------------
list2:  .word 1224, 3125, 3435, 1362, 1932, 1631, 5232, 1736, 5316, 3723
    .word 1298, 1099, 9991, 2222, 3123, 3691, 1376, 7131, 1399, 3756
    .word 5546, 1579, 3549, 9847,  546, 1812, 4345, 1176, 1887, 7985
    .word 1571, 5148, 7495, 5713, 5712,   10, 4358, 7711, 7824, 3792
    .word 6115, 5162,  176, 3192, 1283, 9199, 9456, 3512, 1618, 4891
len2: .word 50
min2: .word 0
med2: .word 0
max2: .word 0
sum2: .word 0
scalar2:  .word 0
ave2: .float  0.0
#END---------------------- End of Second Data Set ----------------------

#---------------------- Third Data Set ----------------------
list3:  .word  823, 1432,  246, 1776,  111,  316,  164, 2165,  295, 3556
    .word 3137,  223, 1223,  140, 1215,  111,  354, 2628, 1613,  122
    .word  269, 1326,  162, 1627,  627,  327,  559,  277, 1175, 1914
    .word 1381,  225, 4315,  912,  317,  235,  610,  129,  412,  134
    .word  161, 3122,  351,  222, 3771,  819,  914, 1922,  215, 1531
    .word 1327,  164, 5110,  172,  924,  325,  216, 2162,  338,  192
    .word  111, 5383,  233,   30,  127,    1,  315, 5258, 1413, 1415
    .word 1217,  126, 2362,    7, 2227,  177, 1599, 3277,  175,  514
    .word  194, 1424,  212,  543,  476,  334, 1126, 6132,  456, 1263
    .word 1524,  219, 3122, 1683, 1810,  191, 1792, 1129,  129,  329
len3: .word 100
min3: .word 0
med3: .word 0
max3: .word 0
sum3: .word 0
scalar3:  .word 0
ave3: .float  0.0 
#END---------------------- End of Third Data Set ----------------------

#---------------------- Fourth Data Set ----------------------
list4:  .word  123,  222,  146,  876,  110,  426,  264,  665,  155,  256
    .word 2171, 9347, 7310, 3827, 6874, 3165, 3421, 9567, 9681, 3129
    .word  547,  123,  753,  340,  865,  231,  354,  728,  813,  522
    .word 1223, 1212, 8546, 1236, 6510, 3116, 3464, 4256, 1215, 3132
    .word  511,  683,  233,  250,  225,  389,  815,  118,  413,  415
    .word 3164, 6441, 6142, 8733, 5166, 5334, 7346, 7323, 5456, 8563
    .word  249,  126,  462,  231,  227,  277,  599,  897,  175,  714
    .word 3164, 6441, 6142, 8733, 5166, 5334, 7346, 7323, 5456, 8563
    .word  135,  626,  962,  337,  627,  727,  159,  177,  375,  244
    .word 6279, 5353, 1936, 3140, 9235, 6712, 8254, 2328, 3213, 7632
    .word  845,  875,  415,  422,  817,  615,  410,  129,  712,  134
    .word 7186, 7435, 1052, 1107, 8287, 2367, 7291, 1077, 1352, 8324
    .word  161,  192,  951,  213,  326,  369,  114,  822,  215,  631
    .word 4121, 8418, 4677, 8543, 9378, 4612, 9211, 9310, 5635, 2610
    .word  427,  644,  110,  172,  924,  225,  816,  462,  128,  192
    .word 3164, 6441, 6142, 8733, 5166, 5334, 7346, 7323, 5456, 8563
    .word  194,  324,  614,  143,  476,  134,  626,  322,  656,  263
    .word 1249, 2144, 5314, 7134, 6367, 6143, 7629, 8561, 3665, 2336
len4: .word 180
min4: .word 0
med4: .word 0
max4: .word 0
sum4: .word 0
scalar4:  .word 0
ave4: .float  0.0
#END---------------------- End of Fourth Data Set ----------------------

#---------------------- Fifth Data Set ----------------------
list5:  .word 1112, 1119, 1125, 1129, 1131, 1135, 1139, 1142, 1144, 1149
    .word 5782, 5795, 5807, 5812, 5827, 5847, 5867, 5879, 5888, 5894
    .word   99,  104,  106,  107,  124,  125,  126,  129,  148,  192
    .word 2241, 2243, 2246, 2249, 2251, 2252, 2254, 2258, 2261, 2265
    .word  199,  213,  224,  236,  240,  256,  275,  287,  315,  326
    .word  332,  351,  376,  387,  390,  400,  411,  423,  432,  445
    .word 5501, 5513, 5524, 5536, 5540, 5556, 5575, 5587, 5590, 5596
    .word  634,  652,  674,  686,  697,  704,  716,  720,  736,  753
    .word  782,  795,  807,  812,  827,  847,  867,  879,  888,  894
    .word 1209, 1211, 1229, 1231, 1249, 1251, 1269, 1271, 1289, 1291
    .word  903,  913,  923,  930,  935,  939,  943,  948,  953,  955
    .word  951,  955,  957,  963,  966,  968,  971,  977,  994,  996
    .word  112,  119,  125,  129,  131,  135,  139,  142,  144,  149
    .word  241,  243,  246,  249,  251,  252,  254,  258,  261,  265
    .word    2,    9,   15,   19,   21,   25,   29,   32,   34,   39
    .word   41,   43,   46,   49,   51,   52,   54,   58,   61,   65
    .word 3369, 3374, 3377, 3379, 3382, 3384, 3386, 3388, 3392, 3393
    .word   69,   74,   77,   79,   82,   84,   86,   88,   92,   93
    .word  369,  374,  377,  379,  382,  384,  386,  388,  392,  393
    .word  400,  404,  406,  407,  424,  425,  426,  429,  448,  492
    .word 1300, 1311, 1324, 1339, 1340, 1255, 1361, 1374, 1388, 1393
    .word  501,  513,  524,  536,  540,  556,  575,  587,  590,  596
    .word 1505, 1512, 1526, 1535, 1540, 1557, 1563, 1579, 1582, 1594
    .word  206,  212,  222,  231,  246,  250,  254,  278,  288,  292
    .word 9707, 9717, 9727, 9737, 9747, 9757, 9767, 9777, 9787, 9797
    .word  457,  487,  499,  501,  523,  524,  525,  526,  575,  594
    .word 4634, 4652, 4674, 4686, 4697, 4704, 4716, 4720, 4736, 4753
    .word  634,  652,  674,  686,  697,  704,  716,  720,  736,  753
    .word  782,  795,  807,  812,  827,  847,  867,  879,  888,  894
    .word 1709, 1711, 1729, 1731, 1749, 1751, 1769, 1771, 1789, 1791
len5: .word 300
min5: .word 0
med5: .word 0
max5: .word 0
sum5: .word 0
scalar5:  .word 0
ave5: .float  0.0
#END---------------------- End of Fifth Data Set ----------------------

#  Variables for main

hdr:    .asciiz "\nAssignment #6\n"

hdr_nm:   .ascii  "\n---------------------------"
      .asciiz "\nList #"

hdr_key:  .asciiz "\nPlease provide size of scalar: "
hdr_ln:   .asciiz "\nLength: "
hdr_or:   .asciiz "\n\n Original List: \n\n"
hdr_un:   .asciiz "\n\n Unsorted List: \n\n"
hdr_sr:   .asciiz "\n\n Sorted List: \n\n"

space:    .asciiz " "
SPACES=7  # number of spaces between the numbers (including number)

# Variables for prt_stats procedure.

new_ln: .asciiz "\n"

str1: .asciiz "\n min = "
str2: .asciiz "\n med = "
str3: .asciiz "\n max = "
str4: .asciiz "\n sum = "
str5: .asciiz "\n ave = "
#END---------------------- End of Data declarations ----------------------

#####################################################################
#  Basic flow:
# * display header

# for each data set:
#   * display headers and get scalar value from keyboard
#   * display original list
#   * create a new list from a list (multiply each element by SCALAR)
#   * display list multiplied by scalar
#   * sort list
#   * display sorted list
#   * find list stats (min, max, med, sum, and average)
#   * display list stats  (min, max, med, sum, and average)
#####################################################################
#  text/code segment

.text
.globl  main
.ent  main
main:

# -----
#  Display Program Header.

  la  $a0, hdr
  li  $v0, 4
  syscall         # print header

  li  $s0, 1        # counter, data set number

#####################################################################
#  Data Set #1

  la  $a0, hdr_nm
  li  $v0, 4
  syscall

  move $a0, $s0
  li  $v0, 1
  syscall

  la  $a0, hdr_key
  li  $v0, 4
  syscall
  
  li  $v0, 5      # load appropriate system call code into register $v0;
            # code for reading integer is 5
  syscall       # call operating system to perform operation
  sw  $v0, scalar1  # value read from keyboard returned in register $v0;
            # store this in desired location  
  
  la  $a0, hdr_ln
  li  $v0, 4
  syscall
  
  lw  $a0, len1
  li  $v0, 1
  syscall

  add $s0, $s0, 1

#  Display original list
# call  prt_lst(list1, len1)
  la  $a0, hdr_or
  li  $v0, 4
  syscall

  la  $a0, list1
  lw  $a1, len1
  jal prt_lst

#  Create New List
# call mk_nlist(list1, len1, scalar1)


#  Display unsorted list
# call  prt_lst(list1, len1)


#  Sort list
# call  ins_sort(list1, len1)


#  Display sorted list
# call  prt_lst(list1, len1)
  
#  Generate list stats

#  Display list stats


#  END of Data Set #1 
#####################################################################


#####################################################################
#  Data Set #2

#...

#  END of Data Set #2 
#####################################################################

#####################################################################
#  Data Set #3

#...

#  END of Data Set #3
#####################################################################

#####################################################################
#  Data Set #4

#...

#  END of Data Set #4
#####################################################################

#####################################################################
#  Data Set #5

#...

#  END of Data Set #5
#####################################################################


#####################################################################
#  Done, terminate program.

  li  $v0, 10
  syscall         # au revoir...

.end main


#####################################################################


#####################################################################
#  Procedure, prt_lst, to display a list of numbers.
#  The numbers should be printed 8 per line.
#  The numbers are right justified (i.e., lined up on right
#  side).  Assumes that the largest number is 5 digits.

#  Note, due to the system calls, the saved registers must
#  be used.  As such, push/pop saved registers altered.

# -----
#    Arguments:
# $a0 - starting address of the list
# $a1 - list length

#    Returns:
# N/A

.globl  prt_lst
.ent  prt_lst
prt_lst:
  #Save registers used in the procedure:
    subu $sp, $sp, 4
  sw  $s0, ($sp)  
  subu $sp, $sp, 4
  sw  $s1, ($sp)
  subu $sp, $sp, 4
  sw  $s2, ($sp)
  subu $sp, $sp, 4
  sw  $s3, ($sp)
  subu $sp, $sp, 4
  sw  $s4, ($sp)
  
  move $s4, $a0
  li $s0, 0       # print counter
  move $s1, $a1
  
  pr_lp:  
    sub $s1, $s1, 1   # decrease len
    bltz $s1, exit
  
    lw $s2, ($s4)   # get number
  
    li $s3, 0       # set digit counter to 0
  
    # loop to check how many digits in the number 
    div_lp: 
      div $s2, $s2, 10  
      add $s3, $s3, 1
    bgtz $s2, div_lp

    li $s2, SPACES
    sub $s3, $s2, $s3     # calculate spaces beetween numbers 

    # loop to print the spaces  
    prt_spcs:
      la  $a0, space  # print a spaces
      li  $v0, 4
      syscall
      subu $s3, $s3, 1
    bgez $s3, prt_spcs
  
    lw $a0, ($s4)     # print value
    li $v0, 1
    syscall
    
    add $s4, $s4, 4     # update address
    add $s0, $s0, 1     # update print counter
    bltu $s0, 8, pr_lp    # if 8 print new line symbol
  
    li $s0, 0
    la  $a0, new_ln     # print a newline
    li  $v0, 4
    syscall

  b pr_lp

exit:
  lw  $s4, ($sp)
  addu $sp, $sp, 4
  lw  $s3, ($sp)
  addu $sp, $sp, 4
  lw  $s2, ($sp)
  addu $sp, $sp, 4
  lw  $s1, ($sp)
  addu $sp, $sp, 4
  lw  $s0, ($sp)
  addu $sp, $sp, 4

jr $ra
.end prt_lst

################################################################################
# This procedure is called as mk_nlist(list, len, scalar), where list is the
# address of an array of integers, len is the length of that array, and scalar
# is the scalar to multiply by. The procedure modifies the list by multiplying
# each element by the given scalar.
#
#    Arguments:
# $a0 - starting address of the list
# $a1 - list length
# $a2 - scalar value to multiply by
################################################################################
.global mk_nlist
.ent mk_nlist
  # loop over the elements
  li $s0, 0  # iterator
  loop:
    bge $s0, $a1, exit

  exit:
.end mk_nlist
