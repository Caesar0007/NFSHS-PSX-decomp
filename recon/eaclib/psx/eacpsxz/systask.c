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
/* W65-A6 DATA-MAT: `systemtasksubs` (8 reloc sites) was extern-only tree-wide.  systask.obj is
 * its only referencer AND its retail owner: the SYM records it as `$8013e980 6 systemtasksubs`
 * -- record type 6 = STATIC, i.e. a file-static of this object, which is exactly why no other
 * TU can define it.  Genuine BSS (0x8013E980 > t_addr+t_size 0x8013E000: no file bytes,
 * zero-init), size 256 = the SYM VA delta to the next symbol (sndss @0x8013EA80 is the next
 * EXT; 0x8013E980 + 0x100 = 0x8013EA80), matching the int[16*4] shape documented here.
 * DEVICE = file-scope asm `.section .bss` with NO `.globl` -- retail's STATIC binding is
 * reproduced exactly, the assembler still resolves this TU's references, and the C view stays
 * the UNSIZED `extern int systemtasksubs[]` that the MATCH note further down records as
 * load-bearing ("its TRUE shape").  3/3 PASS unchanged.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.section\t.bss\n\t.align\t2\nsystemtasksubs:\n\t.space\t256\n\t.text");
extern int systemtasksubs[];    /* int[16*4] : 16 slots of {fn, period, deadline, busy} */

extern void         addsystemtask(int taskFn, int period, int delay);        /* @0x800E6AF4 */
extern void         delsystemtask(int fn);                                   /* @0x800E6BA8 */
extern unsigned int systemtask(int arg1);                                    /* @0x800E6C04 */

/* addsystemtask @0x800E6AF4 : register a periodic task (or update its slot).  VOID (w32-a10 prototype
 *   audit): the tail `lw v0,gp; addiu v0,-1; sw v0,gp` is the re-entrancy counter's own decrement temp,
 *   NOT a return funnel -- the value would be the count as it was on ENTRY (useless), 0/6 call sites
 *   consume $v0, and 3 of the 5 other TUs already declare it `void`.  Codegen is byte-identical either
 *   way (verified: 30 diffs before and after), so this is a correctness-only correction.
 *   Slot pick: an exact fn match always wins its slot; otherwise the first free slot — but when called
 *   re-entrantly (count>0 at entry) the first `count` free slots are skipped (count is decremented per
 *   skipped free slot, a plain register copy — only the +1/-1 bracket touches the global). */
extern void addsystemtask(int taskFn, int period, int delay)
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
        /* MATCH (w33-a4: 30 -> 0.  The w31/w32 residual was ONE uniform 3-register rotation
         * {found,i,count}: ours (a3,v1,a0) vs retail (v1,a0,a3).  It is NOT a coin flip -- the
         * greg/lreg dumps make gcc-2.8's global allocator fully predictable here:
         *   priority = floor_log2(n_refs)*n_refs/live_length  (allocno_compare), and find_reg
         *   then skips any hard reg that a CONFLICTING allocno *prefers* (regs_someone_prefers).
         * Retail's assignment falls out of exactly TWO source facts, both encoded below:
         *  (a) the tail SLOT POINTER lives in `found`'s own pseudo (retail: `sll v1,v1,4` shifts
         *      found IN PLACE and the four stores use $v1).  Writing it to a separate `slot`
         *      variable creates a 5th allocno that is allocated BEFORE found (7 refs / 6 insns =
         *      the highest priority in the function), steals $v1, and pushes found down to $a3.
         *      Reusing `found` merges the two: its refs go 9 -> 14, and the $v1 preference the
         *      pointer carries becomes FOUND's preference.  Hence the `(int)`/`(int *)` casts --
         *      they are the only way to keep one C variable across the index->pointer change.
         *  (b) the deadline temp reuses `taskFn` (the loop counter i), NOT `count`.  The libticks
         *      load is locally allocated to $a0, and whichever variable receives `libticks+delay`
         *      inherits a preference for $a0 -- that is retail's i-in-$a0.  With `count` as the
         *      temp (w31/w32 shape) the preference landed on count and the pair swapped.
         * (c) `base` must be a BLOCK-LOCAL fresh materialization and the add must be written
         *      `found*4 + base` (index first): as `base + found*4` gcc emits the commuted
         *      `addu v1,v0,v1`, and hoisting the base out of the if-block emits the `sll` before
         *      the `lui/addiu` pair (catalog: join-block fresh materialization + operand order). */
        int *base = (int *)&systemtasksubs;
        found  = (int)((found * 4) + base);    /* slot pointer, in found's own register */
        taskFn = libticks + delay;             /* MATCH: libticks read AT its use inside the if */
        ((int *)found)[0] = fn;
        ((int *)found)[1] = period;
        ((int *)found)[3] = 0;
        ((int *)found)[2] = taskFn;
    }
    gSysTaskCount = gSysTaskCount - 1;
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
 * MATCH (w33-a4: 19 -> 0, and the w31 "per-obj optimization-flag identity" verdict was WRONG).
 * The whole 3-insn gap was loop.c hoisting the invariant `li 1` (the busy=1 store value) into a
 * callee-saved reg (`li s3,1` + one extra save/restore pair, arg1 pushed to s4); retail
 * rematerializes `li v0,1` in the `bnez` delay slot every iteration.  Two source facts fix it:
 *  (1) LABEL+GOTO loop instead of do/while -- with no NOTE_INSN_LOOP_BEG/END pair, loop.c does
 *      nothing at all: no invariant hoist (the `li 1` stays at its use) and no strength
 *      reduction, so the slot walker has to be written explicitly (`p++`).  Retail's loop keeps
 *      BOTH a counter (s1, `slti 0x10`) and a pointer (s0, `addiu s0,s0,0x10` in the back-edge
 *      delay slot), which is exactly what the explicit i++/p++ pair emits.  This is the catalog
 *      "goto-loop defeats loop.c" lever; the previous do/while + index form relied on loop.c's
 *      strength reduction and therefore could never avoid the hoist.
 *  (2) `libticks >= p->deadline` (global first), not `p->deadline <= libticks`: gcc evaluates
 *      left-to-right, and retail loads libticks BEFORE the 0x8(s0) deadline field. */
struct SysTaskSlot { int fn; int period; int deadline; int busy; };

extern unsigned int systemtask(int arg1)
{
    unsigned int result = 0;
    if (gSysTaskLastTick != libticks) {
        int i = 0;
        struct SysTaskSlot *p = (struct SysTaskSlot *)systemtasksubs;
        gSysTaskLastTick = libticks;
    next:
        {
            unsigned int (*fn)(int, int) = (unsigned int (*)(int, int))p->fn;
            if (fn != 0 && libticks >= p->deadline && p->busy == 0) {
                unsigned int r;
                int          t;
                p->busy = 1;
                r = fn(arg1, libticks - p->deadline);
                t = libticks;
                result |= r;
                p->busy = 0;
                p->deadline = t + p->period;
            }
        }
        i++;
        p++;
        if (i < 0x10) goto next;
    }
    return result;
}
