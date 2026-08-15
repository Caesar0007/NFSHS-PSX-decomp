	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\vtables_aistate.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AIState_None_vtable
	.data
	.align	2
AIState_None_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__12AIState_None
	.half	0
	.half	0
	.word	___12AIState_None
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Cruise_vtable
	.align	2
AIState_Cruise_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__14AIState_Cruise
	.half	0
	.half	0
	.word	___14AIState_Cruise
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_GotoSlice_vtable
	.align	2
AIState_GotoSlice_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__17AIState_GotoSlice
	.half	0
	.half	0
	.word	___17AIState_GotoSlice
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Donuts_vtable
	.align	2
AIState_Donuts_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__14AIState_Donuts
	.half	0
	.half	0
	.word	___14AIState_Donuts
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_RovingTraffic_vtable
	.align	2
AIState_RovingTraffic_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__21AIState_RovingTraffic
	.half	0
	.half	0
	.word	___21AIState_RovingTraffic
	.half	0
	.half	0
	.word	TestForRelease__21AIState_RovingTraffic
	.globl	AIState_Purgatory_vtable
	.align	2
AIState_Purgatory_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__17AIState_Purgatory
	.half	0
	.half	0
	.word	___17AIState_Purgatory
	.half	0
	.half	0
	.word	TestForRelease__17AIState_Purgatory
	.globl	AIState_NonActive_vtable
	.align	2
AIState_NonActive_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__17AIState_NonActive
	.half	0
	.half	0
	.word	___17AIState_NonActive
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Offroad_vtable
	.align	2
AIState_Offroad_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__15AIState_Offroad
	.half	0
	.half	0
	.word	___15AIState_Offroad
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Chase_vtable
	.align	2
AIState_Chase_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__13AIState_Chase
	.half	0
	.half	0
	.word	___13AIState_Chase
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Idle_vtable
	.align	2
AIState_Idle_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__12AIState_Idle
	.half	0
	.half	0
	.word	___12AIState_Idle
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Normal_vtable
	.align	2
AIState_Normal_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	Execute__14AIState_Normal
	.half	0
	.half	0
	.word	___14AIState_Normal
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base
	.globl	AIState_Base_vtable
	.align	2
AIState_Base_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	__pure_virtual
	.half	0
	.half	0
	.word	_vtdtor_AIState_Base__FP12AIState_Base
	.half	0
	.half	0
	.word	TestForRelease__12AIState_Base

	.text
	.text
	.ent	_vtdtor_AIState_Base__FP12AIState_Base
_vtdtor_AIState_Base__FP12AIState_Base:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._12AIState_Base
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_vtdtor_AIState_Base__FP12AIState_Base
