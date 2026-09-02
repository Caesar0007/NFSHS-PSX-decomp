	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fecars.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Initialize__11tCarManager
	.align	2
	.globl	GetCarFromID__11tCarManagers
	.align	2
	.globl	GetCarFromSimID__11tCarManagers
	.align	2
	.globl	CheapestCarStockPrice__11tCarManager
	.align	2
	.globl	CalcUsedPrice__11tCarManagers
	.align	2
	.globl	PurchaseCar__11tCarManagersss
	.align	2
	.globl	SellCar__11tCarManagerss
	.align	2
	.globl	PurchaseUpgrade__11tCarManagersss
	.align	2
	.globl	RemoveFromPinkSlipsList__11tCarManagerss
	.align	2
	.globl	AddToPinkSlipsList__11tCarManagersss
	.align	2
	.globl	AddUpgradesToPinkSlipsList__11tCarManagersss
	.align	2
	.globl	LoadCars__11tCarManagerR12tSaveCarInfos
	.align	2
	.globl	SaveCars__11tCarManagerR12tSaveCarInfo
	.align	2
	.globl	LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
	.align	2
	.globl	SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
	.align	2
	.globl	SetClassAvailable__11tCarManager13tCarClassTypeb
	.align	2
	.globl	SetCarAvailable__11tCarManager10tCarModelsb
	.align	2
	.globl	SetClassViewable__11tCarManager13tCarClassTypeb
	.align	2
	.globl	SetCarViewable__11tCarManager10tCarModelsb
	.align	2
	.globl	GetStockCar__11tCarManagersR8tCarInfo
	.align	2
	.globl	GetGarageCar__11tCarManagersR8tCarInfos
	.align	2
	.globl	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	.rdata
	.align	2
$LC0:
	.ascii	"%s%s\000"
	.align	2
$LC1:
	.ascii	"fecars.car\000"
	.align	2
$LC2:
	.ascii	"Car List\000"
	.text
	.align	2
	.globl	LoadDescription__11tCarManager
	.align	2
	.globl	ReleaseDescription__11tCarManager
	.align	2
	.globl	GetNumOwnedCars__11tCarManagers
	.align	2
	.globl	GetNumTourneyCars__11tCarManagers
	.align	2
	.globl	GetNumPinkSlipsCars__11tCarManagers
	.align	2
	.globl	GetClassList__11tCarManager13tCarClassTypesP10tCarModels
	.align	2
	.globl	InitializeIngameCarList__11tCarManager
	.align	2
	.globl	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	.align	2
	.globl	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	.align	2
	.globl	FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels
	.align	2
	.globl	__16tListIteratorCarPcP11tCarManager
	.align	2
	.globl	_._16tListIteratorCar
	.align	2
	.globl	Value__16tListIteratorCar7tPlayer
	.rdata
	.align	2
$LC3:
	.half	289
	.half	339
	.half	389
	.text
	.align	2
	.globl	TextValue__16tListIteratorCar7tPlayer
	.align	2
	.globl	AdjustPosition__16tListIteratorCar7tPlayers
	.align	2
	.globl	Increment__16tListIteratorCar7tPlayer
	.align	2
	.globl	Decrement__16tListIteratorCar7tPlayer
	.align	2
	.globl	ValidCar__16tListIteratorCar7tPlayerc
	.align	2
	.globl	__21tListIteratorCarColorPcN21iP11tCarManager
	.align	2
	.globl	_._21tListIteratorCarColor
	.align	2
	.globl	Value__21tListIteratorCarColor7tPlayer
	.align	2
	.globl	TextValue__21tListIteratorCarColor7tPlayer
	.align	2
	.globl	Increment__21tListIteratorCarColor7tPlayer
	.align	2
	.globl	Decrement__21tListIteratorCarColor7tPlayer
	.globl	cars_disableBonuses
	.sdata
cars_disableBonuses:
	.space	1
	.globl	gCarSelected
	.data
	.align	2
gCarSelected:
	.space	100

	.extern	trackManager, 136
	.extern	tournamentManager, 644
	.extern	frontEnd, 1104
	.extern	carManager, 908

	.text
	.text
	.ent	Initialize__11tCarManager
Initialize__11tCarManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$0
	li	$8,-1			# 0xffffffff
	sw	$0,0($4)
	sw	$0,4($4)
	move	$5,$0
$L23:
	sll	$2,$7,16
	sra	$6,$2,9
$L15:
	sll	$2,$5,16
	addu	$3,$5,1
	move	$5,$3
	sra	$2,$2,14
	addu	$2,$2,$6
	addu	$2,$4,$2
	sll	$3,$3,16
	sra	$3,$3,16
	slt	$3,$3,32
	sb	$8,8($2)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L15
	sb	$8,264($2)
	.set	macro
	.set	reorder

	addu	$2,$7,1
	move	$7,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	move	$5,$0
	.set	macro
	.set	reorder

$L21:
	sll	$3,$5,16
	addu	$2,$5,1
	move	$5,$2
	sra	$3,$3,16
	addu	$3,$4,$3
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,48
	sb	$0,520($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L21
	sb	$0,568($3)
	.set	macro
	.set	reorder

	j	$31
	.end	Initialize__11tCarManager
	.text
	.ent	GetCarFromID__11tCarManagers
GetCarFromID__11tCarManagers:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$6,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L26
	move	$3,$0
	.set	macro
	.set	reorder

	sll	$2,$5,16
	sra	$7,$2,16
	move	$5,$6
	lw	$4,4($4)
$L28:
	lb	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$7,$L27
	addu	$3,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

$L27:
	sltu	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L28
	addu	$4,$4,204
	.set	macro
	.set	reorder

$L26:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	GetCarFromID__11tCarManagers
	.text
	.ent	GetCarFromSimID__11tCarManagers
GetCarFromSimID__11tCarManagers:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$6,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L34
	move	$3,$0
	.set	macro
	.set	reorder

	sll	$2,$5,16
	sra	$7,$2,16
	move	$5,$6
	lw	$4,4($4)
$L36:
	lbu	$2,1($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$7,$L35
	addu	$3,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

$L35:
	sltu	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L36
	addu	$4,$4,204
	.set	macro
	.set	reorder

$L34:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	GetCarFromSimID__11tCarManagers
	.text
	.ent	CheapestCarStockPrice__11tCarManager
CheapestCarStockPrice__11tCarManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$6,9961472			# 0x00980000
	ori	$6,$6,0x9680
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	move	$5,$0
	.set	macro
	.set	reorder

	move	$7,$2
	lw	$4,4($4)
$L44:
	lw	$3,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L43
	slt	$2,$3,$6
	.set	macro
	.set	reorder

	beq	$2,$0,$L43
	move	$6,$3
$L43:
	addu	$5,$5,1
	sltu	$2,$5,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L44
	addu	$4,$4,204
	.set	macro
	.set	reorder

$L42:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	CheapestCarStockPrice__11tCarManager
	.text
	.ent	CalcUsedPrice__11tCarManagers
CalcUsedPrice__11tCarManagers:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	sll	$5,$5,16
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$3,0($18)
	sra	$17,$5,16
	sltu	$2,$17,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L48
	move	$16,$0
	.set	macro
	.set	reorder

	subu	$2,$17,$3
	sll	$2,$2,2
	addu	$2,$18,$2
	lb	$5,8($2)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L57
	move	$2,$16
	.set	macro
	.set	reorder

	jal	GetCarFromID__11tCarManagers
	move	$4,$2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L57
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	subu	$2,$17,$2
	sll	$2,$2,2
	addu	$2,$18,$2
	lbu	$3,9($2)
	lw	$16,32($4)
	andi	$2,$3,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L58
	andi	$2,$3,0x0002
	.set	macro
	.set	reorder

	lw	$2,36($4)
	#nop
	addu	$16,$16,$2
	andi	$2,$3,0x0002
$L58:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L59
	andi	$2,$3,0x0004
	.set	macro
	.set	reorder

	lw	$2,40($4)
	#nop
	addu	$16,$16,$2
	andi	$2,$3,0x0004
$L59:
	beq	$2,$0,$L53
	lw	$2,44($4)
	#nop
	addu	$16,$16,$2
$L53:
	lbu	$2,195($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L54
	sll	$2,$16,1
	.set	macro
	.set	reorder

	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L48
	sra	$16,$2,2
	.set	macro
	.set	reorder

	addu	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$L48
	sra	$16,$2,2
	.set	macro
	.set	reorder

$L54:
	sra	$16,$16,1
$L48:
	move	$2,$16
$L57:
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

	.end	CalcUsedPrice__11tCarManagers
	.text
	.ent	PurchaseCar__11tCarManagersss
PurchaseCar__11tCarManagersss:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$7
	sw	$18,24($sp)
	move	$18,$5
	sw	$19,28($sp)
	move	$19,$6
	lui	$4,%hi(carManager) # high
	sll	$5,$5,16
	addiu	$4,$4,%lo(carManager) # low
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	sra	$5,$5,16
	.set	macro
	.set	reorder

	move	$6,$2
	move	$4,$0
	sll	$16,$16,16
	sra	$16,$16,16
	sll	$5,$16,7
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$16,$16,$2
	sll	$2,$4,16
$L68:
	sra	$2,$2,14
	addu	$2,$2,$5
	addu	$3,$17,$2
	lb	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L63
	addu	$2,$4,1
	.set	macro
	.set	reorder

	sb	$18,8($3)
	sb	$19,10($3)
	sb	$0,9($3)
	lbu	$2,0($17)
	#nop
	addu	$2,$4,$2
	sb	$2,291($16)
	lw	$2,32($6)
	j	$L67
$L63:
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L68
	sll	$2,$4,16
	.set	macro
	.set	reorder

	move	$2,$0
$L67:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	PurchaseCar__11tCarManagersss
	.text
	.ent	SellCar__11tCarManagerss
SellCar__11tCarManagerss:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$16,16($sp)
	sll	$16,$17,16
	sra	$16,$16,16
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcUsedPrice__11tCarManagers
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,0($19)
	#nop
	subu	$16,$16,$3
	sll	$16,$16,2
	sll	$3,$18,16
	sra	$4,$3,9
	addu	$16,$16,$4
	addu	$16,$19,$16
	li	$3,-1			# 0xffffffff
	sb	$3,8($16)
	lhu	$3,0($19)
	#nop
	subu	$17,$17,$3
	addu	$17,$17,1
	move	$6,$17
	sll	$17,$17,16
	sra	$17,$17,16
	slt	$17,$17,32
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L71
	move	$8,$2
	.set	macro
	.set	reorder

	move	$7,$4
$L73:
	sll	$2,$6,16
	sra	$3,$2,16
	sll	$2,$3,2
	addu	$2,$2,$7
	addu	$4,$19,$2
	lb	$2,8($4)
	lbu	$5,8($4)
	.set	noreorder
	.set	nomacro
	bltz	$2,$L71
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	sll	$3,$3,2
	addu	$3,$3,$7
	addu	$3,$19,$3
	sb	$5,8($3)
	lbu	$2,9($4)
	#nop
	sb	$2,9($3)
	addu	$2,$6,1
	move	$6,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lbu	$4,10($4)
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L73
	sb	$4,10($3)
	.set	macro
	.set	reorder

$L71:
	sll	$2,$6,16
	sra	$2,$2,14
	addu	$2,$2,-4
	sll	$4,$18,16
	sra	$4,$4,16
	sll	$5,$4,7
	addu	$2,$2,$5
	addu	$2,$19,$2
	li	$3,-1			# 0xffffffff
	sb	$3,8($2)
	addu	$2,$19,$5
	sb	$3,132($2)
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$4,$4,$2
	lbu	$3,291($4)
	lw	$6,0($19)
	#nop
	subu	$2,$3,$6
	sll	$2,$2,2
	addu	$2,$2,$5
	addu	$2,$19,$2
	lb	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L76
	sltu	$2,$6,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L77
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	move	$2,$0
$L77:
	sb	$2,291($4)
$L76:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$8
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	SellCar__11tCarManagerss
	.text
	.ent	PurchaseUpgrade__11tCarManagersss
PurchaseUpgrade__11tCarManagersss:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$0
	sw	$20,32($sp)
	sw	$16,16($sp)
	sll	$16,$5,16
	sra	$16,$16,16
	sw	$17,20($sp)
	sll	$17,$7,16
	sw	$31,36($sp)
	lw	$2,0($18)
	sra	$17,$17,9
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$2,$18,$2
	lb	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$20,$6
	.set	macro
	.set	reorder

	move	$8,$2
	move	$7,$19
	li	$9,1			# 0x00000001
	sll	$2,$7,16
$L88:
	sra	$5,$2,16
	sll	$3,$9,$5
	and	$2,$20,$3
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L82
	move	$6,$3
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$4,$18,$2
	sll	$2,$3,16
	lbu	$3,9($4)
	sra	$2,$2,16
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L87
	addu	$2,$7,1
	.set	macro
	.set	reorder

	or	$2,$6,$3
	sb	$2,9($4)
	addu	$2,$5,1
	sll	$2,$2,2
	addu	$2,$8,$2
	lw	$2,32($2)
	#nop
	addu	$19,$19,$2
$L82:
	addu	$2,$7,1
$L87:
	move	$7,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L88
	sll	$2,$7,16
	.set	macro
	.set	reorder

	move	$2,$19
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	PurchaseUpgrade__11tCarManagersss
	.text
	.ent	RemoveFromPinkSlipsList__11tCarManagerss
RemoveFromPinkSlipsList__11tCarManagerss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$4
	sll	$2,$5,16
	lw	$3,0($9)
	sra	$2,$2,16
	subu	$2,$2,$3
	sll	$2,$2,2
	sll	$3,$6,16
	sra	$4,$3,9
	addu	$2,$2,$4
	addu	$2,$9,$2
	li	$3,-1			# 0xffffffff
	sb	$3,264($2)
	lhu	$2,0($9)
	#nop
	subu	$5,$5,$2
	addu	$5,$5,1
	move	$7,$5
	sll	$5,$5,16
	sra	$5,$5,16
	slt	$5,$5,32
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L99
	sll	$2,$7,16
	.set	macro
	.set	reorder

	move	$8,$4
$L93:
	sll	$2,$7,16
	sra	$3,$2,16
	sll	$2,$3,2
	addu	$2,$2,$8
	addu	$4,$9,$2
	lb	$2,264($4)
	lbu	$5,264($4)
	.set	noreorder
	.set	nomacro
	bltz	$2,$L91
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	sll	$3,$3,2
	addu	$3,$3,$8
	addu	$3,$9,$3
	sb	$5,264($3)
	lbu	$2,265($4)
	#nop
	sb	$2,265($3)
	addu	$2,$7,1
	move	$7,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lbu	$4,266($4)
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L93
	sb	$4,266($3)
	.set	macro
	.set	reorder

$L91:
	sll	$2,$7,16
$L99:
	sra	$2,$2,14
	addu	$2,$2,-4
	sll	$4,$6,16
	sra	$4,$4,16
	sll	$5,$4,7
	addu	$2,$2,$5
	addu	$2,$9,$2
	li	$3,-1			# 0xffffffff
	sb	$3,264($2)
	addu	$2,$9,$5
	sb	$3,388($2)
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$4,$4,$2
	lbu	$6,291($4)
	lw	$3,0($9)
	#nop
	subu	$2,$6,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	addu	$2,$9,$2
	lb	$2,264($2)
	#nop
	bgez	$2,$L100
	lbu	$2,293($4)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L97
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	move	$2,$0
$L97:
	sb	$2,293($4)
$L100:
	j	$31
	.end	RemoveFromPinkSlipsList__11tCarManagerss
	.text
	.ent	AddToPinkSlipsList__11tCarManagersss
AddToPinkSlipsList__11tCarManagersss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$0
	sll	$7,$7,16
	sra	$7,$7,16
	sll	$9,$7,7
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$7,$7,$2
	sll	$2,$8,16
$L108:
	sra	$2,$2,14
	addu	$2,$2,$9
	addu	$3,$4,$2
	lb	$2,264($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L104
	addu	$2,$8,1
	.set	macro
	.set	reorder

	sb	$5,264($3)
	sb	$6,266($3)
	sb	$0,265($3)
	lbu	$2,0($4)
	#nop
	addu	$2,$8,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,293($7)
	.set	macro
	.set	reorder

$L104:
	move	$8,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L108
	sll	$2,$8,16
	.set	macro
	.set	reorder

	j	$31
	.end	AddToPinkSlipsList__11tCarManagersss
	.text
	.ent	AddUpgradesToPinkSlipsList__11tCarManagersss
AddUpgradesToPinkSlipsList__11tCarManagersss:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	sw	$16,16($sp)
	sll	$16,$5,16
	sra	$16,$16,16
	sw	$17,20($sp)
	sll	$17,$7,16
	sw	$31,32($sp)
	lw	$2,0($18)
	sra	$17,$17,9
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$2,$18,$2
	lb	$5,264($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$19,$6
	.set	macro
	.set	reorder

	move	$6,$0
	li	$7,1			# 0x00000001
	sll	$3,$7,$6
$L118:
	and	$2,$19,$3
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L112
	move	$5,$3
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$4,$18,$2
	sll	$2,$3,16
	lbu	$3,265($4)
	sra	$2,$2,16
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L117
	addu	$2,$6,1
	.set	macro
	.set	reorder

	or	$2,$5,$3
	sb	$2,265($4)
$L112:
	addu	$2,$6,1
$L117:
	move	$6,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L118
	sll	$3,$7,$6
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	AddUpgradesToPinkSlipsList__11tCarManagersss
	.text
	.ent	LoadCars__11tCarManagerR12tSaveCarInfos
LoadCars__11tCarManagerR12tSaveCarInfos:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$16,16($sp)
	sll	$16,$6,16
	sra	$16,$16,16
	sll	$5,$16,7
	addu	$5,$5,8
	move	$4,$18
	addu	$5,$17,$5
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,128			# 0x00000080
	.set	macro
	.set	reorder

	bne	$16,$0,$L119
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L119
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$4,$18,$5
$L126:
	lbu	$2,128($4)
	addu	$3,$17,$5
	sb	$2,520($3)
	lbu	$2,176($4)
	#nop
	sb	$2,568($3)
	lw	$2,0($17)
	addu	$5,$5,1
	sltu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L126
	addu	$4,$18,$5
	.set	macro
	.set	reorder

$L119:
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

	.end	LoadCars__11tCarManagerR12tSaveCarInfos
	.text
	.ent	SaveCars__11tCarManagerR12tSaveCarInfo
SaveCars__11tCarManagerR12tSaveCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	addu	$4,$16,8
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,128			# 0x00000080
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L127
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$4,$16,$5
$L133:
	lbu	$2,520($4)
	addu	$3,$17,$5
	sb	$2,128($3)
	lbu	$2,568($4)
	#nop
	sb	$2,176($3)
	lw	$2,0($16)
	addu	$5,$5,1
	sltu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L133
	addu	$4,$16,$5
	.set	macro
	.set	reorder

$L127:
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

	.end	SaveCars__11tCarManagerR12tSaveCarInfo
	.text
	.ent	LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sll	$6,$6,16
	sw	$16,16($sp)
	sra	$16,$6,16
	sll	$5,$16,7
	addu	$5,$5,264
	move	$4,$18
	addu	$5,$17,$5
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,128			# 0x00000080
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L134
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$6,$2,4
	addu	$3,$5,$6
$L140:
	addu	$4,$18,$5
	lbu	$2,128($4)
	addu	$3,$17,$3
	sb	$2,616($3)
	lbu	$2,176($4)
	#nop
	sb	$2,712($3)
	lw	$2,0($17)
	addu	$5,$5,1
	sltu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L140
	addu	$3,$5,$6
	.set	macro
	.set	reorder

$L134:
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

	.end	LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
	.text
	.ent	SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss:
	.frame	$sp,256,$31		# vars= 208, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,256
	sw	$19,236($sp)
	move	$19,$4
	sw	$20,240($sp)
	move	$20,$5
	sw	$18,232($sp)
	move	$18,$6
	sw	$22,248($sp)
	move	$22,$18
	sw	$21,244($sp)
	move	$21,$7
	sll	$7,$7,16
	sw	$17,228($sp)
	sra	$17,$7,16
	li	$2,-1			# 0xffffffff
	sw	$31,252($sp)
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L142
	sw	$16,224($sp)
	.set	macro
	.set	reorder

	move	$5,$17
	addu	$6,$sp,16
	sll	$16,$18,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	RemoveFromPinkSlipsList__11tCarManagerss
	move	$6,$16
	.set	macro
	.set	reorder

$L142:
	sll	$2,$18,16
	sra	$16,$2,16
	sll	$4,$16,7
	addu	$4,$4,264
	addu	$4,$19,$4
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,128			# 0x00000080
	.set	macro
	.set	reorder

	lw	$2,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L143
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$6,$2,4
	addu	$2,$5,$6
$L149:
	addu	$2,$19,$2
	lbu	$3,616($2)
	addu	$4,$20,$5
	sb	$3,128($4)
	lbu	$2,712($2)
	#nop
	sb	$2,176($4)
	lw	$2,0($19)
	addu	$5,$5,1
	sltu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L149
	addu	$2,$5,$6
	.set	macro
	.set	reorder

$L143:
	sll	$2,$21,16
	sra	$2,$2,16
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L141
	lui	$17,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$17,$17,%lo(carManager) # low
	move	$4,$17
	sll	$16,$22,16
	sra	$16,$16,16
	lb	$5,16($sp)
	lbu	$6,213($sp)
	.set	noreorder
	.set	nomacro
	jal	AddToPinkSlipsList__11tCarManagersss
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$16,$2
	lbu	$5,293($2)
	lbu	$6,212($sp)
	.set	noreorder
	.set	nomacro
	jal	AddUpgradesToPinkSlipsList__11tCarManagersss
	move	$7,$16
	.set	macro
	.set	reorder

$L141:
	lw	$31,252($sp)
	lw	$22,248($sp)
	lw	$21,244($sp)
	lw	$20,240($sp)
	lw	$19,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,256
	.set	macro
	.set	reorder

	.end	SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
	.text
	.ent	SetClassAvailable__11tCarManager13tCarClassTypeb
SetClassAvailable__11tCarManager13tCarClassTypeb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L158
	move	$8,$0
	.set	macro
	.set	reorder

	li	$9,1			# 0x00000001
	move	$7,$8
$L152:
	lw	$2,4($4)
	#nop
	addu	$2,$7,$2
	lb	$3,0($2)
	#nop
	bltz	$3,$L155
	lbu	$2,2($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L155
	addu	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L155
	sb	$6,520($2)
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	addu	$2,$7,$2
	lb	$2,0($2)
	#nop
	addu	$2,$4,$2
	sb	$9,568($2)
$L155:
	lw	$2,0($4)
	addu	$8,$8,1
	sltu	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L152
	addu	$7,$7,204
	.set	macro
	.set	reorder

$L158:
	j	$31
	.end	SetClassAvailable__11tCarManager13tCarClassTypeb
	.text
	.ent	SetCarAvailable__11tCarManager10tCarModelsb
SetCarAvailable__11tCarManager10tCarModelsb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$4,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L161
	sb	$6,520($4)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,568($4)
$L161:
	j	$31
	.end	SetCarAvailable__11tCarManager10tCarModelsb
	.text
	.ent	SetClassViewable__11tCarManager13tCarClassTypeb
SetClassViewable__11tCarManager13tCarClassTypeb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L171
	move	$7,$0
	.set	macro
	.set	reorder

	move	$8,$7
$L166:
	lw	$2,4($4)
	#nop
	addu	$2,$8,$2
	lb	$3,0($2)
	#nop
	bltz	$3,$L167
	lbu	$2,2($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L165
	addu	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L165
	sb	$6,568($2)
	.set	macro
	.set	reorder

$L167:
	addu	$2,$4,$3
	sb	$0,568($2)
$L165:
	lw	$2,0($4)
	addu	$7,$7,1
	sltu	$2,$7,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L166
	addu	$8,$8,204
	.set	macro
	.set	reorder

$L171:
	j	$31
	.end	SetClassViewable__11tCarManager13tCarClassTypeb
	.text
	.ent	SetCarViewable__11tCarManager10tCarModelsb
SetCarViewable__11tCarManager10tCarModelsb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$4,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L174
	sb	$6,568($4)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,520($4)
$L174:
	j	$31
	.end	SetCarViewable__11tCarManager10tCarModelsb
	.text
	.ent	GetStockCar__11tCarManagersR8tCarInfo
GetStockCar__11tCarManagersR8tCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sw	$18,24($sp)
	move	$18,$5
	sll	$5,$5,16
	sw	$31,28($sp)
	lw	$2,0($17)
	sra	$3,$5,16
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L176
	move	$16,$6
	.set	macro
	.set	reorder

	move	$5,$3
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L178
	sb	$18,200($16)
	.set	macro
	.set	reorder

$L176:
	move	$5,$16
	li	$6,204			# 0x000000cc
	sll	$4,$3,1
	addu	$4,$4,$3
	sll	$2,$4,4
	addu	$4,$4,$2
	lw	$2,4($17)
	sll	$4,$4,2
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lb	$2,0($16)
	#nop
	addu	$2,$17,$2
	lbu	$3,520($2)
	lb	$2,0($16)
	#nop
	addu	$2,$17,$2
	sb	$3,7($16)
	lbu	$2,568($2)
	sb	$0,196($16)
	sb	$0,199($16)
	sb	$2,198($16)
	sb	$18,200($16)
$L178:
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

	.end	GetStockCar__11tCarManagersR8tCarInfo
	.text
	.ent	GetGarageCar__11tCarManagersR8tCarInfos
GetGarageCar__11tCarManagersR8tCarInfos:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$7
	sw	$19,28($sp)
	move	$19,$6
	sw	$20,32($sp)
	move	$20,$5
	sll	$7,$7,16
	sra	$7,$7,16
	li	$2,1			# 0x00000001
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$7,$2,$L180
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$2
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L181
	sll	$16,$20,16
	.set	macro
	.set	reorder

	move	$17,$0
$L180:
	sll	$16,$20,16
$L181:
	sra	$16,$16,16
	sll	$17,$17,16
	lw	$2,0($18)
	sra	$17,$17,9
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$2,$18,$2
	lb	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,204			# 0x000000cc
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,7($19)
	sb	$2,198($19)
	lw	$2,0($18)
	#nop
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$2,$18,$2
	lbu	$2,9($2)
	#nop
	sb	$2,196($19)
	lw	$2,0($18)
	#nop
	subu	$16,$16,$2
	sll	$16,$16,2
	addu	$16,$16,$17
	addu	$16,$18,$16
	lbu	$2,10($16)
	sb	$0,199($19)
	sb	$20,200($19)
	sb	$2,197($19)
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	GetGarageCar__11tCarManagersR8tCarInfos
	.text
	.ent	GetPinkSlipsCar__11tCarManagersR8tCarInfos
GetPinkSlipsCar__11tCarManagersR8tCarInfos:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$18,24($sp)
	sw	$16,16($sp)
	sll	$16,$20,16
	sra	$16,$16,16
	sw	$19,28($sp)
	sll	$19,$7,16
	sw	$31,36($sp)
	lw	$2,0($17)
	sra	$19,$19,9
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$19
	addu	$2,$17,$2
	lb	$5,264($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$18,$6
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,204			# 0x000000cc
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,7($18)
	sb	$2,198($18)
	lw	$2,0($17)
	#nop
	subu	$2,$16,$2
	sll	$2,$2,2
	addu	$2,$2,$19
	addu	$2,$17,$2
	lbu	$2,265($2)
	#nop
	sb	$2,196($18)
	lw	$2,0($17)
	#nop
	subu	$16,$16,$2
	sll	$16,$16,2
	addu	$16,$16,$19
	addu	$17,$17,$16
	lbu	$2,266($17)
	sb	$0,199($18)
	sb	$20,200($18)
	sb	$2,197($18)
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	.text
	.ent	LoadDescription__11tCarManager
LoadDescription__11tCarManager:
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
	jal	ReleaseDescription__11tCarManager
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
	lw	$3,0($17)
	move	$6,$0
	sll	$5,$3,1
	addu	$5,$5,$3
	sll	$2,$5,4
	addu	$5,$5,$2
	sll	$5,$5,2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$3,0($16)
	.set	macro
	.set	reorder

	addu	$4,$17,4
	lw	$3,0($16)
	move	$5,$2
	sw	$5,4($16)
	sll	$6,$3,1
	addu	$6,$6,$3
	sll	$2,$6,4
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	blockmove
	sll	$6,$6,2
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L184
	move	$9,$0
	.set	macro
	.set	reorder

	li	$10,1			# 0x00000001
	sll	$2,$9,16
$L196:
	sra	$2,$2,16
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	lw	$2,4($16)
	sll	$3,$3,2
	addu	$4,$3,$2
	lbu	$2,7($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L188
	move	$7,$0
	.set	macro
	.set	reorder

	lb	$2,0($4)
	#nop
	addu	$2,$16,$2
	sb	$10,520($2)
	lw	$2,4($16)
	#nop
	addu	$2,$3,$2
	lb	$2,0($2)
	#nop
	addu	$2,$16,$2
	sb	$10,568($2)
$L188:
	lw	$2,4($16)
	move	$8,$3
	addu	$5,$8,$2
	lbu	$2,172($5)
	lbu	$3,173($5)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L187
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$2,$5,$6
$L195:
	lb	$3,175($2)
	lbu	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L192
	addu	$3,$7,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L187
	sb	$7,4($5)
	.set	macro
	.set	reorder

$L192:
	move	$7,$3
	lw	$2,4($16)
	sll	$3,$3,16
	addu	$5,$8,$2
	lbu	$2,172($5)
	lbu	$4,173($5)
	sra	$6,$3,16
	addu	$2,$2,$4
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L195
	addu	$2,$5,$6
	.set	macro
	.set	reorder

$L187:
	addu	$2,$9,1
	move	$9,$2
	sll	$2,$2,16
	lw	$3,0($16)
	sra	$2,$2,16
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L196
	sll	$2,$9,16
	.set	macro
	.set	reorder

$L184:
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

	.end	LoadDescription__11tCarManager
	.text
	.ent	ReleaseDescription__11tCarManager
ReleaseDescription__11tCarManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,4($16)
	#nop
	beq	$4,$0,$L198
	jal	purgememadr
$L198:
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

	.end	ReleaseDescription__11tCarManager
	.text
	.ent	GetNumOwnedCars__11tCarManagers
GetNumOwnedCars__11tCarManagers:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	move	$3,$0
	sll	$5,$5,16
	sra	$5,$5,9
$L200:
	addu	$2,$4,$5
	lb	$2,8($2)
	#nop
	bltz	$2,$L203
	addu	$6,$6,1
$L203:
	addu	$3,$3,1
	slt	$2,$3,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L200
	addu	$5,$5,4
	.set	macro
	.set	reorder

	sll	$2,$6,16
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.end	GetNumOwnedCars__11tCarManagers
	.text
	.ent	GetNumTourneyCars__11tCarManagers
GetNumTourneyCars__11tCarManagers:
	.frame	$sp,248,$31		# vars= 208, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$19,236($sp)
	move	$19,$4
	sw	$18,232($sp)
	move	$18,$0
	sw	$17,228($sp)
	move	$17,$0
	sll	$5,$5,16
	sw	$16,224($sp)
	sra	$16,$5,9
	sw	$31,240($sp)
$L206:
	addu	$3,$19,$16
	lb	$5,8($3)
	lbu	$2,8($3)
	.set	noreorder
	.set	nomacro
	bltz	$5,$L209
	move	$4,$19
	.set	macro
	.set	reorder

	sb	$2,16($sp)
	lbu	$2,9($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	sb	$2,212($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	lbu	$2,2($2)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	ValidCar__18tTournamentManagerR8tCarInfo
	sb	$2,18($sp)
	.set	macro
	.set	reorder

	beq	$2,$0,$L209
	addu	$18,$18,1
$L209:
	addu	$17,$17,1
	slt	$2,$17,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L206
	addu	$16,$16,4
	.set	macro
	.set	reorder

	sll	$2,$18,16
	lw	$31,240($sp)
	lw	$19,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,248
	.set	macro
	.set	reorder

	.end	GetNumTourneyCars__11tCarManagers
	.text
	.ent	GetNumPinkSlipsCars__11tCarManagers
GetNumPinkSlipsCars__11tCarManagers:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	move	$3,$0
	sll	$5,$5,16
	sra	$5,$5,9
$L213:
	addu	$2,$4,$5
	lb	$2,264($2)
	#nop
	bltz	$2,$L216
	addu	$6,$6,1
$L216:
	addu	$3,$3,1
	slt	$2,$3,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L213
	addu	$5,$5,4
	.set	macro
	.set	reorder

	sll	$2,$6,16
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.end	GetNumPinkSlipsCars__11tCarManagers
	.text
	.ent	GetClassList__11tCarManager13tCarClassTypesP10tCarModels
GetClassList__11tCarManager13tCarClassTypesP10tCarModels:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$0
	move	$8,$9
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L220
	move	$11,$6
	.set	macro
	.set	reorder

	sll	$2,$6,16
	sra	$10,$2,16
	andi	$3,$8,0xffff
$L231:
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$6,$2,$3
	lbu	$2,2($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L221
	sll	$2,$9,16
	.set	macro
	.set	reorder

	sra	$3,$2,16
	slt	$2,$3,$10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L224
	sll	$2,$3,2
	.set	macro
	.set	reorder

	lb	$3,0($6)
	addu	$2,$2,$7
	sw	$3,0($2)
$L224:
	addu	$9,$9,1
$L221:
	addu	$8,$8,1
	lw	$3,0($4)
	andi	$2,$8,0xffff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L231
	andi	$3,$8,0xffff
	.set	macro
	.set	reorder

$L220:
	andi	$2,$9,0xffff
	sll	$3,$11,16
	sra	$3,$3,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L227
	move	$8,$9
	.set	macro
	.set	reorder

	sll	$2,$9,16
	sra	$5,$2,16
	move	$6,$3
$L229:
	andi	$2,$8,0xffff
	rem	$3,$2,$5
	addu	$8,$8,1
	sll	$2,$2,2
	sll	$3,$3,2
	addu	$3,$3,$7
	lw	$3,0($3)
	addu	$2,$2,$7
	sw	$3,0($2)
	andi	$2,$8,0xffff
	slt	$2,$2,$6
	bne	$2,$0,$L229
$L227:
	sll	$2,$9,16
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.end	GetClassList__11tCarManager13tCarClassTypesP10tCarModels
	.text
	.ent	InitializeIngameCarList__11tCarManager
InitializeIngameCarList__11tCarManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	lui	$2,%hi(gCarSelected) # high
	addiu	$6,$2,%lo(gCarSelected) # low
	move	$4,$0
$L242:
	sll	$3,$5,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$3,$2,1
	sll	$2,$4,16
$L241:
	sra	$2,$2,16
	addu	$2,$2,$3
	addu	$2,$2,$6
	sb	$0,0($2)
	addu	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,50
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L241
	sll	$2,$4,16
	.set	macro
	.set	reorder

	addu	$2,$5,1
	move	$5,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L242
	move	$4,$0
	.set	macro
	.set	reorder

	j	$31
	.end	InitializeIngameCarList__11tCarManager
	.text
	.ent	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
IsCarAnAddedModel__11tCarManagerR10tCarModelsRc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	sw	$16,16($sp)
	lh	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$16,$6
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	#nop
	addu	$2,$2,$3
	lb	$3,175($2)
	lui	$2,%hi(gCarSelected) # high
	.set	noreorder
	.set	nomacro
	bgez	$3,$L244
	addiu	$4,$2,%lo(gCarSelected) # low
	.set	macro
	.set	reorder

	addu	$3,$3,7
$L244:
	sra	$3,$3,3
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,0($17)
	lw	$31,24($sp)
	lw	$17,20($sp)
	addu	$3,$3,$2
	addu	$3,$3,$4
	lbu	$2,0($3)
	lw	$16,16($sp)
	sltu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	.text
	.ent	AddCarToIngameList__11tCarManagerR10tCarModelsRc
AddCarToIngameList__11tCarManagerR10tCarModelsRc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	sw	$16,16($sp)
	lh	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$16,$6
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	#nop
	addu	$2,$2,$3
	lbu	$2,175($2)
	#nop
	sll	$2,$2,24
	sra	$5,$2,24
	move	$3,$5
	lui	$2,%hi(gCarSelected) # high
	.set	noreorder
	.set	nomacro
	bgez	$3,$L246
	addiu	$6,$2,%lo(gCarSelected) # low
	.set	macro
	.set	reorder

	addu	$3,$3,7
$L246:
	sra	$3,$3,3
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$4,0($17)
	andi	$5,$5,0x0007
	addu	$4,$4,$2
	addu	$4,$4,$6
	li	$2,1			# 0x00000001
	lbu	$3,0($4)
	sll	$2,$2,$5
	or	$3,$3,$2
	sb	$3,0($4)
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

	.end	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	.text
	.ent	FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels
FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	sw	$16,16($sp)
	lh	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$16,$6
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	move	$11,$2
	addu	$3,$11,$3
	lb	$2,175($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L262
	srl	$10,$2,3
	.set	macro
	.set	reorder

	addu	$2,$2,7
	srl	$10,$2,3
$L262:
	move	$12,$0
	lui	$2,%hi(gCarSelected) # high
	lbu	$3,172($11)
	lbu	$4,173($11)
	addiu	$15,$2,%lo(gCarSelected) # low
	addu	$3,$3,$4
	move	$14,$3
	sll	$13,$3,16
	sltu	$24,$0,$13
$L252:
	move	$8,$0
	.set	noreorder
	.set	nomacro
	beq	$24,$0,$L254
	move	$4,$13
	.set	macro
	.set	reorder

	sll	$2,$10,16
	sra	$9,$2,16
$L256:
	sll	$2,$8,16
	sra	$7,$2,16
	lbu	$3,0($16)
	sra	$6,$4,16
	addu	$3,$7,$3
	rem	$2,$3,$6
	addu	$2,$11,$2
	lbu	$4,175($2)
	#nop
	srl	$3,$4,3
	.set	noreorder
	.set	nomacro
	bne	$3,$9,$L263
	addu	$2,$8,1
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,0($17)
	sll	$2,$2,1
	addu	$3,$3,$2
	addu	$3,$3,$15
	lbu	$5,0($3)
	andi	$4,$4,0x0007
	sra	$2,$5,$4
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L255
	addu	$2,$8,1
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sll	$2,$2,$4
	or	$2,$5,$2
	sb	$2,0($3)
	lbu	$2,0($16)
	#nop
	addu	$2,$7,$2
	rem	$3,$2,$6
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L261
	sb	$3,0($16)
	.set	macro
	.set	reorder

$L255:
$L263:
	move	$8,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$14
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L256
	sll	$4,$14,16
	.set	macro
	.set	reorder

$L254:
	li	$2,1			# 0x00000001
	subu	$10,$2,$10
	addu	$2,$12,$2
	move	$12,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L252
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L261:
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

	.end	FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels
	.text
	.ent	__16tListIteratorCarPcP11tCarManager
__16tListIteratorCarPcP11tCarManager:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	move	$2,$5
	sw	$17,20($sp)
	move	$17,$6
	move	$5,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$6,$2
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorCar_vtable) # high
	addiu	$3,$3,%lo(tListIteratorCar_vtable) # low
	sw	$3,12($2)
	li	$3,1			# 0x00000001
	sw	$17,20($2)
	sw	$3,16($2)
	sw	$0,24($2)
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

	.end	__16tListIteratorCarPcP11tCarManager
	.text
	.ent	_._16tListIteratorCar
_._16tListIteratorCar:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorCar_vtable) # high
	addiu	$2,$2,%lo(tListIteratorCar_vtable) # low
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

	.end	_._16tListIteratorCar
	.text
	.ent	Value__16tListIteratorCar7tPlayer
Value__16tListIteratorCar7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L269
	move	$3,$0
	.set	macro
	.set	reorder

	move	$3,$5
$L269:
	sll	$2,$3,16
	lw	$3,4($4)
	sra	$2,$2,16
	addu	$3,$3,$2
	lbu	$2,0($3)
	j	$31
	.end	Value__16tListIteratorCar7tPlayer
	.text
	.ent	TextValue__16tListIteratorCar7tPlayer
TextValue__16tListIteratorCar7tPlayer:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	lui	$2,%hi($LC3) # high
	addiu	$11,$2,%lo($LC3)
	lwl	$8,3($11)
	lwr	$8,0($11)
	lh	$9,4($11)
	swl	$8,3($sp)
	swr	$8,0($sp)
	sh	$9,4($sp)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L271
	move	$3,$0
	.set	macro
	.set	reorder

	move	$3,$5
$L271:
	sll	$2,$3,16
	sra	$6,$2,16
	lw	$3,4($4)
	lw	$7,20($4)
	addu	$3,$3,$6
	lbu	$3,0($3)
	lw	$5,0($7)
	#nop
	sltu	$2,$3,$5
	bne	$2,$0,$L272
	lw	$2,16($4)
	#nop
	andi	$2,$2,0x0020
	beq	$2,$0,$L273
	lw	$2,24($4)
	#nop
	sll	$2,$2,1
	addu	$4,$sp,$2
	subu	$2,$3,$5
	sll	$2,$2,2
	sll	$3,$6,7
	addu	$2,$2,$3
	addu	$2,$7,$2
	lh	$3,0($4)
	lb	$2,264($2)
	.set	noreorder
	.set	nomacro
	j	$L276
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L273:
	lw	$2,24($4)
	#nop
	sll	$2,$2,1
	addu	$4,$sp,$2
	subu	$2,$3,$5
	sll	$2,$2,2
	sll	$3,$6,7
	addu	$2,$2,$3
	addu	$2,$7,$2
	lh	$3,0($4)
	lb	$2,8($2)
	.set	noreorder
	.set	nomacro
	j	$L276
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L272:
	lw	$2,24($4)
	#nop
	sll	$2,$2,1
	addu	$4,$sp,$2
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($7)
	sll	$2,$2,2
	addu	$2,$2,$3
	lh	$3,0($4)
	lb	$2,0($2)
	#nop
	addu	$2,$3,$2
$L276:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	TextValue__16tListIteratorCar7tPlayer
	.text
	.ent	AdjustPosition__16tListIteratorCar7tPlayers
AdjustPosition__16tListIteratorCar7tPlayers:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$18,40($sp)
	move	$18,$4
	sw	$20,48($sp)
	move	$20,$0
	sw	$23,60($sp)
	move	$23,$6
	li	$2,-1			# 0xffffffff
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L278
	sw	$5,76($sp)
	.set	macro
	.set	reorder

	lhu	$20,76($sp)
$L278:
	sll	$2,$20,16
	sra	$5,$2,16
	move	$16,$0
	lw	$3,4($18)
	lw	$6,20($18)
	addu	$3,$3,$5
	lbu	$4,0($3)
	lw	$2,0($6)
	lbu	$3,0($3)
	sltu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L279
	sb	$3,16($sp)
	.set	macro
	.set	reorder

	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$4,%hi(frontEnd) # high
	lw	$3,4($6)
	addiu	$4,$4,%lo(frontEnd) # low
	addu	$16,$3,$2
	sll	$2,$5,1
	addu	$2,$2,$5
	lb	$3,0($16)
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$4
	lbu	$3,192($3)
	.set	noreorder
	.set	nomacro
	j	$L280
	sb	$3,24($sp)
	.set	macro
	.set	reorder

$L279:
	sb	$0,24($sp)
$L280:
	lw	$3,16($18)
	#nop
	andi	$2,$3,0x0089
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L281
	move	$21,$0
	.set	macro
	.set	reorder

	lw	$2,20($18)
	#nop
	lw	$19,0($2)
	.set	noreorder
	.set	nomacro
	j	$L327
	sll	$2,$20,16
	.set	macro
	.set	reorder

$L281:
	andi	$2,$3,0x0042
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L283
	sll	$2,$20,16
	.set	macro
	.set	reorder

	sra	$2,$2,16
	sll	$3,$2,7
	lw	$4,20($18)
	addu	$3,$3,8
	addu	$17,$4,$3
	li	$3,1			# 0x00000001
	lw	$21,0($4)
	bne	$2,$3,$L284
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$3
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bgtz	$2,$L284
	lw	$2,20($18)
	#nop
	addu	$17,$2,8
$L284:
	lb	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L291
	move	$19,$0
	.set	macro
	.set	reorder

	move	$3,$17
$L287:
	addu	$3,$3,4
	lb	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L287
	addu	$19,$19,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L328
	addu	$19,$19,$21
	.set	macro
	.set	reorder

$L283:
	sra	$2,$2,9
	lw	$3,20($18)
	addu	$2,$2,264
	addu	$17,$3,$2
	lb	$2,0($17)
	lw	$21,0($3)
	.set	noreorder
	.set	nomacro
	bltz	$2,$L291
	move	$19,$0
	.set	macro
	.set	reorder

	move	$3,$17
$L292:
	addu	$3,$3,4
	lb	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L292
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L291:
	addu	$19,$19,$21
$L328:
	sll	$2,$20,16
$L327:
	lw	$3,4($18)
	sra	$4,$2,16
	addu	$3,$3,$4
	lbu	$2,0($3)
	#nop
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L294
	addu	$2,$19,-1
	.set	macro
	.set	reorder

	sb	$2,0($3)
$L294:
	lw	$2,4($18)
	#nop
	addu	$3,$2,$4
	lbu	$2,0($3)
	#nop
	slt	$2,$2,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L329
	slt	$2,$21,$19
	.set	macro
	.set	reorder

	sb	$21,0($3)
$L329:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L324
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$22,$2,%lo(frontEnd) # low
	move	$17,$4
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$20,$2,4
	li	$fp,4			# 0x00000004
$L297:
	lw	$2,4($18)
	lw	$5,20($18)
	addu	$4,$2,$17
	lbu	$3,0($4)
	lw	$2,0($5)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L300
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($5)
	sll	$2,$2,2
	addu	$16,$3,$2
	lbu	$3,2($16)
	li	$2,7			# 0x00000007
	bne	$3,$2,$L301
	lb	$3,0($16)
	#nop
	addu	$3,$3,$20
	addu	$3,$3,$22
	lbu	$2,192($3)
	#nop
	addu	$2,$23,$2
	sb	$2,192($3)
	lb	$2,0($16)
	#nop
	addu	$2,$2,$20
	addu	$3,$2,$22
	lb	$4,192($3)
	#nop
	slt	$2,$4,5
	bne	$2,$0,$L302
	sb	$0,192($3)
	lw	$3,4($18)
	#nop
	addu	$3,$3,$17
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$2,4($18)
	#nop
	addu	$2,$2,$17
	lbu	$3,0($2)
	#nop
	slt	$2,$3,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L315
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	lw	$4,20($18)
	.set	noreorder
	.set	nomacro
	j	$L325
	sll	$3,$2,4
	.set	macro
	.set	reorder

$L302:
	bgez	$4,$L315
	sb	$fp,192($3)
	lw	$3,4($18)
	#nop
	addu	$3,$3,$17
	lbu	$2,0($3)
	#nop
	addu	$2,$2,-1
	sb	$2,0($3)
	lw	$2,4($18)
	#nop
	addu	$2,$2,$17
	lbu	$3,0($2)
	#nop
	slt	$2,$3,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L315
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	lw	$4,20($18)
	.set	noreorder
	.set	nomacro
	j	$L326
	sll	$3,$2,4
	.set	macro
	.set	reorder

$L301:
	lb	$2,0($16)
	#nop
	addu	$2,$2,$20
	addu	$3,$2,$22
	sll	$2,$23,16
	bgtz	$2,$L308
	.set	noreorder
	.set	nomacro
	j	$L309
	sb	$fp,192($3)
	.set	macro
	.set	reorder

$L308:
	sb	$0,192($3)
$L309:
	lw	$2,4($18)
	#nop
	addu	$2,$2,$17
	lbu	$3,0($2)
	#nop
	addu	$3,$23,$3
	sb	$3,0($2)
	sll	$2,$23,16
	blez	$2,$L330
	lw	$2,4($18)
	#nop
	addu	$3,$2,$17
	lb	$2,0($3)
	#nop
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L310
	sll	$2,$23,16
	.set	macro
	.set	reorder

	lbu	$3,0($3)
	lw	$4,20($18)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
$L325:
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$16,$3,$2
	lb	$2,0($16)
	#nop
	addu	$2,$2,$20
	addu	$2,$2,$22
	.set	noreorder
	.set	nomacro
	j	$L315
	sb	$0,192($2)
	.set	macro
	.set	reorder

$L310:
$L330:
	bgez	$2,$L315
	lw	$2,4($18)
	#nop
	addu	$3,$2,$17
	lb	$2,0($3)
	#nop
	slt	$2,$2,$21
	bne	$2,$0,$L315
	lbu	$3,0($3)
	lw	$4,20($18)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
$L326:
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$16,$3,$2
	lb	$2,0($16)
	#nop
	addu	$2,$2,$20
	addu	$2,$2,$22
	.set	noreorder
	.set	nomacro
	j	$L315
	sb	$fp,192($2)
	.set	macro
	.set	reorder

$L300:
	addu	$2,$23,$3
	sb	$2,0($4)
$L315:
	lw	$2,4($18)
	#nop
	addu	$3,$2,$17
	lb	$2,0($3)
	#nop
	slt	$2,$2,$19
	bne	$2,$0,$L316
	sb	$21,0($3)
	lw	$2,4($18)
	lw	$4,20($18)
	addu	$2,$2,$17
	lbu	$3,0($2)
	lw	$2,0($4)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L316
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$16,$3,$2
	lb	$2,0($16)
	#nop
	addu	$2,$2,$20
	addu	$2,$2,$22
	sb	$0,192($2)
$L316:
	lw	$2,4($18)
	#nop
	addu	$3,$2,$17
	lb	$2,0($3)
	#nop
	slt	$2,$2,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L318
	addu	$2,$19,-1
	.set	macro
	.set	reorder

	sb	$2,0($3)
	lw	$2,4($18)
	lw	$4,20($18)
	addu	$2,$2,$17
	lbu	$3,0($2)
	lw	$2,0($4)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L318
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$16,$3,$2
	lb	$2,0($16)
	#nop
	addu	$2,$2,$20
	addu	$2,$2,$22
	sb	$fp,192($2)
$L318:
	lw	$2,4($18)
	#nop
	addu	$5,$2,$17
	lbu	$3,0($5)
	lbu	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L321
	sll	$3,$3,24
	.set	macro
	.set	reorder

	lw	$2,20($18)
	#nop
	lw	$2,0($2)
	sra	$3,$3,24
	slt	$3,$3,$2
	beq	$3,$0,$L324
	lb	$2,0($16)
	lbu	$7,24($sp)
	addu	$2,$2,$20
	addu	$2,$2,$22
	lb	$2,192($2)
	#nop
	beq	$2,$7,$L324
$L321:
	lbu	$6,0($5)
	lw	$5,76($sp)
	.set	noreorder
	.set	nomacro
	jal	ValidCar__16tListIteratorCar7tPlayerc
	move	$4,$18
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	bne	$2,$0,$L297
$L324:
	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	AdjustPosition__16tListIteratorCar7tPlayers
	.text
	.ent	Increment__16tListIteratorCar7tPlayer
Increment__16tListIteratorCar7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AdjustPosition__16tListIteratorCar7tPlayers
	li	$6,1			# 0x00000001
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

	.end	Increment__16tListIteratorCar7tPlayer
	.text
	.ent	Decrement__16tListIteratorCar7tPlayer
Decrement__16tListIteratorCar7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AdjustPosition__16tListIteratorCar7tPlayers
	li	$6,-1			# 0xffffffff
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

	.end	Decrement__16tListIteratorCar7tPlayer
	.text
	.ent	ValidCar__16tListIteratorCar7tPlayerc
ValidCar__16tListIteratorCar7tPlayerc:
	.frame	$sp,296,$31		# vars= 256, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,296
	sw	$20,288($sp)
	move	$20,$4
	sw	$18,280($sp)
	move	$18,$6
	sw	$17,276($sp)
	move	$17,$0
	li	$2,-1			# 0xffffffff
	sw	$31,292($sp)
	sw	$19,284($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L336
	sw	$16,272($sp)
	.set	macro
	.set	reorder

	move	$17,$5
$L336:
	move	$16,$0
	sll	$2,$17,16
	sra	$2,$2,16
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L337
	move	$19,$17
	.set	macro
	.set	reorder

	lw	$4,20($20)
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$3
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bgtz	$2,$L337
	move	$19,$16
$L337:
	lw	$4,20($20)
	#nop
	lw	$2,0($4)
	andi	$3,$18,0x00ff
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L338
	sll	$2,$3,1
	.set	macro
	.set	reorder

	lbu	$2,0($4)
	lw	$3,16($20)
	subu	$18,$18,$2
	andi	$2,$3,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L339
	andi	$2,$18,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$2,2
	sll	$3,$17,16
	sra	$3,$3,9
	addu	$2,$2,$3
	addu	$2,$4,$2
	lb	$2,264($2)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L370
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L342
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L339:
	andi	$2,$3,0x0042
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L342
	andi	$2,$18,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$2,2
	sll	$3,$19,16
	sra	$3,$3,9
	addu	$2,$2,$3
	addu	$2,$4,$2
	lb	$5,8($2)
	#nop
	bltz	$5,$L343
	li	$16,1			# 0x00000001
$L343:
	jal	GetCarFromID__11tCarManagers
	move	$4,$2
	lui	$2,%hi(frontEnd+4) # high
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L344
	lbu	$2,191($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L370
	move	$2,$0
	.set	macro
	.set	reorder

$L344:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L370
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$2,16($20)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L342
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lw	$4,20($20)
	andi	$5,$18,0x00ff
	lhu	$2,0($4)
	move	$7,$0
	addu	$5,$5,$2
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	j	$L372
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L338:
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$6,$2,$3
	lbu	$2,0($6)
	#nop
	sll	$2,$2,24
	sra	$5,$2,24
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bltz	$2,$L342
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	lbu	$2,568($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L342
	lui	$2,%hi(frontEnd+4) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L349
	andi	$3,$18,0x00ff
	.set	macro
	.set	reorder

	lbu	$2,191($6)
	#nop
	bne	$2,$0,$L373
	.set	noreorder
	.set	nomacro
	j	$L370
	move	$2,$0
	.set	macro
	.set	reorder

$L349:
$L373:
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	lw	$4,20($20)
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$6,$2,$3
	lbu	$3,2($6)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L351
	slt	$2,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L353
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	beq	$3,$2,$L355
	j	$L356
$L353:
	bltz	$3,$L356
	lw	$2,16($20)
	#nop
	andi	$2,$2,0x0081
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L374
	sll	$2,$5,16
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L374:
	sra	$2,$2,16
	li	$3,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L356
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,298($3)
	li	$4,1			# 0x00000001
	beq	$2,$4,$L360
	lbu	$2,3($3)
	#nop
	beq	$2,$4,$L360
	lbu	$2,4($3)
	#nop
	beq	$2,$0,$L356
$L360:
	.set	noreorder
	.set	nomacro
	j	$L356
	move	$16,$0
	.set	macro
	.set	reorder

$L351:
	lw	$2,16($20)
	#nop
	andi	$2,$2,0x000c
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L356
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$7,$2,%lo(frontEnd) # low
	sll	$4,$5,16
	sra	$4,$4,16
	sll	$3,$17,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$4,$4,$2
	addu	$17,$4,$7
	lbu	$2,174($6)
	lb	$3,192($17)
	#nop
	sra	$2,$2,$3
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L356
	lui	$4,%hi(trackManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(trackManager) # low
	lbu	$5,35($7)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,224
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FECheat_IsCheatEnabled__F10tCheatCode
	li	$4,12			# 0x0000000c
	.set	macro
	.set	reorder

	bne	$2,$0,$L364
	lbu	$3,248($sp)
	lb	$2,192($17)
	#nop
	bne	$3,$2,$L356
	.set	noreorder
	.set	nomacro
	j	$L356
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L355:
	lw	$2,16($20)
	#nop
	andi	$2,$2,0x0010
	beq	$2,$0,$L356
$L364:
	li	$16,1			# 0x00000001
$L356:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L370
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$2,16($20)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L342
	lui	$2,%hi(frontEnd+4) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L370
	move	$2,$16
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	andi	$2,$18,0x00ff
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$2,$5,4
	lw	$3,20($20)
	addu	$5,$5,$2
	lw	$2,4($3)
	sll	$5,$5,2
	addu	$5,$2,$5
$L372:
	jal	ValidCar__18tTournamentManagerR8tCarInfo
	move	$16,$2
$L342:
	move	$2,$16
$L370:
	lw	$31,292($sp)
	lw	$20,288($sp)
	lw	$19,284($sp)
	lw	$18,280($sp)
	lw	$17,276($sp)
	lw	$16,272($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,296
	.set	macro
	.set	reorder

	.end	ValidCar__16tListIteratorCar7tPlayerc
	.text
	.ent	__21tListIteratorCarColorPcN21iP11tCarManager
__21tListIteratorCarColorPcN21iP11tCarManager:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	move	$2,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$20,32($sp)
	move	$20,$7
	sw	$17,20($sp)
	lw	$17,56($sp)
	move	$5,$0
	sw	$18,24($sp)
	lw	$18,60($sp)
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$6,$2
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorCarColor_vtable) # high
	addiu	$3,$3,%lo(tListIteratorCarColor_vtable) # low
	sw	$3,12($2)
	sw	$19,16($2)
	sw	$20,20($2)
	sw	$17,24($2)
	sw	$18,28($2)
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__21tListIteratorCarColorPcN21iP11tCarManager
	.text
	.ent	_._21tListIteratorCarColor
_._21tListIteratorCarColor:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorCarColor_vtable) # high
	addiu	$2,$2,%lo(tListIteratorCarColor_vtable) # low
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

	.end	_._21tListIteratorCarColor
	.text
	.ent	Value__21tListIteratorCarColor7tPlayer
Value__21tListIteratorCarColor7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$5,0($2)
	lw	$2,20($4)
	lw	$3,24($4)
	addu	$2,$2,$5
	mult	$5,$3
	lbu	$3,0($2)
	lw	$5,28($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($5)
	sll	$2,$2,2
	addu	$3,$3,$2
	lb	$2,0($3)
	lw	$3,4($4)
	mflo	$6
	#nop
	#nop
	addu	$2,$6,$2
	addu	$3,$3,$2
	lbu	$2,0($3)
	j	$31
	.end	Value__21tListIteratorCarColor7tPlayer
	.text
	.ent	TextValue__21tListIteratorCarColor7tPlayer
TextValue__21tListIteratorCarColor7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	TextValue__21tListIteratorCarColor7tPlayer
	.text
	.ent	Increment__21tListIteratorCarColor7tPlayer
Increment__21tListIteratorCarColor7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	lw	$3,24($4)
	lw	$6,28($4)
	lbu	$5,0($2)
	lw	$2,20($4)
	mult	$5,$3
	addu	$2,$2,$5
	lbu	$3,0($2)
	lw	$6,4($6)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$6,$6,$2
	lb	$2,0($6)
	lw	$3,4($4)
	mflo	$5
	#nop
	#nop
	addu	$2,$5,$2
	addu	$3,$3,$2
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lb	$2,0($6)
	lw	$3,4($4)
	lbu	$4,173($6)
	addu	$5,$5,$2
	addu	$5,$3,$5
	lbu	$3,172($6)
	lbu	$2,0($5)
	addu	$3,$3,$4
	slt	$2,$2,$3
	bne	$2,$0,$L383
	sb	$0,0($5)
$L383:
	j	$31
	.end	Increment__21tListIteratorCarColor7tPlayer
	.text
	.ent	Decrement__21tListIteratorCarColor7tPlayer
Decrement__21tListIteratorCarColor7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lbu	$5,0($2)
	lw	$2,20($4)
	lw	$3,24($4)
	addu	$2,$2,$5
	mult	$5,$3
	lbu	$3,0($2)
	lw	$5,28($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	lw	$3,4($5)
	sll	$2,$2,2
	addu	$5,$3,$2
	lb	$2,0($5)
	lw	$3,4($4)
	mflo	$6
	#nop
	#nop
	addu	$2,$6,$2
	addu	$4,$3,$2
	lbu	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L387
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lbu	$2,172($5)
	lbu	$3,173($5)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,-1
$L387:
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

	.end	Decrement__21tListIteratorCarColor7tPlayer
