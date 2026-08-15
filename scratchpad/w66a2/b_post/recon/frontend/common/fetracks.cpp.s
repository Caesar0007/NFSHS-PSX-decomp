	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fetracks.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	gTrackInfo_FETrackList
	.data
	.align	2
gTrackInfo_FETrackList:
	.byte	102
	.byte	101
	.byte	116
	.byte	114
	.byte	107
	.byte	46
	.byte	116
	.byte	114
	.byte	107
	.byte	107
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	172
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	204
	.space	2
	.space	24
	.globl	gTrackInfo_Tourney
	.align	2
gTrackInfo_Tourney:
	.byte	116
	.byte	111
	.byte	117
	.byte	114
	.byte	110
	.byte	46
	.byte	116
	.byte	114
	.byte	110
	.byte	110
	.byte	30
	.byte	5
	.byte	0
	.byte	0
	.byte	30
	.byte	0
	.byte	30
	.byte	0
	.byte	30
	.byte	0
	.byte	0
	.byte	30
	.space	2
	.space	24
	.globl	CountryMeasurement
	.align	2
CountryMeasurement:
	.half	0
	.half	1
	.half	0
	.half	1
	.half	1
	.half	0
	.half	1
	.half	1
	.text
	.align	2
	.globl	Initialize__13tTrackManager
	.ent	Initialize__13tTrackManager
Initialize__13tTrackManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	sw	$0,0($4)
	sw	$0,4($4)
$L601:
	sll	$3,$5,16
	addu	$2,$5,1
	move	$5,$2
	sra	$3,$3,14
	addu	$3,$4,$3
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,16
	sw	$0,8($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	sw	$0,72($3)
	.set	macro
	.set	reorder

	j	$31
	.end	Initialize__13tTrackManager
	.align	2
	.globl	LoadTracks__13tTrackManagerR14tSaveTrackInfo
	.ent	LoadTracks__13tTrackManagerR14tSaveTrackInfo
LoadTracks__13tTrackManagerR14tSaveTrackInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
$L606:
	addu	$2,$5,$3
	lbu	$2,0($2)
	addu	$3,$3,1
	sltu	$2,$0,$2
	sw	$2,8($4)
	sltu	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	addu	$4,$4,4
	.set	macro
	.set	reorder

	j	$31
	.end	LoadTracks__13tTrackManagerR14tSaveTrackInfo
	.align	2
	.globl	SaveTracks__13tTrackManagerR14tSaveTrackInfo
	.ent	SaveTracks__13tTrackManagerR14tSaveTrackInfo
SaveTracks__13tTrackManagerR14tSaveTrackInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
$L611:
	lbu	$3,8($4)
	addu	$2,$5,$6
	addu	$6,$6,1
	sb	$3,0($2)
	sltu	$2,$6,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	addu	$4,$4,4
	.set	macro
	.set	reorder

	j	$31
	.end	SaveTracks__13tTrackManagerR14tSaveTrackInfo
	.align	2
	.globl	GetTrack__13tTrackManagersR17tTrackInformation
	.ent	GetTrack__13tTrackManagersR17tTrackInformation
GetTrack__13tTrackManagersR17tTrackInformation:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$4,$5,1
	addu	$4,$4,$5
	sll	$4,$4,4
	move	$5,$17
	sw	$31,24($sp)
	lw	$2,4($16)
	li	$6,48			# 0x00000030
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lb	$2,0($17)
	#nop
	sll	$2,$2,2
	addu	$16,$16,$2
	lbu	$2,8($16)
	#nop
	sb	$2,3($17)
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

	.end	GetTrack__13tTrackManagersR17tTrackInformation
	.rdata
	.align	2
$LC0:
	.ascii	"%s%s\000"
	.align	2
$LC1:
	.ascii	"fetrk.trk\000"
	.align	2
$LC2:
	.ascii	"Track List\000"
	.text
	.align	2
	.globl	LoadDescription__13tTrackManager
	.ent	LoadDescription__13tTrackManager
LoadDescription__13tTrackManager:
	.frame	$sp,112,$31		# vars= 80, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$16,96($sp)
	move	$16,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	lui	$2,%hi(Paths_Paths+148) # high
	lui	$7,%hi($LC1) # high
	lw	$6,%lo(Paths_Paths+148)($2)
	addiu	$7,$7,%lo($LC1) # low
	sw	$31,104($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$17,100($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ReleaseDescription__13tTrackManager
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	move	$17,$2
	lw	$2,0($17)
	move	$6,$0
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,4
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,0($16)
	.set	macro
	.set	reorder

	addu	$4,$17,4
	lw	$3,0($16)
	move	$5,$2
	sw	$5,4($16)
	sll	$6,$3,1
	addu	$6,$6,$3
	.set	noreorder
	.set	nomacro
	jal	blockmove
	sll	$6,$6,4
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	move	$5,$0
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
	move	$4,$5
$L618:
	lw	$2,4($16)
	#nop
	addu	$3,$4,$2
	lbu	$2,3($3)
	#nop
	beq	$2,$0,$L621
	lb	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$6,8($2)
$L621:
	lw	$2,4($16)
	#nop
	addu	$3,$4,$2
	lbu	$2,4($3)
	#nop
	bne	$2,$0,$L622
	lb	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$6,72($2)
$L622:
	lw	$2,0($16)
	addu	$5,$5,1
	sltu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	addu	$4,$4,48
	.set	macro
	.set	reorder

$L617:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$31,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	LoadDescription__13tTrackManager
	.align	2
	.globl	ReleaseDescription__13tTrackManager
	.ent	ReleaseDescription__13tTrackManager
ReleaseDescription__13tTrackManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,4($16)
	#nop
	beq	$4,$0,$L625
	jal	purgememadr
$L625:
	sw	$0,4($16)
	sw	$0,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ReleaseDescription__13tTrackManager
	.align	2
	.globl	SetTrackAvailable__13tTrackManagersb
	.ent	SetTrackAvailable__13tTrackManagersb
SetTrackAvailable__13tTrackManagersb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$5,$5,16
	sra	$5,$5,14
	addu	$4,$4,$5
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,8($4)
	.set	macro
	.set	reorder

	.end	SetTrackAvailable__13tTrackManagersb
	.align	2
	.globl	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	.ent	SetClassAvailable__13tTrackManager15tTrackClassTypeb
SetClassAvailable__13tTrackManager15tTrackClassTypeb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	move	$7,$0
	.set	macro
	.set	reorder

	move	$8,$7
$L631:
	lw	$2,4($4)
	#nop
	addu	$3,$8,$2
	lbu	$2,2($3)
	#nop
	bne	$2,$5,$L630
	lb	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$4,$2
	sw	$6,8($2)
$L630:
	lw	$2,0($4)
	addu	$7,$7,1
	sltu	$2,$7,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L631
	addu	$8,$8,48
	.set	macro
	.set	reorder

$L634:
	j	$31
	.end	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	.align	2
	.globl	GetTrackByID__13tTrackManagers
	.ent	GetTrackByID__13tTrackManagers
GetTrackByID__13tTrackManagers:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L637
	move	$6,$0
	.set	macro
	.set	reorder

	sll	$2,$5,16
	sra	$7,$2,16
	move	$5,$3
	lw	$3,4($4)
$L639:
	lb	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$7,$L638
	addu	$6,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

$L638:
	sltu	$2,$6,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	addu	$3,$3,48
	.set	macro
	.set	reorder

$L637:
	lw	$2,4($4)
	j	$31
	.end	GetTrackByID__13tTrackManagers
	.align	2
	.globl	__18tListIteratorTrackPcT1P13tTrackManager
	.ent	__18tListIteratorTrackPcT1P13tTrackManager
__18tListIteratorTrackPcT1P13tTrackManager:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	move	$2,$5
	move	$3,$6
	sw	$17,20($sp)
	move	$17,$7
	move	$5,$0
	move	$6,$2
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	move	$7,$3
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorTrack_vtable) # high
	addiu	$3,$3,%lo(tListIteratorTrack_vtable) # low
	sw	$3,12($2)
	sw	$17,20($2)
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

	.end	__18tListIteratorTrackPcT1P13tTrackManager
	.align	2
	.globl	_._18tListIteratorTrack
	.ent	_._18tListIteratorTrack
_._18tListIteratorTrack:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorTrack_vtable) # high
	addiu	$2,$2,%lo(tListIteratorTrack_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
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

	.end	_._18tListIteratorTrack
	.align	2
	.globl	TextValue__18tListIteratorTrack7tPlayer
	.ent	TextValue__18tListIteratorTrack7tPlayer
TextValue__18tListIteratorTrack7tPlayer:
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
	lw	$4,20($4)
	sll	$3,$2,1
	addu	$3,$3,$2
	lw	$2,4($4)
	sll	$3,$3,4
	addu	$2,$2,$3
	lb	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,213
	.set	macro
	.set	reorder

	.end	TextValue__18tListIteratorTrack7tPlayer
	.align	2
	.globl	Increment__18tListIteratorTrack7tPlayer
	.ent	Increment__18tListIteratorTrack7tPlayer
Increment__18tListIteratorTrack7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
$L649:
	lw	$2,16($16)
	lw	$3,4($16)
	lbu	$2,0($2)
	#nop
	addu	$3,$3,$2
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$2,16($16)
	#nop
	lbu	$3,0($2)
	lw	$2,4($16)
	#nop
	addu	$4,$2,$3
	lw	$3,20($16)
	lbu	$2,0($4)
	lw	$3,0($3)
	#nop
	sltu	$2,$2,$3
	bne	$2,$0,$L652
	sb	$0,0($4)
$L652:
	lw	$2,16($16)
	#nop
	lbu	$3,0($2)
	lw	$2,4($16)
	#nop
	addu	$2,$2,$3
	lbu	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	ValidTrack__18tListIteratorTrackc
	move	$4,$16
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	bne	$2,$0,$L649
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Increment__18tListIteratorTrack7tPlayer
	.align	2
	.globl	Decrement__18tListIteratorTrack7tPlayer
	.ent	Decrement__18tListIteratorTrack7tPlayer
Decrement__18tListIteratorTrack7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
$L655:
	lw	$2,16($16)
	#nop
	lbu	$3,0($2)
	lw	$2,4($16)
	#nop
	addu	$3,$2,$3
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$2,20($16)
	#nop
	lbu	$2,0($2)
	#nop
	addu	$2,$2,-1
$L660:
	sb	$2,0($3)
	lw	$2,16($16)
	#nop
	lbu	$3,0($2)
	lw	$2,4($16)
	#nop
	addu	$2,$2,$3
	lbu	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	ValidTrack__18tListIteratorTrackc
	move	$4,$16
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	bne	$2,$0,$L655
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Decrement__18tListIteratorTrack7tPlayer
	.align	2
	.globl	ValidTrack__18tListIteratorTrackc
	.ent	ValidTrack__18tListIteratorTrackc
ValidTrack__18tListIteratorTrackc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$5,$5,0x00ff
	sll	$2,$5,1
	lw	$4,20($4)
	addu	$2,$2,$5
	lw	$3,4($4)
	sll	$2,$2,4
	addu	$3,$3,$2
	lb	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$4,$4,$2
	lui	$2,%hi(frontEnd+4) # high
	lbu	$6,%lo(frontEnd+4)($2)
	lw	$5,8($4)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L663
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L664
	move	$2,$5
	.set	macro
	.set	reorder

	j	$L670
$L663:
	lw	$2,72($4)
	#nop
	or	$5,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L662
	sltu	$5,$0,$5
	.set	macro
	.set	reorder

$L664:
	lw	$2,72($4)
	#nop
	or	$5,$5,$2
	lbu	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L665
	sltu	$5,$0,$5
	.set	macro
	.set	reorder

	move	$5,$0
$L665:
	lbu	$2,2($3)
	#nop
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	move	$2,$5
	.set	macro
	.set	reorder

	move	$5,$0
$L662:
	move	$2,$5
$L670:
	j	$31
	.end	ValidTrack__18tListIteratorTrackc
	.globl	tracks_maxTrackIndex
	.data
	.align	2
tracks_maxTrackIndex:
	.space	4
