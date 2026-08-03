.data
original: .space 6
letra1: .space 2
letra2: .space 2
.text
main:
li t1, 65 # ascii 65 = 'A'
li t2, 122 # ascii 122 = 'z'
la a0, original # carregamos o endereço da string, para que possamos receber a string
li a1, 6 # tamanho máximo (5)
li a7, 8 # código pra receber uma string do console
ecall
la s0, original # salvamos a string que recebemos em s0

la a0, letra1 # carregando o endereçode letra1 pra receber a letra a ser substituir
li a1, 2 # tamanho máx (1)
ecall
la s1, letra1 # letra que vamos usar pra checar

lb t0, 0(a0) # carregando a letra pra ver se ela tá entre 'A' e 'z'
blt t0, t1, invalido # se estiver fora do range, invalido
blt t2, t0, invalido # se estiver fora do range, invalido

la a0, letra2 #carregando o endereço de letra2 pra receber a letra que vai substituir letra1
ecall
la s2, letra2 #salvando na memória

lb t0, 0(a0) # checando se ela ta dentro do range
blt t0, t1, invalido # se estiver fora do range, invalido
blt t2, t0, invalido # se estiver fora do range, invalido

li a0, 0 #zerando a0
j loop

loop:
lb t0, 0(s0) # endereço da string
lb t1, 0(s1) # endereço da letra1
lb t2, 0(s2) # endereço de letra2
beq t0, zero, valido # se a letra atual for '\0', parar
bne t0, t1, prox # se a letra não for a que estamos procurando, pular pra a próxima

li t0, 0 #limpando t0
add t0, t0, t2 #carregando a letra que vamos substituir em t0
sb t0, 0(s0) # salvando ela na string
#IMPORTANTE:
#como não há nenhum retorno, a execução desse loop quando substituimos a letra cai dentro de PROX
# que passa a letra de forma normal
prox:
addi s0,s0, 1 # passa pra a próxima letra por meio de um offset
j loop #loop

valido:
la a0, original # carregando o endereço da string em a0 pra poder imprimir no consolel
li a7, 4 # codigo pra imprimir string
ecall
j fim

invalido:
li a0, 1 # se for invalido mostra 1 no console
li a7, 1
ecall
j fim
fim:

li a7, 93 #exit
ecall 


