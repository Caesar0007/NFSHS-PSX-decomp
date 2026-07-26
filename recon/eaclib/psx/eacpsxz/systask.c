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
extern int systemtasksubs[];    /* int[16*4] : 16 slots of {fn, period, deadline, busy} */

extern int          addsystemtask(int taskFn, int period, int delay);        /* @0x800E6AF4 */
extern void         delsystemtask(int fn);                                   /* @0x800E6BA8 */
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

    fn = taskFn;                               /* MATCH: param saved into fn (`addu t1,a0,zero`) -- the
                                                * INDEX-FORM loop below is what keeps this copy alive
                                                * (a pointer-walk loop lets fn stay in $a0, no copy) */
    found = -1;
    taskFn = 0;
    count = gSysTaskCount;                     /* old value kept in a reg across the scan */
    gSysTaskCount = count + 1;                 /* re-entrancy bracket: ++ at entry, -- at exit */
    slot  = (int *)&systemtasksubs;
    for (; taskFn < 0x10; taskFn++) {
        if (slot[taskFn * 4] == fn) {          /* MATCH: index form (strength-reduces to the oracle's
                                                * t0 walker) -- do NOT rewrite as *slot/slot+=4 */
            found = taskFn;                    /* exact match -> (re)use this slot */
        } else if (slot[taskFn * 4] == 0 && found == -1) {
            if (count != 0)                    /* MATCH: != polarity -> beqz to the shared found=i block */
                count--;                       /* skip `count` free slots when re-entrant */
            else
                found = taskFn;                /* first non-skipped free slot */
        }
    }
    if (found != -1) {
        /* MATCH (w31-a5: 38->30 diffs, exact 45/45 count; RESIDUAL 30 = ONE uniform 3-register
         * rotation {found,i,count}: ours (a3,v1,a0) vs retail (v1,a0,a3) -- greg-dump-verified as a
         * global-alloc PRIORITY-ORDER tie (ours allocates i>count>found, retail needs found>i>count;
         * count carries a spurious preference for $a0).  Emission/structure otherwise identical.
         * Permuter territory -- no manual lever found (register kw, minusOne copy, deadline temp,
         * struct-index, decl/statement orders all tested via -dg/-dl scratch harness).
         *   (1) `- (-(found * 4))` == `+ found * 4` (found is 0..15, no overflow) but the extra neg
         *       RTL temp keeps the tail's fresh base rematerialization;
         *   (2) the dead `count` is reused as the deadline temp (a NEW named temp would add a pseudo
         *       and re-color the head -- the catalog "any-new-pseudo-recolors-head" trap). */
        slot = (int *)&systemtasksubs - (-(found * 4));
        count = libticks + delay;              /* MATCH: libticks read AT its use inside the if */
        slot[0] = fn;
        slot[1] = period;
        slot[3] = 0;
        slot[2] = count;
    }
    gSysTaskCount = gSysTaskCount - 1;
    return gSysTaskCount;
}

/* delsystemtask @0x800E6BA8 : remove the task whose fn matches.  PASS (w31-a5).
 * The apparent return value in decompiler output is incidental: every known caller discards it,
 * and the oracle has no return-value funnel (void signature).
 * MATCH levers (both load-bearing):
 *   (1) `for (; i < 0x10; i++)` with the break test in the body -- a do/while form makes gcc
 *       PEEL the first `*slot == fn` check out of the loop and rotate the break test to the
 *       back edge (+5 insns); the for-form (entry test provably true at i=0) compiles to the
 *       oracle's straight do-while with the `i<16` back-edge and the break jumping to the
 *       shared `slti` head.
 *   (2) `extern int systemtasksubs[]` (unsized array, its TRUE shape) -- the scalar extern
 *       self-temps the base la (`lui a2; addiu a2,a2`); the array decl gives the oracle's
 *       separate-temp form (`lui v0; addiu a2,v0`).  Section 3.12 #5 extended to an ADDRESS
 *       materialization. */
extern void delsystemtask(int fn)
{
    int  i    = 0;
    int *base = systemtasksubs;
    int *slot = base;
    for (; i < 0x10; i++) {
        if (*slot == fn)
            break;
        slot = slot + 4;
    }
    if (i < 0x10) {
        if (base[i * 4] == fn)
            base[i * 4] = 0;
    }
}

/* systemtask @0x800E6C04 : once per tick, run every due task (fn(arg1, elapsed)) and re-arm it; OR of returns.
 * RESIDUAL (19 diffs, 62 vs 59 insns; was 77/68, then 27 -- the w31-a5 unsized-array decl of
 * systemtasksubs removed the base-la drift): the WHOLE remaining diff is our loop.c hoisting the
 * invariant `li 1` (busy=1 store value) out of the loop into a callee-saved reg (li s3,1), which
 * adds one save/restore pair and pushes arg1 to s4; the oracle rematerializes `li v0,1` at its use
 * every iteration.  -fno-schedule-insns{,2} does NOT remove the hoist (tested in a -dg scratch
 * harness), and no source shape reaches it -- this is the per-use-constant-remat signature of the
 * catalog's per-obj OPTIMIZATION-FLAG identity class (methodology 3.25-3d, movfxya's `li 255`
 * sibling).  Suspected per-obj flag identity -- do not contort the source; accept. */
struct SysTaskSlot { int fn; int period; int deadline; int busy; };

extern unsigned int systemtask(int arg1)
{
    unsigned int result = 0;
    if (gSysTaskLastTick != libticks) {
        int  i    = 0;
        /* MATCH: indexed struct access follows the PC-beta source shape and keeps all
         * four fields on one slot base in the PSX compiler's generated loop. */
        struct SysTaskSlot *slots = (struct SysTaskSlot *)systemtasksubs;
        gSysTaskLastTick = libticks;
        do {
            unsigned int (*fn)(int, int) =
                (unsigned int (*)(int, int))slots[i].fn;
            if (fn != 0 && slots[i].deadline <= libticks && slots[i].busy == 0) {
                unsigned int r;
                int          t;
                slots[i].busy = 1;
                r = fn(arg1, libticks - slots[i].deadline);
                t = libticks;
                result |= r;
                slots[i].busy = 0;
                slots[i].deadline = t + slots[i].period;
            }
            i = i + 1;
        } while (i < 0x10);
    }
    return result;
}
