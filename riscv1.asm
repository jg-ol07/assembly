# questão 4 - calculando valor absoluto.
li t0, -50
bgez t0, end0
sub t1, zero, t0
j end0

end0:
mv t0, t1
li t1, 0

# questão 5 - verificar se um numero é par bit a bit
li t0, 20
li t1, 2
rem t2, t0, t1 # literalmente modulo
beqz t2, end1

end1:
li t1, 0
# metodo alternativo 
andi t2, t0, 1 #todo numero impar tem o primeiro bit 1 invés de zero, quando comparamos bit a bit, conseguimos saber se o ultimo bit é 1, se ambos os bits forem 1, o final deles é 1, e então é ímpar 
beqz t2, end2 

end2:
li t2, 0