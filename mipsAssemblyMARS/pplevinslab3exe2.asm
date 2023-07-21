## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 3 exercise 2

.data 0x10010000
memsource:
#.byte 2, 4, 8, 16, 32
#.byte 2, 4, 6, 8, 10
.byte 10, 8, 6, 4, 2
#.byte 1, 1, 1, 1, 1
#.byte 5
msgnotseq: .asciiz "\nthe numbers are not a sequence."
msgarithm: .asciiz "\nthe numbers are an arithmetic sequence."
msggeom: .asciiz "\nthe numbers are an geometric sequence."
msga1: .asciiz "\nfirst element is: "
msgd: .asciiz "\n'd' is: "
msgq: .asciiz "\n'q' is: "

.text
la $a0, memsource
li $a1, 5

li $t0, 1
beq $a1, $t0, oneelement #if it's only one element

#check fo arithmetirc sequence.
arithmetic: lb $t0, 0($a0)
lb $t1, 1($a0)
sub $t2, $t1, $t0 #setting the 'd'
li $t4, 2
aloop: slt $t5, $t4, $a1
beq $t5, $zero, loopexit
addi $a0, $a0, 1
lb $t0, 0($a0)
lb $t1, 1($a0)
sub $t3, $t1, $t0
addi $t4, $t4, 1
beq $t3, $t2, aloop #if the difference is equal, continue the loop.
li $s0, 0 #flag
j geometric #go to check for geometric sequence
loopexit: la $a0, memsource
lb $a2, 0($a0)
li $s0, 1 #flag
slt $t7, $t2, $zero
beq $t7, $zero geometric
jal isarithmetic
j exit

#check fo geometric sequence.
geometric: la $a0, memsource
lb $t0, 0($a0)
lb $t1, 1($a0)
div $t1, $t0
mflo $t6 #setting the 'q'
li $t4, 2
bloop: slt $t5, $t4, $a1
beq $t5, $zero, loopexit2
addi $a0, $a0, 1
lb $t0, 0($a0)
lb $t1, 1($a0)
div $t1, $t0
mflo $t3
addi $t4, $t4, 1
beq $t3, $t6, bloop
li $s1, 0 #flag
j flagcheck
loopexit2: la $a0, memsource
lb $a2, 0($a0)
li $s1, 1 #flag

flagcheck: li $s3, 1
and $s2, $s1, $s0 #if it's both arithmetic and geometric.
beq $s2, $s3, both
or $s2, $s1, $s0
beq $s2, $zero, isnotseq
beq $s0, $zero, next
la $a0, memsource
jal isarithmetic
j exit
next: jal isgeometric
j exit

both: jal isarithmetic
jal isgeometric
j exit

oneelement: li $t2, 0
li $t6, 0
jal isarithmetic
jal isgeometric
j exit

isarithmetic: addi $sp, $sp, -12
sw $t0, 8($sp)
sw $a0, 4($sp)
sw $v0, 0($sp)

add $t0, $a0, $zero
la $a0, msgarithm
li $v0, 4
syscall
la $a0, msgd
li $v0, 4
syscall
add $a0, $t2, $zero
li $v0, 1
syscall
la $a0, msga1
li $v0, 4
syscall
lb $a0, 0($t0)
li $v0, 1
syscall

lw $v0, 0($sp)
lw $a0, 4($sp)
lw $t0, 8($sp)
addi $sp, $sp, 12
jr $ra

isgeometric: addi $sp, $sp, -12
sw $t0, 8($sp)
sw $a0, 4($sp)
sw $v0, 0($sp)

add $t0, $a0, $zero
la $a0, msggeom
li $v0, 4
syscall
la $a0, msgq
li $v0, 4
syscall
add $a0, $t6, $zero
li $v0, 1
syscall
la $a0, msga1
li $v0, 4
syscall
lb $a0, 0($t0)
li $v0, 1
syscall

lw $v0, 0($sp)
lw $a0, 4($sp)
lw $t0, 8($sp)
addi $sp, $sp, 12
jr $ra

isnotseq: la $a0, msgnotseq
li $v0, 4
syscall

exit:
