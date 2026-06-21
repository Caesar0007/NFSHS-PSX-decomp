/* syslib/psx/libcd/drv.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   libcd.lib(BIOS.OBJ): the low-level CD-ROM driver core that cdcont.cpp wraps -- the command-write
 *   / event-poll state machine that talks to the CD-ROM controller (CDREG0-3) and pulls sector data
 *   over DMA channel 3.  12 functions: CD_sync CD_ready CD_cw CD_flush CD_initvol CD_initintr CD_init
 *   CD_datasync CD_getsector CD_getsector2 CD_set_test_parmnum _cd_intr_dispatch.
 *
 *   CD_getsector / CD_getsector2 are DMA reads (Ghidra produced infinite-loop garbage for them; the
 *   bodies below come straight from disasm).  HW registers are literal MMIO; the original cached the
 *   CD/DMA register pointers in driver globals (@0x8013C20C..) -- behaviourally identical.  This obj
 *   also defines the shared CD state globals that cdcont.cpp declares extern. */

typedef int (*CdCB)(int intr, unsigned char *result);

struct CdlLOC { unsigned char minute, second, sector, track; };

/* ---- HW registers (literal MMIO) ------------------------------------------------------------- */
#define CDREG0      (*(volatile unsigned char *)0x1F801800)   /* index/status        */
#define CDREG1      (*(volatile unsigned char *)0x1F801801)   /* command / response  */
#define CDREG2      (*(volatile unsigned char *)0x1F801802)   /* data / parameter    */
#define CDREG3      (*(volatile unsigned char *)0x1F801803)   /* interrupt enable/ack*/
#define CDROM_DELAY (*(volatile unsigned int  *)0x1F801018)   /* CD-ROM bus delay    */
#define COM_DELAY   (*(volatile unsigned int  *)0x1F801020)   /* common bus delay    */
#define D3_MADR     (*(volatile unsigned int  *)0x1F8010B0)   /* DMA3 (CD) addr      */
#define D3_BCR      (*(volatile unsigned int  *)0x1F8010B4)   /* DMA3 block control  */
#define D3_CHCR     (*(volatile unsigned int  *)0x1F8010B8)   /* DMA3 channel control*/
#define DPCR        (*(volatile unsigned int  *)0x1F8010F0)   /* DMA control         */
/* SPU CD-audio volume (CD_initvol) */
#define SPU_MAIN_VOL_L  (*(volatile unsigned short *)0x1F801D80)
#define SPU_MAIN_VOL_R  (*(volatile unsigned short *)0x1F801D82)
#define CD_VOL_L        (*(volatile unsigned short *)0x1F801DB0)
#define CD_VOL_R        (*(volatile unsigned short *)0x1F801DB2)
#define CURR_MAIN_VOL_L (*(volatile unsigned short *)0x1F801DBC)
#define CURR_MAIN_VOL_R (*(volatile unsigned short *)0x1F801DBE)
#define SPUCNT          (*(volatile unsigned short *)0x1F801DAA)

/* ---- externs (kernel / other libs) ----------------------------------------------------------- */
extern "C" int  VSync(int mode);            /* VSYNC */
extern "C" void CheckCallback(void);        /* INTR  */
extern "C" void ResetCallback(void);        /* INTR  */
extern "C" void InterruptCallback(void);    /* INTR  */
extern "C" int  DMACallback(int ch, int func);  /* INTR */
extern "C" int  puts(const char *s);        /* libc A63 */
extern "C" int  printf(const char *fmt, ...); /* libc C63 */
extern "C" int  _cd_get_intr(void);         /* P06 @0x80107080 (defined below; returns dispatch code) */

/* forward declarations (the poll loops flush, CD_cw syncs first) */
extern "C" void CD_flush(void);
extern "C" int  CD_sync(int mode, unsigned char *result);

/* ---- shared CD state globals (also declared extern by cdcont.cpp) ----------------------------- */
extern "C" {
int           CD_cbsync  = 0;   /* @0x8013BF48 : sync-complete callback */
int           CD_cbready = 0;   /* @0x8013BF4C : data-ready callback */
int           CD_debug   = 0;   /* @0x8013BF50 : debug verbosity */
unsigned char CD_status  = 0;   /* @0x8013BF54 : last controller status (a.k.a. _CD_status) */
unsigned char CD_status1 = 0;   /* @0x8013BF58 */
CdlLOC        CD_pos      = { 0, 0, 0, 0 };  /* @0x8013BF60 : last seek location */
unsigned char CD_mode    = 0;   /* @0x8013BF64 */
unsigned char CD_com     = 0;   /* @0x8013BF65 : last command */
int           CD_nopen   = 0;   /* lid-open event counter (bumped when status bit 0x10 newly set) */
}

/* ---- driver-internal state ------------------------------------------------------------------- */
static int            _cd_to_deadline;   /* @0x801489B4 : VSync timeout deadline */
static int            _cd_to_count;      /* @0x801489B8 : busy-loop counter */
static const char    *_cd_opname;        /* @0x801489BC : current op name (debug) */
static unsigned char  _cd_sync_buf[8];   /* @0x8014899C : sync (CdlComplete) result */
static unsigned char  _cd_ready_buf[8];  /* @0x801489A4 : ready (data) result */
static unsigned char  _cd_done_buf[8];   /* @0x801489AC : acknowledge result */
static unsigned char  _cd_sync_res;      /* @0x8013C224 : sync interrupt code (2 = complete, 5 = error) */
static unsigned char  _cd_ready_res;     /* @0x8013C225 : ready interrupt code */
static unsigned char  _cd_done_res;      /* @0x8013C226 : acknowledge interrupt code */
static int            _cd_test_parmnum;  /* @0x8013C1F0 : CD_set_test_parmnum value */

/* per-command attribute tables (data-mat: bytes live in the EXE) */
extern const int _cd_param_count[];      /* @0x8013C18C : #parameter bytes per command */
extern const int _cd_result_flag[];      /* @0x8013C08C : command produces a ready-result? */

/* per-command attribute tables used by _cd_get_intr (materialised byte-exact from nfs4-f.exe;
 * indexed by CD_com 0..31).  Standard PsyQ libcd tables. */
static const int _cd_cmd_int3result[32] = {  /* @0x8013C00C : INT3 means "result complete"? */
    0,0,0,0,0,0,0,1, 1,1,1,0,0,0,0,0, 0,0,1,0,0,1,1,0, 0,0,1,0,0,0,0,0 };
static const int _cd_cmd_ackstatus[32]  = {  /* @0x8013C10C : acknowledge carries a status byte? */
    1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1, 0,0,1,1,1,1,1,1, 1,1,1,1,1,1,1,1 };
static const char *const _cd_cmd_names[32] = {  /* @0x8013BF6C : CdlXXX command names (debug only) */
    "CdlSync","CdlNop","CdlSetloc","CdlPlay","CdlForward","CdlBackward","CdlReadN","CdlStandby",
    "CdlStop","CdlPause","CdlReset","CdlMute","CdlDemute","CdlSetfilter","CdlSetmode","?",
    "CdlGetlocL","CdlGetlocP","?","CdlGetTN","CdlGetTD","CdlSeekL","CdlSeekP","?",
    "?","?","?","CdlReadS","?","?","?","?" };

/* _cd_get_intr @0x80107080 : acquire one CD-ROM controller interrupt.  Reads + stabilises the
 *   interrupt code, drains the response FIFO into a local buffer, acknowledges, updates the driver
 *   status, then routes the result into the sync/ready/done buffers per interrupt code.  Returns a
 *   dispatch code (1,2,4,6) or 0 if nothing pending.  Faithful transcription of the MIPS (disasm-v3
 *   @0x80107080; switch targets via jump table @0x800577E8: int1->ready, int2/int3->sync, int4->
 *   done+ready, int5->error).  Called by CD_sync/CD_ready/CD_cw and the _cd_intr_dispatch loop. */
extern "C" int _cd_get_intr(void)
{
    unsigned char result[8];
    unsigned char intr;
    int           n, i;
    int           errbits = 0;          /* CD_status & 0x1D; stays 0 if the status update is skipped */

    CDREG0 = 1;                          /* select index 1 (interrupt registers) */
    intr = CDREG3 & 7;
    if (intr == 0)
        return 0;
    do { intr = CDREG3 & 7; } while ((CDREG3 & 7) != intr);   /* stabilise the code */

    /* drain the response FIFO (<=8 bytes) then zero-pad */
    n = 0;
    while (CDREG0 & 0x20) {
        result[n++] = CDREG1;
        if (n >= 8) break;
    }
    for (i = n; i < 8; i++)
        result[i] = 0;

    CDREG0 = 1;  CDREG3 = 7;  CDREG2 = 7;          /* acknowledge */

    /* status update -- skipped only for a pure acknowledge that carries no status byte */
    if (!(intr == 3 && _cd_cmd_ackstatus[CD_com] == 0)) {
        if (!(CD_status & 0x10) && (result[0] & 0x10))
            CD_nopen++;                            /* lid just opened */
        CD_status  = result[0];
        errbits    = CD_status & 0x1D;
        CD_status1 = result[1];
    }

    if (intr == 5 && CD_debug > 0) {               /* DiskError diagnostic (debug-only path) */
        printf("CD error\n");
        if (CD_debug > 0)
            printf("  %s status=%02x,%02x\n", _cd_cmd_names[CD_com], CD_status, CD_status1);
    }

    switch (intr) {
    case 1:                                        /* INT1 : data-ready -> ready buffer */
        if (errbits != 0 && n == 1) errbits = 0;   /* single-byte INT1 response is not an error */
        _cd_ready_res = (errbits == 0) ? 1 : 5;
        for (i = 0; i < 8; i++) _cd_ready_buf[i] = result[i];
        CDREG0 = 0;  CDREG3 = 0;                    /* extra ack for the data path */
        return 4;
    case 2:                                        /* INT2 : complete -> sync buffer */
        _cd_sync_res = (errbits == 0) ? 2 : 5;
        for (i = 0; i < 8; i++) _cd_sync_buf[i] = result[i];
        return 2;
    case 3:                                        /* INT3 : acknowledge -> sync buffer */
        if (errbits != 0) {
            _cd_sync_res = 5;
        } else if (_cd_cmd_int3result[CD_com] != 0) {
            _cd_sync_res = 3;
            for (i = 0; i < 8; i++) _cd_sync_buf[i] = result[i];
            return 1;
        } else {
            _cd_sync_res = 2;
        }
        for (i = 0; i < 8; i++) _cd_sync_buf[i] = result[i];
        return 2;
    case 4:                                        /* INT4 : data-end -> done + ready buffers */
        _cd_done_res  = 4;
        _cd_ready_res = 4;
        for (i = 0; i < 8; i++) _cd_done_buf[i]  = result[i];
        for (i = 0; i < 8; i++) _cd_ready_buf[i] = result[i];
        return 4;
    case 5:                                        /* INT5 : disk-error -> sync + ready buffers */
        _cd_ready_res = 5;
        _cd_sync_res  = 5;
        for (i = 0; i < 8; i++) _cd_sync_buf[i]  = result[i];
        for (i = 0; i < 8; i++) _cd_ready_buf[i] = result[i];
        return 6;
    default:
        if (CD_debug > 0) printf("unknown CD intr %d (%s)\n", intr, _cd_cmd_names[CD_com]);
        return 0;
    }
}

/* ---- interrupt drain (shared by CD_sync/CD_ready/CD_cw and exported as _cd_intr_dispatch) ----- */
static void _cd_drain(void)
{
    /* @0x80107744-77C8 (inlined drain loop, identical at CD_sync/CD_ready/CD_cw/_cd_intr_dispatch):
     * the loop is driven off the RETURN of _cd_get_intr() ($s0), NOT a CDREG0 read; it loops until
     * _cd_get_intr() returns 0, and the &4/&2 tests + callback return values are on that ret (cb
     * returns discarded). The reconstruction looped on `pending = CDREG0` and captured cbsync's
     * return -- wrong loop variable + extra CDREG0 read (H47). */
    unsigned char restore = CDREG0 & 3;
    for (;;) {
        int r = _cd_get_intr();
        if (r == 0)
            break;
        if ((r & 4) != 0 && CD_cbready != 0)
            ((CdCB)CD_cbready)(_cd_ready_res, _cd_ready_buf);
        if ((r & 2) != 0 && CD_cbsync != 0)
            ((CdCB)CD_cbsync)(_cd_sync_res, _cd_sync_buf);
    }
    CDREG0 = restore;
}

/* deadline check shared by the poll loops; returns -1 on timeout (after flushing), else 0. */
static int _cd_timed_out(void)
{
    int now = VSync(-1);
    if (_cd_to_deadline < now || _cd_to_count++ > 0x3c0000) {
        puts("CD timeout: ");
        printf("%s:(%s) Sync=%s, Ready=%s\n", _cd_opname, "", "", "");
        CD_flush();
        return -1;
    }
    return 0;
}

static void _cd_arm_timeout(const char *name)
{
    _cd_to_deadline = VSync(-1) + 0x3c0;
    _cd_to_count    = 0;
    _cd_opname      = name;
}

/* @0x80108680 : _cd_intr_dispatch */
extern "C" void _cd_intr_dispatch(void) { _cd_drain(); }

/* @0x801075DC : CD_sync -- wait for the command to acknowledge (mode 0 = block, else poll once). */
extern "C" int CD_sync(int mode, unsigned char *result)
{
    unsigned res;
    _cd_arm_timeout("CD_sync");
    for (;;) {
        if (_cd_timed_out())
            return -1;
        CheckCallback();
        _cd_drain();
        res = _cd_sync_res;
        if (res == 2 || res == 5)
            break;
        if (mode != 0)
            return 0;
    }
    _cd_sync_res = 2;
    if (result != 0) {
        int i;
        for (i = 0; i < 8; i++)
            result[i] = _cd_sync_buf[i];
    }
    return res;
}

/* @0x8010785C : CD_ready -- wait for a data-ready / acknowledge interrupt. */
extern "C" int CD_ready(int mode, unsigned char *result)
{
    unsigned res;
    _cd_arm_timeout("CD_ready");
    for (;;) {
        if (_cd_timed_out())
            return -1;
        CheckCallback();
        _cd_drain();
        if (_cd_done_res != 0) {
            res = _cd_done_res;
            _cd_done_res = 0;
            if (result != 0) {
                int i;
                for (i = 0; i < 8; i++)
                    result[i] = _cd_done_buf[i];
            }
            return res;
        }
        res = _cd_ready_res;
        if (res != 0) {
            _cd_ready_res = 0;
            if (result != 0) {
                int i;
                for (i = 0; i < 8; i++)
                    result[i] = _cd_ready_buf[i];
            }
            return res;
        }
        if (mode != 0)
            return 0;
    }
}

/* @0x80107B24 : CD_cw -- write a command (with parameters) to the controller and await the ack. */
extern "C" int CD_cw(int com, unsigned char *param, unsigned char *result, int fast)
{
    int comb = com & 0xff;
    int n, i;
    (void)fast;

    if (CD_debug > 1)
        printf("%s...\n", "");

    if (_cd_param_count[comb] != 0 && param == 0) {
        if (CD_debug > 0)
            printf("%s: no param\n", "");
        return -2;
    }

    CD_sync(0, 0);

    if (comb == 2)                       /* CdlSetloc: latch the seek position */
        for (i = 0; i < 4; i++)
            ((unsigned char *)&CD_pos)[i] = param[i];
    if (comb == 0xe)                     /* CdlSetmode */
        CD_mode = param[0];

    _cd_sync_res = 0;
    if (_cd_result_flag[comb] != 0)
        _cd_ready_res = 0;

    CDREG0 = 0;
    n = _cd_param_count[comb];
    for (i = 0; i < n; i++)
        CDREG2 = param[i];

    CD_com = (unsigned char)comb;
    CDREG1 = CD_com;

    if (result != 0)
        return 0;

    _cd_arm_timeout("CD_cw");
    while (_cd_sync_res == 0) {
        if (_cd_timed_out())
            return -1;
        CheckCallback();
        _cd_drain();
    }
    if (param != 0)
        for (i = 0; i < 8; i++)
            param[i] = _cd_sync_buf[i];
    return _cd_sync_res == 5 ? -1 : 0;
}

/* @0x80107F30 : CD_flush -- abort and reset the controller interrupt state. */
extern "C" void CD_flush(void)
{
    while ((CDREG3 & 7) != 0)
        ;
    _cd_done_res  = 0;
    _cd_ready_res = 0;
    _cd_sync_res  = 2;
    CDREG0 = 0;
    CDREG3 = 0;
    COM_DELAY = 0x1325;
}

/* @0x80108004 : CD_initvol -- enable CD audio and set the mixer volumes to maximum. */
extern "C" int CD_initvol(void)
{
    if (CURR_MAIN_VOL_L == 0 && CURR_MAIN_VOL_R == 0) {
        SPU_MAIN_VOL_L = 0x3fff;
        SPU_MAIN_VOL_R = 0x3fff;
    }
    CD_VOL_L = 0x3fff;
    CD_VOL_R = 0x3fff;
    SPUCNT = 0xc001;
    CDREG0 = 2;
    CDREG2 = 0x80;
    CDREG3 = 0;
    CDREG0 = 3;
    CDREG1 = 0x80;
    CDREG2 = 0;
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
    InterruptCallback();
    return 0;
}

/* @0x80108140 : CD_init -- bring the CD-ROM subsystem up (nop, mode, demute). */
extern "C" int CD_init(void)
{
    int r;
    puts("CD_init:");
    printf("addr=%08x\n", 0);
    CD_com     = 0;
    CD_mode    = 0;
    CD_cbready = 0;
    CD_cbsync  = 0;
    CD_status1 = 0;
    CD_status  = 0;
    ResetCallback();
    InterruptCallback();

    while ((CDREG3 & 7) != 0)
        ;
    _cd_done_res  = 0;
    _cd_ready_res = 0;
    _cd_sync_res  = 2;
    CDREG0 = 0;
    CDREG3 = 0;
    COM_DELAY = 0x1325;

    CD_cw(1, 0, 0, 0);                       /* CdlNop */
    if ((CD_status & 0x10) != 0)
        CD_cw(1, 0, 0, 0);
    r = -1;
    if (CD_cw(0xa, 0, 0, 0) == 0) {          /* CdlInit */
        if (CD_cw(0xc, 0, 0, 0) == 0) {      /* CdlDemute */
            if (CD_sync(0, 0) == 2)
                r = 0;
        }
    }
    return r;
}

/* @0x80108320 : CD_datasync -- wait for the CD DMA (channel 3) to finish (mode 0 = block). */
extern "C" int CD_datasync(int mode)
{
    int r;
    _cd_arm_timeout("CD_datasync");
    do {
        if (_cd_timed_out())
            return -1;
        if ((D3_CHCR & 0x1000000) == 0) {   /* DMA finished */
            r = 0;
            break;
        }
        r = 1;                              /* still busy */
    } while (mode == 0);
    return r;
}

/* @0x80108488 : CD_getsector -- DMA `size` words of the current sector to `madr` (blocking). */
extern "C" int CD_getsector(void *madr, int size)
{
    CDREG0 = 0;
    CDREG3 = 0x80;                       /* want-data */
    CDROM_DELAY = 0x20943;
    COM_DELAY = 0x1323;
    DPCR |= 0x8000;                      /* enable DMA3 */
    D3_MADR = (unsigned)madr;
    D3_BCR = size | 0x10000;
    while ((CDREG0 & 0x40) == 0)         /* wait data-ready */
        ;
    D3_CHCR = 0x11000000;                /* start DMA read */
    if ((D3_CHCR & 0x1000000) != 0)
        while ((D3_CHCR & 0x1000000) != 0)
            ;
    COM_DELAY = 0x1325;
    return 0;
}

/* @0x80108588 : CD_getsector2 -- async variant (kick the DMA, do not wait for completion). */
extern "C" int CD_getsector2(void *madr, int size)
{
    CDREG0 = 0;
    CDREG3 = 0x80;
    CDROM_DELAY = 0x21020843;
    COM_DELAY = 0x1325;
    DPCR |= 0x8000;
    D3_MADR = (unsigned)madr;
    D3_BCR = size | 0x10000;
    while ((CDREG0 & 0x40) == 0)
        ;
    D3_CHCR = 0x11400100;               /* start DMA read (chained-ish), no wait */
    (void)D3_CHCR;
    return 0;
}

/* @0x80108674 : CD_set_test_parmnum */
extern "C" void CD_set_test_parmnum(int n) { _cd_test_parmnum = n; }
