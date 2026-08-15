	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\iso9660.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fsigned-char -o

gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	_cd_dir
	.globl	_cd_pathtbl
	.globl	_cd_secbuf
	.section	.bss
	.align	2
_cd_dir:
	.space	1536
_cd_pathtbl:
	.space	5632
_cd_secbuf:
	.space	2048
	.text
 #NO_APP
	.text
	.align	2
	.ent	rd32le
rd32le:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,1($4)
	lbu	$5,0($4)
	lbu	$3,2($4)
	sll	$2,$2,8
	or	$5,$5,$2
	sll	$3,$3,16
	lbu	$2,3($4)
	or	$5,$5,$3
	sll	$2,$2,24
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$5,$2
	.set	macro
	.set	reorder

	.end	rd32le
	.rdata
	.align	2
$LC0:
	.ascii	"%s: path level (%d) error\n\000"
	.align	2
$LC1:
	.ascii	"%s: dir was not found\n\000"
	.align	2
$LC2:
	.ascii	"CdSearchFile: disc error\n\000"
	.align	2
$LC3:
	.ascii	"CdSearchFile: searching %s...\n\000"
	.align	2
$LC4:
	.ascii	"%s:  found\n\000"
	.align	2
$LC5:
	.ascii	"%s: not found\n\000"
	.text
	.align	2
	.globl	CdSearchFile
	.ent	CdSearchFile
CdSearchFile:
	.frame	$sp,80,$31		# vars= 32, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	lw	$3,D_80136C6C
	lw	$2,CD_nopen
	subu	$sp,$sp,80
	sw	$22,72($sp)
	addu	$22,$4,$0
	sw	$19,60($sp)
	addu	$19,$5,$0
	sw	$31,76($sp)
	sw	$21,68($sp)
	sw	$20,64($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L3
	sw	$16,48($sp)
	.set	macro
	.set	reorder

	jal	CD_newmedia
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$2,CD_nopen
	#nop
	sw	$2,D_80136C6C
$L3:
	lb	$3,0($19)
	li	$2,0x0000005c		# 92
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L35
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L37:
	.set	noreorder
	.set	nomacro
	j	$L14
	sb	$0,16($sp)
	.set	macro
	.set	reorder

$L5:
	sb	$0,16($sp)
	addu	$16,$19,$0
	li	$21,0x0000005c		# 92
	li	$20,-1			# 0xffffffff
	addu	$18,$0,$0
$L9:
 #APP
 #NO_APP
	lbu	$3,0($16)
	.set	noreorder
	.set	nomacro
	j	$L38
	addu	$17,$sp,16
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L40
	slt	$2,$18,8
	.set	macro
	.set	reorder

	addu	$16,$16,1
	sb	$3,0($17)
	lbu	$3,0($16)
	addu	$17,$17,1
$L38:
	sll	$2,$3,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	bne	$2,$21,$L12
	addu	$5,$3,$0
	.set	macro
	.set	reorder

	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	slt	$2,$18,8
	.set	macro
	.set	reorder

	addu	$16,$16,1
	sb	$0,0($17)
	.set	noreorder
	.set	nomacro
	jal	_cd_find_path
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$2,$0
	beq	$4,$20,$L37
	addu	$18,$18,1
	slt	$2,$18,8
	bne	$2,$0,$L9
$L14:
	slt	$2,$18,8
$L40:
	bne	$2,$0,$L19
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L34
	addu	$5,$19,$0
	.set	macro
	.set	reorder

	la	$4,$LC0
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$6,$18,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L35
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L19:
	lb	$2,16($sp)
	#nop
	bne	$2,$0,$L21
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L34
	addu	$5,$19,$0
	.set	macro
	.set	reorder

	la	$4,$LC1
	j	$L39
$L21:
	.set	noreorder
	.set	nomacro
	jal	CD_cachefile
	sb	$0,0($17)
	.set	macro
	.set	reorder

	bne	$2,$0,$L23
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L35
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	la	$4,$LC2
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L35
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L23:
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L41
	addu	$18,$0,$0
	.set	macro
	.set	reorder

	la	$4,$LC3
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	addu	$18,$0,$0
$L41:
	la	$2,_cd_dir+8
	addu	$16,$2,-8
	addu	$19,$2,$0
	addu	$17,$0,$0
$L29:
	lb	$2,_cd_dir+8($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L27
	addu	$4,$19,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_cd_cmp_name
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L28
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L32
	la	$4,$LC4
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L32:
	lw	$2,0($16)
	lw	$3,4($16)
	lw	$4,8($16)
	lw	$5,12($16)
	sw	$2,0($22)
	sw	$3,4($22)
	sw	$4,8($22)
	sw	$5,12($22)
	lw	$2,16($16)
	lw	$3,20($16)
	sw	$2,16($22)
	sw	$3,20($22)
	.set	noreorder
	.set	nomacro
	j	$L35
	addu	$2,$16,$0
	.set	macro
	.set	reorder

$L28:
	addu	$16,$16,24
	addu	$19,$19,24
	addu	$18,$18,1
	slt	$2,$18,64
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L29
	addu	$17,$17,24
	.set	macro
	.set	reorder

$L27:
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L34
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	la	$4,$LC5
$L39:
	jal	printf
$L34:
	addu	$2,$0,$0
$L35:
	lw	$31,76($sp)
	lw	$22,72($sp)
	lw	$21,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	addu	$sp,$sp,80
	j	$31
	.end	CdSearchFile
	.align	2
	.globl	_cd_cmp_name
	.ent	_cd_cmp_name
_cd_cmp_name:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,0x0000000c		# 12
	.set	macro
	.set	reorder

	.set	noreorder
	lw	$31,16($sp)
	sltu	$2,$2,1
	j	$31
	addu	$sp,$sp,24
	.set	reorder
	.end	_cd_cmp_name
	.rdata
	.align	2
$LC6:
	.ascii	"CD_newmedia: Read error in cd_read(PVD)\n\000"
	.align	2
$LC7:
	.ascii	"CD001\000"
	.align	2
$LC8:
	.ascii	"CD_newmedia: Disc format error in cd_read(PVD)\n\000"
	.align	2
$LC9:
	.ascii	"CD_newmedia: Read error (PT:%08x)\n\000"
	.align	2
$LC10:
	.ascii	"CD_newmedia: sarching dir..\n\000"
	.align	2
$LC11:
	.ascii	"\t%08x,%04x,%04x,%s\n\000"
	.align	2
$LC12:
	.ascii	"CD_newmedia: %d dir entries found\n\000"
	.text
	.align	2
	.globl	CD_newmedia
	.ent	CD_newmedia
CD_newmedia:
	.frame	$sp,64,$31		# vars= 8, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,32($sp)
	la	$16,_cd_secbuf
	li	$4,0x00000001		# 1
	li	$5,0x00000010		# 16
	addu	$6,$16,$0
	sw	$31,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	.set	noreorder
	.set	nomacro
	jal	cd_read
	sw	$17,36($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	addu	$17,$2,$0
	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L44
	addu	$4,$16,1
	.set	macro
	.set	reorder

	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	la	$4,$LC6
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L44:
	la	$5,$LC7
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,0x00000005		# 5
	.set	macro
	.set	reorder

	beq	$2,$0,$L46
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	la	$4,$LC8
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L46:
	lwl	$2,143($16)
	lwr	$2,140($16)
	swl	$2,27($sp)
	swr	$2,24($sp)
	li	$4,0x00000001		# 1
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	cd_read
	addu	$6,$16,$0
	.set	macro
	.set	reorder

	beq	$2,$17,$L48
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	la	$4,$LC9
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L61
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L48:
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L62
	addu	$17,$16,$0
	.set	macro
	.set	reorder

	la	$4,$LC10
	jal	printf
$L62:
	addu	$3,$17,2048
	sltu	$2,$17,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L51
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	addu	$21,$3,$0
	la	$20,_cd_pathtbl+8
	addu	$22,$20,4
$L54:
	lbu	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L51
	sll	$2,$7,1
	.set	macro
	.set	reorder

	addu	$2,$2,$7
	sll	$2,$2,2
	subu	$2,$2,$7
	sll	$16,$2,2
	addu	$2,$16,$20
	lwl	$3,5($17)
	lwr	$3,2($17)
	swl	$3,3($2)
	swr	$3,0($2)
	addu	$18,$16,$22
	addu	$4,$18,$0
	lbu	$2,6($17)
	addu	$19,$7,1
	sw	$19,_cd_pathtbl($16)
	sw	$2,_cd_pathtbl+4($16)
	lbu	$6,0($17)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$17,8
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	#nop
	addu	$2,$18,$2
	sb	$0,0($2)
	lbu	$3,0($17)
	#nop
	andi	$2,$3,0x0001
	addu	$2,$2,8
	addu	$3,$3,$2
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L56
	addu	$17,$17,$3
	.set	macro
	.set	reorder

	lw	$5,_cd_pathtbl+8($16)
	lw	$6,_cd_pathtbl($16)
	lw	$7,_cd_pathtbl+4($16)
	la	$4,$LC11
	.set	noreorder
	.set	nomacro
	jal	printf
	sw	$18,16($sp)
	.set	macro
	.set	reorder

$L56:
	addu	$7,$19,$0
	slt	$2,$7,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L59
	sltu	$2,$17,$21
	.set	macro
	.set	reorder

	bne	$2,$0,$L54
$L51:
	slt	$2,$7,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L59
	sll	$2,$7,1
	.set	macro
	.set	reorder

	addu	$2,$2,$7
	sll	$2,$2,2
	subu	$2,$2,$7
	sll	$2,$2,2
	sw	$0,_cd_pathtbl+4($2)
$L59:
	lw	$2,CD_debug
	sw	$0,D_80136C68
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L61
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	la	$4,$LC12
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$5,$7,$0
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
$L61:
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	addu	$sp,$sp,64
	j	$31
	.end	CD_newmedia
	.align	2
	.globl	_cd_find_path
	.ent	_cd_find_path
_cd_find_path:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	addu	$19,$4,$0
	sw	$20,32($sp)
	addu	$20,$5,$0
	sw	$16,16($sp)
	addu	$16,$0,$0
	sw	$18,24($sp)
	la	$18,_cd_pathtbl+12
	sw	$17,20($sp)
	addu	$17,$0,$0
	sw	$31,36($sp)
$L64:
	lw	$2,_cd_pathtbl+4($17)
	#nop
	beq	$2,$0,$L71
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L68
	addu	$4,$20,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strcmp
	addu	$5,$18,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L72
	addu	$18,$18,44
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L70
	addu	$2,$16,1
	.set	macro
	.set	reorder

$L68:
	addu	$18,$18,44
$L72:
	addu	$16,$16,1
	slt	$2,$16,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L64
	addu	$17,$17,44
	.set	macro
	.set	reorder

$L71:
	li	$2,-1			# 0xffffffff
$L70:
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_cd_find_path
	.rdata
	.align	2
$LC13:
	.ascii	"CD_cachefile: dir not found\n\000"
	.align	2
$LC14:
	.ascii	"CD_cachefile: searching...\n\000"
	.align	2
$LC15:
	.ascii	".\000"
	.align	2
$LC16:
	.ascii	"..\000"
	.align	2
$LC17:
	.ascii	"\t(%02x:%02x:%02x) %8d %s\n\000"
	.align	2
$LC18:
	.ascii	"CD_cachefile: %d files found\n\000"
	.text
	.align	2
	.globl	CD_cachefile
	.ent	CD_cachefile
CD_cachefile:
	.frame	$sp,64,$31		# vars= 8, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	lw	$2,D_80136C68
	subu	$sp,$sp,64
	sw	$22,56($sp)
	addu	$22,$4,$0
	sw	$31,60($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	beq	$22,$2,$L91
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	li	$4,0x00000001		# 1
	sll	$2,$22,1
	addu	$2,$2,$22
	sll	$2,$2,2
	subu	$2,$2,$22
	sll	$2,$2,2
	lw	$5,_cd_pathtbl-36($2)
	la	$16,_cd_secbuf
	.set	noreorder
	.set	nomacro
	jal	cd_read
	addu	$6,$16,$0
	.set	macro
	.set	reorder

	li	$3,0x00000001		# 1
	beq	$2,$3,$L75
	lw	$2,CD_debug
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L92
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	la	$4,$LC13
	jal	printf
	.set	noreorder
	.set	nomacro
	j	$L92
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L75:
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L93
	addu	$2,$16,2048
	.set	macro
	.set	reorder

	la	$4,$LC14
	jal	printf
	addu	$2,$16,2048
$L93:
	sltu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	addu	$18,$0,$0
	.set	macro
	.set	reorder

	la	$21,_cd_dir
	addu	$19,$21,8
	addu	$17,$0,$0
	addu	$20,$21,$0
$L80:
	lbu	$2,0($16)
	#nop
	beq	$2,$0,$L79
	lwl	$2,5($16)
	lwr	$2,2($16)
	swl	$2,27($sp)
	swr	$2,24($sp)
	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	addu	$5,$20,$0
	.set	macro
	.set	reorder

	addu	$2,$21,4
	addu	$2,$17,$2
	lwl	$3,13($16)
	lwr	$3,10($16)
	swl	$3,3($2)
	swr	$3,0($2)
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L83
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L84
	addu	$4,$19,$0
	.set	macro
	.set	reorder

	j	$L85
$L83:
	lhu	$2,$LC15
	.set	noreorder
	.set	nomacro
	j	$L82
	sh	$2,8($21)
	.set	macro
	.set	reorder

$L84:
	lh	$2,$LC16
	lb	$3,$LC16+2
	sh	$2,32($21)
	sb	$3,34($21)
	j	$L82
$L85:
	lbu	$6,32($16)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$16,33
	.set	macro
	.set	reorder

	lbu	$2,32($16)
	#nop
	addu	$2,$19,$2
	sb	$0,0($2)
$L82:
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L87
	lbu	$5,_cd_dir($17)
	lbu	$6,_cd_dir+1($17)
	lbu	$7,_cd_dir+2($17)
	lw	$2,_cd_dir+4($17)
	la	$4,$LC17
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	jal	printf
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L87:
	addu	$19,$19,24
	addu	$17,$17,24
	lbu	$2,0($16)
	addu	$18,$18,1
	addu	$16,$16,$2
	slt	$2,$18,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	addu	$20,$20,24
	.set	macro
	.set	reorder

	la	$2,_cd_secbuf+2048
	sltu	$2,$16,$2
	bne	$2,$0,$L80
$L79:
	sw	$22,D_80136C68
	slt	$2,$18,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L90
	sll	$2,$18,1
	.set	macro
	.set	reorder

	addu	$2,$2,$18
	sll	$2,$2,3
	sb	$0,_cd_dir+8($2)
$L90:
	lw	$2,CD_debug
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L92
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	la	$4,$LC18
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$5,$18,$0
	.set	macro
	.set	reorder

$L91:
	li	$2,0x00000001		# 1
$L92:
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	addu	$sp,$sp,64
	j	$31
	.end	CD_cachefile
	.align	2
	.globl	cd_read
	.ent	cd_read
cd_read:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	addu	$17,$4,$0
	addu	$4,$5,$0
	addu	$5,$sp,16
	sw	$16,24($sp)
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	addu	$16,$6,$0
	.set	macro
	.set	reorder

	li	$4,0x00000002		# 2
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	addu	$4,$17,$0
	addu	$5,$16,$0
	.set	noreorder
	.set	nomacro
	jal	CdRead
	li	$6,0x00000080		# 128
	.set	macro
	.set	reorder

	addu	$4,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CdReadSync
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	sltu	$2,$2,1
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,40
	j	$31
	.end	cd_read
