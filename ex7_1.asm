.data
a: .word 3
b: .word 4
m: .word 10
n: .word 0
.text
main:
# a0 = a, a1 = b, a2 = m, a3 = n
# para que a gente possa ler/receber o valor que tá dentro de a,b,m e n
# temos que carregar a endreço que eles estão e acessar eles como se fosse um ponteiro
# por isso la t0, a e etc...

la t0, a
lw a0, 0(t0)
la t0, b
lw a1, 0(t0)
la t0, m
lw a2, 0(t0)
la t0, n
lw a3, 0(t0)

jal ra, forma_2
li a7, 10
ecall


# parte de if ( b < m && n < a ) 

#existem duas formas de fazer um if com and
# podemos fazer elas usando a lógica do curto-circuito
# isto é, nos checamos se b > m e se n > a, se for, nos pulamos diretamente para o fim do programa
# ou, podemos fazer usando um comando chamado slt (set less than) que coloca 1 em um registrador se for verdadeiro, e 0 se for falso
# por questões de aprendizado, vou fazer as duas.

forma_1:

li t0, 2
# primeiro, if(b<m)
slt t1, a1, a2
#segundo if(n<a)
slt t2, a3, a0
#aqui que aparece o and
add t1, t1, t2
#se os dois forem verdade, a soma de t1 e t2 vai ser 2.
beq t1, t0, fim_bom 


forma_2:
#essa forma usa a lógica de curto circuito

#se b for maior que m, pule para o final
bgt a1, a2, fim_ruim
# se a for maior que n, pule para o final
bgt a3, a0, fim_ruim
j fim_bom

fim_bom:
mv a3, a1
li t6, 1
li a7, 10
ecall

fim_ruim:
mv a3, a2
li t6, 2
li a7, 10
ecall