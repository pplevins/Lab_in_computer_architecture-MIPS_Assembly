## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 5 exercise 2

.data
evalue: .asciiz "\nENTER VALUE: "
einput: .asciiz "\nINPUT= "
eoutput: .asciiz " RESULT= "
eerror: .asciiz "ERROR!\n"

.data 0x10010040
memsource:

.text
la $s0, memsource
li $t4, 49 #hex = 0x31
li $t5, 48 #hex = 0x30
li $t6, 72 #hex = 0x48
li $t7, 116 #hex = 0x74
begin: li $v0, 4
la $a0, evalue # cout << enter value
syscall
li $v0, 5
syscall
beq $v0, $zero, exit #if the input is 0 exit the program.
sw $v0, 0($s0) #storing the input in the memory.
lb $t0, 3($s0) #loading the MSB byte for the op-code.
beq $t0, $t4, ones #for 0x31 changing the required bits to 1.
beq $t0, $t5, zeros #for 0x30 changing the required bits to 0.
beq $t0, $t6, flip #for 0x48 fliping the 8-15 bits.
beq $t0, $t7, shift #for 0x74 shifting the number left accroding the value of 20....24 bits (bit 24 is always 0 because the 74 op-code).
li $v0, 4 #if it's wrong op-code, "cout << "error""
la $a0, eerror
syscall
j begin #asking for new input.

ones: lw $t0 0($s0)
li $t1 195 #bin = 0000 1100 0011
or $t2, $t1, $t0 #setting bits 0,1,6,7 to be 1.
j print

zeros: lw $t0 0($s0)
li $t1 -196 #bin = 1111 0011 1100
and $t2, $t1, $t0 #setting bits 0,1,6,7 to be 0.
j print

flip: lw $t0 0($s0)
li $t1 65280 #hex = 0000ff00
xor $t2, $t1, $t0 #fliping the 8-15 bits.
j print

shift: lbu $t0, 2($s0) #loading the 16-23 bits to the register (bit 24 is always 0 because the 74 op-code).
li $t1, 16
div $t0, $t1 #shifting the number right and getting the results of bits 20-23 in lo register.
mflo $t1
lw $t2, 0($s0)
loop: beq $t1, $zero, print
sll $t2, $t2, 1 #shifting the number 1 bit left
addi $t1, $t1, -1
j loop

print: li $v0, 4
la $a0, einput
syscall
lw $a0, 0($s0)
#li $v0, 1
li $v0 34 #printing in hexadecimal base
syscall
li $v0, 4
la $a0, eoutput
syscall
addi $a0, $t2, 0
#li $v0, 1
li $v0 34 #printing in hexadecimal base
syscall
j begin #asking for new input.

exit: