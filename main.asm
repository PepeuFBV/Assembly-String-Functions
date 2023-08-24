.include "string.asm"
.globl main

.data
	msg_inicial: .asciiz "Bem vindo ao programa de teste das funções de string.asm, programa feito por Pedro Figueira"
	entrada1: .space 16
	entrada2: .space 16
	n: .word 3
	msg: .asciiz "\n[0] - Sair\n[1] - strlen\n[2] - strcmp\n[3] - strcat\n[4] - strncat\n[5] - strncpy\n--> "
	msg_1: .asciiz "Insira a string 1: "
	msg_2: .asciiz "Insira a string 2: "
	msg_3: .asciiz "Insira n: "
	espaco: .asciiz "\n"
	
.text
	main:
	li $v0, 4
	la $a0, msg_inicial
	syscall
		
	loop_main:
		#imprime um pulo de linha
		li $v0, 4
		la $a0, espaco
		syscall
	
		#imprime lista de opções
		li $v0, 4
		la $a0, msg
		syscall
		
		#ler inteiro (em $a0)
		li $v0, 5
		syscall
		addi $s0, $v0, 0 #s0 contém inteiro lido
	
		addi $s1, $0, 1 #inicia contador para opções (começa em 1)
		beq $s0, $0, fim #se input == 0, sair
		beq $s1, $s0, chama_strlen
		addi $s1, $s1, 1 #contador++
		beq $s1, $s0, chama_strcmp
		addi $s1, $s1, 1
		beq $s1, $s0, chama_strcat
		addi $s1, $s1, 1
		beq $s1, $s0, chama_strncat
		addi $s1, $s1, 1
		beq $s1, $s0, chama_strncpy
	
	chama_strlen:

		#imprime mensagem pedindo a string
		li $v0, 4
		la $a0, msg_1
		syscall
		
		#le string do usuário
		li $v0, 8
		la $a0, entrada1 #onde ficará a string
		addi $a1, $0, 16
		syscall
		
		la $a0, entrada1 #coloca o endereço da string lida em a0
		jal strlen #chama strlen
		addi $a0, $v0, 0 #move resultado para s0
		
		li $v0, 1
		syscall
		
		j loop_main
		
	chama_strcmp:
		
		#imprime mensagem pedindo a string 1
		li $v0, 4
		la $a0, msg_1
		syscall
		
		#le string 1 do usuário
		li $v0, 8
		la $a0, entrada1 #onde ficará a string 1
		addi $a1, $0, 16
		syscall
		
		#imprime mensagem pedindo a string 2
		li $v0, 4
		la $a0, msg_2
		syscall
		
		#le string 2 do usuário
		li $v0, 8
		la $a0, entrada2 #onde ficará a string 2
		addi $a1, $0, 16
		syscall
		
		la $a0, entrada1 #coloca o endereço da string 1 lida em a0
		la $a1, entrada2 #coloca o endereço da string 2 lida em a1
		jal strcmp #chama strcmp
		addi $a0, $v0, 0 #move resultado para a0
		
		li $v0, 1
		syscall
		
		j loop_main
		
	chama_strcat:
		
		#imprime mensagem pedindo a string 1
		li $v0, 4
		la $a0, msg_1
		syscall
		
		#le string 1 do usuário
		li $v0, 8
		la $a0, entrada1 #onde ficará a string 1
		addi $a1, $0, 16
		syscall
		
		#imprime mensagem pedindo a string 2
		li $v0, 4
		la $a0, msg_2
		syscall
		
		#le string 2 do usuário
		li $v0, 8
		la $a0, entrada2 #onde ficará a string 2
		addi $a1, $0, 16
		syscall
		
		la $a0, entrada1 #coloca o endereço da string 1 lida em a0
		la $a1, entrada2 #coloca o endereço da string 2 lida em a1
		jal strcat #chama strcat
		
		la $a0, 0($v0) #move resultado para s0
		li $v0, 4
		syscall	
		
		j loop_main
		
	chama_strncat:
		
		#imprime mensagem pedindo a string 1
		li $v0, 4
		la $a0, msg_1
		syscall
		
		#le string 1 do usuário
		li $v0, 8
		la $a0, entrada1 #onde ficará a string 1
		addi $a1, $0, 16
		syscall
		
		#imprime mensagem pedindo a string 2
		li $v0, 4
		la $a0, msg_2
		syscall
		
		#le string 2 do usuário
		li $v0, 8
		la $a0, entrada2 #onde ficará a string 2
		addi $a1, $0, 16
		syscall
		
		#imprime mensagem pedindo a string 2
		li $v0, 4
		la $a0, msg_3
		syscall
		
		#le n do usuário (estará em a0)
		li $v0, 5
		syscall
		addi $a2, $v0, 0
		
		la $a0, entrada1 #coloca o endereço da string 1 lida em a0
		la $a1, entrada2 #coloca o endereço da string 2 lida em a1
		jal strncat #chama strncat
		
		la $a0, 0($v0) #move resultado para s0
		li $v0, 4
		syscall	
		
		j loop_main
		
	chama_strncpy:
		
		#imprime mensagem pedindo a string 1
		li $v0, 4
		la $a0, msg_1
		syscall
		
		#le string 1 do usuário
		li $v0, 8
		la $a0, entrada1 #onde ficará a string 1
		addi $a1, $0, 16
		syscall
		
		#imprime mensagem pedindo a string 2
		li $v0, 4
		la $a0, msg_2
		syscall
		
		#le string 2 do usuário
		li $v0, 8
		la $a0, entrada2 #onde ficará a string 2
		addi $a1, $0, 16
		syscall
		
		#imprime mensagem pedindo a string 2
		li $v0, 4
		la $a0, msg_3
		syscall
		
		#le n do usuário (estará em a0)
		li $v0, 5
		syscall
		addi $a2, $v0, 0
		
		la $a0, entrada1 #coloca o endereço da string 1 lida em a0
		la $a1, entrada2 #coloca o endereço da string 2 lida em a1
		jal strncpy #chama strncpy
		
		la $a0, 0($v0) #move resultado para s0
		li $v0, 4
		syscall
		
		j loop_main
		
	fim:
		li $v0, 10
		syscall
