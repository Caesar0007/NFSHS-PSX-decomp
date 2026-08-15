	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixdatan.c"
gcc2_compiled.:
__gnu_compiled_c:
	.rdata
	.text
	.rdata
	.align	2
kAtanTbl:
	.word	0
	.word	41
	.word	81
	.word	122
	.word	163
	.word	204
	.word	244
	.word	285
	.word	326
	.word	367
	.word	407
	.word	448
	.word	489
	.word	529
	.word	570
	.word	610
	.word	651
	.word	692
	.word	732
	.word	773
	.word	813
	.word	854
	.word	894
	.word	935
	.word	975
	.word	1015
	.word	1056
	.word	1096
	.word	1136
	.word	1177
	.word	1217
	.word	1257
	.word	1297
	.word	1337
	.word	1377
	.word	1417
	.word	1457
	.word	1497
	.word	1537
	.word	1577
	.word	1617
	.word	1656
	.word	1696
	.word	1736
	.word	1775
	.word	1815
	.word	1854
	.word	1894
	.word	1933
	.word	1973
	.word	2012
	.word	2051
	.word	2090
	.word	2129
	.word	2168
	.word	2207
	.word	2246
	.word	2285
	.word	2324
	.word	2363
	.word	2401
	.word	2440
	.word	2478
	.word	2517
	.word	2555
	.word	2594
	.word	2632
	.word	2670
	.word	2708
	.word	2746
	.word	2784
	.word	2822
	.word	2860
	.word	2897
	.word	2935
	.word	2973
	.word	3010
	.word	3047
	.word	3085
	.word	3122
	.word	3159
	.word	3196
	.word	3233
	.word	3270
	.word	3307
	.word	3344
	.word	3380
	.word	3417
	.word	3453
	.word	3490
	.word	3526
	.word	3562
	.word	3599
	.word	3635
	.word	3670
	.word	3706
	.word	3742
	.word	3778
	.word	3813
	.word	3849
	.word	3884
	.word	3920
	.word	3955
	.word	3990
	.word	4025
	.word	4060
	.word	4095
	.word	4129
	.word	4164
	.word	4199
	.word	4233
	.word	4267
	.word	4302
	.word	4336
	.word	4370
	.word	4404
	.word	4438
	.word	4471
	.word	4505
	.word	4539
	.word	4572
	.word	4605
	.word	4639
	.word	4672
	.word	4705
	.word	4738
	.word	4771
	.word	4803
	.word	4836
	.word	4869
	.word	4901
	.word	4933
	.word	4966
	.word	4998
	.word	5030
	.word	5062
	.word	5094
	.word	5125
	.word	5157
	.word	5188
	.word	5220
	.word	5251
	.word	5282
	.word	5313
	.word	5344
	.word	5375
	.word	5406
	.word	5437
	.word	5467
	.word	5498
	.word	5528
	.word	5559
	.word	5589
	.word	5619
	.word	5649
	.word	5679
	.word	5708
	.word	5738
	.word	5768
	.word	5797
	.word	5826
	.word	5856
	.word	5885
	.word	5914
	.word	5943
	.word	5972
	.word	6000
	.word	6029
	.word	6058
	.word	6086
	.word	6114
	.word	6142
	.word	6171
	.word	6199
	.word	6227
	.word	6254
	.word	6282
	.word	6310
	.word	6337
	.word	6365
	.word	6392
	.word	6419
	.word	6446
	.word	6473
	.word	6500
	.word	6527
	.word	6554
	.word	6580
	.word	6607
	.word	6633
	.word	6660
	.word	6686
	.word	6712
	.word	6738
	.word	6764
	.word	6790
	.word	6815
	.word	6841
	.word	6867
	.word	6892
	.word	6917
	.word	6943
	.word	6968
	.word	6993
	.word	7018
	.word	7043
	.word	7068
	.word	7092
	.word	7117
	.word	7141
	.word	7166
	.word	7190
	.word	7214
	.word	7238
	.word	7262
	.word	7286
	.word	7310
	.word	7334
	.word	7358
	.word	7381
	.word	7405
	.word	7428
	.word	7451
	.word	7475
	.word	7498
	.word	7521
	.word	7544
	.word	7566
	.word	7589
	.word	7612
	.word	7635
	.word	7657
	.word	7679
	.word	7702
	.word	7724
	.word	7746
	.word	7768
	.word	7790
	.word	7812
	.word	7834
	.word	7856
	.word	7877
	.word	7899
	.word	7920
	.word	7942
	.word	7963
	.word	7984
	.word	8005
	.word	8026
	.word	8047
	.word	8068
	.word	8089
	.word	8110
	.word	8131
	.word	8151
	.word	8172
	.word	8192
	.text
	.align	2
	.globl	fixedatan

	.text
	.def	fixedatan;	.val	fixedatan;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	fixedatan
fixedatan:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	x;	.val	3;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	move	$3,$4
	sw	$16,24($sp)
	move	$16,$5
	sw	$17,28($sp)
	move	$17,$0
	.set	noreorder
	.set	nomacro
	bgez	$16,$L2
	sw	$31,32($sp)
	.set	macro
	.set	reorder

	li	$17,2			# 0x00000002
	subu	$16,$0,$16
$L2:
	bgez	$3,$L3
	ori	$17,$17,0x0004
	subu	$3,$0,$3
$L3:
	.set	noreorder
	.set	nomacro
	bne	$3,$16,$L4
	slt	$2,$16,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L5
	li	$6,8192			# 0x00002000
	.set	macro
	.set	reorder

$L4:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	move	$2,$3
	.set	macro
	.set	reorder

	move	$3,$16
	move	$16,$2
	ori	$17,$17,0x0001
$L6:
	addu	$4,$sp,16
	move	$5,$3
	.set	noreorder
	.set	nomacro
	jal	make64
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	divu64
	move	$6,$16
	.set	macro
	.set	reorder

	srl	$5,$2,8
	srl	$2,$2,24
	lui	$4,%hi(kAtanTbl) # high
	addiu	$4,$4,%lo(kAtanTbl) # low
	sll	$3,$2,2
	addu	$3,$3,$4
	addu	$2,$2,1
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$6,0($3)
	lw	$2,0($2)
	andi	$5,$5,0xffff
	subu	$2,$2,$6
	mult	$2,$5
	mflo	$7
	#nop
	#nop
	srl	$2,$7,16
	addu	$6,$6,$2
$L5:
	sltu	$2,$17,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	lui	$2,%hi($L18) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L18) # low
	sll	$3,$17,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L18:
	.word	$L9
	.word	$L10
	.word	$L11
	.word	$L12
	.word	$L13
	.word	$L14
	.word	$L15
	.word	$L16
	.text
$L10:
	subu	$2,$0,$6
	.set	noreorder
	.set	nomacro
	j	$L9
	addu	$6,$2,16384
	.set	macro
	.set	reorder

$L11:
	li	$2,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	j	$L19
	subu	$2,$2,$6
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	j	$L19
	addu	$2,$6,16384
	.set	macro
	.set	reorder

$L13:
	.set	noreorder
	.set	nomacro
	j	$L19
	subu	$2,$0,$6
	.set	macro
	.set	reorder

$L14:
	.set	noreorder
	.set	nomacro
	j	$L19
	addu	$2,$6,-16384
	.set	macro
	.set	reorder

$L15:
	li	$2,-32768			# 0xffff8000
	.set	noreorder
	.set	nomacro
	j	$L19
	addu	$2,$6,$2
	.set	macro
	.set	reorder

$L16:
	subu	$2,$0,$6
	.set	noreorder
	.set	nomacro
	j	$L19
	addu	$2,$2,-16384
	.set	macro
	.set	reorder

	.def	return_a2;	.val	$L9;	.scl	6;	.type	0x0;	.endef
$L9:
	move	$2,$6
$L19:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	fixedatan
	.def	kAtanTbl;	.val	kAtanTbl;	.scl	3;	.dim	257;	.size	1028;	.type	0x34;	.endef
