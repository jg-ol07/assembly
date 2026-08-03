.data
buffer: .space 9
palavra: .space 9
invertido: .space 9

# descrição detalhada:
# linhas 1-4
# carregamos em diferentes endereços as seguintes variáveis:
# buffer, palavra e invertido, todos ocupando 9 bytes, mas o espaço pode ser maior
# na linha 

.text
main:
# essa parte recebe a string de 9 caracteres inserida no input
la a0, buffer #endereço de buffer sendo carregado em a0
li a1, 9 # tamanho total (contando o caractere nulo)
li a7, 8 # codigo pra ler uma string do console
ecall # abre um pop-up pra ler a string
la a2, invertido # aqui carregamos o endereço onde a string vai ser escrita ao contrário
li t3, 0 # t3, vai ser usado pra armazenar o contador contrário, que vai ser o offset em a2 (o offset é como se fosse um indice)
li s10, 8 # tamanho da palavra
addi t1, a1, -2 #subtrai do tamanho da string -2 pra copiar somente as letras e não o caractere nulo (acessamos o indice 7)
j loop

li a7, 4 #imprime a string que tem o endereço começando em a0.
ecall

loop:
#como é um blt, isso aqui vai executar 8 vezes
#esse loop le a string digitada de tras pra frente e depois escreve no endereço de palavra
blt t1, zero, fim #se o contador de t1 for menor que 0, então pare o loop.

add t2, a0, t1 #vai adicionando o offset que DECRESCE, primeira exec = 7, segunda = 6...
lb s0, 0(t2)
# como as coisas em assembly funcionam por meio da memória, o que nós fazemos é
# pegamos o ponteiro a0 (aponta pra o primeiro indice [0] da palavra que recebemos
# nos então criamos um contador que começa já acessando o ultimo inidice da palavra ind[7]
# adicionamos esse contador ao endereço de memória original, sem sobrescrever o endereço, pois vamos usar mais de uma vez
# e dessa forma, nós vamos acessando os indices

jal ra, troca_letra # isso aqui pula pra a parte do código que troca as letras por maiusculas e minusculas

add t4, a2, t3 # vai adiconando o offset que CRESCE
sb s0, 0(t4)
# aqui nos copiamos o endereço de a2, que tem o primeiro indice ,[0], onde nos vamos copiar a string
# observe que essa parte vem depois da execução de troca_letra, isso significa que o valor que vamos acessar
# em s0 já é modificado pra ser minusculo ou maiusculo
# então copiamos esse valor pra o indice [0] na primeira execução, na segunda vamos para [1], etc...

addi t1, t1, -1 # aqui decrementamos o contador, que diminui
addi t3, t3, 1 # aquii AUMENTAMOS o contador
j loop # executamos o loop denovo até que a linha 31 for verdadeira

troca_letra:
# essa função checa se a eltra é maiuscula, se for, ele troca pra minuscula
# Tabela ASCII: 'A'=65, 'Z'=90, 'a'=97, 'z'=122
li s8, 65  # carregamos os valores em memória para fins de comparação
li s9, 90 # carregamos os valores em memória para fins de comparação
blt s0, s8, checa_minuscula # se a letra atual nao for uma letra, pule para checa...
bgt s0, s9, checa_minuscula # se letra atual for minuscula, pule para checa...
addi s0, s0, 32 # caso ela seja maiuscula, ou seja s0 > 65 e s0 < 90, adicionamos 32 pra transformar em minuscula 
j fim_troca #retorno

checa_minuscula:
# essa função checa se a letra em s0 é minuscula, se for, ele troca pra maiuscula
# Tabela ASCII: 'A'=65, 'Z'=90, 'a'=97, 'z'=122
li s8, 97 # carregamos os valores em memória para fins de comparação
li s9, 122 # //
blt s0, s8, fim_troca # se s0 for maiuscula pule para fim 
bgt s0, s9, fim_troca # se s0 nao for nenhuma letra minuscuila (nao é letra) pule para fim
addi s0, s0, -32 # retire 32 para fazer a letra ser maíuscula
j fim_troca #ret

fim_troca:
ret

fim:
add t4, a2, t3 # como terminamos com 8 no final, acessamos o indice 8 e colocamos o caractere nulo
sb zero, 0(t4)# termina a string invertida com \0


mv a0, a2 #movemos o endereço da string a2 para a0, para que possamos imprimir
li a7, 4
ecall # imprime a string invertidal

li a7, 93 #sai do programa
ecall
