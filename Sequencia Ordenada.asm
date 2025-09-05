# Programa 1: Ordenação de uma sequência de números (Bubble Sort)
#
# Este programa ordena o array 'sequencia' em ordem crescente e
# imprime o resultado na tela.

.data
sequencia:      .word 4, 3, 9, 5, 2, 1   # Sequência original de números
tamanho:        .word 6                  # Número de elementos na sequência
espaco:         .asciiz " "              # String para imprimir um espaço entre os números
msg_inicial:    .asciiz "Sequencia Original: 4 3 9 5 2 1\n"
msg_final:      .asciiz "Sequencia Ordenada: "

.text
.globl main

main:
    #mensagem inicial
    li $v0, 4                   # Código do syscall para imprimir string
    la $a0, msg_inicial         # Carrega o endereço da mensagem inicial
    syscall

    # Início do Algoritmo Bubble Sort
    la $s0, sequencia           # Carrega o endereço base do array em $s0 (ponteiro)
    lw $s1, tamanho             # Carrega o tamanho do array em $s1

    # Loop externo (i = 0 até n-2)
    # Controla quantas passagens completas faremos sobre o array.
    li $t0, 0                   # Inicializa o contador 'i' em $t0
    addi $s2, $s1, -1           # Limite para o loop externo (n-1)

for_externo:
    beq $t0, $s2, fim_sort      # Se i == (n-1), o sort terminou

    # Loop interno (j = 0 até n-i-2)
    # Percorre o array comparando e trocando os elementos.
    li $t1, 0                   # Inicializa o contador 'j' em $t1
    sub $s3, $s2, $t0           # Limite para o loop interno (n-1-i)
    la $s0, sequencia           # Reinicia o ponteiro para o início do array a cada passagem

for_interno:
    beq $t1, $s3, fim_interno   # Se j == (n-1-i), termina a passagem atual

    # Carrega os elementos adjacentes array[j] e array[j+1]
    lw $t2, 0($s0)              # Carrega o valor em array[j] para $t2
    lw $t3, 4($s0)              # Carrega o valor em array[j+1] para $t3 (4 bytes de deslocamento)

    # Compara se array[j] > array[j+1]
    ble $t2, $t3, nao_troca     # Se array[j] <= array[j+1], pula a troca

    # Troca os elementos de lugar na memória
    sw $t3, 0($s0)              # Salva o valor de $t3 em array[j]
    sw $t2, 4($s0)              # Salva o valor de $t2 em array[j+1]

nao_troca:
    addi $s0, $s0, 4            # Avança o ponteiro para o próximo elemento (j++)
    addi $t1, $t1, 1            # Incrementa o contador 'j'
    j for_interno               # Volta para o início do loop interno

fim_interno:
    addi $t0, $t0, 1            # Incrementa o contador 'i'
    j for_externo               # Volta para o início do loop externo

fim_sort:
    # resultado
    li $v0, 4                   # Código do syscall para imprimir string
    la $a0, msg_final           # Carrega o endereço da mensagem final
    syscall

    li $t0, 0                   # Zera o contador para o loop de impressão
    la $s0, sequencia           # Carrega o endereço base do array ordenado

loop_impressao:
    beq $t0, $s1, fim_programa  # Se já imprimiu todos os 6 números, termina

    # Imprime o número
    lw $a0, 0($s0)              # Carrega o número do array para $a0
    li $v0, 1                   # Código do syscall para imprimir inteiro
    syscall

    # Imprime um espaço
    li $v0, 4                   # Código do syscall para imprimir string
    la $a0, espaco              # Carrega o endereço do espaço
    syscall

    addi $s0, $s0, 4            # Avança o ponteiro para o próximo elemento
    addi $t0, $t0, 1            # Incrementa o contador
    j loop_impressao

fim_programa:
    li $v0, 10                  # Código do syscall para terminar o programa
    syscall
