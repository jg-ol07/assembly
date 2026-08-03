.data
n: .word 9 # valor de n
s: .word 3 #valor de s
comb: .word 0 #onde o resultado vai ser guardado

.text
main: 
lw a0, n # valor de n sendo carregado no registrador
lw a1, s # valor de s sendo carregado no registrador
la a2, comb # endereço de comb pra acessos futuros
sub a3, a0, a1 # (n-s) que vai ser calculado depois
bgt a1, a0, s_maior_n # se s for maior que n, tem codigo de saida 1
bltz a0, menor_zero # se n ou s for menor que zero, o codigo de saida é 2
bltz a1, menor_zero # se n ou s for menor que zero, o codigo de saida é 2
beq a0, a1, iguais # se n e s forem iguais, o código de saída é 3
beqz a1, igual_zero # se n ou s for igual a 0, o código de saída é 4
beqz a1, igual_zero # se n ou s for igual a 0, o código de saída é 4
add s0, zero, a0 # carregando o valor de a0 em s0, porque s0 é onde vai ser operado o fatorial
jal fatorial

add s1, s0, zero # guardando o valor de n!
li s0, 0 # zerando s0
add s0, zero, a1 # carregando o valor de s em s0

jal fatorial

add s2, s0, zero # guardando o valor de s!
li s0, 0 # zerando
add s0, zero, a3 # carregando o valor de (n-s)

jal fatorial

add s3, s0, zero #guardando o valor de (n-s)!

mul s0, s2, s3 #s! * (n-s)!
div s0, s1, s0 #n!/s! * (n-s)!

mv a0, s0 # carregando o resultado pra exibir ele no console
sw a0, 0(a2) # carregando o resultado em comb
j saida

fatorial:
beqz s0, fato_base # se for 0, vá para o caso base
addi sp, sp, -8 # stack
sw ra, 4(sp)
sw s0, 0(sp)

addi s0, s0, -1 #(n-1)

jal fatorial

lw t0, 0(sp) # carrega o valor anterior
lw ra, 4(sp) # carrega o endereço de retorno

mul s0, s0, t0 # n*(n-1)

addi sp, sp, 8 # fechando stack
ret

fato_base:
li s0, 1
ret

s_maior_n:
li a0, 1
j saida

menor_zero:
li a0, 2
j saida

iguais:
li a0, 3
j saida

igual_zero:
li a0, 4
j saida

saida:
li a7, 1
ecall

li a7, 93
ecall