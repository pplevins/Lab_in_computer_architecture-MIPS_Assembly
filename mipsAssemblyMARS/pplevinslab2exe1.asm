## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 2 exercise 1

.data 0x10010000
memsource:
.byte 3, 2, -3, 130, 1 #the given data for the program

.text
la $a0, memsource #setting the starting address in $a0.
li $a1, 5 #setting the givan data length in $a1.
li $a2, 0 #initializing the loop counter register.
li $v0, 0 #initializing the result register.

loop: lb $t1, 0($a0)
addi $a0, $a0, 1 #Promoting the address to the next value address.
slt $t4, $v0, $t1 #checking if the new value in $t1 is bigger than the last saved value.
beq $t4, $zero, count #if smaller, skip on the following command, and go to "count".
add $v0, $t1, $zero #if biggar, update the saved value to the larger.

count: addi $a2, $a2, 1 #promoting the loop counter.
beq $a1, $a2, exit #if the counter reached to the values amount of the data, go to "exit".
j loop

exit: addi $a0, $v0, 0 #moving the saved number to $ao for the print.
li $v0, 1 #command for printing int.
syscall #print the result.
