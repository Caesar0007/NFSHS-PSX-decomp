	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\textsys.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"%s%s\000"
	.text
	.align	2
	.globl	TextSys_LoadWordsGeneric__FiPc
	.sdata
	.align	2
$LC1:
	.ascii	"p\000"
	.text
	.align	2
	.globl	TextSys_LoadInGame__Fi
	.align	2
	.globl	TextSys_LoadWords__Fi
	.align	2
	.globl	TextSys_Word__Fi
	.align	2
	.globl	TextSys_WordFlags__Fi
	.align	2
	.globl	TextSys_WordX__Fi
	.align	2
	.globl	TextSys_WordY__Fi
	.align	2
	.globl	TextSys_UnloadWords__Fv
	.globl	wordFile
	.sdata
	.align	2
wordFile:
	.space	4

	.extern	langFileName, 24

	.text
	.text
	.ent	TextSys_LoadWordsGeneric__FiPc
TextSys_LoadWordsGeneric__FiPc:
	.frame	$sp,288,$31		# vars= 256, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,288
	sw	$16,272($sp)
	move	$16,$4
	sw	$17,276($sp)
	move	$17,$5
	slt	$2,$16,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L600
	sw	$31,280($sp)
	.set	macro
	.set	reorder

	lw	$4,wordFile
	#nop
	beq	$4,$0,$L602
	jal	purgememadr
$L602:
	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	lui	$3,%hi(langFileName) # high
	addiu	$3,$3,%lo(langFileName) # low
	sll	$2,$16,2
	addu	$2,$2,$3
	lw	$7,0($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,wordFile
$L600:
	lw	$31,280($sp)
	lw	$17,276($sp)
	lw	$16,272($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,288
	.set	macro
	.set	reorder

	.end	TextSys_LoadWordsGeneric__FiPc
	.text
	.ent	TextSys_LoadInGame__Fi
TextSys_LoadInGame__Fi:
	.frame	$sp,104,$31		# vars= 80, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$16,96($sp)
	move	$16,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	lui	$2,%hi(Paths_Paths+104) # high
	lui	$7,%hi($LC1) # high
	lw	$6,%lo(Paths_Paths+104)($2)
	sw	$31,100($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$7,$7,%lo($LC1) # low
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	TextSys_LoadWordsGeneric__FiPc
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lw	$31,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	TextSys_LoadInGame__Fi
	.text
	.ent	TextSys_LoadWords__Fi
TextSys_LoadWords__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(Paths_Paths+136) # high
	lw	$5,%lo(Paths_Paths+136)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	TextSys_LoadWordsGeneric__FiPc
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextSys_LoadWords__Fi
	.text
	.ent	TextSys_Word__Fi
TextSys_Word__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,wordFile
	sll	$2,$2,2
	addu	$2,$3,$2
	lw	$2,8($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

	.end	TextSys_Word__Fi
	.text
	.ent	TextSys_WordFlags__Fi
TextSys_WordFlags__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,wordFile
	sll	$2,$2,2
	addu	$3,$3,$2
	lbu	$2,3($3)
	j	$31
	.end	TextSys_WordFlags__Fi
	.text
	.ent	TextSys_WordX__Fi
TextSys_WordX__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,wordFile
	sll	$2,$2,2
	addu	$3,$3,$2
	lh	$2,4($3)
	j	$31
	.end	TextSys_WordX__Fi
	.text
	.ent	TextSys_WordY__Fi
TextSys_WordY__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,wordFile
	sll	$2,$2,2
	addu	$3,$3,$2
	lh	$2,6($3)
	j	$31
	.end	TextSys_WordY__Fi
	.text
	.ent	TextSys_UnloadWords__Fv
TextSys_UnloadWords__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,wordFile
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L610
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L610:
	lw	$31,16($sp)
	sw	$0,wordFile
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextSys_UnloadWords__Fv
