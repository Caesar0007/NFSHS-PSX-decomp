	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PAD.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.globl	_padFuncNextPort
	.sdata
	.align	2
_padFuncNextPort:
	.word	0
	.globl	_padFuncClrInfo
	.align	2
_padFuncClrInfo:
	.word	0
	.globl	_padFuncGetTxd
	.align	2
_padFuncGetTxd:
	.word	0
	.globl	_padFuncCurrLimit
	.align	2
_padFuncCurrLimit:
	.word	0
	.globl	_padFuncPtr2Port
	.align	2
_padFuncPtr2Port:
	.word	0
	.globl	_padFuncPort2Info
	.align	2
_padFuncPort2Info:
	.word	0
	.globl	_padFuncSendAuto
	.align	2
_padFuncSendAuto:
	.word	0
	.globl	_padFuncChkEng
	.align	2
_padFuncChkEng:
	.word	0
	.globl	_padFuncRecvAuto
	.align	2
_padFuncRecvAuto:
	.word	0
	.globl	_padFuncClrCmdNo
	.align	2
_padFuncClrCmdNo:
	.word	0
	.globl	_padFuncIntGun
	.align	2
_padFuncIntGun:
	.word	0
	.globl	_padFuncSetGunPort
	.align	2
_padFuncSetGunPort:
	.word	0
	.globl	_padFuncGetGunPos
	.align	2
_padFuncGetGunPos:
	.word	0
	.globl	_padInfoDir
	.align	2
_padInfoDir:
	.word	0
	.globl	_padIntExec
	.align	2
_padIntExec:
	.word	0
	.globl	_padGunExec
	.align	2
_padGunExec:
	.word	0
	.globl	_padSioChan
	.align	2
_padSioChan:
	.word	0
	.globl	_padSioState
	.align	2
_padSioState:
	.word	0
	.globl	_padTotalCurr
	.align	2
_padTotalCurr:
	.word	0
	.globl	_padModeMtap
	.align	2
_padModeMtap:
	.word	0
	.globl	_padChanStart
	.align	2
_padChanStart:
	.word	0
	.globl	_padChanStop
	.align	2
_padChanStop:
	.word	1
	.globl	_padFixResult
	.data
	.align	2
_padFixResult:
	.word	-1
	.word	-1
	.globl	_padIntRegs
	.sdata
	.align	2
_padIntRegs:
	.word	528486512
	.globl	_padSioRegs
	.align	2
_padSioRegs:
	.word	528486464
	.globl	_padVbExec
	.align	2
_padVbExec:
	.word	0
	.globl	_waitTime
	.align	2
_waitTime:
	.word	0
	.globl	_startTime
	.align	2
_startTime:
	.word	0
	.globl	padIntFunc
	.data
	.align	2
padIntFunc:
	.word	_padIntInit
	.word	_padIntQuery
	.word	_padIntRecvId
	.word	_padIntRecvHdr
	.word	_padIntRecvData
	.text

	.text
	.def	PadIntFn;	.scl	13;	.type	0x94;	.endef
	.def	_padFuncNextPort;	.val	_padFuncNextPort;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncClrInfo;	.val	_padFuncClrInfo;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncGetTxd;	.val	_padFuncGetTxd;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncCurrLimit;	.val	_padFuncCurrLimit;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncPtr2Port;	.val	_padFuncPtr2Port;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncPort2Info;	.val	_padFuncPort2Info;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncSendAuto;	.val	_padFuncSendAuto;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncChkEng;	.val	_padFuncChkEng;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncRecvAuto;	.val	_padFuncRecvAuto;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncClrCmdNo;	.val	_padFuncClrCmdNo;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncIntGun;	.val	_padFuncIntGun;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncSetGunPort;	.val	_padFuncSetGunPort;	.scl	2;	.type	0x11;	.endef
	.def	_padFuncGetGunPos;	.val	_padFuncGetGunPos;	.scl	2;	.type	0x11;	.endef
	.def	_padInfoDir;	.val	_padInfoDir;	.scl	2;	.type	0x1c;	.endef
	.def	_padIntExec;	.val	_padIntExec;	.scl	2;	.type	0x4;	.endef
	.def	_padGunExec;	.val	_padGunExec;	.scl	2;	.type	0x4;	.endef
	.def	_padSioChan;	.val	_padSioChan;	.scl	2;	.type	0x4;	.endef
	.def	_padSioState;	.val	_padSioState;	.scl	2;	.type	0x4;	.endef
	.def	_padTotalCurr;	.val	_padTotalCurr;	.scl	2;	.type	0x4;	.endef
	.def	_padModeMtap;	.val	_padModeMtap;	.scl	2;	.type	0x4;	.endef
	.def	_padChanStart;	.val	_padChanStart;	.scl	2;	.type	0x4;	.endef
	.def	_padChanStop;	.val	_padChanStop;	.scl	2;	.type	0x4;	.endef
	.def	_padFixResult;	.val	_padFixResult;	.scl	2;	.dim	2;	.size	8;	.type	0x34;	.endef
	.def	_padIntRegs;	.val	_padIntRegs;	.scl	2;	.type	0x1c;	.endef
	.def	_padSioRegs;	.val	_padSioRegs;	.scl	2;	.type	0x1c;	.endef
	.def	_padVbExec;	.val	_padVbExec;	.scl	2;	.type	0x4;	.endef
	.def	_waitTime;	.val	_waitTime;	.scl	2;	.type	0x4;	.endef
	.def	_startTime;	.val	_startTime;	.scl	2;	.type	0x4;	.endef
	.def	padIntFunc;	.val	padIntFunc;	.scl	2;	.dim	5;	.size	20;	.type	0x274;	.endef
