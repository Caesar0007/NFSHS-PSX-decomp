/* syslib/psx/libcd/event.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(EVENT.OBJ): CdInit -- bring the whole CD subsystem up and install the default
 *   event-delivering callbacks.
 *
 *   CdInit retries the low-level bring-up (CD_init + CD_initvol) up to five times, then wires the
 *   three libcd callback slots to the stock handlers that simply DeliverEvent() the CdRom hardware
 *   event class (0xF0000003) so that EnterCriticalSection / TestEvent based waits get notified:
 *       _cd_event_sync  -> EvSpCOMP (0x20)   (CD_cbsync)
 *       _cd_event_ready -> EvSpDR   (0x40)   (CD_cbready)
 *       _cd_event_read  -> EvSpDR   (0x40)   (CD_cbread)
 *   and clears CD_read_dma_mode.  This object owns the CD_cbread / CD_read_dma_mode globals that
 *   CDREAD.OBJ (cdread.cpp) references extern. */

/* ---- low-level driver (DRV.OBJ) --------------------------------------------------------------- */
extern "C" int CD_init(void);      /* @0x80108140 */
extern "C" int CD_initvol(void);   /* @0x80108004 */

/* ---- libc / libapi ---------------------------------------------------------------------------- */
extern "C" int  printf(const char *fmt, ...);                       /* libc C63 @0x801028AC */
extern "C" void DeliverEvent(unsigned long ev, unsigned long spec); /* libapi A07 (BIOS B0:0x07) @0x8010C6F8 */

/* ---- callback slots installed by CdInit (CD_cbsync/CD_cbready owned by DRV.OBJ) ---------------- */
extern "C" int CD_cbsync;    /* @0x8013BF48 */
extern "C" int CD_cbready;   /* @0x8013BF4C */

/* ---- globals owned by this object ------------------------------------------------------------- */
extern "C" {
int CD_cbread = 0;        /* @0x8013C2D0 : user CdReadCallback (default = _cd_event_read) */
int CD_read_dma_mode = 0; /* @0x8013C2D4 : bit0 = copy read sectors via DMA */
}

/* @0x80109158 : default sync callback -- deliver the "command complete" CdRom event. */
extern "C" void _cd_event_sync(int /*intr*/, int /*result*/)  { DeliverEvent(0xF0000003, 0x20); }  /* MATCH: void - oracle has no addu v0,zero,zero */

/* @0x80109180 : default ready callback -- deliver the "data ready" CdRom event. */
extern "C" void _cd_event_ready(int /*intr*/, int /*result*/) { DeliverEvent(0xF0000003, 0x40); }  /* MATCH: void */

/* @0x801091A8 : default read callback -- deliver the "data ready" CdRom event. */
extern "C" void _cd_event_read(int /*intr*/, int /*result*/)  { DeliverEvent(0xF0000003, 0x40); }  /* MATCH: void */

/* @0x8010911C : one bring-up attempt -- CD_init then CD_initvol; returns 1 on success. */
extern "C" int _cd_event_init(void)
{
    if (CD_init() != 0)
        return 0;                 /* controller init failed */
    return (unsigned)CD_initvol() < 1u;  /* MATCH: sltiu (unsigned < 1) not slti */
}

/* @0x8010908C : CdInit -- retry bring-up (<=5x), install default callbacks, return 1 on success. */
extern "C" int CdInit(void)
{
    int retry = 4;
    do {
        if (_cd_event_init() == 1) {
            CD_cbsync        = (int)_cd_event_sync;
            CD_cbready       = (int)_cd_event_ready;
            CD_cbread        = (int)_cd_event_read;
            CD_read_dma_mode = 0;
            return 1;
        }
        retry--;
    } while (retry != -1);

    printf("CdInit: Init failed\n");
    return 0;
}
