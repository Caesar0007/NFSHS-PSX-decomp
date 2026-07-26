/* eaclib/psx/sndpsxz/salloc.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/4 PASS ***
 *   Source obj : nfs4\eaclib\psx\salloc.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800FE724 .. 0x800FEDC4].  Sound-channel allocation/arbitration (no SPU pokes -- pure
 *   priority logic over the channel pool sndgs[0x25]).  Ghidra nfs4-f.exe.c L163749..164019.
 *
 *   Channel slot (100 bytes, pool base = sndgs[0x25], count = (byte)sndgs[0x11]):
 *     +0x00 owning tag (id|priority)   +0x0B in-use state (0 free / 1 held / 2 linked)
 *     +0x0C age   +0x10 alloc timestamp   +0x3C link-back   +0x3D..  voice fields
 */

extern int           sndgs[];
extern signed char    sndchanreserved[];       /* scratch list of chosen channel indices */
extern int           DAT_80136dec[];             /* rolling allocation id counter (+=0x20); OWNED by
                                                  snddata.c (strong def there). MATCH: must stay a pure
                                                  extern HERE -- a local tentative def would make it
                                                  small-common/gp-rel, but the oracle reaches it ABSOLUTE
                                                  (lui/lw; sec 3.12 #6 caveat: no %gp_rel oracles). */
extern int  SNDstop(unsigned int tag);                          /* sstop  */
extern int  SNDover(unsigned int tag);                          /* sover  */
extern int  DAT_801478f4;                                      /* channel-pool pointer (sndgs + 0x94) */

extern int iSNDischanreserved(int chan, int count);             /* @0x800FE724 */

#define SNDNUMCHAN (((unsigned char *)sndgs)[0x11])  /* sndgs[4]._1_1_ : channels in the pool */

/* iSNDischanreserved @0x800FE724 : is channel `chan` already in the chosen list (first `count` entries)? */
extern int iSNDischanreserved(int chan, int count)
{
    int i;
    for (i = 0; i < count; i++)
        if ((signed char)sndchanreserved[i] == chan)
            return 1;
    return 0;
}

/* iSNDallocchan @0x800FE764 : reserve `numChannels` voices for a sound, honouring the `priority` channel
 *   mask.  First takes idle channels (lowest timestamp), then -- if short -- steals the lowest-age /
 *   lowest-timestamp busy channels (stopping their current sound, rolling back on refusal).  Writes the
 *   allocation id to *out and returns the primary channel index, or -9 on failure.
 *     priority = channel-eligibility bitmask;  numChannels = voices needed;  a2 = a voice flag byte.
 * RAW/CROSS-VERSION REDUCTION (2026-07-26, 416->274 detailed diffs; 298/298 instructions):
 *   NFS4 PC tagged_play.c, NFS3 isnd.c, NFS2b alloc2.c and PC-beta salloc.obj all confirm the two-pass
 *   selection/rollback/link algorithm.  The PSX oracle separately holds a bare sndgs base through each
 *   selection pass, so block-scoped bases reproduce those lifetimes; removing a redundant outer
 *   positive-count guard restores the raw pass-to-pass CFG; and the chosen-slot array is signed byte
 *   storage (`-1` sentinel), recovering the oracle's literal materialization without disturbing the
 *   exact iSNDischanreserved/iSNDgetchan neighbors.  A pass-local pointer to the current chosen slot
 *   keeps the selected-array lifetime live across the scan calls; that reproduces the retail 72-byte
 *   frame and caller-saved numChannels spill/reload family.  Retail's eligibility test is a signed
 *   `1 << c` expression (sllv/and), not the compiler-canonicalized unsigned srlv/andi form.
 *   W32-a7 (2026-07-26, 277->260 diffs, 303->302 insns) added three IDA-register-map-driven fixes:
 *   the sequence counter uses the UNSIZED-ARRAY shape so ONE `lui %hi` base serves the load and both
 *   stores (the scalar extern left each store to the assembler's `$at` macro, +2 insns); `gs` is
 *   assigned INSIDE each pass loop so loop.c hoists the `la` into the PREHEADER, after the entry
 *   guard, matching the oracle's slt/beqz-then-la order; and the pass-2 age local is an `int`, not a
 *   `u_char`, killing a per-use `andi ..,255` (the oracle compares with a bare `slt`).
 *   IDA sub_800FE764's per-variable annotations are the retail allocation: reserved=$s7, pass
 *   counters=$s3, chosen=$s4, bestval=$s5, c=$s1, off=$s2, slot=$s0, numChannels=$t0 (a CALLER-saved
 *   reg spilled to sp+0x18 across every iSNDischanreserved call and reloaded), and the -9 result on
 *   the FRAME at sp+0x10.  Ours matches that whole layout except for two swapped pairs, s6<->s7 and
 *   t1<->t2 -- i.e. the residual is one allocno-priority rotation, not a shape error.  Two levers were
 *   tried and REVERTED for making it worse: the index form `sndchanreserved[reserved]=best` reaches
 *   297/298 instructions but explodes the coloring to 401 diffs (the pass-local `selected` pointer is
 *   load-bearing), and `int bestage` regresses to 297.
 *   W33-a7 (2026-07-26): the SLD lever asked for by the wave brief DOES NOT EXIST for this obj (0
 *   line records across the whole sndpsxz VA span -- see sdmemman.c's header for the proof and the
 *   pad.c consequence), and the compiler-snapshot axis is closed: gcc 2.8.1 output is BYTE-IDENTICAL
 *   to our 2.8.0 here (260 both), gcc 2.7.2 is far worse and mis-counts (541 diffs, 293 insns vs the
 *   oracle's 298).  Two more levers tried and REVERTED: `int bestage` (292, already recorded above as
 *   297 in w32) and a goto-loop pass-2 with the label reused for entry+continuation (284; it does not
 *   collapse the duplicated `li s3,102` loop-head init).  The residual is still the s6<->s7 / t1<->t2
 *   allocno rotation.  Re-audited against the wave's three-way copy taxonomy and BOTH source-reachable
 *   mechanisms are absent here: the copy counts are SYMMETRIC (13 oracle-only `addu rX,rY,zero` with
 *   matching ours-only lines -- a pure permutation, no asymmetric copy to explain, so no cse.c
 *   double-evaluation target), and the loop.c giv anchor cannot apply because both passes walk the
 *   100-byte channel slot, which is not a power-of-two stride.
 *   W34-a8 (2026-07-26, 260 -> 255 diffs, 302 -> 301 insns).  The w32 verdict that the index form
 *   "explodes the coloring" was an ARTEFACT of a missing allocno, not a property of the index form.
 *   Retail's pass-1 store IS the index form -- the oracle computes `addu $v0,$s7,$fp; sb $s4,0($v0)`
 *   in the `bltz` block, i.e. base+reserved AT THE STORE, not a pass-local slot pointer built at the
 *   loop head.  Adopting it alone drops us to EXACT 298/298 instructions but moves `numChannels` out
 *   of retail's caller-saved $t0 (with its `sw/lw 0x18($sp)` caller-save pair around every
 *   iSNDischanreserved call) into the freed $s8 -- because the pass-local pointer had been the NINTH
 *   callee-saved pseudo that pushed numChannels out of the callee-saved pool.  The faithful ninth
 *   pseudo is the CHANNEL-SLOT POINTER: retail keeps it in $s0 in BOTH passes, and in pass 1 it is
 *   live across the `jal` (`lw $v1,0x10($s0)` after the call), so ONE function-scope `ch` shared by
 *   the two passes is call-crossing => callee-saved => numChannels returns to $t0 with the exact
 *   caller-save pair.  Two block-local `int ch` declarations are two pseudos and let pass 2's copy
 *   land in a caller-saved reg, which is what had been hiding the whole allocation.
 *   Pass-1 head order also follows the oracle now: `bestval = best;` sits BEFORE the channel-count
 *   guard (retail `addu $s5,$s4,$zero` at the loop head, both -1 so cse emits a copy) and `c = 0;
 *   off = c;` INSIDE it (`addu $s1,$zero,$zero` in the beqz delay slot, then `addu $s2,$s1,$zero`).
 *   Pass 1 is now instruction-EXACT except for ONE residual: retail hoists `la sndchanreserved` into
 *   the loop PREHEADER ($fp, 2 insns once) while ours rematerializes it inside the store block (2
 *   insns, +1 net) and LICM-hoists the `1` of `1 << c` into $s8 instead.  Named-pointer spellings do
 *   NOT reach it -- a local holding a SYMBOL_REF is constant-propagated back to its use sites and
 *   rematerialized (verified with the pointer assigned inside the body, before the loop, and shared
 *   with pass 2: all three produce byte-identical output).  Reaching retail here needs a lever that
 *   keeps a constant address allocno alive, not another spelling.
 *   W34-a8 continued (255 -> 245 diffs, 301 -> 299 insns), three more oracle-shape corrections, all
 *   confirmed by the NFS2 PC-beta NAMED salloc.obj source (pc-split/salloc.obj/iSNDallocchan.c, the
 *   direct ancestor of this function):
 *   (a) PASS-2 ARMS ARE INDEPENDENT, only `best = c;` is shared.  The NFS2 named source is
 *       `if (age < bestage) { bestage = age; bestv = ch->ts; best = c; }
 *        else if (age == bestage && ch->ts < bestv) { bestv = ch->ts; best = c; }`
 *       and gcc CROSS-JUMPS the two `best = c;` copies into retail's single `.L98C: addu $s4,$s1`
 *       reached by `j` from arm 1.  The previous goto-merged form (one shared `best = c; bestv = v;`
 *       tail fed by a `v` temp) put BOTH copies in the shared tail, which retail does not do -- retail
 *       loads arm 1's timestamp straight into bestv (`lw $s5,0x10($s0)`) and puts `bestage = age` in
 *       the `j` delay slot.  Duplicating the `ch->ts` load in the source is free: cse folds it.
 *   (b) ASSIGNMENT ORDER inside a winning arm is `bestval = ts;` THEN `best = c;` in BOTH passes
 *       (retail `addu $s5,$v1,$zero; addu $s4,$s1,$zero`); the reverse order costs 2 diffs.
 *   (c) THE SCAN LIMIT IS RE-READ INTO A TEMP BEFORE THE COUNTER INCREMENT.  Retail's loop tail is
 *       `lbu $v0,0x11(base); addiu $s1,$s1,1; slt; bnez; addiu $s2,$s2,0x64` -- the increment fills
 *       the lbu's LOAD-DELAY slot.  With the count re-read as part of the `while` condition our
 *       scheduler emits `addiu; lbu; nop; slt` (+1 insn per pass).  Writing `limit = gs[0x11];`
 *       as its own statement ahead of `c++` gives the load the earlier luid and reproduces retail's
 *       order in both passes (-2 insns).
 *   OPEN (pass 1, the last 1-insn structural gap): retail hoists `la sndchanreserved` into the pass-1
 *   PREHEADER ($fp) and leaves `li 1` of `1 << c` inside the inner loop, while ours does the opposite
 *   (LICM hoists `li fp,1`; the la is rematerialized inside the `bltz` store block).  A named base
 *   pointer does NOT reach it: `signed char *chosen = sndchanreserved;` was tested at three source
 *   positions (inside the loop body, before the loop, and shared with pass 2's store so it has two
 *   uses) and ALL THREE compile byte-identically to the plain array form -- a pseudo whose only set
 *   is a SYMBOL_REF gets a constant REG_EQUIV and is rematerialized at its uses, so no spelling can
 *   keep it in a register.  The remaining residual is that one hoist plus the $s6<->$s7 rotation.
 *   Raw nfs4-f.exe EEF64..EF40B SHA-256:
 *   4af4cae9357cee8d5c94a064c543b15d4d1edb7a6f5d1c0d5ccd8c8f259740fc. */
extern int iSNDallocchan(unsigned int priority, int numChannels, int a2, unsigned int *out)
{
    int          reserved = 0;
    int          result = -9;
    int          i, k, off, ch, limit;
    unsigned int best, c, v, bestval;

    for (i = 0; i < numChannels; i++)               /* clear the chosen list */
        sndchanreserved[i] = 0xff;

    /* MATCH: unsized-array shape (methodology 3.12 #5).  The oracle keeps ONE `lui $v1,%hi` base
     * alive across the load AND both stores (`lw/sw ...,%lo(D_80136DEC)($v1)`); the scalar-extern
     * form folds the %hi into the load's own dest and then leaves each store to the assembler's
     * `$at` macro -- two extra `lui $at` instructions we do not want. */
    DAT_80136dec[0] += 0x20;                         /* fresh allocation id */
    if (DAT_80136dec[0] < 0)
        DAT_80136dec[0] = 0;

    /* pass 1: take idle channels (state 0), preferring the oldest (lowest +0x10) */
    {
            unsigned char *gs;
            /* MATCH: pass 1 counts from `reserved` like pass 2 (oracle slt i,numChannels with the
             * reserved copy in the delay slot -- an i=0 form const-folds the guard into blez).
             * `gs` is assigned INSIDE the body so loop.c hoists it to the PREHEADER (after the
             * entry guard), matching the oracle's `slt/beqz` then `lui/addiu` order; a block-scope
             * initialiser put the la ABOVE the guard. */
            for (i = reserved; i < numChannels; i++) {
                gs = (unsigned char *)sndgs;
                best = 0xffffffff;
                bestval = best;
                if (gs[0x11] != 0) {
                    c = 0;
                    off = c;
                    do {
                        if ((priority & (1 << c)) != 0) {
                            ch = *(int *)(gs + 0x94) + off;
                            if (*(signed char *)(ch + 0xb) == 0 &&
                                iSNDischanreserved(c, reserved) == 0) {
                                v = *(unsigned int *)(ch + 0x10);
                                if (v < bestval) { bestval = v; best = c; }
                            }
                        }
                        limit = gs[0x11];
                        c++; off += 100;
                    } while ((int)c < limit);
                }
                if (-1 < (int)best) {
                    sndchanreserved[reserved] = (unsigned char)best;
                    reserved++;
                }
            }
        }
    /* pass 2: short of channels -> steal busy ones by lowest (age, timestamp) */
    {
            unsigned char *gs;
            for (k = reserved; k < numChannels; k++) {
                unsigned char bestage = 0x66;
                unsigned int  bestv;
                gs = (unsigned char *)sndgs;
                best = 0xffffffff;
                bestv = best;
                if (gs[0x11] != 0) {
                    c = 0;
                    off = c;
                    do {
                        if ((priority & (1 << c)) != 0 &&
                            iSNDischanreserved(c, reserved) == 0) {
                            ch = *(int *)(gs + 0x94) + off;
                            if (*(unsigned char *)(ch + 0xc) < 0x65) {
                                /* MATCH: `age` is an int -- the oracle re-loads the byte with a
                                 * bare `lbu` and compares with no `andi ..,255` re-mask; a u_char
                                 * local re-masks on every use (methodology 3.12 #9). */
                                int age = *(unsigned char *)(ch + 0xc);
                                if (age < bestage) {
                                    bestv = *(unsigned int *)(ch + 0x10);
                                    bestage = age;
                                    best = c;
                                } else if (age == bestage &&
                                           *(unsigned int *)(ch + 0x10) < bestv) {
                                    bestv = *(unsigned int *)(ch + 0x10);
                                    best = c;
                                }
                            }
                        }
                        limit = gs[0x11];
                        c++; off += 100;
                    } while ((int)c < limit);
                }
                if (-1 < (int)best) {
                    sndchanreserved[reserved] = (unsigned char)best;
                    reserved++;
                    if (numChannels <= reserved)
                        break;
                }
            }
        }

    if (reserved == numChannels) {                   /* got them all -> commit */
        *out = DAT_80136dec[0] | (int)(signed char)sndchanreserved[0];
        result = (int)(signed char)sndchanreserved[0];
        i = 0;
        if (0 < reserved) {
            do {
                int *ch = (int *)(sndgs[0x25] + (signed char)sndchanreserved[i] * 100);
                unsigned int owner = *(unsigned int *)ch;
                if (*(char *)((int)ch + 0xb) == 1) {        /* currently held -> stop it */
                    if ((int)owner < 0)
                        owner = *(unsigned int *)((signed char)ch[0xf] * 100 + sndgs[0x25]);
                    SNDstop(owner);
                    if (SNDover(owner) != 1) {              /* refused -> roll back */
                        while (i = i - 1, -1 < i)
                            *(char *)(sndgs[0x25] + (signed char)sndchanreserved[i] * 100 + 0xb) = 0;
                        return -9;
                    }
                }
                *(char *)((int)ch + 0xb) = 1;
                ch[4] = sndgs[0x11];                        /* timestamp */
                *(char *)((int)ch + 0xc) = (char)a2;        /* voice flag byte */
                i++;
            } while (i < reserved);
        }
        /* link the secondary channels to the primary */
        *(unsigned int *)((signed char)sndchanreserved[0] * 100 + sndgs[0x25]) = *out;
        for (i = 1; i < reserved; i++) {
            *(unsigned char *)(i + (signed char)sndchanreserved[0] * 100 + sndgs[0x25] + 3) =
                sndchanreserved[i];
            *(unsigned int *)((signed char)sndchanreserved[i] * 100 + sndgs[0x25]) = 0xffffffff;
            *(unsigned char *)((signed char)sndchanreserved[i] * 100 + sndgs[0x25] + 0x3c) =
                sndchanreserved[0];
        }
    }
    return result;
}

/* iSNDfreechan @0x800FEC0C : release channel `chan`. Honours linked-channel groups (a stereo/multi voice
 *   only frees when its partners are also done). NFS3/NFS4 confirm the void ABI and primary-state 1->2
 *   protocol; NFS2/NFS2B use only the simpler ungrouped release. The recovered three-release-block CFG
 *   and storage model improve the authoritative residual from 177 to 107 diffs (109/110 instructions).
 *
 * 🔴 ALLOCNO FLOOR (w32-a7, 2026-07-26) -- the whole 79-diff residual is ONE register permutation in a
 *   LEAF function, and the RTL dumps say our allocator cannot reach retail's.  IDA sub_800FEC0C gives
 *   retail's map verbatim: count=$t0, initialSlot/idx/recomputed-slot=$a1, group=$a3, partner=$a2,
 *   scan=$v1, result=$v0, partner*100=$a3 (reused after group dies).  Ours (cc1 -dg, "16 regs to
 *   allocate: 96 94 87 86 134 127 82 154 95 107 81 83 85 116 108 80"; dispositions 87->3 83->5 82->7
 *   81->9 85->10) is a PERMUTATION of the SAME hard-reg set {v1,a1,a2,a3,t0,t1,t2}: base=$a1,
 *   slot=$v1, count=$a3, group=$t1, pool=$t2.  The decisive allocno fact is the PRIORITY inversion on
 *   two pseudos with IDENTICAL ref counts: 87 (initialSlot) "used 4 times across 7 insns" outranks 83
 *   (&sndgs) "used 4 times across 28 insns", so 87 takes $v1 first and 83 falls to $a1 -- retail has
 *   them the other way round.  The live-length gap is structural, not source-set: every path inside
 *   `if (group)` RETURNS, so initialSlot is live only over the short group==0 fall-through while
 *   &sndgs is additionally live inside the scan; no re-spelling of the C changes either count.  The
 *   oracle's 3 extra instructions are downstream consequences (`addu $t2,$v1,$zero`/`addu $v1,$t1,$zero`
 *   to free $v1 for the scan; a `nop`-vs-`addiu %lo` delay-slot fill).  Levers tried and REVERTED:
 *   dropping the `volatile` casts (109/110 insns -- closer parity -- but loop.c then strength-reduces
 *   the scan into TWO walking pointers, 101 diffs) and a label+goto scan loop (107 insns, 111 diffs).
 *   The `volatile` casts here are therefore load-bearing giv blockers, not decoration.  Same family as
 *   methodology sec-3.25-3d (per-obj old-gcc identity); route to the toolchain-identity investigation.
 *
 *   ✅ W33-a7 CUT 79 -> 74 diffs, 107 -> 108 insns (oracle 110), via the cse.c DOUBLE-EVALUATION
 *   mechanism (a3's w33 census, class 2): retail's otherwise inexplicable `addu $t2,$v1,$zero` is NOT
 *   an allocator artefact -- it is cse rewriting a SECOND textual evaluation of `base[0x11]` into a
 *   copy of the first load's register.  Retail's guard compares against the loaded reg ($v1) and the
 *   loop against the copy ($t2), so the guard holds the FIRST evaluation and the loop's `limit` is the
 *   SECOND.  Spelling that literally -- `if (idx < (int)base[0x11]) { limit = base[0x11]; ... }`
 *   instead of hoisting one `limit` above the guard -- reproduces the copy exactly.  Anything that
 *   folds the two evaluations back together (one named local used twice) loses it again.
 *
 *   W33-a7 (2026-07-26): SLD cannot adjudicate this fn's variable set -- there are ZERO line records
 *   for it (proof + consequences in sdmemman.c's header).  The base-pointer-uniform rewrite (every
 *   `sndgs[0x25]`/`sndgs[0x11]` written as `*(int*)(base+0x94/0x44)`, aimed both at the tail's
 *   `la sndgs`-vs-fused-`%lo` diff and at raising the base pseudo's ref count so it outranks
 *   initialSlot) is WORSE: 92 diffs at 100/110 insns, because cse then folds the rematerializations
 *   away.  The 3-instruction gap to retail decomposes as: retail's extra `addu $t2,$v1,$zero` limit
 *   copy (retail loaded the limit into $v1 and must free it for the scan; ours loads straight into
 *   $t0 -- OURS IS SHORTER for a real reason), a duplicated `lui %hi(D_801478F4)` retail parks in a
 *   branch delay slot, and the `la sndgs` + `lw 0x44` tail where ours fuses `lui;lw %lo`.  Per the
 *   methodology discriminator an "ours-shorter / oracle's extra insn is a redundant reg-to-reg move"
 *   residual is a PERMUTER multi-basin case, not an accept -- but iSNDpsxmemconstrain (31/31, 14
 *   diffs) is a strictly cheaper and cleaner exhibit of the SAME allocator decision, so run that
 *   one first.  Compiler sweep: gcc 2.8.1 == our 2.8.0 (79 both); gcc 2.7.2 = 110 diffs @112 insns.
 *
 *   W34-a8 (2026-07-26): UNCHANGED at 74 diffs / 108 insns, but the 2-instruction gap is now
 *   LOCALIZED.  A block-by-block count shows every block equal (14 / 28 / 16 / 26 insns on both
 *   sides); BOTH missing instructions are in the LAST block (retail ED5C..EDC0 = 26, ours 24), and
 *   both are reorg consequences of the register permutation, not of the C shape:
 *     (i) retail pays a `nop` in the `bne $v1,$v0` delay slot and recomputes `sll $v0,$a2,1` inside
 *         the block, where ours steals that shift into the slot -- in retail's assignment the
 *         shift writes the branch's own compare register, so `resource_conflicts_p` refuses it;
 *    (ii) retail reaches the final `sndgs[0x11]` through a REMATERIALIZED base -- `lui;addiu` split
 *         across two branch delay slots plus one duplicated `addiu %lo` at the join, then
 *         `lw $v0,0x44($v0)` -- where ours fuses `lui; lw %lo(sndgs+0x44)` (2 insns).
 *   Rewriting JUST that one site as a base-pointer read `*(int *)(base + 0x44)` (the targeted form
 *   of the whole-function rewrite already recorded above as worse) goes the WRONG WAY: 75 diffs at
 *   107 insns, because cse then shares the top-of-function base instead of rematerializing.
 *   NFS2 PC-beta contributes nothing to this function: its salloc.obj `_iSNDfreechan` is a
 *   THREE-LINE ungrouped release (`chan[i].state = 0;`) with no linked-group protocol at all, so
 *   the whole group/partner CFG is NFS3/NFS4-era and has no named-source ancestor to copy. */
extern void iSNDfreechan(int chan)
{
    unsigned int group;
    int count = 0;
    unsigned char *base = (unsigned char *)sndgs;
    int pool = *(int *)(base + 0x94);
    int partner = -1;
    unsigned char *initialSlot = (unsigned char *)(pool + chan * 100);
    group = initialSlot[0x37];

    if (group != 0) {
        int idx = count;
        int limit;
        unsigned char *scan;

        if (idx < (int)base[0x11]) {
            limit = base[0x11];
            scan = (unsigned char *)pool;
            do {
                if (*(volatile unsigned char *)(scan + 0x37) == group &&
                    0 <= *(volatile int *)scan &&
                    *(volatile signed char *)(scan + 0xb) != 0 &&
                    (count++, *(volatile unsigned char *)(scan + 0x36) != 0))
                    partner = idx;
                idx++;
                scan += 100;
            } while (idx < limit);
        }

        {
            int slot = sndgs[0x25] + chan * 100;

            if (count == 1) {
                *(unsigned char *)(slot + 0xb) = 0;
                *(int *)(slot + 0x10) = sndgs[0x11];
                return;
            }

            {
                int partnerOffset = partner * 100;

                /* MATCH (diff-neutral under the current coloring, but oracle-truer): the scaled
                 * partner offset is the FIRST addu operand -- the oracle emits `addu $v0,$a3,$v1`
                 * / `addu $a3,$v0,$v1`, and addu operand order IS part of the encoding, so this
                 * only stops showing as a diff once the register permutation above is solved. */
                if (*(signed char *)(partnerOffset + sndgs[0x25] + 0xb) == 2 &&
                    chan != partner && count == 2) {
                    *(unsigned char *)(slot + 0xb) = 0;
                    *(int *)(slot + 0x10) = sndgs[0x11];
                    *(unsigned char *)(partnerOffset + sndgs[0x25] + 0xb) = 0;
                    *(int *)(partnerOffset + sndgs[0x25] + 0x10) = sndgs[0x11];
                    return;
                }

                {
                    int partnerSlot = partner * 100 + DAT_801478f4;
                    if (*(signed char *)(partnerSlot + 0xb) == 1 && chan == partner) {
                        *(unsigned char *)(partnerSlot + 0xb) = 2;
                        return;
                    }
                }

                *(unsigned char *)(slot + 0xb) = 0;
                *(int *)(slot + 0x10) = sndgs[0x11];
                return;
            }
        }
    }

    initialSlot[0xb] = 0;
    *(int *)(initialSlot + 0x10) = sndgs[0x11];
}

/* iSNDgetchan @0x800FEDC4 : resolve a sound tag back to its channel index, validating that the channel is
 *   still held by that exact tag.  Returns the channel, or a negative error. */
extern int iSNDgetchan(unsigned int tag)
{
    unsigned char *base;
    int ch;   /* signed -- oracle compares via slt (both operands non-negative so behavior is unchanged) */
    if ((int)tag < 0)
        goto invalid;
    base = (unsigned char *)sndgs;   /* materialize bare &sndgs first (no offset folded into %lo) */
    ch = tag & 0x1f;
    if (ch < base[0x11])
        goto valid_range;
invalid:
    return -8;
valid_range:
    {
        int *slot = (int *)(*(int *)(base + 0x94) + ch * 100);
        if (*(signed char *)((int)slot + 0xb) == 0 || *(unsigned int *)slot != tag)
            ch = 0xfffffff8;
        return ch;
    }
}
