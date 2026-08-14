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
extern void setRC2wait(int ticks);          /* WAITRC2 @0x8010BFE8 (VOID -- see WAITRC2.c) */
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
extern int _padClrIntSio0(void);
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
    /* MATCH (w53-a8, 4 -> PASS 91/91): COMPARE-OPERAND ORDER IS LOAD ORDER.  The oracle loads
     * `_padChanStart` into $v1 BEFORE `_padChanStop` into $v0 and then tests `slt $v0,$v0,$v1`;
     * writing the guard as `_padChanStop >= _padChanStart` emits the two macro loads in the
     * opposite order (4 diffs, count-exact).  `!(_padChanStop < _padChanStart)` is canonicalized
     * back to the wrong order (4) -- only the left-operand spelling reaches it. */
    if (_padIntExec != 0 && _padChanStart <= _padChanStop) {
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

/* @0x80104C1C : _padStartCom -- arm the engine: chain in the VSync IRP, enable RCnt, clear info.
 * MATCH (w53-a8, 12 @53/51 -> PASS 51/51).  TWO BASE ANCHORS, both read off the oracle:
 *  (1) `_padIntRegs` is ONE local base serving BOTH the I_STAT store and the I_MASK RMW -- retail
 *      materializes `lui $v1; lw $v1` once and then does `sw $v0,0($v1) / lw $v0,4($v1) /
 *      sw $v0,4($v1)`.  The bare macros reload the pointer for the I_MASK access (+2 insns).
 *  (2) the two frame counters are cleared through an EXPLICIT, FENCED pointer into `_padFrames`
 *      (`lui $v0; addiu $v0,%lo; sw $zero,4($v0); sw $zero,0($v0)`), stop ([1]) before start ([0]).
 *      A plain `int *f = _padFrames;` decl-init is copy-propagated straight back into two
 *      `lui $at; sw $zero,0($at)` assembler macros (8 diffs, count-exact); the zero-insn opacity
 *      fence makes the address a real pseudo -- and it must sit AT THE USE SITE: the same fence on
 *      a top-of-function decl-init costs 20 (the address then lives across all five calls). */
extern void _padStartCom(void)
{
    unsigned char *ir;
    int *f;

    _padIntExec = 0;
    EnterCriticalSection();
    SysDeqIntRP(2, &_padVbCb);
    SysEnqIntRP(2, &_padVbCb);
    ir = _padIntRegs;
    *(volatile unsigned int *)(ir + 0x00) = 0xfffffffe;
    *(volatile unsigned int *)(ir + 0x04) = *(volatile unsigned int *)(ir + 0x04) | 1;
    ChangeClearRCnt(3, 0);
    ExitCriticalSection();
    _padFuncClrInfo(_padInfoDir);
    _padFuncClrInfo(_padInfoDir + 0xf0);
    f = _padFrames;
    __asm__("" : "=r"(f) : "0"(f));
    f[1] = 0;                                /* _padFramesSinceStop  */
    f[0] = 0;                                /* _padFramesSinceStart */
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
/* MATCH (w59-root, 54 -> 24 at 203/205; earlier w52-a5, 198 -> 94) -- the matched
 * Sled Storm Sony-lib body at `pc-beta/sotn-sled/_padInitSioMode.c` confirms this control flow.
 * The direct ternary JOY_CTRL store removes two excess instructions, and a short-lived initial
 * `fix` value gives retail's AT-indexed load into v0 plus the delayed s1 base materialization.
 * The remaining 24 are isolated to GCC's phantom `vars=8` frame and the two-insn folded final
 * byte test.  Per-function -G8 is byte-identical; compiler ladder: 2.6.3=40,
 * 2.7.2-970404=186, 2.8.0/2.8.1=177, confirming 2.7.2 as the correct basin.
 * Five earlier ORACLE-READ corrections, three of them REAL BUGS:
 *  (1) setRC2wait is VOID (WAITRC2.c receipt) and it is _padClrIntSio0's RETURN that retail
 *      tests (`jal _padClrIntSio0; beqz $v0,<ret 0>`), not a setRC2wait result.  The old
 *      `u = setRC2wait(N); _padClrIntSio0(); if (u == 0)` shape tested the WRONG value.
 *  (2) BUG: the SIO reset store `JOY_CTRL = 0x40` before the `= 0` was missing entirely.
 *  (3) BUG: the queued-recv drain passed `info + n*0xF0`; retail indexes off the port-table
 *      pointer `*(u_char **)(info + 0xC) + n*0xF0` (`lw $v0,0xC($s0); addu $a0,$v0,$a0`).
 *  (4) ONE JOY_CTRL store fed by a selected constant (`chan ? 0x3003 : 0x1003`),
 *      not two stores -- retail's `beqz $v0 / addiu $v1,0x1003` + a single `sh $v1,0xA($a0)`.
 *  (5) each `_padWaitRXready()` is followed by a DISCARDED `JOY_DATA8` read (`lbu $v0,0($v0)`),
 *      and the I_STAT ack spins are top-tested `while ((I_STAT & 0x80) == 0) { if (chkRC2wait())
 *      return 0; }`, not do/while with the test in the body. */
extern int _padInitSioMode(unsigned char *info)
{
    JOY_CTRL = 0x40;
    JOY_CTRL = 0;
    JOY_MODE = 0xd;
    JOY_BAUD = 0x88;
    setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
    JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;

    /* drain any queued auto-mode recv fix-ups for this channel */
    {
        int fix = _padFixResult[_padSioChan];
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --_padFixResult[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     _padFixResult[_padSioChan] * 0xf0);
                } while (_padFixResult[_padSioChan] > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }

    if ((JOY_STAT & 0x200) != 0) {
        JOY_CTRL = JOY_CTRL | 0x10;
        if ((JOY_STAT & 0x200) != 0) {
            while (chkRC2wait() == 0)
                ;
            JOY_DATA8 = 1;                       /* 0x01 : select controller */
            setRC2wait(100);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)JOY_DATA8;
            setRC2wait(0x1ae);
            while ((I_STAT & 0x80) == 0) {
                if (chkRC2wait() != 0)
                    return 0;
            }
            JOY_DATA8 = 0x42;                    /* 0x42 : poll */
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)JOY_DATA8;
            setRC2wait(0x1ae);
            while ((I_STAT & 0x80) == 0) {
                if (chkRC2wait() != 0)
                    return 0;
            }
            JOY_DATA8 = 1;
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)JOY_DATA8;
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
/* MATCH (w53-a8, 34 -> 14, COUNT-EXACT 50/50).  Two facts:
 *  (1) ARM POLARITY: the oracle's `bltz $a0,<tail>` sends the r<0 case OUT-OF-LINE and falls
 *      through into the success path -- so the source tests `r >= 0` with the `_padFuncNextPort(r)`
 *      call as the `else`.  Writing `if (r < 0)` first inlines the error arm and inverts the
 *      branch (34 diffs).  Worth 15 on its own.
 *  (2) `_padSioState` is reached through ONE ANCHOR POINTER and its increment is a NAMED local
 *      stored back BEFORE the call, so the store lands in the `jalr` delay slot exactly like
 *      retail (`lw $v1,0($a1) / sll / lw fn / addiu $v1,$v1,1 / jalr $v0 / sw $v1,0($a1)`).
 *      Falsified: storing `*st` AFTER the call (27), an opacity fence on the anchor (27 there /
 *      14 here, identical), the named-`s` form without the anchor pointer (19 @49/50, one short).
 *  (3) the last 14 (a clean $v0<->$v1 swap on the dispatch head: retail keeps the STATE in $v1 and
 *      the FN POINTER in $v0, ours the reverse) is a local-alloc QTY-PRIORITY tie -- `fn` has 2
 *      refs, `s` has 3, so ours allocates `s` first and MIPS' numeric find_free_reg scan hands it
 *      $v0.  A ZERO-INSN read-only fence on `fn` buys the +1 ref that crosses the floor_log2 step
 *      and flips the pair (w49/w52 fence-dial law: read-only fence = +1 ref).  The identity fence
 *      also works; a fence on `s` (the demote direction) does NOT (14), nor does re-ordering the
 *      first uses so `fn` is born first (14). */
extern void _padSioMain(unsigned char *info)
{
    int (*fn)(unsigned char *);
    int r;
    int *st = &_padSioState;
    int s;

    s = *st;
    fn = (int (*)(unsigned char *))padIntFunc[s];
    __asm__("" : : "r"(fn));                     /* ref dial -- see (3) above */
    *st = s + 1;
    r = fn(info);
    if (r >= 0) {
        if (_padSioState != 0) {
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                _padFuncNextPort(0xfffffffd);
        }
        if (_padSioState > 4)
            _padSioState = _padSioState - 1;
    } else {
        _padFuncNextPort(r);
    }
}

/* @0x80105128 : _padSioRW -- exchange one byte; first byte (tx<0) issues the line, else polls.
 * MATCH (w59-root, 57 -> PASS 118/118; earlier w52-a5, 137 -> 59): rebuilt from the oracle.
 * Signature is `int (u_char*, int)` and BOTH
 * exits return the RX byte (`addu $v0,$s1,$zero`).  Corrections: chkRC2wait's RESULT drives the
 * spins (`while (chkRC2wait() == 0);` / `if (chkRC2wait() != 0) return -0x14;`) -- it was being
 * called and discarded; the BAUD value is SELECTED into a local and stored ONCE, late, next to the
 * `rx = JOY_DATA8` read (`sh $a2,0xE($v0)`), not written twice at the top; `_waitTime` is stored
 * BEFORE `_startTime`.  Final GCC-2.7.2 source-shape receipts: `rx` is an `int`; both arms share
 * one physical `return_rx` label; the negative transmit byte is a block-local `unsigned char`;
 * the positive arm caches SIO/IRQ bases only for their retail-sized phases; and both STAT waits
 * are guard + do/while shapes.  Most decisively, the timer value and the first volatile JOY_STAT
 * read are named locals loaded before the two timer stores.  That statement/lifetime order gives
 * retail's a2 baud, a1 SIO base, a0 timer, v1 STAT allocation and exact scheduling without asm. */
extern int _padSioRW(unsigned char *dev, int tx)
{
    int rx;

    if (tx < 0) {
        unsigned char *out = *(unsigned char **)(dev + 0x40);
        rx = JOY_DATA8;
        dev[0x44] = 0xff;
        dev[0x45] = 1;
        *out = (unsigned char)~tx;
        while ((JOY_STAT & 1) == 0)
            ;
        while (chkRC2wait() == 0)
            ;
        {
            unsigned char value = (unsigned char)~tx;
            volatile unsigned char *data = _padSioRegs;
            *data = value;
        }
        goto return_rx;
    } else {
        unsigned short baud = 0x88;
        int hdr = **(unsigned char **)(dev + 0x3c);
        if (hdr >> 4 == 8 && dev[0x44] > 8)
            baud = 0x22;
        {
            unsigned short start = T2_VALUE;
            unsigned char *sio = _padSioRegs;
            unsigned short stat;
            stat = *(volatile unsigned short *)(sio + 4);
            _waitTime  = 0x1ae;
            _startTime = start;
            if ((stat & 2) == 0) {
                do {
                } while ((JOY_STAT & 2) == 0);
            }
        }
        {
            unsigned char *sio = _padSioRegs;
            unsigned char *ir = _padIntRegs;
            rx = *(volatile unsigned char *)sio;
            *(volatile unsigned short *)(sio + 0xe) = baud;
            if ((*(volatile unsigned int *)ir & 0x80) == 0) {
                do {
                    if (chkRC2wait() != 0)
                        return -0x14;
                } while ((I_STAT & 0x80) == 0);
            }
        }
        JOY_DATA8 = (unsigned char)tx;
        dev[0x45] = dev[0x45] + 1;
        *(*(unsigned char **)(dev + 0x3c) + dev[0x44]) = rx;
        dev[0x44] = dev[0x44] + 1;
return_rx:
        return rx;
    }
}

/* @0x80105300 : _padSioRW2 -- like _padSioRW but bounded by the RC2 timer.
 * MATCH (w59-root, 36 -> 2, count-EXACT 142/142; earlier w52-a5, 157 -> 36): the matched
 * Sled Storm donor confirms the baud-arm polarity and the `T2_TARGET != 0` arm order.  `rx` is
 * an int normalized with `& 0xff`; an int index stages the required second `dev[0x44]` read.
 * The allocator boundary is only 0.1142 vs 0.1111: spelling the nibble threshold as
 * `baud - 0x80` adds the one real baud reference needed for retail s1/s2 ownership.  The sole
 * residual is therefore `addiu v0,s1,-128` versus retail `li v0,8`; `int baud` regresses to 14,
 * and -G8 is not a solution.  The ACK wait embeds an INLINE COPY of
 * chkRC2wait's body (retail hoists _startTime/_waitTime and the four RC2/SIO MMIO addresses into
 * $a0/$a1/$t1/$a2/$t2/$t0 above the loop -- a call could never produce that), returning -2 on
 * timeout.  Also: baud is a selected local stored once, and the second baud decision reads the
 * JUST-RECEIVED byte (`if (dev[0x44] == 0 && (int)rx >> 4 == 8) JOY_BAUD = 0x22;`).  The
 * prescale arms are ordered `(T2_MODE & 0x200) != 0` FIRST (fall-through) so the >>3 arm is the
 * beqz target, matching retail's block layout. */
extern int _padSioRW2(unsigned char *dev, int tx)
{
    unsigned short baud = 0x88;
    int rx;
    int hdr = **(unsigned char **)(dev + 0x3c);

    if (hdr >> 4 == 8 && dev[0x44] > 8)
        baud = 0x22;

    while ((JOY_STAT & 2) == 0)
        ;
    setRC2wait(0x190);
    rx = JOY_DATA8 & 0xff;
    if (*(volatile unsigned char *)(dev + 0x44) != 0 ||
        rx >> 4 != baud - 0x80)
        JOY_BAUD = baud;
    else
        JOY_BAUD = 0x22;

    while ((I_STAT & 0x80) == 0) {
        unsigned cur = T2_VALUE & 0xffff;
        if (cur < (unsigned)_startTime) {
            if (T2_TARGET != 0)
                cur += T2_TARGET;
            else
                cur += 0x10000;
        }
        if ((T2_MODE & 0x200) != 0) {
            if (cur - (unsigned)_startTime >= (unsigned)_waitTime)
                return -2;
        } else {
            if ((cur - (unsigned)_startTime) >> 3 >= (unsigned)_waitTime)
                return -2;
        }
    }
    if (dev[0xe8] != 8 && _padSioState == 2) {
        setRC2wait(0x3c);
        while (chkRC2wait() == 0)
            ;
    }
    JOY_DATA8 = (unsigned char)tx;
    {
        int idx = dev[0x44];
        dev[0x45] = dev[0x45] + 1;
        if (idx != 0xff) {
            idx = dev[0x44];
            *(*(unsigned char **)(dev + 0x3c) + idx) = rx;
        }
    }
    dev[0x44] = dev[0x44] + 1;
    return rx;
}

/* @0x80105538 : _padClrIntSio0 -- ack the SIO0 IRQ and re-enable. */
/* MATCH (w52-a5, 24 -> 7): the fn RETURNS int (retail stages `addu $v0,$zero,$zero` in the
 * timeout branch's delay slot and `addiu $v0,$zero,1` before the CTRL set) and the loop is a
 * PLAIN TOP-TESTED `while`, not a do/while with an in-body early return: gcc-2.8's jump.c
 * duplicate_loop_exit_test emits retail's second copy of the STAT test (the `.L8010559C`
 * reload+`bnez` back-edge).  Both call sites (MCXMAIN/_padSioMain) discard the result. */
/* MATCH (w53-a8, 8 @30/36 -> PASS 36/36).  Two cooperating facts, both read off the oracle:
 *  (1) THE WAIT IS A ZERO-TRIP-GUARDED do/while, not a plain `while`.  Retail tests SIO0 STAT
 *      ONCE before the loop (`lhu $v0,4($a0); andi 128; beqz`) and AGAIN at the back edge, with
 *      the two tests reaching the register base DIFFERENTLY (the entry test off the hoisted $a0,
 *      the back-edge test off a fresh `lui/lw`).  That is a guard + rotated do/while written in
 *      source: a plain `while` gives the entry `j <test>` shape (6 insns short), and the guard
 *      written around a plain `while` is JUMP-THREADED back into the loop test by gcc's jump.c
 *      (byte-identical to the bare `while`; a zero-insn `__asm__("" : : "i"(0))` at the loop head
 *      blocks the thread and lands 7 @37/36 -- the do/while needs no device at all).
 *  (2) BOTH register-block bases are DECL-INIT LOCALS, `_padIntRegs` FIRST.  The macros reach the
 *      globals directly, so cc1 emits `_padSioRegs`'s macro load ahead of `_padIntRegs`'s (4 diffs,
 *      count-exact) and the entry test pays a load-delay `nop`; two named locals in the oracle's
 *      materialization order fix both.  Falsified: `sio` alone as a decl-init (4), `sio` assigned
 *      after the I_STAT store (8 @30 -- the guard collapses again), non-volatile STAT read (8). */
extern int _padClrIntSio0(void)
{
    unsigned char *ir = _padIntRegs;
    unsigned char *sio = _padSioRegs;

    *(volatile unsigned int *)(ir + 0x00) = 0xffffff7f;
    if ((*(volatile unsigned short *)(sio + 0x04) & 0x80) != 0) {
        do {
            if (chkRC2wait() != 0)
                return 0;
        } while ((JOY_STAT & 0x80) != 0);
    }
    JOY_CTRL = JOY_CTRL | 0x10;
    return 1;
}

/* @0x801055C8 : _padWaitRXready -- spin until SIO0 RX has a byte (STAT bit 1). */
extern void _padWaitRXready(void)
{
    do {
    } while ((JOY_STAT & 2) == 0);
}
