# fatorial (recursividade) 
.text
main:
li a0, 6 #numero a ser multiplicado 

jal ra, fatoria #guardamos em ra o primeiro endereço de retorno

mv a0, a0 # guarda o valor em a0 pra printar no console
li a7, 1 # codigo pra printar um inteiro no console
ecall

li a7, 93 # exit
ecall

fatorial:
li t0, 0 # carregado na memória pra fins de comparação
beq a0, t0, base #se a0 (o valor a ser multiplicado for 0) for 0, pule pra o caso base (retorna 1)

addi sp, sp, -8 #abrimos espaço na stack, que cresce de maneira descrescente.
sw ra, 4(sp) #guardamos o endereço de retorno atual, ou seja, endereço de retorno dessa execução no primeiro espaço
sw a0, 0(sp) #guardamos o valor atual de ao (ou o valor a ser multiplicado)

addi a0, a0, -1 #subtraimos 1 desse valor
jal ra, fatorial #chamamos a tag fatorial dnv
#isso resulta na seguinte ação:
#ao executar dnv, o valor de a0, que era 6, virou 5
# então, guardamos o valor 5 e o endereço de retorno da execução
# fazemos isso até chegarmos em 0, que retornará 1.


lw t0, 0(sp) # nos acessamos então o primeiro valor guardado, que na primeira execução será 1, na segunda, 2 , na terceira, 3, e assim por diante
lw ra, 4(sp) #nos carregamos no registrador de endereço de retorno o retorno para acesso das outras multiplicações
#explicação:
# ao carregar o endereço de retorno anterior, nos conseguimos continuar a partir da linha 24 nas outras execuções
# ou seja, vamos realizar as operações até chegarmos no primeiro endereço de retorno, que voltará para a main
# ou seja, vamos acessar 1, carregar 1 na memória
# vamos acessar o endereço de retorno, captado na execução de a0 = 2, e coloca-lo no registrador de retorno
# assim, ao executar o código, vamos realizar as seguintes operações:
# 0 -> retorna 1 -> 1 * >1< (foi armazenado previamente, acessamos por meio de lw e carregamos ele em t0)
# a partir do endereço de retorno que guardamos na stack, vamos voltar pra o local da memória onde 2 e seu endereço de retorno estão guardados. ( que aponta para 3)
# 1 -> 1 * >2< (foi armazenado previamente, acessamos por meio de lw e carregamos ele em t0)
# a partir do endereço de retorno que guardamos na stack, vamos voltar pra o local da memória onde 3 e seu endereço de retorno estão guardados. (que aponta para 4)
# 2 -> 2 * >3< (foi armazenado previamente, acessamos por meio de lw e carregamos ele em t0)
# a partir do endereço de retorno que guardamos na stack, vamos voltar pra o local da memória onde 4 e seu endereço de retorno estão guardados. (que aponta para 5)
# assim por diante...

addi sp, sp, 8 #vamos manualmente avançando o ponteiro pela memória
# o avanço executado aqui vai apontar para a localização do próx núumero.


mul a0, a0, t0 #multiplicação do fatorial 
ret # retorna pra o valor em ra.

base:
li a0, 1
ret