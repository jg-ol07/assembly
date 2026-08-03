.data
vetor1: .word 11,12,13,14,15,16,17,18,19,20
tamanho_max: .word 10
.text
main:
la a0, vetor1 3 # carregando o endereço de vetor1 em a0, pra fazer vetor[i]
la a1,vetor1 # carregando o endereço de vetor 1 para poder fazer vetor1[i+1]
lw a2, tamanho_max # carregando o tamanho do vetor
addi a2, a2, -1 # como nos vamos executar vetor1[i+1], não podemos executar 10 vezes, somente 9
li a3, 2 #valor pra poder fazer o i%2 == 0
li s0, 0 #acumulador
j algoritmo

algoritmo:
lw s1, 0(a0) #carregamos o valor do indice i de vetor (vetor[i])
addi a1, a1, 4 # esse offset serve como forma de pegar o proximo numero
lw s2, 0(a1) # pegamos o valor do indice i+1 de vetor(vetor[i])

rem t0, s0, a3 # isso aqui obtem o valor de i%2 (lembrando que s0 = i)
beq s0, a2, fim # se o indice for igual ao tamanho maximo de execução, pule pro final
beq t0, zero, condicao # se o i%2 == 0 for verdade, va para conficao

add s1, s1, s1 # a[i] = a[i]*2

sw s1, 0(a0) # guardando o resultado no vetor de volta

addi a0, a0, 4 # passando pro prox indice

addi s0, s0, 1 #contador
j algoritmo

condicao:
add s1, s1, s2 # a[i] = a[i] + a[i+1]

sw s1, 0(a0) #guardando o valor

addi a0, a0, 4 # passando pro prox indice

addi s0, s0, 1 # incrementando contador
j algoritmo

fim:
li a7, 10 #exit
ecall