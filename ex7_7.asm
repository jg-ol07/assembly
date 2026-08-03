.data
vetorx: .space 64
numerosDe1: .string "0"
.text
main:
la a2, numerosDe1 # carrega o endereço da string que vamos escrever
li a1, 65 # numero máximo de caracteres que podemos inscrever no input, contando com "\0"
la a0, vetorx # endereço de onde vamos escrever

li a7, 8 #codigo pra receber uma string de input
ecall 

j contador

contador:
lbu t1, 0(a0) # carregamos o caractere atual como ascii
beq a1, zero, fim # se o contador regressivo for 0, isto é, executamos esse loop 64 vezes, pule para o fim

li t0, 49 # carregamos o valor de 1 na tabela ascii, '1' = 49, a fins comparativos
bne t1, t0, prox # caso o caractere atual não seja 1, pula pra o proximo
addi s0, s0, 1 # se for 1, então contamos ele, por meio de uma adição a s0
#IMPORTANTE:
# uma das dificuldades que eu enfrentei quando fiz esse codigo é de que por ex, eu nao podia fazer uma funçaõ chamada contar e depois retornar
# a execução de contador, então, a solução que eu procurei e encontrei é
# fazer um desvio que pule o contador dentro de contador, dentro desse desvio, temos um j contador, que retorna para a prox execução
# desse algoritmo.
# IMPORTANTE 2:
# pela logica que eu usei, o contador que diminui teve que ficar dentro de prox , porque perceba o seguinte:
# ao passar pela condicional sem ativar ela, nao temos nenhum return, então nos fazemos o seguinte caminho:
# contador(executa passando pela condicional)  e caimos em prox:, justamente por não haver return, então nos executamos e adicionamos o offset também
# nós só não vamos adicionar o valor 1 ao contador de numeros 1.

prox:
addi a1, a1, -1 #retira um do contador regressivo
addi a0,a0, 1 # adiciona 1 ao offset para que possamos acessar o proximo numero em vetorx
j contador #volta para contador para uma nova execução com um novo número

fim:
# guarda o valor em numerosDe1 e imprime a quantidade no console.
sb s0, 0(a2) #guardando em numerosDe1
li a0, 0 # zerando a0
add a0,a0,s0 # carregando s0 (resultado da contagem) em a0
li a7, 1 #codigo pra imprimir um inteiro
ecall

li a7, 93 #saida
ecall