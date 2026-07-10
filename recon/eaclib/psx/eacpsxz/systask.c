/* eaclib/psx/eacpsxz/systask.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\systask.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   3 fns @[0x800E6AF4 .. 0x800E6C04].  A 16-slot periodic system-task scheduler driven by libticks.
 *   Ghidra nfs4-f.exe.c (systask) + IDA sigs.  Slot = 4 ints {fn, period, deadline, busy} (the Ghidra
 *   DAT_8013e984/988/98c are systemtasksubs+1/+2/+3, folded into the one array here).
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
 int gSysTaskCount; int gSysTaskLastTick; 
extern int libticks;          /* free-running tick counter */
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

/* delsystemtask @0x800E6BA8 : remove the task whose fn matches; returns the cleared fn (or end-marker). */
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
    ret = i * 0x10;
    if (i < 0x10) {
        ret = (&systemtasksubs)[i * 4];
        if (ret == fn)
            (&systemtasksubs)[i * 4] = 0;
    }
    return ret;
}

/* systemtask @0x800E6C04 : once per tick, run every due task (fn(arg1, elapsed)) and re-arm it; OR of returns. */
extern unsigned int systemtask(int arg1)
{
    unsigned int result = 0;
    if (gSysTaskLastTick != libticks) {
        int  i    = 0;
        int *slot = &systemtasksubs;
        gSysTaskLastTick = libticks;
        do {
            if (*slot != 0 && slot[2] <= libticks && slot[3] == 0) {
                unsigned int r;
                int          t;
                slot[3] = 1;
                r = ((unsigned int (*)(int, int))*slot)(arg1, libticks - slot[2]);
                t = libticks;
                result |= r;
                slot[3] = 0;
                slot[2] = t + slot[1];
            }
            i = i + 1;
            slot = slot + 4;
        } while (i < 0x10);
    }
    return result;
}
