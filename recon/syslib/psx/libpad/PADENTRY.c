/* syslib/psx/libpad/PADENTRY.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libpad.lib(PADENTRY.OBJ): the 8 public Pad* API entry points.  Each looks the per-port
 *   controller descriptor up through the global dispatch pointer _padFuncPort2Info(port) (set by the
 *   active pad mode -- direct, SIO, etc.), then reads/writes that descriptor or forwards to the
 *   PADMAIN / PADCMD engines.  PadStartCom/PadStopCom just kick the SIO main loop. */

/* ---- per-port controller descriptor (libpad internal; only the touched fields are named) ------ */
typedef struct _PadDev {
    unsigned short *mode_tbl;     /* +0x00 : mode-id table (PadInfoMode term 4) */
    unsigned char  *act_tbl;      /* +0x04 : actuator table, 5 bytes/entry (PadInfoAct) */
    char            _pad08[0x08]; /* +0x08 */
    struct _PadDev *self;         /* +0x10 : loopback ptr (connected test) */
    char            _pad14[0x1c]; /* +0x14 */
    char           *flag_ptr;     /* +0x30 : ptr to a live status-flag byte */
    unsigned int    status;       /* +0x34 : status word (hi 16 bits = error/connect) */
    unsigned char   connected;    /* +0x38 */
    char            _pad39[0x02]; /* +0x39 */
    char            _pad3b[0x0e]; /* +0x3b */
    unsigned char   state;        /* +0x49 : controller state code */
    char            _pad4a[0x02]; /* +0x4a */
    int             term100;      /* +0x4c : PadInfoMode term 100 */
    char            _pad50[0x93]; /* +0x50 */
    unsigned char   nmode;        /* +0xe3 : mode count */
    unsigned char   mode3;        /* +0xe4 : PadInfoMode term 3 */
    char            _pade5[0x01]; /* +0xe5 */
    unsigned short  modeword;     /* +0xe6 : PadInfoMode term 2 */
    unsigned char   mode1;        /* +0xe8 : PadInfoMode term 1 */
    unsigned char   nact;         /* +0xe9 : actuator count */
} _PadDev;                        /* the touched fields land at their @-offsets above */

/* ---- dispatch pointer + engine entry points (defined by PAD.OBJ / PADMAIN / PADCMD) ----------- */
extern _PadDev *(*_padFuncPort2Info)(int port);       /* @0x80137C8C dispatch slot */
void _padStartCom(void);                             /* PADMAIN @0x80104C1C */
void _padStopCom(void);                              /* PADMAIN @0x80104CE8 */
int  _padSetActAlign(_PadDev *info, char *data);     /* PADCMD  @0x80105BF4 */
int  _padSetMainMode(_PadDev *info, int offs, int lock); /* PADCMD @0x80105D40 */
void _padSetAct(_PadDev *info, unsigned char *data, int len); /* PADCMD @0x801055F0 */

/* @0x800EFE60 : PadStartCom
 * FLOOR (4 diffs): oracle epilogue is `lw ra; addiu sp,sp,24; jr ra; nop` (sp-restore NOT
 * in the jr delay slot); ours schedules the sp-restore INTO the delay slot (`lw ra; jr ra;
 * addiu sp,sp,24`) -- the common/expected gcc shape seen everywhere else in this tree
 * (e.g. PadInfoMode, AICop_CleanUp). Single-$ra-only-save trivial wrappers apparently get a
 * DIFFERENT epilogue scheduling shape than multi-register-restore frames on the real
 * toolchain; not reachable from this 1-statement source. Same shape hits PadStopCom below. */
void PadStartCom(void) { _padStartCom(); }

/* @0x800EFE80 : PadStopCom -- FLOOR, same single-$ra-save epilogue-scheduling shape as
 * PadStartCom above (4 diffs). */
void PadStopCom(void) { _padStopCom(); }

/* @0x800EFEA0 : PadGetState -- map the raw controller state to the public PadState* code.
 * FLOOR (16 diffs): same duplicate-vs-share tail-merge / branch-polarity class seen throughout
 * this wave (chkRC2wait, _padSetMainMode_snd) -- oracle emits `beq state,K,RETURN_SITE` (jump
 * TO each return literal's own `li v0,K;j common_tail` block) for both the s==2 and s==6 arms,
 * while ours emits `bne state,K,SKIP` (skip-around) for the s==2 arm. Tried+reverted: fully
 * flat guard-chain (if(s==2)return1;if(s==6)return4;) -- drops the oracle's `slti v0,s,4` (s<4)
 * test entirely, worse (17 diffs); explicit `return d->state;` duplicated into the s<4 arm --
 * also worse (26 diffs, breaks the delay-slot-shared slti). Kept the nested if/else-if shape
 * that reproduces the slti test faithfully. */
int PadGetState(int port)
{
    _PadDev *d = _padFuncPort2Info(port);
    if ((d->status & 0xffff0000) != 0 ||
        (d != d->self && d->connected != 0) ||
        *d->flag_ptr != 0) {
        int s = d->state;
        if (s == 3)
            return 1;
        if (s < 4) {
            if (s == 2)
                return 1;
        } else if (s == 6) {
            return 4;
        }
    }
    return d->state;
}

/* @0x800EFF60 : PadInfoMode -- query a controller mode property. */
int PadInfoMode(int port, int term, int offs)
{
    _PadDev *d = _padFuncPort2Info(port);
    unsigned int r;
    if (term == 3) {
        r = d->mode3;
    } else if (term < 4) {
        if (term == 1) {
            r = d->mode1;
        } else {
            r = 0;
            if (term == 2)
                r = d->modeword;
        }
    } else if (term == 4) {
        if (offs < 0)
            r = d->nmode;
        else if (offs < (int)d->nmode)
            r = d->mode_tbl[offs];
        else
            r = 0;
    } else {
        r = 0;
        if (term == 100)
            r = (unsigned int)d->term100;
    }
    return r;
}

/* @0x800F0058 : PadInfoAct -- query an actuator property (5-byte records). */
int PadInfoAct(int port, int actno, int term)
{
    _PadDev *d = _padFuncPort2Info(port);
    if (actno < 0)
        return d->nact;
    if (actno < (int)d->nact) {
        unsigned char *e = d->act_tbl + actno * 5;
        switch (term) {
        case 1: return e[0];
        case 2: return e[1];
        case 3: return e[2];
        case 4: return e[3];
        case 5: return e[4];
        }
    }
    return 0;
}

/* @0x800F012C : PadSetActAlign */
int PadSetActAlign(int port, char *data)
{
    _PadDev *d = _padFuncPort2Info(port);
    return _padSetActAlign(d, data);
}

/* @0x800F0164 : PadSetMainMode */
int PadSetMainMode(int port, int offs, int lock)
{
    _PadDev *d = _padFuncPort2Info(port);
    return _padSetMainMode(d, offs & 0xff, lock & 0xff);
}

/* @0x800F01AC : PadSetAct */
void PadSetAct(int port, unsigned char *data, int len)
{
    _PadDev *d = _padFuncPort2Info(port);
    _padSetAct(d, data, len);
}
