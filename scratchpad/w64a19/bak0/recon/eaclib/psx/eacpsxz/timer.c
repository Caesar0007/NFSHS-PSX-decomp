/* eaclib/psx/eacpsxz/timer.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\timer.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   4 fns: gettick@0x800E8220, elapsedticks@0x800E8230, resettick@0x800E8260, timedwait@0x800E8284.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  EA frame-tick service.
 *
 *   `ticks` is the master tick counter, advanced by the Clock interrupt handler (inittimer/tmrint).
 *     gettick()        : return ticks.
 *     elapsedticks()   : delta since the last call -- t=gettick(); d=t-gTickVal; gTickVal=t; return d.
 *     resettick()      : ticks=0; gTickVal=gTickSet=ticks (re-baseline).
 *     timedwait(n)     : busy-wait n ticks, pumping systemtask(0) each iteration until gettick()
 *                        reaches the target (target = gettick()+n).
 */

/* ---- owning-TU defs for link-harness ----
 * STORAGE SHAPE matters (methodology lever #6 / its caveat):
 *   - `ticks` (oracle @0x8013DCAC) is referenced ABSOLUTELY by every oracle
 *     (gettick/resettick: `lui %hi(ticks); lw %lo(ticks)`; 0 %gp_rel anywhere),
 *     so it must be a PURE `extern` -> the assembler resolves it far/absolute.
 *     Its definition is provided by asm/data/sdata_8013C54C.sdata.s (`ticks`).
 *   - `gTickVal`/`gTickSet` are reached via %gp_rel(tickval)/(tickset) in the
 *     oracle, so they are timer.obj-OWNED small globals -> tentative definitions
 *     (no `extern`) land them in .sdata -> gp-addressable. (Their own names; the
 *     verify normalizes symbol names, and asm/data's tickval/tickset are distinct.) */
/* `ticks` is VOLATILE: advanced by the Clock ISR behind the compiler's back
 * (lever #13). resettick stores 0 then RE-READS ticks from memory into the value
 * it writes to tickval/tickset -- without `volatile` gcc constant-folds the reload
 * away (stores 0 directly). volatile restores the oracle's store->reload. */
extern volatile int ticks;   /* @0x8013DCAC master tick counter (asm/data owns; ABSOLUTE) */
 int gTickSet; int gTickVal;    /* tentative defs -> .sdata -> gp-rel */

extern int  gTickVal;     /* last-sampled tick (elapsedticks state)                  */
extern int  gTickSet;     /* baseline tick (resettick)                               */
extern int  systemtask(int);   /* @0x800E6C04 per-frame vsync/idle pump (lbl_D6C04)  */

extern int gettick(void)        /* @0x800E8220 */
{
    return ticks;
}

extern int elapsedticks(void)   /* @0x800E8230 */
{
    int prev = gTickVal;
    int now  = gettick();
    gTickVal = now;
    return now - prev;
}

extern void resettick(void)     /* @0x800E8260 */
{
    int t;
    ticks   = 0;
    t = ticks;            /* volatile reload (=0); oracle keeps it in $v0 */
    gTickVal = t;
    gTickSet = t;
}

extern void timedwait(int n)    /* @0x800E8284 */
{
    int target = gettick() + n;
    while (gettick() - target < 0)
        systemtask(0);
}
