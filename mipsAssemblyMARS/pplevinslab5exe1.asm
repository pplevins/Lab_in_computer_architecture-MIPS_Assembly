## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 5 exercise 1

##the solution is:
##the program scaning the data block, and search the first number of the basic code.
##after it's finding it, we scaning the next bytes in inner loop. if the rest numbers are equal to the basic code, the program exiting and outpitting "found".
##if not found, the program returns to the outer loop, and search the first number in the rest of the block.
##if the scan is complete, and there's not the basic code in the block, the program outputs "not found".

.data 0x10010000
block: .byte  3, 5, 8, 1, 1, 2, 3, 4, 5, 6, 9, 1, 4, 3, 4, 8, 3, 8, 1, 3, 4, 5, 56, 45, 22, 10, 3, 6, 7, 1, 0, 99
ecode: .asciiz "ENTER THE CODE:\n"
ecodeis: .asciiz "THE CODE IS: "
efound: .asciiz "\nFOUND!"
enotfound: .asciiz "\nNOT FOUND!"

.data
usermem:

.text
#inserting the casic code
li $t0, 6 #inserting 6 numbers.
la $t1, usermem
li $v0, 4
la $a0, ecode # cout << "enter code"
syscall
cin: beq $t0, $zero, continue1 #if it's inputs 6 numbers.
li $v0, 5
syscall
sb $v0, 0($t1) #storing the number in the memory.
addi $t1, $t1, 1
addi $t0, $t0, -1
j cin

continue1: li $a0, 32 #the size of the block.
la $t0, block

#searching the first number of the basic code in the block.
loopa: la $t1, usermem
lb $t2, 0($t0)
lb $t3, 0($t1)
addi $t0, $t0, 1
beq $t2, $t3, next #if it's found the first, go to the inner loop for the rest of the numbers.
addi $a0, $a0, -1
beq $a0, $zero, notfound #if the scan is complete and not found.
j loopa

next: li $s1, 6
li $s0, 1
addi $t4, $t0, 0
loopb: addi $t1, $t1, 1
lb $t2, 0($t4)
lb $t3, 0($t1)
beq $t2, $t3, continue2
j loopa #if is not equal, return to the outer loop and search.
continue2: addi $t4, $t4, 1
addi $s0, $s0, 1
beq $s0, $s1, found #if the all basic code found in the block.
j loopb

found: jal printcode
li $v0, 4
la $a0, efound
syscall
j exit

notfound: jal printcode
li $v0, 4
la $a0, enotfound
syscall
j exit

printcode: addi $sp, $sp, -16
sw $v0, 12($sp)
sw $a0, 8($sp)
sw $a1, 4($sp)
sw $a2, 0($sp)

la $a0, ecodeis
li $v0, 4
syscall
la $a1, usermem
li $a2, 6
printl: li $v0, 1
lb $a0, 0($a1)
syscall
li $v0, 11
li $a0, ','
syscall
addi $a1, $a1, 1
addi $a2, $a2, -1
beq $a2, $zero, stop
j printl

stop: lw $a2, 0($sp)
lw $a1, 4($sp)
lw $a0, 8($sp)
lw $v0, 12($sp)
addi $sp, $sp, 16
jr $ra

exit: