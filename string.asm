#aluno: Pedro Figueira Bôa-Viagem
.text


strlen: #recebe uma string e conta a quantidade de caracteres (usa t0,t1,t2)
	
	addi $t2, $0, 0 #contador
	loop_strlen:                 
		add $t0, $t2, $a0 #soma o endereço do caractere atual com o contador para pegar o próximo caractere
		lb $t1, 0($t0) #t1 = caractere atual
		beq $t1, $0, fim_strlen #pula para o fim se caractere = '/0'
		addi $t2, $t2, 1 #adiciona mais 1 ao contador (s0)
		j loop_strlen #reinicia o loop
	fim_strlen:
	addi $t2, $t2, -1 #tira 1 do contador
	addi $v0, $t2, 0 #move contador para $v0
	jr $ra #volta para o programa principal
		
		
strcmp: #recebe dois endereços de string, retorna -1 se a primeira recebida é maior, 1 se a
# segunda recebida é maior e retorna 0 se as strings forem iguais (usa s0,s1,t0)

	#ajustar a pilha para acomodar os valores, salva s0 e ra (já que chama função folha)
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	#roda strlen com o a0 (primeira string)
	jal strlen
	#salva o valor retornado em $t0
	addi $s0, $v0, 0
	
	#roda strlen com o a1 (em a0)
	addi $a0, $a1, 0
	jal strlen
	#salva o valor retornado em $t1
	addi $s1, $v0, 0
	
	bne $s0, $s1, else_strcmp #se não for igual checar qual é maior (ir para else)
	addi $v0, $0, 0 #retorna 0 se valores iguais
	j fim_strcmp
	
	else_strcmp:
		slt $t0, $s0, $s1 #se s0<s1, t0 = 0
		beq $t0, $0, esquerda_maior
		addi $v0, $0, -1 #retorna -1 se valor da direita é maior
		j fim_strcmp
		
	esquerda_maior:
		addi $v0, $0, 1 #retorna -1 se direita maior

	fim_strcmp:
	lw $s1, 0($sp)
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra #volta para o programa principal
		
		
strcat: #recebe 2 strings e concatena a segunda no final da primeira
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	jal strlen #retorna tamanho da primeira string (a0)
	addi $s0, $v0, 0 #salva o tamanho da primeira em s0
	
	add $s0, $s0, $a0 #vai ao final da primeira string
	
	lb $s1, 0($a1) #carrega o primeiro caractere da segunda string
	sb $s1, 0($s0) #salva o primeiro caracter da segunda string no '/0' da primeira
	
	loop_strcat: 
		addi $s0, $s0, 1 #proximo byte da string 1
		addi $a1, $a1, 1 #proximo byte da string 2
		
		lb $s1, 0($a1) #proxima letra da string 2
		beq $s1, $0, fim_strcat #checa se caracter é igual a '/0', se sim ir ao fim
		sb $s1, 0($s0) #salva caractere no posição atual da string 1
		j loop_strcat
		
	fim_strcat:
	sb $0, 0($s0) #salva '/0' no final da string 1
	addi $v0, $a0, 0 #retorna a string 1 alterada
			
	lw $s1, 0($sp)
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra #volta ao programa principal
	
	
strncat: #recebe 2 strings e concatena a segunda em n caracteres no final da primeira
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	jal strlen #retorna tamanho da string 1
	addi $s0, $v0, 0 #carrega tamanho de string 1 em s0
	
	add $s0, $s0, $a0 #endereço do último caractere de string 1 em s0
	
	beq $a2, $0, fim_strncat #se a string 2 == '/0', ir ao fim
	lb $s1, 0($a1) #carrega o primeiro caractere da string 2
	sb $s1, 0($s0) #salva o primeiro caracter da string 2 no '/0' da string 1
	
	addi $a2, $a2, -1 #subtrai 1 de n pois contador começa em 0
	addi $t0, $0, 0 #contador
	loop_strncat:
		addi $s0, $s0, 1 #proximo byte
		addi $a1, $a1, 1 #proximo byte
		
		lb $s1, 0($a1) #proxima letra da string 2
		beq $t0, $a2, fim_strncat #checa se contador == n (tamanho para copiar)
		sb $s1, 0($s0) #salva caractere no final de s0
		addi $t0, $t0, 1 #contador +1
		j loop_strncat
		
	fim_strncat:
		
	sb $0, 0($s0) #salva '/0' no final da string
	addi $v0, $a0, 0 #retorna a string 1 alterada
			
	lw $s1, 0($sp)
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
	
strncpy: #recebe 2 strings e copia n elementos de string 2 no inicio da string 1
	
	addi $t0, $0, 0 #contador = t0
	loop_strncpy: #só para qnd contador == n
		beq $t0, $a2, fim_strncpy #se n == 0, ir ao fim
		
		lb $t1, 0($a1) #carrega letra de string 2
		sb $t1, 0($a0) #coloca letra em string 1
	
		addi $a1,$a1, 1 #proximo byte
		addi $a0, $a0, 1 #proximo byte
		addi $t0, $t0, 1 #contador++
		j loop_strncpy
	
	fim_strncpy:
	mul $t0, $t0, -1 #multiplica contador por -1 para voltar para inicio da string 1
	add $a0, $a0, $t0 #volta, com o -contador, para o inicio da string

	addi $v0, $a0, 0 #carrega nova string 1 em v0

	jr $ra
