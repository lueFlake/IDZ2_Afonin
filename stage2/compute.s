	.intel_syntax noprefix
	.text
	.globl	compute
	.type	compute, @function
compute:

	# Пролог функции.
	push	rbp
	mov	rbp, rsp

	# Передача параметров в переменные стека.
	mov	DWORD PTR -20[rbp], edi 	# n, как 1й параметр (edi)
	mov	QWORD PTR -32[rbp], rsi 	# s, как 2й параметр (rsi)
	mov	DWORD PTR -4[rbp], 0 		# i = 0
	jmp	.L2
.L4: 									# for (..; i < n;..)

	mov	eax, DWORD PTR -4[rbp] 		# eax = i
	movsx	rdx, eax 				# rdx =64<-32= eax = i
	mov	rax, QWORD PTR -32[rbp] 	# rax = s
	add	rax, rdx 					# rax = s + rdx = s + i = &s[i]
	movzx	eax, BYTE PTR [rax] 	# eax =32<-16= *rax = s[i]	

	cmp	al, 96							# if ('a' <= s[i])
	jle	.L3

	# eax = s[i]
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]

	cmp	al, 122							# if ('z' >= s[i])
	jg	.L3

	# eax = s[i]
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]

	lea	ecx, -32[rax] 				# ecx = rax - 32 = s[i] - 'a' + 'A'
	mov	eax, DWORD PTR -4[rbp] 		
	movsx	rdx, eax 				# rdx = i
	mov	rax, QWORD PTR -32[rbp] 	# rax = s
	add	rax, rdx 					# rax = s + i
	mov	edx, ecx 					# edx = s[i] - 'a' + 'A'
	mov	BYTE PTR [rax], dl 			# s[i] = dl = s[i] - 'a' + 'A'
.L3: 									# Конец 
	# ++i
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L4
										# Конец for (..; i < n;..)
	# Эпилог функции.
	leave
	ret
