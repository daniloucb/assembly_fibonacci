# Data segment
.data
msg30: .asciiz "O valor do 30� termo da S�rie de Fibonacci �: "
msg40: .asciiz "O valor do 40� termo da S�rie de Fibonacci �: "
msg41: .asciiz "O valor do 41� termo da S�rie de Fibonacci �: "
msgPhi: .asciiz "O valor da raz�o �urea (phi) �: "

# Text segment
.text
.globl main

main:
    # Calcula o 30� termo da sequ�ncia de Fibonacci
    li $a0, 30       # Passa 30 como argumento para a fun��o
    jal fibonacci    # Chama a fun��o fibonacci
    move $s1, $v0    # Armazena o resultado em $s1

    # Imprime o valor do 30� termo
    li $v0, 4        # C�digo do servi�o de impress�o de string
    la $a0, msg30    # Endere�o da string msg30
    syscall
    li $v0, 1        # C�digo do servi�o de impress�o de inteiro
    move $a0, $s1    # Move $s1 para $a0 para impress�o
    syscall

    # Calcula o 40� termo da sequ�ncia de Fibonacci
    li $a0, 40       # Passa 40 como argumento para a fun��o
    jal fibonacci    # Chama a fun��o fibonacci
    move $s3, $v0    # Armazena o resultado em $s3

    # Imprime o valor do 40� termo
    li $v0, 4        # C�digo do servi�o de impress�o de string
    la $a0, msg40    # Endere�o da string msg40
    syscall
    li $v0, 1        # C�digo do servi�o de impress�o de inteiro
    move $a0, $s3    # Move $s3 para $a0 para impress�o
    syscall

    # Calcula o 41� termo da sequ�ncia de Fibonacci
    li $a0, 41       # Passa 41 como argumento para a fun��o
    jal fibonacci    # Chama a fun��o fibonacci
    move $s2, $v0    # Armazena o resultado em $s2

    # Imprime o valor do 41� termo
    li $v0, 4        # C�digo do servi�o de impress�o de string
    la $a0, msg41    # Endere�o da string msg41
    syscall
    li $v0, 1        # C�digo do servi�o de impress�o de inteiro
    move $a0, $s2    # Move $s2 para $a0 para impress�o
    syscall

    # Calcula a raz�o �urea (phi)
    mtc1 $s2, $f2     # Move o valor de $s2 (F41) para $f2
    mtc1 $s3, $f4     # Move o valor de $s3 (F40) para $f4
    cvt.s.w $f2, $f2  # Converte $f2 de inteiro para ponto flutuante
    cvt.s.w $f4, $f4  # Converte $f4 de inteiro para ponto flutuante
    div.s $f0, $f2, $f4  # $f0 = $f2 / $f4 (phi)

    # Imprime a raz�o �urea (phi)
    li $v0, 4         # C�digo do servi�o de impress�o de string
    la $a0, msgPhi    # Endere�o da string msgPhi
    syscall
    li $v0, 2         # C�digo do servi�o de impress�o de float
    mov.s $f12, $f0   # Move $f0 para $f12 para impress�o
    syscall

    # Fim do programa
    li $v0, 10        # C�digo do servi�o de sa�da
    syscall

# Fun��o para calcular o n-�simo termo da sequ�ncia de Fibonacci
fibonacci:
    # Salva os registradores que ser�o usados
    addi $sp, $sp, -8  # Cria espa�o na pilha
    sw $ra, 4($sp)     # Salva o endere�o de retorno
    sw $a1, 0($sp)     # Salva o argumento n
    
    li $v0, 0          # Inicializa $v0 como 0 (F0)
    li $t1, 1          # Inicializa $t1 como 1 (F1)
    
    beqz $a0, fib_exit # Se n == 0, retorna F0
    beq $a0, 1, fib_one # Se n == 1, retorna F1
    
fib_loop:
    add $t2, $v0, $t1  # t2 = F(n-2) + F(n-1)
    move $v0, $t1      # F(n-1) torna-se F(n-2)
    move $t1, $t2      # F(n) torna-se F(n-1)
    addi $a0, $a0, -1  # Decrementa n
    bnez $a0, fib_loop # Se n != 0, continua no loop
    
    j fib_exit         # Sai da fun��o
    
fib_one:
    move $v0, $t1      # Se n == 1, retorna 1
    
fib_exit:
    lw $ra, 4($sp)     # Restaura o endere�o de retorno
    lw $a1, 0($sp)     # Restaura o argumento n
    addi $sp, $sp, 8   # Libera espa�o na pilha
    jr $ra             # Retorna para o chamador
