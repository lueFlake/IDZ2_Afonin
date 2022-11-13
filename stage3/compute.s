	.intel_syntax noprefix
	.text
	.globl	compute
	.type	compute, @function
compute:

	# Пролог функции.
	push	rbp
	mov	rbp, rsp

	# Передача параметров в переменные стека.
	# edi, вместо n
	# rsi, вместо s
	mov	edx, 0 						# i = 0
	jmp	.L2
.L4: 									# for (..; i < n;..)

	mov	rax, rsi 					# rax = s
	add	rax, rdx 					# rax = s + rdx = s + i = &s[i]
	movzx	eax, BYTE PTR [rax] 	# eax =32<-16= *rax = s[i]	

	cmp	al, 96							# if ('a' <= s[i])
	jle	.L3

	cmp	al, 122							# if ('z' >= s[i])
	jg	.L3

	lea	ecx, -32[rax] 				# ecx = rax - 32 = s[i] - 'a' + 'A'	
	mov	rax, rsi 	# rax = s
	add	rax, rdx 					# rax = s + i
	mov	BYTE PTR [rax], cl 			# s[i] = dl = s[i] - 'a' + 'A'
.L3: 									# Конец for (..; i < n;..)
	# ++i
	add	edx, 1
.L2:
	cmp	edx, edi
	jl	.L4
										# Конец for (..; i < n;..)
	# Эпилог функции.
	leave
	ret
