/* eaclib/psx/sndpsxz/sdresolv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sdresolv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x8010B75C .. 0x8010B958].  Resolve/release a bank patch's SPU sample data: DMA the sample
 *   into SPU RAM and record the SPU address (or free it).  Ghidra nfs4-f.exe.c (sdresolv) + IDA sigs.
 *
 *   Tags consumed while scanning a patch's resolve header (until 0xfe): 0x88 = sample offset, 0x82 =
 *   channel count, 0x85 = sample byte size, 0x8a = the field that receives the resolved SPU address.
 *   PATCH RESOLVE TABLE (the `patch`/scratch arg): {ramOffset, spuAddr}[] terminated by -1.
 */

extern int iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* sgettag  */
extern int iSNDpsxmalloc(int size);                                                 /* sdmemman */
extern void iSNDpsxfree(void *p);                                                   /* sdmemman */
extern int iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, int prio); /* sdma */
extern int iSNDdmcomplete(int handle);                                              /* sdma */

extern int iSNDplatformresolve(int cursor, int bank, int patch);     /* @0x8010B75C */
extern int iSNDplatformremove(int cursor, int *patch);               /* @0x8010B958 */

struct SNDResolveEntry {
    int offset;
    int spu;
};

/* iSNDplatformresolve @0x8010B75C : load a patch's sample into SPU RAM (unless already resolved), recording
 *   the SPU address in the 0x8a field and the resolve table.  Returns 7 / -6 (out of SPU memory).
 *
 * RESIDUAL 3 diffs, ours 126 / oracle 127 (w33-a6 re-diagnosis -- was filed only as a "126/127 floor").
 * The single missing instruction is a delay-slot NOP, not a missing computation: at the
 * `cur->offset == offset` test the oracle emits `beq v0,s3,found; nop` and only THEN the walker
 * advance `addiu v1,a0,8`; ours puts the advance INTO the branch slot.  The volatile compare load
 * `lw v0,0(a0)` already blocks reorg's fill_simple_delay_slots backward scan, so ours is coming from
 * the EAGER fill stealing the advance out of the FALL-THROUGH thread (legal because `scan` is dead on
 * the taken path).  Retail's reorg did not take it.  The obvious source counter -- moving `scan++`
 * below the compare (`cur = scan; if (...) goto found; scan++;`) -- does produce the nop but changes
 * which register carries `cur` (`addu a0,v1,zero` moves) and nets WORSE: 7 diffs (and 9 with idx++
 * ordered first).  The 3rd diff (`lw v0,4(a0)` vs the oracle's `lw v0,4(v1)` at `found:`) is the same
 * a0/v1 pairing.  Same reorg-steal family as sdpacket's iSNDfillspuwithpackets clusters (which WAS
 * cracked, by a volatile that blocks the SIMPLE fill) -- here the simple fill is already blocked and
 * there is no source-side handle on the EAGER fill.  Permuter/allocno territory.
 *
 * w34-a5 SHARPENED THE MECHANISM to a single blocker (still open, but now precisely named).  Retail's
 * slot is empty for a REASON, not a scheduler mood.  Its loop is
 *     LOOP: addu a0,v1,zero ; lw v0,0(a0) ; nop ; beq v0,s3,found ; nop ; addiu v1,a0,8 ; lw v0,8(a0)
 * and BOTH slot candidates are illegal there:
 *   - the copy `addu a0,v1,zero` is a DEPENDENCY of the branch's own compare load (`lw v0,0(a0)`),
 *     so the backward simple fill cannot take it;
 *   - the advance `addiu v1,a0,8` WRITES v1, and retail's `found:` block READS v1 (`lw v0,4(v1)` =
 *     the pre-advance cur->spu), so the eager fill cannot steal it either (a delay-slot insn runs on
 *     BOTH paths, so liveness only blocks a candidate that CLOBBERS a taken-path live-in).
 * Reproducing "found reads v1" needs the advance written AFTER the compare (`cur = scan; if(...) goto
 * found; scan = cur + 1;`) plus `*spuField = scan->spu;`, and that shape WAS built (w34-a5) -- but
 * then cse copy-propagates `cur = scan` into the compare load (`lw v0,0(v1)`), the copy stops being a
 * branch dependency, and reorg steals THE COPY into the slot instead: 7 diffs.  So the whole residual
 * reduces to ONE unsolved item: forcing the compare load to address through `cur` (a0) rather than the
 * canonical `scan` (v1).  That is the make_regs_eqv canonicalisation the sibling sdma.c iSNDdmqueue
 * beat by giving the source a SEPARATE pseudo that dies at the copy -- not available here, because
 * `scan` is loop-carried and by construction outlives `cur` in every iteration.  Also measured and
 * rejected this pass: Yoda compare order (9 diffs), `scan->spu` vs `cur->spu` at found (both 7).
 *
 * ***** 🏆 W47-a4: SOLVED -- PASS 127/127 (was 3 diffs @126). *****
 * The w34-a5 mechanism note was RIGHT about the blocker and WRONG about which reorg pass fills the
 * slot: it is the BACKWARD `fill_simple_delay_slots` scan, not the eager fill.  With `cur = scan++`
 * the advance sits BEFORE the compare in the insn stream, the volatile compare load is skipped as
 * the branch's own dependency, and the scan keeps walking back and takes `addiu v1,a0,8`.
 * Three cooperating edits, each measured (gate = verify_asm, oracle 127):
 *   1. ADVANCE AFTER THE COMPARE (`cur = scan; if(..) goto found; scan = cur + 1;`) + `found:` reads
 *      `scan->spu` -- this is the shape w34-a5 identified; it makes `scan`(v1) live-in at `found`
 *      (`lw v0,4(v1)`) so no fill can clobber it.  Alone: 7 diffs @126 (cse copy-propagates
 *      `cur = scan`, the compare loads `0(v1)`, and the COPY gets taken into the slot instead).
 *   2. ZERO-INSN IDENTITY FENCE on the copy -- `__asm__ ("" : "=r"(cur) : "0"(cur));`.  Defining
 *      `cur` with an opaque asm breaks cse's copy-propagation, so the compare addresses through
 *      `cur`(a0) exactly like retail, AND the asm blocks the backward simple fill.  Alone (as an
 *      INPUT-only fence `"r"(cur)`, with or without a "memory" clobber): 4 diffs -- an input fence
 *      blocks the fill but does NOT break the copy-prop; only the OUTPUT (identity) form does.
 *      It is a ZERO-INSN barrier (127 == oracle), not a register pin: no hard register is named.
 *      ⚠️ WHAT IT STANDS IN FOR: retail's cc1 simply did not copy-propagate this copy -- the
 *      per-obj "old-gcc no-copy-prop / weaker-cse" identity already recorded for the sndpsxz
 *      allocators (methodology sec 3.25-3d; catalog w33 sec G).  If a per-TU flag for sndpsxz ever
 *      reproduces that, DELETE this line and the match should hold.  Honest fallback without it: 7.
 *   3. STATEMENT ORDER `scan = cur + 1;` BEFORE `idx++;` -- independent-chain issue order is fixed
 *      by luid (catalog w43); with `idx++` first the two tail addiu's come out swapped (4 diffs).
 */
extern int iSNDplatformresolve(int cursor, int bank, int patch)
{
    unsigned int  id;
    int           val, ptr;
    int           size = 0;
    int           count = 1;
    int           offset = size;
    int          *spuField = (int *)size; /* the 0x8a field that receives the SPU address */
    int           idx = size;
    int           blocks, scale, buf, dma;
    int          *e;
    struct SNDResolveEntry *scan;
    struct SNDResolveEntry *cur;
    int           end;

    while (iSNDgettag(&cursor, &id, &val, &ptr) != 0 && id != 0xfe) {
        if (id == 0x80)      { /* no-op tag */ }
        else if (id == 0x88) offset   = val;
        else if (id == 0x8a) spuField = (int *)ptr;
        else if (id == 0x82) count    = val;
        else if (id == 0x85) size     = val;
    }
    if (bank != 0) {
        e = (int *)(idx * 8 + patch);               /* find an existing resolve for this offset */
        if (*(volatile int *)e != -1) {
            end = -1;
            scan = (struct SNDResolveEntry *)e;
            do {
                cur = scan;
                /* MATCH: zero-insn IDENTITY fence -- breaks cse copy-prop so the compare addresses
                 * through `cur`(a0) like retail, and blocks fill_simple_delay_slots' backward scan
                 * from stealing the advance into the beq slot.  See the banner. DO NOT "simplify". */
                __asm__ ("" : "=r"(cur) : "0"(cur));
                if (*(volatile int *)&cur->offset == offset)
                    goto found;
                scan = cur + 1;
                idx++;
            } while (*(volatile int *)&cur[1].offset != end);
        }
checked:
        if (*spuField != 0)
            return 7;                              /* already resolved */
        blocks = size / 0x1c;
        if (size != blocks * 0x1c)
            blocks = blocks + 1;
        scale = count << 4;
        blocks = blocks * scale;
        buf = iSNDpsxmalloc(blocks);
        if (buf == 0)
            return -6;
        goto resolve;
found:
        *spuField = scan->spu;
        goto checked;
resolve:
        dma = iSNDdmqueuesplit(bank + offset, (unsigned int)buf, blocks, 1);
        *spuField = buf;
        *(int *)(idx * 8 + patch) = offset;
        *(int *)(idx * 8 + patch + 4) = buf;
        do { } while (iSNDdmcomplete(dma) == 0);
    }
    return 7;
}

/* iSNDplatformremove @0x8010B958 : release a patch's resolved SPU data -- record it in the remove table and
 *   free the SPU block. */
extern int iSNDplatformremove(int cursor, int *patch)
{
    unsigned int  id;
    int           val, ptr;
    int          *spuField = 0;
    int           i;

    while (iSNDgettag(&cursor, &id, &val, &ptr) != 0 && id != 0xfe) {
        if (id == 0x8a)
            spuField = (int *)ptr;
    }
    i = 0;
    if (*patch != -1) {
        do {
            if (patch[i * 2] == *spuField)    /* already removed */
                return 0;
            i++;
        } while (patch[i * 2] != -1);
    }
    patch[i * 2] = *spuField;
    if (*spuField != 0)
        iSNDpsxfree((void *)*spuField);
    return 0;
}
