/* Memory-oriented libcd public/core layer for NFS4 mod builds.
 *
 * This deliberately preserves the ABI consumed by the unmodified EAC cdfs/nfile/stream stack.
 * It is not a byte-matching reconstruction: the goal is smaller resident code and data.  Link it
 * with the original low-level DRV object and with TYPE/toc, and omit the original SYS/event objects.
 */

typedef unsigned char u_char;

typedef struct CdlLOC {
    u_char minute, second, sector, track;
} CdlLOC;

typedef void (*CdlCB)(u_char intr, u_char *result);

/* Low-level driver entry points and state retained from DRV. */
extern int  CD_init(void);
extern int  CD_initintr(void);
extern int  CD_initvol(void);
extern void CD_flush(void);
extern int  CD_sync(int mode, u_char *result);
extern int  CD_ready(int mode, u_char *result);
extern int  CD_cw(int com, u_char *param, u_char *result, int fast);
extern int  CD_getsector(void *dst, int words);
extern int  CD_datasync(int mode);

extern u_char CD_status;
extern int CD_debug;
extern int CD_cbsync;
extern int CD_cbready;

extern void DeliverEvent(unsigned long event, unsigned long spec);

/* These words were owned by EVENT.OBJ in retail. */
extern int CD_cbread;
extern int CD_read_dma_mode;

/* Only CdlSetloc-sensitive command numbers need nonzero entries.  A byte table has identical
 * semantics to PsyQ's 32-word table and removes 96 resident bytes. */
static const u_char cd_needs_setloc[32] = {
    0,0,0,1,0,0,1,0, 0,0,0,0,0,0,0,0,
    0,0,0,0,0,1,1,0, 0,0,0,1,0,0,0,0
};

static void cd_event_sync(u_char intr, u_char *result)
{
    (void)intr; (void)result;
    DeliverEvent(0xF0000003UL, 0x20UL);
}

static void cd_event_ready(u_char intr, u_char *result)
{
    (void)intr; (void)result;
    DeliverEvent(0xF0000003UL, 0x40UL);
}

static void cd_event_read(u_char intr, u_char *result)
{
    (void)intr; (void)result;
    DeliverEvent(0xF0000003UL, 0x40UL);
}

int CdInit(void)
{
    int tries = 5;
    while (tries-- != 0) {
        if (CD_init() == 0 && CD_initvol() == 0) {
            CD_cbsync = (int)cd_event_sync;
            CD_cbready = (int)cd_event_ready;
            CD_cbread = (int)cd_event_read;
            CD_read_dma_mode = 0;
            return 1;
        }
    }
    return 0;
}

int CdReset(int mode)
{
    if (mode == 2) {
        CD_initintr();
        return 1;
    }
    if (CD_init() != 0)
        return 0;
    if (mode == 1 && CD_initvol() != 0)
        return 0;
    return 1;
}

void CdFlush(void) { CD_flush(); }

int CdSetDebug(int level)
{
    int old = CD_debug;
    CD_debug = level;
    return old;
}

int CdSync(int mode, u_char *result) { return CD_sync(mode, result); }
int CdReady(int mode, u_char *result) { return CD_ready(mode, result); }

CdlCB CdSyncCallback(CdlCB fn)
{
    CdlCB old = (CdlCB)CD_cbsync;
    CD_cbsync = (int)fn;
    return old;
}

CdlCB CdReadyCallback(CdlCB fn)
{
    CdlCB old = (CdlCB)CD_cbready;
    CD_cbready = (int)fn;
    return old;
}

/* Shared compact implementation for asynchronous and blocking commands. */
static int cd_control(int com, u_char *param, u_char *result, int wait, int fast)
{
    int saved_sync = CD_cbsync;
    unsigned int command = (unsigned int)com & 0xff;
    int tries;

    if (command >= 32)
        return 0;

    for (tries = 0; tries != 4; ++tries) {
        CD_cbsync = 0;
        if (command != 1 && (CD_status & 0x10) != 0)
            CD_cw(1, 0, 0, 0);
        if (param != 0 && cd_needs_setloc[command] != 0 &&
            CD_cw(2, param, result, 0) != 0)
            continue;

        CD_cbsync = saved_sync;
        if (CD_cw((int)command, param, result, fast) == 0) {
            if (wait != 0)
                return CD_sync(0, result) == 2;
            return 1;
        }
    }

    CD_cbsync = saved_sync;
    return 0;
}

int CdControl(int com, u_char *param, u_char *result)
{
    return cd_control(com, param, result, 0, 0);
}

int CdControlB(int com, u_char *param, u_char *result)
{
    return cd_control(com, param, result, 1, 0);
}

int CdControlF(int com, u_char *param)
{
    return cd_control(com, param, 0, 0, 1);
}

int CdGetSector(void *dst, int words) { return CD_getsector(dst, words) == 0; }
int CdDataSync(int mode) { return CD_datasync(mode); }

#define BCD_ENCODE(v) ((((v) / 10) << 4) + ((v) % 10))
#define BCD_DECODE(v) ((((v) >> 4) * 10) + ((v) & 15))

CdlLOC *CdIntToPos(int sector, CdlLOC *pos)
{
    int seconds, minutes;
    sector += 150;
    seconds = sector / 75;
    minutes = seconds / 60;
    pos->sector = (u_char)BCD_ENCODE(sector % 75);
    pos->second = (u_char)BCD_ENCODE(seconds - minutes * 60);
    pos->minute = (u_char)BCD_ENCODE(minutes);
    return pos;
}

int CdPosToInt(CdlLOC *pos)
{
    int minute = BCD_DECODE(pos->minute);
    int second = BCD_DECODE(pos->second);
    int sector = BCD_DECODE(pos->sector);
    return (minute * 60 + second) * 75 + sector - 150;
}
