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
extern int CD_init(void);      /* @0x80108140 */
extern int CD_initvol(void);   /* @0x80108004 */

/* ---- libc / libapi ---------------------------------------------------------------------------- */
extern int  printf(const char *fmt, ...);                       /* libc C63 @0x801028AC */
extern void DeliverEvent(unsigned long ev, unsigned long spec); /* libapi A07 (BIOS B0:0x07) @0x8010C6F8 */

/* ---- callback slots installed by CdInit (CD_cbsync/CD_cbready owned by DRV.OBJ) ---------------- */
extern int CD_cbsync;    /* @0x8013BF48 */
extern int CD_cbready;   /* @0x8013BF4C */

/* ---- globals owned by this object ------------------------------------------------------------- */

/* MATCH (catalog I-addendum, section lever): retail addresses BOTH of this TU's owned
 * 4-byte globals ABSOLUTELY (`lui $at,%hi; sw ...%lo($at)`), so they were NOT in .sdata.
 * An initialised `= 0` definition lands them in .sdata under -G4 and maspsx emits the
 * 1-insn gp-relative store instead.  section(".bss") forces them out (each is written
 * exactly ONCE in CdInit -> the single-access precondition holds).  CdInit 42 -> 36. */
int CD_cbread __attribute__((section(".bss")));        /* @0x8013C2D0 : user CdReadCallback */
int CD_read_dma_mode __attribute__((section(".bss"))); /* @0x8013C2D4 : bit0 = DMA copy */


/* @0x80109158 : default sync callback -- deliver the "command complete" CdRom event. */
extern void _cd_event_sync(int intr, int result)  { DeliverEvent(0xF0000003, 0x20); }  /* MATCH: void - oracle has no addu v0,zero,zero */

/* @0x80109180 : default ready callback -- deliver the "data ready" CdRom event. */
extern void _cd_event_ready(int intr, int result) { DeliverEvent(0xF0000003, 0x40); }  /* MATCH: void */

/* @0x801091A8 : default read callback -- deliver the "data ready" CdRom event. */
extern void _cd_event_read(int intr, int result)  { DeliverEvent(0xF0000003, 0x40); }  /* MATCH: void */

/* @0x8010911C : one bring-up attempt -- CD_init then CD_initvol; returns 1 on success. */
extern int _cd_event_init(void)
{
    if (CD_init() != 0)
        return 0;                 /* controller init failed */
    return (unsigned)CD_initvol() < 1u;  /* MATCH: sltiu (unsigned < 1) not slti */
}

/* @0x8010908C : CdInit -- retry bring-up (<=5x), install default callbacks, return 1 on success. */
extern int CdInit(void)
{
    /* MATCH (label-goto loop): retail lays the SUCCESS arm out as the loop's FALL-THROUGH
     * (`bne v0,v1,<decrement>` with the `li v0,1` return value in its delay slot) and keeps the
     * comparison constants 1 / -1 REMATERIALIZED inside the loop (frame 0x18, only s0+ra saved).
     * Every natural loop form (do-while / while-top / for / continue-arm) instead hoists 1, -1
     * and the printf string address into s1/s2/s3 (frame 0x28) and inverts the branch:
     *   do-while 36 diffs - while-top 53 - for 53 - continue-arm 53 - GOTO 19.
     * MATCH (w51-a4, cc1_272 lane): BRANCH POLARITY -- writing the FAILURE arm as the `if` body
     * (`if (_cd_event_init() != 1) { retry--; ... }`) and the callback installs as the
     * fall-through puts the fail block out of line after the success block, exactly like the
     * oracle; the success-arm-as-if-body spelling made gcc invert and emit the fail block first.
     * 20 -> 6, count-exact 36/36.  Residual = which instruction the delay-slot filler picks
     * (oracle: `li v0,1` in the bne slot + `sw zero` in the `j` slot; ours: the `retry--`
     * speculated into the bne slot).  FALSIFIED: hoisting the shared constant into an `ok`
     * local (`!= ok` / `return ok`) -- 6 -> 20, ours 38 insns. */
    int retry = 4;
loop:
    if (_cd_event_init() != 1) {
        retry--;
        if (retry != -1) goto loop;
        printf("CdInit: Init failed\n");
        return 0;
    }
    CD_cbsync        = (int)_cd_event_sync;
    CD_cbready       = (int)_cd_event_ready;
    CD_cbread        = (int)_cd_event_read;
    CD_read_dma_mode = 0;
    return 1;
}
