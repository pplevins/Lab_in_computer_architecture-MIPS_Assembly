## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 4

.data
evalue: .asciiz "\nENTER VALUE: "
eopcode: .asciiz "\nENTER OP CODE:"
eresult: .asciiz "\nthe result is: "

.text
j main

sum: add $v0, $v0, $a1 #the sum function.
jr $ra

multi: addi $sp, $sp, -24
sw $t3, 20($sp)
sw $t2, 16($sp)
sw $a1, 12($sp)
sw $t1, 8($sp)
sw $t0, 4($sp)
sw $ra, 0($sp)

slt $t3, $a1, $zero
beq $t3, $zero, continue1 #check if it's a negative number.
sub $a1, $zero, $a1 #Makes the number positive.
continue1: add $t2, $a1, $zero #setting the number of loops according the multiplier in $a1.
li $t0, 1
add $a1, $a0, $zero #moving the doubled number to the added argument (3+3=3*2).
loopa: addi $t0, $t0, 1 
jal sum #adding the number in $a0 by itself.
slt $t1, $t0, $t2
beq $t1, $zero, exitloopa
j loopa
exitloopa: beq $t3, $zero, continue2 #if it's negative number, we need to reverse the result to the opposite.
sub $v0, $zero, $v0

continue2: lw $ra, 0($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
lw $a1, 12($sp)
lw $t2, 16($sp)
lw $t3, 20($sp)
addi $sp, $sp, 24
jr $ra

power: addi $sp, $sp, -20
sw $t2, 16($sp)
sw $a1, 12($sp)
sw $t1, 8($sp)
sw $t0, 4($sp)
sw $ra, 0($sp)

add $t2, $a1, $zero #setting the number of loops according the power in $a1.
li $t0, 1
add $a1, $v0, $zero
loopb:
addi $t0, $t0, 1
jal multi
add $a0, $v0, $zero #setting $a0 to be the result of the last iteration, so it will do mult on the result.  
slt $t1, $t0, $t2
beq $t1, $zero, exitloopb
j loopb
exitloopb:

lw $ra, 0($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
lw $a1, 12($sp)
lw $t2, 16($sp)
addi $sp, $sp, 20
jr $ra

main:
li $t1, '+'
li $t2, '*'
li $t3, '^'

li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
add $t0, $v0, $zero

li $v0, 4
la $a0, eopcode
syscall
li $v0, 12
syscall

beq $v0, $t1, nadd
beq $v0, $t2, nmult
beq $v0, $t3, npower

nadd: li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
add $a0, $t0, $zero #setting the first number in an argument.
add $a1, $v0, $zero #setting the second number in an argument.
add $v0, $a0, $zero  #setting the first number in an result register.
jal sum #calling the function.
j result

nmult: li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
add $a0, $t0, $zero
add $a1, $v0, $zero
add $v0, $a0, $zero
beq $a1, $zero, zeroo #if the number is 0.
jal multi #calling the function.
j result

npower: li $v0, 4
la $a0, evalue
syscall
li $v0, 5
syscall
add $a0, $t0, $zero
add $a1, $v0, $zero
add $v0, $a0, $zero
beq $a1, $zero, zeropower #if the power is zero.
jal power #calling the function.
j result

zeroo: li $v0, 0 # a * 0 = 0
j result

zeropower: li $v0, 1 # a ^ 0 = 1

result: add $t0, $v0, $zero
li $v0, 4
la $a0, eresult
syscall
li $v0, 1
add $a0, $t0, $zero
syscall
