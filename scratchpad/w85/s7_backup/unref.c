/* W52-A7 GCC-LADDER RECEIPT (2026-08-09) -- THE COMPILER-VERSION AXIS IS CLOSED FOR eacpsxz.
 * Every residual in this TU was A/B'd across the FULL windows-gcc-psx ladder on UNCHANGED
 * source, on BOTH axes:
 *   (a) ladder lane  NFS4_FORCE_CC1_ALT=<ver>  (272 recipe: macro cc1 + direct GNU-as reorder,
 *       NO maspsx) -- changes compiler AND assembler route at once; and
 *   (b) VERSION-ONLY axis  NFS4_CC1=<ladder>/cc1.exe  (normal compile_c, maspsx KEPT) -- the
 *       clean single-variable experiment.  Use (b) to read a version verdict; (a) confounds.
 * WHOLE-CLUSTER TOTALS, 68 TUs / 244 fns, version-only axis:
 *   default(psq43 CC1PSX)  232 PASS / 173 diffs   <-- the wired lane, WINS
 *   ladder 2.8.0           232 PASS / 173 diffs   <-- BIT-IDENTICAL to psq43 CC1PSX on all 244
 *   ladder 2.8.1           232 PASS / 172 diffs   (+1 F->P nsync, -1 P->F nfile FILE_operror)
 *   2.7.2-970404            61 PASS / 2422        2.7.2  51 / 5855   (SN 2.7.2 == FSF 2.7.2,
 *   2.6.0 / 2.6.3           50 PASS / ~4925        verified via the ladder lane)
 *   2.91.66 92 / 6832       2.95.2 95 / 6881
 * ==> eacpsxz's compiler IS gcc 2.8.0 -- the rung already wired.  NO rung beats it.  Any
 * residual in this file that a prior wave routed to "the toolchain-identity / old-gcc-cse /
 * allocno_compare-delta investigation" is hereby FALSIFIED on the VERSION axis: it is not a
 * gcc-version question.  Remaining candidate axes: per-obj FLAGS (3.25-3d), the assembler
 * route, or source.  Do NOT re-run the ladder on this TU.
 * PER-FN LADDER NUMBERS (version-only axis; 'P' = PASS):
 *   unrefpack      def 12 | 2.6.0 16 | 2.6.3 16 | 2.7.2-970404 21 | 2.7.2 21 | 2.8.1 13 | 2.91.66 27 | 2.95.2 23
 */
/* eaclib/psx/eacpsxz/unref.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\unref.obj ; EACPSXZ.LIB.  2 fns @[0x800F52B8 .. 0x800F5530].  EA RefPack decompressor
 *   (unrefpack) + the unbtree tree-node expander (chase).  Ghidra nfs4-f.exe.c (unref) + disasm-v3 + IDA sigs.
 *   Every puti() writes 4 bytes (delay-slot a2=4 -- the RefPack "over-write 4, advance by the real count"
 *   trick; the cursor advances via the back-reference arithmetic).  refcpy/memcpyl live in unhuff.obj.
 */
/* MATCH: chase's oracle reaches all four via %gp_rel -- tentative defs (mergeable
 * .comm; unbtree.c tentative-defines the same set, the linker folds them).
 * SYM-SHARED-COMMON: SQVd
 * SYM-SHARED-COMMON: SQVclue
 * SYM-SHARED-COMMON: SQVleft
 * SYM-SHARED-COMMON: SQVright */
int SQVd;       /* destination cursor (shared with unbtree) */
int SQVclue;    /* clue table base */
int SQVleft;    /* node left-child table base */
int SQVright;   /* node right-child table base */

extern unsigned int   geti(void *p, char nbits);               /* getm */
extern void           puti(unsigned char *buf, unsigned int val, int n); /* textcrnt */
extern unsigned char *refcpy(unsigned char *src, unsigned int count, int len); /* unhuff */
extern void           memcpyl(char *dst, char *src, int len);  /* unhuff */

extern int  unrefpack(unsigned char *comp, unsigned char *out, int reverse); /* @0x800F52B8 */
extern void chase(unsigned int code);                                               /* @0x800F5530 */

/* unrefpack @0x800F52B8 : decompress RefPack stream `comp` into `out` (only if `reverse` != 0, else size-query);
 *   returns the 24-bit uncompressed size.
 * RAW/ORACLE REDUCTION (2026-07-26, 103->33 diffs; 153/158 instructions): the retail body keeps a
 * separate mutable byte cursor derived from `comp` while mutating the output parameter directly.
 * That lifetime puts source in $s2 and output in $s3 and removes the whole saved-register cascade;
 * declaring that cursor before the result accumulator also matches the retail saved-register setup,
 * while the literal-run length reuses the mutable third parameter for the retail $s0 schedule.
 * w32-a4 (33 -> 17 diffs): every command arm's `count` is built from TWO terms, and written as a
 * single sum gcc both reassociates the `+1` onto the FIRST term and evaluates the terms in the
 * wrong order -- giving each term its own named statement (hi/lo) reproduces the oracle's exact
 * operand order and `addiu vN,vN,1` placement in all three arms (same lever as memstd's
 * `gran + 0x0F` / resize's `align + 15`).
 * RESIDUAL 17 (ours 153 / oracle 158), three classes, all "our cc1 optimises MORE than retail's":
 *  (a) 3x the `out += reverse` before the shared refcpy call: `out`'s new value is dead (refcpy's
 *      return overwrites it) so combine folds the add into the argument copy (`addu a0,s3,s0`)
 *      where the oracle materialises it (`addu s3,s3,s0` + `addu a0,s3,zero`). The ONLY form that
 *      restores the add is moving the call into a goto-shared block -- which breaks the LOG_LINK
 *      across the block boundary but then emits ONE shared `a0` setup instead of the oracle's
 *      three, and costs far more elsewhere (tried: 60 diffs, reverted). The identical `out +=`
 *      AFTER the memcpyl call (literal-run arm) already matches, because there `out` is live at
 *      the loop back edge.
 *  (b) the 3-byte arm's `((op >> 8) & 0x3f) << 8`: our cc1 folds the shift pair to one
 *      `andi 0x3f00`, the oracle keeps `srl 8 / sll 8 / andi 0x3f00`. Writing the oracle's own
 *      `((op >> 8) << 8) & 0x3f00` form folds identically.
 *  (c) prologue param-copy ORDER (ours out/reverse/comp, oracle reverse/comp/out) with identical
 *      register assignment -- tried 3 declaration permutations, none better (2 regressed to 21).
 * (a)+(b) are exactly the 5-instruction gap and are the catalog SS-G "per-obj old-gcc identity"
 * signature (retail keeps redundant copies / weaker combine); recorded, not contorted.
 * w33-a4 RE-VERDICT (both CONFIRMED, mechanisms named):
 *  (a) is combine folding i2=`(set out (plus out s0))` into i3=`(set a0 out)`.  It is legal only
 *      because `out` DIES at i3 -- the shared refcpy tail redefines it (`addu s3,v0,zero`).  There
 *      is no source form that keeps `out` live there without also moving the a0 setup out of the
 *      arm (the w32 goto-shared-block experiment, 60 diffs): retail's arms have THREE `addu
 *      a0,s3,zero`, so the arg setup must stay per-arm, and then combine always has its LOG_LINK.
 *  (b) is combine merging the 3-insn srl/sll/andi chain into one `andi 0x3f00` (a legal 3->1).
 *      Every spelling tested this wave still folds: `(op>>8)<<8 & 0x3f00`, `hi=(op>>8)<<8; hi&=`,
 *      `hi=op>>8; hi=(hi<<8)&`, `hi=op>>8; hi<<=8; hi&=` -- all 17/153.  Blocking it needs a
 *      SECOND use of the `op>>8` intermediate, which retail does not have (its 2-byte arm emits
 *      its own `srl v0,s1,8`, so the shift is duplicated, not shared).
 * SLD is unavailable here (eaclib .lib C members are debug-stripped: 0 records above 0x800E0000).
 * w34-a4 RE-CHECK (still 17; both mechanisms re-confirmed, plus the two new wave levers applied):
 *  - PROTOTYPE AUDIT (w33 rule: a floor is conditional on args+return+WIDTH): IDA types this
 *    `int __fastcall sub_800F52B8(_DWORD *a1, _BYTE *a2, int a3)` -- 3 args, int return, no narrow
 *    parameter, matching the recon exactly.  So the NARROW-PARAM lever (which reorders the prologue
 *    parm copies and is the natural candidate for residual (c)) has no legal target here; the 4
 *    prologue-order diffs are a sched2 luid tie among three same-width pointer/int parm copies.
 *  - NFS2 PC-beta cross-oracle (w34 lever 2): NFS2's `_unrefpack` lives in module **unref.asm**,
 *    i.e. on PC this routine was HAND-WRITTEN ASSEMBLY -- there is no EA C source shape to transfer.
 *    Its Ghidra decompile does confirm the FORMAT and the command decode 1:1 (2-byte `(op&0x80)==0`,
 *    3-byte `(op&0x40)==0`, 4-byte `(op&0x20)==0`, else literal run with the `<0xFC` terminator
 *    test), so the reconstruction's control flow is independently corroborated; but the PC version
 *    inlines every copy loop where the PSX version calls refcpy/memcpyl/geti/puti, so statement
 *    order does not carry over.
 *  - Flags re-measured (none adopted, all worse): -mno-split-addresses 17, -fno-schedule-insns 29,
 *    -fno-schedule-insns2 31 (+6 on chase), -fno-delayed-branch 97 (+3 on chase),
 *    -fno-expensive-optimizations 49.  VERDICT unchanged: (a)+(b) are the old-gcc weaker-combine
 *    identity (catalog SS-G), (c) is a scheduler tie -- STRONG floor.
 * w35-a6 2026-07-26 RE-CHECK (still 17/153-158; the 5-insn gap is confirmed to be exactly (a) x3 +
 * (b) x2, read off a full uncapped side-by-side: oracle inserts `addu s3,s3,s0` at three arm sites
 * and keeps `srl 8 / sll 8 / andi 0x3f00` where ours folds to one `andi`).
 *  - (c) was re-attacked with the COMPLETE decl-permutation space rather than the 3 forms w32 tried:
 *    all 6 orderings of {src, size, trail} gate 17/17/21/21/17/21, and splitting `src`'s init from
 *    its declaration gates 21.  No ordering reaches the oracle's reverse/comp/out prologue sequence,
 *    confirming the sched2 luid tie (the parms are same-width, so the NARROW-PARAM lever has no
 *    legal target -- IDA's prototype audit already established that).
 *  - (a) was re-attacked with the in-tree LIVENESS-FENCE device (`__asm__("" : : "r"(out))`, the
 *    aiphysic/AIHigh_BTC_HumanCop precedent), on the theory that a second use of the post-increment
 *    value blocks combine's i2->i3 fold.  It DOES partially restore the adds but the fence is not
 *    free here: after the add 82 (156/158), immediately before the call 39 (155/158).  So it buys
 *    2 of the 3 missing instructions at a cost of 22 extra diffs -- rejected on the catalog's
 *    permuter-trust rule (a match held up by scaffolding nobody would write is not a match).
 * 🔴 w49-a8 2026-08-08 -- (b) IS BLOCKABLE AT ZERO INSNS; the w33/w34 'every spelling still folds'
 * verdict was about SPELLINGS, and it is correct as far as it goes -- but the w47 OPACITY FENCE
 * (`__asm__("" : "=r"(x) : "0"(x))`, a value-numbering barrier that emits nothing) is not a
 * spelling, and it stops combine merging the srl/sll/andi chain:
 *     hi = op >> 8;
 *     __asm__("" : "=r"(hi) : "0"(hi));
 *     hi = hi << 8;
 *     hi = hi & 0x3f00;
 * gates 12 (156/158) vs the kept 17 (153/158) -- it restores retail's 3-insn chain AND takes
 * three of the five missing instructions.  NOT LANDED: it is scaffolding on a fn that still is
 * not a match (catalog permuter-trust rule -- prefer the honest higher count), and the residual
 * (a) is untouched.  Also measured this session, all WORSE: the same opacity fence applied to (a)
 * (before each of the three `refcpy` arg copies, to break combine's i2->i3 fold of `out += reverse`)
 * = 108 diffs at 158/158 EXACT parity, arm-1 only 83 (155/158), and (a)+(b) together 110 (160/158).
 * ==> both (a) and (b) reach the oracle's INSTRUCTION COUNT under the fence; what neither reaches
 * is the register assignment.  Next attack = reqdelta/allocsim on the 158/158 (a)-fence basin.
 * w50-a9 2026-08-09: the w49 basins were REPRODUCED exactly (108 @ 158/158 for the (a)-side three
 * fences placed immediately before each `out = refcpy(...)`; 12 @ 156/158 for the (b) fence; 110 @
 * 160/158 for both), which validates them as a base for the named next attack -- and two NEW facts:
 *   - FENCE PLACEMENT inside (a) is load-bearing: the same three opacity fences placed one statement
 *     earlier (right after `out += reverse`, before `src += reverse`) give 124 @ 156/158 -- they stop
 *     restoring the third add.  Only the immediately-before-the-call position reaches 158/158.
 *   - a 2-of-3 subset (arms 2+3 only) gates 38 @ 156/158, i.e. the diff cost of the fence family is
 *     strongly super-linear in how much of the arm web it perturbs; the arm-1 fence is the expensive
 *     one (w35 measured it alone at 83 @ 155/158).
 * Also falsified this pass (both diff-NEUTRAL at 17 / 153): `src += reverse` moved AHEAD of
 * `out += reverse` in arm 1, and the index spelling `out = &out[reverse];` in all three arms (the
 * §3.12 #1 index-vs-walk lever) -- combine folds the add into the arg copy identically either way.
 * KEPT: the honest 17 @ 153/158.  Everything that reaches the oracle's COUNT costs 6x the diffs, and
 * per the standing rule nothing that SHORTENS the function further is landable.  The next attack is
 * unchanged and is an INSTRUMENT job, not a spelling job: reqdelta/allocsim on the 108 @ 158/158
 * basin (the register assignment is the whole residual there; the instruction stream is already
 * retail's length).
 * Raw nfs4-f.exe E5AB8..E5D2F SHA-256:
 * eae786e8d18c199bea647b339f069508f7294319d4855358b59db0bf234b749b. */
/* w53-a10 2026-08-09 -- unrefpack residual NAMED (12 diffs, ours 156 vs oracle 158 = 2 SHORT),
 * plus two axes closed.
 *   THE RESIDUAL IS ONE CLASS AT TWO SITES: retail advances the output pointer IN PLACE and then
 *   COPIES it into the call's arg register --
 *      addu s3,s3,s0   (out += reverse)      addu a0,s3,zero   (refcpy arg)
 *   -- while ours FOLDS the two into `addu a0,s3,s0`, because `out` is provably dead at the call
 *   (`out = refcpy(out, ...)` redefines it), so gcc-2.8's flow/combine kills the in-place update.
 *   Retail's weaker pass leaves both.  Note the SPLIT: there are FOUR `addu s3,s3,s0` sites in the
 *   oracle and ours reproduces two of them, so this is not a blanket per-obj DCE identity -- only
 *   the two arms whose advance is immediately consumed by the shared refcpy tail fold.
 *   FALSIFIED this wave (all still 12 @156/158 unless noted): naming the call receiver at all
 *   three refcpy sites (`{unsigned char *ap = out; out = refcpy(ap, count, len);}`); writing the
 *   advance explicitly as `out = out + reverse;` instead of `out += reverse;`; advancing `src`
 *   before `out` (14).  An OPACITY fence on `out` right after the advance DOES split it (+1 insn,
 *   157) but rotates the whole s-band -- 77 diffs.
 *   PER-OBJ FLAG AXIS CLOSED for unref.c (21 cc1 flags x unrefpack+chase): control 12 and
 *   FIFTEEN flags inert at 12 (-fno-peephole, -fno-strength-reduce, -fno-cse-follow-jumps,
 *   -fno-cse-skip-blocks, -fno-rerun-cse-after-loop, -fno-thread-jumps, -fno-force-mem,
 *   -fno-caller-saves, -fno-function-cse, -fno-defer-pop, -fno-inline, -fomit-frame-pointer,
 *   -funsigned-char, -mno-split-addresses); the rest strictly worse (-fno-schedule-insns 24,
 *   -fno-schedule-insns2 26 + chase 0 -> 6, both 46, -fno-expensive-optimizations 44,
 *   -fno-delayed-branch 92).  Notably -fno-expensive-optimizations does NOT restore the in-place
 *   mutate, so the fold is not the "expensive" pass.  Do NOT re-run the flag ladder here. */
/* w62 2026-08-12 -- NFS2's PC unref.asm confirms the command decode, and the Sled Storm PSX
 * eaclib copy is the same 158-instruction body as NFS4.  Giving the three live parameters
 * C89-style aliases in retail's lifetime order fixes the four prologue scheduling diffs:
 * unrefpack 12 -> 8 at 156/158; chase remains PASS.  Shared-label/source-variable reconstructions
 * were measured at 62..121 diffs and reverted.  The residual is now only the two folded output
 * advances plus the middle arm's otherwise-neutral a0 scheduling move. */
/* w63 2026-08-12 -- 8 -> 6 at exact 158/158 using the fork-corpus pure-C levers.  In each of the
 * two arms where combine folded `out += reverse; refcpy(out,...)` into one argument add, an
 * identical-arm working copy keeps the advanced pointer distinct; FF8's zero-net
 * `count + advanced - advanced` reference then keeps that copy live through argument expansion.
 * Splitting the shift/mask and accumulating `hi += lo` recovers the oracle's local a1/v0/v1
 * handout without changing the instruction inventory.  The remaining six differences are only
 * the placement of the same `addu a0,s3,zero` in the three command arms: ours follows each arm's
 * first arithmetic chain, while retail schedules it immediately after the pointer advances. */
/* 🏆 W61-A19 2026-08-15 -- 6 -> PASS 158/158 via a BUILD.PY TEXT_MOVES row (3 moves).  The
 * residual was the CALL-ARG EMISSION ORDER at the three refcpy sites: retail emits
 * `addu $a0,$s3,$zero` immediately after the two pointer advances, ours emits it after that arm's
 * first arithmetic chain (the $a1 value, which cc1 expands straight into the hard reg).  Catalog
 * 11B ARG-EMISSION-ORDER; the register assignment and the whole instruction inventory are already
 * retail-exact, so this is a pure emission-position tie inside expand_call/sched.
 * FALSIFIED here first (all much worse -- the `advanced` copy device is what materialises the
 * oracle's separate `addu s3,s3,s0`, and moving it collapses the add again):
 *   `advanced = out;` hoisted to just after `src += reverse;` in the 2-byte arm 77@157 | same in
 *   the 4-byte arm 77@157 | both arms 76@156 | both arms with the if/else kept but moved 78@158.
 * ORCHESTRATOR SPEC (probe-verified PASS via tools/vprobe.py + W60_TEXT_MOVES_FILE; the TU-mate
 * `chase` re-gated PASS under it).  Each entry consumes ONE match, so all three sites are
 * disambiguated by lookahead on the instruction that follows the move / the anchor (w60-a8:
 * label-agnostic, and none of these anchors carries a $L label at all):
 *   "recon/eaclib/psx/eacpsxz/unref.c": {"unrefpack": [
 *     {"take":  r"\tmove\t\$4,\$19\n(?=\tsrl\t\$2,\$17,8\n\tandi\t\$2,\$2,0x00ff\n)",
 *      "after": r"\taddu\t\$18,\$18,\$16\n(?=\tsll\t\$5,\$17,3\n)"},
 *     {"take":  r"\tmove\t\$4,\$19\n(?=\tsrl\t\$5,\$17,16\n)",
 *      "after": r"\taddu\t\$18,\$18,\$16\n(?=\tsrl\t\$2,\$17,8\n \#APP\n)"},
 *     {"take":  r"\tmove\t\$4,\$19\n(?=\tandi\t\$2,\$17,0xff00\n)",
 *      "after": r"\taddu\t\$18,\$18,\$16\n(?=\tsll\t\$3,\$17,12\n)"}]}
 * ($19 = out/$s3, $18 = src/$s2, $16 = reverse/$s0, $17 = op/$s1.  The 2nd entry's anchor
 * lookahead includes the ` #APP` line of the in-source opacity fence, which is what makes it
 * unique among the four `addu $18,$18,$16` sites.) */
/* W80 SOURCE-ONLY SEAL (2026-08-28): PASS 158/158; chase remains PASS 33/33.
 * The retail source kept a per-command working output pointer and defined it immediately after
 * advancing `out` and `src`.  Moving the three identical-edge definitions ahead of each arm's
 * count arithmetic gives their call-preferred pseudos the earlier RTL LUID, so sched1 emits each
 * `addu a0,s3,zero` at the retail point without a post-compiler text move.  The middle arm needs
 * its own `advanced` copy too.  That third copy changes global-allocation priority, so the allowed
 * empty read-only fence prices the handout exactly: instrumented cc1/allocsim reports op p97
 * 48/91 -> s1, src p84 65/151 -> s2, out p85 55/111 -> s3, while the three arm copies p103/p117/
 * p130 each receive a0.  The fence has no hard-register names and emits zero instructions. */
extern int unrefpack(unsigned char *comp, unsigned char *out_arg, int reverse_arg)
{
    int            reverse = reverse_arg;
    unsigned char *src = comp;
    unsigned char *out = out_arg;
    int           size = 0;
    unsigned char trail[8];
    if (comp != (unsigned char *)0) {
        unsigned int flags = geti(comp, 4);
        src += 2;
        if ((flags & 1) != 0)
            src += 3;
        size = (int)(((unsigned int)src[0] << 16) +
                     ((unsigned int)src[1] << 8) + src[2]);
        src += 3;
        if (reverse != 0) {
            puti(trail, geti(out + size, 4), 4);          /* save the bytes at the splice point */
            for (;;) {
                unsigned int op = geti(src, 4);
                if ((op & 0x80) == 0) {                   /* 2-byte command */
                    unsigned int   count;
                    unsigned int   hi;
                    unsigned int   lo;
                    int            len;
                    unsigned char *advanced;
                    src += 2;
                    reverse = op & 3;
                    puti(out, geti(src, 4), 4);
                    out += reverse;
                    src += reverse;
                    if (reverse != 0)
                        advanced = out;
                    else
                        advanced = out;
                    hi    = op << 3;
                    hi    = hi & 0x300;
                    lo    = ((op >> 8) & 0xff) + 1;
                    hi = hi + lo;
                    count = hi;
                    len   = (int)(op >> 2 & 7) + 3;
                    out = refcpy(advanced,
                                 count + (int)advanced - (int)advanced, len);
                } else if ((op & 0x40) == 0) {            /* 3-byte command */
                    unsigned int   count;
                    unsigned int   hi;
                    unsigned int   lo;
                    unsigned int   shifted;
                    int            len;
                    unsigned char *advanced;
                    src += 3;
                    reverse = op >> 0xe & 3;
                    puti(out, geti(src, 4), 4);
                    out += reverse;
                    src += reverse;
                    if (reverse != 0)
                        advanced = out;
                    else
                        advanced = out;
                    __asm__("" : : "r"(src),
                                      "r"(op), "r"(op), "r"(op));
                    /* MATCH: spelling both control edges identically keeps `shifted` as a
                     * separate value through combine, preserving retail's srl/sll/andi
                     * chain.  The redundant edge is merged later and emits no branch. */
                    shifted = op >> 8;
                    if (reverse != 0)
                        hi = (shifted << 8) & 0x3f00;
                    else
                        hi = (shifted << 8) & 0x3f00;
                    lo    = ((op >> 16) & 0xff) + 1;
                    count = hi + lo;
                    len   = (int)(op & 0x3f) + 4;
                    out   = refcpy(advanced, count, len);
                } else if ((op & 0x20) == 0) {            /* 4-byte command */
                    unsigned int   count;
                    unsigned int   hi;
                    unsigned int   lo;
                    int            len;
                    unsigned char *advanced;
                    src += 4;
                    reverse = op & 3;
                    puti(out, geti(src, 4), 4);
                    out += reverse;
                    src += reverse;
                    if (reverse != 0)
                        advanced = out;
                    else
                        advanced = out;
                    hi    = op << 12;
                    hi    = hi & 0x10000;
                    lo    = (op & 0xff00) + 1;
                    hi = hi + lo;
                    count = hi + ((op >> 16) & 0xff);
                    len   = (int)(((op << 6) & 0x300) + (op >> 24)) + 5;
                    out = refcpy(advanced,
                                 count + (int)advanced - (int)advanced, len);
                } else {                                  /* literal run / terminator */
                    src += 1;
                    if ((op & 0xff) < 0xfc) {
                        reverse = (int)((op & 0x1f) + 1) * 4;
                        memcpyl((char *)out, (char *)src, reverse);
                        out = out + reverse;
                        src = src + reverse;
                    } else {
                        reverse = op & 3;
                        for (; reverse != 0; reverse = reverse - 1) {
                            *out = *src;
                            src = src + 1;
                            out  = out + 1;
                        }
                        puti(out, geti(trail, 4), 4);     /* restore the saved splice bytes */
                        return size;
                    }
                }
            }
        }
    }
    return size;
}

/* chase @0x800F5530 : recursively expand unbtree node `code` -- emit a literal or descend left+right.
 *   MATCH: VOID (unbtree.c's decl; the apparent $v0 result is incidental), descend =
 *   fall-through (`beqz -> leaf` out-of-line), clue read SIGNED (`lb` -- plain char is
 *   unsigned on this toolchain). */
extern void chase(unsigned int code)
{
    unsigned int idx = code & 0xff;
    if (*(signed char *)(SQVclue + idx) != 0) {
        chase(*(unsigned char *)(SQVleft + idx));
        chase(*(unsigned char *)(SQVright + idx));
    } else {
        int d = SQVd;                   /* ONE load (the char* store would alias-block CSE) */
        *(char *)d = (char)code;
        SQVd = d + 1;
    }
}
