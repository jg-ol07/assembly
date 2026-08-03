.data
num1: .word -10 #n a ser multiplicado
num2: .word 20 #n de vezes multiplicando
result: .word 0 #resultado

.text
main:
la s0, num1 # carregando o num1 para o registrador
la s1, num2 #carregando o num2 pra o registrador
la s2, result #carregando result para o reg
lw a0, 0(s0) # lendo o que tem em num1 e colocando em a0
lw a1, 0(s1) # lendo o que tem em num2 e colocando em a1
mv a2, a1 #copiando o valor de um deles para a a2
blt a2, zero, negativo #se a2 for negativo, pular para negativo
jal ra, loop
j fim

fim:
sw a3, 0(s2)
lw a0, 0(s2)
li a7, 1
ecall

li a7, 93
ecall

loop:
beq a2, zero, fim_loop
add a3, a3, a0
addi a2, a2, -1
j loop

fim_loop:
ret

negativo:
neg a2, a2 #invertemos o sinal de a2 ex: -20 -> 20
jal ra, loop #executamos o loop
neg a3, a3 #como o resultado tem que ser negativo, invertemos o valor do resultado
j fim #voltamos a main