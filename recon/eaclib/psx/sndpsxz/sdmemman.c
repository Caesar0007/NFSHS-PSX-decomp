/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: identity = gcc-2.8.0 + maspsx (the DEFAULT lane).
 *
 *   lane            iSNDpsxmemconstrain   iSNDpsxmalloc
 *   default         14 (31/31)             59 (120/127)
 *   2.6.0           compile error          compile error
 *   2.6.3           compile error          compile error
 *   2.7.2-970404    14 (31/31)             67 (120/127)
 *   2.7.2           23 (32/31)             94 (123/127)
 *   2.8.0 CONTROL   14 (31/31)             59 (120/127)
 *   2.8.1           14 (31/31)             59 (120/127)
 *   2.91.66         44 (33/31)            101 (118/127)
 *   2.95.2          14 (31/31)            158 (125/127)
 *
 * READING: nothing beats the default.  This EXTENDS the w33-a7 sweep ("3 distinct cc1
 * binaries / 2 gcc generations") to the full 8-rung ladder, so the w34-a7 verdict on
 * iSNDpsxmemconstrain -- retail's `diff` is a BLOCK-1 pseudo that reorg eager-stole into
 * the branch delay slot, and THIS cc1 always sinks the subu below the `lw *avail` to fill
 * its load-delay slot -- is now closed on the compiler-version axis as well.  (The 2.6.x
 * rungs reject this TU outright, so they are not evidence either way.)
 */
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
 *
 *   🔴🔴 W34-a7 LEVER-2 VERDICT (NFS2 PC-beta named source) -- THERE IS NO ANCESTOR FOR THIS OBJ.
 *   The wave's new weapon (C:\Temp\nfs2-clean\pc-beta\pc-split, 53 NAMED memman.obj bodies + the
 *   whole INDEX.csv module map) does NOT cover sdmemman/smemman and cannot adjudicate their shape:
 *     - NFS2-PC has NO SPU (sdmemman allocates SPU local RAM) and NO sound sub-pool allocator.  A
 *       full INDEX.csv sweep of every `iSND*`/`SND*` name (sbank/spath/sinit/sdriver/sstream/shdr/
 *       sserver/slib/sbankbld/spatch/salloc/sdirect/smixer) finds no *malloc/*memconstrain/*free
 *       member at all -- the PC sound lib gets its memory from the general manager.
 *     - memman.obj IS a different DATA STRUCTURE: a doubly-linked mem-CLASS/mem-BLOCK manager
 *       (_creatememclass/_linkmemclass/_reservememblock{,z,a,ai}/_reservememadr{,z,a}/_purgeone/
 *       _largestreserveableinclass walk `piVar[8]` next-pointers), whereas sdmemman/smemman are a
 *       sorted ARRAY free-list of {block:u16,size:u16} entries scanned by INDEX with an insert-shift.
 *       No statement order, loop shape or early-exit structure transfers between the two.
 *     - Its per-fn files are Ghidra/IDA decompiles with synthetic locals (`piVar1`,`iVar2`), so even
 *       for a matching algorithm they carry function NAMES, not EA statement text.
 *   => For sndpsxz's allocators the NFS2 axis is CLOSED alongside SLD (w33) and the compiler
 *   snapshot (w33).  Do not re-spend a wave looking for a PC twin of these three functions.
 *
 *   🔬 W33-a7 RE-AUDIT against the wave's three-way copy taxonomy (loop.c giv anchor / cse.c
 *   double-evaluation / true allocator coalescing): (a) applying w32's class-2 finding IN ISOLATION --
 *   spelling the empty arm as `final_block = *p; final_avail = *q - *p;` with a literal second read of
 *   sndpd+0x51A -- is fully CSE'd away here: byte-identical output, still 59 diffs at 120/127, no
 *   `addu $v1,$a2,$zero` emitted.  It only survives inside the larger w32 scratch, which scores worse
 *   overall.  (b) The giv-anchor mechanism does NOT apply: the entry table stride is 4 (power of two),
 *   but retail emits a per-iteration `sll`+`addu` rather than a strength-reduced walker, so the
 *   multiply-set-`idx` giv BLOCKER already in this body IS the retail shape -- creating an anchor
 *   would move away from the oracle.  (c) The residual is therefore conceded to class 3, the $v0/$v1
 *   mirror, whose only untried instrument is the permuter (start with iSNDpsxmemconstrain, 31 insns).
 *
 *   🟢🔴 W35-a3 (2026-07-26) -- the SIBLING floor in smemman.c iSNDmalloc, described here and there
 *   as the same allocno family, WAS BROKEN this wave (86 -> 52 diffs) by three return/block-placement
 *   levers.  All three were ported here; NONE is a keep.  Recorded as a clean matrix so nobody
 *   re-derives it (gate = verify_asm, diffs @ insns, oracle 127):
 *       baseline 59@120 | split 75@120 | dbl 59@120 | pv 61@122
 *       split+dbl 60@123 | split+pv 85@122 | dbl+pv 61@122 | all three 70@125
 *     * `split` = TWO textual iSNDpsxmemconstrain call sites writing the address-taken pair directly
 *                 (retiring the shared `final_constrain:` label and the final_* register copies).
 *                 This IS retail's shape -- retail duplicates `addiu $a0/$a1,$sp` and both frame
 *                 stores per arm and shares ONLY `.L8010A634: jal; nop`.
 *     * `dbl`   = the W32 double READ of sndpd+0x51A in the empty arm (retail's `addu $v1,$a2,$zero`).
 *                 CONFIRMED: CSE'd away in isolation (59@120, byte-identical output) and it only
 *                 materializes once `split` exists -- w33-a7's isolated-finding note was right.
 *     * `pv`    = scan_done against its OWN sndpd+0x51C symbol, limit read at offset 0 off that same
 *                 base (retail's `.L8010A740 lui/addiu %hi/%lo(D_80147E34)` + `lhu $v1,0($v1)`).
 *   `split+dbl` reproduces the empty arm BYTE-EXACTLY (first 24 instructions identical, vs the
 *   baseline's 18) and `split+dbl+pv` reaches 125/127 -- but the LCS-MATCHED instruction count is
 *   LOWER than the baseline's (91 vs 94), so the baseline body stays.
 *   WHY THE 7 INSTRUCTIONS SURVIVE: the whole gap is one region.  Retail's post-scan owns
 *   `addiu $a0/$a1,$sp` + `sw $v0,0x10($sp)` + `sw $v1,0x14($sp)` (4) and the empty arm owns its own
 *   4, with only `jal`+`nop` shared; ours shares 5 of them.  post-reload cross-jump merge DEPTH is
 *   decided on HARD REGISTERS, and retail's two arms differ ($a2/$v0 vs $v0/$v1) only because in
 *   scan_done retail's `entry` address takes a FRESH $a2 while ours coalesces it with the dying
 *   `idx*4` pseudo in $v0, pushing prev[0] to $v1 and rotating everything after it.
 *   SOURCE-INVARIANCE OF THAT ONE `addu` is now 14 spellings across w32/w34/w35.  W35 added:
 *   `(int)pv + idx*4`; `pv + idx*2`; the `pv[k]/pv[k+1]` index form; an `off` named temp; sum-in-a-
 *   temp; limit-in-a-temp; limit read FIRST; limit read BETWEEN the two prev loads; `prev[1]+prev[0]`
 *   order; a dead-set `prev = 0` carrier; and moving `table`/`previous` BELOW the entry guard (which
 *   IS retail's shape -- the oracle assigns $s1/$s3 only on the fall-through, `beqz` first).  ALL
 *   produce byte-identical output.  The only two that move at all COST instructions: writing the
 *   limit into the address-taken `local_avail` before overwriting it (61@128, a spurious double
 *   store) and the `+=` chain (62@129).
 *   ALSO CLOSED: `-mno-split-addresses` for this TU is decisively WRONG (malloc 63@120, memconstrain
 *   14 -> 18, and it BREAKS iSNDpsxfree which currently PASSes -> 4 diffs).
 *   The smemman commit-block levers are diff-neutral here -- our commit already reuses $a0 for the
 *   state base like retail, and sched1 re-floats the index `sll` regardless of source position
 *   (index-first: 59 -> 59; on top of split+dbl: 61@124).
 *   NOTE for the next wave: today's two NEW dials (IN-LOOP-DEF REF doubling, DEAD-SET carrier) are
 *   both loop.c-mediated and this residual is NOT in a loop, so neither is applicable here.
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
extern unsigned short D_80147E34[];            /* sndpd+0x51C, exact retail tail-scan relocation */
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
 *
 *   🔴🔴 W34-a7 RE-VERDICT -- THIS IS **NOT** AN ALLOCNO TIE-BREAK.  It is a LIVE-RANGE fact forced
 *   by one RTL-emission decision, and the whole coloring follows from it deterministically.  PROOF
 *   (read the oracle, not the allocno table):
 *       slt  $v0,$a2,$a3        ; the compare temp IS $v0 and is live until the branch
 *       beqz $v0,.L8010A588
 *        subu $v0,$a3,$a2       ; `diff` -- the SAME $v0
 *   A pseudo defined BEFORE the compare cannot be given $v0: it would be live across an insn that
 *   already owns $v0 (our -dg dump says exactly that -- `86 conflicts: ... 2 ...`, a HARD conflict
 *   with $v0 that no priority reordering can dodge).  So retail's `diff` is a BLOCK-1 pseudo (born
 *   after the branch) that reorg then EAGER-STOLE into the delay slot (legal: $v0 is redefined by
 *   `lw $v0,0($a1)` on the taken path, so the stolen subu is dead there).  Retail's source therefore
 *   computed the difference INSIDE the `if`.  Everything else follows: with $v0 taken by a block-1
 *   pseudo, `lo` is pushed off $v0/$v1 to $a3 and the block-1 avail temp lands in $v1 -- exactly the
 *   oracle's assignment.  Ours computes `diff` in block 0, so the 3-cycle rotation
 *   (lo $v1->$a3, diff $a3->$v0, temp $v0->$v1) is a CONSEQUENCE, not a coin-flip.
 *   WHY WE STILL CANNOT REACH IT (the real, narrow floor): whenever the subtraction is written
 *   inside the `if`, THIS cc1 always emits it AFTER the `lw *avail` -- it uses the subu to fill the
 *   load-delay slot, which leaves the un-stealable `sw` at the block head, so reorg fills nothing
 *   and the count is restored by the removed load-delay nop (20 diffs, 31/31, every time).  Retail's
 *   build left the subu at the block head and paid the load-delay nop the oracle actually shows.
 *   MEASURED (w34-a7, all still >= 14; the 20s all carry the correct block-1 live ranges and the
 *   WRONG placement):  diff-first-in-if 20 | store-then-named 20 | store-then-inline 20 |
 *   volatile-*avail 20 | re-read-*size-in-diff 20 | avail-cached-first 20 | `-=` form 20 |
 *   negated (`s-lo` then `+`) 30 | negated in block 0 30 | no-`s`-variable 23 (32 insns) |
 *   compare via `*size` 14 | `int` lo/diff 14 | source load order swapped 14.
 *   FLAGS on the block-1 spellings: -fno-schedule-insns 20/30, -fno-schedule-insns2 22,
 *   both off 35 (34 insns), -fno-cse-follow-jumps 20 -- i.e. the placement is decided at RTL
 *   EMISSION, not by either scheduler pass, so no flag identity reaches it either.
 *   PERMUTER (w34-a7, the instrument this note asked for): base score 75, ~3270 iterations at -j 2.
 *   Best VALID candidate score 50 = "reuse the dead `lo` variable for the third clamp's limit read"
 *   (catalog dead-var-repurpose) -- transcribed and GATED: still 14 diffs.  A score-60 candidate was
 *   semantically INVALID (it deleted `s = *size;` and read `s` uninitialized) -- rejected per the
 *   permuter trust rules.  Two more scorer/gate DISAGREEMENT data points for tools/PERMUTER.md.
 *   STATUS: STRONG floor (>=13 alternate source forms byte-checked, 4 flag configs, 3 cc1 binaries,
 *   a permuter basin, and a named mechanism).  The only untried instrument left is a permuter
 *   multi-basin re-seed FROM the 20-diff block-1 basin -- but its premise is falsified above: every
 *   source form in that basin has the subtraction mis-placed, and the permuter mutates source, not
 *   RTL emission order.
 *
 *   🔴 W35-a3 RE-CONFIRMATION + the PROTOTYPE axis (which the catalog flags as the usual reason a
 *   floor certification is wrong -- "floors are prototype-conditional incl. PARAMETER WIDTH").  Now
 *   closed here too: `int *size, int *avail` = 14, `unsigned int *size, unsigned int *avail` = 14,
 *   `short *size` = 35 @32 insns (breaks parity).  Return type is genuinely void -- the exit $v0
 *   holds the third clamp's `subu`/`slt` scratch on every path, i.e. incidental, and an `int` return
 *   would RESERVE $v0, which is the register retail gives to `diff`.
 *   Five more spellings (all still 14 @31/31, byte-identical output): declaration-with-initializer
 *   form; `diff` computed from a second literal `*size` read; `lo` typed `unsigned int` with the
 *   subtraction un-cast; `s` read BEFORE `lo`; Yoda `(int)lo > (int)s`.
 *   The residual is precisely TWO facts: (i) the first two loads are ORDER-SWAPPED (ours
 *   `lw $a2,0($a0)` then `lhu`, retail `lhu` then `lw`) because sched1 gives the dependency-free
 *   `lw` off the incoming `$a0` a higher ready-list priority than the `lhu` that must wait for the
 *   `la` of sndpd; and (ii) the 3-way rotation that follows from it (lo $v1<-$a3, diff $a3<-$v0,
 *   block-1 temp $v0<-$v1).  Our body ALREADY has retail's exact instruction sequence including the
 *   `subu` in the `beqz` delay slot -- the W34 note's "we cannot put the subtraction at the block
 *   head" concern does not apply to THIS body, only to the 20-diff variants.
 *   Today's two new dials do not reach it either: both IN-LOOP-DEF REF doubling and the DEAD-SET
 *   carrier are loop.c-mediated (REG_N_REFS is loop-depth-weighted only inside a
 *   NOTE_INSN_LOOP_BEG/END pair) and this function contains no loop.
 *
 *   🟡 W49-a7 -- FACT (i) IS NOW REACHABLE; only fact (ii) survives.  The w45 USE FENCE
 *   (sched-issue-position fixpoint, `__asm__("" : : "r"(lo))` between the `lhu` and `s = *size`,
 *   with `lo` retyped `unsigned int` so no `andi 0xffff` re-mask appears) FIXES the load order:
 *   the object becomes `lhu; lw; nop; slt; beqz; subu(delay)` -- retail's exact sequence -- and the
 *   residual is EXACTLY the 3-way rotation (lo $v1<-$a3, diff $a3<-$v0, block-1 temp $v0<-$v1),
 *   still 14 @31/31.  NOT LANDED: same gate count, and it buys the alignment with a device.
 *   Re-tested IN THAT NEW BASIN (the w45 "falsifications are basin-relative" law), the block-1
 *   spellings still miss the same way: diff-in-if 20, diff-inline 20, diff-fn-scope-in-if 20,
 *   store-after 21, re-read-*size 20, `-=` 20, volatile-*size 20, `s`-mutated 30.  ROOT CAUSE of
 *   the 20-basin, now named: inside the `if`, sched1 ranks `sw *size` ABOVE `subu diff` because
 *   `*size` and `*avail` may alias, so `sw *size -> lw *avail -> subu -> sw *avail -> lw s` is a
 *   5-long dependence chain while `subu diff` heads a 2-long one; retail issued the subu first,
 *   which is what lets reorg eager-steal it into the `beqz` slot.  A fence pinning the subu at the
 *   block head DOES win the order but blocks the steal itself (32 insns / 31 diffs -- the w45
 *   documented fence boundary).  Remaining angle: a spelling that SHORTENS the store's chain
 *   without removing the `s = *size` reload the oracle shows.  Floor stands at 14.
 *
 *   ð´ W50-a7 -- THE W49 ROOT-CAUSE NOTE ABOVE IS FALSIFIED (floor-hygiene: recorded diagnoses are
 *   falsifiable too).  W49 named the 20-basin cause as "sched1 ranks `sw *size` above `subu diff`
 *   because *size and *avail may alias, giving the store a 5-long dependence chain".  Both halves
 *   were tested directly and neither holds:
 *     (a) READ `*avail` INTO A LOCAL BEFORE the `*size` store, so no store->load chain can exist at
 *         all (`int a = *avail; diff = lo - s; *size = lo; *avail = a - diff; s = *size;`): STILL 20,
 *         and the emitted block-1 order is unchanged (lw avail, sw size, subu diff, subu, sw, lw).
 *     (b) BREAK THE ALIAS with real COMPONENT_REFs -- two distinct one-member struct views, one per
 *         pointer, so both MEMs are MEM_IN_STRUCT_P of different types: STILL 20.
 *   Also measured at exactly 20, byte-identical: diff as a BLOCK-SCOPE declaration-with-initializer;
 *   `lo` typed int; the store routed through `s` first (`s = lo; *size = s;`); a dead `diff - diff`
 *   term added to the stored value (folded); the W49 load-order use fence combined with a block-1
 *   diff.  Worse: avail-store-before-size-store 21 @30, reload-before-avail-update 23 @30, an
 *   opacity fence on the *avail pointer 23 @32, a fence on diff 31 @32.
 *   â THE 20-BASIN IS A SINGLE POINT, NOT A FAMILY: 13 structurally different block-1 spellings all
 *   emit the SAME object.  So the placement is not decided by the dependence graph the source can
 *   shape, and no alias/ordering spelling reaches it.  What the basin DOES show (new, from the raw
 *   objects): the branch delay slot is EMPTY in every 20-variant -- reorg neither simple-fills
 *   (block 0 has no movable candidate once `diff` leaves it) nor eager-steals block 1's head insn.
 *   Retail's steal works only because its block-1 head IS the `subu` whose dest $v0 is redefined on
 *   the taken path.  So the requirement is exact: `subu diff` must be the FIRST insn sched1 emits in
 *   block 1, and the only lever that pins it there (a fence) is also the thing that blocks the steal.
 *   NEXT INSTRUMENT (named, not tried here -- out of budget): `-dS` on this TU to read block 1's
 *   ready list and luid/priority numbers directly, or the LAUNCH_BOOST route (`birthing_insn_p`
 *   needs REG_N_SETS==1) -- e.g. make the *avail temp MUTATED (2+ sets) so it can never boost above
 *   the subu.  Floor stands at 14; the mechanism note above is corrected, not the number. */
extern void iSNDpsxmemconstrain(unsigned int *size, int *avail)
{
    unsigned char *pd = sndpd;
    unsigned int lo;
    unsigned int s, diff;
    lo = *(unsigned short *)(pd + 0x51a);
    /* MATCH: enter the branch-local-diff basin, then keep `lo` as the equivalent
     * `s + diff`.  That dependency puts the subtraction at the block head.  The
     * zero-trip wrapper is a zero-insn ref-step dial: s refs 7->8, which restores
     * the oracle's a2/a3 handout after `lo` gains its second role. */
    do {
        s = *size;
    } while (0);
    if ((int)s < (int)lo) {
        diff = (unsigned int)lo - s;
        lo = s + diff;
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
     * The empty and scan-tail candidates use separate textual constrain sites, matching the lifetime split
     * recovered by IDA.  The packed four-byte shift is expressed as __builtin_memcpy so
     * CC1PSX emits the oracle's direct lwl/lwr/swl/swr sequence without an artificial value move.  Together
     * with in-place size rounding and the oracle-ordered failure label, these changes reduced the detailed
     * residual from 140 to 46 instructions.
     *
     * W34-a7 TRIED AND REVERTED (both move the INSN COUNT toward the oracle but raise the gate count,
     * so neither is a keep -- recorded so they are not re-derived):
     *  (a) scan_done against a FRESH `sndpd+0x51c` symbol (`pv = sndpd+0x51c; prev = idx*4 + pv;
     *      avail = pv[0] - block;`) instead of the loop's saved `previous`/`pd+0x51C`.  This IS what
     *      the oracle does (.L8010A740 emits its own `lui/addiu %hi/%lo(D_80147E34)` and reads the
     *      limit as `lhu $v1,0($v1)` off that fresh base), and it correctly adds the missing lui/addiu
     *      pair: 120 -> 122 insns (oracle 127).  But cse folds our limit read onto the %hi register
     *      (`lhu $v1,0x51C($a1)` + LO16) instead of onto `pv`, so the gate goes 59 -> 61.
     *  (b) splitting the shared `final_constrain:` label into TWO textual `iSNDpsxmemconstrain(...)`
     *      call sites (which is retail's shape -- retail shares ONLY the `jal` at .L8010A634 and
     *      duplicates the `addiu $a0/$a1,$sp` setup and both frame stores per arm).  gcc then
     *      re-colors the prologue base (`addiu $a1,$v0,%lo(sndpd)` instead of the oracle's `$v1`) and
     *      the whole function shifts: 59 -> 77 alone, 59 -> 87 combined with (a).
     * Both confirm the standing diagnosis: our two constrain arms merge deeper than retail's because
     * they END in the same hard registers, and that hard-register choice is upstream of any source
     * shape available here (same $v0/$v1 mirror as smemman.c iSNDmalloc's post-scan tail).
     *
     * W49-a7 NEGATIVE (transfer test): the USE-FENCE recipe that took the twin smemman.c iSNDmalloc
     * from 48 to 16 @135/135 (fence the block-offset + the base before forming the entry pointer, and
     * fence the offset again AFTER the add so combine_regs cannot tie the sum's dest to the dying
     * offset) does NOT transfer here -- scan_done fenced 61 @122, scan_done fenced on the OLD base 59,
     * the `idx != 0` arm fenced on `idx` 59, fenced on `previous`+`idx` 59.  Reason: iSNDmalloc was
     * 2 insns OVER the oracle and its residual really was a scheduling/fresh-dest question, whereas
     * this function is 7 insns SHORT and its gap is the un-merged `iSNDpsxmemconstrain` arms above --
     * a cross-jump-depth problem, not a schedule one.  Attack the arm merge first.
     *
     * W50-a7 ARM-MERGE PASS (the brief's assignment; no keep, but the mechanism is now NAMED and the
     * split basin is re-measured with the w47/w49 fence instruments):
     *   RE-MEASURED: split 76@121 | split+dbl 60@123 | split+dbl with per-arm temps 60@123 |
     *   split+dbl with a literal `return 0` tail instead of `goto fail` 62@123 | label-moved-to-just-
     *   before-the-call with per-arm stores 77@122 | fenced double-read of 0x51A (a value-numbering
     *   barrier so copy-prop cannot fold the second evaluation) 67@122 | commit-block index-offset
     *   hoisted + fenced 59@120 (exact no-op, 3rd independent confirmation that sched1 re-floats that
     *   `sll`) | prev-address respellings: offset-first 63, shared fenced `off` temp 63, plain shared
     *   `off` 59.
     *   ð´ THE REAL OBSTACLE IS NOT MERGE DEPTH, IT IS MERGE DIRECTION (new, from the raw objects).
     *   gcc's cross_jump keeps the copy that contains the LABEL and truncates the arm that ends in a
     *   JUMP (jump.c do_cross_jump redirects `insn` to `newlpos`).  Retail's tail arm is the jump side
     *   (`j .L8010A634` at A770) so the shared block sits AFTER THE EMPTY ARM.  Our split basin merges
     *   the other way round: the empty arm becomes the jump side and the shared block lands after the
     *   TAIL arm -- the instruction CONTENT of the split basin is right (the empty arm is byte-exact
     *   for its first 24 insns) but the two blocks are transposed, which is most of the 60.  Meanwhile
     *   the 59-diff baseline has the CORRECT block order and shares too much (5 of retail's 8 per-arm
     *   insns).  So the two available basins each hold one half of the answer.
     *   NEXT ANGLE (named, untried): get the split basin's merge to keep the EMPTY arm's copy -- i.e.
     *   make the empty arm's post-call tail the fall-through and the scan_done arm the one ending in
     *   a jump.  That is a block-ORDER question (catalog w42 "PHYSICAL BLOCK ORDER dominates"), not a
     *   fence question; the lever family is the arrangement of the `fail`/`return 0` tails, not the
     *   constrain call itself.  Do NOT re-spend budget on prev-address spellings or on the double
     *   read in isolation -- both are now falsified twice.
     *
     * W58 2026-08-11: the deliberate split+dbl step-back finally crossed the 59-diff floor.  A fresh
     * exact D_80147E34 tail base plus three nested one-trip wrappers around only that base definition
     * changes flow-reference pricing without emitted code.  Keeping the index offset unwrapped gives
     * the decisive asymmetric allocation: 46 diffs at exact 127/127 parity.  Wrapping both quantities
     * reaches parity too but scores 64; base depths 1/2 score 66/64, while depths 3/4 both score 46.
     * This is the expected multi-step hard-floor route: 59@120 -> 60@123 -> 46@127.
     *
     * W59 2026-08-12: stage `table = base + 0x520` before the nonempty count guard, but delay the
     * persistent `pd = base` copy and `previous` derivation until after it.  This is retail's exact
     * lifetime order: the count load/test stays on incoming $v1, the table add fills the branch slot,
     * then $v1 is copied to $s1.  It removes the three setup residual blocks: 46 -> 40 diffs at exact
     * 127/127 parity.  Re-tested basin-relative negatives: shared-label 75@122; scan-tail literal
     * return 44@127; direct indexed previous loads and offset-first respelling 46@127; prev-definition
     * one-trip depths 1/2/3 all 51@124.
     *
     * W60 2026-08-12: 40 -> 26, still exact 127/127.  The Sled Storm PSX twin and NFS4 Ghidra CFG
     * both show the empty-table failure as a direct return, separate from the post-scan failure.
     * Expressing those two returns textually stops gcc from cross-jumping the empty constrain/check
     * tail into the scan-done copy, restoring retail's duplicated jal/reload/compare block.  This
     * removes the whole 14-diff CFG cluster without disturbing iSNDpsxmemconstrain/iSNDpsxfree.
     * Remaining 26 are three exact-count allocation/scheduling clusters: previous-entry address
     * fresh-dest a2 vs coalesced v1, three missing/sunk `idx<<2` schedule copies, and the commit
     * table/address local handout.
     *
     * W61 2026-08-12: 26 -> 20 at exact 127/127.  Declaring the commit byte offset before the
     * table/address restores retail's three path-local `idx << 2` copies.  Two instruction-free
     * FF8-style ++/-- reference dials, on the saved block value and then the byte offset, cross the
     * local-alloc boundaries that keep the offset in v1 and the block value in v0.  Fork-corpus
     * follow-up falsified, in this basin: moving the offset dial after both stores 24; pointer
     * ++/-- 26; a function-scope/path-assigned offset 62@133; shared scan offset and early entry
     * capture both neutral at 20; scan offset/pointer ++/-- and identical-arm variants 36-45.
     * Remaining 20 are three count-exact local-allocation clusters: previous-entry address v1/a2,
     * scan-done offset/base a2,v0/v0,v1, and commit derived address v1/a1.
     *
     * W62 2026-08-12: 20 -> 18, still exact 127/127.  Move the existing instruction-free
     * commit_block ++/-- reference dial from before the two entry stores to between them.  This
     * changes only local-alloc/live-range pricing and improves the commit address/store cluster;
     * placing it after both stores regresses to 30, duplicating it before and between returns to
     * 20, and moving the entry_off dial before the stores regresses to 26.
     *
     * 🔴 W61-A19 2026-08-15 -- RE-GATED BASELINE WAS 40 @129/127 (ours 2 LONGER), NOT the 18/20
     * quoted by the W58..W62 fork-corpus notes above -- those numbers do NOT reproduce under this
     * repo's gate and must not be used as a baseline (re-gate first, standing rule).
     * 40 -> 26 AT COUNT-EXACT 127/127 with ONE source change: the return value is now computed
     * into a named `result` BEFORE the alloc-count read-modify-write (see the commit block).  The
     * two extra instructions were two load-delay `nop`s: `local_block`'s stack home may-alias the
     * `sndpd+0x518` store, so with the trailing `return local_block << 6;` the scheduler could not
     * hoist the reload over the count store and neither the count `lhu` nor the result `lw` got a
     * filler.  Retail interleaves them (`lw v0,16(sp); lhu v1,1304(a0); sll v0,v0,6; addiu v1,v1,1;
     * sh v1,1304(a0)`), which is exactly what the named result reproduces.
     * FALSIFIED in the NEW 26-diff basin (the w60-12D int-typed index-first `addu` operand lever,
     * re-tested per the LEVER-ORDER-DEPENDENCE law because the 40-diff readings were basin-stale):
     *   commit `entry = (unsigned short *)(entry_off + (unsigned int)table)` 26 (neutral) |
     *   scan `prev = (unsigned short *)((idx * 4) + (int)previous)` 32 | scan_done
     *   `prev = (unsigned short *)((int)off + (int)pv)` 26 (neutral) | all three 32 |
     *   commit+scan_done 26 | commit+scan 32.  (In the OLD 40-diff basin the scan form measured 46
     *   and the pair 46, so the lever is basin-relative but never a win here.)
     * RESIDUAL 26 = FOUR count-exact register clusters, all the same mirror the file has tracked
     * since w32 (ours/retail):
     *   (i)   the dead `sll ?,s0,2` in three branch delay slots: v0 / v1  (3 lines)
     *   (ii)  the scan entry address: `addu v1,s3,v0` / `addu a2,v0,s3` + its two `lhu` bases
     *   (iii) scan_done's base+offset: `sll a2` / `sll v0`, `addiu v0,v1,0` / `addiu v1,v1,0`,
     *         `addu a2,a2,v0` / `addu a2,v0,v1`
     *   (iv)  the commit address `addu v0,v0,a0` / `addu a1,v1,a0` + the `lhu v0,16(sp)` position
     *         (retail loads local_block BEFORE both entry stores, ours between them).
     * NEXT ANGLE (named, untried in THIS basin): allocsim MATCH check + `reqdelta --want` on the
     * scan/commit address pseudos -- the whole residual is now ONE consistent v0/v1/a2 rotation at
     * count parity, which is exactly the priced-dial shape (methodology 4.3), and every prior
     * spelling sweep in this file was run against a basin that was 7 insns SHORT.
     *
     * 🟢 W71-A15 2026-08-21 -- 26 -> 12, STILL COUNT-EXACT 127/127.  Clusters (i) and (iv) are
     * GONE: the whole commit block is byte-exact (the three-part recipe is receipted at the
     * `commit:` label below -- identity launder + depth-3 ref inflator + read position).  The
     * mechanism is combine_regs' output-to-dying-input tie, which is the SAME mechanism the
     * file's other residuals show, so the surviving 12 is now ONE question in TWO places:
     *   (ii) scan / idx!=0 arm  : ours `addu v1,s3,v0` + its two lhu bases;
     *                             retail `addu a2,v0,s3` + `lhu ?,0/2(a2)`   (3 lines)
     *   (iii) scan_done         : ours `sll a2,s0,2` / `addiu v0,v1,0` / `addu a2,a2,v0`;
     *                             retail `sll v0,s0,2` / `addiu v1,v1,0` / `addu a2,v0,v1`
     *                             (4 lines; note retail's pv is the SELF-temp `addiu v1,v1`
     *                             while ours splits high/lo_sum across $v1/$v0)
     * 🔴 THE LAUNDER DOES NOT TRANSFER TO scan_done, AND THE REASON IS STRUCTURAL, NOT A TIE:
     * scan_done ends in `j` to the SHARED iSNDpsxmemconstrain call, and ANY `__asm__` placed in
     * that block (launder on `off` before the add 28@125, after the add 37@124, launder on `pv`
     * 30@125) costs TWO INSTRUCTIONS -- the barrier lets cross_jump merge scan_done's
     * `addiu $a0,$sp,16 / addiu $a1,$sp,20` pair into the shared block, which retail duplicates.
     * So scan_done needs a NON-ASM device (or the arm-merge work named in the W50 note).
     * FALSIFIED IN THE 12-DIFF BASIN (all re-measured here per 04Z; none < 12):
     *   scan_done: index-first int sum 12 (neutral) | `off` typed `int` 12 (neutral) |
     *     `prev = &pv[idx*2]` 28@125 | `off` assigned after `pv` 28@125 | depth-2/3 inflator on
     *     the `pv[0]` read 30@129 | depth-2 inflator on the `prev` statement 36@125 |
     *     pv[0] hoisted before the block read 21@128 | pv-wrapper depth ladder 0/1/2/3/4/5 =
     *     40@125 / 32 / 14 / 14 / 14 / 14 (>=2 saturates; the W58 depth-3 is kept) |
     *     `D_80147E34` sized [1]/[2] 21@128, [4] 12, `&D_80147E34[0]` 12.
     *   scan arm: depth-2/3 wrapper on the `prev` decl 23@124 | depth-2/3 wrapper on the
     *     `block` sum 27@126 | two named half-temps for prev[0]/prev[1] 12 | `prev` declared
     *     first 12 | entry read hoisted above the block sum 12 | index-first int sum 18.
     *   commit: read-position and inflator-depth ladders are in the `commit:` receipt.
     *
     * W72-A20 2026-08-22 -- RE-GATED at 12, COUNT-EXACT 127/127 (baseline confirmed).
     * NO landing.  The brief's named angle was 21B-4 (a fresh literal + read-only fence
     * so two arms' setups use DIFFERENT registers) applied to scan_done, plus a re-price
     * of the depth ladder.  Both clusters were attacked; six new falsifications:
     *   (iii) scan_done -- the SERVING-ORDER reading of the residual (retail off=$v0 /
     *     pv=$v1 / sum=$a2; ours off=$a2 with pv SPLIT across $v1(hi)+$v0(lo_sum)) says
     *     `off` must be served before the la, so the ZERO-INSN REF INFLATOR was aimed at
     *     `off`'s DEFINITION for the first time (every prior ladder wrapped `pv`, the
     *     `pv[0]` read, or the `prev` statement):
     *       `do{...}while(0)` depth 1 / 2 / 3 on `off = idx * 4;` .... 12 / 12 / 12 (inert)
     *       depth 4 (crosses the floor_log2 step at 4->5 weighted refs) ....... 30 @127
     *     ⇒ the step IS reachable and the direction is WRONG -- raising `off`'s priority
     *       makes it worse, so `off` is not losing a serving-order race.  The real
     *       obstacle is the la being SELF-temped ($v1 holding both %hi and the lo_sum),
     *       which consumes the register pair `off` would otherwise get; that is the
     *       §3.15 self-temp-vs-separate-temp question on an ADDRESS, and the w71 ladder
     *       already falsified the declaration-shape lever for it (`D_80147E34` sized
     *       [1]/[2]/[4] and `&D_80147E34[0]`).  21B-4's "different registers" cannot be
     *       spelled here at all: the two arms that must stay unmerged end in the ABI arg
     *       registers $a0/$a1, which no source form can vary.
     *   (ii) the scan arm's `prev` -- the W71 COMMIT RECIPE transplanted (identity
     *     launder on the byte offset AFTER the sum, with a genuine LATER USE supplied,
     *     which is the ingredient the commit block needed and asinfunc.c cannot supply):
     *       `e_off = idx*4; entry = e_off + table; <launder e_off>;` and the else arm's
     *       `prev = previous + e_off` as the later use ....................... 14 @127
     *       (the launder hoists the `addu` above the `bnez` instead of freshening its
     *        dest -- the tie is not on the offset here, it is on `previous`)
     *     `prev = (unsigned short *)((unsigned int)(idx*4) + (unsigned int)previous)`
     *       -- the UNSIGNED index-first spelling, i.e. the exact form `entry` uses two
     *       lines above and which DOES give `entry` retail's fresh-dest index-first
     *       `addu $a1,$v0,$s4` ............................................... 18 @127
     *     the same with the operands swapped (base-first, unsigned) ..... 12 @127 (inert)
     *     `(idx << 2)` instead of `idx * 4` in that spelling ................ 18 @127
     *     ⇒ INFORMATIVE: `entry` and `prev` are the SAME expression shape over the same
     *       CSE'd `idx*4`, one gets retail's fresh dest and the other does not, and the
     *       source spelling provably does not decide it (the winning spelling, copied
     *       verbatim from the sibling, is the WORST one).  This is the local-alloc
     *       combine_regs tie the file has tracked since w32, and it is now bounded by a
     *       same-function control rather than by an argument.
     * ANGLE UNCHANGED: allocsim MATCH + `reqdelta --want` on the two address pseudos, in
     * THIS 12-diff basin (every prior priced attempt predates the w71 commit landing). */
    unsigned char *base = sndpd;
    unsigned char *pd;
    unsigned int blk, src;
    int          idx = 0;
    unsigned int local_block;
    int          local_avail;
    unsigned short count = *(unsigned short *)(base + 0x518);

    if (count >= 0x80)
        return 0;
    size += 0x3f;
    size >>= 6;
    if (count == 0) {
        local_block = (unsigned int)*(unsigned short *)(base + 0x51A);
        local_avail = (int)*(unsigned short *)(base + 0x51C) -
                      (int)*(unsigned short *)(base + 0x51A);
        iSNDpsxmemconstrain(&local_block, &local_avail);
        if (size <= local_avail)
            goto commit;
        return 0;
    }
nonempty:
    {
        unsigned char *table;
        unsigned char *previous;
        table = base + 0x520;
        if (idx >= (int)(unsigned int)
                       *(volatile unsigned short *)(base + 0x518))
            goto scan_done;
        pd = base;
        previous = pd + 0x51c;
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
                unsigned int block;
                int avail;
                unsigned short *prev =
                    (unsigned short *)(previous + idx * 4);
                block = (unsigned int)prev[0] + (unsigned int)prev[1];
                avail = *(unsigned short *)entry - (int)block;
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
            unsigned short *pv;
            unsigned int off = idx * 4;
            unsigned short *prev;
            do {
                do {
                    do {
                        pv = D_80147E34;
                    } while (0);
                } while (0);
            } while (0);
            prev = (unsigned short *)((unsigned char *)pv + off);
            local_block = (unsigned int)prev[0] + (unsigned int)prev[1];
            local_avail =
                (int)pv[0] - (int)local_block;
        }
    }
    iSNDpsxmemconstrain(&local_block, &local_avail);
    if (size > local_avail)
        return 0;
    goto commit;
commit:
    {
        unsigned short *entry = 0;
        unsigned int entry_off = idx * 4;
        unsigned char *table = sndpd + 0x520;
        unsigned short commit_block;
        unsigned char *commit_base;
        /* ============================================================================
         * MATCH (w71-a15, 2026-08-21): 26 -> 12, COUNT-EXACT 127/127, WHOLE COMMIT BLOCK
         * NOW BYTE-EXACT.  Three cooperating pieces; each was measured alone and in the
         * pair, and NONE of them lands without the other two (13F lever-order law).
         *
         * (1) IDENTITY LAUNDER ON `entry_off`, PLACED AFTER THE ENTRY ADD (26 -> 24).
         *     Retail forms the entry pointer into a FRESH register (`addu a1,v1,a0`);
         *     ours tied the sum's dest to the dying byte-offset pseudo (`addu v0,v0,a0`)
         *     because local-alloc's combine_regs (local-alloc.c:1866) ties an output to
         *     an input that dies in the same insn.  The zero-insn launder makes the
         *     pseudo die TWICE (once as the asm's input, once at the add), so
         *     combine_regs refuses the tie.  🔴 IT MUST HAVE A LATER USE or the asm is
         *     dead and deleted -- `commit_base`'s `- entry_off + entry_off` supplies it.
         *     Same lever falsified in scan_done, where `off` has no later use (below).
         *
         * (2) DEPTH-3 `do{}while(0)` REF INFLATOR ON THE local_block READ (24 -> 14).
         *     With (1) the sum is fresh but the block's two short-lived quantities were
         *     still SWAPPED (ours entry_off=$v0/local_block=$v1, retail the reverse).
         *     They do not overlap, so this is a SERVING-ORDER question:
         *     QTY_CMP_PRI = floor_log2(refs)*refs*size/live, and the launder itself
         *     handed entry_off two extra refs.  flow.c weights refs by loop depth and
         *     loop.c strips the phony loop, so the wrapper is zero-insn.  Depth ladder
         *     measured in this basin: 1 -> 26, 2 -> 24, 3 -> 14, 4 -> 14 (3 = cheapest).
         *
         * (3) THE READ'S POSITION: BETWEEN THE ENTRY ADD AND THE LAUNDER (14 -> 12).
         *     Statement position is the sched1 luid dial and it is NOT free to choose:
         *     read before the add 14 | read between add and launder 12 (kept) |
         *     read after the launder 24 | read after `commit_base` (its old home) 26.
         *     At 14 the registers were already retail's but the `addu a1` / `lhu v0`
         *     pair issued in the wrong order; moving the read one statement later fixes
         *     the order without disturbing the handout.
         *
         * ALSO CLOSED HERE: the two former net-zero `entry_off++/--` and
         * `commit_block++/--` "reference dials" (W61/W62 fork-corpus receipts) are DEAD
         * CODE in this repo's gate -- 26 with and without them, i.e. exactly the W64-16A
         * net-zero-pair adjudication.  Both removed; entry_off's is replaced by (1).
         * ============================================================================ */
        entry = (unsigned short *)(table + entry_off);
        do { do { do { commit_block = (unsigned short)local_block; } while (0); } while (0); } while (0);
        __asm__("" : "=r"(entry_off) : "0"(entry_off));
        commit_base = (unsigned char *)
            ((unsigned int)table - entry_off - 0x520 + entry_off);
        entry[1] = (short)size;
        entry[0] = commit_block;
        {
            /* MATCH (w61-a19, 40 -> 26 at COUNT-EXACT 127/127): retail computes the RETURN VALUE
             * (`lw v0,16(sp); sll v0,v0,6`) INTERLEAVED with the alloc-count read-modify-write,
             * which fills both load-delay slots.  Written as a trailing `return local_block << 6;`
             * the reload sits after the count store and gcc pays TWO nops -- `local_block`'s stack
             * home may-alias the sndpd store, so the scheduler may not hoist the load over it.
             * Naming the result BEFORE the RMW puts the load on retail's side of the store and the
             * `sll` becomes the count-load's delay filler. */
            int result = (int)(local_block << 6);
            *(unsigned short *)(commit_base + 0x518) =
                *(unsigned short *)(commit_base + 0x518) + 1;
            return result;
        }
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
