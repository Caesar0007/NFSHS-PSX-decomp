/* eaclib/psx/eacpsxz/systask.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\systask.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   3 fns @[0x800E6AF4 .. 0x800E6C04].  A 16-slot periodic system-task scheduler driven by libticks.
 *   Ghidra nfs4-f.exe.c (systask) + IDA sigs.  Slot = 4 ints {fn, period, deadline, busy} (the Ghidra
 *   DAT_8013e984/988/98c are systemtasksubs+1/+2/+3, folded into the one array here).
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
 int gSysTaskCount; int gSysTaskLastTick; 
extern volatile int libticks; /* free-running tick counter -- volatile: IRQ-updated (tmrint.c),
                               * matches inittmr.c's declaration; the oracle re-reads it fresh
                               * at each use inside systemtask() rather than caching one value */
extern int gSysTaskCount;     /* live task count */
extern int gSysTaskLastTick;  /* last tick the task list ran */
extern int systemtasksubs;    /* int[16*4] : 16 slots of {fn, period, deadline, busy} */

extern int          addsystemtask(int taskFn, int period, int delay);        /* @0x800E6AF4 */
extern int          delsystemtask(int fn);                                   /* @0x800E6BA8 */
extern unsigned int systemtask(int arg1);                                    /* @0x800E6C04 */

/* addsystemtask @0x800E6AF4 : register a periodic task (or update its slot); returns the running count.
 *   Slot pick: an exact fn match always wins its slot; otherwise the first free slot — but when called
 *   re-entrantly (count>0 at entry) the first `count` free slots are skipped (count is decremented per
 *   skipped free slot, a plain register copy — only the +1/-1 bracket touches the global). */
extern int addsystemtask(int taskFn, int period, int delay)
{
    int  fn;
    int  found;
    int  count;
    int *slot;

    fn = taskFn;                               /* MATCH: param saved then RECYCLED as the loop index below --
                                                * the reassignment keeps the copy un-coalesced (`addu t1,a0,zero`)
                                                * and the index inherits $a0 (the retail allocation) */
    count = gSysTaskCount;                     /* MATCH: old value kept in a reg (a3) across the scan */
    gSysTaskCount = count + 1;                 /* re-entrancy bracket: ++ at entry, -- at exit */
    found = -1;
    slot  = &systemtasksubs;
    for (taskFn = 0; taskFn < 0x10; taskFn++) {
        if (*slot == fn) {
            found = taskFn;                    /* exact match -> (re)use this slot */
        } else if (*slot == 0 && found == -1) {
            if (count != 0)                    /* MATCH: != polarity -> beqz to the shared found=i block */
                count--;                       /* skip `count` free slots when re-entrant */
            else
                found = taskFn;                /* first non-skipped free slot */
        }
        slot += 4;
    }
    if (found != -1) {
        /* MATCH (permuter find, 43->38 diffs + exact 45/45 count -- transcribed VERBATIM, both details
         * are load-bearing pseudo/scheduling devices; every "clean" rewrite regresses to 48-50):
         *   (1) `- (-(found * 4))` == `+ found * 4` (found is 0..15, no overflow) but the extra neg
         *       RTL temp re-colors the head so the entry `addu t1,a0,zero` copy survives;
         *   (2) the dead `count` is reused as the deadline temp (a NEW named temp would add a pseudo
         *       and re-color the head -- the catalog "any-new-pseudo-recolors-head" trap). */
        slot = (&systemtasksubs) - (-(found * 4));
        count = libticks + delay;              /* MATCH: libticks read AT its use inside the if */
        slot[0] = fn;
        slot[1] = period;
        slot[3] = 0;
        slot[2] = count;
    }
    gSysTaskCount = gSysTaskCount - 1;
    return gSysTaskCount;
}

/* delsystemtask @0x800E6BA8 : remove the task whose fn matches; returns the matched fn word
 * (0 if the scan exhausted all 16 slots without a match -- MATCH: the not-found path returns
 * the loop's own `i<0x10` boolean AS-IS (always 0 there), NOT a bogus `i*0x10` value -- real
 * bug fix vs the prior form; also kept as a single-exit funnel to reproduce the oracle's ONE
 * shared epilogue instead of 3 separate `jr ra`s).
 * RESIDUAL (36 diffs, 29 vs 23 insns): gcc-2.8 `-O2` PEELS the do-while's first iteration
 * (compile-time-provable initial `slot`=&systemtasksubs address) into straight-line code
 * before the real loop -- the oracle has NO peeling (uniform 16-iteration do-while). Tried:
 * for-loop rewrite (still peels, 27 insns), avoiding a compile-time-constant initial pointer
 * (not source-reachable without changing the real initial value). Accept as a toolchain-pass
 * floor; the return-value bug fix above is the real, oracle-evidenced improvement here. */
extern int delsystemtask(int fn)
{
    int  i    = 0;
    int *slot = &systemtasksubs;
    int  ret;
    do {
        if (*slot == fn)
            break;
        i = i + 1;
        slot = slot + 4;
    } while (i < 0x10);
    ret = 0;
    if (i < 0x10) {
        ret = (&systemtasksubs)[i * 4];
        if (ret == fn)
            (&systemtasksubs)[i * 4] = 0;
    }
    return ret;
}

/* systemtask @0x800E6C04 : once per tick, run every due task (fn(arg1, elapsed)) and re-arm it; OR of returns.
 * RESIDUAL (77 diffs, 68 vs 59 insns; was 95 diffs/64 insns before the `volatile libticks`
 * fix below): gcc-2.8 strength-reduces the 4-field slot walk into TWO induction variables
 * (base+0 for `fn`, base+8 for deadline/busy) where the oracle keeps ONE pointer + fixed
 * displacements (0/4/8/0xC). Tried: struct-typed pointer (identical codegen to flat int*
 * indexing -- not a C-shape lever, the split is gcc's own loop-strength-reduction heuristic).
 * Same class as the catalog's "GENUINE base-anchor FLOOR" (§E) -- accept. */
struct SysTaskSlot { int fn; int period; int deadline; int busy; };

extern unsigned int systemtask(int arg1)
{
    unsigned int result = 0;
    if (gSysTaskLastTick != libticks) {
        int  i    = 0;
        /* MATCH: a struct-typed pointer walk (vs raw int* slot[0..3] indexing) keeps ALL
         * four field accesses as displacement offsets (0/4/8/0xC) off ONE base register --
         * the flat-int-array form let gcc strength-reduce slot[2]/slot[3] into a SECOND
         * induction variable (base+8), costing an extra saved register vs the oracle's
         * single-pointer walk. */
        struct SysTaskSlot *slot = (struct SysTaskSlot *)&systemtasksubs;
        gSysTaskLastTick = libticks;
        do {
            if (slot->fn != 0 && slot->deadline <= libticks && slot->busy == 0) {
                unsigned int r;
                int          t;
                slot->busy = 1;
                r = ((unsigned int (*)(int, int))slot->fn)(arg1, libticks - slot->deadline);
                t = libticks;
                result |= r;
                slot->busy = 0;
                slot->deadline = t + slot->period;
            }
            i = i + 1;
            slot = slot + 1;
        } while (i < 0x10);
    }
    return result;
}
