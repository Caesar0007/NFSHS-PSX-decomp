/* syslib/psx/libetc/VSYNC.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra nfs4-f.exe.c, verified vs disasm-v3;
 *   IDA unreliable here -- const-memory bug).  obj VSYNC.obj ; libetc.lib.
 *   VSync @0x800F231C + static _VSync_wait @0x800F2494.  Matches the PSX VSync spec (EmulationResources
 *   Vsync.txt): mode<0 -> current Vcount; mode==1 -> Hcount delta; mode>0 -> block until that vblank with a
 *   spin-count timeout.  Regs: 0x1F801110 = RCnt vblank-timing COUNT, 0x1F801814 = GPU status (rescan bit
 *   0x400000).  Vcount lives in INTR_VB.obj; Hcount/last-count are VSYNC.obj data.
 */
#define T1_VALUE  (*(volatile unsigned int *)0x1F801110)
#define GP1       (*(volatile unsigned int *)0x1F801814)

extern "C" void puts(const char *s);              /* A63 */
extern "C" void ChangeClearPAD(int v);            /* A91 */
extern "C" int  ChangeClearRCnt(int t, int m);    /* L10 */
extern "C" int  Vcount;                            /* INTR_VB @0x80137D10 */

extern "C" int Hcount = 0;            /* @0x80134A90 */
extern "C" int vsync_lastcount = 0;   /* @0x80134A94 : Vcount at the previous VSync */

/* HIDDEN-PHANTOM FIX (w14-a2): oracle name is the bare "_VSync_wait" (no __F mangling suffix --
 * every other fn in this file is already `extern "C"`), but this `static` C++ fn got C++-mangled
 * to _VSync_wait__Fii, a NAME MISMATCH invisible to the gate ("NOT IN OBJECT" forever). `static`
 * and `extern "C"` can't combine as adjacent storage-class specifiers on this compiler --
 * wrap in an `extern "C" { }` block instead (keeps internal/static linkage, drops the mangling). */
extern "C" {
static int _VSync_wait(int target, int mult)   /* @0x800F2494 */
{
    int cnt = mult << 0xf;
    do {
        if (target <= Vcount) return 0;
        cnt = cnt - 1;
    } while (cnt != -1);
    puts("VSync: timeout\n");
    ChangeClearPAD(0);
    ChangeClearRCnt(3, 0);
    return cnt;
}
}   /* extern "C" */

extern "C" int VSync(int mode)   /* @0x800F231C */
{
    unsigned int hdiff = (T1_VALUE - Hcount) & 0xffff;
    unsigned int ret   = Vcount;
    if ((mode >= 0) && (ret = hdiff, mode != 1)) {
        int target = vsync_lastcount;
        if (mode > 0) target = vsync_lastcount + mode - 1;
        int to = 0;
        if (mode > 0) to = mode - 1;
        _VSync_wait(target, to);
        unsigned int gp = GP1;
        _VSync_wait(Vcount + 1, 1);
        if (((gp & 0x400000) != 0) && ((int)(gp ^ GP1) >= 0)) {
            while (((gp ^ GP1) & 0x80000000) == 0)
                ;
        }
        vsync_lastcount = Vcount;
        Hcount = T1_VALUE;
    }
    return ret;
}
