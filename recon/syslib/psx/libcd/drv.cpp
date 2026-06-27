/* syslib/psx/libcd/drv.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3), structurally
 *   re-derived from the canonical PsyQ libcd BIOS.OBJ source (cf. SOTN psxsdk libcd/bios.c).
 *   The low-level CD-ROM driver core that cdcont.cpp wraps: the command-write / event-poll state
 *   machine that talks to the CD-ROM controller (CDREG0-3, reached through CACHED register pointers
 *   in the driver globals @0x8013C20C..) and pulls sector data over DMA channel 3.
 *
 *   STRUCTURE NOTE: the original INLINES set_alarm / get_alarm / callback into each of CD_sync /
 *   CD_ready / CD_cw / CD_datasync (they are `static inline` helpers, NOT separate functions).
 *   getintr is a real out-of-line function (func_80107080).  An earlier reconstruction factored the
 *   inlined helpers out into _cd_arm_timeout/_cd_timed_out/_cd_drain which made the big CD_* bodies
 *   structurally far smaller than the oracle.
 *
 *   HW registers are reached through pointer globals the driver caches at init (D_8013C20C = &CDREG0,
 *   etc.) -- the original does `*(volatile u_char*)D_8013C20C`, NOT a literal MMIO store. */

typedef int (*CdlCB)(int intr, unsigned char *result);

/* ---- cached HW-register pointers (driver globals, defined in asm/data @0x8013C20C..) -----------
 *   The driver caches each CD/SPU/DMA register address in a word at init; every access dereferences
 *   the cached pointer (matches the oracle's `lui %hi(D_8013Cxx); lw; sb/lbu`). */
extern "C" {
extern volatile unsigned char *D_8013C20C;   /* &CDREG0  index/status        0x1F801800 */
extern volatile unsigned char *D_8013C210;   /* &CDREG1  command/response    0x1F801801 */
extern volatile unsigned char *D_8013C214;   /* &CDREG2  data/parameter      0x1F801802 */
extern volatile unsigned char *D_8013C218;   /* &CDREG3  interrupt en/ack    0x1F801803 */
extern volatile unsigned int  *D_8013C21C;   /* &COM_DELAY                   0x1F801020 */
extern volatile unsigned short*D_8013C220;   /* &SPU base                    0x1F801C00 */
extern volatile unsigned int  *D_8013C240;   /* &CDROM_DELAY                 0x1F801018 */
extern volatile unsigned int  *D_8013C244;   /* &DPCR  DMA control           0x1F8010F0 */
extern volatile unsigned int  *D_8013C248;   /* &D3_MADR  DMA3 addr          0x1F8010B0 */
extern volatile unsigned int  *D_8013C24C;   /* &D3_BCR   DMA3 block control 0x1F8010B4 */
extern volatile unsigned int  *D_8013C250;   /* &D3_CHCR  DMA3 channel ctrl  0x1F8010B8 */
}
#define CDREG0  (*D_8013C20C)
#define CDREG1  (*D_8013C210)
#define CDREG2  (*D_8013C214)
#define CDREG3  (*D_8013C218)

/* ---- externs (kernel / other libs) ----------------------------------------------------------- */
extern "C" int  VSync(int mode);
extern "C" int  CheckCallback(void);
extern "C" void ResetCallback(void);
extern "C" void InterruptCallback(int n, void (*cb)(void));
extern "C" int  puts(const char *s);
extern "C" int  printf(const char *fmt, ...);

extern "C" void CD_flush(void);
extern "C" int  CD_sync(int mode, unsigned char *result);

/* ---- shared CD state globals (defined in asm/data with REGULAR .data placement -> ABSOLUTE
 *   addressing; the oracle reaches them via `lui %hi; lw/sw %lo`, NOT gp-rel, so they must be
 *   plain externs here -- a TU-local `int X=0;` def would land them in .sdata = gp-rel = mismatch). */
extern "C" {
extern int           CD_cbsync;   /* @0x8013BF48 : sync-complete callback */
extern int           CD_cbready;  /* @0x8013BF4C : data-ready callback */
extern int           CD_debug;    /* @0x8013BF50 : debug verbosity */
extern unsigned char CD_status;   /* @0x8013BF54 : last controller status */
extern unsigned char CD_status1;  /* @0x8013BF58 */
extern unsigned char CD_pos[4];   /* @0x8013BF60 : last seek location (MSF) */
extern unsigned char CD_mode;     /* @0x8013BF64 */
extern unsigned char CD_com;      /* @0x8013BF65 : last command */
extern int           CD_nopen;    /* lid-open event counter */
}

/* The 3-byte interrupt-state struct {sync, ready, c} @0x8013C224. */
struct CD_intr { unsigned char sync, ready, c; };
extern "C" CD_intr D_8013C224;            /* = Intr (in asm/data .bss-ish region) */
#define Intr D_8013C224

/* Per-command 8-byte response buffers (this TU OWNS these in BSS @0x8014899C..). */
extern "C" unsigned char D_8014899C[8];   /* sync   result */
extern "C" unsigned char D_801489A4[8];   /* ready  result */
extern "C" unsigned char D_801489AC[8];   /* data-end (c) result */
unsigned char D_8014899C[8];
unsigned char D_801489A4[8];
unsigned char D_801489AC[8];

/* alarm/timeout state (this TU OWNS these in BSS @0x801489B4..). */
extern "C" int          D_801489B4;       /* deadline (VSync frame) */
extern "C" int          D_801489B8;       /* spin counter */
extern "C" const char  *D_801489BC;       /* current op name (debug) */
int          D_801489B4;
int          D_801489B8;
const char  *D_801489BC;

/* command-name + interrupt-name string tables (debug; in asm/data). */
extern "C" char *CD_comstr[];             /* @ : CdlXXX names, indexed by CD_com */
extern "C" char *CD_intstr[];             /* @ : NoIntr/DataReady/.. names, indexed by Intr.* */

/* per-command attribute tables (data-mat: bytes live in the EXE / cdtables.cpp). */
extern const int _cd_result_flag[];       /* @0x8013C08C : command produces a ready result? */
extern const int _cd_param_count[];       /* @0x8013C18C : #parameter bytes per command */
static const int _cd_int3_ack[32] = {     /* @0x8013C00C : INT3 means "ack, hold result"? (D_80032B68) */
    0,0,0,0,0,0,0,1, 1,1,1,0,0,0,0,0, 0,0,1,0,0,1,1,0, 0,0,1,0,0,0,0,0 };
static const int _cd_status_ok[32] = {    /* @0x8013C10C : interrupt carries a valid status byte? (D_80032C68) */
    1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1, 0,0,1,1,1,1,1,1, 1,1,1,1,1,1,1,1 };

/* ------------------------------------------------------------------------------------------------
 * getintr  (func_80107080) -- acquire one CD-ROM controller interrupt: read+stabilise the code,
 *   drain the response FIFO, acknowledge, update status, route the result into the sync/ready/done
 *   buffers, and return a dispatch code (1/2/4/6) or 0 if nothing pending.  Out-of-line function.
 * ---------------------------------------------------------------------------------------------- */
static inline void _memcpy8(unsigned char *dst, unsigned char *src)
{
    int i;
    if (dst == 0)
        return;
    for (i = 0; i < 8; i++)
        dst[i] = src[i];
}

extern "C" int _cd_get_intr(void)
{
    unsigned char result[8];
    unsigned char nReg;
    int i, j;
    int bHasError;

    CDREG0 = 1;
    nReg = CDREG3 & 7;
    if (nReg == 0)
        return 0;

    bHasError = 0;
    while (nReg != (CDREG3 & 7))
        nReg = CDREG3 & 7;

    for (i = 0; i < 8; i++) {
        if ((CDREG0 & 0x20) == 0)
            break;
        result[i] = CDREG1;
    }
    for (j = i; j < 8; j++)
        result[j] = 0;

    CDREG0 = 1;  CDREG3 = 7;  CDREG2 = 7;

    if (nReg != 3 || _cd_status_ok[CD_com]) {
        if (!(CD_status & 0x10) && (result[0] & 0x10))
            CD_nopen++;
        CD_status  = result[0];
        CD_status1 = result[1];
        bHasError  = CD_status & 0x1d;
    }
    if (nReg == 5) {
        puts("DiskError: ");
        if (CD_debug > 0)
            printf("com=%s,code=(%02x:%02x)\n", CD_comstr[CD_com], CD_status, CD_status1);
    }

    switch (nReg) {
    case 3:
        if (bHasError) {
            Intr.sync = 5;
            _memcpy8(D_8014899C, result);
            return 2;
        }
        if (_cd_int3_ack[CD_com]) {
            Intr.sync = 3;
            _memcpy8(D_8014899C, result);
            return 1;
        }
        Intr.sync = 2;
        _memcpy8(D_8014899C, result);
        return 2;
    case 2:
        Intr.sync = bHasError ? 5 : 2;
        _memcpy8(D_8014899C, result);
        return 2;
    case 1:
        if (bHasError && i == 1)
            bHasError = 0;
        Intr.ready = bHasError ? 5 : 1;
        _memcpy8(D_801489A4, result);
        CDREG0 = 0;  CDREG3 = 0;
        return 4;
    case 4:
        Intr.ready = Intr.c = 4;
        _memcpy8(D_801489AC, result);
        _memcpy8(D_801489A4, result);
        return 4;
    case 5:
        Intr.sync = Intr.ready = 5;
        _memcpy8(D_8014899C, result);
        _memcpy8(D_801489A4, result);
        return 6;
    default:
        puts("CDROM: unknown intr");
        printf("(%d)\n", nReg);
        return 0;
    }
}

/* ---- inlined helpers (set_alarm / get_alarm / callback) --------------------------------------- */

static inline void set_alarm(const char *name)
{
    D_801489B4 = VSync(-1) + 0x3c0;
    D_801489B8 = 0;
    D_801489BC = name;
}

static inline int get_alarm(void)
{
    if (D_801489B4 < VSync(-1) || D_801489B8++ > 0x3c0000) {
        puts("CD timeout: ");
        printf("%s:(%s) Sync=%s, Ready=%s\n", D_801489BC,
               CD_comstr[CD_com], CD_intstr[Intr.sync], CD_intstr[Intr.ready]);
        CD_flush();
        return -1;
    }
    return 0;
}

static inline void callback(void)
{
    int interrupt;
    unsigned char restore;

    restore = CDREG0 & 3;
    for (;;) {
        interrupt = _cd_get_intr();
        if (interrupt == 0)
            break;
        if ((interrupt & 4) && CD_cbready != 0)
            ((CdlCB)CD_cbready)(Intr.ready, D_801489A4);
        if ((interrupt & 2) && CD_cbsync != 0)
            ((CdlCB)CD_cbsync)(Intr.sync, D_8014899C);
    }
    CDREG0 = restore;
}

/* @0x80108680 : the registered CD interrupt handler (InterruptCallback(2, ...)). */
extern "C" void _cd_intr_dispatch(void) { callback(); }

/* @0x801075DC : CD_sync -- wait for the command to acknowledge (mode 0 = block, else poll once). */
extern "C" int CD_sync(int mode, unsigned char *result)
{
    int sync;
    set_alarm("CD_sync");
    for (;;) {
        if (get_alarm())
            return -1;
        if (CheckCallback())
            callback();
        sync = Intr.sync;
        if (sync == 2 || sync == 5) {
            Intr.sync = 2;
            _memcpy8(result, D_8014899C);
            return sync;
        }
        if (mode != 0)
            return 0;
    }
}

/* @0x8010785C : CD_ready -- wait for a data-ready / data-end interrupt. */
extern "C" int CD_ready(int mode, unsigned char *result)
{
    int c, ready;
    set_alarm("CD_ready");
    for (;;) {
        if (get_alarm())
            return -1;
        if (CheckCallback())
            callback();
        c = Intr.c;
        if (c != 0) {
            Intr.c = 0;
            _memcpy8(result, D_801489AC);
            return c;
        }
        ready = Intr.ready;
        if (ready != 0) {
            Intr.ready = 0;
            _memcpy8(result, D_801489A4);
            return ready;
        }
        if (mode != 0)
            return 0;
    }
}

/* @0x80107B24 : CD_cw -- write a command (with parameters) and await the ack. */
extern "C" int CD_cw(int com, unsigned char *param, unsigned char *result, int arg3)
{
    int i;

    if (CD_debug > 1)
        printf("%s...\n", CD_comstr[com]);
    if (_cd_param_count[com] != 0 && param == 0) {
        if (CD_debug > 0)
            printf("%s: no param\n", CD_comstr[com]);
        return -2;
    }
    CD_sync(0, 0);
    if (com == 2)
        for (i = 0; i < 4; i++)
            CD_pos[i] = param[i];
    if (com == 0xe)
        CD_mode = param[0];
    Intr.sync = 0;
    if (_cd_result_flag[com])
        Intr.ready = 0;
    CDREG0 = 0;
    for (i = 0; i < _cd_param_count[com]; i++)
        CDREG2 = param[i];
    CD_com = (unsigned char)com;
    CDREG1 = CD_com;
    if (arg3 != 0)
        return 0;

    set_alarm("CD_cw");
    while (Intr.sync == 0) {
        if (get_alarm())
            return -1;
        if (CheckCallback())
            callback();
    }
    _memcpy8(result, D_8014899C);
    return -(Intr.sync == 5);
}

/* @0x80107F30 : CD_flush -- abort and reset the controller interrupt state. */
extern "C" void CD_flush(void)
{
    CDREG0 = 1;
    while (CDREG3 & 7) {
        CDREG0 = 1;
        CDREG3 = 7;
        CDREG2 = 7;
    }
    Intr.c = 0;
    Intr.ready = Intr.c;
    Intr.sync = 2;
    CDREG0 = 0;
    CDREG3 = 0;
    *D_8013C21C = 0x1325;
}

/* @0x80108004 : CD_initvol -- enable CD audio and set the mixer volumes to maximum.
 *   MATCH (verify_asm PASS 60/60): the volume-guard is two SHORT-CIRCUIT branches in the
 *   oracle (`bnez 0x1b8; bnez 0x1ba`), so the `A==0 && B==0` test must be written as NESTED
 *   ifs (methodology lever #7 -- a single `&&` made gcc fold both compares into one
 *   `sltiu;beqz`, +1 insn).  The `vol[]` byte inits must be `vol[0]=vol[2]=0x80` order (NOT
 *   `vol[2]=vol[0]=`) so the rightmost assignment stores offset 2 before 0, matching the
 *   oracle's `sb v0,2(sp); sb v0,0(sp)` schedule. */
extern "C" int CD_initvol(void)
{
    unsigned char vol[4];
    if (D_8013C220[0x1b8 / 2] == 0) {
        if (D_8013C220[0x1ba / 2] == 0) {
            D_8013C220[0x180 / 2] = 0x3fff;
            D_8013C220[0x182 / 2] = 0x3fff;
        }
    }
    D_8013C220[0x1b0 / 2] = 0x3fff;
    D_8013C220[0x1b2 / 2] = 0x3fff;
    D_8013C220[0x1aa / 2] = 0xc001;
    vol[0] = vol[2] = 0x80;
    vol[1] = vol[3] = 0;
    CDREG0 = 2;
    CDREG2 = vol[0];
    CDREG3 = vol[1];
    CDREG0 = 3;
    CDREG1 = vol[2];
    CDREG2 = vol[3];
    CDREG3 = 0x20;
    return 0;
}

/* @0x801080F4 : CD_initintr -- (re)install the CD interrupt callbacks. */
extern "C" int CD_initintr(void)
{
    CD_cbready = 0;
    CD_cbsync  = 0;
    CD_status1 = 0;
    CD_status  = 0;
    ResetCallback();
    InterruptCallback(2, _cd_intr_dispatch);
    return 0;
}

/* @0x8013C228 : the CD_init bookkeeping struct (SOTN's CD_init_struct), only its address is used. */
extern "C" int D_8013C228;

/* @0x80108140 : CD_init -- bring the CD-ROM subsystem up (nop, reset, demute).
 * NOTE: splat disambiguated this lowercase `CD_init` from the high-level `CD_Init` by appending
 * the address -> the oracle file is asm/nonmatchings/main/CD_init_80108140.s. */
extern "C" int CD_init(void)
{
    puts("CD_init:");
    printf("addr=%08x\n", &D_8013C228);
    CD_com     = 0;
    CD_mode    = 0;
    CD_cbready = 0;
    CD_cbsync  = 0;
    CD_status1 = 0;
    CD_status  = 0;
    ResetCallback();
    InterruptCallback(2, _cd_intr_dispatch);

    CDREG0 = 1;
    while (CDREG3 & 7) {
        CDREG0 = 1;
        CDREG3 = 7;
        CDREG2 = 7;
    }
    Intr.c = 0;
    Intr.ready = Intr.c;
    Intr.sync = 2;
    CDREG0 = 0;
    CDREG3 = 0;
    *D_8013C21C = 0x1325;

    CD_cw(1, 0, 0, 0);                       /* CdlNop */
    if (CD_status & 0x10)
        CD_cw(1, 0, 0, 0);
    if (CD_cw(0xa, 0, 0, 0))                 /* CdlReset */
        return -1;
    if (CD_cw(0xc, 0, 0, 0))                 /* CdlDemute */
        return -1;
    if (CD_sync(0, 0) != 2)
        return -1;
    return 0;
}

/* @0x80108320 : CD_datasync -- wait for the CD DMA (channel 3) to finish (mode 0 = block). */
extern "C" int CD_datasync(int mode)
{
    int ret;
    set_alarm("CD_datasync");
    for (;;) {
        if (get_alarm()) {
            ret = -1;
            break;
        }
        if ((*D_8013C250 & 0x1000000) == 0) {
            ret = 0;
            break;
        }
        if (mode != 0) {
            ret = 1;
            break;
        }
    }
    return ret;
}

/* @0x80108488 : CD_getsector -- DMA `size` words of the current sector to `madr` (blocking). */
extern "C" int CD_getsector(void *madr, int size)
{
    CDREG0 = 0;
    CDREG3 = 0x80;
    *D_8013C240 = 0x20943;
    *D_8013C21C = 0x1323;
    *D_8013C244 |= 0x8000;
    *D_8013C248 = (unsigned)madr;
    *D_8013C24C = size | 0x10000;
    while ((CDREG0 & 0x40) == 0)
        ;
    *D_8013C250 = 0x11000000;
    while (*D_8013C250 & 0x1000000)
        ;
    *D_8013C21C = 0x1325;
    return 0;
}

/* @0x80108588 : CD_getsector2 -- async variant (kick the DMA, do not wait for completion). */
extern "C" int CD_getsector2(void *madr, int size)
{
    int tmp;
    CDREG0 = 0;
    CDREG3 = 0x80;
    *D_8013C240 = 0x21020843;
    *D_8013C21C = 0x1325;
    *D_8013C244 |= 0x8000;
    *D_8013C248 = (unsigned)madr;
    *D_8013C24C = size | 0x10000;
    while ((CDREG0 & 0x40) == 0)
        ;
    *D_8013C250 = 0x11400100;
    tmp = *D_8013C250;
    (void)tmp;
    return 0;
}

/* @0x80108674 : CD_set_test_parmnum -- patch the param-count of command 0x19 (test).
 * The original stored to &_cd_param_count[25] via a STANDALONE data symbol (splat named it
 * D_8013C1F0 @0x8013C1F0 = 0x8013C18C + 25*4) -> a direct absolute store `lui $at; sw a0,%lo($at)`. */
extern "C" int D_8013C1F0;
extern "C" void CD_set_test_parmnum(int n) { D_8013C1F0 = n; }
