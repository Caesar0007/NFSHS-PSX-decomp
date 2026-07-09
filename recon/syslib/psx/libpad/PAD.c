/* syslib/psx/libpad/PAD.c -- RECONSTRUCTED from nfs4-f.exe (SYM + Ghidra/disasm cross-ref).
 *   obj libpad.lib(PAD.OBJ): the libpad DATA module -- it defines (provides storage for) every
 *   global the libpad code objects declare extern: the function-pointer dispatch table (_padFunc*,
 *   wired at runtime by PadInitDirect / _padInitDirSeq), the SIO-engine state-function table
 *   padIntFunc[] (statically pointing at the five MCXMAIN steps), the engine state variables, and
 *   the two cached HW register-block base pointers.  No executable code -- pure .data/.bss.
 *
 *   The dispatch slots are runtime-assigned, so they are defined here as pointer-sized 0-initialised
 *   storage (each consumer declares them with its own concrete function-pointer type; C linkage
 *   resolves them by name).  Original addresses kept as @VA breadcrumbs in comments. */

/* the five SIO state-function steps that padIntFunc[] points at (defined in MCXMAIN.OBJ) */
extern int      _padIntInit(unsigned char *info);     /* MCXMAIN @0x8010C0A8 */
extern unsigned _padIntQuery(unsigned char *info);    /* MCXMAIN @0x8010C0F0 */
extern int      _padIntRecvId(unsigned char *info);   /* MCXMAIN @0x8010C1C8 */
extern unsigned _padIntRecvHdr(unsigned char *info);  /* MCXMAIN @0x8010C288 */
extern unsigned _padIntRecvData(unsigned char *info); /* MCXMAIN @0x8010C314 */

typedef int (*PadIntFn)(unsigned char *info);



/* ---- _padFunc* dispatch slots @0x80137C78.. (set by PadInitDirect / _padInitDirSeq) ----------- */
void *_padFuncNextPort   = 0;   /* @0x80137C78 */
void *_padFuncClrInfo    = 0;   /* @0x80137C7C */
void *_padFuncGetTxd     = 0;   /* @0x80137C80 */
void *_padFuncCurrLimit  = 0;   /* @0x80137C84 */
void *_padFuncPtr2Port   = 0;   /* @0x80137C88 */
void *_padFuncPort2Info  = 0;   /* @0x80137C8C */
void *_padFuncSendAuto   = 0;   /* @0x80137C90 */
void *_padFuncChkEng     = 0;   /* @0x80137C94 */
void *_padFuncRecvAuto   = 0;   /* @0x80137C98 */
void *_padFuncClrCmdNo   = 0;   /* @0x80137C9C */
void *_padFuncIntGun     = 0;   /* @0x80137CA0 */
void *_padFuncSetGunPort = 0;   /* @0x80137CA4 */
void *_padFuncGetGunPos  = 0;   /* @0x80137CA8 */

/* ---- engine state @0x80137CAC.. -------------------------------------------------------------- */
unsigned char *_padInfoDir   = 0;   /* @0x80137CAC : per-port info array base */
int            _padIntExec   = 0;   /* @0x80137CB0 : engine armed */
int            _padGunExec   = 0;   /* @0x80137CB4 : light-gun active */
int            _padSioChan   = 0;   /* @0x80137CB8 : channel being serviced */
int            _padSioState  = 0;   /* @0x80137CBC : SIO state index */
int            _padTotalCurr = 0;   /* @0x80137CC0 : actuator current draw */
int            _padModeMtap  = 0;   /* @0x80137CC4 : multitap mode */
int            _padChanStart = 0;   /* @0x80137CC8 : first active channel */
int            _padChanStop  = 0;   /* @0x80137CCC : last active channel */
int            _padFixResult[2] = { 0, 0 };  /* @0x80137CD0 : per-channel auto-fix count */

/* ---- cached HW register-block base pointers (point at the I/O page) --------------------------- */
unsigned char *_padIntRegs = (unsigned char *)0x1F801070;  /* @0x80137CD8 : I_STAT/I_MASK */
unsigned char *_padSioRegs = (unsigned char *)0x1F801040;  /* @0x80137CDC : SIO0 (JOY) block */
int            _padVbExec  = 0;     /* @0x80137CE0 : VSync verifier-fired flag */

/* ---- RC2 wait state @0x80148AAC.. ------------------------------------------------------------ */
int _waitTime  = 0;   /* @0x80148AAC */
int _startTime = 0;   /* @0x80148AB0 */

/* ---- SIO engine state-function table @0x8013C314 (the five MCXMAIN steps) --------------------- */
PadIntFn padIntFunc[5] = {   /* @0x8013C314 */
    (PadIntFn)_padIntInit,
    (PadIntFn)_padIntQuery,
    (PadIntFn)_padIntRecvId,
    (PadIntFn)_padIntRecvHdr,
    (PadIntFn)_padIntRecvData,
};

  /* extern */
