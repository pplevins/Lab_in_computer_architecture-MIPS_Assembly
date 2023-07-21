## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 2 exercise 2

#setting the messages for the program.
.data
evalue: .asciiz "\nENTER VALUE: "
eopcode: .asciiz "\nENTER OP CODE:"
eresult: .asciiz "\nthe result is: "
eexception: "\nERROR!"

#setting the operands signinto rgisters.
.text
li $s1, '+'
li $s2, '-'
li $s3, '*'
li $s4, '@'

#inputting the first value and place it into $t0.
li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
add $t0, $v0, $zero

#inputting the op-code from the user.
opcode: li $v0, 4
la $a0, eopcode
syscall
li $v0, 12
syscall

#selecting the operation.
beq $v0, $s1, nadd
beq $v0, $s2, nsub
beq $v0, $s3, nmult
beq $v0, $s4, exit

#addition.
nadd: li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
add $t0, $t0, $v0
add $s0, $t0, $zero #setting the result into $s0.
j opcode

#subtraction.
nsub: li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
sub $t0, $t0, $v0
add $s0, $t0, $zero #setting the result into $s0.
j opcode

#multiplication.
nmult: li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
mult $t0, $v0
mflo $a1 #setting the lo register into $a1.
mfhi $a2 #setting the hi register into $a1.
j integrity #checking if the mult result is correct.
good: add $t0, $a1, $zero #setting the result in $t0.
add $s0, $a1, $zero #setting the result in $t0.
j opcode

#for @ operation, printing the final rsult on the screen, in finishing the program.
exit: li $v0, 4
la $a0, eresult
syscall
li $v0, 1
add $a0, $s0, $zero
syscall
j shut

integrity:
li $k0, 0
li $k1, -1
beq $a2, $k0, positive #if hi is 0, it's a positive number.
beq $a2, $k1, negative #if hi is -1 (all bytes are 1...), it's a nagitive number.
j exception #anything else, it's an error.
positive: slt $t8, $a1, $k1 #for positive case, cheking if the MSB byte is 0.
beq $t8, $zero, good #when it's 0 (the number in lo is larger than -1).
j exception #when it's 1 (negative number in lo).
negative: slt $t8, $k0, $a1 #for negative case, cheking if the MSB byte is 1.
beq $t8, $zero, good #when it's 1 (the number in lo is larger than 0).
j exception #when it's 0 (positive number in lo).

#printing error message and then shut.
exception: li $v0, 4
la $a0, eexception
syscall

shut: