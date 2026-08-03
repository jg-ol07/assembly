.data
vetor: .word 11,12,13,14,15,16,17,18,19,20
tamanho_max: .word 10
.text
main:
li s0, 0 # contador
lw a1, tamanho_max #carrega o tamanho do vetor
la a2, vetor #carrega o endereço do vetor
j loop_converte # vai pro loop

loop_converte:

beq s0, a1, fim # se s0, for igual ao tamanho do vetor
lw s1, 0(a2) # carregando o o valor de vetor[s0]
addi s1, s1, 1 # incrementando mais um no valor atual
sw s1, 0(a2) #guardado o valor incrementado no mesmo lugar

addi a2,a2,4 #pulando 4 bytes porque esse é o tamanho da word
#IMPORTANTE:
# tem que lembrar dessas coisas na prova,de que cada tipo de data tem um tamanho diferente

addi s0, s0,1 # aumentando o contador

j loop_converte #loop

fim:
li a7, 93 #exit
ecall