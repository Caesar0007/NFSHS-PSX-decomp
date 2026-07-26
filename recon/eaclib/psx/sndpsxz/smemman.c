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
 * 🔴 ALLOCNO FLOOR, shared with sdmemman.c iSNDpsxmalloc: in BOTH the `i != 0` arm and the post-scan
 * tail the oracle colors the {prev[0]+prev[1]} sum into $v0 and the {limit - sum} difference into
 * $v1; ours colors them exactly the other way.  The cause is upstream: retail keeps the entry byte
 * offset `i*4` in $v0 and ours in $a0, because our `j` is ALSO the shift-loop counter and that
 * counter's `lhu $a0,4($s1)` drags the fused pseudo into $a0.  Splitting them into two locals (the
 * textbook catalog sec-A fix) makes it far WORSE (86 -> 131 diffs): the reuse IS the retail shape,
 * so the two live ranges must stay fused and the register they land in is then the allocator's call.
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
 * register is decided by the same $v0/$v1 mirror as the rest of this floor. */
extern int iSNDmalloc(int size)
{
    /* MATCH (w31-a2, from the raw oracle -- same shape family as iSNDpsxmalloc but with THREE
     * separate iSNDmemconstrain call sites (gcc merges none of them: the empty arm and the
     * post-scan tail use OPPOSITE branch polarities), the {block,size} entry table at sndmm+0xC,
     * the virtual entry[-1] overlapping the high-water word at sndmm+8, and a commit block that
     * returns pool + block*4 and bumps the high-water mark. */
    int             block;      /* sp+0x10 -- address taken */
    int             available;  /* sp+0x14 -- address taken */
    int             i, j;
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
                j = *(unsigned short *)(mm + 4);
                while (i < j) {
                    int n;
                    /* struct assignment on the 2-aligned 4-byte entry = the oracle's unaligned
                     * lwl/lwr + swl/swr word copy; `n` keeps the 0xC displacements un-folded. */
                    ((SndMemEnt *)(mm + 0xc))[j] =
                        ((SndMemEnt *)(mm + 0xc))[n = j - 1];
                    j = n;
                }
                goto commit;
            }
            i++;
        } while (i < (int)*(unsigned short *)(mm + 4));
    }
    {
        /* post-loop tail: fresh block-locals re-materialize the FUSED sndmm+8 symbol (oracle
         * D_80148788); poolWords is read as pb[-1] (offset -2 off it). */
        unsigned short *pb = (unsigned short *)((unsigned char *)&sndmm + 8);
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
        unsigned char *tabsym = (unsigned char *)&sndmm + 0xc;
        unsigned char *cb;
        int addr;
        entry = (unsigned short *)((i << 2) + (int)tabsym);
        entry[1] = (unsigned short)size;
        entry[0] = (unsigned short)block;
        cb = tabsym - 0xc;
        *(unsigned short *)(cb + 4) += 1;
        addr = *(int *)(tabsym - 0xc) + block * 4;
        if (*(int *)(cb + 8) < block + size)
            *(int *)(cb + 8) = block + size;
        return addr;
    }
fail:
    return 0;
}
