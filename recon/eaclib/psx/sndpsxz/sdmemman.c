/* eaclib/psx/sndpsxz/sdmemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/3 PASS ***
 *   Source obj : nfs4\eaclib\psx\sdmemman.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x8010A550 .. 0x8010A7C8].  SPU local-RAM block allocator -- a sorted free-list of up to 128
 *   {block,size} entries (DAT_80147e38, 4-byte stride) carving the SPU's 512 KB sample area into 64-byte
 *   blocks.  Ghidra nfs4-f.exe.c (sdmemman) + disasm-v3 L<8010A700+> for the unaligned shift loop.
 *
 *   🔴 The shift loop's `entry[dst]=entry[src]` is a lwl/lwr+swl/swr UNALIGNED 4-byte copy (the table sits
 *   on an odd boundary); Ghidra mangled the swl/swr into a bit-twiddle AND emitted a phantom aligned store
 *   -- disasm shows ONE unaligned word copy, so the bit-twiddle is dropped and the plain copy kept.
 *
 *   🔴🔴 W33-a7 IDENTITY AXES CLOSED (2026-07-26) -- applies to this whole obj AND to salloc/smemman:
 *   (1) SLD IS UNAVAILABLE HERE.  Walking the trusted SYM's line stream (88/80/82/84 records) and
 *       attributing every VA to its file gives **ZERO SLD records** across 800FE764..8010A800 -- the
 *       SNDPSXZ/EACPSXZ/SPCHPSXZ .LIB members carry only a `2 <name>` address record, no
 *       `8c Function start` block and no line info (2581 debug'd fns of 4503 symbols; 194 SLD'd
 *       source files, none of them a sound TU).  The only SLD-bearing objects interleaved in this VA
 *       span are the hand-written C:\LIB\PSX\*.ASM members, so the absence is PER-OBJECT.  Any future
 *       "check it against the SLD statement map" plan for a .LIB member is a dead end; the only
 *       SLD-armed eaclib calibration point in the whole image is D:\nfs4\EACLIB\PSX\PAD.C -- which is
 *       also the ONLY one of the 194 source paths not on C:, i.e. eaclib was built on a different
 *       machine, archived without -g, and pad.c alone was compiled into the game build.
 *   (2) COMPILER-SNAPSHOT AXIS CLOSED.  Three distinct CC1PSX binaries exist locally across six PsyQ
 *       drops -- 2.7.2 (psyq400 == psyq_sdk 4.3), 2.8.0 (psq43, our gate lane), 2.8.1 (psq44 == psq45
 *       == psyq_sdk 4.4).  Run through the real gate on all five allocators: **2.8.0 and 2.8.1 are
 *       byte-identical** (260/79/86/59/14), and **2.7.2 is decisively refuted** (541/110/134/102/23,
 *       with the wrong instruction count on every one where 2.8.x hits the oracle's exactly).  Retail
 *       is gcc-2.8-class = our own generation, so the residual is an allocation-ORDER difference
 *       INSIDE the generation, not a compiler-version difference.  A surviving "other snapshot"
 *       hypothesis would need a point release absent from every PsyQ drop on this machine.
 *   (3) Cross-game probe: iSNDfreechan's 21-insn reloc-free scan loop is NOT present in NFS3.EXE,
 *       NFS3-F.EXE, NFS2.EXE or NFS2-F.EXE -- this is not a byte-shared prebuilt blob from an
 *       earlier title.
 *   Full evidence tables: C:\Temp\nfs4-clean\pcmap\W33_IDENTITY_a7.md.
 *
 *   ⚠️ iSNDpsxmalloc FLOOR NOTE (w31-a2, 2026-07-26): a full oracle-shape rebuild (three-call CFG with
 *   per-site polarity, guarded-preamble base split, multiply-set-offset SR blocker, clean align-2
 *   struct-assign shift copy, fused-symbol scan_done/commit) reached insn 124/127 but 105 diffs vs this
 *   body's 59 -- the residual classes are NOT source-reachable under the gate toolchain: (a) retail does
 *   NOT cross-jump-merge the empty-arm/scan_done constrain+check tails (ours always merges them because
 *   both arms color identically); (b) retail keeps a redundant value copy in the empty arm
 *   (`addu v1,a2,zero`) and duplicated per-arm `addiu a0/a1,sp` arg setups; (c) retail re-reads a
 *   just-la'd constant via the la RESULT reg where ours folds to %lo(hi-reg). All three = the
 *   methodology sec 3.25-3d "old-gcc no-copy-prop / weaker-cse" per-obj identity family (proven
 *   elsewhere in sndpsxz: sdmemlu needed the multiply-set-giv + join-block levers to sidestep the same
 *   engine differences). Do NOT re-fight with source contortions; a per-obj flag/toolchain identity for
 *   sndpsxz is the suspected root (W30 rule 6).
 *
 *   🔴 W32-a7 SHARPENING (2026-07-26) -- the floor above is CONFIRMED and now localized to a single
 *   allocno decision.  Three of the four residual classes ARE source-reachable and were reproduced
 *   exactly in a scratch build that reached 125/127 instructions with the first 26 instructions
 *   byte-identical to the oracle:
 *     (a) the empty arm's otherwise inexplicable `addu $v1,$a2,$zero` is a plain double READ of
 *         sndpd+0x51A (`local_block = *p; local_avail = *q - *p;`) -- cse rewrites the second load
 *         into a register copy that this cc1 then fails to propagate away, and it lands in retail's
 *         exact registers ($a2/$v0/$v1);
 *     (b) scan_done's fresh `lui/addiu` of sndpd+0x51C (splat D_80147E34) comes from writing that
 *         block against its OWN base instead of the loop's $s3 -- retail must rematerialize because
 *         $s3 is undefined on the guard-taken path;
 *     (c) the duplicated per-arm `addiu $a0/$a1,$sp` setups come from TWO textual call sites whose
 *         post-reload cross-jump merges only the bare `jal`.
 *   What is NOT reachable is (d): retail's scan_done colors the block sum into $v0 and the avail
 *   difference into $v1; ours colors them $v1/$v0 -- the exact mirror.  Because the merge depth of
 *   the post-reload cross-jump is decided on HARD registers, that one swap is what makes retail's two
 *   arms stop merging at the `jal` while ours also merges the `sw ..,0x14($sp)` and the argument
 *   setup.  Root of the swap: our `addu` for the entry address coalesces its dest with the dying
 *   `idx*4` pseudo ($v0), so prev[0] is pushed to $v1; retail takes a fresh $a2 and keeps prev[0] in
 *   $v0.  SIX source spellings of that address were tried -- `(idx*4)+(int)base`, `(int)base+idx*4`,
 *   `base + idx*2`, `base[idx*2]` index form, total-loaded-first, and a fresh-symbol total -- and ALL
 *   SIX produce byte-identical RTL/asm.  The identical swap appears in smemman.c iSNDmalloc's
 *   post-scan tail, so it is a property of the allocator, not of either function's source.
 *   NET: reverted to this 59-diff body; the 125/127 variant scores 72 because the shared tail lands
 *   after scan_done instead of after the empty arm (a pure alignment artifact of the same swap).
 */

/* MATCH: engine_ver/block_total/reverb_mode/alloc_count are NOT separate linked globals -- the oracle
 * (iSNDpsxmemconstrain, byte-exact) materializes ONE `sndpd` base (lui/addiu) and reads them all as
 * fixed displacements off it (0x518/0x51A/0x51C/0x51E). Modeled as sndpd+offset macros, same lever as
 * sdma.c. The alloc table lives right after reverb_mode @ sndpd+0x520 (4-byte {block:u16,size:u16}
 * stride); iSNDpsxmalloc's oracle addresses it via its OWN independently-relocated symbol at the
 * array-indexed sites, but that symbol's VA == sndpd+0x520 -- same storage, different materialization.
 *
 * SPLIT-STORAGE FIX (wave-22 a1): this file previously `extern`-declared snd_spu_block_total/
 * snd_spu_reverb_mode/snd_spu_alloc_count/DAT_80147e38 as their OWN standalone globals, owned by
 * sdmemlu.c (with mismatched shapes between the two files' decls -- flagged by scratch/
 * extern_audit_report.txt: DAT_80147e38 as `unsigned short` here vs `int` there, no owner def either
 * place). That is a genuine aliasing/link bug: sdmemlu.c has been converted to the sndpd-relative
 * model (see its banner) and no longer provides that storage, so these externs would now be
 * UNDEFINED REFERENCES. Converted to the same SNDPD_* macro-view convention used by
 * iSNDpsxmemconstrain above, so this file's own reads/writes of the free-list genuinely alias with
 * slib.c's iSNDinit (writer) and sdmemlu.c's SNDmemlargestunused (reader) -- all three now compute
 * addresses off the same `sndpd` base instead of three disconnected storage locations. */
extern unsigned char sndpd[];                 /* voice/queue state base @0x80147918 (shared, sdma.c) */
#define SNDPD_ENGINEVER   (*(unsigned short *)(sndpd + 0x51A))  /* min SPU block (reserved low area) */
#define SNDPD_BLOCKTOTAL  (*(unsigned short *)(sndpd + 0x51C))  /* top of the SPU sample area */
#define SNDPD_REVERBMODE  (*(unsigned short *)(sndpd + 0x51E))  /* reverb-work-area boundary */
#define SNDPD_ALLOCCOUNT  (*(unsigned short *)(sndpd + 0x518))  /* # of live SPU allocations */
/* legacy names kept as macro aliases so the function bodies below need no rewrite beyond dropping
 * their `extern` decls -- lvalue macro-view recipe: NAME, &NAME, and (&NAME)[i] all keep working. */
#define snd_spu_block_total  SNDPD_BLOCKTOTAL
#define snd_spu_reverb_mode  SNDPD_REVERBMODE
#define snd_spu_alloc_count  SNDPD_ALLOCCOUNT
#define DAT_80147e38          (*(int *)(sndpd + 0x520))          /* {block:u16, size:u16}[] alloc table */

extern void iSNDpsxmemconstrain(unsigned int *size, int *avail);  /* @0x8010A550 */
extern int iSNDpsxmalloc(int size);                               /* @0x8010A5CC */

/* iSNDpsxmemconstrain @0x8010A550 : clamp a candidate [block, avail] window to the SPU sample area limits
 *   (floor at engine_ver, ceil at block_total, and at reverb_mode).  Returns the reverb-bounded
 *   available size.
 *
 * 🔴 ALLOCNO FLOOR, and now the CLUSTER'S MINIMAL EXHIBIT (w33-a7, 2026-07-26).  Ours is 31 insns /
 *   oracle 31, SAME ORDER, SAME MNEMONICS, SAME DISPLACEMENTS -- all 14 diffs are two register
 *   choices in the first basic block, and the last two blocks are already byte-exact:
 *       lo   = *(u16*)(sndpd+0x51A)   retail $a3   ours $v1
 *       diff = lo - *size (delay slot) retail $v0   ours $a3
 *   Retail lets `diff` take BACK $v0 -- the register the `slt` compare temp just died in -- while
 *   ours gives it a fresh caller-saved reg.  That is the w32 "coalesce-with-dying-pseudo vs fresh
 *   reg" core, isolated with nothing else moving.  MEASURED INVARIANCE (all still 14 diffs):
 *     - 4 declaration orders/groupings of {lo, s, diff}: 14/14/14/14 (exactly invariant);
 *     - 4 source spellings (load order swapped; `lo` as unsigned int; `diff` computed inside the
 *       `if`; store order swapped): 14/18/20/17 -- this body is the best of them;
 *     - 11 cc1 flags on top of the gate set (-fno-schedule-insns{,2}, -fno-delayed-branch,
 *       -fno-cse-follow-jumps, -fno-expensive-optimizations, -fno-strength-reduce,
 *       -fno-function-cse, -fno-peephole, -fno-thread-jumps, -fcaller-saves): none < 14 at parity
 *       (-fno-expensive-optimizations shows 13 but BREAKS the 31/31 parity, so it is a worse fit);
 *     - 3 distinct cc1 binaries / 2 gcc generations -- see the file header sweep.
 *   NEXT INSTRUMENT (not yet tried on this cluster): permuter multi-basin re-seed.  At 31 insns this
 *   is the cheapest permuter target in sndpsxz and the methodology's discriminator says a
 *   "retail reuses a dying reg / ours takes a fresh one" residual is a permuter case, not an accept. */
extern void iSNDpsxmemconstrain(unsigned int *size, int *avail)
{
    unsigned char *pd = sndpd;
    unsigned short lo;
    unsigned int s, diff;
    lo = *(unsigned short *)(pd + 0x51a);
    s = *size;
    diff = (unsigned int)lo - s;
    if ((int)s < (int)lo) {
        *size = lo;
        *avail = *avail - diff;
        s = *size;
    }
    if ((int)(unsigned int)*(unsigned short *)(pd + 0x51c) < (int)(s + *avail))
        *avail = (int)*(unsigned short *)(pd + 0x51c) - s;
    if ((int)(unsigned int)*(unsigned short *)(pd + 0x51e) < (int)(*size + *avail))
        *avail = (int)*(unsigned short *)(pd + 0x51e) - (int)*size;
}

/* iSNDpsxmalloc @0x8010A5CC : allocate `size` bytes (rounded to 64-byte blocks) of SPU local RAM, first-fit
 *   into the gaps of the sorted free-list, inserting the new {block,size} entry in order.  Returns the SPU
 *   byte address (block << 6) or 0 on failure. */
extern int iSNDpsxmalloc(int size)
{
    /* MATCH: this split base lifetime plus the label-shaped scan reproduces the oracle's five saved-register
     * layout without turning the indexed table accesses into walking induction pointers.  Keep the empty path
     * on the caller-saved `base`; the nonempty path promotes it to persistent `pd`, while commit deliberately
     * re-materializes sndpd+0x520.  The explicit volatile entry-count gate preserves the oracle's pre-loop
     * bound check, and branch-local block/avail temporaries keep each gap calculation on its own CFG arm.
     * The empty/tail candidates remain separate register temporaries until the shared constrain block, matching
     * the lifetime split recovered by RetDec.  The packed four-byte shift is expressed as __builtin_memcpy so
     * CC1PSX emits the oracle's direct lwl/lwr/swl/swr sequence without an artificial value move.  Together
     * with in-place size rounding and the oracle-ordered failure label, these changes reduced the detailed
     * residual from 140 to 59 instructions. */
    unsigned char *base = sndpd;
    unsigned char *pd;
    unsigned int blk, src;
    int          idx = 0;
    unsigned int final_block;
    int          final_avail;
    unsigned int local_block;
    int          local_avail;
    unsigned short count = *(unsigned short *)(base + 0x518);

    if (count >= 0x80)
        goto fail;
    size += 0x3f;
    size >>= 6;
    if (count != 0)
        goto nonempty;
    final_block = (unsigned int)*(unsigned short *)(base + 0x51A);
    final_avail =
        (int)*(unsigned short *)(base + 0x51C) - (int)final_block;
final_constrain:
    local_block = final_block;
    local_avail = final_avail;
    iSNDpsxmemconstrain(&local_block, &local_avail);
    if (size <= local_avail)
        goto commit;
fail:
    return 0;
nonempty:
    {
        unsigned char *table;
        unsigned char *previous;
        pd = base;
        table = pd + 0x520;
        previous = pd + 0x51c;
        if (idx >= (int)(unsigned int)
                       *(volatile unsigned short *)(pd + 0x518))
            goto scan_done;
scan:
        {
            unsigned char *entry =
                (unsigned char *)((unsigned int)(idx * 4) +
                                  (unsigned int)table);
            if (idx == 0) {
                unsigned int block =
                    (unsigned int)*(unsigned short *)(pd + 0x51A);
                int avail = *(volatile unsigned short *)entry - (int)block;
                local_block = block;
                local_avail = avail;
            } else {
                unsigned short *prev =
                    (unsigned short *)(previous + idx * 4);
                unsigned int block =
                    (unsigned int)prev[0] + (unsigned int)prev[1];
                int avail = *(unsigned short *)entry - (int)block;
                local_block = block;
                local_avail = avail;
            }
            iSNDpsxmemconstrain(&local_block, &local_avail);
            if (size <= local_avail) {
                blk = (unsigned int)*(unsigned short *)(pd + 0x518);
                if (idx < (int)blk) {
                    do {                                   /* shift entries up to open slot `idx` */
                        struct PackedAllocSlot {
                            unsigned char pad[0x520];
                            int word;
                        } __attribute__((packed));
                        volatile struct PackedAllocSlot *dst =
                            (struct PackedAllocSlot *)
                                ((unsigned int)(blk * 4) + (unsigned int)pd);
                        src = blk - 1;
                        __builtin_memcpy(
                            (void *)&dst->word,
                            (void *)&((struct PackedAllocSlot *)
                                          ((unsigned int)(src * 4) +
                                           (unsigned int)pd))->word,
                            4);
                        blk = src;
                    } while (idx < (int)src);
                }
                goto commit;
            }
        }
        idx++;
        if (idx < (int)(unsigned int)*(unsigned short *)(pd + 0x518))
            goto scan;
scan_done:
        {
            unsigned short *prev =
                (unsigned short *)(previous + idx * 4);
            final_block = (unsigned int)prev[0] + (unsigned int)prev[1];
            final_avail =
                (int)*(unsigned short *)(pd + 0x51C) - (int)final_block;
        }
    }
    goto final_constrain;
commit:
    {
        unsigned char *table = sndpd + 0x520;
        unsigned short *entry =
            (unsigned short *)(table + idx * 4);
        unsigned char *commit_base = table - 0x520;
        entry[1] = (short)size;
        entry[0] = (unsigned short)local_block;
        *(unsigned short *)(commit_base + 0x518) =
            *(unsigned short *)(commit_base + 0x518) + 1;
        return local_block << 6;
    }
}

/* iSNDpsxfree @0x8010A7C8 : free the SPU block at byte address `ptr` (block == ptr>>6), removing its entry
 *   and compacting the free-list.
 *   BUG FIX (wave-22 a1): the oracle epilogues return 0 (found+compacted) or -8 (not found in the
 *   table) in $v0 -- this was reconstructed `void`, a Ghidra-style dropped-return (methodology §3.2).
 *   All current callers (sdata.c, sdpacket.c, sdresolv.c) discard the result, so this is a pure type
 *   correction (declares the true signature; codegen for a non-void return differs from void even when
 *   the value goes unused) -- not a behavior change for any caller. Their stale `void`/`(void*)`-arg
 *   forward decls elsewhere are harmless under C linkage (no signature-based mangling) and are OUT OF
 *   SCOPE for this file to retarget. */
extern int iSNDpsxfree(int ptr)
{
    /* MATCH: same early &sndpd materialization lever as iSNDpsxmalloc/SNDmemlargestunused/iSNDpsxfxinit.
     * __builtin_memcpy on the packed slot is intentional: CC1PSX lowers it to the oracle's direct unaligned
     * word copy and avoids the extra temporary move produced by a member assignment. */
    int idx = 0;
    unsigned char *pd = sndpd;
    ptr >>= 6;
    if (*(unsigned short *)(pd + 0x518) != 0) {
        unsigned char *table = pd + 0x520;
        unsigned char *base = pd;
        do {
            if ((unsigned int)*(unsigned short *)(table + idx * 4) == (unsigned int)ptr) {
                unsigned short remaining =
                    *(unsigned short *)(base + 0x518) - 1;
                *(unsigned short *)(base + 0x518) = remaining;
                if (idx < (int)(unsigned int)remaining) {
                  do {
                    struct PackedAllocSlot {
                        unsigned char pad[0x520];
                        int word;
                    } __attribute__((packed));
                    volatile struct PackedAllocSlot *dst =
                        (struct PackedAllocSlot *)((unsigned int)(idx * 4) +
                                                  (unsigned int)base);
                    int next = idx + 1;
                    __builtin_memcpy((void *)&dst->word,
                                     (void *)&((struct PackedAllocSlot *)
                                                   (base + next * 4))->word,
                                     4);
                    idx = next;
                  } while (idx < (int)(unsigned int)*(volatile unsigned short *)(base + 0x518));
                }
                return 0;
            }
            idx++;
        } while (idx < (int)(unsigned int)*(unsigned short *)(base + 0x518));
    }
    return -8;
}
