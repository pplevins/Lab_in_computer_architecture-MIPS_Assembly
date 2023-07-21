## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 1 exercise 1

##setting the source address for the copying in a label, and set the values in it.
.data 0x10010000
memsource:
.word 10, 11, 12, 13, 14, 15, 16

##setting the destination address for the copying.
.data 0x10010020
memdestin:

.text
la $a0 memsource ##veriable of the source address.
la $a1 memdestin ##veriable of the destination address.
li $t0 0 ##the counter of the copies.

loop:
lw $t1, 0($a0) ##loading the copied value to the register.
sw $t1, 0($a1) ##copy the value and storing it in the destination 
addi $a0, $a0, 4 ##moving to the next address.
addi $a1, $a1, 4 ##moving to the next address.
beq $t1, $zero, exit ##exiting when the copied value us 0.
addi $t0, $t0, 1 ##counting the copies (not including the last copy of the 0).
j loop

exit:
