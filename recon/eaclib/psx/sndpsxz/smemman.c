/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: identity = gcc-2.8.0 + maspsx (the DEFAULT lane).  UNCHANGED source;
 * forced-2.8.0 = CONTROL (the lane also swaps the assembler route).
 *
 *   lane            iSNDmalloc
 *   default          6 (135/135)
 *   2.6.0          101 (140/135)
 *   2.6.3          101 (140/135)
 *   2.7.2-970404    39 (134/135)
 *   2.7.2           98 (137/135)
 *   2.8.0 CONTROL    6 (135/135)
 *   2.8.1            6 (135/135)
 *   2.91.66        118 (133/135)
 *   2.95.2         127 (138/135)
 *
 * READING: extends the w33-a7 note's "compiler axis closed here too (2.8.1 byte-identical,
 * 2.7.2 = 134 @123)" from 2 generations to the FULL 8-rung ladder -- nothing beats 2.8.0.
 * The 6-diff residual (a $v1 -> $a2 swap on the 3-insn `addu/lhu/lhu` address chain at
 * idx 45-47, count-exact) stands as an allocator-coalescing residual.
 */
/* eaclib/psx/sndpsxz/smemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 PASS (TU SEALED w53-a11) ***
 *   Source obj : nfs4\eaclib\psx\smemman.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x801061A8 .. 0x80106238].  The sound system's main-RAM sub-allocator (the `sndmm` pool the
 *   game hands SNDSYS_init) -- a sorted first-fit free-list of up to 128 {block,size} word entries.
 *   Ghidra nfs4-f.exe.c (smemman) + disasm note: iSNDmalloc's shift loop is a lwl/lwr+swl/swr unaligned
 *   4-byte entry copy (Ghidra mangled the swl/swr into a bit-twiddle + emitted the aligned store -> keep
 *   the plain copy, drop the bit-twiddle), exactly as sdmemman.
 *
 *   Globals: sndmm = pool byte base, DAT_80148784 = live entry count, DAT_80148786 = pool size in WORDS,
 *            DAT_80148788 = high-water mark (words), DAT_8014878c = {block:u16, size:u16}[] entry table.
 */

/* {block,size} free-list entry -- 2-byte alignment is LOAD-BEARING (struct assignment on an
 * align-2 4-byte struct = the oracle's lwl/lwr+swl/swr unaligned word copy). */
typedef struct SndMemEnt {
    unsigned short blk, sz;
} SndMemEnt;

typedef struct SNDMemState {
    int            base;                /* +0x00 pool byte address */
    unsigned short count;               /* +0x04 live allocation count */
    unsigned short poolWords;           /* +0x06 pool size in words */
    int            highWater;           /* +0x08 high-water mark */
    SndMemEnt      entries[128];         /* +0x0c sorted allocation table */
} SNDMemState;
extern SNDMemState sndmm;
/* W65-A6 DATA-MAT: `sndmm` was extern-only tree-wide (13 reloc-referenced undefined sites).
 * Retail: .bss @0x80148780 (VA > t_addr+t_size 0x8013E000 => no file bytes, pure zero-init).
 * smemman.obj owns it (sole referencer besides its own asm-label alias `sndmm_b`).
 * Size = sizeof(SNDMemState) = 524, the oracle-derived struct above; the VA delta to the next
 * known symbol (drv.c's D_8014899C @0x8014899C) is 540, so 16 trailing bytes of that gap are
 * unattributed -- recorded, not invented.
 * A C tentative definition is correct HERE (unlike sndgs/sndpd): the type is COMPLETE and
 * identical to the existing extern declaration, so nothing about address materialization can
 * move, and 524 > the TU's -G4 so maspsx routes it to `.section .bss` + `.globl` (a `.comm`
 * of size <= -G would land in `.sbss` as a LOCAL symbol and fix nothing).  4/4 PASS unchanged. */
SNDMemState sndmm;                  /* @0x80148780 [BSS] definition */
/* UNSIZED-ARRAY VIEW of the same storage (asm-label alias): an unsized `unsigned char[]`
 * makes gcc materialize each `sndmm_b + K` as the FUSED high(sym+K)/lo_sum pair, so the two
 * distinct table bases (+8 and +0xC, splat D_80148788 / D_8014878C) cannot share one hoisted
 * `lui %hi(sndmm)`. */
extern unsigned char sndmm_b[] __asm__("sndmm");

#define DAT_80148784 (sndmm.count)
#define DAT_80148786 (sndmm.poolWords)
#define DAT_80148788 (sndmm.highWater)
#define DAT_8014878c (sndmm.entries[0].blk)
extern void           trap(unsigned int code);

extern void iSNDmemconstrain(int *block, int *size);   /* @0x801061A8 */
extern int *iSNDmeminit(int membase, int memsize);     /* @0x801061D4 */
extern unsigned int iSNDmemrestore(void);              /* @0x801061F4 */
extern int  iSNDmalloc(int size);                      /* @0x80106238 */

/* iSNDmemconstrain @0x801061A8 : clamp a candidate [block, size] so block+size stays within the pool top.
 *   Its true contract is void; the subtraction left in v0 on the clamp path is incidental. */
extern void iSNDmemconstrain(int *block, int *size)
{
    unsigned int top = (unsigned short)DAT_80148786;
    int start = *block;
    if ((int)top < start + *size)
        *size = (int)top - start;
}

/* iSNDmeminit @0x801061D4 : (re)initialise the pool over `memsize` bytes at `membase`. */
extern int *iSNDmeminit(int membase, int memsize)
{
    char *mm;
    sndmm.base = membase;
    mm = (char *)&sndmm;
    *(short *)(mm + 4) = 0;
    *(short *)(mm + 6) = (short)(memsize >> 2);
    *(int *)(mm + 8) = 0;
    return (int *)mm;
}

/* iSNDmemrestore @0x801061F4 : return pool utilisation percent = high_water*100/poolsize.
 *   The unsigned divide auto-emits the BREAK 0x1c00 div-by-zero guard (oracle 0x80106228),
 *   so the trap only fires when the pool was never initialised (poolsize==0). */
extern unsigned int iSNDmemrestore(void)
{
    /* high-water (+8) and poolsize (+6) are fields of the sndmm struct @0x80148780; read both off the
     * single `&sndmm` base (lui;addiu materialized once, CSE'd) to match the oracle's `lw 8(a0)/lhu 6(a0)`
     * rather than two separate absolute DAT_ loads. */
    char          *mm = (char *)&sndmm;
    int            hw = *(int *)(mm + 8);
    unsigned short ps = *(unsigned short *)(mm + 6);
    return (unsigned int)(hw * 100) / (unsigned int)ps;
}

/* iSNDmalloc @0x80106238 : first-fit allocate `size` bytes (rounded to words) from the sndmm pool,
 *   inserting the new {block,size} entry in sorted order.  Returns the byte address or 0 on failure.
 * RAW/ORACLE (2026-07-26, 134->106 detailed diffs): keep the table scan indexed from distinct
 * `sndmm+0xc` entry and `sndmm+8` previous-entry bases, and express the packed shift as memcpy.
 * This restores the oracle's saved-register family and direct lwl/lwr/swl/swr copy sequence.
 * W32-a7 (88->86 diffs, 129->127 insns): the `i != 0` scan arm is now INSTRUCTION-EXACT against the
 * oracle (load-before-store, see below) -- only a $v0/$v1 register swap remains there.
 *
 * 🔴 ALLOCNO FLOOR [W35-a3: FIRST HALF WITHDRAWN, see the W35 block at the end of this comment],
 * shared with sdmemman.c iSNDpsxmalloc: in BOTH the `i != 0` arm and the post-scan
 * tail the oracle colors the {prev[0]+prev[1]} sum into $v0 and the {limit - sum} difference into
 * $v1; ours colors them exactly the other way.  The cause is upstream: retail keeps the entry byte
 * offset `i*4` in $v0 and ours in $a0, because our `j` is ALSO the shift-loop counter and that
 * counter's `lhu $a0,4($s1)` drags the fused pseudo into $a0.  Splitting them into two locals (the
 * textbook catalog sec-A fix) makes it far WORSE (86 -> 131 diffs): the reuse IS the retail shape,
 * so the two live ranges must stay fused and the register they land in is then the allocator's call.
 * [W35-a3: FALSE.  The split is the RIGHT shape -- it just needs a giv blocker of its own, which
 *  is what the reuse had been doing by accident.  See lever (4) below: split + a DEAD-SET carrier
 *  puts `i*4` in retail's $v0 in every one of its four sites.]
 * Consequence: retail's post-scan tail keeps its OWN `jal iSNDmemconstrain` + tail (`sw $v1,0x14($sp)`
 * differs from the empty arm's `sw $v0,..`), while ours cross-jumps into the empty arm's call because
 * both arms end in the same hard register -- that alone is 5 of the 8 missing instructions.
 * W33-a7 (2026-07-26): SLD cannot adjudicate this obj either -- ZERO line records across the whole
 * sndpsxz span (proof + the pad.c consequence in sdmemman.c's header).  Compiler axis closed here
 * too: gcc 2.8.1 output is BYTE-IDENTICAL to our 2.8.0 (86 both), gcc 2.7.2 is 134 diffs @123 insns.
 * Flag axis: the only flag that lowers the count is -fno-expensive-optimizations (82) and it does so
 * by ADDING two instructions (129 vs 127) -- a worse fit, not a better one; every other flag is >=
 * baseline.  Four more spellings of the post-scan tail's {block,available} build were tried (limit
 * loaded into its own local first; `block = p2[0]; block += p2[1];` accumulation; available-before-
 * block; the sum recomputed twice) -> 86 / 91 / 90 / 93, i.e. NONE beats this body and none flips
 * the $v0/$v1 pair whose coloring is what lets our two constrain arms cross-jump-merge.
 * Re-audited against the wave's three-way copy taxonomy: there is NO cse.c double-evaluation target
 * here (the only retail-only "copies" in the diff are three `addu $v0,$zero,$zero` return-zero
 * setups, not value copies), and no loop.c giv-anchor target (the 4-byte entry stride is a power of
 * two, but retail emits a per-iteration sll+addu, not a strength-reduced walker -- the multiply-set
 * offset blocker already in this body IS the retail shape).  Conceded to true allocator coalescing.
 * Also tried and REVERTED: hoisting `j = i << 2` above the entry guard so one sll serves the loop
 * preheader and the tail (retail's `sll $v0,$s0,2` in the guard delay slot is reorg's `redundant_insn`
 * unification of two same-register slls, NOT a shared source expression) -- gcc const-folds our
 * pre-guard `i<<2` to `move rD,zero` since i==0 there, 98 diffs.
 * W34-a7: the NFS2 PC-beta named-source lever does NOT reach this obj either -- NFS2-PC has no sound
 * sub-pool allocator at all and memman.obj is a linked mem-class/mem-block manager, a different data
 * structure (full verdict + the INDEX.csv sweep in sdmemman.c's header).  Two more attempts at the
 * "one `sll` serves the loop back-edge AND the post-scan tail" unification (the oracle's `sll $v0,
 * $s0,2` in the .L80106378 delay slot feeds .L8010638C's `addu $a2,$v0,$v1`, while ours computes a
 * DEAD `sll $a0,$s0,2` in the slot and recomputes `sll $v0,$s0,2` in the tail) were made and
 * REVERTED: (i) tail spelled `j = i << 2; p2 = j + pb;` so both sites write the SAME variable and
 * reorg's `redundant_insn` could unify them -> 91 diffs / 128 insns; (ii) moving `j = i << 2` BELOW
 * the `i++` so the induction shift is live out of the loop and the tail just uses `j` (retail's exact
 * dataflow) -> 93 diffs / 128 insns, because gcc const-folds the pre-loop seed to `move rD,zero`
 * exactly as the earlier hoist attempt did.  The unification is register-equality-gated and the
 * register is decided by the same $v0/$v1 mirror as the rest of this floor.
 *
 * 🟢🟢 W35-a3 (2026-07-26): 86 -> 52 diffs, 127 -> 137 insns (oracle 135).  THE ABOVE "5-of-8
 * missing instructions is an allocno floor" VERDICT IS WITHDRAWN -- it was a RETURN-STATEMENT
 * PLACEMENT problem, not a coloring one, and the whole 8-instruction gap plus most of the diff
 * mass came off with three source-shape levers:
 *   (1) 🔑 EXPLICIT `fail:` BLOCK PLACED PHYSICALLY LAST (86 -> 74, 127 -> 137 insns).  Retail has
 *       THREE distinct return-0 exits: the count guard branches to a cold one-insn block AFTER
 *       commit (.L80106430 `addu $v0,$zero,$zero`), the empty arm zeroes $v0 in its own `beqz`
 *       DELAY SLOT and `j`s to the epilogue, and the post-scan `bnez`es straight to the epilogue
 *       with the zero in ITS delay slot.  Three textual `return 0;` statements give gcc three
 *       byte-identical tails that jump.c cross-jump-MERGES, which is what collapsed our post-scan
 *       into the empty arm's `jal`+check (the 5 "missing" instructions) and what forced the wrong
 *       `beqz` delay-slot filler.  Writing all three as `goto fail;` with ONE `fail: return 0;`
 *       after the commit block removes the merge candidate entirely and reproduces retail's layout.
 *   (2) 🔑 INDEX-FIRST STATEMENT ORDER in `commit` (74 -> 67, 137 -> 136).  reorg STEALS a branch
 *       target's first instruction into the predecessors' delay slots when that instruction's dest
 *       is dead on the fall-through path.  Our commit block opened with the `lui %hi(sndmm)` (dest
 *       $v1, dead on every fall-through) so ALL THREE predecessors' slots got a copy of it and the
 *       block kept only the `addiu %lo` -- 4 materialization insns instead of retail's 2, and it
 *       displaced the real fillers.  Retail's commit opens with `sll $a0,$s0,2` whose dest $a0 IS
 *       live on the shift-loop fall-through, so the steal is ILLEGAL there and reorg falls back to
 *       the fall-through thread (`sll $v1,$a0,2`, `addu $v0,$zero,$zero`).  Hoisting `int off =
 *       i << 2;` to be the block's FIRST statement reproduces that exactly.
 *   (3) 🔑 DEAD-VAR REPURPOSE for the state base (67 -> 52): retail reuses the now-dead ENTRY
 *       pointer's register for `&sndmm` (`addiu $a1,$v1,-0xC`), not a fresh temp.  Re-assigning the
 *       `entry` variable instead of introducing `cb` makes the ENTIRE commit block byte-exact,
 *       including the oracle's load-delay `nop` after `lhu $v0,4($a1)`.
 *   Supporting shape change: `sndmm_b[]`, an unsized-array asm-label VIEW of the same storage, so
 *   the +8 and +0xC bases lower to the FUSED `high(sym+K)` RTL (three distinct high expressions in
 *   `-dl`) instead of one shareable `high(sndmm)`; codegen-neutral on its own but it is what lets
 *   levers (2)/(3) land.  Post-scan index-first (same lever as (2)) moved its base into the oracle's
 *   $v1 and its limit read onto that base (`lhu $v0,-2($v1)`), diff-neutral, shape-correct.
 * RESIDUAL = 2 instructions + the $v0/$v1 mirror inside the two remaining blocks:
 *   (a) `addiu $a0,$sp,0x10` DUPLICATED into the entry-guard delay slot -- the same reorg steal as
 *       (2), but in the post-scan block the first instruction is the sched1-hoisted call-arg setup
 *       (dest $a0, dead on the fall-through).  Retail's post-scan opens with `lui $v1,%hi(...)` and
 *       $v1 holds &sndmm, which the fall-through reads (`addiu $s4,$v1,0xC`), so the steal is
 *       illegal there.  Not reachable by statement order: sched1 floats the dependency-free `addiu
 *       $aN,$sp,K` to the top of the block regardless of source position.
 *   (b) the duplicated `sll $s0,2` (a DEAD one in the loop back-edge slot + a live one in the
 *       post-scan) -- the `j`-live-out unification was RE-TESTED on this new base per the "re-test
 *       shelved leads after a structural fix" rule and is still worse (77 diffs / 138 insns), as is
 *       the pre-guard hoist (98 diffs, unchanged from W33).
 * Flag axis re-probed: `-mno-split-addresses` for this TU is decisively WRONG (91 diffs @136, and
 * it breaks iSNDmemconstrain/iSNDmeminit which currently PASS).
 *
 *   (4) 🔑 COUNTER/OFFSET SPLIT + DEAD-SET CARRIER (52 -> 50 -> 48 with the post-scan spelling).
 *       This RETIRES the "the reuse IS the retail shape" verdict at the top of this comment.  The
 *       W32 experiment that scored 131 split `j` into two locals and nothing else -- which makes the
 *       entry offset SINGLE-SET in the loop, so loop.c classifies it as a giv, strength-reduces it
 *       into a walking pointer and destroys the whole scan.  The multiply-set property was doing
 *       double duty (giv blocker AND register fusion) and only the first half was load-bearing.
 *       W35 lever #2 (movfxya's DEAD-SET carrier) supplies the blocker separately: the shift loop
 *       gets its own counter `k`, and a dead `j = 0;` at the end of the loop body keeps
 *       set_in_loop != 1 (loop.c counts it) while flow deletes it for free -- zero instructions.
 *       RESULT: `i*4` moves from $a0 to retail's $v0 at ALL FOUR of its sites, so the loop head
 *       (`sll $v0,$s0,2` / `addu $a1,$v0,$s4`), the shift-loop exit `j` + delay slot, and the loop
 *       back-edge delay slot are now byte-exact.
 * RESIDUAL after (1)-(4) = 2 instructions, and they are ONE cause: reorg's steal of the post-scan
 * block's first instruction.  Retail's post-scan opens with `sll $v0,$s0,2`, which reorg then
 * distributes into BOTH of its predecessors' delay slots (the entry guard at .L801062C0 and the
 * loop back-edge at .L80106384) and deletes from the block -- one instruction serving three places.
 * Ours opens with the sched1-hoisted call-arg setup `addiu $a0,$sp,0x10` instead (call-arg feeders
 * carry sched.c's 0x7f000001 LAUNCH_PRIORITY boost, so they float to the head of any block ending
 * in a `jal`), so the guard's slot gets a DUPLICATE `addiu $a0,$sp,0x10` and the block still has to
 * recompute its own `sll $v0,$s0,2`.  Statement-order levers do not reach it: `int off = i << 2;`
 * as the block's first statement is diff-WORSE here (50 vs 48) because it also moves the post-scan
 * base off retail's $v1, and the `j`-live-out unification -- RE-TESTED a third time now that the
 * registers finally agree -- is still worse (63 diffs @136).
 *
 * 🟢🟢 W49-a7 (2026-08-08): 48 -> 16 diffs, and the insn count is now EXACT 135/135.  The
 *   "statement-order levers do not reach the LAUNCH_PRIORITY float" verdict above is RETIRED -- the
 *   instrument is not statement order, it is the w45 USE FENCE (`__asm__("" : : "r"(x))`, zero
 *   insns on a register-resident value) used as a SCHED-ISSUE-POSITION FIXPOINT.  Three placements,
 *   all load-bearing, each measured on top of the previous one:
 *     (5) POST-SCAN, fence the OFFSET then the BASE (48 -> 24): reuse the dead loop offset `j`
 *         (`j = i << 2;`), fence it, materialize `pb`, fence `pb`, THEN form `p2`.  The first fence
 *         pins the `sll` at the block head so the LAUNCH_PRIORITY-boosted `addiu $a0,$sp,0x10`
 *         can no longer float above it (reorg's steal of the block-head insn into both predecessor
 *         delay slots is what retail shows); the second stops the `%hi/%lo` pair from sinking past
 *         the offset.  Fencing only ONE of the two is worth just 48->40/41.  Reusing `j` instead of
 *         a fresh `off2` local is what lands the exact 135 count (dead-var repurpose, catalog §A).
 *     (6) `i != 0` ARM, fence `j` AFTER the pv add (20 -> 16): retail forms the entry-table address
 *         with a FRESH dest (`addu $a2,$v0,$s3`) while ours mutated the offset register in place
 *         (`addu $v0,$v0,$s3`) -- local-alloc's combine_regs ties the sum's dest to the offset
 *         pseudo because the offset DIES at the add.  A use fence one statement later keeps it live
 *         past the add, combine refuses, and the fresh dest appears.  (This is the general cure for
 *         the "oracle uses a fresh dest, ours mutates the index reg" class; the array-index spellings
 *         `prev + i*2` / `&prev[i*2]` / byte-cast all measure 26, i.e. the w43 ascii2sjis lever's
 *         index form does NOT transfer here.)
 *   RESIDUAL 16, ONE remaining cause: with the fence in place the offset `j` is homed in $a2 where
 *   retail keeps it in $v0 (the extra live range costs it the lowest free reg), so `pv`/`entry`
 *   rotate one slot.  Falsified in this basin: fence AFTER the sum `b` (27 @136), fence at arm end
 *   (26), opacity fence on `pv` (20, no change), fence on `entry` as well (16, no change),
 *   base-first operand order (26), `available`-before-`block` (40 in the post-scan basin).
 *
 * *** W50-A7 (2026-08-09): 16 -> 6 diffs, still count-EXACT 135/135.  TWO levers, both one line:
 *   (7) THIRD USE FENCE, in the POST-SCAN tail: `__asm__("" : : "r"(j))` placed AFTER the
 *       `p2 = j + pb` add -- the exact twin of lever (6) one block up.  Keeping the offset live past
 *       the add makes the sum take retail's FRESH `$a2` (`addu $a2,$v0,$v1`) instead of mutating the
 *       offset register in place (`addu $a2,$a2,$v1`).  16 -> 8.  AND IT PAID TWICE: with the
 *       post-scan add no longer eating the offset register, the WHOLE `j` global moved off `$a2` and
 *       onto retail's `$v0`, fixing both `sll` sites (loop head + loop back-edge) as a side effect --
 *       so the two-wave `sll $a2` vs `sll $v0` residual was never its own defect.  Fencing `p2`
 *       instead of `j` is 30, and fencing both is 30: it is the OFFSET that must survive, not the sum.
 *   (8) LOAD-BEFORE-STORE in the `i == 0` arm (8 -> 6): retail emits `lhu $v0,0($a1)` and only then
 *       `sw $zero,0x10($sp)`; our `block = 0; available = *entry;` order put the store first.  Note
 *       this is the OPPOSITE of the note in the `i != 0` arm -- there the store must come last
 *       because it may-aliases the following load; here nothing aliases and the load simply leads.
 *   RESIDUAL 6 = ONE register: `pv` (the prev-entry address) is `$v1` where retail has `$a2`, so its
 *   two `lhu`s differ too.  Ours lets `pv` die at `lhu $a0,2(pv)` and REUSES $v1 for the entry value
 *   on the very next insn; retail keeps them in separate registers ($a2 / $v1).  Same instruction
 *   sequence, same order, one home.  FALSIFIED IN THIS BASIN (all exactly 6, byte-identical): named
 *   entry-value temp before OR after the sum; split `p0`/`p1` temps; an extra `q` temp; interleaving
 *   the entry load between pv[0] and pv[1]; operand-order swap on the pv add; `unsigned char *`
 *   base; dead-set carriers on `pv` and on `entry`.  WORSE: a use fence on `pv` after the entry read
 *   (28 -- the barrier moves the whole arm), a depth wrapper on the sum (27 @136).
 *   NEXT ANGLE: this is a local_alloc ALLOCATION-ORDER question (which of `pv` and the entry-value
 *   qty is handed a register first), not a live-range or ref question -- every ref/live dial above
 *   measures zero.  Read the block's `-dl` qty table (tools/rtl_dump_c.py + qtyprio.py) and check
 *   the 3-QTY LAW first: if the arm has <= 3 qtys it is hand-rolled, not priority-ordered, and the
 *   dial is crossing the 3<->4 boundary with a DISTINCT temp (the `q`/split probes above added
 *   temps that cse folded, so they never crossed it).
 *   Next angle: a zero-insn dial that lowers whatever pseudo currently occupies $v0 in that block
 *   rather than lengthening `j` (i.e. reach the fresh dest without paying for j's live range). */
extern int iSNDmalloc(int size)
{
    /* MATCH (w31-a2, from the raw oracle -- same shape family as iSNDpsxmalloc but with THREE
     * separate iSNDmemconstrain call sites (gcc merges none of them: the empty arm and the
     * post-scan tail use OPPOSITE branch polarities), the {block,size} entry table at sndmm+0xC,
     * the virtual entry[-1] overlapping the high-water word at sndmm+8, and a commit block that
     * returns pool + block*4 and bumps the high-water mark. */
    int             block;      /* sp+0x10 -- address taken */
    int             available;  /* sp+0x14 -- address taken */
    int             i, j, k;
    unsigned short *entry;
    unsigned short *prev;
    unsigned short *pv;
    unsigned char  *tab;
    unsigned char  *mm;
    unsigned char  *base = (unsigned char *)&sndmm;
    unsigned short  count = *(unsigned short *)(base + 4);

    i = 0;
    if (count >= 0x80)
        goto fail;
    size += 3;
    size >>= 2;
    if (count == 0) {
        block = 0;
        available = *(unsigned short *)(base + 6);
        iSNDmemconstrain(&block, &available);
        if (size <= available)
            goto commit;
        goto fail;
    }
    if (i < (int)*(unsigned short *)(base + 4)) {
        tab = base + 0xc;
        prev = (unsigned short *)(base + 8);
        mm = base;
        do {
            /* the byte offset goes through the MULTIPLY-SET `j` so gcc loop.c never sees a giv
             * (keeps the oracle's per-iteration sll+addu, no strength-reduced walking pointer);
             * index term FIRST in the adds (commutative-order lever). */
            j = i << 2;
            entry = (unsigned short *)(j + (int)tab);
            if (i == 0) {
                /* MATCH (w50-a7): LOAD BEFORE STORE in this arm (the opposite of the note in the
                 * `i != 0` arm below, which is about a may-aliasing store).  Retail emits
                 * `lhu $v0,0($a1); sw $zero,0x10($sp)`; writing `block = 0;` first put the store
                 * ahead of the load.  8 -> 6. */
                available = *entry;
                block = 0;
            } else {
                /* MATCH: compute BOTH values into plain register temps and only then write the
                 * two address-taken frame slots.  Writing `block` first makes gcc treat the
                 * following `*entry` global load as possibly-aliasing, so it cannot be hoisted
                 * into the store's load-delay slot -- ours emitted two nops the oracle does not
                 * have.  The oracle issues all three lhu's up front, then addu/subu, then the
                 * two sw's (catalog sec-F load-before-compute). */
                pv = (unsigned short *)(j + (int)prev);
                /* MATCH (w49-a7): USE FENCE on `j` AFTER the pv add -- keeps the offset live past the
                 * add so combine_regs cannot tie the sum's dest to the dying offset pseudo; the add
                 * takes retail's FRESH dest ($a2) instead of mutating the offset reg in place. */
                __asm__("" : : "r"(j));
                {
                    int b = (int)pv[0] + (int)pv[1];
                    int a = (int)*entry - b;
                    block = b;
                    available = a;
                }
            }
            iSNDmemconstrain(&block, &available);
            if (size <= available) {
                k = *(unsigned short *)(mm + 4);
                while (i < k) {
                    int n;
                    /* struct assignment on the 2-aligned 4-byte entry = the oracle's unaligned
                     * lwl/lwr + swl/swr word copy; `n` keeps the 0xC displacements un-folded. */
                    ((SndMemEnt *)(mm + 0xc))[k] =
                        ((SndMemEnt *)(mm + 0xc))[n = k - 1];
                    k = n;
                }
                goto commit;
            }
            i++;
            /* DEAD-SET CARRIER (W35 lever): `j` is now single-set in the loop once the shift
             * counter moved to `k`, which would let loop.c classify it as a giv and strength-
             * reduce the per-iteration sll+addu into a walking pointer.  This dead store keeps
             * set_in_loop != 1 (loop.c counts it) and flow deletes it for free. */
            j = 0;
        } while (i < (int)*(unsigned short *)(mm + 4));
    }
    {
        /* post-loop tail: fresh block-locals re-materialize the FUSED sndmm+8 symbol (oracle
         * D_80148788); poolWords is read as pb[-1] (offset -2 off it).
         * MATCH (w49-a7, lever 5): the offset REUSES the now-dead loop variable `j` and both it and
         * the base carry a zero-insn USE FENCE, so (a) the `sll` stays at the block head where reorg
         * steals it into both predecessors' delay slots -- the LAUNCH_PRIORITY-boosted call-arg
         * `addiu $a0,$sp,0x10` can no longer float above it -- and (b) the `%hi/%lo` pair cannot sink
         * past the offset.  Both fences are required (one alone = 40/41 vs 24). */
        unsigned short *pb;
        /* *** MATCH (w53-a11, 2026-08-09): 6 -> PASS 135/135.  THE ENTRY POINTER IS ONE
         * FUNCTION-SCOPE VARIABLE SHARED BY THE LOOP ARM AND THIS TAIL -- the tail's own
         * `unsigned short *p2` block-local was the last defect.  MECHANISM (new, generalizes):
         * a pointer used in exactly ONE basic block is a LOCAL quantity, so local_alloc hands
         * it the first free hard reg by the numeric scan ($v1 here) and lets the next,
         * non-overlapping value in the same block REUSE that register.  Writing BOTH sites
         * through the same `pv` makes the pseudo live in TWO blocks => it is a GLOBAL allocno,
         * assigned by global.c AFTER local_alloc has taken $v0/$v1, which lands retail's $a2 --
         * and the `lhu $v0,0($a2)` / `lhu $a0,2($a2)` pair falls out with it.  Cost: zero
         * instructions (both blocks already had the pointer).  The w50-a7 note's "this is a
         * local_alloc ALLOCATION-ORDER question, read the -dl qty table" was right about the
         * pass and wrong about the dial: the fix is not to reorder local_alloc but to LEAVE
         * ITS SCOPE -- promote the pseudo to global by giving it a second block.  Falsified on
         * the way (all 6 or worse, in this basin): opacity fence on `j` before the pv add (6),
         * a distinct opaque 4th qty `q` from `"=r"(q):"0"(j)` (26 -- the 3-QTY-LAW probe), an
         * unused entry-value temp (6).  DO NOT re-split `pv` into a tail-local. */
        j = i << 2;
        __asm__("" : : "r"(j));
        pb = (unsigned short *)(sndmm_b + 8);
        __asm__("" : : "r"(pb));
        pv = (unsigned short *)(j + (int)pb);
        /* MATCH (w50-a7): THIRD use fence, the same lever as the loop's `pv` add one block up --
         * keep `j` live PAST the add so the sum takes retail's FRESH `$a2` (`addu $a2,$v0,$v1`)
         * instead of mutating the offset register in place (`addu $a2,$a2,$v1`).  16 -> 8.
         * Fencing the SUM instead of `j` (or both) is 30 -- it is the OFFSET that must survive. */
        __asm__("" : : "r"(j));
        block = (int)pv[0] + (int)pv[1];
        available = (int)pb[-1] - block;
    }
    iSNDmemconstrain(&block, &available);
    if (available < size)
        goto fail;
    /* fall through into commit (oracle .L801063D4) */
commit:
    {
        /* fused sndmm+0xC table symbol (oracle D_8014878C); the state base is recovered by
         * subtracting 0xC from it, and the pool pointer is read at -0xC off the SAME symbol. */
        int off = i << 2;
        unsigned char *tabsym = sndmm_b + 0xc;
        unsigned char *cb;
        int addr;
        entry = (unsigned short *)(off + (int)tabsym);
        entry[1] = (unsigned short)size;
        entry[0] = (unsigned short)block;
        /* MATCH: retail REUSES the now-dead entry pointer's register for the state base
         * (catalog dead-var repurpose) -- `addiu $a1,$v1,-0xC`, not a fresh temp. */
        entry = (unsigned short *)(tabsym - 0xc);
        cb = (unsigned char *)entry;
        *(unsigned short *)(cb + 4) += 1;
        addr = *(int *)(tabsym - 0xc) + block * 4;
        if (*(int *)(cb + 8) < block + size)
            *(int *)(cb + 8) = block + size;
        return addr;
    }
fail:
    return 0;
}
