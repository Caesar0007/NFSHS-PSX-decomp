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

/* W65-A6 DATA-MAT: `_first_save` (6 reloc sites) and `_first_devname` (8) were extern-only
 * tree-wide -- FIRST.obj is their only referencer and their only possible owner.  Both are
 * genuine BSS: their VAs are > t_addr+t_size (0x8013E000), so no file bytes, pure zero-init.
 * Contiguous run, sizes from the SYM/symbol_addrs VA deltas:
 *      _first_save    @0x80148A7C  8   (= _first_devname - _first_save)
 *      _first_devname @0x80148A84 40   (= _waitTime @0x80148AAC - 0x80148A84; libpad PAD.c
 *                                       owns _waitTime, so this run ends there)
 * DEVICE = file-scope asm `.section .bss` block with the C view left `extern` -- byte-neutral
 * by construction, and required because `_first_devname` is declared as an UNSIZED array (a
 * documented codegen lever, methodology 3.12 #5) that a sized C definition would disturb.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\t_first_save\n\t.globl\t_first_devname\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "_first_save:\n\t.space\t8\n"
        "_first_devname:\n\t.space\t40\n\t.text");
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

    /* W63-A6 re-gate: the basin has MOVED since the w59-a13 note below -- it is now
     * 5 diffs at ours 104 / oracle 103 (1 LONG), and the whole residual is residual (1):
     *     ours    ... addu s3,a1 | lui v0 ; addiu a0,v0 | sw ra ; sw s1 ; sw s0 ; lb v0,0(s2) ; NOP
     *     retail  ... addu s3,a1 | sw ra ; sw s1 ; sw s0 ; lb v0,0(s2) ; lui a0 ; addiu a0,a0
     * i.e. ours issues the address pair ABOVE the callee-save store group and through a
     * SEPARATE scratch, leaving the lb's load-delay slot empty; retail issues a SELF-temp
     * pair after the lb and fills that slot with its `lui`.  Residual (2) (the zero-trip
     * guard's eager steal) is GONE on this basin.
     * FALSIFIED W63-A6, all gated + reverted (scratchpad/w63a6/probe_first*.py):
     *  - the W43 ARRAY-DECAY-vs-&SCALAR law, which is what the symptom looks like: a
     *    second file-scope `extern char _first_devname_h __asm__("_first_devname");`
     *    view used only here (`p = &_first_devname_h;`) = 5, with a `(char *)` cast = 5,
     *    `&_first_devname[0]` = 5.  The loop site keeps the unsized form regardless.
     *  - identity fence on `p` = 5, read-only fence on `p` = 5.
     *  - fence POSITION sweep: void fence as the first statement 5, read-only fence on
     *    (name,dir) first 5, void fence between the two inits 5, void fence after
     *    `scan = name` 8 @105.
     *  - `scan` before `p` re-tested on THIS basin (04Z): 18 but COUNT-EXACT 103/103 --
     *    it does fill the slot, at the price of swapping p/scan's registers ($a0<->$v1)
     *    through the whole prefix loop.  NAMED ANGLE: that count-exact basin plus a
     *    p/scan coloring dial is the only structurally-right route seen so far. */
    /* W64-A5 re-gate + PRICING of the named angle above (still 5 @104/103).  The
     * `scan`-before-`p` basin is count-EXACT 103/103 at 18 and its residual is a clean
     * TWO-REGISTER swap: retail scan=$v1 / p=$a0, ours p=$v1 / scan=$a0.  Both are global
     * allocnos and priced off .greg (qty272): p (p78) refs 9 / live 12 = 2.2500 is allocated
     * FIRST and takes $v1; scan (p77) refs 8 / live 11 = 2.1818 gets $a0.  They conflict, so
     * whoever ranks first takes the lower reg -- the flip needs scan ABOVE p, i.e. scan
     * refs 8->9, or scan live 11->10, or p refs 9->8 / live 12->13.
     * FALSIFIED W64-A5 (every one measured, all in the swap basin, all count-EXACT 103): a
     * read-only fence on `scan` or on `p` or on `name` placed after the prefix loop, before
     * the terminator store, or after it -- ALL INERT at 18 (the operands do not move the .greg table);
     * 1- and 2-operand forms identical; in the ctl basin the same fences are inert at 5.
     * Only the fence placed BETWEEN the two inits costs instructions (8 @105).
     * NAMED ANGLE (sharpened): the dial is one ref or one live-unit on a pseudo whose refs the
     * fence provably fails to change -- read `-dl`/`-dg` on the swap basin and find WHY the
     * asm operand is not counted (candidate: the operand is a copy cse folds back into `name`,
     * so the ref lands on p73/name, not on p77).  That is a 1-run instrument question, not a
     * spelling sweep. */
    /* 🔑 W71-A13 RE-GATE (5 @104/103) + THE MECHANISM OF RESIDUAL (1), read off the -dg RTL.
     * The whole residual is ONE row: ours `lui $v0,%hi; addiu $a0,$v0,%lo` ABOVE the callee-save
     * store group and a `nop` after `lb $v0,0($s2)`; retail `lb`, then `lui $a0,%hi; addiu
     * $a0,$a0,%lo` (self-temp) filling that load's delay.
     * -dg shows the split-address pair as TWO insns before the lb:
     *     (insn 12 (set (reg 2 v0) (high (symbol_ref "_first_devname"))))
     *     (insn 13 (set (reg/v 4 a0) (lo_sum (reg 2 v0) (symbol_ref ...))))
     *     (insn 247 (set (reg 2 v0) (sign_extend (mem (reg 18 s2)))))   <- the lb
     * i.e. the ORDER is already fixed before reload, and the `high` pseudo is a separate qty
     * (that is also why the pair is split-temp `$v0`->`$a0` instead of retail's self-temp).
     * ⚠️ `-mno-split-addresses` does NOT fix it (I checked the raw .s, contradicting a plausible
     * reading of the w59 note): the single `la $4,_first_devname` macro is STILL emitted above
     * the lb, the `#nop` stays, and the flag costs `_first_patch` its PASS -- whole-TU probe
     * (in-memory PER_TU hook) firstfile 11 @106/103, _first_patch PASS -> 3.
     * FALSIFIED THIS WAVE (all whole-TU gated, restored):
     *   swap the two inits (the count-EXACT 103/103 basin) ............... 18
     *     + read-only fence on `scan` right after its def ................ 18 (inert)
     *     + read-only fence on `scan` INSIDE the loop body ............... 18 (inert)
     *     + read-only fence on `scan` AFTER the `p` init ................. 8  @105  <- best swap-
     *       basin dial found (the p/scan coloring flips) but 2 insns LONG, so still > 5
     *   index-form prefix copy (`_first_devname[n]`, pointer only at the end) ... 31
     *   index-form with `p` dropped entirely ............................. 31
     *   peeled `if (*scan > ':') do {...} while (...)` .................... 18
     *   `"m"(*_first_devname)` fence after the p init 5 (inert) / before it 6
     *   read-only fence on `p` right after its def ....................... 5  (inert)
     *   read-only fence on `name` after both inits ....................... 8
     * NAMED ANGLE (unchanged in kind, sharper): the lever must move insn 12/13 BELOW the lb in
     * sched1's order without adding a pseudo; the only two handles left are a per-fn scheduler
     * flag/rung (build-side) and an instrument read of sched1's ready list (`-dS`) to find which
     * priority input puts the `high` ahead of the load chain. */
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
