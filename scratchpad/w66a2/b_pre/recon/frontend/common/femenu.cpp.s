	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\femenu.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	gMenu_SubMenuPlayer
	.data
	.align	2
gMenu_SubMenuPlayer:
	.word	-1
	.text
	.align	2
	.globl	__13tListIteratorPsPc
	.ent	__13tListIteratorPsPc
__13tListIteratorPsPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(tListIterator_vtable) # high
	addiu	$3,$3,%lo(tListIterator_vtable) # low
	sw	$3,12($2)
	sw	$5,0($2)
	sw	$6,4($2)
	sb	$0,9($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,8($2)
	.set	macro
	.set	reorder

	.end	__13tListIteratorPsPc
	.align	2
	.globl	_._13tListIterator
	.ent	_._13tListIterator
_._13tListIterator:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIterator_vtable) # high
	addiu	$2,$2,%lo(tListIterator_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L605
	sw	$2,12($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L605:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._13tListIterator
	.align	2
	.globl	Value__13tListIterator7tPlayer
	.ent	Value__13tListIterator7tPlayer
Value__13tListIterator7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	#nop
	lbu	$2,0($2)
	j	$31
	.end	Value__13tListIterator7tPlayer
	.align	2
	.globl	TextValue__13tListIterator7tPlayer
	.ent	TextValue__13tListIterator7tPlayer
TextValue__13tListIterator7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,12($16)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sll	$2,$2,1
	lw	$3,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextValue__13tListIterator7tPlayer
	.align	2
	.globl	Increment__13tListIterator7tPlayer
	.ent	Increment__13tListIterator7tPlayer
Increment__13tListIterator7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,4($4)
	#nop
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$5,4($4)
	#nop
	lbu	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	bne	$2,$0,$L610
	sb	$0,0($5)
$L610:
	j	$31
	.end	Increment__13tListIterator7tPlayer
	.align	2
	.globl	Decrement__13tListIterator7tPlayer
	.ent	Decrement__13tListIterator7tPlayer
Decrement__13tListIterator7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,4($4)
	#nop
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	move	$5,$3
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	blez	$2,$L618
$L615:
	lbu	$2,0($5)
	#nop
	addu	$2,$2,1
	sb	$2,0($5)
	lw	$5,4($4)
	#nop
	lbu	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	bgtz	$2,$L615
	j	$31
$L612:
	addu	$2,$2,-1
	sb	$2,0($3)
$L618:
	j	$31
	.end	Decrement__13tListIterator7tPlayer
	.align	2
	.globl	__20tListIteratorIndexedPsPcT2
	.ent	__20tListIteratorIndexedPsPcT2
__20tListIteratorIndexedPsPcT2:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$17,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorIndexed_vtable) # high
	addiu	$3,$3,%lo(tListIteratorIndexed_vtable) # low
	sw	$3,12($2)
	sw	$17,16($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	__20tListIteratorIndexedPsPcT2
	.align	2
	.globl	_._20tListIteratorIndexed
	.ent	_._20tListIteratorIndexed
_._20tListIteratorIndexed:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorIndexed_vtable) # high
	addiu	$2,$2,%lo(tListIteratorIndexed_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	sw	$2,12($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._20tListIteratorIndexed
	.align	2
	.globl	Value__20tListIteratorIndexed7tPlayer
	.ent	Value__20tListIteratorIndexed7tPlayer
Value__20tListIteratorIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,4($4)
	#nop
	addu	$2,$2,$3
	lbu	$2,0($2)
	j	$31
	.end	Value__20tListIteratorIndexed7tPlayer
	.align	2
	.globl	TextValue__20tListIteratorIndexed7tPlayer
	.ent	TextValue__20tListIteratorIndexed7tPlayer
TextValue__20tListIteratorIndexed7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,12($16)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sll	$2,$2,1
	lw	$3,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextValue__20tListIteratorIndexed7tPlayer
	.align	2
	.globl	Increment__20tListIteratorIndexed7tPlayer
	.ent	Increment__20tListIteratorIndexed7tPlayer
Increment__20tListIteratorIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	lw	$3,4($4)
	lbu	$2,0($2)
	#nop
	addu	$3,$3,$2
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,4($4)
	#nop
	addu	$5,$2,$3
	lbu	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	bne	$2,$0,$L628
	sb	$0,0($5)
$L628:
	j	$31
	.end	Increment__20tListIteratorIndexed7tPlayer
	.align	2
	.globl	Decrement__20tListIteratorIndexed7tPlayer
	.ent	Decrement__20tListIteratorIndexed7tPlayer
Decrement__20tListIteratorIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$6,16($4)
	lw	$5,4($4)
	lbu	$2,0($6)
	#nop
	addu	$3,$5,$2
	lbu	$2,0($3)
	#nop
	bne	$2,$0,$L630
	andi	$2,$2,0x00ff
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	blez	$2,$L636
$L633:
	lbu	$3,0($6)
	#nop
	addu	$3,$5,$3
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$6,16($4)
	lw	$5,4($4)
	lbu	$2,0($6)
	#nop
	addu	$2,$5,$2
	lbu	$2,0($2)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	bgtz	$2,$L633
	j	$31
$L630:
	addu	$2,$2,-1
	sb	$2,0($3)
$L636:
	j	$31
	.end	Decrement__20tListIteratorIndexed7tPlayer
	.align	2
	.globl	_._26tListIteratorDoubleIndexed
	.ent	_._26tListIteratorDoubleIndexed
_._26tListIteratorDoubleIndexed:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorDoubleIndexed_vtable) # high
	addiu	$2,$2,%lo(tListIteratorDoubleIndexed_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	sw	$2,12($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._26tListIteratorDoubleIndexed
	.align	2
	.globl	Value__26tListIteratorDoubleIndexed7tPlayer
	.ent	Value__26tListIteratorDoubleIndexed7tPlayer
Value__26tListIteratorDoubleIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,20($4)
	#nop
	mult	$3,$2
	lw	$2,24($4)
	lw	$3,4($4)
	lbu	$2,0($2)
	mflo	$5
	#nop
	#nop
	addu	$2,$5,$2
	addu	$3,$3,$2
	lbu	$2,0($3)
	j	$31
	.end	Value__26tListIteratorDoubleIndexed7tPlayer
	.align	2
	.globl	TextValue__26tListIteratorDoubleIndexed7tPlayer
	.ent	TextValue__26tListIteratorDoubleIndexed7tPlayer
TextValue__26tListIteratorDoubleIndexed7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,12($16)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sll	$2,$2,1
	lw	$3,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextValue__26tListIteratorDoubleIndexed7tPlayer
	.align	2
	.globl	Increment__26tListIteratorDoubleIndexed7tPlayer
	.ent	Increment__26tListIteratorDoubleIndexed7tPlayer
Increment__26tListIteratorDoubleIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,20($4)
	#nop
	mult	$3,$2
	lw	$2,24($4)
	lw	$3,4($4)
	lbu	$2,0($2)
	mflo	$6
	#nop
	#nop
	addu	$2,$6,$2
	addu	$3,$3,$2
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,20($4)
	#nop
	mult	$3,$2
	lw	$2,24($4)
	lw	$3,4($4)
	lbu	$2,0($2)
	mflo	$6
	#nop
	#nop
	addu	$2,$6,$2
	addu	$5,$3,$2
	lbu	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	bne	$2,$0,$L644
	sb	$0,0($5)
$L644:
	j	$31
	.end	Increment__26tListIteratorDoubleIndexed7tPlayer
	.align	2
	.globl	Decrement__26tListIteratorDoubleIndexed7tPlayer
	.ent	Decrement__26tListIteratorDoubleIndexed7tPlayer
Decrement__26tListIteratorDoubleIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$8,16($4)
	lw	$7,20($4)
	lbu	$2,0($8)
	#nop
	mult	$2,$7
	lw	$6,24($4)
	lw	$5,4($4)
	lbu	$2,0($6)
	mflo	$9
	#nop
	#nop
	addu	$2,$9,$2
	addu	$3,$5,$2
	lbu	$2,0($3)
	#nop
	bne	$2,$0,$L646
	andi	$2,$2,0x00ff
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	blez	$2,$L652
$L649:
	lbu	$2,0($8)
	#nop
	mult	$2,$7
	lbu	$3,0($6)
	mflo	$9
	#nop
	#nop
	addu	$3,$9,$3
	addu	$3,$5,$3
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$8,16($4)
	lw	$7,20($4)
	lbu	$2,0($8)
	#nop
	mult	$2,$7
	lw	$6,24($4)
	lw	$5,4($4)
	lbu	$2,0($6)
	mflo	$9
	#nop
	#nop
	addu	$2,$9,$2
	addu	$2,$5,$2
	lbu	$2,0($2)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	bgtz	$2,$L649
	j	$31
$L646:
	addu	$2,$2,-1
	sb	$2,0($3)
$L652:
	j	$31
	.end	Decrement__26tListIteratorDoubleIndexed7tPlayer
	.align	2
	.globl	_._24tListIteratorMultiPlayer
	.ent	_._24tListIteratorMultiPlayer
_._24tListIteratorMultiPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorMultiPlayer_vtable) # high
	addiu	$2,$2,%lo(tListIteratorMultiPlayer_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	sw	$2,12($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._24tListIteratorMultiPlayer
	.align	2
	.globl	Value__24tListIteratorMultiPlayer7tPlayer
	.ent	Value__24tListIteratorMultiPlayer7tPlayer
Value__24tListIteratorMultiPlayer7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	bne	$5,$2,$L657
	move	$5,$0
$L657:
	lw	$2,4($4)
	#nop
	addu	$2,$2,$5
	lbu	$2,0($2)
	j	$31
	.end	Value__24tListIteratorMultiPlayer7tPlayer
	.align	2
	.globl	TextValue__24tListIteratorMultiPlayer7tPlayer
	.ent	TextValue__24tListIteratorMultiPlayer7tPlayer
TextValue__24tListIteratorMultiPlayer7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,12($16)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sll	$2,$2,1
	lw	$3,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextValue__24tListIteratorMultiPlayer7tPlayer
	.align	2
	.globl	Increment__24tListIteratorMultiPlayer7tPlayer
	.ent	Increment__24tListIteratorMultiPlayer7tPlayer
Increment__24tListIteratorMultiPlayer7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	bne	$5,$2,$L660
	move	$5,$0
$L660:
	lw	$3,4($4)
	#nop
	addu	$3,$3,$5
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$2,4($4)
	#nop
	addu	$5,$2,$5
	lbu	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	bne	$2,$0,$L662
	sb	$0,0($5)
$L662:
	j	$31
	.end	Increment__24tListIteratorMultiPlayer7tPlayer
	.align	2
	.globl	Decrement__24tListIteratorMultiPlayer7tPlayer
	.ent	Decrement__24tListIteratorMultiPlayer7tPlayer
Decrement__24tListIteratorMultiPlayer7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	bne	$5,$2,$L664
	move	$5,$0
$L664:
	lw	$6,4($4)
	#nop
	addu	$3,$6,$5
	lbu	$2,0($3)
	#nop
	bne	$2,$0,$L665
	andi	$2,$2,0x00ff
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L672
	addu	$3,$6,$5
	.set	macro
	.set	reorder

$L670:
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$6,4($4)
	#nop
	addu	$2,$6,$5
	lbu	$2,0($2)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L670
	addu	$3,$6,$5
	.set	macro
	.set	reorder

$L672:
	j	$31
$L665:
	addu	$2,$2,-1
	sb	$2,0($3)
	j	$31
	.end	Decrement__24tListIteratorMultiPlayer7tPlayer
	.align	2
	.globl	__18tListIteratorRangeccPc
	.ent	__18tListIteratorRangeccPc
__18tListIteratorRangeccPc:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	move	$5,$0
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$6,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorRange_vtable) # high
	addiu	$3,$3,%lo(tListIteratorRange_vtable) # low
	sw	$3,12($2)
	sb	$17,8($2)
	sb	$18,9($2)
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

	.end	__18tListIteratorRangeccPc
	.align	2
	.globl	_._18tListIteratorRange
	.ent	_._18tListIteratorRange
_._18tListIteratorRange:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorRange_vtable) # high
	addiu	$2,$2,%lo(tListIteratorRange_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	sw	$2,12($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._18tListIteratorRange
	.align	2
	.globl	Value__18tListIteratorRange7tPlayer
	.ent	Value__18tListIteratorRange7tPlayer
Value__18tListIteratorRange7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	#nop
	lbu	$2,0($2)
	j	$31
	.end	Value__18tListIteratorRange7tPlayer
	.align	2
	.globl	TextValue__18tListIteratorRange7tPlayer
	.ent	TextValue__18tListIteratorRange7tPlayer
TextValue__18tListIteratorRange7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	TextValue__18tListIteratorRange7tPlayer
	.align	2
	.globl	Increment__18tListIteratorRange7tPlayer
	.ent	Increment__18tListIteratorRange7tPlayer
Increment__18tListIteratorRange7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,4($4)
	lbu	$2,9($4)
	lbu	$3,0($5)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L681
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sb	$2,0($5)
$L681:
	j	$31
	.end	Increment__18tListIteratorRange7tPlayer
	.align	2
	.globl	Decrement__18tListIteratorRange7tPlayer
	.ent	Decrement__18tListIteratorRange7tPlayer
Decrement__18tListIteratorRange7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,4($4)
	lbu	$2,8($4)
	lbu	$3,0($5)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L684
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sb	$2,0($5)
$L684:
	j	$31
	.end	Decrement__18tListIteratorRange7tPlayer
	.align	2
	.globl	__25tListIteratorRangeIndexedccPcT3
	.ent	__25tListIteratorRangeIndexedccPcT3
__25tListIteratorRangeIndexedccPcT3:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	andi	$5,$5,0x00ff
	sw	$17,20($sp)
	lw	$17,48($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorRangeccPc
	andi	$6,$6,0x00ff
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorRangeIndexed_vtable) # high
	addiu	$3,$3,%lo(tListIteratorRangeIndexed_vtable) # low
	sw	$3,12($2)
	sw	$17,16($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	__25tListIteratorRangeIndexedccPcT3
	.align	2
	.globl	_._25tListIteratorRangeIndexed
	.ent	_._25tListIteratorRangeIndexed
_._25tListIteratorRangeIndexed:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorRangeIndexed_vtable) # high
	addiu	$2,$2,%lo(tListIteratorRangeIndexed_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorRange
	sw	$2,12($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._25tListIteratorRangeIndexed
	.align	2
	.globl	Value__25tListIteratorRangeIndexed7tPlayer
	.ent	Value__25tListIteratorRangeIndexed7tPlayer
Value__25tListIteratorRangeIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,4($4)
	#nop
	addu	$2,$2,$3
	lbu	$2,0($2)
	j	$31
	.end	Value__25tListIteratorRangeIndexed7tPlayer
	.align	2
	.globl	Increment__25tListIteratorRangeIndexed7tPlayer
	.ent	Increment__25tListIteratorRangeIndexed7tPlayer
Increment__25tListIteratorRangeIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,4($4)
	#nop
	addu	$5,$2,$3
	lbu	$3,0($5)
	lbu	$2,9($4)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L692
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sb	$2,0($5)
$L692:
	j	$31
	.end	Increment__25tListIteratorRangeIndexed7tPlayer
	.align	2
	.globl	Decrement__25tListIteratorRangeIndexed7tPlayer
	.ent	Decrement__25tListIteratorRangeIndexed7tPlayer
Decrement__25tListIteratorRangeIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$3,0($2)
	lw	$2,4($4)
	#nop
	addu	$5,$2,$3
	lbu	$3,0($5)
	lbu	$2,8($4)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L695
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sb	$2,0($5)
$L695:
	j	$31
	.end	Decrement__25tListIteratorRangeIndexed7tPlayer
	.align	2
	.globl	__9tMenuItemUi
	.ent	__9tMenuItemUi
__9tMenuItemUi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(tMenuItem_vtable) # high
	addiu	$3,$3,%lo(tMenuItem_vtable) # low
	sw	$3,24($2)
	li	$3,-1			# 0xffffffff
	sw	$5,4($2)
	sw	$0,0($2)
	sh	$0,8($2)
	sw	$3,12($2)
	sw	$0,16($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,20($2)
	.set	macro
	.set	reorder

	.end	__9tMenuItemUi
	.align	2
	.globl	_._9tMenuItem
	.ent	_._9tMenuItem
_._9tMenuItem:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItem_vtable) # high
	addiu	$2,$2,%lo(tMenuItem_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L701
	sw	$2,24($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L701:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._9tMenuItem
	.align	2
	.globl	DebounceKeys__9tMenuItem
	.ent	DebounceKeys__9tMenuItem
DebounceKeys__9tMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.end	DebounceKeys__9tMenuItem
	.align	2
	.globl	ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	UpdateTransition__9tMenuItemb
	.ent	UpdateTransition__9tMenuItemb
UpdateTransition__9tMenuItemb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	UpdateSelFade__9tMenuItemb
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateTransition__9tMenuItemb
	.align	2
	.globl	TransitionIsFinished__9tMenuItem
	.ent	TransitionIsFinished__9tMenuItem
TransitionIsFinished__9tMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__9tMenuItem
	.align	2
	.globl	UpdateSelFade__9tMenuItemb
	.ent	UpdateSelFade__9tMenuItemb
UpdateSelFade__9tMenuItemb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	beq	$5,$0,$L707
	lhu	$2,8($4)
	.set	noreorder
	.set	nomacro
	j	$L711
	addu	$2,$2,64
	.set	macro
	.set	reorder

$L707:
	lhu	$2,8($4)
	#nop
	addu	$2,$2,-10
$L711:
	sh	$2,8($4)
	lh	$2,8($4)
	#nop
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,8($4)
$L709:
	lh	$2,8($4)
	#nop
	bgez	$2,$L712
	sh	$0,8($4)
$L712:
	j	$31
	.end	UpdateSelFade__9tMenuItemb
	.align	2
	.globl	Draw__9tMenuItemiib
	.ent	Draw__9tMenuItemiib
Draw__9tMenuItemiib:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,24($4)
	#nop
	lh	$2,32($3)
	#nop
	addu	$4,$4,$2
	lw	$2,36($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$7
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Draw__9tMenuItemiib
	.align	2
	.globl	Draw__9tMenuItemiiib
	.ent	Draw__9tMenuItemiiib
Draw__9tMenuItemiiib:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	lw	$3,24($4)
	move	$7,$6
	lh	$2,48($3)
	move	$6,$5
	sw	$0,16($sp)
	lw	$5,48($sp)
	addu	$4,$4,$2
	lw	$2,52($3)
	#nop
	jal	$31,$2
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Draw__9tMenuItemiiib
	.align	2
	.globl	__20tMenuItemInteractiveUi
	.ent	__20tMenuItemInteractiveUi
__20tMenuItemInteractiveUi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuItemUi
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(tMenuItemInteractive_vtable) # high
	addiu	$2,$2,%lo(tMenuItemInteractive_vtable) # low
	sw	$2,24($16)
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__20tMenuItemInteractiveUi
	.align	2
	.globl	_._20tMenuItemInteractive
	.ent	_._20tMenuItemInteractive
_._20tMenuItemInteractive:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemInteractive_vtable) # high
	addiu	$2,$2,%lo(tMenuItemInteractive_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuItem
	sw	$2,24($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._20tMenuItemInteractive
	.align	2
	.globl	__24tMenuItemLeftRightChoiceUiP13tListIterator
	.ent	__24tMenuItemLeftRightChoiceUiP13tListIterator
__24tMenuItemLeftRightChoiceUiP13tListIterator:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__20tMenuItemInteractiveUi
	move	$17,$6
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuItemLeftRightChoice_vtable) # high
	lw	$4,0($2)
	addiu	$3,$3,%lo(tMenuItemLeftRightChoice_vtable) # low
	sw	$3,24($2)
	sw	$17,28($2)
	ori	$4,$4,0x0400
	sw	$4,0($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	__24tMenuItemLeftRightChoiceUiP13tListIterator
	.align	2
	.globl	_._24tMenuItemLeftRightChoice
	.ent	_._24tMenuItemLeftRightChoice
_._24tMenuItemLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemLeftRightChoice_vtable) # high
	addiu	$2,$2,%lo(tMenuItemLeftRightChoice_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._20tMenuItemInteractive
	sw	$2,24($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._24tMenuItemLeftRightChoice
	.align	2
	.globl	ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$16,24($sp)
	lw	$2,0($4)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L723
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L726
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	beq	$3,$2,$L727
	j	$L723
$L726:
	lw	$3,28($4)
	#nop
	lw	$2,12($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L725
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

$L727:
	lw	$3,28($4)
	#nop
	lw	$2,12($3)
	#nop
	lh	$4,32($2)
	lw	$2,36($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
$L725:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L723:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	Draw__24tMenuItemLeftRightChoiceb
	.ent	Draw__24tMenuItemLeftRightChoiceb
Draw__24tMenuItemLeftRightChoiceb:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$19,$5
	.set	macro
	.set	reorder

	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	sll	$5,$16,16
	sra	$5,$5,16
	sll	$18,$2,16
	sra	$18,$18,16
	move	$6,$18
	sltu	$19,$0,$19
	move	$7,$19
	lh	$4,4($17)
	li	$20,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	lw	$6,28($17)
	lui	$2,%hi(gMenu_SubMenuPlayer) # high
	lw	$3,12($6)
	lw	$5,%lo(gMenu_SubMenuPlayer)($2)
	lh	$4,24($3)
	lw	$2,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$6,$4
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$4,$2,16
	addu	$16,$16,180
	sll	$16,$16,16
	sra	$5,$16,16
	move	$6,$18
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Draw__24tMenuItemLeftRightChoiceb
	.align	2
	.globl	__24tMenuItemLeftRightSliderUiP13tListIterator
	.ent	__24tMenuItemLeftRightSliderUiP13tListIterator
__24tMenuItemLeftRightSliderUiP13tListIterator:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__20tMenuItemInteractiveUi
	move	$17,$6
	.set	macro
	.set	reorder

	lw	$3,0($16)
	move	$2,$16
	sw	$17,28($2)
	ori	$3,$3,0x0080
	sw	$3,0($2)
	lui	$3,%hi(tMenuItemLeftRightSlider_vtable) # high
	lw	$4,0($2)
	addiu	$3,$3,%lo(tMenuItemLeftRightSlider_vtable) # low
	sw	$3,24($2)
	ori	$4,$4,0x0080
	sw	$4,0($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	__24tMenuItemLeftRightSliderUiP13tListIterator
	.align	2
	.globl	_._24tMenuItemLeftRightSlider
	.ent	_._24tMenuItemLeftRightSlider
_._24tMenuItemLeftRightSlider:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemLeftRightSlider_vtable) # high
	addiu	$2,$2,%lo(tMenuItemLeftRightSlider_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._20tMenuItemInteractive
	sw	$2,24($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._24tMenuItemLeftRightSlider
	.align	2
	.globl	DebounceKeys__24tMenuItemLeftRightSlider
	.ent	DebounceKeys__24tMenuItemLeftRightSlider
DebounceKeys__24tMenuItemLeftRightSlider:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1536			# 0x00000600
	.set	macro
	.set	reorder

	.end	DebounceKeys__24tMenuItemLeftRightSlider
	.align	2
	.globl	ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$16,24($sp)
	lw	$2,0($4)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L738
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L741
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	beq	$3,$2,$L742
	j	$L738
$L741:
	lw	$3,28($4)
	#nop
	lw	$2,12($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	j	$L746
$L742:
	lw	$3,28($4)
	#nop
	lw	$2,12($3)
	#nop
	lh	$4,32($2)
	lw	$2,36($2)
$L746:
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	li	$4,21			# 0x00000015
	li	$5,64			# 0x00000040
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	.set	noreorder
	jal	AudioCmn_PlayFESFXVol__Fii
	sw	$2,0($16)
	.set	reorder
	.set	macro
	.set	reorder

$L738:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	DrawSlider__FsssssssssbT9ss
	.ent	DrawSlider__FsssssssssbT9ss
DrawSlider__FsssssssssbT9ss:
	.frame	$sp,112,$31		# vars= 56, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sll	$4,$4,16
	sra	$4,$4,16
	sll	$5,$5,16
	sra	$5,$5,16
	lh	$8,132($sp)
	subu	$4,$4,$5
	mult	$4,$8
	sll	$6,$6,16
	mflo	$9
	#nop
	sra	$6,$6,16
	subu	$6,$6,$5
	div	$6,$9,$6
	sw	$19,84($sp)
	lhu	$19,128($sp)
	lhu	$10,136($sp)
	sw	$23,100($sp)
	lhu	$23,140($sp)
	sw	$20,88($sp)
	lhu	$20,160($sp)
	lw	$5,156($sp)
	sw	$22,96($sp)
	li	$22,13107200			# 0x00c80000
	sh	$10,16($sp)
	lhu	$10,144($sp)
	lh	$9,156($sp)
	lw	$4,132($sp)
	sltu	$2,$9,1
	sh	$2,40($sp)
	lw	$2,148($sp)
	ori	$22,$22,0x3c1e
	sw	$31,108($sp)
	sw	$fp,104($sp)
	sw	$21,92($sp)
	sw	$18,80($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	sh	$10,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	sh	$6,32($sp)
	.set	macro
	.set	reorder

	sll	$2,$7,16
	sra	$3,$2,16
	addu	$4,$3,$8
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L758
	move	$17,$7
	.set	macro
	.set	reorder

	li	$10,528482304			# 0x1f800000
	ori	$10,$10,0x0004
	li	$21,16711680			# 0x00ff0000
	ori	$21,$21,0xffff
	move	$fp,$9
	move	$18,$8
	sw	$10,52($sp)
	sw	$3,56($sp)
	sw	$4,48($sp)
$L751:
	lw	$10,52($sp)
	lw	$4,528482304
	lw	$16,0($10)
	li	$10,-16777216			# 0xff000000
	lw	$2,0($4)
	lw	$3,0($16)
	and	$2,$2,$21
	and	$3,$3,$10
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$3,0($4)
	lw	$10,52($sp)
	addu	$2,$16,24
	sw	$2,0($10)
	li	$10,-16777216			# 0xff000000
	and	$3,$3,$10
	and	$2,$16,$21
	or	$3,$3,$2
	sw	$3,0($4)
	addu	$3,$17,$23
	sh	$17,8($16)
	sh	$19,10($16)
	sh	$3,12($16)
	sh	$19,14($16)
	sh	$17,16($16)
	lhu	$10,16($sp)
	sh	$3,20($16)
	addu	$2,$19,$10
	sh	$2,18($16)
	sh	$2,22($16)
	lw	$10,152($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$10,$0,$L752
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$17,16
	lhu	$10,32($sp)
	sra	$4,$2,16
	sll	$2,$10,16
	lw	$10,56($sp)
	sra	$2,$2,16
	addu	$2,$10,$2
	slt	$2,$4,$2
	beq	$2,$0,$L753
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L754
	subu	$4,$4,$10
	.set	macro
	.set	reorder

	sll	$7,$4,1
	addu	$7,$7,$4
	sll	$7,$7,5
	subu	$7,$7,$4
	sll	$7,$7,1
	div	$7,$7,$18
	sll	$3,$4,5
	subu	$3,$3,$4
	sll	$3,$3,2
	div	$3,$3,$18
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$5,$2,4
	subu	$5,$5,$2
	sll	$5,$5,1
	subu	$5,$0,$5
	div	$5,$5,$18
	move	$4,$22
	lhu	$10,40($sp)
	move	$6,$fp
	move	$2,$10
	sra	$7,$7,$2
	sll	$7,$7,16
	sra	$7,$7,16
	addu	$3,$3,66
	sra	$3,$3,$2
	sll	$3,$3,16
	sra	$3,$3,8
	or	$7,$7,$3
	addu	$5,$5,210
	sra	$5,$5,$2
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	or	$5,$7,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L769
	move	$4,$2
	.set	macro
	.set	reorder

$L754:
	.set	noreorder
	.set	nomacro
	j	$L769
	move	$4,$22
	.set	macro
	.set	reorder

$L753:
	li	$4,2621440			# 0x00280000
	ori	$4,$4,0x0f00
$L769:
	sll	$5,$20,16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sra	$5,$5,16
	.set	macro
	.set	reorder

	move	$5,$2
$L752:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetPolyF4
	sw	$5,4($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetSemiTrans
	move	$5,$0
	.set	macro
	.set	reorder

	lhu	$10,24($sp)
	#nop
	addu	$2,$23,$10
	addu	$2,$17,$2
	move	$17,$2
	sll	$2,$2,16
	lw	$10,48($sp)
	sra	$2,$2,16
	slt	$2,$2,$10
	beq	$2,$0,$L758
	j	$L751
$L748:
	addu	$2,$7,$4
	addu	$2,$2,-1
	move	$17,$2
 #APP
 #NO_APP
	sll	$3,$7,16
	sll	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L758
	sra	$4,$3,16
	.set	macro
	.set	reorder

	li	$10,528482304			# 0x1f800000
	ori	$10,$10,0x0004
	li	$21,16711680			# 0x00ff0000
	ori	$21,$21,0xffff
	move	$18,$8
	sw	$10,60($sp)
	sw	$4,64($sp)
	addu	$10,$4,$18
	move	$fp,$9
	sw	$10,68($sp)
$L761:
	lw	$10,60($sp)
	lw	$4,528482304
	lw	$16,0($10)
	li	$10,-16777216			# 0xff000000
	lw	$2,0($4)
	lw	$3,0($16)
	and	$2,$2,$21
	and	$3,$3,$10
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$3,0($4)
	lw	$10,60($sp)
	addu	$2,$16,24
	sw	$2,0($10)
	li	$10,-16777216			# 0xff000000
	and	$3,$3,$10
	and	$2,$16,$21
	or	$3,$3,$2
	sw	$3,0($4)
	addu	$3,$17,$23
	sh	$17,8($16)
	sh	$19,10($16)
	sh	$3,12($16)
	sh	$19,14($16)
	sh	$17,16($16)
	lhu	$10,16($sp)
	sh	$3,20($16)
	addu	$2,$19,$10
	sh	$2,18($16)
	sh	$2,22($16)
	lw	$10,152($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$10,$0,$L762
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$17,16
	lhu	$10,32($sp)
	sra	$3,$2,16
	sll	$2,$10,16
	lw	$10,68($sp)
	sra	$2,$2,16
	subu	$2,$10,$2
	slt	$2,$3,$2
	bne	$2,$0,$L763
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L764
	subu	$4,$10,$3
	.set	macro
	.set	reorder

	sll	$7,$4,1
	addu	$7,$7,$4
	sll	$7,$7,5
	subu	$7,$7,$4
	sll	$7,$7,1
	div	$7,$7,$18
	sll	$3,$4,5
	subu	$3,$3,$4
	sll	$3,$3,2
	div	$3,$3,$18
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$5,$2,4
	subu	$5,$5,$2
	sll	$5,$5,1
	subu	$5,$0,$5
	div	$5,$5,$18
	move	$4,$22
	lhu	$10,40($sp)
	move	$6,$fp
	move	$2,$10
	sra	$7,$7,$2
	sll	$7,$7,16
	sra	$7,$7,16
	addu	$3,$3,66
	sra	$3,$3,$2
	sll	$3,$3,16
	sra	$3,$3,8
	or	$7,$7,$3
	addu	$5,$5,210
	sra	$5,$5,$2
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	or	$5,$7,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L765
	move	$5,$2
	.set	macro
	.set	reorder

$L764:
	move	$5,$22
$L765:
	.set	noreorder
	.set	nomacro
	j	$L770
	move	$4,$5
	.set	macro
	.set	reorder

$L763:
	li	$4,2621440			# 0x00280000
	ori	$4,$4,0x0f00
$L770:
	sll	$5,$20,16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sra	$5,$5,16
	.set	macro
	.set	reorder

	move	$5,$2
$L762:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetPolyF4
	sw	$5,4($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetSemiTrans
	move	$5,$0
	.set	macro
	.set	reorder

	lhu	$10,24($sp)
	#nop
	addu	$2,$23,$10
	subu	$2,$17,$2
	move	$17,$2
	sll	$2,$2,16
	lw	$10,64($sp)
	sra	$2,$2,16
	slt	$2,$2,$10
	beq	$2,$0,$L761
$L758:
 #APP
 #NO_APP
	lw	$31,108($sp)
	lw	$fp,104($sp)
	lw	$23,100($sp)
	lw	$22,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	DrawSlider__FsssssssssbT9ss
	.align	2
	.globl	Draw__24tMenuItemLeftRightSliderb
	.ent	Draw__24tMenuItemLeftRightSliderb
Draw__24tMenuItemLeftRightSliderb:
	.frame	$sp,72,$31		# vars= 0, regs= 4/0, args= 56, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$17,60($sp)
	move	$17,$4
	sw	$31,68($sp)
	sw	$18,64($sp)
	sw	$16,56($sp)
	lw	$2,32($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L772
	move	$18,$5
	.set	macro
	.set	reorder

	lw	$4,4($17)
	jal	TextSys_WordX__Fi
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sh	$2,32($17)
	.set	macro
	.set	reorder

	sh	$2,34($17)
$L772:
	sltu	$7,$0,$18
	lh	$4,4($17)
	lhu	$5,32($17)
	lhu	$6,34($17)
	li	$16,6			# 0x00000006
	sw	$16,16($sp)
	addu	$5,$5,8
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,3
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lw	$3,28($17)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	andi	$8,$2,0x00ff
	li	$2,4			# 0x00000004
	lhu	$3,34($17)
	lw	$4,28($17)
	addu	$3,$3,4
	sll	$3,$3,16
	lbu	$5,8($4)
	lbu	$6,9($4)
	lhu	$4,32($17)
	sra	$3,$3,16
	sw	$3,16($sp)
	lh	$3,36($17)
	addu	$4,$4,115
	sll	$4,$4,16
	sw	$3,20($sp)
	lh	$3,38($17)
	sra	$7,$4,16
	sw	$16,28($sp)
	sw	$2,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L773
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	j	$L774
	sw	$2,44($sp)
	.set	macro
	.set	reorder

$L773:
	sw	$0,44($sp)
$L774:
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$0,48($sp)
	.set	macro
	.set	reorder

	lw	$31,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Draw__24tMenuItemLeftRightSliderb
	.align	2
	.globl	SetDimensions__24tMenuItemLeftRightSliderssss
	.ent	SetDimensions__24tMenuItemLeftRightSliderssss
SetDimensions__24tMenuItemLeftRightSliderssss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	sh	$5,32($4)
	sh	$6,34($4)
	sh	$7,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,38($4)
	.set	macro
	.set	reorder

	.end	SetDimensions__24tMenuItemLeftRightSliderssss
	.align	2
	.globl	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
	.ent	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__20tMenuItemInteractiveUi
	move	$18,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuItemGoToMenuButton_vtable) # high
	addiu	$3,$3,%lo(tMenuItemGoToMenuButton_vtable) # low
	sw	$3,24($2)
	sw	$17,20($2)
	sw	$18,28($2)
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

	.end	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
	.align	2
	.globl	_._23tMenuItemGoToMenuButton
	.ent	_._23tMenuItemGoToMenuButton
_._23tMenuItemGoToMenuButton:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemGoToMenuButton_vtable) # high
	addiu	$2,$2,%lo(tMenuItemGoToMenuButton_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._20tMenuItemInteractive
	sw	$2,24($4)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._23tMenuItemGoToMenuButton
	.align	2
	.globl	ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$16,24($sp)
	lw	$5,0($4)
	#nop
	andi	$2,$5,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L789
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L789
	lw	$2,20($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L785
	andi	$2,$5,0x0040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L786
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L787
	sw	$3,0($7)
	.set	macro
	.set	reorder

$L786:
	sw	$2,0($7)
$L787:
	lw	$2,20($4)
	#nop
	sw	$2,4($7)
$L785:
	lw	$2,28($4)
	#nop
	beq	$2,$0,$L788
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$7
	.set	macro
	.set	reorder

$L788:
	li	$2,1			# 0x00000001
	sw	$2,0($16)
$L789:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	tMenuConstructor__5tMenuP9tMenuItemPv
	.ent	tMenuConstructor__5tMenuP9tMenuItemPv
tMenuConstructor__5tMenuP9tMenuItemPv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$0
	sh	$0,100($4)
	sw	$5,16($4)
$L793:
	addu	$6,$6,4
	addu	$5,$2,1
	sll	$2,$5,2
	lw	$3,-4($6)
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L796
	sw	$3,16($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L793
	move	$2,$5
	.set	macro
	.set	reorder

$L796:
	j	$31
	.end	tMenuConstructor__5tMenuP9tMenuItemPv
	.align	2
	.globl	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	.ent	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(tMenu_vtable) # high
	lw	$4,16($sp)
	lw	$8,20($sp)
	lw	$9,24($sp)
	addiu	$3,$3,%lo(tMenu_vtable) # low
	sw	$3,104($2)
	sw	$5,0($2)
	sw	$0,8($2)
	sw	$6,80($2)
	sw	$7,84($2)
	sw	$0,12($2)
	sw	$0,88($2)
	sw	$4,92($2)
	sw	$8,96($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$9,4($2)
	.set	macro
	.set	reorder

	.end	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	.align	2
	.globl	_._5tMenu
	.ent	_._5tMenu
_._5tMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenu_vtable) # high
	addiu	$2,$2,%lo(tMenu_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L802
	sw	$2,104($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L802:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._5tMenu
	.align	2
	.globl	Initialize__5tMenu
	.ent	Initialize__5tMenu
Initialize__5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,8($4)
	#nop
	sll	$2,$3,2
	addu	$2,$4,$2
	lw	$2,16($2)
	#nop
	lw	$2,0($2)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L811
	move	$5,$3
	.set	macro
	.set	reorder

$L805:
	lw	$3,8($4)
	#nop
	sll	$2,$3,2
	addu	$2,$4,$2
	lw	$2,16($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L811
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,8($4)
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$2,16($2)
	#nop
	bne	$2,$0,$L807
	sw	$0,8($4)
$L807:
	lw	$2,8($4)
	#nop
	bne	$5,$2,$L805
$L811:
	j	$31
	.end	Initialize__5tMenu
	.align	2
	.globl	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$6
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$2,0($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L813
	move	$17,$7
	.set	macro
	.set	reorder

	lw	$3,0($18)
	li	$2,8192			# 0x00002000
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L813
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,0($18)
$L813:
	lw	$2,0($16)
	li	$3,65536			# 0x00010000
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L814
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L814
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	sw	$2,0($18)
$L814:
	lw	$2,8($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$3,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L815
	move	$6,$18
	.set	macro
	.set	reorder

	lw	$2,24($3)
	move	$7,$17
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L815:
	lw	$3,0($18)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L847
	slt	$2,$3,17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L850
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L844
	slt	$2,$3,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L851
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$2,$L836
	j	$L812
$L851:
	li	$2,8			# 0x00000008
	beq	$3,$2,$L845
	j	$L812
$L850:
	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L829
	slt	$2,$3,1025
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L852
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

	beq	$3,$2,$L817
	j	$L812
$L852:
	li	$2,8192			# 0x00002000
	beq	$3,$2,$L838
	j	$L812
$L817:
	lw	$4,8($16)
$L818:
	lw	$2,8($16)
	#nop
	blez	$2,$L821
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L820
	sw	$2,8($16)
	.set	macro
	.set	reorder

$L821:
	addu	$2,$2,1
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	beq	$2,$0,$L820
$L825:
	lw	$2,8($16)
	#nop
	addu	$3,$2,1
	addu	$2,$2,2
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$3,8($16)
	lw	$2,16($2)
	#nop
	bne	$2,$0,$L825
$L820:
	lw	$3,8($16)
	#nop
	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L818
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L857
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L857
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L829:
	lw	$4,8($16)
$L830:
	lw	$2,8($16)
	#nop
	addu	$2,$2,1
	sw	$2,8($16)
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	bne	$2,$0,$L832
	sw	$0,8($16)
$L832:
	lw	$3,8($16)
	#nop
	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L830
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L857
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L857
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L836:
	lw	$2,84($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$3,0($17)
	lw	$2,84($16)
	.set	noreorder
	.set	nomacro
	j	$L858
	sw	$2,4($17)
	.set	macro
	.set	reorder

$L838:
	lw	$2,96($16)
	#nop
	beq	$2,$0,$L839
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L857
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L839:
	lw	$4,0($16)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L856
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	andi	$2,$4,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L844:
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	.set	noreorder
	.set	nomacro
	jal	DisplayHelp__14tFEApplications
	move	$5,$0
	.set	macro
	.set	reorder

	j	$L812
$L845:
	lw	$2,92($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$3,0($17)
	lw	$2,92($16)
	#nop
	sw	$2,4($17)
$L858:
	.set	noreorder
	.set	nomacro
	j	$L812
	sw	$3,0($18)
	.set	macro
	.set	reorder

$L847:
	li	$2,4			# 0x00000004
$L856:
	sw	$2,0($17)
$L859:
	li	$2,1			# 0x00000001
$L857:
	sw	$2,0($18)
$L812:
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

	.end	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	GetNumberEnabledItems__5tMenu
	.ent	GetNumberEnabledItems__5tMenu
GetNumberEnabledItems__5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,12($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L861
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L861:
	move	$3,$5
$L862:
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$4,$2
	lw	$2,16($2)
	#nop
	beq	$2,$0,$L863
	lw	$2,0($2)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	beq	$2,$0,$L864
	addu	$5,$5,1
$L864:
	.set	noreorder
	.set	nomacro
	j	$L862
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L863:
	sll	$2,$5,16
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.end	GetNumberEnabledItems__5tMenu
	.align	2
	.globl	Draw__5tMenu
	.ent	Draw__5tMenu
Draw__5tMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lh	$4,4($17)
	#nop
	bltz	$4,$L868
	jal	FETextRender_Title__Fs
$L868:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L867
	move	$16,$0
	.set	macro
	.set	reorder

$L871:
	sll	$5,$16,16
	sra	$5,$5,16
	sll	$2,$5,2
	addu	$2,$17,$2
	lw	$3,16($2)
	lw	$2,8($17)
	#nop
	xor	$5,$5,$2
	lw	$6,24($3)
	sltu	$5,$5,1
	lh	$4,32($6)
	lw	$2,36($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L871
	move	$16,$3
	.set	macro
	.set	reorder

$L867:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Draw__5tMenu
	.align	2
	.globl	UpdateTransition__5tMenu
	.ent	UpdateTransition__5tMenu
UpdateTransition__5tMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L874
	move	$16,$0
	.set	macro
	.set	reorder

$L877:
	sll	$3,$16,16
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	lw	$6,24($2)
	lw	$5,8($17)
	lh	$4,80($6)
	xor	$5,$5,$3
	addu	$4,$2,$4
	lw	$2,84($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sltu	$5,$5,1
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L877
	move	$16,$3
	.set	macro
	.set	reorder

$L874:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	UpdateTransition__5tMenu
	.align	2
	.globl	TransitionOff__5tMenu
	.ent	TransitionOff__5tMenu
TransitionOff__5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	TransitionOff__5tMenu
	.align	2
	.globl	TransitionOn__5tMenu
	.ent	TransitionOn__5tMenu
TransitionOn__5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	TransitionOn__5tMenu
	.align	2
	.globl	TransitionIsFinished__5tMenu
	.ent	TransitionIsFinished__5tMenu
TransitionIsFinished__5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__5tMenu
	.align	2
	.globl	IsSubMenu__5tMenu
	.ent	IsSubMenu__5tMenu
IsSubMenu__5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	IsSubMenu__5tMenu
	.align	2
	.globl	DebounceKeys__5tMenu
	.ent	DebounceKeys__5tMenu
DebounceKeys__5tMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,8($4)
	#nop
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$3,16($4)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DebounceKeys__5tMenu
	.align	2
	.globl	TransitionOn__9tMenuItem
	.ent	TransitionOn__9tMenuItem
TransitionOn__9tMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	TransitionOn__9tMenuItem
	.align	2
	.globl	TransitionOff__9tMenuItem
	.ent	TransitionOff__9tMenuItem
TransitionOff__9tMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	TransitionOff__9tMenuItem
