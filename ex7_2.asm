.data
A: .word 0
B: .word 10
X: .word 0

.text
main:
# carregando as variaveis nos registradores
la t0, A
lw a0, 0(t0)
la t0, B
lw a1, 0(t0)
la t0, X
lw a2, 0(t0)
j if

if:
# if ( a >= 0 && b <= 50 )
# usando a lógica de curto circuito, fazemos a comparação
li t1, 50
# se a for menor que 0, pule pra fim_ruim
blt a0, x0, fim_ruim
# se b for maior que 50, pule para fim_ruim
bgt a1, t1, fim_ruim

j fim_bom

fim_ruim:
li a7, 10
ecall

fim_bom:
li a2, 1
li a7, 10
ecall