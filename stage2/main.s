	.intel_syntax noprefix
	.text
# Read-only, в частности используемые строки.
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

	#main
main:

	# Пролог функции.
	push	rbp
	mov	rbp, rsp
	sub	rsp, 3104


	# Передача аргументов командной строки в стек.
	mov	DWORD PTR -3092[rbp], edi	# argc = edi
	mov	QWORD PTR -3104[rbp], rsi	# argv = rsi

	# Вызов time(edi = 0)
	mov	edi, 0
	call	time@PLT

	# srand(edi = eax = time(0))
	mov	edi, eax
	call	srand@PLT

	mov	DWORD PTR -3076[rbp], 0 	# n = 0

	mov	rax, QWORD PTR stdin[rip] 	# rax = stdin
	mov	QWORD PTR -8[rbp], rax 		# ifs = rax = stdin
	mov	rax, QWORD PTR stdout[rip]	# rax = stdout
	mov	QWORD PTR -16[rbp], rax 	# ofs = rax = stdout

	
	cmp	DWORD PTR -3092[rbp], 3 		# if (argc == 3) ...
	jne	.L2

	mov	rax, QWORD PTR -3104[rbp]
	add	rax, 8 						# rax = argv + sz(ptr) = &argv[1]
	mov	rax, QWORD PTR [rax]		# rax = argv[1]
	movzx	eax, BYTE PTR [rax] 	# eax =64->32= argv[1][0]
	
	cmp	al, 37
	je	.L3 							# if (argv[1][0] != '%') ...

	mov	rax, QWORD PTR -3104[rbp]
	add	rax, 8 						# rax = argv + sz(ptr) = &argv[1]
	mov	rax, QWORD PTR [rax] 		# rax = argv[1]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax 					# rdi = rax = argv[1]
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax 		# ifs = fopen(rdi, rsi)

	jmp	.L4
.L3: 									# if (argv[1][0] == '%') ...
	mov	QWORD PTR -8[rbp], 0 			# ifs = NULL
.L4: 									# Конец if (argv[1][0] != '%') ...

	# ofs = fopen(argv[2], "w")
	mov	rax, QWORD PTR -3104[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax

.L2:									# Конец if (argc == 3) ...
	cmp	QWORD PTR -8[rbp], 0 			# if (ifs == NULL) ...
	je	.L5
	mov	DWORD PTR -52[rbp], 0 		# ch = 0

.L6:									# do ...

	# ch = fgetc(ifs)
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -52[rbp], eax
	
	mov	eax, DWORD PTR -3076[rbp] 	# eax = n
	lea	edx, 1[rax] 				# edx = eax + 1 = n + 1
	mov	DWORD PTR -3076[rbp], edx 	# n = edx = n + 1

	mov	edx, DWORD PTR -52[rbp] 	# edx = ch
	mov	BYTE PTR -3072[rbp+rax], dl # str[rbp + rax] => str[rbp + n] = dl = ch
	cmp	DWORD PTR -52[rbp], -1 			# ... while (ch != -1);
	jne	.L6

	# --n
	mov	eax, DWORD PTR -3076[rbp]
	sub	eax, 1
	mov	DWORD PTR -3076[rbp], eax

	mov	eax, DWORD PTR -3076[rbp]
	mov	BYTE PTR -3072[rbp+rax], 0 	# str[n] = '\0'

	# start = clock()
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax

	# compute(n, str)
	mov	eax, DWORD PTR -3076[rbp]
	lea	rdx, -3072[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	compute@PLT

	# finish = clock()
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax

	# fprintf(ofs, "%s\n", str)
	lea	rdx, -3072[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT

	# fprintf(ofs, "time: %ld ms\n", finish - start)
	mov	rax, QWORD PTR -48[rbp]
	sub	rax, QWORD PTR -40[rbp] 	# rax = finish - start
	mov	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC3[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT

	jmp	.L7
.L5: 									# if (ifs == NULL) ...
	mov	QWORD PTR -24[rbp], 0 		# total = 0
	mov	DWORD PTR -28[rbp], 0 		# i = 0
	jmp	.L8
.L9: 									# for (..;i < 100000;..)

	# genString(&n, str)
	lea	rdx, -3072[rbp]
	lea	rax, -3076[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	genString@PLT

	# fprintf(ofs, "test no.%d:\n\n in: %s\n\n ", i, str)
	lea	rcx, -3072[rbp]
	mov	edx, DWORD PTR -28[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fprintf@PLT

	# start = clock()
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax

	# compute(n, str)
	mov	eax, DWORD PTR -3076[rbp]
	lea	rdx, -3072[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	compute@PLT

	# finish = clock()
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	lea	rdx, -3072[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC5[rip]
	mov	rsi, rcx
	mov	rdi, rax
	call	fprintf@PLT
	
	# total += finish - start
	mov	rax, QWORD PTR -48[rbp]
	sub	rax, QWORD PTR -40[rbp] 	# rax = finish - start
	add	QWORD PTR -24[rbp], rax
	
	# ++i
	add	DWORD PTR -28[rbp], 1
.L8:
	cmp	DWORD PTR -28[rbp], 99999
	jle	.L9
										# Конец for (..;i < 100000;..)

	# fprintf(ofs, "total random testing time: %ld ms", total)
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC6[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
.L7:
	# return 0
	mov	eax, 0

	# Эпилог функции
	leave
	ret
