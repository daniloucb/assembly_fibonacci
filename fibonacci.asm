# Data segment
.data
msg30: .asciiz "O valor do 30° termo da Série de Fibonacci é: "
msg40: .asciiz "O valor do 40° termo da Série de Fibonacci é: "
msg41: .asciiz "O valor do 41° termo da Série de Fibonacci é: "
msgPhi: .asciiz "O valor da razão áurea (phi) é: "

# Text segment
.text
.globl main

main:
    # Calcula o 30º termo da sequência de Fibonacci
    li $a0, 30       
    jal fibonacci   
    move $s1, $v0    

    # Imprime o valor do 30º termo
    li $v0, 4       
    la $a0, msg30    
    syscall
    li $v0, 1        
    move $a0, $s1   
    syscall

    # Calcula o 40º termo da sequência de Fibonacci
    li $a0, 40      
    jal fibonacci    
    move $s3, $v0    

    # Imprime o valor do 40º termo
    li $v0, 4        
    la $a0, msg40    
    syscall
    li $v0, 1        
    move $a0, $s3    
    syscall

    # Calcula o 41º termo da sequência de Fibonacci
    li $a0, 41       
    jal fibonacci    
    move $s2, $v0    

    # Imprime o valor do 41º termo
    li $v0, 4        
    la $a0, msg41   
    syscall
    li $v0, 1        
    move $a0, $s2    
    syscall

    # Calcula a razão áurea (phi)
    mtc1 $s2, $f2     
    mtc1 $s3, $f4     
    cvt.s.w $f2, $f2  
    cvt.s.w $f4, $f4  
    div.s $f0, $f2, $f4  # $f0 = $f2 / $f4 (phi)

    # Imprime a razão áurea (phi)
    li $v0, 4         
    la $a0, msgPhi    
    syscall
    li $v0, 2         
    mov.s $f12, $f0   
    syscall

    li $v0, 10        
    syscall

fibonacci:
    addi $sp, $sp, -8  
    sw $ra, 4($sp)     
    sw $a1, 0($sp)     
    
    li $v0, 0          
    li $t1, 1         
    
    beqz $a0, fib_exit 
    beq $a0, 1, fib_one 
    
fib_loop:
    add $t2, $v0, $t1  
    move $v0, $t1  
    move $t1, $t2     
    addi $a0, $a0, -1  
    bnez $a0, fib_loop 
    
    j fib_exit         
    
fib_one:
    move $v0, $t1      
    
fib_exit:
    lw $ra, 4($sp)     
    lw $a1, 0($sp)     
    addi $sp, $sp, 8   
    jr $ra            
