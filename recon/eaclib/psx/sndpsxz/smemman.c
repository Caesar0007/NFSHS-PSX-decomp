/* eaclib/psx/sndpsxz/smemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/4 PASS ***
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

typedef struct SNDMemState {
    int            base;                /* +0x00 pool byte address */
    short          count;               /* +0x04 live allocation count */
    short          poolWords;           /* +0x06 pool size in words */
    int            highWater;           /* +0x08 high-water mark */
    unsigned short entries[256];        /* +0x0c {block,size}[128] */
} SNDMemState;
extern SNDMemState sndmm;
/* UNSIZED-ARRAY VIEW of the same storage (asm-label alias): an unsized `unsigned char[]`
 * makes gcc materialize each `sndmm_b + K` as the FUSED high(sym+K)/lo_sum pair, so the two
 * distinct table bases (+8 and +0xC, splat D_80148788 / D_8014878C) cannot share one hoisted
 * `lui %hi(sndmm)`. */
extern unsigned char sndmm_b[] __asm__("sndmm");

/* {block,size} free-list entry -- 2-byte alignment is LOAD-BEARING (struct assignment on an
 * align-2 4-byte struct = the oracle's lwl/lwr+swl/swr unaligned word copy). */
typedef struct { unsigned short blk, sz; } SndMemEnt;
#define DAT_80148784 (sndmm.count)
#define DAT_80148786 (sndmm.poolWords)
#define DAT_80148788 (sndmm.highWater)
#define DAT_8014878c (sndmm.entries[0])
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
 * registers finally agree -- is still worse (63 diffs @136). */
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
                block = 0;
                available = *entry;
            } else {
                /* MATCH: compute BOTH values into plain register temps and only then write the
                 * two address-taken frame slots.  Writing `block` first makes gcc treat the
                 * following `*entry` global load as possibly-aliasing, so it cannot be hoisted
                 * into the store's load-delay slot -- ours emitted two nops the oracle does not
                 * have.  The oracle issues all three lhu's up front, then addu/subu, then the
                 * two sw's (catalog sec-F load-before-compute). */
                pv = (unsigned short *)(j + (int)prev);
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
         * D_80148788); poolWords is read as pb[-1] (offset -2 off it). */
        unsigned short *pb = (unsigned short *)(sndmm_b + 8);
        unsigned short *p2 = (unsigned short *)((i << 2) + (int)pb);
        block = (int)p2[0] + (int)p2[1];
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
