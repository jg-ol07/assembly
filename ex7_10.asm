.data
A: 
.word 10 ,20 ,30 ,40 ,50
.space 380
B: 
.word 5, 15, 25, 35, 45
.space 380
C:
.word 5

tamanho_max: .word 100
.text
main:
la a0, A # carregando o endereço de A
la a1,B # carregando o endereço de B
lw a2, C # carreagando o valor de c
lw a3, tamanho_max # carreagndo o numero max de execuções


li s0, 0 #zerando nosso contador
j algoritmo

algoritmo:
lw s1, 0(a0)
lw s2, 0(a1)
beq s0, a3, fim #se o contador for = valor max, parar
blt s1, s2, condicao # se A[i] < B[i]
bne s1, zero, condicao # se A[i] == 0

li s1, 0 # zerando A[i]
sub s1, s2, a2 # A[i] = B[i] - C 
sw s1, 0(a0) #guardando o valor no mesmo lugar

addi a0, a0, 4 # passando pro prox numero
addi a1, a1, 4 # passando pro prox numero
addi s0, s0, 1 #incrementando o contador
j algoritmo
condicao:
li s1, 0 # zerando A[i]
add s1, s2, a2 # A[i] = B[i] + C

sw s1, 0(a0) # Guardando esse valor

addi a0, a0, 4 # passando pro prox numero
addi a1, a1, 4 # passando pro prox numero
addi s0, s0, 1 # incrementando contador

j algoritmo

fim:
li a7, 93
ecall