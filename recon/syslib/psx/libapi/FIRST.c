/* syslib/psx/libapi/FIRST.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj FIRST.obj ; libapi.lib.  firstfile + _first_patch -- the libapi "first-file" wrapper that
 *   works around a retail-BIOS bug.  firstfile() strips the device prefix off `name`, walks the BIOS
 *   Device Control Block (DCB) table (kernel globals: base @0x150, byte-count @0x154; 0x50-byte
 *   entries), saves the matching device's first-file handler and swaps in _first_patch, then calls
 *   the BIOS firstfile2().  When the BIOS later invokes the device handler it hits _first_patch,
 *   which restores the original handler in the DCB and forwards the call -- a one-shot, self-removing
 *   patch.  NOTE: firstfile() returns firstfile2()'s DIRENTRY* result (Ghidra typed firstfile2 void
 *   and mis-attributed the return to the patch pointer; the disasm returns $v0 from firstfile2).
 *
 *   The 0x150/0x154 kernel globals and the 0x50-byte DCB layout are part of the PSX BIOS ABI (fixed
 *   addresses), represented here as literal volatile pointers per the HW/BIOS-global rule.
 *
 *   Oracle tracing shows two searches: the first saves the real handler and the second installs
 *   the one-shot patch.  The pathname scan is signed, preserves the original `name` for firstfile2,
 *   and the DCB byte-count division is unsigned (0xCCCCCCCD >> 6).
 *
 * w25-a2 SURVEY (-fno-delayed-branch splice project, methodology sec 3.25.3b): UNRELATED for both
 *   fns -- register-coloring floor (per w24-a7's prior "60/40" diagnosis, re-confirmed here): our
 *   frame allocates one MORE callee-saved s-reg than the oracle (firstfile: ours s2/s4/s5, sp-48;
 *   oracle s2/s3, sp-40 -- one fewer live temp across the DCB-walk loop; _first_patch: ours
 *   s2/s4/s5/s6, sp-48; oracle s2/s3/s4/s5, sp-40, same one-reg-over pattern). No jal-arg-slot or
 *   epilogue-reorder signature lines present in either diff (the epilogue lw-ra/addiu-sp deltas
 *   are pure byte-offset shifts caused by the extra saved register, not a slot/order swap).
 *   Empirically whole-TU `-fno-delayed-branch` test (w25-a2, reverted, not committed): firstfile
 *   68->136 diffs, _first_patch 44->54 diffs -- both MUCH WORSE. Confirms neither fn is
 *   delayed-branch-related; do NOT splice. Needs a genuine register-coloring lever instead
 *   (one fewer live local across the two DCB-table walks). */

extern int   strcmp(const char *a, const char *b);     /* libc C23 @0x800E5D7C */
extern void *firstfile2(const char *name, void *dir);  /* A66.OBJ : BIOS B0:0x42 */

/* PSX BIOS Device Control Block: 0x50 bytes.  Only the name pointer (+0x00) and the per-device
 * first-file handler slot (+0x34) are touched here. */
typedef struct DCB {
    char  *name;        /* +0x00 */
    int    _r1[12];     /* +0x04 .. +0x30 */
    void  *firstfile;   /* +0x34 : first-file handler (patch target) */
    int    _r2[6];      /* +0x38 .. +0x4C */
} DCB;                  /* sizeof == 0x50 */

/* BIOS device-table kernel globals (fixed ABI addresses). */
#define BIOS_DCB_BASE   (*(DCB **)0x150)   /* @kernel 0x150 : DCB table base pointer */
#define BIOS_DCB_BYTES  (*(int  *)0x154)   /* @kernel 0x154 : DCB table size in bytes */

typedef int (*FirstFn)(int *state, int arg, int arg2);

extern FirstFn _first_save;          /* @0x80148A7C : saved original device handler */
/* MATCH (w48-a7): UNSIZED.  The oracle materializes this address INSIDE the DCB search loop, at
 * the strcmp call site (`lui $a1,%hi; addiu $a1,$a1,%lo` = one `la` macro).  With the size known,
 * -msplit-addresses gives gcc a separate `(high _first_devname)` pseudo that loop.c hoists out of
 * the loop into a CALLEE-SAVED register -- costing a whole extra saved reg (7 vs the oracle's 6)
 * and rotating every other saved-reg role.  IDT Ch9's rule (methodology 3.12 #5) both ways:
 * omit the size, or give the correct one -- here the omission is what retail's codegen shows. */
extern char    _first_devname[];     /* @0x80148A84 : device prefix extracted from `name` */

/* W60-A1 (2026-08-14): the _first_patch DEFINITION lives at EOF -- retail's obj is
 * firstfile (0x80109DC0) then _first_patch (0x80109F5C).  Forward decl for the DCB
 * install site inside firstfile below. */
extern int _first_patch(int *state, int arg, int arg2);

/* @0x80109DC0 : firstfile */
extern void *firstfile(char *name, void *dir)
{
    DCB  *e, *end, *lim;
    char *p;
    signed char *scan;
    int   found;

    /* extract the device prefix (characters before ':') into _first_devname */
    p = _first_devname;
    scan = (signed char *)name;
    while (*scan > ':')
        *p++ = (unsigned char)*scan++;
    *p = '\0';

    /* RESIDUAL (w59-a13, 6 diffs @103/103, both sites reorg/sched1-side):
     *  (1) HEAD: retail emits the `la _first_devname` AFTER the first `lb $v0,0($s2)`
     *      (its `lui` fills that load's delay slot) and materializes it SELF-TEMP
     *      (`lui $a0; addiu $a0,$a0`); ours hoists the pair into the prologue store group
     *      and splits it through a SEPARATE scratch (`lui $v0; addiu $a0,$v0`) leaving the
     *      lb's slot a `nop` -- a sched1 ready-list order + reload-scratch tie-break.
     *      FALSIFIED: `scan` before `p` (22), split-increment loop body (22), peeled
     *      do/while (22), void/read-only fences before or after either init (6 inert or 9),
     *      sized `_first_devname[32]`/`[16]` (6 inert; `[4]`/`[1]` = 15, they fall under -G4).
     *  (2) the zero-trip guard's `beqz $v0` slot: retail eager-steals `addu $a0,$s2,$zero`
     *      from the TARGET thread (the firstfile2 arg setup, re-done at the shared tail),
     *      ours fills from the fall-through -- the same reorg thread-choice residual as
     *      _first_patch's, and the only diff left after (1).
     *  FLAG/VERSION AXIS RE-LADDERED on this basin (04Z): default lane best (6+2);
     *  cc1_alt 2.7.2 = 5 on firstfile but 18 on _first_patch (23 total), 2.7.2-970404 21/7,
     *  2.8.0/2.8.1 alt 22/6, cc1_ver 2.7.2 18/30, -mno-split-addresses 12/4,
     *  -fno-schedule-insns 18, -fno-schedule-insns2 17/14, -G0 25/13, -G8 == default. */
    /* MATCH (w48-a7): both DCB searches use a GOTO back-edge (see _first_patch) so loop.c never
     * hoists the `(high _first_devname)` half into a callee-saved reg, and `found` is assigned in
     * the two EXIT paths (never before the loop) so it does not live across strcmp and stays in a
     * caller-saved reg -- the oracle's `addu $v1,$zero,$zero` / `li $v1,1` / `bnez $v1`.  Both
     * together take the frame 48 -> 40 and the saved set s0..s5 -> s0..s3. */

    /* pass 1: locate the device, remember its current first-file handler */
    e   = BIOS_DCB_BASE;
    lim = e + (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(DCB);
    if (e < lim) {
        end = lim;
scan1:
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0)
            goto hit1;                     /* match handler is OUT OF LINE (oracle beqz target) */
        e++;
        if (e < end) goto scan1;
    }
    found = 0;
tested:
    if (!found)
        return 0;
    goto pass2;
hit1:
    _first_save = (FirstFn)e->firstfile;
    found = 1;
    goto tested;
/* MATCH (2026-08-14, 16 @103/103 -> 9 @102/103): retail places the second
 * search's match arm physically before the search setup.  Keeping hit2 here
 * makes the loop branch backward to the patch store and reproduces the SDK
 * cross-jump layout; placing it after scan2 emitted the right logic in the
 * wrong block order. */
hit2:
    /* MATCH (w59-a13, 2026-08-14, 9 @102/103 -> 6 @103/103): void-tail fence at the ARM
     * HEAD (06B/05H).  Without it reorg back-scans into this block and steals the
     * `lui %hi(_first_patch)` half of the split address into the preceding loop's
     * `beqz $v0` delay slot, where retail keeps a `nop` and emits the lui adjacent to its
     * `addiu %lo` -- one wrong fill costing 3 diffs AND the instruction count.  Zero insns.
     * FALSIFIED (all inert or worse): the same fence at hit1's head (9), at tail's head (9),
     * a read-only `name` fence at tail (9), void fence before/after `p = _first_devname`
     * (6, inert), after `scan = name` (9 @104). */
    __asm__("" : : "i"(0));
    e->firstfile = (void *)_first_patch;
    goto tail;
pass2:

    /* pass 2: install the self-removing patch into that device */
    e   = BIOS_DCB_BASE;
    lim = e + (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(DCB);
    if (e < lim) {
        /* MATCH (w61-a8): void-tail fence, 6 -> 5.  Retail fills pass 2's zero-trip
         * `beqz $v0` slot by EAGER-STEALING `addu $a0,$s2,$zero` from the BRANCH
         * TARGET thread (the shared firstfile2 arg setup); ours filled it from the
         * fall-through with this `end = lim` copy.  An asm stops reorg's BACKWARD
         * scan, so the fall-through candidate disappears and reorg takes the target
         * thread instead.  SITE-SELECTIVE, priced per site: the same fence at pass 1
         * is inert (6) and at _first_patch's identical walk it REGRESSES (2 -> 3), so
         * the all-three-sites sweep is a wash (5+3).  Zero insns. */
        __asm__("" : : "i"(0));
        end = lim;
scan2:
        if (e->name != 0 && strcmp(e->name, _first_devname) == 0)
            goto hit2;                     /* match handler OUT OF LINE, as in pass 1 */
        e++;
        if (e < end) goto scan2;
    }
    goto tail;
tail:
    return firstfile2(name, dir);
}

/* @0x80109F5C : _first_patch -- restore the device's real handler, then forward the call. */
extern int _first_patch(int *state, int arg, int arg2)
{
    DCB *e, *end, *lim;
    unsigned int cnt;
    FirstFn saved;

    /* MATCH (w59-a13, 2026-08-14, 9 -> 2 diffs @62/64): SUPERSEDES the w48-a7 note that
     * `saved` must be assigned FIRST (that basin measured 9; every later position measured
     * 20 -- but only because the s2/s3 roles then swapped).  The oracle SCHEDULES the
     * `lui/lw _first_save` pair into the multu latency window (between `lw s0,336` and
     * `mfhi`), i.e. in the block AFTER the `*state` update -- unreachable from the
     * first-statement position, where sched1 puts it in the `lw v0,0(s2)` load-delay slot
     * and retail keeps a `nop`.  Assigning it here reproduces retail's placement AND the
     * prologue `sw ra` order; the resulting s2/s3 swap is then bought back by the one
     * read-only fence on `state` before the tail call (see below).
     * FALSIFIED at this position (all worse): fence on `saved` instead (24), two `state`
     * operands (18), no fence (20), void fence at the fall-through head (3) / after the
     * `end` copy (2, inert) / at the tail head (2, inert), duplicated tail call in the
     * guarded arm (24 @68 -- the call setup duplicates without a cross_jump merge).
     * FLAG/VERSION AXIS RE-LADDERED on THIS basin (04Z): default best -- cc1_ver 2.7.2 30,
     * 2.7.2-970404 12, 2.6.3 36, 2.8.1 == default, -fno-schedule-insns2 14,
     * -mno-split-addresses 4 @64/64 (count-exact but it un-splits the `la _first_devname`
     * macro, so the jal can no longer sit between its halves = 2 NEW diffs for 2 old ones).
     * W62-A7 (2026-08-15): 2 -> 0, SEALED.  BOTH residuals were the SAME mechanism and
     * both were reachable -- 13B, reorg.c:685-712 `stop_search_p` returns 1 at ANY asm:
     *  (1) the read-only `state` fence below was sitting at the MERGE POINT, i.e. it was
     *      the FIRST insn of the zero-trip guard's BRANCH-TARGET thread (the cc1 .s shows
     *      `$L24: #APP #NO_APP move $4,$18`), so it was blocking the very steal retail
     *      makes.  Moving it INSIDE the guard keeps its +1 ref (same loop depth, so the
     *      $s2/$s3 coloring is unchanged) and frees the target-thread steal: 2 -> 1.
     *      Measured positions: above the guard 2, after `saved = _first_save` 2, both
     *      sites 18 -- only the in-guard position pays.
     *  (2) the name test's slot: a void fence at its FALL-THROUGH head stops our reorg
     *      stealing the `lui %hi(_first_devname)` half into it: 1 -> 0.  The identical
     *      nesting WITHOUT the fence still measures 1, so the fence is the lever.
     *      Naming the devname address in a local instead 21.
     * LAW (belt-wide): a ref-buying fence and reorg's thread choice are the SAME dial --
     * price a fence's POSITION against every branch whose thread it heads. */
    if (*state == 0)
        *state = 1;
    cnt  = (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(DCB);
    e    = BIOS_DCB_BASE;
    saved = _first_save;
    /* MATCH (w48-a7): the oracle computes the table end into a CALLER-saved temp, tests THAT in
     * the zero-trip guard, and only copies it into the callee-saved loop bound inside the guard
     * (`addu $v1,$s0,$v0; sltu $v0,$s0,$v1; beqz $v0,..; addu $s1,$v1,$zero`).  The copy survives
     * because the destination outlives its source (make_regs_eqv); computing straight into `end`
     * coalesces it away. */
    lim  = e + cnt;
    if (e < lim) {
        /* MATCH (w59-a13 + w62-a7): read-only fence = +1 ref on `state`, which raises
         * its allocno priority back above `saved`'s and restores retail's $s2=state /
         * $s3=saved roles (without it the late `saved` assignment colours them the
         * other way round: 20 diffs).  Zero insns; must list `state` ONLY -- a second
         * operand costs 16 more diffs.  W62-A7 moved it INSIDE the guard: at the merge
         * point it was the first insn of the zero-trip branch's TARGET thread and
         * blocked reorg's steal (see the header note). */
        __asm__("" : : "r"(state));
        end = lim;
scan:
        /* MATCH (w62-a7): 2 -> 0.  The void fence is a SLOT-THEFT BLOCKER at the
         * FALL-THROUGH head of the name test (13B / reorg.c:685-712 stop_search_p
         * returns 1 at ANY asm): retail leaves this beqz $a0 slot EMPTY, ours stole
         * the lui $5,%hi(_first_devname) half of the strcmp arg setup into it.  It is
         * inside the && (a statement-expression) so the source SHAPE is unchanged --
         * the same nesting WITHOUT the fence still measures 1, i.e. the fence is the
         * lever, not the restructure.  Zero insns. */
        if (e->name != 0 && ({ __asm__("" : : "i"(0));
                               strcmp(e->name, _first_devname); }) == 0) {
            e->firstfile = (void *)saved;   /* un-patch (one-shot) */
        } else {
            e++;
            if (e < end) goto scan;
        }
    }
    return (*_first_save)(state, arg, arg2);   /* forward $a2=$s5 too (oracle @0x8010a034); re-reads the global fresh */
}
