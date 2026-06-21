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
extern "C" int  EnterCriticalSection(void);     /* A36 @0x8010698C */
extern "C" void ExitCriticalSection(void);      /* A37 @0x8010696C */
extern "C" void ChangeClearRCnt(int n, int m);  /* L10 @0x80106664 */
extern "C" void SysDeqIntRP(int pri, void *rp); /* L03 @0x8010BFC8 */
extern "C" void SysEnqIntRP(int pri, void *rp); /* L02 @0x8010BFD8 */
extern "C" unsigned setRC2wait(int ticks);      /* WAITRC2 @0x8010BFE8 */
extern "C" int      chkRC2wait(void);           /* WAITRC2 @0x8010C008 */

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
extern "C" int            _padIntExec;          /* engine-running flag */
extern "C" int            _padSioState;         /* current SIO state-fn index */
extern "C" int            _padSioChan;          /* channel being serviced (0..1) */
extern "C" int            _padChanStart;        /* first active channel */
extern "C" int            _padChanStop;         /* last active channel */
extern "C" int            _padTotalCurr;        /* total actuator current draw */
extern "C" unsigned char *_padInfoDir;          /* per-port info array base (0xF0 bytes/port) */
extern "C" int            _padFixResult[2];     /* @0x80137CD0 : per-channel auto-mode retry count */
extern "C" int            padIntFunc[];         /* SIO state-function pointer table */
extern "C" int            _startTime;           /* RC2 timestamp at transfer start */
extern "C" int            _waitTime;            /* RC2 timeout budget */
extern "C" int            _padVbExec;           /* @0x80137CE0 : verifier-fired flag */

/* dispatch slots (set per pad mode; defined in PAD.OBJ) */
extern "C" int  (*_padFuncNextPort)(int flag);
extern "C" int  (*_padFuncRecvAuto)(unsigned char *info);
extern "C" void (*_padFuncClrInfo)(unsigned char *info);
extern "C" void (*_padFuncClrCmdNo)(unsigned char *info);
extern "C" int  (*_padFuncIntGun)(void);

/* internal fns (forward) */
extern "C" int  _padInitSioMode(unsigned char *info);
extern "C" void _padSioMain(unsigned char *info);
extern "C" void _padClrIntSio0(void);
extern "C" void _padWaitRXready(void);

/* ---- the VSync interrupt-handler element (Interrupt Request Path) ----------------------------- */
struct _PadIntRP {
    _PadIntRP *next;        /* +0x00 */
    void     (*handler)();  /* +0x04 */
    int      (*verifier)(); /* +0x08 */
    int        _pad0c;      /* +0x0c */
};
static _PadIntRP _padVbCb;              /* @0x8014857C */
static int       _padFramesSinceStart;  /* @0x8014858C : VSync frames since start (clamped 150) */
static int       _padFramesSinceStop;   /* @0x80148590 : VSync frames since stop  (clamped 150) */

/* prototypes for the handler/verifier installed into the IRP */
extern "C" void _padVbCallback0(void);
extern "C" int  _padVbCallback1(void);

/* @0x80104A1C : _padSetVsyncParam -- point the IRP at our handler/verifier. */
extern "C" void _padSetVsyncParam(void)
{
    _padVbCb.handler  = _padVbCallback0;
    _padVbCb.verifier = (int (*)())_padVbCallback1;
    _padVbCb.next     = 0;
    _padVbCb._pad0c   = 0;
}

/* @0x80104A48 : _padVbCallback1 -- IRP verifier: only accept the VSync (bit 0) interrupt. */
extern "C" int _padVbCallback1(void)
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
extern "C" void _padVbCallback0(void)
{
    if (_padChanStart != 0) {
        _padVbExec = 1;
        if (_padFramesSinceStart < 0x96)
            _padFramesSinceStart = _padFramesSinceStart + 1;
    }
    if (_padChanStop == 0) {
        if (_padFramesSinceStop < 0x96)
            _padFramesSinceStop = _padFramesSinceStop + 1;
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
}

/* @0x80104C1C : _padStartCom -- arm the engine: chain in the VSync IRP, enable RCnt, clear info. */
extern "C" void _padStartCom(void)
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
extern "C" void _padStopCom(void)
{
    EnterCriticalSection();
    ChangeClearRCnt(3, 1);
    SysDeqIntRP(2, &_padVbCb);
    ExitCriticalSection();
}

/* @0x80104D2C : _padInitSioMode -- configure SIO0 for `info`'s port, run any pending auto-mode
 *   fix-ups, then exchange the 0x01/0x42/0x01 select+poll prologue.  Returns 1 on success. */
extern "C" int _padInitSioMode(unsigned char *info)
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
extern "C" void _padSioMain(unsigned char *info)
{
    int (*fn)(unsigned char *);
    int r;
    unsigned u;

    fn = (int (*)(unsigned char *))padIntFunc[_padSioState];
    _padSioState = _padSioState + 1;
    r = fn(info);
    if (r < 0) {
        _padFuncNextPort(0);
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
extern "C" unsigned _padSioRW(unsigned char *dev, unsigned arg2)
{
    unsigned char rx;
    unsigned r, ack, ret;
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
extern "C" unsigned _padSioRW2(unsigned char *dev, int tx)
{
    unsigned char rx;
    unsigned r, t;
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
extern "C" void _padClrIntSio0(void)
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
extern "C" void _padWaitRXready(void)
{
    do {
    } while ((JOY_STAT & 2) == 0);
}
