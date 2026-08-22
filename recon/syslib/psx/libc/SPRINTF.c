/* MATCH (2026-08-14): 174 -> 60 diffs, now count-exact at 545/545.  Retail loads each
 * variadic argument from the current cursor before advancing it; spelling those as
 * separate load/advance statements removes the repeated advance-then-load(-4) cascade.
 * The prefix tests require signed-byte reads, while the prefix copy remains unsigned.
 * A narrow unsigned-char temporary in case 'c' also reproduces retail's load and removes
 * the last two count differences.  Detailed verify_asm/vdiff are the authority.
 */
/* W59-A13 RE-GATE + FALSIFICATIONS (2026-08-14, baseline re-measured at 60 @545/545):
 *  - FORMAT-POINTER CLUSTER (~15 of the 60): retail reads the next char off the OLD base with
 *    a bigger displacement (`addiu $v0,$a2,1; sw $v0,596(sp); lb $a1,2($a2)`) where ours reads
 *    it off the freshly-incremented pointer (`lb $a1,1($a3)`).  All four spellings of the 9
 *    `ch = *++f;` sites gate IDENTICALLY (60): `f = f + 1; ch = *f;`, `ch = *(++f);`,
 *    `ch = *(f += 1);`; the index form `ch = f[1]; f = f + 1;` is much worse (110 @537).
 *    ==> post-RTL base-reuse choice, not a source spelling.
 *  - LANE/FLAG AXIS RE-LADDERED (04Z): default (jtbl_at_fusion) 60 @545/545 is best on
 *    instruction parity; cc1_272 168 @529, cc1_272+no_schedule_insns 204 @529,
 *    cc1_ver 2.8.1 60 (identical), -G0 60 (identical), -mno-split-addresses 49 @546/545 --
 *    the last one FIXES the `lui $v0; addiu $a3,$v0` vs retail `lui $a3; addiu $a3,$a3`
 *    self-temp class (~6 diffs) but ADDS an instruction, so it fails the w34 keep-rule as
 *    written; reported as an orchestrator judgement call, not wired.
 */
/* W61-A9 RE-GATE + FALSIFICATIONS (2026-08-15, baseline re-measured at 56 @545/545 after the
 * w60-a5 flag-constant landing).  NOTHING LANDED; the six probes below are recorded so the
 * spelling axis is not re-fought (scratchpad/w61a9/spr_v1.json + spr_v2.json, whole-TU gated):
 *   case 'c' with the `*bufPtr = argChar` store BEFORE `args += 4` 62 | with `len = 1` moved
 *   between them 62 | `extern const printf_info D_8012348C` 56 (inert) |
 *   `info = *(printf_info *)&D_8012348C` 56 (inert) | the '*' precision/width arg read as
 *   `args += 4; ... *(int *)(args - 4)` 69 / 81 | `flagZero = '0'` at the TOP of the for body
 *   56 (inert) | `flagZero = '0'` inside the '%' branch 186 | ALL FOUR flag characters spelled
 *   as named `register int` constants in retail's emission order ('-','+',' ','0') 64.
 *   ==> the `li $s3,48` emission-order row is NOT a declaration/assignment-position question:
 *   the other three constants are LICM-hoisted literals and any explicit assignment of
 *   flagZero lands in the same preheader group, ahead of them.
 * 04Z FLAG RE-LADDER on the CURRENT basin (in-memory PER_TU hook, no build.py edit):
 *   default 56 @545/545 | -mno-split-addresses 45 @546/545 | -fno-schedule-insns2 74 @547 |
 *   -fno-schedule-insns 124 @545 | -fno-strength-reduce 56 (inert).
 *   🔴 ORCHESTRATOR CALL, RE-PRICED: the w59-a13 note recorded -mno-split-addresses at 49;
 *   on this basin it is 45, i.e. -11 diffs for +1 instruction.  It removes the ENTIRE second
 *   self-temp cluster (`lui $v0,0; addiu $a3,$v0,0` x2 -> retail's `lui $a3; addiu $a3,$a3`)
 *   and reduces the D_8012348C template copy to a pure register-choice row (ours
 *   t3/t0/t1/t2, retail a1/v0/v1/a0); the +1 is a `nop` in a new `j` slot near the tail.
 *   Still fails the count-parity keep-rule as written -- wire it only if the orchestrator
 *   prefers the diff metric.  Not wired by me.
 * REMAINING (56) unchanged in kind: the template-copy register handout (8), the
 * format-pointer base-reuse cluster (6, post-RTL per w59-a13), the `li $s3,48` order (2),
 * the case-'c' j-slot pick (4), the '*' li-position (2), one `sll` coloring row (2).
 * The template-copy handout is a local-alloc QTY question (the 06E gap) -- de-prioritized
 * per the agent guide until qtytrace exists.  NOT a floor.
 */
/* W62-A8 (2026-08-15) -- RE-GATED at 56 @545/545.  Nothing landed; ONE new structural
 * reading that upgrades the orchestrator call, and no new spellings (the axis is closed):
 *   THE TEMPLATE-COPY REGISTER HANDOUT IS NOT AN INDEPENDENT 06E ROW -- IT IS DOWNSTREAM OF
 *   THE SPLIT-ADDRESS FORM.  Ours emits `lui $v0,0; addiu $t3,$v0,0` for &D_8012348C, so $v0
 *   is occupied at the copy and the three words fall to $t0/$t1/$t2; retail emits
 *   `lui $a1; addiu $a1,$a1` and the three words take the first three free caller-saved regs
 *   $v0/$v1/$a0.  Same at the two `addiu $a3,$v0,0` sites.  I.e. the "8-diff local-alloc QTY
 *   handout" the w61-a9 receipt de-prioritised behind qtytrace and the ~6-diff self-temp
 *   cluster are ONE row with ONE cause, and `-mno-split-addresses` removes the cause.
 *   That makes the standing orchestrator call (45 @546 vs 56 @545) a -11 for +1 `nop`, and
 *   the +1 is not structural.  Spec unchanged:
 *     "recon/syslib/psx/libc/SPRINTF.c": {"jtbl_at_fusion": True, "no_split_addresses": True}
 *   Not wired by me -- it is the count-parity rule's call.
 * No new source spellings were probed: w59-a13 (4 pointer forms), w60-a5 and w61-a9 (8 more)
 * cover the format-pointer, flag-constant and case-'c' rows, and all are post-RTL. */
/* 🔑 W71-A13 RE-GATE (44 @545/545 after the w63-a9 nosplit wiring) + THE TEMPLATE-COPY ROW'S
 * ROOT CAUSE, NAMED FROM THE RTL (it is NOT a local-alloc QTY question, as w61-a9/w62-a8 assumed).
 * `info = D_8012348C;` expands to ONE insn:
 *     (insn 72 (parallel [(set (mem/s:BLK (plus (reg fp) 528)) (mem/s:BLK (symbol_ref D_8012348C)))
 *                         (clobber (scratch:SI)) x4 ...]) {movstrsi_internal})
 * so its four registers are RELOAD SCRATCHES, handed out from reload's SPILL POOL
 * (`order_regs_for_reload`, ascending `hard_reg_n_uses`), never by local_alloc.  Ours takes
 * $t0/$t1/$t2 + $t3 (address), retail takes $v0/$v1/$a0 + $a1 -- the SAME relative pattern
 * (3 word scratches then the address), shifted by six registers.  The -dg dump proves $2..$7 are
 * NOT live across the copy (the block's live set is pseudos 80/82/85/107/110/113, homed
 * $s4/$s3/$s2/$s7/$s6/$s5), so the shift is purely the POOL ORDER: in our build $2..$7 carry the
 * function's local qtys (dispositions: dozens of `in 2` / `in 3`) so they sort LAST, while
 * $t0-$t3 are untouched and sort FIRST.  ⇒ this row and the `addiu $a3,$a2,1`/`lb $a1,1($a3)`
 * format-pointer row (which is the same story one level down -- ours keeps `f+1` in $a3, retail
 * in a dying $v0 and re-offsets `2($a2)`) are ONE whole-function allocation-PROFILE property.
 * Not a spelling; the named instrument is the 06E local-alloc/spill-pool trace.
 * FALSIFIED THIS WAVE (all whole-TU gated, restored):
 *   the '%' constant: a named `pct` re-assigned at BOTH compare sites (the w54 anti-hoist row),
 *     with and without an identity launder, and at the head only ......... 44 (all inert)
 *     -- and the reason is worth recording: our build ALREADY rematerializes `li $2,37` three
 *     times exactly like retail (preheader, the `%`-default arm, and the back-edge delay slot),
 *     so the '%' literal was never what occupies $2 at the copy.
 *   the template copy spelled as explicit words (`w0=src[0];..; dst[0]=w0;..`, grouped
 *     load-3/store-3 AND naive interleaved) ............................. 53 both -- it stops
 *     being a movstrsi and grows an `addiu $v0,$sp,528` destination address.
 *   the copy through a 3-int view type (`*(pi3 *)&info = *(const pi3 *)&D_8012348C`) ... 44
 *     (inert -- still movstrsi, which confirms the movstrsi form itself is right).
 *   flagZero: dropped entirely (plain '0' literals) 185 | plain `int` instead of `register` 44
 *     (inert) | identity-laundered 44 (inert) | assigned inside the '%' branch 174.
 *     ⇒ the `li $s3,48` emission-order row is downstream of the same pool/profile question. */
/* 🏆 W72-A18 -- (A) THE VENDOR-BYTE CERTIFICATE, (B) THE CORPUS VERDICT, (C) THE ROOT CAUSE
 * SHARPENED WITH A DECISIVE EXPERIMENT.  Re-gated at 44 @545/545 (unchanged; nothing landed).
 *
 * (A) 🔑 RETAIL'S sprintf IS THE SHIPPED PsyQ 4.3 LIBC VENDOR OBJECT, BYTE-PROVEN.
 *     `C:/Temp/nfs4-clean/psyq43/extracted/LIBC/functions/sprintf.bin` (2192 B = 548 insns) vs
 *     the oracle's 548 words: 514/548 raw-identical, and ALL 34 differences are in relocated
 *     fields only (jal targets, lui/%hi and addiu/lw/sw %lo immediates) -- RELOC-MASKED DIFF = 0.
 *     So this is the 19A object-identity class (like LIBMATH/LIBMCRD): the target is a genuine
 *     Sony build of Sony's own source, and every residual here is codegen identity, never
 *     structure.  ⚠️ NOTE the INDEX.tsv insn counts are the honest size: LIBMCRD's
 *     GetDirentry/CreateFile/DeleteFile are 152/130/111 = our oracles exactly, so the whole
 *     libmcrd + libc/SPRINTF cluster is vendor-anchored.
 *
 * (B) 🔴 CORPUS VERDICT ON THE TEMPLATE-COPY ROW -- THE HOPED-FOR DISSOLUTION IS FALSE.
 *     The user's directive was: sotn/sh ship a MATCHED PsyQ sprintf; if their source shape
 *     avoids the movstrsi template copy (a per-char loop instead of a struct assignment) the
 *     whole row class dissolves.  IT DOES NOT.  `C:/Temp/sotn-decomp/src/main/psxsdk/libc/
 *     sprintf.c` is a fully matched body (0 INCLUDE_ASM; splat config lists it as a `c` segment)
 *     and it copies the template with the IDENTICAL struct assignment `info = D_8002D3A8;`
 *     over the identical 0xC-byte bitfield `printf_info`.  Point-by-point against our body:
 *       - same 0x200 buf, same `bufPtr = (char*)&args - sizeof(printf_info) - 4` va_list trick,
 *         same `for (; ch = *f, ch != 0; ++f)` head, same flag/width/precision/conversion tree,
 *         same `do { if (info.isHalf) ... } while (0)` wrappers (we already carry them),
 *         same case set incl. the `default:` that handles '%'.
 *       - the ONE structural difference is the va_list: sotn uses the STANDARD gcc macro
 *         `(AP += 4, *(TYPE*)(AP-4))`; ours uses read-then-advance.  That is not a corpus win
 *         to take -- the standard form was already measured HERE at 69/81 (w61-a9) because THIS
 *         oracle loads before advancing.  Revision drift, not a better shape.
 *       - sotn uses plain '0' literals where we need the function-wide `flagZero` register
 *         constant (dropping ours measures 185), which is independent evidence that the two
 *         SDK revisions differ -- consistent with (A): match OUR vendor object, not sotn's.
 *     `C:/Temp/ps1-decomp-refs/rood-reverse/src/SLUS_010.40/libc/SPRINTF.c` is INCLUDE_ASM
 *     (unmatched), and PE2 ships only a prebuilt libc2/sprintf.o.  ==> the corpus is EXHAUSTED
 *     for sprintf's SHAPE; our body is already the vendor shape.  Do not re-mine it.
 *
 * (C) THE TEMPLATE-COPY REGISTER ROW, ROOT CAUSE SHARPENED (the W71 reading is HALF right).
 *     What the four registers ARE (mips.md:4110, gcc-2.8.1): `movstrsi_internal` carries FOUR
 *     `(clobber (match_scratch:SI "=&d"))` operands.  TWO different passes can assign them:
 *       - local-alloc's `alloc_qty_for_scratch` (local-alloc.c:307) makes each a QTY with
 *         n_refs 1 / live length 2 / size 4, so QTY_CMP_PRI = floor_log2(1)*1*4/2 = 0 -- they
 *         sort LAST in their block and then take the lowest free regs by MIPS's ascending
 *         numeric scan (find_free_reg, no REG_ALLOC_ORDER), i.e. $2,$3,$4,$5 when the block
 *         head is quiet;
 *       - failing that, reload's `potential_reload_regs` (order_regs_for_reload, reload1.c:3840)
 *         = first the `uses == 0 && call_used` hard regs in ASCENDING order, i.e. $8,$9,$10,$11.
 *     🏆 DECISIVE EXPERIMENT (new, cheap, reusable as a PASS DISCRIMINATOR): put a zero-insn
 *     void-tail fence with a HARD-REG CLOBBER far away from the copy --
 *         `__asm__("" : : "i"(0) : "$8");`            (at the top of the fn, 470 insns away)
 *     and the copy's registers SHIFT BY ONE: t0/t1/t2 + t3 -> t1/t2/t3 + t4 (gate 44 -> 48);
 *     clobbering "$8","$9","$10","$11" shifts them to t4/t5/t6 + t7.  A local-alloc scratch qty
 *     could not move (local-alloc only sees `regs_live_at` INSIDE the block) -- so OURS IS THE
 *     RELOAD POOL, function-wide, exactly as W71 said.
 *     🔴 BUT RETAIL'S FOUR CANNOT BE THE RELOAD POOL, and this is arithmetic, not opinion:
 *     order_regs_for_reload adds `large + 1` (large = the sum of every pseudo's REG_N_REFS) to
 *     every reg in `regs_explicitly_used`, which is a straight copy of `regs_ever_live` taken
 *     BEFORE pseudo homes are merged in (reload1.c:582).  Any sprintf sets `(reg 2)` for its
 *     return value and `(reg 4..6)` for the memmove/strlen/memchr argument registers, so
 *     $2/$4/$5/$6 are `regs_explicitly_used` in EVERY build and sort to the END of the pool.
 *     Retail's `lui $a1; addiu $a1,$a1; lw $v0,0($a1); lw $v1,4($a1); lw $a0,8($a1)` therefore
 *     came from LOCAL-ALLOC's scratch qtys (ascending from $2 at a quiet block head).
 *     ==> ⭐ THE ROW IS NOT A SPILL-POOL-ORDER QUESTION AT ALL.  It is: OUR local-alloc DECLINES
 *     the four scratch qtys and retail's ACCEPTS them.  That re-points the whole class at
 *     local-alloc's own basic block, and the .lreg says that block is as quiet as it gets:
 *         ;; Start of basic block 4.
 *         ;; Registers live: 0 [$0] 29 [$sp] 30 [$fp] 80 82 85 107 110 113
 *         (code_label 66 ...)  (insn 72 ... movstrsi_internal ...)   <- the copy IS the block head
 *     (the six live pseudos are all saved-reg homed; and the dump still PRINTS `(scratch:SI)`
 *     because local-alloc rewrites `qty_scratch_rtx[]`, never the in-insn rtx -- so the dump is
 *     NOT evidence either way, which is why the clobber experiment was needed).
 *     NAMED NEXT STEP (one run, not a sweep): the two exits of `alloc_qty_for_scratch` are
 *     (i) `constrain_operands(insn_code_num, 0)` failing -- note operand 1 is `memory_operand "o"`
 *     i.e. OFFSETTABLE, and the source is `(mem (symbol_ref "D_8012348C"))`; and (ii) find_free_reg
 *     returning -1.  Instrument with the [find_free_reg]/[qty_order] traces.
 *     ⚠️ LAB BLOCKER RECORDED: `C:/Temp/nfs4-instr-cc1/cc1-ecoff.exe` SEGFAULTS on this TU at
 *     -O2 (every flag combination tried, with and without -mgas/-funsigned-char/
 *     -mno-split-addresses); -O0 runs clean.  SPRINTF is one of the known lab-segfault TUs
 *     (w48-a9) -- the trace needs the fn sliced out into a mini-TU first.
 *     The format-pointer row (`addiu $a3,$a2,1` + `lb $a1,1($a3)` vs retail `addiu $v0,$a2,1` +
 *     `lb $a1,2($a2)`) is the same story one level down and moves with it. */
/* PRIOR MATCH (w51-a8, 2026-08-09) -- RAGE-RACER VENDOR SIBLING AUDITED; our body is already
 * the right shape, so NO transplant was landed (kept at 174 diffs, 547-vs-545 insns).
 * Reference: C:/Temp/rage-racer-decomp\src\main\PAL\lib\libc\sprintf.c (a full
 * byte-matched PsyQ libc sprintf, gcc-2.6.3 -O2 -G0 -funsigned-char).  Findings:
 *  - CONFIRMED IDENTICAL by construction (RR arrives at the same code we already emit):
 *    the 3-word struct copy of the default spec; the spec living just ABOVE the 0x200
 *    number buffer so the digits are written backwards from &spec; `args` forced into a
 *    frame slot by taking &format (hence the per-iteration reload/increment/store of the
 *    format pointer); `(u32)(c - '0') < 10` digit tests (we already emit the oracle's
 *    `sltiu ...,0xA`); `hash = '#'` materialised INSIDE the per-conversion block (we
 *    already emit `li v1,35` there); '-','+',' ','0' as function-wide register constants
 *    ($s7,$s6,$s5,$s3 -- our build assigns the SAME four registers).
 *  - DIVERGENT, and OUR form is right: RR reads the format with a plain `const char *`
 *    (`lbu`); this oracle uses `lb $a1,0($a1)`, so the `signed char *f` here is correct.
 *  - GATED AND REJECTED: (a) the whole RR body transplanted onto our globals: 449 diffs
 *    at 530-vs-545 and a 584-byte frame (ours already matches the oracle's 0x250 frame
 *    and its entire prologue slot map).  (b) RR's `zeroFlag = '0'` assigned inside the
 *    loop instead of our function-scope `register int flagZero = '0'` (the intent was to
 *    fix the flag-constant EMISSION ORDER -- ours emits `li s3,48` first, retail last):
 *    303 diffs, frame shrinks to 584.  (c) RR's `do { ... } while (format++, (c=*format)
 *    != 0)` loop head/tail: 179 at 548-vs-545 (worse than the kept 174).
 * ==> the residual really is the broad callee-saved coloring cascade the note below
 * describes, not a missing vendor idiom.  The one un-tried structural item left is RR's
 * `u8 *argState[2]` pointer-ARRAY spelling of the va_list cursor (memory by construction).
 */
/* syslib/psx/libc/SPRINTF.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 * Source obj: nfs4\syslib\psx\SPRINTF.obj; libc.lib(SPRINTF.OBJ).
 *
 * The format parser's source shape is shared with the Psy-Q SDK reconstruction at
 * sotn-decomp/src/main/psxsdk/libc/sprintf.c.  In particular it uses a 0x200-byte
 * conversion buffer, copies a zero printf_info template for every conversion, and
 * derives the backwards number-buffer pointer from the on-stack va_list.
 *
 * VERIFY (2026-07-25 survey): 179 diffs (ours 548 / oracle 545 insns), down from an initial
 * 327.  The `switch(ch)` case set (h,l,L,d,i,u,o,p,X,x,c,s,n) is confirmed 1:1 against the
 * oracle's jump table `jtbl_80056B60` (dumped from asm/data/rdata_80054548.rodata.s: 45
 * entries spanning 'L'(0x4C)..'x'(0x78), every non-default slot manually cross-checked
 * against its target block's semantics) -- the algorithm/case coverage is NOT the gap.
 * 🔴 SYSTEMIC TOOLCHAIN FLOOR (not this file's bug): every jump-table LOAD in the whole
 * repo's current build emits the address as an explicit 2-register sequence (`lui
 * v0,%hi(tbl); addiu v0,v0,%lo(tbl); sll v1,idx,2; addu v1,v1,v0; lw v0,0(v1)`), but every
 * oracle jump table (33 `jtbl_` sites tree-wide) was assembled through GAS's own indexed-
 * symbol-load MACRO, which always uses `$at` as the scratch (`sll v0,idx,2; lui
 * at,%hi(tbl); addu at,at,v0; lw v0,%lo(tbl)($at)`) -- confirmed identical on an unrelated,
 * much smaller function in this same tree (PadInfoAct, asm/nonmatchings/main/PadInfoAct.s)
 * so it is NOT source-shape-dependent. This costs ~5 insns and a register-pressure ripple
 * at EVERY jump-table site; not fixable by editing the C.
 * 🏆 FIXED (2026-07-25, 327->179 -- the session's headline lever): `flagZero` (`register int
 * flagZero = '0';`) is the ORIGINAL SOURCE'S own name for the padding-zero character, and the
 * oracle keeps it live in ONE callee-saved register (`$s3`) for the WHOLE function, reusing it
 * at every `'0'`-padding/compare site -- NOT just the flags-parser `else if (ch==flagZero)`
 * check this recon originally scoped it to. Every other `'0'` literal used for PADDING or
 * COMPARING (case 'o': the alt-form zero-strip compare + its store; the `printDec`/`case 'x'`/
 * `case 'p'` precision pad loops; the "0x"/"0X" alt-form prefix's leading '0') must reference
 * `flagZero`, not a fresh `'0'` literal -- the raw oracle confirms this by disassembling those
 * sites as `sb $s3,0($s1)` / `beq $v0,$s3,...` (a persistent register), never a re-materialized
 * `li vN,0x30`. (The DIGIT-VALUE computation itself, `(num%8)+'0'` etc., is genuinely a one-off
 * per-iteration immediate in the oracle too -- `addiu v0,v0,0x30` -- and correctly stays a bare
 * literal; only the PAD/COMPARE '0' is the shared variable.) Also needed `*(signed char
 * *)bufPtr` on the alt-form zero-strip compare (this build's plain `char` defaults UNSIGNED so
 * `*bufPtr` alone reads `lbu`, but the oracle wants `lb`).
 * STILL OPEN (179 diffs): (1) the prologue's callee-save ORDER -- oracle materializes
 * `written=0` in the `beqz`-format-empty-check's delay slot and parks `out` in `$s4`; ours
 * computes `written=0` in the prologue proper and parks `out` in `$s3`. (2) The four flag
 * constants ('-','+',' ',flagZero) are emitted in a DIFFERENT order: oracle emits flagZero's
 * `li $s3,48` LAST (after '-','+' ,' ' -- matching the flags if-else chain's textual order,
 * where the `flagZero` compare is the last arm), ours emits it FIRST (before '-'/'+'/' ') --
 * likely because flagZero's much higher total ref-count (used well beyond the flags loop, per
 * the fix above) raises its scheduling priority. Tried moving the `register int flagZero='0';`
 * declaration to the END of the local-decl block (hoping declaration position, not just usage
 * count, controls emission order) -- ZERO effect, reverted; this needs the `-dg`/`-dl` RTL-dump
 * technique (methodology §3.12b) to actually read the allocator's priority table rather than
 * guess. (3) Beyond those two, the remaining diffs are ordinary parameter/local -> callee-
 * saved-register coloring cascades from the 20+ live locals across 548 insns; no more `lbu`/
 * `lb` mismatches or jtbl-adjacent issues were found. (An earlier survey pass mis-read a diff-
 * alignment artifact near the octal pad loop as a genuinely duplicated instruction block /
 * loop-rotation bug -- re-examined against the raw oracle labels directly and it was NOT real;
 * the octal-loop's own shape already matches a standard peeled `while`.)
 */
typedef enum { false = 0, true = 1 } bool;
typedef char *va_list;
#define va_start(ap, last) ((ap) = (char *)&(last) + 4)
#define va_arg(ap, type)   (*(type *)(ap))
#define NULL ((void *)0)

extern int   strlen(const char *s);
extern void *memchr(const void *s, int c, unsigned n);
extern void *memmove(void *d, const void *s, unsigned n);

typedef struct printf_info {
    bool leftJustified : 1;
    bool prependPlus : 1;
    bool alternativeForm : 1;
    bool leadingZeros : 1;
    bool usePrecision : 1;
    bool isHalf : 1;
    bool isLong : 1;
    bool isLongLong : 1;
    char leadingChar;
    int width;
    int precision;
} printf_info;

extern printf_info D_8012348C;

extern int sprintf(char *out, signed char *f, ...)
{
    register int flagZero;
    char buf[0x200];
    printf_info info;
    va_list args;
    char *hexChars;
    int written;
    int num;
    int len;
    char *bufPtr;
    int ch;

    va_start(args, f);
    ch = *f;
    written = 0;
    /* w60-a5 (idiom: rage-racer-decomp src/main/PAL/lib/libc/sprintf.c,
     * a 100%-matched PSY-Q libc sprintf): the flag-character constants are
     * assigned AFTER the zero-trip guard, not at function entry.  Retail
     * emits `beqz` with `written = 0` in its delay slot and only THEN the
     * four `li` constants (s7='-', s6='+', s5=' ', s3='0'); a function-scope
     * `flagZero = '0'` initializer emits its `li s3,48` FIRST, ahead of the
     * three LICM-hoisted literals.  Splitting the decl from the init and
     * assigning behind an explicit guard puts it in the loop preheader with
     * them.  60 -> 56.  (RR spells the guard `if (c == 0) goto finished;`
     * and the loop `do { ... } while (format++, (c = *format) != 0);` -- the
     * do/while half is gate-neutral here, so only the guard is taken.) */
    if (ch == 0) goto end;
    flagZero = '0';
    for (; ch = *f, ch != 0; ++f) {
        if (ch != '%') {
            out[written++] = ch;
            continue;
        }
        info = D_8012348C;

        while (true) {
            ch = *++f;
            if (ch == '-') {
                info.leftJustified = true;
            } else if (ch == '+') {
                info.prependPlus = true;
            } else if (ch == ' ') {
                info.leadingChar = ' ';
            } else if (ch == '#') {
                info.alternativeForm = true;
            } else if (ch == flagZero) {
                info.leadingZeros = true;
            } else {
                break;
            }
        }

        if (ch == '*') {
            info.width = va_arg(args, int);
            args += 4;
            if (info.width < 0) {
                info.width = -info.width;
                info.leftJustified = true;
            }
            ch = *++f;
        } else {
            while (ch >= '0' && ch <= '9') {
                info.width = (info.width * 10) + (ch - '0');
                ch = *++f;
            }
        }
        if (ch == '.') {
            ch = *++f;
            if (ch == '*') {
                info.precision = va_arg(args, int);
                args += 4;
                ch = *++f;
            } else {
                while (ch >= '0' && ch <= '9') {
                    info.precision = (info.precision * 10) + (ch - '0');
                    ch = *++f;
                }
            }
            if (info.precision >= 0)
                info.usePrecision = true;
        }

        /* This relation deliberately keeps args on the stack and produces buf+0x1FC. */
        bufPtr = (char *)&args - sizeof(printf_info) - 4;

        if (info.leftJustified)
            info.leadingZeros = false;

    conversion:
        switch (ch) {
        case 'h':
            info.isHalf = true;
            ch = *++f;
            goto conversion;

        case 'l':
            info.isLong = true;
            ch = *++f;
            goto conversion;

        case 'L':
            info.isLongLong = true;
            ch = *++f;
            goto conversion;

        case 'd':
        case 'i':
            num = va_arg(args, int);
            args += 4;
            do {
                if (info.isHalf)
                    num = (short)num;
            } while (0);
            if (num < 0) {
                num = -num;
                info.leadingChar = '-';
            } else {
                do {
                    if (info.prependPlus)
                        info.leadingChar = '+';
                } while (0);
            }
            goto printDec;

        case 'u':
            num = va_arg(args, unsigned int);
            args += 4;
            do {
                if (info.isHalf)
                    num = (unsigned short)num;
            } while (0);
            info.leadingChar = '\0';
        printDec:
            if (!info.usePrecision) {
                if (info.leadingZeros) {
                    info.precision = info.width;
                    if ((signed char)info.leadingChar != '\0')
                        info.precision = info.width - 1;
                }
                if (info.precision <= 0)
                    info.precision = 1;
            }
            len = 0;
            while (num != 0) {
                *--bufPtr = (num % 10U) + '0';
                num /= 10U;
                len++;
            }
            while (len < info.precision) {
                *--bufPtr = flagZero;
                len++;
            }
            if ((signed char)info.leadingChar != '\0') {
                *--bufPtr = info.leadingChar;
                len++;
            }
            break;

        case 'o':
            num = va_arg(args, unsigned int);
            args += 4;
            do {
                if (info.isHalf)
                    num = (unsigned short)num;
            } while (0);
            if (!info.usePrecision) {
                if (info.leadingZeros)
                    info.precision = info.width;
                if (info.precision <= 0)
                    info.precision = 1;
            }
            len = 0;
            while (num != 0) {
                *--bufPtr = (num % 8U) + '0';
                num /= 8U;
                len++;
            }
            if (info.alternativeForm && len != 0 && *(signed char *)bufPtr != flagZero) {
                *--bufPtr = flagZero;
                len++;
            }
            while (len < info.precision) {
                *--bufPtr = flagZero;
                len++;
            }
            break;

        case 'p':
            info.precision = 8;
            info.usePrecision = true;
            info.isLong = true;
            /* fallthrough */
        case 'X':
            hexChars = "0123456789ABCDEF";
            goto printHex;
        case 'x':
            hexChars = "0123456789abcdef";
        printHex:
            num = va_arg(args, unsigned int);
            args += 4;
            do {
                if (info.isHalf)
                    num = (unsigned short)num;
            } while (0);
            if (!info.usePrecision) {
                if (info.leadingZeros) {
                    info.precision = info.width;
                    if (info.alternativeForm)
                        info.precision = info.width - 2;
                }
                if (info.precision <= 0)
                    info.precision = 1;
            }
            len = 0;
            while (num != 0) {
                *--bufPtr = hexChars[num % 16U];
                num /= 16U;
                len++;
            }
            while (len < info.precision) {
                *--bufPtr = flagZero;
                len++;
            }
            if (info.alternativeForm) {
                *--bufPtr = ch;
                *--bufPtr = flagZero;
                len += 2;
            }
            break;

        case 'c': {
            unsigned char argChar;

            --bufPtr;
            argChar = *(unsigned char *)args;
            args += 4;
            *bufPtr = argChar;
            len = 1;
            break;
        }

        case 's':
            bufPtr = va_arg(args, char *);
            args += 4;
            if (info.alternativeForm) {
                len = (unsigned char)*bufPtr++;
                if (info.usePrecision && info.precision < len)
                    len = info.precision;
            } else if (!info.usePrecision) {
                len = strlen(bufPtr);
            } else {
                char *ptr = (char *)memchr(bufPtr, 0, info.precision);
                len = ptr - bufPtr;
                if (ptr == NULL)
                    len = info.precision;
            }
            break;

        case 'n':
            bufPtr = va_arg(args, char *);
            args += 4;
            if (info.isHalf)
                *(short *)bufPtr = (short)written;
            else if (info.isLong)
                *(int *)bufPtr = written;
            else if (info.isLongLong)
                *(int *)bufPtr = written;
            else
                *(int *)bufPtr = written;
            continue;

        default:
            if (ch == '%') {
                out[written++] = ch;
                continue;
            }
            goto end;
        }
        if (len < info.width && !info.leftJustified) {
            while (len < info.width) {
                out[written++] = ' ';
                info.width--;
            }
        }
        memmove(&out[written], bufPtr, len);
        written += len;
        while (len < info.width) {
            out[written++] = ' ';
            len++;
        }
    }
end:
    out[written] = 0;
    return written;
}
