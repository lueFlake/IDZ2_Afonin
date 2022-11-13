	.intel_syntax noprefix
	.text
	.globl	genString
	.type	genString, @function
genString:

	# Пролог функции.
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	mov	QWORD PTR -24[rbp], rdi 	# n, как 1й параметр (rdi)
	mov	QWORD PTR -32[rbp], rsi 	# s, как 2й параметр (rsi)

	# *n = rand() % 3000 + 1
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 91625969
	shr	rdx, 32
	sar	edx, 6
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 3000
	sub	eax, ecx
	mov	edx, eax
	add	edx, 1
	mov	rax, QWORD PTR -24[rbp]
	mov	DWORD PTR [rax], edx

	# i = 0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3: 									# for (..;i < n;..)
	
	# s[i] = rand() % 95 + 32;
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -1401515643
	shr	rdx, 32
	add	edx, eax
	sar	edx, 6
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 95
	sub	eax, ecx
	mov	edx, eax
	lea	ecx, 32[rax]
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl

	# ++i
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L3
										# Конец for (..;i < n;..)
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0

	# Эпилог функции.
	leave
	ret
