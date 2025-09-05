# Programa 2: Soma do ano de nascimento com 2025 
#
# Este programa soma o ano de nascimento definido na seção .data com 2025
# e imprime o resultado.

.data

ano_nascimento: .word 2003
ano_fixo:       .word 2025
msg_soma:       .asciiz "A soma do seu ano com 2025 e: "

.text
.globl main

main:
    # Carrega os valores da memória para os registradores
    lw $t0, ano_nascimento
    lw $t1, ano_fixo

    # Realiza a soma dos valores
    add $s0, $t0, $t1           # $s0 = ano_nascimento + 2025

    # resultado
    # Imprime a mensagem
    li $v0, 4                   # Código do syscall para imprimir string
    la $a0, msg_soma
    syscall

    # Imprime o valor da soma
    move $a0, $s0               # Move o resultado ($s0) para $a0 para impressão
    li $v0, 1                   # Código do syscall para imprimir inteiro
    syscall

    # Finaliza o programa
    li $v0, 10                  # Código do syscall para terminar o programa
    syscall
