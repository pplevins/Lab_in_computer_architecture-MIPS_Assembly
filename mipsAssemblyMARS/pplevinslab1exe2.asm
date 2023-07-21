## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 1 exercise 2

##setting the source address in a label, and set the values for the check in it.
.data 0x10010000
memsource:
.word 10, 11, -115, 13, 111, 15, 0

##setting the destination address for the copying.
.data 0x10010020
memdestin:

.text
la $a0 memsource ##veriable of the source address.
la $a1 memdestin ##veriable of the destination address.
li $t0 0 ##the sum of the values.
li $t2 99 ##for the integrity check.
li $t3 -99 ##for the integrity check.

loop:
lw $t1, 0($a0) ##loading the value from the memory to the register.
addi $a0, $a0, 4 ##moving to the next address.
slt $t4, $t1, $t2 ##integrity check (x < 99)
beq $t4, $zero, loop ##if (x > 99) ignore it and go to the next value.
slt $t4, $t3, $t1 ##integrity check (x > -99)
beq $t4, $zero, loop ##if (x < -99) ignore it and go to the next value.

add $t0, $t0, $t1 ##summing the values.
beq $t1, $zero, exit ##exiting when the copied value is 0.
j loop

exit:
sw $t0, 0($a1) ##copy the value and storing it in the destination adrress.
