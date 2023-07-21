## Pinchas Plevinski 322211558
## Lab in Computer Architecture
##lab 3 exercise 1

.data 0x10010000
memsource:
.word 3, 6, 1, 4, 5, 7, 2

.text
li $a1, 7 #lentgh of the data.
li $s0, 1 #veriable "i" of the outer loop.
bubblesort: la $a0, memsource #loading the data address in $a0.
li $s1, 1 #veriabke "j" of the inner loop.
sub $a2, $a1, $s0 #lentgh for the inner loop (n - i)

#the inner loop.
swaploop: lw $t0, 0($a0) #loading the first element.
lw $t1, 4($a0) #loading the second element.
slt $s2, $t1, $t0 #checking how is larger (arr[j] > arr[j + 1]).
beq $s2, $zero, skipswap #if $t0 is smaller then skip the following swap.
#swapping the elements.
sw $t1, 0($a0) 
sw $t0, 4($a0)
skipswap: addi $a0, $a0, 4 #moving to the next address.
addi $s1, $s1, 1 #j++
slt $s2, $a2, $s1 #if (j < n - i)
beq $s2, $zero, swaploop #if j smaller, continuing the loop.

addi $s0, $s0, 1 #i++
slt $s2, $a1, $s0 #if (i < n)
beq $s2, $zero, bubblesort #if i smaller, continuing the loop.

la $a2, memsource #placing the address of the first element in $a2 for the print. 
li $s0, 1 #i = 1
print: lw $a0, 0($a2) #loadint the element for the print.
li $v0, 1 
syscall
li $a0, ','
li $v0, 11
syscall
addi $a2, $a2, 4 #moving to the next element address.
addi $s0, $s0, 1 #i++
slt $s2, $a1, $s0
beq $s2, $zero, print
