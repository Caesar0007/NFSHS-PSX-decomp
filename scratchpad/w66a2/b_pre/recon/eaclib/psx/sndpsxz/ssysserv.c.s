	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\ssysserv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDserveraddclient
	.align	2
	.globl	iSNDserverremoveclient
	.align	2
	.globl	SNDSYS_service

	.text
	.def	iSNDserveraddclient;	.val	iSNDserveraddclient;	.scl	2;	.type	0x63;	.endef
	.text
	.ent	iSNDserveraddclient
iSNDserveraddclient:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	cb;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs) # high
	addiu	$2,$2,%lo(sndgs) # low
	lb	$3,65($2)
	#nop
	sll	$3,$3,2
	addu	$3,$3,$2
	sw	$4,100($3)
	lbu	$3,65($2)
	#nop
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$3,65($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDserveraddclient
	.def	iSNDserverremoveclient;	.val	iSNDserverremoveclient;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDserverremoveclient
iSNDserverremoveclient:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	cb;	.val	4;	.scl	17;	.type	0x4;	.endef
	move	$6,$4
 #APP
 #NO_APP
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	lb	$2,65($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L13
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$3
	sll	$2,$4,2
$L11:
	addu	$2,$2,$5
	lw	$2,100($2)
	#nop
	bne	$2,$6,$L5
	lbu	$2,65($5)
	#nop
	addu	$2,$2,-1
	sb	$2,65($5)
	sll	$2,$2,24
	sra	$2,$2,24
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L13
	sll	$3,$4,2
	.set	macro
	.set	reorder

$L10:
	addu	$4,$4,1
	sll	$2,$4,2
	addu	$2,$2,$5
	lw	$2,100($2)
	addu	$3,$3,$5
	sw	$2,100($3)
	lb	$2,65($5)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	sll	$3,$4,2
	.set	macro
	.set	reorder

$L13:
	j	$31
$L5:
	lb	$2,65($5)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	sll	$2,$4,2
	.set	macro
	.set	reorder

	j	$31

	.loc	1 0
LM2:
	.end	iSNDserverremoveclient
	.def	SNDSYS_service;	.val	SNDSYS_service;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SNDSYS_service
SNDSYS_service:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lb	$2,65($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L15
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$3
	move	$17,$18
$L16:
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$17,$17,4
	.set	macro
	.set	reorder

	lb	$2,65($18)
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L16
$L15:
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
LM3:
	.end	SNDSYS_service
