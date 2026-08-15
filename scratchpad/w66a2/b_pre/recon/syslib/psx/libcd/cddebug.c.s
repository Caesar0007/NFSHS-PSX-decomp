	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\cddebug.c"
gcc2_compiled.:
__gnu_compiled_c:
	.globl	CD_comstr
	.data
	.align	2
CD_comstr:
	.word	$LC0
	.word	$LC1
	.word	$LC2
	.word	$LC3
	.word	$LC4
	.word	$LC5
	.word	$LC6
	.word	$LC7
	.word	$LC8
	.word	$LC9
	.word	$LC10
	.word	$LC11
	.word	$LC12
	.word	$LC13
	.word	$LC14
	.word	$LC15
	.word	$LC16
	.word	$LC17
	.word	$LC15
	.word	$LC18
	.word	$LC19
	.word	$LC20
	.word	$LC21
	.word	$LC15
	.word	$LC15
	.word	$LC15
	.word	$LC15
	.word	$LC22
	.word	$LC15
	.word	$LC15
	.word	$LC15
	.word	$LC15
	.rdata
	.align	2
$LC22:
	.ascii	"CdlReadS\000"
	.align	2
$LC21:
	.ascii	"CdlSeekP\000"
	.align	2
$LC20:
	.ascii	"CdlSeekL\000"
	.align	2
$LC19:
	.ascii	"CdlGetTD\000"
	.align	2
$LC18:
	.ascii	"CdlGetTN\000"
	.align	2
$LC17:
	.ascii	"CdlGetlocP\000"
	.align	2
$LC16:
	.ascii	"CdlGetlocL\000"
	.sdata
	.align	2
$LC15:
	.ascii	"?\000"
	.rdata
	.align	2
$LC14:
	.ascii	"CdlSetmode\000"
	.align	2
$LC13:
	.ascii	"CdlSetfilter\000"
	.align	2
$LC12:
	.ascii	"CdlDemute\000"
	.align	2
$LC11:
	.ascii	"CdlMute\000"
	.align	2
$LC10:
	.ascii	"CdlReset\000"
	.align	2
$LC9:
	.ascii	"CdlPause\000"
	.align	2
$LC8:
	.ascii	"CdlStop\000"
	.align	2
$LC7:
	.ascii	"CdlStandby\000"
	.align	2
$LC6:
	.ascii	"CdlReadN\000"
	.align	2
$LC5:
	.ascii	"CdlBackward\000"
	.align	2
$LC4:
	.ascii	"CdlForward\000"
	.align	2
$LC3:
	.ascii	"CdlPlay\000"
	.align	2
$LC2:
	.ascii	"CdlSetloc\000"
	.align	2
$LC1:
	.ascii	"CdlNop\000"
	.align	2
$LC0:
	.ascii	"CdlSync\000"
	.globl	CD_intstr
	.data
	.align	2
CD_intstr:
	.word	$LC23
	.word	$LC24
	.word	$LC25
	.word	$LC26
	.word	$LC27
	.word	$LC28
	.word	$LC15
	.word	$LC15
	.rdata
	.align	2
$LC28:
	.ascii	"DiskError\000"
	.align	2
$LC27:
	.ascii	"DataEnd\000"
	.align	2
$LC26:
	.ascii	"Acknowledge\000"
	.align	2
$LC25:
	.ascii	"Complete\000"
	.align	2
$LC24:
	.ascii	"DataReady\000"
	.align	2
$LC23:
	.ascii	"NoIntr\000"
	.text

	.text
	.def	CD_comstr;	.val	CD_comstr;	.scl	2;	.dim	32;	.size	128;	.type	0x72;	.endef
	.def	CD_intstr;	.val	CD_intstr;	.scl	2;	.dim	8;	.size	32;	.type	0x72;	.endef
