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

struct CdlLOC { unsigned char minute, second, sector, track; };  /* BCD MSF position */

/* ---- low-level driver (DRV.OBJ / BIOS) ------------------------------------------------------- */
extern "C" int  CD_init(void);                                          /* @0x80108140 */
extern "C" int  CD_initintr(void);                                      /* @0x801080F4 */
extern "C" int  CD_initvol(void);                                       /* @0x80108004 */
extern "C" void CD_flush(void);                                         /* @0x80107F30 */
extern "C" int  CD_sync(int mode, unsigned char *result);              /* @0x801075DC */
extern "C" int  CD_ready(int mode, unsigned char *result);             /* @0x8010785C */
extern "C" int  CD_cw(int com, unsigned char *param, unsigned char *result, int fast); /* @0x80107B24 */
extern "C" int  CD_getsector(void *madr, int size);                    /* @0x80108488 */
extern "C" int  CD_getsector2(void *madr, int size);                   /* @0x80108588 */
extern "C" int  CD_datasync(int mode);                                 /* @0x80108320 */
extern "C" int  DMACallback(int ch, int func);                         /* libetc @0x800F28AC */

/* ---- driver state globals (defined in DRV.OBJ data @0x8013BF48..) ---------------------------- */
extern "C" unsigned char CD_status;   /* @0x8013BF54 */
extern "C" unsigned char CD_mode;     /* @0x8013BF64 */
extern "C" CdlLOC        CD_pos;      /* @0x8013BF60 */
extern "C" int           CD_debug;    /* @0x8013BF50 */
extern "C" int           CD_cbsync;   /* @0x8013BF48 */
extern "C" int           CD_cbready;  /* @0x8013BF4C */

/* per-command parameter-count table (data-mat: bytes live in the EXE @0x80136A18) */
extern const int _cd_param_count[];   /* @0x80136A18 */

/* @0x800F7780 : CdStatus */
extern "C" int CdStatus(void) { return (unsigned)CD_status; }

/* @0x800F7790 : CdMode */
extern "C" int CdMode(void) { return (unsigned)CD_mode; }

/* @0x800F77A0 : CdLastPos */
extern "C" void *CdLastPos(void) { return &CD_pos; }

/* @0x800F77AC : CdReset -- bring the CD subsystem up (mode 0 = drive, 1 = +volume, 2 = intr only). */
extern "C" int CdReset(int mode)
{
    if (mode == 2) {
        CD_initintr();
        return 1;
    }
    if (CD_init())
        return 0;
    if (mode == 1 && CD_initvol())
        return 0;
    return 1;
}

/* @0x800F7818 : CdFlush */
extern "C" void CdFlush(void) { CD_flush(); }

/* @0x800F7838 : CdSetDebug -- set the debug level, return the previous one. */
extern "C" int CdSetDebug(int level)
{
    int prev = CD_debug;
    CD_debug = level;
    return prev;
}

/* @0x800F784C : CdSync */
extern "C" int CdSync(int mode, unsigned char *result) { return CD_sync(mode, result); }

/* @0x800F786C : CdReady */
extern "C" int CdReady(int mode, unsigned char *result) { return CD_ready(mode, result); }

/* @0x800F788C : CdSyncCallback -- install the sync-complete callback, return the previous one. */
extern "C" int CdSyncCallback(int func)
{
    int prev = CD_cbsync;
    CD_cbsync = func;
    return prev;
}

/* @0x800F78A0 : CdReadyCallback */
extern "C" int CdReadyCallback(int func)
{
    int prev = CD_cbready;
    CD_cbready = func;
    return prev;
}

/* inlined into CdControl/CdControlF/CdControlB: issue `com` (optionally a setloc sub-command first),
 * retrying up to 4 times; returns 0 on success, -1 on exhaustion. */
static inline int cd_cw(unsigned char com, unsigned char *param, unsigned char *result, int arg3)
{
    int old = CD_cbsync;
    int count = 4;

    while (count--) {
        CD_cbsync = 0;
        if (com != 1 && (CD_status & 0x10))
            CD_cw(1, 0, 0, 0);
        if (param == 0 || _cd_param_count[com] == 0 || !CD_cw(2, param, result, 0)) {
            CD_cbsync = old;
            if (!CD_cw(com, param, result, arg3))
                return 0;
        }
    }
    CD_cbsync = old;
    return -1;
}

/* @0x800F78B4 : CdControl -- issue a command (with result), retrying up to 4 times. */
extern "C" int CdControl(unsigned char com, unsigned char *param, unsigned char *result)
{
    return cd_cw(com, param, result, 0) == 0;
}

/* @0x800F79F0 : CdControlF -- fire-and-forget command (no result, fast). */
extern "C" int CdControlF(unsigned char com, unsigned char *param)
{
    return cd_cw(com, param, 0, 1) == 0;
}

/* @0x800F7B24 : CdControlB -- blocking command: issue then CD_sync(0) to completion. */
extern "C" int CdControlB(unsigned char com, unsigned char *param, unsigned char *result)
{
    if (cd_cw(com, param, result, 0))
        return 0;
    return CD_sync(0, result) == 2;
}

/* @0x800F7C70 : CdGetSector -- copy `size` words of the last-read sector to `madr` (1 = ok). */
extern "C" int CdGetSector(void *madr, int size) { return CD_getsector(madr, size) == 0; }

/* @0x800F7C90 : CdGetSector2 */
extern "C" int CdGetSector2(void *madr, int size) { return CD_getsector2(madr, size) == 0; }

/* @0x800F7CB0 : CdDataCallback -- install the CD DMA (channel 3) completion callback,
 *   returning the previous one (tail-call into DMACallback, whose $v0 = old handler). */
extern "C" int CdDataCallback(int func) { return DMACallback(3, func); }

/* @0x800F7CD4 : CdDataSync */
extern "C" int CdDataSync(int mode) { return CD_datasync(mode); }

/* @0x800F7CF4 : CdIntToPos -- sector number -> BCD minute:second:frame location. */
#define ENCODE_BCD(n) (((n) / 10 << 4) + (n) % 10)
extern "C" void *CdIntToPos(int i, CdlLOC *p)
{
    int t;
    i += 150;
    t = i / 75;
    p->sector = (unsigned char)ENCODE_BCD(i % 75);
    p->second = (unsigned char)ENCODE_BCD(t % 60);
    p->minute = (unsigned char)ENCODE_BCD(t / 60);
    return p;
}

/* @0x800F7DF8 : CdPosToInt -- BCD location -> sector number. */
#define DECODE_BCD(x) (((x) >> 4) * 10 + ((x) & 0xF))
extern "C" int CdPosToInt(CdlLOC *p)
{
    unsigned char sector = p->sector;
    unsigned char second = p->second;
    unsigned char minute = p->minute;

    return (DECODE_BCD(minute) * 60 + DECODE_BCD(second)) * 75
           + DECODE_BCD(sector) - 150;
}
