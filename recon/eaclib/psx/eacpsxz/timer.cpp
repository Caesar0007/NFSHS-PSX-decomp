/* eaclib/psx/eacpsxz/timer.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\timer.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   4 fns: gettick@0x800E8220, elapsedticks@0x800E8230, resettick@0x800E8260, timedwait@0x800E8284.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  EA frame-tick service.
 *
 *   `gTicks` is the master tick counter, advanced by the Clock interrupt handler (inittimer/tmrint).
 *     gettick()        : return gTicks.
 *     elapsedticks()   : delta since the last call -- t=gettick(); d=t-gTickVal; gTickVal=t; return d.
 *     resettick()      : gTicks=0; gTickVal=gTickSet=gTicks (re-baseline).
 *     timedwait(n)     : busy-wait n ticks, pumping systemtask(0) each iteration until gettick()
 *                        reaches the target (target = gettick()+n).
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
extern "C" { int gTickSet; int gTickVal; int gTicks; }

extern "C" int  gTicks;       /* @0x8014xxxx, advanced by Clock ISR (data-mat pass owns) */
extern "C" int  gTickVal;     /* last-sampled tick (elapsedticks state)                  */
extern "C" int  gTickSet;     /* baseline tick (resettick)                               */
extern "C" int  systemtask(int);   /* @0x800E6C04 per-frame vsync/idle pump (lbl_D6C04)  */

extern "C" int gettick(void)        /* @0x800E8220 */
{
    return gTicks;
}

extern "C" int elapsedticks(void)   /* @0x800E8230 */
{
    int prev = gTickVal;
    int now  = gettick();
    gTickVal = now;
    return now - prev;
}

extern "C" void resettick(void)     /* @0x800E8260 */
{
    gTicks   = 0;
    gTickVal = gTicks;
    gTickSet = gTicks;
}

extern "C" void timedwait(int n)    /* @0x800E8284 */
{
    int target = gettick() + n;
    while (gettick() - target < 0)
        systemtask(0);
}
