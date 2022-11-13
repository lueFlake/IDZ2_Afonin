	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"w"
.LC2:
	.string	"%s\n"
.LC3:
	.string	"time: %ld ms\n"
.LC4:
	.string	"test no.%d:\n\n in: %s\n\n "
.LC5:
	.string	"out: %s\n\n"
	.align 8
.LC6:
	.string	"total random testing time: %ld ms"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 3104
	mov	DWORD PTR -3092[rbp], edi
	mov	QWORD PTR -3104[rbp], rsi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	DWORD PTR -3076[rbp], 0
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax
	cmp	DWORD PTR -3092[rbp], 3
	jne	.L2
	mov	rax, QWORD PTR -3104[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 37
	je	.L3
	mov	rax, QWORD PTR -3104[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	jmp	.L4
.L3:
	mov	QWORD PTR -8[rbp], 0
.L4:
	mov	rax, QWORD PTR -3104[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
.L2:
	cmp	QWORD PTR -8[rbp], 0
	je	.L5
	mov	DWORD PTR -52[rbp], 0
.L6:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -52[rbp], eax
	mov	eax, DWORD PTR -3076[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -3076[rbp], edx
	mov	edx, DWORD PTR -52[rbp]
	cdqe
	mov	BYTE PTR -3072[rbp+rax], dl
	cmp	DWORD PTR -52[rbp], -1
	jne	.L6
	mov	eax, DWORD PTR -3076[rbp]
	sub	eax, 1
	mov	DWORD PTR -3076[rbp], eax
	mov	eax, DWORD PTR -3076[rbp]
	cdqe
	mov	BYTE PTR -3072[rbp+rax], 0
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	eax, DWORD PTR -3076[rbp]
	lea	rdx, -3072[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	compute@PLT
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -3072[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, QWORD PTR -48[rbp]
	sub	rax, QWORD PTR -40[rbp]
	mov	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC3[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	jmp	.L7
.L5:
	mov	QWORD PTR -24[rbp], 0
	mov	DWORD PTR -28[rbp], 0
	jmp	.L8
.L9:
	lea	rdx, -3072[rbp]
	lea	rax, -3076[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	genString@PLT
	lea	rcx, -3072[rbp]
	mov	edx, DWORD PTR -28[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	eax, DWORD PTR -3076[rbp]
	lea	rdx, -3072[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	compute@PLT
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -3072[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, QWORD PTR -48[rbp]
	sub	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -24[rbp], rax
	add	DWORD PTR -28[rbp], 1
.L8:
	cmp	DWORD PTR -28[rbp], 99999
	jle	.L9
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC6[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
.L7:
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
