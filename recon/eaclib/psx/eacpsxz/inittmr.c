/* eaclib/psx/eacpsxz/inittmr.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   obj nfs4\eaclib\psx\inittmr.obj ; EACPSXZ.LIB.  4 fns @[0x800F4180 .. 0x800F4328].  Root-counter timer
 *   setup: open the RCnt event, install the per-tick handler list (tmrsub[8]), and tick libticks/ticks.
 *   Ghidra nfs4-f.exe.c (inittmr) + disasm-v3 + IDA sigs.  Bare VAs symbolicated: addexit arg 0x800F4304 =
 *   &restoretimer; blockclear target 0x8012360C = &tmrsub; creatememclass template 0x8013DD48 = &DAT_8013dd48.
 */

#include "../eaclib_types.h"
#include "eac_types.h"
#include "inittmr.h"
#include "exit.h"
#include "blkfill.h"
#include "savegp.h"
#include "meminit.h"
#include "threads.h"
#include "memstd.h"
#include "timer.h"
int timerflag;    /* @0x8013DD4C: owning-TU tentative def → .comm/.sbss → gp-rel */
int timerevent;  /* @0x8013DEC4: owning-TU tentative def → .comm/.sbss → gp-rel */
int reentryflag;  /* @0x8013DEC0: tmrint re-entry guard -- owning-TU tentative def → .comm/.sbss → gp-rel
                    * (only inittimer.s oracle gp-rels it: `sw zero,%gp_rel(reentryflag)(gp)`) */
extern int timerhz;       /* tick rate */
/* `memclass` is owned by memstd.obj as the retail 16-pointer table.  This TU
 * deliberately keeps an unsized integer view: it copies the first pointer
 * word to the second, and that declaration shape preserves the shared %hi. */
extern int memclass[];    /* @0x8013E900; [1] = cached copy @0x8013E904
                             * (UNSIZED array shape: oracle shares ONE %hi -- lw %lo(memclass)(v1);
                             *  addiu v1,%lo; sw a0,4(v1)) */
extern int tmrsub[];      /* int[8] : per-tick handler list (UNSIZED array shape, lever #5) */
/* `ticks` and `libticks` come from vars.h (via timer.h) -- vars.obj owns both.
 * MATCH DEVICE (re-measured 2026-09-11): `volatile` on libticks is load-bearing HERE: without it
 * cse shares the `1` between the g_currentthread store and the increment (`li v1,1` +
 * `addu v0,v0,v1` where retail has two independent `addiu v0,v0,1`), 16 diffs at the exact 43
 * insns.  Falsified without volatile: a local one-carrier, an increment through a local, `++`,
 * the flag store moved last, volatile on g_currentthread, and libticks as an unsized array
 * (15 diffs, one insn short).  `ticks` holds 4/4 here either way, but IS load-bearing in
 * timer.c resettick (7 diffs without it), so vars.h carries volatile on both. */

/* --- syslib (PsyQ libapi/libetc) --- */
extern void EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern int  OpenEvent(unsigned int cls, int spec, int mode, int *fn);
extern void EnableEvent(int ev);
extern void DisableEvent(int ev);
extern void SetRCnt(int spec, unsigned short target, int mode);
extern void StartRCnt(int spec);

/* initmemadr @0x800F4180 : carve `base[size]` into the default memory class (id 0),
 * gran 8 / align 0x20 / no guards / MEM_defaultevent handler, and cache the class id. */
int initmemadr(int base, int size)
{
    char *name = "RAM";                 /* compiler-owned writable literal @0x8013DD48 */
    int r = creatememclass(0, name, (char *)base, size,
                           8, 0x20, 0, 0, 0, 0, 0, (int)MEM_defaultevent);
    memclass[1] = memclass[0];               /* cached copy @0x8013E904 */
    return r;
}

/* inittimer @0x800F41F0 : install (once) the RCnt event + restore hook, then arm the counter for `hz` Hz. */
int inittimer(int hz)
{
    if (hz == 0)
        hz = 100;
    EnterCriticalSection();
    if (timerflag == 0) {
        blockclear(tmrsub, 0x20);
        timerevent = OpenEvent(0xf2000002, 2, 0x1000, (int *)tmrint);
        EnableEvent(timerevent);
        timerflag = 1;
        addexit((int)restoretimer);
    }
    initgp();
    timerhz = hz;
    reentryflag = 0;
    SetRCnt(0xf2000002, (unsigned short)(0x409980 / hz), 0x1000);
    StartRCnt(0xf2000002);
    ExitCriticalSection();
    resettick();
    /* MATCH: addexit() returns nothing (its oracle never sets $v0 on the exit path), and the
     * oracle tail-calls it -- inittimer's own result is whatever $v0 happens to hold.  Falling
     * off the end reproduces that; an explicit `return 0;` adds the `li $v0,0` retail lacks. */
    addexit(restoretimer);
}

/* restoretimer @0x800F4304 : disable the RCnt event (exit hook). */
void restoretimer(void)
{
    DisableEvent(timerevent);
    timerflag = 0;
}

/* tmrint @0x800F4328 : the per-tick interrupt handler -- advance the tick counters and run tmrsub[0..7]. */
unsigned int tmrint(void)
{
    unsigned int gpbuf[2];
    int          i;
    int         *p;
    savegp(gpbuf);
    /* MATCH: i/p assigned AFTER the savegp call (oracle zeroes s1 + materializes &tmrsub
     * post-call, %hi via a v1 scratch into s0); initialized decls hoist both before the jal. */
    i = 0;
    p = tmrsub;
    ticks = ticks + 1;
    g_currentthread = 1;
    libticks = libticks + 1;
    do {
        if (*p != 0)
            ((void (*)(void))*p)();
        i = i + 1;
        p = p + 1;
    } while (i < 8);
    g_currentthread = 0;
    restoregp(gpbuf[0]);
    return 0;
}
