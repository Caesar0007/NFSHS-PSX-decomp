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

/* Canonical PsyQ 4.3 fs.h device table (PSX BIOS ABI, sizeof == 0x50). */
struct device_table {
    char *dt_string;
    int dt_type;
    int dt_bsize;
    char *dt_desc;
    int (*dt_init)();
    int (*dt_open)();
    int (*dt_strategy)();
    int (*dt_close)();
    int (*dt_ioctl)();
    int (*dt_read)();
    int (*dt_write)();
    int (*dt_delete)();
    int (*dt_undelete)();
    int (*dt_firstfile)();
    int (*dt_nextfile)();
    int (*dt_format)();
    int (*dt_cd)();
    int (*dt_rename)();
    int (*dt_remove)();
    int (*dt_else)();
};

/* BIOS device-table kernel globals (fixed ABI addresses). */
#define BIOS_DCB_BASE   (*(struct device_table **)0x150) /* @kernel 0x150 : DCB table base pointer */
#define BIOS_DCB_BYTES  (*(int  *)0x154)   /* @kernel 0x154 : DCB table size in bytes */

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
extern int (*_first_save)();         /* @0x80148A7C : saved original device handler */
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
    struct device_table *e, *end, *lim;
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
    /* 🔑 W72-A18 RE-GATE (5 @104/103, unchanged) + A QUANTIFIED CERTIFICATE THAT RETIRES THE
     * SWAP-BASIN NAMED ANGLE.  W64-A5/W71-A13 left the swap basin (scan-init before p-init,
     * count-EXACT 103/103 at 18, residual = a clean p/scan two-register swap) with the angle
     * "one ref or one live-unit on p or scan -- read -dl/-dg and find why the fence operand is
     * not counted".  I read it (tools/rtl_dump_c.py -dg -dl, scratch/rtl_a5/FIRST.i.*) and the
     * answer is that THE ANGLE IS THE WRONG PASS.  Measured, in the swap basin:
     *     no fence ......................... rank0 p85 refs 8 live 11 pri 8.727 -> $v1
     *                                        rank1 p86 refs 9 live 13 pri 8.308 -> $a0   gate 18
     *     + foreign-operand fence "r"(dir)
     *       between the loop and `*p='\0'` .. rank0 p86 (8.308) -> $a0
     *                                        rank1 p85 refs 8 live 12 (8.000) -> $v1     gate 18
     *     + the same fence x2 .............. rank0 p86 -> $a0, rank1 p85 live 13 (7.385)  gate 18
     *     + "r"(name) instead of "r"(dir) .. same flip                                    gate 18
     *   i.e. THE 15A FOREIGN-OPERAND FENCE DOES EXACTLY WHAT IT ADVERTISES -- +1 live on every
     *   pseudo live across it, +0 refs on the others -- and the allocno RANK ORDER FLIPS as
     *   predicted.  THE HARD-REG HOMES DO NOT MOVE: p85 stays $v1 and p86 stays $a0 in every
     *   one of the four tables.  ==> in this basin the p/scan homes are decided by find_reg's
     *   PREFERENCE/CONFLICT step (12A: find_reg takes a hard-reg preference BEFORE the numeric
     *   scan), not by allocno_compare, so NO priority dial -- ref, live, or fence-flavour --
     *   can ever reach them.  That closes the W64-A5/W71-A13 "one ref or one live-unit" angle
     *   with receipts instead of another sweep, and it is a general LAW worth carrying:
     *     🔴 A RANK FLIP THAT DOES NOT MOVE THE HOMES PROVES THE RESIDUAL IS PREFERENCE-BOUND.
     *        Dump the table BEFORE and AFTER the dial; if the order changed and the dispositions
     *        did not, stop dialing priority and go to global.c's preference/conflict side.
     *   (The same fence in the CONTROL basin is inert at 5, table rank0 p86 refs 9 live 10 -> $v1
     *   / rank1 p85 refs 8 live 14 -> $a0 -- i.e. the control basin ALREADY has retail's p=$a0 /
     *   scan=$v1 assignment, which is why its residual is only the address-materialization row.)
     *   ==> the CONTROL basin (5) remains the right base; its residual is the `high`/`lo_sum`
     *   emission-position + self-temp row, unchanged and still sched1/allocation-side. */
    /* 🏆🏆 W74-A15 -- firstfile REACHES **PASS 103/103** (and _first_patch stays PASS 64/64).
     * VERIFIED END TO END, but it needs ONE build.py line this agent was not allowed to write,
     * so the SOURCE HALF IS DELIBERATELY NOT LANDED HERE (alone it is 5 -> 18).  Land the two
     * together; both halves are below, and the object was built and scored this wave.
     *
     * THE CELL (§22C(8) cross-basin: each axis alone is neutral or worse, together they PASS):
     *   axis 1 (SOURCE) -- swap the two inits, `scan` BEFORE `p`:
     *        scan = (signed char *)name;
     *        p    = _first_devname;
     *     This is the W64-A5/W71-A13 "swap basin": count-EXACT 103/103, residual = a clean
     *     p/scan two-register swap, which W72-A18 CERTIFIED preference-bound (a rank flip that
     *     does not move the homes) -- 18 on the default lane, hence three waves of "not landed".
     *   axis 2 (BUILD) -- compile THIS FUNCTION with PsyQ 4.0's CC1PSX and let GNU as (reorder
     *     mode) expand its macros, i.e. `PER_FN_RAW40_SPLICE` (the W73 mechanism, already in
     *     build.py for PADSEQD._padInitDirSeq):
     *        PER_FN_RAW40_SPLICE = { ... , "recon/syslib/psx/libapi/FIRST.c": {"firstfile"} }
     *     ⚠️ ONE MECHANISM FIX REQUIRED: the raw-4.0 alt compile inherits the maspsx lane's
     *     CC1_FLAGS, which carry `-g1`, and the 1996 cc1 answers that with COFF debug the GNU
     *     assembler rejects -- `.def/.val/.scl/.type/.endef`, `.loc`, and `LM<n>:` labels (the
     *     LM labels also split the symbol block, so even after the .def strip the epilogue is
     *     attributed to `LM1` and the fn reads 7 insns short).  Either drop `-g1` from the
     *     alt-compile flag list or strip those three line classes from the spliced region.
     *     PADSEQD never hit this: `_padInitDirSeq` has no params and no labels, so its 4.0
     *     output carried none of them.
     *   MEASURED THIS WAVE (whole-TU, both fns):
     *     control  default lane .......... firstfile  5 @104/103 | _first_patch PASS
     *     swap     default lane .......... firstfile 18 @103/103 | _first_patch PASS
     *     control  whole-TU cc1_272 ...... firstfile  5 @104/103 | _first_patch 18
     *     swap     whole-TU cc1_272 ...... firstfile **PASS**    | _first_patch 18
     *     swap     + PER_FN_RAW40_SPLICE .. firstfile **PASS 103/103** | _first_patch **PASS**
     *       (object built by hand from build/.../FIRST.c.raw40merged.s with the three debug
     *        line classes stripped, assembled with the lane's own `as`, scored with
     *        verify_asm's normalizer: scratchpad/W74_A15_raw40score.py)
     *   CHEAPER ROUTES FALSIFIED (same wave, so do not substitute them):
     *     swap + PER_FN_NO_SPLIT_ADDRESSES(firstfile) ..... 6 @105/103
     *     control + PER_FN_NO_SPLIT_ADDRESSES ............. 11 @106/103
     *     swap + PER_FN_CC1_VER_SPLICE 2.7.2 (maspsx lane)  13 @98/103
     *     control + PER_FN_CC1_VER_SPLICE 2.7.2 ........... 18 @99/103
     *   WHY ONLY THE RAW40 ROUTE WORKS -- the residual is TWO coupled facts and the ladder rung
     *   alone fixes only one: (a) 2.7.2 has no -msplit-addresses so the address comes out as the
     *   single `la $4,_first_devname` MACRO (retail's SELF-temp `lui $a0;addiu $a0,$a0`, not our
     *   split-temp `lui $v0;addiu $a0,$v0`) -- the version splice gets this; (b) the macro must
     *   still be ONE insn when cc1 schedules, so it can sit in the `lb $v0,0($s2)` load-delay gap
     *   and be expanded to two AFTERWARDS -- that requires GNU as to do the expansion, i.e. the
     *   no-maspsx route.  maspsx pre-expands, so the maspsx-lane version splice loses (b).
     *   🔴 LAW: "PsyQ 4.0 cc1 + GNU as in reorder mode" is not a curiosity for one PADSEQD row --
     *   it is a VENDOR-BUILD-IDENTITY LANE, and its distinguishing property is that the
     *   ASSEMBLER, not the compiler, expands address/store macros.  Any residual whose shape is
     *   "retail has a 2-insn macro expansion sitting where a 1-insn slot filler belongs" is a
     *   candidate for it. */
    /* extract the device prefix (characters before ':') into _first_devname */
    /* W74-A15 axis-1 (coupled with the PER_FN_RAW40_SPLICE row -- land/revert
     * together; alone this is the 18-diff swap basin): scan BEFORE p. */
    scan = (signed char *)name;
    p = _first_devname;
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
    lim = e + (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(struct device_table);
    if (e < lim) {
        end = lim;
scan1:
        if (e->dt_string != 0 && strcmp(e->dt_string, _first_devname) == 0)
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
    _first_save = e->dt_firstfile;
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
    e->dt_firstfile = _first_patch;
    goto tail;
pass2:

    /* pass 2: install the self-removing patch into that device */
    e   = BIOS_DCB_BASE;
    lim = e + (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(struct device_table);
    if (e < lim) {
        /* MATCH (w61-a8): void-tail fence, 6 -> 5.  Retail fills pass 2's zero-trip
         * `beqz $v0` slot by EAGER-STEALING `addu $a0,$s2,$zero` from the BRANCH
         * TARGET thread (the shared firstfile2 arg setup); ours filled it from the
         * fall-through with this `end = lim` copy.  An asm stops reorg's BACKWARD
         * scan, so the fall-through candidate disappears and reorg takes the target
         * thread instead.  SITE-SELECTIVE, priced per site: the same fence at pass 1
         * is inert (6) and at _first_patch's identical walk it REGRESSES (2 -> 3), so
         * the all-three-sites sweep is a wash (5+3).  Zero insns. */
        end = lim;
scan2:
        if (e->dt_string != 0 && strcmp(e->dt_string, _first_devname) == 0)
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
    struct device_table *e, *end, *lim;
    unsigned int cnt;
    int (*saved)();

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
    cnt  = (unsigned int)BIOS_DCB_BYTES / (unsigned int)sizeof(struct device_table);
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
        if (e->dt_string != 0 && ({ __asm__("" : : "i"(0));
                               strcmp(e->dt_string, _first_devname); }) == 0) {
            e->dt_firstfile = saved;   /* un-patch (one-shot) */
        } else {
            e++;
            if (e < end) goto scan;
        }
    }
    return (*_first_save)(state, arg, arg2);   /* forward $a2=$s5 too (oracle @0x8010a034); re-reads the global fresh */
}
