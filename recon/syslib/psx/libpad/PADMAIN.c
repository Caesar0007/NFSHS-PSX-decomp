/* syslib/psx/libpad/PADMAIN.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 authoritative; Ghidra
 *   for the stable bodies).  obj libpad.lib(PADMAIN.OBJ): the SIO0 controller-port serial engine --
 *   the interrupt-driven core that actually talks to the pad hardware.  11 functions:
 *     _padSetVsyncParam  install the VSync interrupt-handler element (_padVbCallback0/1)
 *     _padVbCallback1    IRP verifier  (runs only on a VSync IRQ)
 *     _padVbCallback0    IRP handler   (pumps _padSioMain across the active channels each frame)
 *     _padStartCom/_padStopCom  enable/disable the handler + root-counter
 *     _padInitSioMode    bring SIO0 up for one port, fix auto-mode, prime the exchange
 *     _padSioMain        step the per-port SIO state-function table
 *     _padSioRW/_padSioRW2  exchange one byte over SIO0 (RW2 = timer-bounded)
 *     _padClrIntSio0     acknowledge the SIO0 IRQ
 *     _padWaitRXready    spin until the SIO0 RX FIFO has a byte
 *
 *   HARDWARE ACCESS: the original reaches the SIO0 register block and the interrupt registers through
 *   two cached base pointers (set at init) rather than literal MMIO -- _padSioRegs (-> 0x1F801040)
 *   and _padIntRegs (-> 0x1F801070).  Root-counter-2 (timer) is touched as literal MMIO.  Modeled
 *   faithfully below; on the host none of this runs (compiles, never executes off-PSX). */

/* ---- kernel / cross-obj helpers -------------------------------------------------------------- */
extern int  EnterCriticalSection(void);     /* A36 @0x8010698C */
extern void ExitCriticalSection(void);      /* A37 @0x8010696C */
extern void ChangeClearRCnt(int n, int m);  /* L10 @0x80106664 */
extern void SysDeqIntRP(int pri, void *rp); /* L03 @0x8010BFC8 */
extern void SysEnqIntRP(int pri, void *rp); /* L02 @0x8010BFD8 */
extern unsigned setRC2wait(int ticks);      /* WAITRC2 @0x8010BFE8 */
extern int      chkRC2wait(void);           /* WAITRC2 @0x8010C008 */

/* ---- SIO0 + interrupt register blocks, reached via libpad's cached base pointers (PAD.OBJ) ----- */
extern unsigned char *_padSioRegs;   /* @0x80137CDC -> 0x1F801040 : SIO0 (JOY) block base */
extern unsigned char *_padIntRegs;   /* @0x80137CD8 -> 0x1F801070 : interrupt I_STAT/I_MASK */
#define JOY_DATA8 (*(volatile unsigned char  *)(_padSioRegs))
#define JOY_STAT  (*(volatile unsigned short *)(_padSioRegs + 0x04))
#define JOY_MODE  (*(volatile unsigned short *)(_padSioRegs + 0x08))
#define JOY_CTRL  (*(volatile unsigned short *)(_padSioRegs + 0x0a))
#define JOY_BAUD  (*(volatile unsigned short *)(_padSioRegs + 0x0e))
#define I_STAT    (*(volatile unsigned int   *)(_padIntRegs + 0x00))
#define I_MASK    (*(volatile unsigned int   *)(_padIntRegs + 0x04))
/* root counter 2 (literal MMIO) */
#define T2_VALUE  (*(volatile unsigned short *)0x1F801120)
#define T2_MODE   (*(volatile unsigned short *)0x1F801124)
#define T2_TARGET (*(volatile unsigned short *)0x1F801128)

/* ---- libpad state globals (defined in PAD.OBJ data) ------------------------------------------- */
extern int            _padIntExec;          /* engine-running flag */
extern int            _padSioState;         /* current SIO state-fn index */
extern int            _padSioChan;          /* channel being serviced (0..1) */
extern int            _padChanStart;        /* first active channel */
extern int            _padChanStop;         /* last active channel */
extern int            _padTotalCurr;        /* total actuator current draw */
extern unsigned char *_padInfoDir;          /* per-port info array base (0xF0 bytes/port) */
extern int            _padFixResult[2];     /* @0x80137CD0 : per-channel auto-mode retry count */
extern int            padIntFunc[];         /* SIO state-function pointer table */
extern int            _startTime;           /* RC2 timestamp at transfer start */
extern int            _waitTime;            /* RC2 timeout budget */
extern int            _padVbExec;           /* @0x80137CE0 : verifier-fired flag */

/* dispatch slots (set per pad mode; defined in PAD.OBJ) */
extern int  (*_padFuncNextPort)(int flag);
extern int  (*_padFuncRecvAuto)(unsigned char *info);
extern void (*_padFuncClrInfo)(unsigned char *info);
extern void (*_padFuncClrCmdNo)(unsigned char *info);
extern int  (*_padFuncIntGun)(void);

/* internal fns (forward) */
extern int  _padInitSioMode(unsigned char *info);
extern void _padSioMain(unsigned char *info);
extern void _padClrIntSio0(void);
extern void _padWaitRXready(void);

/* ---- the VSync interrupt-handler element (Interrupt Request Path) ----------------------------- */
struct _PadIntRP {
    struct _PadIntRP *next;        /* +0x00 */
    void     (*handler)();  /* +0x04 */
    int      (*verifier)(); /* +0x08 */
    int        _pad0c;      /* +0x0c */
};
typedef struct _PadIntRP _PadIntRP;
static _PadIntRP _padVbCb;              /* @0x8014857C */
/* MATCH (w51-a5): ONE 2-int ARRAY, not two scalars.  _padStartCom's oracle clears both through a
 * SINGLE base (`lui $v0; addiu $v0,%lo; sw $zero,4($v0); sw $zero,0($v0)`) -- only an array gives
 * that anchor; two independent statics emit two `lui $at; sw` macro pairs.  The 8-byte size also
 * keeps it out of .sdata under -G4, matching the oracle's absolute addressing (two 4-byte scalars
 * would be gp-relative).  [0] = frames since start @0x8014858C, [1] = since stop @0x80148590. */
static int       _padFrames[2];
#define _padFramesSinceStart _padFrames[0]
#define _padFramesSinceStop  _padFrames[1]

/* prototypes for the handler/verifier installed into the IRP */
extern int  _padVbCallback0(void);
extern int  _padVbCallback1(void);

/* @0x80104A1C : _padSetVsyncParam -- point the IRP at our handler/verifier.
 * w48-a3: PASS 11/11 (was FAIL 16, count-exact).  The residual was pure ADDRESS-ANCHOR shape:
 * retail materializes ONE base = `&_padVbCb.handler` (i.e. the symbol + 4) and reaches all four
 * words off it with displacements 0 / +4 / -4 / +8, INCLUDING the negative one for `.next`; our
 * field-name form made cc1 keep the %hi half in one register (fused-%lo store for `.next`) and the
 * full address in another -- 2 base materializations.  Writing the anchor as an explicit pointer
 * local at the +4 field reproduces it (catalog w42 "SYM-declared-but-unused pointer local = the
 * base anchor" / negative-displacement family), and the OPACITY FENCE completes the anchor's
 * `addiu %lo` BEFORE the first store, where cc1 otherwise sinks it past the store (the last 2
 * diffs).  A plain use-fence `__asm__("" : : "r"(p))` does NOT do it (16) -- the "=r"/"0" identity
 * form is required; reordering the stores does not either.  The four stores keep retail's order. */
extern void _padSetVsyncParam(void)
{
    void (**p)() = &_padVbCb.handler;         /* MATCH: retail's +4 base anchor */
    __asm__("" : "=r"(p) : "0"(p));           /* MATCH: 0 insns; completes the addiu %lo here */
    p[0] = (void (*)())_padVbCallback0;       /* +0x04 handler  */
    p[1] = (void (*)())_padVbCallback1;       /* +0x08 verifier */
    p[-1] = 0;                                /* +0x00 next     */
    p[2] = 0;                                 /* +0x0c _pad0c   */
}

/* @0x80104A48 : _padVbCallback1 -- IRP verifier: only accept the VSync (bit 0) interrupt. */
extern int _padVbCallback1(void)
{
    if ((I_MASK & 1) != 0 && (I_STAT & 1) != 0) {
        if (_padFuncIntGun != 0)
            _padFuncIntGun();
        return 1;
    }
    return 0;
}

/* @0x80104AB0 : _padVbCallback0 -- IRP handler: once armed, pump the SIO engine across the
 *   active channel range every VSync frame. */
extern int _padVbCallback0(void)
{
    _padVbExec = 1;                              /* MATCH (w51-a5): the oracle's store sits in the
                                                  * `beqz $v1,.L80104AF0` DELAY SLOT, so it is
                                                  * UNCONDITIONAL -- it was wrongly inside the
                                                  * `if` (a real runtime bug: the verifier flag
                                                  * never set when _padChanStart == 0). */
    if (_padChanStart != 0) {
        int *n = &_padFramesSinceStart;      /* MATCH: retail holds the counter's ADDRESS in one
                                              * reg (`lui;addiu` then `lw 0(a0)`/`sw 0(a0)`); a
                                              * bare global gives two fused `lui;lw`/`lui;sw` */
        if (*n < 0x96)
            *n = *n + 1;
    }
    if (_padChanStop == 0) {
        int *n = &_padFramesSinceStop;
        if (*n < 0x96)
            *n = *n + 1;
    }
    if (_padIntExec != 0 && _padChanStop >= _padChanStart) {
        _padSioState = 0;
        _padSioChan  = _padChanStart;
        if (_padInitSioMode(_padInfoDir + _padChanStart * 0xf0) == 0)
            _padFuncNextPort(0xffff);
        _padTotalCurr = 0;
        while (_padChanStop >= _padSioChan)
            _padSioMain(_padInfoDir + _padSioChan * 0xf0);
        JOY_BAUD = 0x88;
    }
    return 0;                                    /* MATCH: the oracle stages `addu $v0,$zero,$zero`
                                                  * in the epilogue -- it is an int IRP handler */
}

/* @0x80104C1C : _padStartCom -- arm the engine: chain in the VSync IRP, enable RCnt, clear info. */
extern void _padStartCom(void)
{
    _padIntExec = 0;
    EnterCriticalSection();
    SysDeqIntRP(2, &_padVbCb);
    SysEnqIntRP(2, &_padVbCb);
    I_STAT = 0xfffffffe;
    I_MASK = I_MASK | 1;
    ChangeClearRCnt(3, 0);
    ExitCriticalSection();
    _padFuncClrInfo(_padInfoDir);
    _padFuncClrInfo(_padInfoDir + 0xf0);
    _padFramesSinceStop  = 0;
    _padFramesSinceStart = 0;
    _padIntExec = 1;
}

/* @0x80104CE8 : _padStopCom -- unchain the IRP. */
extern void _padStopCom(void)
{
    EnterCriticalSection();
    ChangeClearRCnt(3, 1);
    SysDeqIntRP(2, &_padVbCb);
    ExitCriticalSection();
}

/* @0x80104D2C : _padInitSioMode -- configure SIO0 for `info`'s port, run any pending auto-mode
 *   fix-ups, then exchange the 0x01/0x42/0x01 select+poll prologue.  Returns 1 on success. */
extern int _padInitSioMode(unsigned char *info)
{
    unsigned int u;
    int wait;

    JOY_CTRL = 0;
    JOY_MODE = 0xd;
    JOY_BAUD = 0x88;
    wait = 0x91;
    if (info[0xe8] == 8)
        wait = 0x50;
    setRC2wait(wait);
    JOY_CTRL = 0x1003;
    if (_padSioChan != 0)
        JOY_CTRL = 0x3003;

    /* drain any queued auto-mode recv fix-ups for this channel */
    if (_padFixResult[_padSioChan] >= 0) {
        while (_padFixResult[_padSioChan] > 0) {
            _padFixResult[_padSioChan] = _padFixResult[_padSioChan] - 1;
            _padFuncRecvAuto(info + _padFixResult[_padSioChan] * 0xf0);
        }
        if (_padFixResult[_padSioChan] == 0) {
            _padFixResult[_padSioChan] = -1;
            _padFuncRecvAuto(info);
            _padFuncClrCmdNo(info);
        }
    }

    if ((JOY_STAT & 0x200) != 0) {
        JOY_CTRL = JOY_CTRL | 0x10;
        if ((JOY_STAT & 0x200) != 0) {
            do {
            } while (chkRC2wait() == 0);
            JOY_DATA8 = 1;                       /* 0x01 : select controller */
            u = setRC2wait(100);
            _padClrIntSio0();
            if (u == 0) return 0;
            _padWaitRXready();
            setRC2wait(0x1ae);
            do {
                if ((I_STAT & 0x80) != 0) {
                    JOY_DATA8 = 0x42;            /* 0x42 : poll */
                    u = setRC2wait(0x3c);
                    _padClrIntSio0();
                    if (u == 0) return 0;
                    _padWaitRXready();
                    setRC2wait(0x1ae);
                    do {
                        if ((I_STAT & 0x80) != 0) {
                            JOY_DATA8 = 1;
                            u = setRC2wait(0x3c);
                            _padClrIntSio0();
                            if (u == 0) return 0;
                            _padWaitRXready();
                            return 0;
                        }
                    } while (chkRC2wait() == 0);
                    return 0;
                }
            } while (chkRC2wait() == 0);
            return 0;
        }
        I_STAT = 0xffffff7f;
    }
    if (info[0x50] == 0)
        return 1;
    if (info[0x36] != 0)
        return 0;
    return 1;
}

/* @0x80105060 : _padSioMain -- run the next SIO state function; advance / retire on its result. */
extern void _padSioMain(unsigned char *info)
{
    int (*fn)(unsigned char *);
    int r;
    unsigned u;

    fn = (int (*)(unsigned char *))padIntFunc[_padSioState];
    _padSioState = _padSioState + 1;
    r = fn(info);
    if (r < 0) {
        _padFuncNextPort(r);
    } else {
        if (_padSioState != 0) {
            u = setRC2wait(0x3c);
            _padClrIntSio0();
            if (u == 0)
                _padFuncNextPort(0xfffffffd);
        }
        if (_padSioState > 4)
            _padSioState = _padSioState - 1;
    }
}

/* @0x80105128 : _padSioRW -- exchange one byte; first byte (arg2<0) issues the line, else polls. */
extern unsigned _padSioRW(unsigned char *dev, unsigned arg2)
{
    unsigned r;
    unsigned ack;
    unsigned ret;
    unsigned char rx;

    int again;

    rx = JOY_DATA8;
    if ((int)arg2 < 0) {
        ret = JOY_DATA8;
        dev[0x44] = 0xff;
        dev[0x45] = 1;
        **(unsigned char **)(dev + 0x40) = (unsigned char)~arg2;
        do {
            r = JOY_STAT & 1;
        } while ((JOY_STAT & 1) == 0);
        do {
            chkRC2wait();
            again = (r == 0);
            r = ~arg2;
        } while (again);
        JOY_DATA8 = (unsigned char)r;
    } else {
        JOY_BAUD = 0x88;
        if ((int)(unsigned)**(unsigned char **)(dev + 0x3c) >> 4 == 8 && dev[0x44] > 8)
            JOY_BAUD = 0x22;
        _startTime = (int)T2_VALUE;
        _waitTime  = 0x1ae;
        do {
        } while ((JOY_STAT & 2) == 0);
        r = JOY_DATA8;
        do {
            ack = I_STAT & 0x80;
            if (ack != 0) {
                JOY_DATA8 = (unsigned char)arg2;
                dev[0x45] = dev[0x45] + 1;
                *(*(unsigned char **)(dev + 0x3c) + dev[0x44]) = rx;
                dev[0x44] = dev[0x44] + 1;
                return r;
            }
            chkRC2wait();
            ret = 0xffffffec;
        } while (ack == 0);
    }
    return ret;
}

/* @0x80105300 : _padSioRW2 -- like _padSioRW but bounded by the RC2 timer (no busy ACK spin). */
extern unsigned _padSioRW2(unsigned char *dev, int tx)
{
    unsigned r;
    unsigned t;
    unsigned char rx;

    unsigned short baud;
    int again;

    baud = 0x88;
    if ((int)(unsigned)**(unsigned char **)(dev + 0x3c) >> 4 == 8 && dev[0x44] > 8)
        baud = 0x22;
    do {
    } while ((JOY_STAT & 2) == 0);
    setRC2wait(400);
    rx = JOY_DATA8;
    r  = JOY_DATA8;
    JOY_BAUD = baud;
    if (dev[0x44] == 0 && (int)r >> 4 == 8)
        JOY_BAUD = 0x22;
    do {
        if ((I_STAT & 0x80) != 0) {
            if (dev[0xe8] != 8 && _padSioState == 2) {
                t = setRC2wait(0x3c);
                do {
                    chkRC2wait();
                    again = (t == 0);
                    t = 0;
                } while (again);
            }
            JOY_DATA8 = (unsigned char)tx;
            dev[0x45] = dev[0x45] + 1;
            if ((signed char)dev[0x44] != -1)
                *(*(unsigned char **)(dev + 0x3c) + dev[0x44]) = rx;
            dev[0x44] = dev[0x44] + 1;
            return r;
        }
        t = (unsigned)T2_VALUE;
        if (t < (unsigned)_startTime) {
            if (T2_TARGET == 0)
                t = t + 0x10000;
            else
                t = T2_TARGET + t;
        }
        t = t - _startTime;
        if ((T2_MODE & 0x200) == 0)
            t = t >> 3;
    } while (t < (unsigned)_waitTime);
    return 0xfffffffe;
}

/* @0x80105538 : _padClrIntSio0 -- ack the SIO0 IRQ and re-enable. */
extern void _padClrIntSio0(void)
{
    I_STAT = 0xffffff7f;
    do {
        if ((JOY_STAT & 0x80) == 0) {
            JOY_CTRL = JOY_CTRL | 0x10;
            return;
        }
        chkRC2wait();
    } while ((JOY_STAT & 0x80) != 0);
}

/* @0x801055C8 : _padWaitRXready -- spin until SIO0 RX has a byte (STAT bit 1). */
extern void _padWaitRXready(void)
{
    do {
    } while ((JOY_STAT & 2) == 0);
}
