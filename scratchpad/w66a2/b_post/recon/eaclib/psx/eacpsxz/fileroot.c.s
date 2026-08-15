	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fileroot.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
 #APP
		.globl	D_8013DD34
		.globl	D_8013DD40
 #NO_APP
	.align	2
	.globl	initfileio
	.sdata
	.align	2
$LC0:
	.ascii	"\\\000"
	.text
	.align	2
	.globl	setdirectory
	.align	2
	.globl	openfile
	.align	2
	.globl	closefile
	.align	2
	.globl	readfile
	.align	2
	.globl	readfile_systask
	.align	2
	.globl	writefile
	.align	2
	.globl	getfilesize
	.align	2
	.globl	stopreadfile

	.comm	currentdirectory,64

	.comm	D_8013DD34,4

	.comm	D_8013DD40,4

	.comm	readcmd,20

	.extern	currentfilesystem, 4
	.extern	availablefilesystems, 4
	.extern	disablecd, 4

	.text
	.file	1 "C:\\Temp\\nfs4-decomp\\recon/stddef.h"
	.def	size_t;	.scl	13;	.type	0xe;	.endef
	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fileroot.c"
	.def	ReadCmd;	.scl	10;	.type	0x8;	.size	20;	.endef
	.def	pending;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	handle;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	dest;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	offset;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	len;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	20;	.scl	102;	.tag	ReadCmd;	.size	20;	.endef
	.def	ReadCmd;	.scl	13;	.tag	ReadCmd;	.size	20;	.type	0x8;	.endef
	.def	initfileio;	.val	initfileio;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	initfileio
initfileio:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,disablecd
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$2,availablefilesystems
	#nop
	ori	$2,$2,0x0001
	sw	$2,availablefilesystems
$L2:
	jal	psxdevelopmentsystem
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	jal	PCinit
	lui	$4,%hi(readfile_systask) # high
	addiu	$4,$4,%lo(readfile_systask) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	addsystemtask
	move	$6,$5
	.set	macro
	.set	reorder

	lw	$2,availablefilesystems
	li	$3,2			# 0x00000002
	sw	$3,currentfilesystem
	or	$2,$2,$3
	sw	$2,availablefilesystems
	j	$L4
$L3:
	sw	$2,currentfilesystem
$L4:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	initfileio
	.def	setdirectory;	.val	setdirectory;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	setdirectory
setdirectory:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	dir;	.val	18;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lw	$5,D_8013DD34
	li	$6,6			# 0x00000006
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	strncmp
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,availablefilesystems
	li	$3,2			# 0x00000002
	andi	$2,$2,0x0003
	beq	$2,$3,$L5
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$18
	.set	macro
	.set	reorder

	sltu	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$17,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L16
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L6:
	lw	$5,D_8013DD40
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	bne	$2,$0,$L9
	lw	$2,availablefilesystems
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$17,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
$L16:
	sw	$2,currentfilesystem
$L9:
	lw	$3,currentfilesystem
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L5
	lui	$2,%hi(currentdirectory) # high
	.set	macro
	.set	reorder

	addiu	$16,$2,%lo(currentdirectory) # low
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$18,$17
	.set	macro
	.set	reorder

	lbu	$2,63($16)
	#nop
	bne	$2,$0,$L5
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L5
	addu	$2,$2,$16
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	li	$2,92			# 0x0000005c
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$5,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

$L5:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	setdirectory
	.def	openfile;	.val	openfile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	openfile
openfile:
	.frame	$sp,104,$31		# vars= 64, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	16;	.scl	17;	.type	0x12;	.endef
	.def	flags;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	outp;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,104
	sw	$16,80($sp)
	move	$16,$4
	sw	$19,92($sp)
	move	$19,$5
	sw	$17,84($sp)
	move	$17,$6
	addu	$4,$sp,16
	move	$5,$0
	li	$6,64			# 0x00000040
	sw	$31,96($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$18,88($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$18,currentfilesystem
	.set	noreorder
	.set	nomacro
	jal	strchr
	li	$5,58			# 0x0000003a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L18
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,D_8013DD34
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,availablefilesystems
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L18
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L19:
	lw	$5,D_8013DD40
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L22
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,availablefilesystems
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	li	$18,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L18
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L22:
	lw	$3,currentfilesystem
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L26
	li	$2,58			# 0x0000003a
	.set	macro
	.set	reorder

	lbu	$3,1($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L45
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L26:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strchr
	li	$5,58			# 0x0000003a
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$16
	subu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	jal	strncpy
	addu	$6,$2,1
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strchr
	li	$5,58			# 0x0000003a
	.set	macro
	.set	reorder

	subu	$2,$2,$16
	addu	$2,$2,$sp
	sb	$0,18($2)
	move	$18,$0
$L18:
	li	$2,1			# 0x00000001
$L45:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L27
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	CD_Open
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,0($17)
	li	$4,16777216			# 0x01000000
	or	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L42
	sw	$3,0($17)
	.set	macro
	.set	reorder

$L27:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L42
	move	$2,$0
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	li	$2,92			# 0x0000005c
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L30
	li	$2,47			# 0x0000002f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L30
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$5,%hi(currentdirectory) # high
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addiu	$5,$5,%lo(currentdirectory) # low
	.set	macro
	.set	reorder

$L30:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	strcat
	move	$5,$16
	.set	macro
	.set	reorder

	andi	$3,$19,0x0007
	sltu	$2,$3,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
	lui	$2,%hi($L40) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L40) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L40:
	.word	$L32
	.word	$L33
	.word	$L34
	.word	$L39
	.word	$L36
	.word	$L39
	.word	$L38
	.text
$L32:
	addu	$4,$sp,16
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	PCopen
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L33:
	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	PCopen
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L34:
	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	PCopen
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L31
	sw	$2,0($17)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	PCcreat
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L36:
	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	PCopen
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L41
	sw	$2,0($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PCclose
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	PCcreat
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L38:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	PCcreat
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L31
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L39:
	li	$2,-1			# 0xffffffff
	sw	$2,0($17)
$L31:
	lw	$3,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L41
	sll	$2,$18,24
	.set	macro
	.set	reorder

	or	$2,$3,$2
	sw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L42
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L41:
	sw	$0,0($17)
$L43:
	move	$2,$0
$L42:
	lw	$31,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	openfile
	.def	closefile;	.val	closefile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	closefile
closefile:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	li	$2,16711680			# 0x00ff0000
	ori	$2,$2,0xffff
	sra	$5,$4,24
	and	$4,$4,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L47
	move	$3,$0
	.set	macro
	.set	reorder

	jal	CD_Close
	.set	noreorder
	.set	nomacro
	j	$L48
	move	$3,$2
	.set	macro
	.set	reorder

$L47:
	li	$2,2			# 0x00000002
	bne	$5,$2,$L48
	jal	PCclose
	move	$3,$2
$L48:
	lw	$31,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	closefile
	.def	readfile;	.val	readfile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	readfile
readfile:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	dest;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	len;	.val	7;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	li	$2,16711680			# 0x00ff0000
	ori	$2,$2,0xffff
	move	$9,$0
	sra	$3,$4,24
	li	$11,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$11,$L52
	and	$4,$4,$2
	.set	macro
	.set	reorder

	jal	CD_Read
	.set	noreorder
	.set	nomacro
	j	$L53
	move	$9,$2
	.set	macro
	.set	reorder

$L52:
	li	$2,2			# 0x00000002
	bne	$3,$2,$L53
 #APP
	mfc0 $10,$12
	 nop
	 addiu $1,$0,-0x402
	 and $8,$10,$1
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lui	$3,%hi(readcmd) # high
	lw	$2,%lo(readcmd)($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L55
	addiu	$8,$3,%lo(readcmd) # low
	.set	macro
	.set	reorder

	li	$9,1			# 0x00000001
	sw	$11,%lo(readcmd)($3)
	sw	$4,4($8)
	sw	$5,8($8)
	sw	$6,12($8)
	sw	$7,16($8)
$L55:
 #APP
	mtc0 $10,$12
 #NO_APP
$L53:
	lw	$31,16($sp)
	move	$2,$9
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	readfile
	.def	readfile_systask;	.val	readfile_systask;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	readfile_systask
readfile_systask:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
 #APP
	mfc0 $18,$12
	 nop
	 addiu $1,$0,-0x402
	 and $8,$18,$1
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lui	$17,%hi(readcmd) # high
	lw	$2,%lo(readcmd)($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L57
	addiu	$16,$17,%lo(readcmd) # low
	.set	macro
	.set	reorder

	lw	$4,4($16)
	lw	$5,12($16)
	.set	noreorder
	.set	nomacro
	jal	PClseek
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$4,4($16)
	lw	$5,8($16)
	lw	$6,16($16)
	jal	PCread
	lw	$3,16($16)
	sw	$0,%lo(readcmd)($17)
	xor	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	iFILE_CommandCompleteCallback
	sltu	$4,$2,1
	.set	macro
	.set	reorder

$L57:
 #APP
	mtc0 $18,$12
 #NO_APP
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	readfile_systask
	.def	writefile;	.val	writefile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	writefile
writefile:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	buf;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	len;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$5
	move	$5,$6
	sw	$17,20($sp)
	move	$17,$7
	li	$2,16711680			# 0x00ff0000
	ori	$2,$2,0xffff
	sra	$3,$4,24
	sw	$16,16($sp)
	and	$16,$4,$2
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L59
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	PClseek
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	PCwrite
	move	$6,$17
	.set	macro
	.set	reorder

	xor	$2,$2,$17
	.set	noreorder
	.set	nomacro
	jal	iFILE_CommandCompleteCallback
	sltu	$4,$2,1
	.set	macro
	.set	reorder

$L59:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	writefile
	.def	getfilesize;	.val	getfilesize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	getfilesize
getfilesize:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	li	$2,16711680			# 0x00ff0000
	ori	$2,$2,0xffff
	sra	$3,$4,24
	and	$4,$4,$2
	li	$2,1			# 0x00000001
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L61
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CD_Getinfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	j	$L62
$L61:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L62
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PClseek
	move	$6,$2
	.set	macro
	.set	reorder

	sw	$2,16($sp)
$L62:
	lw	$2,16($sp)
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	getfilesize
	.def	stopreadfile;	.val	stopreadfile;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	stopreadfile
stopreadfile:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	li	$2,16711680			# 0x00ff0000
	ori	$2,$2,0xffff
	sra	$3,$4,24
	and	$4,$4,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L65
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	CD_Stopread
	j	$L66
$L65:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L66
	lui	$3,%hi(readcmd) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(readcmd)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L66
	addiu	$5,$3,%lo(readcmd) # low
	.set	macro
	.set	reorder

	lw	$2,4($5)
	#nop
	bne	$2,$4,$L66
	sw	$0,%lo(readcmd)($3)
	.set	noreorder
	.set	nomacro
	jal	iFILE_CommandCompleteCallback
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L66:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	stopreadfile
	.def	currentdirectory;	.val	currentdirectory;	.scl	2;	.dim	64;	.size	64;	.type	0x32;	.endef
	.def	D_8013DD34;	.val	D_8013DD34;	.scl	2;	.type	0x12;	.endef
	.def	D_8013DD40;	.val	D_8013DD40;	.scl	2;	.type	0x12;	.endef
	.def	readcmd;	.val	readcmd;	.scl	2;	.tag	ReadCmd;	.size	20;	.type	0x8;	.endef
