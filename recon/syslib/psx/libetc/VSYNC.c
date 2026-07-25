/* syslib/psx/libetc/VSYNC.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra nfs4-f.exe.c, verified vs disasm-v3;
 *   IDA unreliable here -- const-memory bug).  obj VSYNC.obj ; libetc.lib.
 *   VSync @0x800F231C + static _VSync_wait @0x800F2494.  Matches the PSX VSync spec (EmulationResources
 *   Vsync.txt): mode<0 -> current Vcount; mode==1 -> Hcount delta; mode>0 -> block until that vblank with a
 *   spin-count timeout.  Regs: 0x1F801110 = RCnt vblank-timing COUNT, 0x1F801814 = GPU status (rescan bit
 *   0x400000).  Vcount lives in INTR_VB.obj; Hcount/last-count are VSYNC.obj data.
 *
 * w25-a2 SURVEY (-fno-delayed-branch splice project, methodology sec 3.25.3b): MIXED for both fns,
 *   dominated by an UNRELATED class in each case:
 *   - _VSync_wait (8 diffs): epilogue lw-ra/addiu-sp/jr-ra reorder (2 of 8 diff lines) IS the
 *     pure signature, but the other 6 lines are a register-choice mismatch on the timeout-address
 *     materialize (ours: lui a1,0; addiu a0,a1,0 [via a1 scratch]; oracle: lui a0,0; addiu a0,a0,0
 *     [direct into dest] -- same rematerialize-into-dest class noted in INTR_DMA.cpp/INTR_VB.c).
 *     Empirically whole-TU `-fno-delayed-branch` test (w25-a2, reverted, not committed): 8->15
 *     diffs, WORSE (the flag reorders scheduling elsewhere in the fn and does not isolate the
 *     epilogue fix). NOT a splice candidate as-is.
 *   - VSync (45-49 diffs): NO signature lines at all in the diff (pure register-coloring /
 *     branch-restructuring floor, same family as _initIntr's base-pointer-hoist issue but for a
 *     different global). Whole-TU flag test: 45->53, WORSE. Confirmed UNRELATED, not a splice
 *     candidate.
 */
extern void puts(const char *s);              /* A63 */
extern void ChangeClearPAD(int v);            /* A91 */
extern int  ChangeClearRCnt(int t, int m);    /* L10 */
extern volatile int Vcount;                    /* INTR_VB @0x80137D10 */

extern volatile unsigned int *g_vsync_gp1_ptr; /* @0x80134A88 : = 0x1F801814 */
extern volatile unsigned int *g_vsync_t1_ptr;  /* @0x80134A8C : = 0x1F801110 */
extern int Hcount;                /* @0x80134A90 */
extern int vsync_lastcount;       /* @0x80134A94 : Vcount at the previous VSync */

#define T1_VALUE (*g_vsync_t1_ptr)
#define GP1      (*g_vsync_gp1_ptr)

/* HIDDEN-PHANTOM FIX (w14-a2): oracle name is the bare "_VSync_wait" (no __F mangling suffix --
 * every other fn in this file is already `extern "C"`), but this `static` C++ fn got C++-mangled
 * to _VSync_wait__Fii, a NAME MISMATCH invisible to the gate ("NOT IN OBJECT" forever). `static`
 * and `extern "C"` can't combine as adjacent storage-class specifiers on this compiler --
 * wrap in an `extern "C" { }` block instead (keeps internal/static linkage, drops the mangling). */
static void _VSync_wait(int target, int mult)   /* @0x800F2494 */
{
    volatile int timeout[2];

    timeout[0] = mult << 0xf;
    while (Vcount < target) {
        if (timeout[0]-- == 0) {
            puts("VSync: timeout\n");
            ChangeClearPAD(0);
            ChangeClearRCnt(3, 0);
            return;
        }
    }
}

extern int VSync(int mode)   /* @0x800F231C */
{
    unsigned int gp = GP1;
    volatile unsigned int hcount;
    unsigned int ret;
    int target;
    int timeout;

    do {
        hcount = T1_VALUE;
    } while (hcount != T1_VALUE);
    ret = (hcount - Hcount) & 0xffff;
    if (mode < 0)
        return Vcount;
    if (mode == 1)
        return ret;

    if (mode > 0)
        target = vsync_lastcount - 1 + mode;
    else
        target = vsync_lastcount;
    timeout = 0;
    if (mode > 0)
        timeout = mode - 1;
    _VSync_wait(target, timeout);

    gp = GP1;
    _VSync_wait(Vcount + 1, 1);
    if ((gp & 0x400000) != 0) {
        if ((int)(gp ^ GP1) >= 0) {
            while (((gp ^ GP1) & 0x80000000) == 0)
                ;
        }
    }
    vsync_lastcount = Vcount;
    do {
        Hcount = T1_VALUE;
    } while (Hcount != T1_VALUE);
    return ret;
}
