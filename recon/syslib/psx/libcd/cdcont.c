/* syslib/psx/libcd/cdcont.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   libcd.lib public CD-ROM control / sync / position API.  PsyQ ships these as one-function objects
 *   (S_002..S_024 / SYS.OBJ); they are grouped here as the single logical "CD control" module since
 *   each is a thin wrapper over the low-level BIOS CD_* driver (DRV.OBJ) sharing the same globals.
 *   Functions: CdStatus CdMode CdLastPos CdReset CdFlush CdSetDebug CdSync CdReady CdSyncCallback
 *   CdReadyCallback CdControl CdControlF CdControlB CdGetSector CdGetSector2 CdDataCallback
 *   CdDataSync CdIntToPos CdPosToInt.
 *
 *   CD_cw(com, param, result, fast) returns 0 on success (non-zero = error); the CdControl* retry
 *   loops issue an optional set-param sub-command (com 2) then the real command, up to 4 attempts. */

struct CdlLOC { unsigned char minute, second, sector, track; };
typedef struct CdlLOC CdlLOC;  /* BCD MSF position */

/* ---- low-level driver (DRV.OBJ / BIOS) ------------------------------------------------------- */
extern int  CD_init_80108140(void);   /* @0x80108140 (VA-suffixed: CD_init/CD_Init case-collide) */
extern int  CD_initintr(void);                                      /* @0x801080F4 */
extern int  CD_initvol(void);                                       /* @0x80108004 */
extern void CD_flush(void);                                         /* @0x80107F30 */
extern int  CD_sync(int mode, unsigned char *result);              /* @0x801075DC */
extern int  CD_ready(int mode, unsigned char *result);             /* @0x8010785C */
extern int  CD_cw(int com, unsigned char *param, unsigned char *result, int fast); /* @0x80107B24 */
extern int  CD_getsector(void *madr, int size);                    /* @0x80108488 */
extern int  CD_getsector2(void *madr, int size);                   /* @0x80108588 */
extern int  CD_datasync(int mode);                                 /* @0x80108320 */
extern int  DMACallback(int ch, int func);                         /* libetc @0x800F28AC */

/* ---- driver state globals (defined in DRV.OBJ data @0x8013BF48..) ---------------------------- */
extern unsigned char CD_status;   /* @0x8013BF54 */
extern unsigned char CD_mode;     /* @0x8013BF64 */
extern CdlLOC        CD_pos;      /* @0x8013BF60 */
extern int           CD_debug;    /* @0x8013BF50 */
extern int           CD_cbsync;   /* @0x8013BF48 */
extern int           CD_cbready;  /* @0x8013BF4C */

/* per-command parameter-count table (data-mat: bytes live in the EXE @0x80136A18) */
extern const int _cd_param_count[];   /* @0x80136A18 */

/* @0x800F7780 : CdStatus */
extern int CdStatus(void) { return (unsigned)CD_status; }

/* @0x800F7790 : CdMode */
extern int CdMode(void) { return (unsigned)CD_mode; }

/* @0x800F77A0 : CdLastPos */
extern void *CdLastPos(void) { return &CD_pos; }

/* @0x800F77AC : CdReset -- bring the CD subsystem up (mode 0 = drive, 1 = +volume, 2 = intr only). */
extern int CdReset(int mode)
{
    if (mode == 2) {
        CD_initintr();
        return 1;
    }
    if (CD_init_80108140())
        return 0;
    if (mode == 1 && CD_initvol())
        return 0;
    return 1;
}

/* @0x800F7818 : CdFlush */
extern void CdFlush(void) { CD_flush(); }

/* @0x800F7838 : CdSetDebug -- set the debug level, return the previous one. */
extern int CdSetDebug(int level)
{
    int prev = CD_debug;
    CD_debug = level;
    return prev;
}

/* @0x800F784C : CdSync */
extern int CdSync(int mode, unsigned char *result) { return CD_sync(mode, result); }

/* @0x800F786C : CdReady */
extern int CdReady(int mode, unsigned char *result) { return CD_ready(mode, result); }

/* @0x800F788C : CdSyncCallback -- install the sync-complete callback, return the previous one. */
extern int CdSyncCallback(int func)
{
    int prev = CD_cbsync;
    CD_cbsync = func;
    return prev;
}

/* @0x800F78A0 : CdReadyCallback */
extern int CdReadyCallback(int func)
{
    int prev = CD_cbready;
    CD_cbready = func;
    return prev;
}

/* MATCH: the three CdControl* bodies are transplanted from the byte-exact Rage
 * Racer decomp (C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\
 * command_control.c) -- the SAME PsyQ libcd TU, matched in plain C.  Load-bearing
 * pieces of that shape:
 *   - they are THREE SEPARATE FUNCTIONS, not one shared `static inline` helper:
 *     CdControlF has no `resultReg` local at all (it passes a literal 0) and
 *     CdControlB carries two extra ones, so the three have DIFFERENT local sets
 *     and therefore different s-register handouts.  A shared inline forces one
 *     handout on all three and cannot match more than one of them.
 *   - the locals are assigned ONE PER STATEMENT in exactly this order; the
 *     oracle's prologue emits each callee-saved save paired with that local's
 *     first def, so the statement order IS the s-register handout
 *     (s1=arg s2=resultReg s4=cmd s0=retries s3=command s5=savedMode
 *      s6=commandState s7=status), and the loop sentinel comes LAST ($fp).
 *   - `retries = 3;` + `do { ... } while (--retries != sentinel);` -- the
 *     PRE-decrement do-while.  `for (i=3;i!=-1;i--)` and `while (count--)` both
 *     CSE the loop sentinel with the exhaustion `-1` and run 2 insns short.
 *   - the setloc-failure path is a `continue` (branch straight to the
 *     decrement), NOT a fall-through around an else.
 *   - `status` is a real variable set 0/-1 and the return is `status + 1`
 *     (oracle: `addu s7,zero,zero` / `li s7,-1` + `addiu v0,s7,1`).
 * Rage Racer additionally needs `register long cmd asm("$20")` pins and
 * zero-insn opacity fences; asm register pins are FORBIDDEN here
 * (methodology 3.13), so they are dropped and the residual is left honest. */

/* @0x800F78B4 : CdControl -- issue a command (with result), retrying up to 4 times. */
extern int CdControl(unsigned char com, unsigned char *param, unsigned char *result)
{
    unsigned char *arg;
    unsigned char *resultReg;
    int cmd;
    int retries;
    int command;
    const int *base;
    int savedMode;
    int offset;
    const int *commandState;
    int status;
    int sentinel;

    arg = param;
    resultReg = result;
    cmd = com;
    retries = 3;
    command = (unsigned char)cmd;
    base = _cd_param_count;
    savedMode = CD_cbsync;
    offset = command * 4;
    commandState = (const int *)(offset + (int)base);
    status = 0;
    sentinel = -1;

    do {
        CD_cbsync = 0;
        if (command != 1) {
            if (CD_status & 0x10)
                CD_cw(1, 0, 0, 0);
        }
        if (arg != 0 && *commandState != 0) {
            if (CD_cw(2, arg, resultReg, 0) != 0)
                continue;
        }
        CD_cbsync = savedMode;
        if (CD_cw((unsigned char)cmd, arg, resultReg, 0) == 0)
            goto done;
    } while (--retries != sentinel);

    CD_cbsync = savedMode;
    status = -1;
done:
    return status + 1;
}

/* @0x800F79F0 : CdControlF -- fire-and-forget command (no result, fast). */
extern int CdControlF(unsigned char com, unsigned char *param)
{
    unsigned char *arg;
    int cmd;
    int retries;
    int one;
    int command;
    int savedMode;
    const int *base;
    int offset;
    const int *commandState;
    int status;
    int sentinel;

    arg = param;
    cmd = com;
    retries = 3;
    /* MATCH: the `1` of the `command != 1` test is a NAMED loop invariant here
     * (CdControlF/CdControlB only) -- their oracles hoist it into a callee-saved
     * reg in the preheader (`li fp,1` ... `beq s3,fp`), while CdControl's oracle
     * rematerializes it in a caller-saved temp inside the loop (`li t0,1`), so
     * CdControl keeps the literal.  272-lane: F 15->4, B 15->4, both COUNT-EXACT. */
    one = 1;
    command = (unsigned char)cmd;
    base = _cd_param_count;
    savedMode = CD_cbsync;
    offset = command * 4;
    commandState = (const int *)(offset + (int)base);
    status = 0;
    sentinel = -1;

    do {
        CD_cbsync = 0;
        if (command != one) {
            if (CD_status & 0x10)
                CD_cw(1, 0, 0, 0);
        }
        if (arg != 0 && *commandState != 0) {
            if (CD_cw(2, arg, 0, 0) != 0)
                continue;
        }
        CD_cbsync = savedMode;
        if (CD_cw((unsigned char)cmd, arg, 0, 1) == 0)
            goto done;
    } while (--retries != sentinel);

    CD_cbsync = savedMode;
    status = -1;
done:
    return status + 1;
}

/* @0x800F7B24 : CdControlB -- blocking command: issue then CD_sync(0) to completion. */
extern int CdControlB(unsigned char com, unsigned char *param, unsigned char *result)
{
    unsigned char *arg;
    unsigned char *resultReg;
    int cmd;
    int retries;
    int one;
    int command;
    int savedMode;
    const int *base;
    int offset;
    const int *commandState;
    int status;
    int sentinel;
    int zero;

    arg = param;
    resultReg = result;
    cmd = com;
    retries = 3;
    /* MATCH: the `1` of the `command != 1` test is a NAMED loop invariant here
     * (CdControlF/CdControlB only) -- their oracles hoist it into a callee-saved
     * reg in the preheader (`li fp,1` ... `beq s3,fp`), while CdControl's oracle
     * rematerializes it in a caller-saved temp inside the loop (`li t0,1`), so
     * CdControl keeps the literal.  272-lane: F 15->4, B 15->4, both COUNT-EXACT. */
    one = 1;
    command = (unsigned char)cmd;
    base = _cd_param_count;
    savedMode = CD_cbsync;
    offset = command * 4;
    commandState = (const int *)(offset + (int)base);
    status = 0;
    sentinel = -1;

    do {
        CD_cbsync = 0;
        if (command != one) {
            if (CD_status & 0x10)
                CD_cw(1, 0, 0, 0);
        }
        if (arg != 0 && *commandState != 0) {
            if (CD_cw(2, arg, resultReg, 0) != 0)
                continue;
        }
        CD_cbsync = savedMode;
        if (CD_cw((unsigned char)cmd, arg, resultReg, 0) == 0) {
            status = 0;
            goto done;
        }
    } while (--retries != sentinel);

    CD_cbsync = savedMode;
    status = -1;
done:
    zero = 0;
    if (status == 0)
        status = CD_sync(zero, resultReg) == 2;
    else
        status = 0;
    return status;
}

/* @0x800F7C70 : CdGetSector -- copy `size` words of the last-read sector to `madr` (1 = ok). */
extern int CdGetSector(void *madr, int size) { return CD_getsector(madr, size) == 0; }

/* @0x800F7C90 : CdGetSector2 */
extern int CdGetSector2(void *madr, int size) { return CD_getsector2(madr, size) == 0; }

/* @0x800F7CB0 : CdDataCallback -- install the CD DMA (channel 3) completion callback,
 *   returning the previous one (tail-call into DMACallback, whose $v0 = old handler). */
extern int CdDataCallback(int func) { return DMACallback(3, func); }

/* @0x800F7CD4 : CdDataSync */
extern int CdDataSync(int mode) { return CD_datasync(mode); }

/* @0x800F7CF4 : CdIntToPos -- sector number -> BCD minute:second:frame location. */
#define ENCODE_BCD(n) (((n) / 10 << 4) + (n) % 10)
extern void *CdIntToPos(int i, CdlLOC *p)
{
    /* MATCH: the minute quotient must be its OWN named local, with `second`
     * DERIVED from it (`t - m*60`), not spelled `t % 60` beside `t / 60`.
     * The `%`/`/` pair makes gcc emit the (i%75)/10 magic-multiply FIRST and
     * the t/60 one late (ours 64 vs oracle 65 insns, every insn shifted:
     * 65 diffs); naming `m` forces the t/60 mult up to the oracle's position
     * right after the i/75 mult, and `t - m*60` reuses it.  PASS 65/65 under
     * BOTH the 2.8.0 and the gcc-2.7.2 lane.  (psyz's `i/75%60`+`i/75/60`
     * form -- no temp at all -- is WORSE: 87 diffs at 66 insns.) */
    int t, m;
    i += 150;
    t = i / 75;
    m = t / 60;
    p->sector = (unsigned char)ENCODE_BCD(i % 75);
    p->second = (unsigned char)ENCODE_BCD(t - m * 60);
    p->minute = (unsigned char)ENCODE_BCD(m);
    return p;
}

/* @0x800F7DF8 : CdPosToInt -- BCD location -> sector number. */
#define DECODE_BCD(x) (((x) >> 4) * 10 + ((x) & 0xF))
extern int CdPosToInt(CdlLOC *p)
{
    unsigned char sector = p->sector;
    unsigned char second = p->second;
    unsigned char minute = p->minute;

    return (DECODE_BCD(minute) * 60 + DECODE_BCD(second)) * 75
           + DECODE_BCD(sector) - 150;
}
