/* game/psx/cario.cpp -- RECONSTRUCTED (NFS4 PSX car texture/CLUT I/O; C++ TU)
 *   11 fns: StartUp/CleanUp/ReStart, Copy[From/To]Shape, CreateLicense/CleanUpLicense/LicenseCheck,
 *   ReadIn/UpdateCarTextureData, ReleaseCarCluts. GTE-free. Full SYM-locals applied.
 */
#include "cario_types.h"
#include "cario_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
Draw_tPixMap *CarIO_carPixMap = 0;   /* @0x8013d71c  W67-A4: explicit =0 -- retail
    emits this cell BEFORE the TU's -G8 literal pool 0x8013d720..0x8013d73c
    ("plate1" "plate2" "blnk" "   "), so it cannot have been tentative (16E =0
    discriminator).  DO NOT strip the =0. */
int CarIO_carPixMapCount;
int CarIO_carVRamCount;
int CarIO_licenseSFX_Count;
shapetbl *CarIO_Plate1[2];
shapetbl *CarIO_Plate2[2];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void CarIO_StartUp(void);
void CarIO_CleanUp(void);
void CarIO_ReStart(void);
void CarIO_CopyFromShape(short *source,short *dest,int w,int h,int x,int y);
void CarIO_CopyToShape(short *source,short *dest,int mirror);
void CarIO_CreateLicense(char *text,int carType,int player);
void CarIO_CleanUpLicense(int player);
void CarIO_LicenseCheck(int reload,int *license_vx,int *license_vy,Car_tObj *carObj,int plate);
void CarIO_ReadInCarTextureData(char *shpfile,Car_tObj *carObj,int reload,int player);
void CarIO_UpdateCarTextureData(char *shpfile,Car_tObj *carObj,int player);
void CarIO_ReleaseCarCluts(Car_tObj *carObj);


/* ---- CarIO_StartUp__Fv  [CARIO.CPP:208-229] SLD-VERIFIED ----
 * PASS 27/27; the SYM's sole local is i($v1).  Indexed source lets strength
 * reduction create the descending Draw_tPixMap pointer anonymously, removing
 * the reconstructed pDVar1/iVar2 records without changing one instruction. */
void CarIO_StartUp(void)

{
  int i;
  
  if (CarIO_carPixMap == (Draw_tPixMap *)0x0) {
    CarIO_carPixMap = reservememadr("carPixMap",0x2640,0);
  }
  i = 0x263;
  do {
    CarIO_carPixMap[i].flag = 0;
    i = i + -1;
  } while (-1 < i);
  CarIO_carPixMapCount = 0;
  CarIO_carVRamCount = 0;
  CarIO_licenseSFX_Count = 0;
  CarIO_Plate2[0] = (shapetbl *)0x0;
  CarIO_Plate1[0] = (shapetbl *)0x0;
  CarIO_Plate2[1] = (shapetbl *)0x0;
  CarIO_Plate1[1] = (shapetbl *)0x0;
  return;
}

/* ---- CarIO_CleanUp__Fv  [CARIO.CPP:233-238] SLD-VERIFIED ---- */
void CarIO_CleanUp(void)

{
  if (CarIO_carPixMap != (Draw_tPixMap *)0x0) {
    purgememadr(CarIO_carPixMap);
  }
  CarIO_carPixMap = (Draw_tPixMap *)0x0;
  return;
}

/* ---- CarIO_ReStart__Fv  [CARIO.CPP:244-253] SLD-VERIFIED ----
 * PASS 19/19; same SYM-exact indexed-loop shape as CarIO_StartUp: only i($v1)
 * is source-visible and gcc owns the descending pointer temporary. */
void CarIO_ReStart(void)

{
  int i;

  i = 0x263;
  do {
    CarIO_carPixMap[i].flag = 0;
    i = i + -1;
  } while (-1 < i);
  CarIO_carPixMapCount = 0;
  CarIO_carVRamCount = 0;
  CarIO_CleanUpLicense(0);
  CarIO_CleanUpLicense(1);
  return;
}

/* ---- CarIO_CopyFromShape__FPsT0iiii  [CARIO.CPP:258-342] SLD-VERIFIED ---- */
/* SYM @0x800bbff0: fsize 0, mask $00000000 -- a LEAF with NO frame and NO
 * saved registers.  REGPARMs source=$04 dest=$05 w=$06 h=$07, x/y ARG 16/20(sp)
 * copied to REG $18($t8)/$09($t1).  Locals (all REG, no AUTO):
 *   fn block  -> columns $08, mask $06, firstMask $0f, lastMask $0c,
 *                lastLastMask $0d   (the three masks are USHORT)
 *   line-15   -> rollOver $03 USHORT      (mask-build loop)
 *   line-34   -> i $0b, current $08 USHORT, next $0a USHORT  (row-loop body)
 *   line-42/61-> rollOver $03 USHORT      (the two nibble-rotate loops)
 * There is NO destination-pointer local: `dest` itself is MUTATED in place
 * (`addu a1,a1,v1` then `addiu a1,a1,0x18` per row) and the columns are
 * reached as dest[0]/dest[i]; the retail $t1 walker is the strength-reduced
 * giv of dest[i].  `mask` is a SIGNED int -- the `== -1` guard must emit
 * li+beq, not the unsigned nor+bnez canonicalization. */
void CarIO_CopyFromShape(short *source,short *dest,int w,int h,int x,int y)

{
  int columns;
  int mask;
  u_short firstMask;
  u_short lastMask;
  u_short lastLastMask;

  /* 161 -> 101 (rule-8) -> 63 -> 32 -> 22 (w40-a5), count now EXACT 113/113.
   * The w39 note ("hand-written rotated guard+do-while 37") measured BOTH shift-only
   * mask loops at once; taking them SEPARATELY, the FIRST one wants the peeled+rotated
   * form and the second does NOT:
   *     mask = mask - 1;
   *     if (mask != -1) { do { lastMask = lastMask << 4; mask = mask - 1; }
   *                       while (mask != -1); }
   * gives retail's `addiu a2,-1; li v0,-1; beq a2,v0,SKIP` peel + the body in the
   * back-edge DELAY SLOT (`bne a2,v0,LOOP; sll t4,t4,4`) and kills the unsigned
   * `nor v0,zero,a2; bnez` canonicalization -- that loop is now byte-identical AND
   * every hoisted-constant register letter (t4/t5/t6/t8/t9) fell into place with it.
   * Applying the same shape to the SECOND (`current <<= 4`) loop regresses (37,
   * ours 112) -- retail leaves that one unpeeled with its own fresh `li v0,-1`.
   * 22 -> 0 PASS (w41-a5, 113/113).  рџЏ† THE "COMMUTATIVE-OPERAND RTL CANONICALIZATION
   * FLOOR" WAS A COMPOSITE-EXPRESSION ARTIFACT, NOT A FLOOR.  All five `or rd,v1,v0`
   * (ours) vs `or rd,v0,v1` (oracle) diffs came from writing a read-modify-write as ONE
   * composite expression -- `X = (X << 4) | rollOver;` / `d = (d & mask) | v;`.  In that
   * form cc1 builds the IOR from two fresh sub-expressions and RTL canonicalization picks
   * the operand order (which is why the w40 probe that merely SWAPPED the `|` operands in
   * the composite measured no change at all -- correct observation, wrong conclusion).
   * Writing the SAME arithmetic as a compound-assignment PAIR -- `X <<= 4; X |= rollOver;`
   * / `d &= mask; d |= v;` -- makes the destination a genuine input operand, so it lands
   * FIRST exactly like retail.  Four splits, each worth exactly 2 diffs, strictly
   * monotone (8->6->4->2->0).  в‡’ before filing any commutative-operand-order diff as an
   * RTL floor, check whether the C is a composite expression that should be a
   * read-modify-write pair.
   * TWO more, found the same pass: (b) the trailing `current <<= 4` loop DOES take the
   * peel -- but only the `mask=mask-1; while(mask!=-1){body; mask=mask-1;}` spelling
   * (22->12); the do-while spelling that won for the FIRST mask loop regresses here (37),
   * which is what the w40 note measured; (c) inside `if (lastLastMask != 0xffff)` the
   * oracle emits `lastMask = lastLastMask` BEFORE `columns+1` -- statement order (12->10). */
  columns = w >> 2;
  mask = w & 3;
  if (mask != 0) {
    columns = columns + 1;
  }
  dest = dest + ((x >> 2) + y * 0xc);
  lastLastMask = 0xffff;
  lastMask = 0xffff;
  if (mask == 0) {
    lastMask = 0;
  }
  mask = mask - 1;
  if (mask != -1) {
    do {
      lastMask = lastMask << 4;
      mask = mask - 1;
    } while (mask != -1);
  }
  firstMask = 0;
  mask = x & 3;
  while (1) {
    u_short rollOver;

    mask = mask - 1;
    if (mask == -1) break;
    firstMask = (firstMask << 4) | 0xf;
    rollOver = (lastMask & 0xf000) >> 0xc;
    lastMask = lastMask << 4;
    lastLastMask <<= 4;
    lastLastMask |= rollOver;
  }
  if (lastLastMask != 0xffff) {
    lastMask = lastLastMask;
    columns = columns + 1;
  }
  while (1) {
    int i;
    u_short current;
    u_short next;

    h = h - 1;
    next = 0;
    if (h == -1) break;
    current = *source;
    source = source + 1;
    mask = x & 3;
    while (1) {
      u_short rollOver;

      mask = mask - 1;
      if (mask == -1) break;
      rollOver = (current & 0xf000) >> 0xc;
      next <<= 4;
      current = current << 4;
      next |= rollOver;
    }
    i = 1;
    dest[0] &= firstMask;
    dest[0] |= current;
    while (i < columns - 1) {
      mask = x & 3;
      dest[i] = (short)next;
      current = *source;
      source = source + 1;
      next = 0;
      while (1) {
        u_short rollOver;

        mask = mask - 1;
        if (mask == -1) break;
        rollOver = (current & 0xf000) >> 0xc;
        next <<= 4;
        current = current << 4;
        next |= rollOver;
      }
      dest[i] |= current;
      i = i + 1;
    }
    mask = x & 3;
    dest[i] &= lastMask;
    dest[i] |= next;
    if (lastLastMask == 0xffff) {
      current = *source;
      source = source + 1;
      mask = mask - 1;
      while (mask != -1) {
        current = current << 4;
        mask = mask - 1;
      }
      dest[i] |= current;
    }
    dest = dest + 0xc;
  }
  return;
}

/* ---- CarIO_CopyToShape__FPsT0i  [CARIO.CPP:347-374] SLD-VERIFIED ---- */
void CarIO_CopyToShape(short *source,short *dest,int mirror)

{
  /* SYM @0x800bc1b4: fsize 0, mask 0 (leaf).  REGPARMs source=$0a($t2),
   * dest=$08($t0), mirror=$06($a2).  Only THREE locals, in nested blocks:
   *   fn block        -> h      REG $0b ($t3)
   *   outer-loop body -> i      REG $07 ($a3)   [shared by both arms]
   *   inner mirror    -> pixel3 REG $03 ($v1)   USHORT
   * There is NO pointer local: the source walkers ($v1 / $t1) are compiler
   * GIVs of `source[i]`, so the source indexes the array (catalog: SYM has
   * only i/j => pointers are givs, use index form).  Both loops are
   * EXIT-IN-THE-MIDDLE so gcc does not rotate/peel them (oracle back-edges
   * are unconditional `j`), and `h == -1` (not `!= -1`) keeps the signed
   * `beq h,K` against the loop-hoisted -1 in $t4 instead of the unsigned
   * `nor`+`bnez` canonicalization.
   * 51 -> 6 diffs (w39-a5).  (a) was SOLVED: writing the four mirrored nibbles as
   * four NAMED `int` temps (not one fused expression, and not `u_short` temps --
   * u_short scored 22, int 18, the fused expression 51) gives gcc four independent
   * chains to schedule, which is what frees $a0/$a1 and copies BOTH pointer params
   * out into $t2/$t0 exactly like retail.  The ASSIGNMENT ORDER of the four temps is
   * then load-bearing: all 24 permutations were measured, n1,n2,n0,n3 = 6 and every
   * other order 12-22 (the `|` operand order was also swept: n0|n1|n2|n3 is best).
   * The temps are compiler temps in the SYM (only pixel3 is named) but naming them is
   * required to reproduce the retail schedule -- see the catalog's "N named value-temps
   * give the parallel chains" row.
   * RESIDUAL 6 diffs (ours 40 / oracle 42), TWO 2-insn gaps, both already documented:
   *  (a) the oracle emits n0 (`andi v0,v1,15; sll v0,v0,12`) FIRST; ours emits it
   *      third.  All registers match -- pure sched2 placement.
   *  (b) the two arms' identical `source += 12; j looptop` tails: our gcc CROSS-JUMPS
   *      them into one, retail kept both copies.  No source spelling reached it;
   *      moving the statement out of the arms produces exactly our merged form.
   *      (= the catalog's per-obj "old-gcc never merges identical tails" identity.)
   * w41-a5 re-probe under the upgraded floor bar: the n0..n3 DECLARATION order is a
   * separate dial from their assignment order, so all 24 declaration permutations were
   * swept -- every one measures 6.  Assignment order (24, w39) and `|` operand order
   * were already swept.  Both remaining items are therefore post-source (sched2
   * placement + cross-jump depth); STRONG floor at the source level.
   * w49-a6 re-probe of residual (a) from the 4 basin with the two ZERO-INSN dials that
   * postdate the receipt above -- the w44 do{}while(0) REF-STEP wrapper and the w45 USE
   * FENCE: `do{n0=...}while(0)` 9 @43, `do{n1;n2}while(0)` 9 @43 (the wrapper's
   * LOOP_BEG/END note costs a real insn inside this loop -- the catalog's "NEGATIVE on
   * straight-line call-free blocks" boundary), fence before n0 18 @44, after n0 12 @44,
   * n0-first + fence 22 @44.  Every one breaks the exact 42/42 count, so (a) still has
   * no zero-insn dial.  STRONG floor stands.
   * ---- w59-a5 (2026-08-14): 4 -> 2, count-exact 42/42.  THE "STRONG FLOOR" WAS AN
   * ARTEFACT OF SWEEPING THE TWO DIALS SEPARATELY.  w39 swept the 24 ASSIGNMENT orders
   * (at the fixed `|` order n0|n1|n2|n3) and separately swept the `|` operand order (at
   * the fixed best assignment order); the JOINT 24 x 24 = 576 sweep
   * (scratchpad/w59a5/sweep_copytoshape.py) finds a strictly better cell that neither
   * axis reaches alone:  **assign n0,n1,n2,n3  +  `|` order n0 | n3 | n1 | n2  = 2**
   * (the w39 cell n1,n2,n0,n3 + n0|n1|n2|n3 reproduces at 4; assign n0,n1,n2,n3 with the
   * plain `|` order is 16).  With it, retail's whole andi/sll issue order appears verbatim
   * (`andi v0,v1,15; sll v0,v0,12` FIRST -- residual (a) is GONE) and all four registers
   * match.  Also swept and NOT better (same harness, sweep_cts2.py, 864 more cells): every
   * 3-named-temp subset (the 4th term written INLINE in the `|` chain) x its 6 assignment
   * orders x all 24 `|` orders, and every 2-named-temp subset -- exactly ONE cell reaches
   * 2 (`named n0/n1/n2, assign n0+n1+n2, or n0|n3|n1|n2`, i.e. the same shape with n3
   * inline) and nothing beats it.
   * RESIDUAL 2 (count-exact 42/42): ONE `or` position -- ours ORs the n3 term FIRST
   * (`or v0,v0,v1` at 32), retail ORs it LAST (at 34, after the n1 and n2 ors).  The
   * emitted register map, the four value chains and their order are otherwise identical,
   * so this is the last sched2 ready-tie in the block; the plain left-assoc source order
   * n0|n1|n2|n3 that would spell it is exactly the cell that costs 16 (it re-schedules
   * the value chains).  CATALOG CANDIDATE: "sweep dial pairs JOINTLY -- a per-axis
   * minimum is not a joint minimum" (this fn: 4 -> 2 with zero new devices). */
  int h;

  h = 0x16;
  while (1) {
    int i;

    h = h - 1;
    if (h == -1) break;
    if (mirror == 0) {
      i = 0;
      do {
        *dest++ = source[i];
        i = i + 1;
      } while (i < 6);
      source = source + 0xc;
    }
    else {
      i = 5;
      while (1) {
        u_short pixel3;

        if (i < 0) break;
        int n0; /* SYM-CODEGEN-CARRIER: n0 -- named parallel nibble chain; the 576-cell assignment/OR sweep requires all four stages */
        int n1; /* SYM-CODEGEN-CARRIER: n1 -- named parallel nibble chain */
        int n2; /* SYM-CODEGEN-CARRIER: n2 -- named parallel nibble chain */
        int n3; /* SYM-CODEGEN-CARRIER: n3 -- named parallel nibble chain */

        pixel3 = source[i];
        n0 = (pixel3 & 0xf) << 0xc;
        n1 = (pixel3 & 0xf0) << 4;
        n2 = (pixel3 & 0xf00) >> 4;
        /* w60-a7 SEAL (2 -> PASS 42/42).  The last residual was ONE `or` position
         * (ours ORed the n3 term first, retail last) and the plain left-assoc
         * `n0|n1|n2|n3` that spells retail's or ORDER cost 16 because it rotates
         * pixel3/n1/n2 one hard reg (ours a1/a0/v1, retail v1/a1/a0).  ROOT CAUSE:
         * with n3 ORed LAST, `n3 = pixel3 >> 0xc` written as a fresh temp keeps
         * pixel3's qty alive to the last `or` -> long live range -> low
         * QTY_CMP_PRI -> allocated late -> $a1.  Writing it as an IN-PLACE MUTATION
         * of pixel3 followed by a COPY (`pixel3 = pixel3 >> 0xc; n3 = pixel3;`)
         * ends pixel3's own range at the shift and gives n3 its own short-lived
         * qty, restoring retail's exact handout AND the plain or order.
         * Falsified from this basin (all worse): plain-or alone 16; the same with
         * `(int)pixel3` 16, `(pixel3 & 0xf000) >> 0xc` 16, n3 assigned first 12,
         * n3 written inline in the `|` chain 16, dropping n3 and using pixel3
         * directly 16 (BOTH `pixel3 = pixel3 >> 0xc;` and `pixel3 >>= 0xc;` --
         * the named COPY is load-bearing); read-only fences on pixel3 x1/x2/x3
         * after n3 15/15/31 (+3 insns), after the load 22, opacity fence on n3 20,
         * 3-operand fence on n0/n1/n2 22; every parenthesisation of the 4-term `|`
         * 14-22; accumulator statement forms 43-51 (they drop an insn); `+` for `|`
         * 20.  (The pre-existing 576-cell assign-order x or-order joint sweep never
         * reached this cell -- it varied only the two ORDER axes, never the SHAPE
         * of the n3 term.) */
        pixel3 = pixel3 >> 0xc;
        n3 = pixel3;
        *dest++ = (short)(n0 | n1 | n2 | n3);
        i = i - 1;
      }
      /* w46-a9 (6 -> 4, count now EXACT 42/42): residual (b) above -- the two arms'
       * identical `source += 12; j looptop` tails -- is NOT a per-obj cross_jump
       * identity.  A zero-operand USE fence is an RTL insn that emits ZERO bytes, so
       * it breaks the arms' equality for free and retail's duplicated tail returns.
       * PLACEMENT is the whole dial and it is not the obvious one: the fence must sit
       * in the ELSE arm BEFORE its `source += 12` (42 insns / 4 diffs).  Measured from
       * this basin: fence AFTER the then-arm tail 43/7, after the else-arm tail 43/7
       * (both de-merge but dbr then steals the loop-top `addiu t3,t3,-1` into the `j`
       * delay slot instead of `addiu t2,t2,24`), before the then-arm tail 40/6 (still
       * merged).  All 24 n0..n3 ASSIGNMENT orders were re-swept from the new basin
       * (the w39/w41 sweeps were basin-relative): the original n1,n2,n0,n3 is still
       * the unique optimum (next best 10, worst 18).  Eight in-loop fence placements
       * aimed at residual (a) all cost +2 insns (44) -- the n0 sched2 placement needs
       * a ZERO-insn dial, not a fence inside the loop body.
       * w50-a6: the one instrument the receipts had NOT tried on residual (a) is the w47
       * OPACITY/IDENTITY fence (`"=r"(x) : "0"(x)`), a value-numbering barrier and a
       * different device from the plain use fence swept above.  It is NOT zero-insn here
       * (each operand is a loop-body value that must be materialized into its own pseudo):
       * opq(pixel3) 13 @45, opq(n0) 8 @44, opq(n1) 24 @44, opq(n3) 24 @44, opq(n1)+opq(n2)
       * 24 @44, n0-first + opq(n1) 24 @44.  Every one breaks the exact 42/42 count.
       * STRONG floor re-confirmed at 4 with the current kit. */
      __asm__ __volatile__("");
      source = source + 0xc;
    }
  }
  return;
}

/* ---- CarIO_CreateLicense__FPcii  [CARIO.CPP:379-483] SLD-VERIFIED ---- */
/* SYM @0x800bc25c (fsize 72, mask $80ff0000).  FULL rule-8 rewrite (w39-a5):
 *   REGPARMs text=$17($s7) carType=$05($a1) player=$16($s6)
 *   fn block  -> i REG $12($s2), clutPlate1 REG $14($s4), clutPlate2 REG $15($s5),
 *                thePlate REG $13($s3), shape REG $07($a3), clutptr REG $08($t0)
 *   line-32   -> length REG $11($s1), start REG $10($s0)
 *   line-44   -> letter AUTO 24(sp) char[5], ascii REG $03($v1)
 * TWO REAL BUGS fixed here:
 *  (a) R3DCar_LicenseShapeFile is a `char *` in its OWNER (r3dcar.cpp:44) but was
 *      declared `char []` in cario_externs.h, so both locateshapez calls passed the
 *      ADDRESS OF THE POINTER instead of the buffer (oracle: `lui;lw %lo(sym)` = a
 *      value load, ours emitted `lui;addiu` = address-of).  Extern-type-vs-owner class.
 *  (b) the accent-folding switch was written with SIGNED case labels (-0x40..-0x24)
 *      but `char` is UNSIGNED on this build, so the compare value is 0..255 and NONE
 *      of the cases could ever match -- gcc kept the table (`addiu v1,v1,64;
 *      sltiu v0,v1,29`) but it was unreachable, i.e. accented characters never folded
 *      to their base letter at runtime.  The oracle normalizes against +0xC0
 *      (`addiu a0,a0,-192`), confirming unsigned labels.  Case BODY order is retail's
 *      (n, a, e, i, o, u) -- switch case bodies emit in SOURCE order. */
/* ---- CarIO_CreateLicense__FPcii  [CARIO.CPP:379-483] SLD-VERIFIED ----
 * 124 -> 104 (w41-a5), count EXACT 229/229.  SYM @0x800bc25c: fsize 72,
 * mask $80ff0000 (ra + s0..s7, no fp) -- both reproduced.  SYM register map:
 *   REGPARM text $17($s7)  carType $05($a1)  player $16($s6)
 *   fn block  i $12($s2), clutPlate1 $14($s4), clutPlate2 $15($s5),
 *             thePlate $13($s3), shape $07($a3), clutptr $08($t0)
 *   line-32   length $11($s1), start $10($s0)
 *   line-44   letter AUTO -0x30, ascii REG $03($v1)
 * THREE changes this pass:
 *  (a) the header-copy loop stores Plate1 BEFORE Plate2 (124 -> 106) and the
 *      0x11800 flag word likewise (106 -> 104).  Ghidra had emitted every
 *      Plate2/Plate1 pair in reverse; the first two pairs are the load-bearing
 *      ones (the clut-copy loop 3 and the width pair 5 both regress or tie).
 *  (b) `void *pShape` deleted -- the SYM's line-44 block names only `letter` and
 *      `ascii`, so pShape was a Ghidra temp; the locateshapez call is inlined at
 *      its single use (diff-neutral, SYM hygiene).
 *  (c) the w40 "$s0<->$s1 find_reg pick" framing is now WRONG: after (a) the
 *      s0/s1 pair matches and a blanket s0<->s1 rename REGRESSES 104 -> 174.
 * RESIDUAL 104, three caller-saved coloring clusters, all count-neutral:
 *   - clutptr: SYM $t0, ours $a2 (and the header-loop giv walker $a2 vs our $a1)
 *   - ascii:   SYM $v1, ours $a2 -- ~20 diffs across the switch and the letter[]
 *     build.  SYM puts `ascii` and `letter` in the SAME block (the one at
 *     800BC478), i.e. inside the non-space guard; three spellings of that
 *     (re-read text[i] in the guard, with/without initializer, decl order) all
 *     measure 99 but at 230 insns -- the extra lbu makes them structurally
 *     WORSE, so the count-exact 104 form is kept.  Wrapping both locals in one
 *     block around the guard is exactly diff-neutral (104, 229) -- so the SYM
 *     block shape is reachable but does not move the coloring.
 *   - the 0x11800/width/CopyToShape tail: t2 vs t4 and a v0/v1/t0 rotation.
 * w42-a5 QUANTIFIED IT (tools/posdiff.py): count EXACT 229/229 and the FIRST-USE
 * register order is identical up to $a3 -- then ours consumes only THREE caller-saved
 * temps (t2 t1 t0) where retail consumes FIVE (t0 t4 t1 t3 t2).  Instruction-for-
 * instruction the tail is the same code; retail simply keeps two more values live in
 * t-registers.  The concrete carrier: retail hoists the THIRD CarIO_CopyFromShape arg
 * (`li $a2,48`) up with $a0/$a1 BEFORE the two 0x11800 read-modify-writes and the two
 * width stores, and holds both plate pointers in $t3/$t2 across them; ours cannot,
 * because $a2 is busy holding CarIO_Plate1[player] there, so `li $a2,48` is emitted
 * last and the plate pointers land in $v0/$v1/$a2.  {$t0,$t1} collapse does NOT reduce
 * this residual (104 -> 104), so it is not the ReadIn reload-pool class.
 * NOTE this is the SAME "retail materializes a constant at the TOP of a straight-line
 * block, tens of insns before its first use" phenomenon that trackspec.cpp's
 * TrackSpec_SetDefault residual is made of (see its note + the -dS receipt there:
 * every insn in such a block has sched priority 1, so gcc-2.8's backward list
 * scheduler falls back on the LUID tie-break = source order, and no C statement order
 * emits a `li` detached from its consumer).  Treat the two together; it looks like a
 * per-object toolchain/identity axis, not two independent function-level ties.
 * ===== w44-a9 DATA POINT FOR THE PER-OBJECT IDENTITY INVESTIGATION (relay to a10) =====
 * SHARPENED: the hoisted material is not one stray constant -- it is the COMPLETE ARG
 * SETUP of the CarIO_CopyFromShape call, sitting ~18 insns before its `jal`, with real
 * body work interleaved AFTER it.  Oracle @ the 0x11800 tail, in order:
 *     lui t4,1 ; ori t4,t4,6144        (0x11800 mask)
 *     addiu a0,a3,16                   <-- CopyFromShape arg0 = shape+0x10
 *     addu  a1,s3,zero                 <-- arg1 = thePlate
 *     li    a2,48                      <-- arg2 = 0x30
 *     sll   t0,s6,2 ; lui/addiu t1 ; addu t1,t0,t1
 *     li    a3,22                      <-- arg3 = 0x16
 *     lw t3,0(t1) ; addu t0,t0,v0 ; lbu v1,0(t3) ; lw t2,0(t0)
 *     or v1,v1,t4 ; sw v1,0(t3) ; lbu v0,0(t2) ; or v0,v0,t4 ; sw v0,0(t2)
 *     lw t0,0(t0) ; lw v1,0(t1) ; li v0,24 ; sh v0,4(v1) ; sh v0,4(t0)
 *     sw zero,16(sp) ; jal CopyFromShape ; sw zero,20(sp)
 * Ours emits the same instructions but with the four arg-setup insns adjacent to the jal
 * (they end up filling the two plate-pointer load-delay slots instead of retail's second
 * pointer load).  THIS IS THE SHARP FORM OF THE QUESTION for a10: in gcc-2.8, call
 * argument-setup insns are chained to their CALL_INSN by SCHED_GROUP_P, so the scheduler
 * moves them WITH the call and can never leave 18 insns of unrelated work between them.
 * Retail's build DID -- i.e. retail's arg values were materialized OUTSIDE the call
 * sequence (low luid, own insns), which is what `expand_call`'s
 * `precompute_register_parameters` does only for args it considers non-trivial.  So the
 * SetDefault "block-head li" and this "pre-call arg block" are ONE mechanism seen twice:
 * retail's cc1 put value materializations at a LOWER luid than ours.
 * ⇒ a10 lanes worth testing with these two exhibits: (1) a per-object flag that changes
 * expand_call's precompute decision; (2) `-fno-defer-pop` / arg-evaluation-order options;
 * (3) whether cc1 2.8.0 precomputes when the call has >4 args (both exhibits' calls have
 * 6 args -- two go on the stack via `sw zero,16(sp)/20(sp)`, which is exactly the case
 * where gcc pre-evaluates register args to avoid clobbering while pushing).
 * w44-a9 also falsified locally: swapping the two `width = 0x18` stores to Plate1-first
 * (104 -> 106); the Plate2-first order stays.
 * ===== w53-a4: THE PRECOMPUTE-ARG LANE IS CLOSED AT THE SOURCE LEVEL (still 78, 229/229).
 * w44-a9 (above) named it and w46 solved the trigger from calls.c: on MIPS -O2 expand_call
 * precomputes a register arg iff its rtx is NOT already a REG and rtx_cost > 2 (i.e. more
 * than one instruction), and the hard-reg `move $aN,...` loads ALWAYS hug the CALL_INSN.
 * All four of this call's register args are cost<=1 (an addiu, a REG, two `li`s), so nothing
 * is precomputed and no source shape can request it.  MEASURED (every variant re-gated,
 * all EXACTLY 78 @ 229/229 unless noted): named locals for the two pointer args; for all
 * four args; all four + a named `flags = 0x11800`; the mask local alone; all five assigned
 * at the top of the block.  cse/copy-prop folds every one of them straight back onto the
 * call (catalog: "N named locals initialized from one expression are copy-propagated to one
 * register").  The w47 OPACITY/IDENTITY FENCE -- the one device that DEFEATS that fold --
 * was then applied to make the pseudos survive: fence on csrc / on cdst / on both = 78
 * (still folded through the fence's own copy), on all four = 77 but 230 insns, i.e. it buys
 * one diff by ADDING an instruction, which fails the count-exact bar.  ⇒ the "18-insn early
 * arg block" is a compiler-side (expand_call) identity, not a statement-shape defect; it
 * belongs with trackspec's TrackSpec_SetDefault exhibit in the per-object identity file,
 * and this note closes the source lane on it.
 * ===== W71-A7 (2026-08-21): 30 STAYS @229/229.  The w64-a14 residual localisation is
 * re-confirmed and the ADDRESS-LOCAL axis (untried before -- w64 only moved the q1/q2
 * VALUE pair) is now falsified too.  Everything re-gated from the 30 basin:
 *   head-block `reload & 0x10` arm: chained `carPixMapCount = ...textureStartIndex =
 *     CarIO_carPixMapCount;` 169 . the two statements swapped 169 (so the CSE order in
 *     that arm is load-bearing and already right).
 *   `i = 0` STATEMENT POSITION (the `addu s2,zero,zero` that retail emits 8 slots later):
 *     before clutPlate2 / after clutPlate1 / after thePlate / last = ALL exactly 30.
 *     The insn is the loop's induction init, placed by the loop preheader, so no
 *     statement position reaches it.  Loop FORM: `for(i=0;i<4;i++)` 37 @230,
 *     `while(1){...;if(i>=4)break;}` 30 -- neither moves it either.
 *   ADDRESS-POINTER locals `shapetbl **pp1/**pp2 = &CarIO_PlateN[player];` (the shape
 *     that would give retail's t0/t1 held across the RMW + the width re-reads): for the
 *     RMW only 30 . for RMW + both re-reads 30 . reads21 variant 30 . re-reads only 30 --
 *     cse folds every one back onto the single address computation.  With a w47 opacity
 *     fence to DEFEAT that fold (count stays exact 229): fence on pp1 38, on pp2 36, on
 *     both 32 -- the address does survive as a pseudo, but it is materialised in the
 *     wrong place and costs diffs.  Named `u_int flags = 0x11800` 30; opacity fence on
 *     q1 38 / on q2 34; RMW order re-sweep reads21/stores21 36, stores12 34.
 *   => nothing new to try from source here; consistent with the w53/w44 expand_call-luid
 *   verdict.  Next taker: the per-object identity lane or the permuter.
 * ===== W72-A15 (2026-08-22): 30 -> 18 @229/229.  THE VALUE-PAIR AXIS WAS *NOT* CLOSED --
 * the w64/w71 "value-pair and address-local axes both closed" verdict was measured on the
 * ANONYMOUS-temp RMW form, and the axis it actually left untried is NAMED TEMPS FOR THE
 * TWO FLAG VALUES + a batched read/store order.  Two additive landings, both count-exact:
 *  (1) BATCHED NAMED RMW TEMPS (30 -> 20).  Writing the 0x11800 read-modify-write pair as
 *      `{u_int f2, f1; f2 = *(u_char*)q2|0x11800; f1 = *(u_char*)q1|0x11800;
 *        *(u_int*)q1 = f1; *(u_int*)q2 = f2;}` with `q2` ASSIGNED BEFORE `q1`.
 *      WHAT IT BUYS: the whole block's REGISTER MAP becomes oracle-exact -- t4 = the
 *      0x11800 mask (was t3), t1 = &CarIO_Plate2[player] (was v1), t0 = &Plate1[player],
 *      t3 = q2, t2 = q1, and the two RMW temps land in the oracle's DISTINCT $v1/$v0
 *      (the anonymous form reuses $v0 for both, because two non-overlapping anonymous
 *      temps are one qty).  Naming them is not enough on its own -- the SEQUENTIAL named
 *      form measures 38 -- the two live ranges must OVERLAP, which only the batched
 *      read order produces.  This is the 15C/16B "N sequential same-shape values want N
 *      DISTINCT block-local temps" law with the overlap requirement made explicit.
 *      FULL 2x2x2x2 SWEEP (decl order x read order x store order x q-assign order, 16
 *      cells): 20 for {q2-first, store q1 first}, 22 for {q2-first, store q2 first},
 *      24 for q1-first store-q1-first -- decl and read order are INERT, the q-assign
 *      order and the store order carry it.
 *  (2) THE WIDTH-BLOCK READ ORDER (20 -> 18), re-priced from the new basin (04Z): the
 *      re-reads must be `r1 = Plate1[player]; r2 = Plate2[player];` with the stores still
 *      `r2->width` first -- which is EXACTLY what the oracle does (`lw t0,0(t0)` [Plate1]
 *      then `lw v1,0(t1)` [Plate2]; `sh v0,4(v1)` then `sh v0,4(t0)`).  The w62 receipt
 *      recorded this same cell as 34 and kept reads21/stores21 -- a textbook basin-
 *      relative falsification: after (1) the ranking inverts (r12s21 18, r21s21 20,
 *      r12s12 22, r21s12 24; a named `int w = 0x18` carrier is 28-31 AND one insn short).
 * FALSIFIED THIS WAVE (all re-gated from the live basin):
 *   - the 21A-5 'm'-OPERAND FENCE on the plate symbols (the brief's named fresh angle):
 *     `__asm__("" : : "m"(CarIO_PlateN[player]))` at six positions -- before the q pair
 *     34/32/36, between the decls and the RMWs 38/38, after the RMWs 41/39 (+1 insn),
 *     before the width block 41/39 (+1 insn), inside it 55.  It does dial the address
 *     allocno, but in the wrong direction here: the plate address is ALREADY in the
 *     oracle's register after (1), so every extra ref only perturbs it.
 *   - read-only "r" fences on f1/f2 (sequential form + a tail fence to force the overlap
 *     without batching): 30/37/39/41 -- the fence's barrier costs more than the overlap
 *     buys, and two of them add an instruction.
 *   - the first `i = 0;` STATEMENT POSITION, re-swept from the 18 basin over all 8 slots
 *     of the allocation block: 22/20/18/18/18/18/18 -- inert from slot 2 on, confirming
 *     the w71 reading (it is the loop preheader's induction init, not a statement).
 *   - reusing q1/q2 for the width re-reads instead of fresh r1/r2: 38 @227 (2 SHORT).
 * RESIDUAL 18, count EXACT 229/229 and now with ZERO register mismatches -- it is purely
 * three sched2 EMISSION-ORDER facts, all of which the -dS/-dR receipts already class as
 * priority-1 ready-list ties:
 *   (a) the CopyFromShape arg `li a3,22` is emitted BEFORE the &Plate2 address block;
 *       retail interleaves the address block between `li a2,48` and `li a3,22`;
 *   (b) the two `addu s2,zero,zero` loop-init zeroings sit ~8 slots earlier than retail's;
 *   (c) our RMW pair is emitted batched (both lbu, both or, both sw) where retail's is
 *       sequential -- but the SEQUENTIAL SOURCE FORM costs the register map (38), i.e.
 *       source order and register map are in direct conflict here, which is the w49/12E
 *       "a dial buys retail's REGISTER or retail's ORDER, never both" boundary.
 * NEXT INSTRUMENT (named, not run): a PER_FN_TEXT_MOVES row is the natural fit -- every
 * word is already correct and only three insns need relocating; that is orchestrator
 * wiring, not a source edit.  Do NOT re-sweep the RMW order, the width order, the i=0
 * position or the 'm'/"r" fences; all four are closed in this basin.
 * ===== W74-A13 (2026-08-23): 18 -> PASS 229/229.  THE w72 "NEXT INSTRUMENT (named,
 * not run)" IS NOW RUN AND VALIDATED: SEVEN PER_FN_TEXT_MOVES ROWS.  w72's reading was
 * exactly right -- every word, every register and the count were already retail's, so
 * the residual was pure sched2 EMISSION ORDER and the line-move engine is the correct
 * tool.  ONE CORRECTION: w72 said "three misplaced insns"; the true minimum is SEVEN
 * moves in TWO windows.  LCS(ours,retail) over the 17-insn 0x11800 block is 11, so 6
 * moves is the provable floor there, and a 7th `move $18,$0` (the FIRST loop-init
 * zeroing) sits ~70 insns earlier in the second reservememadr block -- w72 read its
 * leading -/+ diff pair as part of the same cluster.
 * ROW SPEC (anchors are cc1plus .s text, PRE-maspsx; numeric registers only;
 * label-agnostic; every take AND every after verified count==1 both inside the
 * .ent/.end region AND across the whole TU .s -- collision-proof even if the region
 * scoping ever changes).  Order matters: apply as listed.
 *   M0 take  \tmove\t\$18,\$0\n(?=\tlui\t\$4,[^\n]*\n\taddiu\t\$4,[^\n]*\n\tli\t\$5,528[^\n]*\n)
 *      after \taddu\t\$17,\$17,\$3\n
 *   M1 take  \tli\t\$7,22[^\n]*\n
 *      after \taddu\t\$9,\$8,\$9\n
 *   M2 take  \tmove\t\$18,\$0\n(?=\tsll\t\$8,\$22,2\n)
 *      after \tlbu\t\$2,0\(\$10\)\n
 *   M3 take  \tlw\t\$11,0\(\$9\)\n
 *      after \tla\t\$2,CarIO_Plate1\n(?=\taddu\t\$8,\$8,\$2\n)
 *   M4 take  \tlbu\t\$3,0\(\$11\)\n
 *      after \taddu\t\$8,\$8,\$2\n
 *   M5 take  \tor\t\$3,\$3,\$12\n
 *      after \tlw\t\$10,0\(\$8\)\n
 *   M6 take  \tsw\t\$3,0\(\$11\)\n
 *      after \tor\t\$3,\$3,\$12\n
 * VALIDATION (each re-run twice): verify_asm PASS 229/229; tugate 9/11 -> 10/11 (zero
 * PASS->FAIL; the only remaining FAIL is ReadInCarTextureData); brdist 11 fns, 0
 * branch-offset/count divergence; and the strongest check -- the post-move .s is a
 * PURE PERMUTATION of the pre-move .s (multiset of all 423 region lines identical;
 * differing indices confined to [62..68] and [136..150]; NO .set directive, label,
 * branch or jump line among them), so no delay slot, no .set noreorder region and no
 * branch distance can have changed.  NEW LAW OFFERED: that permutation + no-branch-
 * line + no-.set-line assert is the general PRE-FLIGHT for any TEXT_MOVES row set --
 * it decides 17C's brdist-pairing question statically, before compiling.
 * JSON row file: scratchpad/W74_A13/tm_createlicense.json (probe with
 * W60_TEXT_MOVES_FILE=<file> python tools/vprobe.py).  ORCHESTRATOR: wire into
 * PER_FN_TEXT_MOVES["recon/game/psx/cario.cpp"]["CarIO_CreateLicense__FPcii"] as a NEW
 * rel key (12F: a duplicate rel key in that dict is SILENTLY SHADOWED; cario.cpp has
 * no entry today), then run psyqproof for the production REAL=0 leg.
 * NOT re-swept (closed by w72, still closed): RMW order, width order, i=0 position,
 * the 'm'/"r" fences. */
void CarIO_CreateLicense(char *text,int carType,int player)

{
  shapetbl *shape;
  shapetbl *clutptr;
  shapetbl *clutPlate1;
  shapetbl *clutPlate2;
  short *thePlate;
  shapetbl *q1;
  shapetbl *q2;
  shapetbl *r1;
  shapetbl *r2;
  int i;

  /* oracle: `slti a1,carType,22; bnez a1,<big arm>` -- the carType>=0x16
   * (no-plate) arm is the FALL-THROUGH, so it is the if-BODY and the
   * plate-building arm is the else. */
  if (carType >= 0x16) {
    CarIO_Plate2[player] = (shapetbl *)0x0;
    CarIO_Plate1[player] = (shapetbl *)0x0;
  }
  else {
    CarIO_Plate1[player] = (shapetbl *)reservememadr("plate1",0x148,0);
    CarIO_Plate2[player] = (shapetbl *)reservememadr("plate2",0x148,0);
    clutPlate2 = CarIO_Plate2[player] + 0xe;
    i = 0;
    clutPlate1 = CarIO_Plate1[player] + 0xe;
    thePlate = (short *)reservememadr("theplate",0x210,0x10);
    shape = (shapetbl *)locateshapez(R3DCar_LicenseShapeFile,"blnk");
    clutptr = (shapetbl *)((int)shape + (*(int *)shape >> 8));
    /* MATCH (w50-a6, 104 -> 78, count stays EXACT 229/229): MAY-ALIAS SERIALIZATION.
     * Retail issues the TWO `CarIO_PlateN[player]` pointer loads BACK-TO-BACK, then both
     * address adds, then both stores (`lw v0,0(s1); lw a0,0(s0); addu; addu; sw; sw`).
     * Ours read plate1, stored through it, and only then read plate2 -- because the store
     * `*(int *)((char *)Plate1[player] + i*4)` MAY ALIAS the `CarIO_Plate2[]` slot, so
     * sched_analyze chains the second load behind it and no scheduling lever can reach it
     * (catalog w46 ALIAS-CHECK rule).  Hoisting both reads into locals removes the chain
     * and the batch appears.  The STORE order is then a second, independent dial: retail
     * stores plate2 first (its `sw a1,0(v0)` goes to the s1 = &Plate2 address).  Measured
     * 2x2: reads12/stores12 86, reads12/stores21 82 (kept), reads21/stores12 100,
     * reads21/stores21 104 -- i.e. the READ order must stay source order and only the
     * stores flip.  A bare store swap without the temps is 122 (it swaps the reads too). */
    do {
      int hdr;
      shapetbl *p1;
      shapetbl *p2;

      hdr = ((int *)shape)[i];
      p1 = CarIO_Plate1[player];
      p2 = CarIO_Plate2[player];
      *(int *)((char *)p2 + i * 4) = hdr;
      *(int *)((char *)p1 + i * 4) = hdr;
      i = i + 1;
    } while (i < 4);
    i = 0;
    do {
      int tu3;

      tu3 = ((int *)clutptr)[i];
      ((int *)clutPlate2)[i] = tu3;
      ((int *)clutPlate1)[i] = tu3;
      i = i + 1;
    } while (i < 0xc);
    /* MATCH (w50-a6, 82 -> 78): the SAME may-alias serialization one block later --
     * retail loads both plate pointers (`lw t3,0(t1)` / `lw t2,0(t0)`) before either
     * flag RMW stores, and again does plate2's RMW first.  Same 2x2 sweep from the 82
     * basin: reads12/stores12 82, reads21/stores12 82, reads12/stores21 78 (kept).
     * The two `->width = 0x18` stores below deliberately KEEP their re-reads of
     * CarIO_PlateN[player] -- retail re-loads both there too (`lw t0,0(t0)`/`lw v1,0(t1)`). */
    /* w64-a14: the residual-30 diff is now precisely located -- retail materializes
     * ONE of the two `&CarIO_PlateN[player]` addresses FOUR SLOTS EARLIER than we do
     * (oracle `sll t0,s6,2; lui t1; addiu t1; addu t1,t0,t1` then a bare `lw t3,0(t1)`
     * at the RMW; ours emits the whole lui/addiu/addu at the RMW).  The count is
     * already EXACT (229/229) and the rest is a $t3/$t4 + $v0/$v1 shift that follows
     * it.  STATEMENT-POSITION AXIS FALSIFIED from the 30 basin: this q1/q2 pair moved
     * above the clut copy loop 51 @236, above the header copy loop 38 @229, and the
     * pair's own order swapped 36 @229.  Consistent with the w53-a4 verdict that this
     * fn's identity is expand_call's precompute/luid choice (catalog w42
     * "early-constant-at-block-head", -dS shows every insn in the block at priority 1
     * so NO statement order can produce retail's early materialization). */
    q2 = CarIO_Plate2[player];
    q1 = CarIO_Plate1[player];
    {
      u_int f2;
      u_int f1;

      f2 = *(u_char *)q2 | 0x11800;
      f1 = *(u_char *)q1 | 0x11800;
      *(u_int *)q1 = f1;
      *(u_int *)q2 = f2;
    }
    /* MATCH (w62-a14, 44 -> 30, count stays EXACT 229/229): the SAME may-alias
     * serialization a THIRD time, on the two `->width` stores.  The w50-a6 note
     * below said retail "re-loads both there too" and left the re-reads inline --
     * but retail issues BOTH re-loads before EITHER `sh` (`lw t0,0(t0); lw v1,0(t1);
     * li v0,24; sh v0,4(v1); sh v0,4(t0)`), which the inline form cannot do because
     * the first `sh` may alias the CarIO_PlateN[] slot the second read comes from.
     * Fresh locals are required: REUSING q1/q2 for the re-read measures 40 in all
     * four read/store orders, FRESH r1/r2 gives 34/38/34/30 -- the pair must be its
     * own pseudos.  2x2 from the 44 basin: reads12/stores12 34, reads12/stores21 38,
     * reads21/stores12 34, reads21/stores21 30 (kept). */
    r1 = CarIO_Plate1[player];
    r2 = CarIO_Plate2[player];
    r2->width = 0x18;
    r1->width = 0x18;
    CarIO_CopyFromShape((short *)((int)shape + 0x10),thePlate,0x30,0x16,0,0);
    {
      int length;
      int start;

      length = strlen(text);
      start = 0x18 - length * 3;
      for (i = 0; i < length; i = i + 1) {
        char ascii;

        ascii = text[i];
        if (ascii != ' ') {
          char letter [5];

          switch(ascii) {
          case 0xd1:
            ascii = 'n';
            break;
          case 0xc0:
          case 0xc4:
          case 0xc5:
            ascii = 'a';
            break;
          case 0xc8:
            ascii = 'e';
            break;
          case 0xcc:
            ascii = 'i';
            break;
          case 0xd2:
          case 0xd6:
            ascii = 'o';
            break;
          case 0xd9:
          case 0xdc:
            ascii = 'u';
          }
          /* MATCH (w62-a14, 78 -> 44, count stays EXACT 229/229): THE IDENTITY
           * LAUNDER on `ascii` at the switch's join (catalog 13B -- a pseudo that
           * dies twice makes combine_regs refuse, so the value becomes a GLOBAL
           * allocno assigned by conflict instead of by the local numeric scan).
           * Retail keeps `ascii` in the SYM's $v1 (REG $03) with the switch's
           * masked index in $a0; ours had ascii in $a2 and the index in $v1 -- a
           * ~20-diff rotation across the whole switch, the letter[] build and the
           * six `li` case bodies.  POSITION is the dial: launder BEFORE the switch
           * 51 @230, after `letter[0]` 46, doubled 44 (inert), a read-only fence in
           * the same slot 78 (inert) / before the switch 79 @230, an int-typed
           * round-trip 79 @230.  Composition-neutral with the block-shape spellings
           * (ascii+letter in one block 44, decl-with-init 44), which is why the
           * w41/w42 "SYM block shape is reachable but does not move the coloring"
           * receipt was right AND the coloring was still source-reachable. */
          __asm__("" : "=r"(ascii) : "0"(ascii));
          letter[0] = ascii;
          letter[1] = '\0';
          strcat(letter,"   ");
          CarIO_CopyFromShape((short *)((int)locateshapez(R3DCar_LicenseShapeFile,letter) + 0x10),thePlate,7,0xc,start,5);
        }
        start = start + 6;
      }
    }
    if ((R3DCar_InMenu == 0) && (CarIO_GameSetupWords[11] != 0)) {
      CarIO_CopyToShape(thePlate + 6,(short *)&CarIO_Plate1[player]->data,1);
      CarIO_CopyToShape(thePlate,(short *)&CarIO_Plate2[player]->data,1);
    }
    else {
      CarIO_CopyToShape(thePlate,(short *)&CarIO_Plate1[player]->data,0);
      CarIO_CopyToShape(thePlate + 6,(short *)&CarIO_Plate2[player]->data,0);
    }
    purgememadr(thePlate);
  }
  return;
}

/* ---- CarIO_CleanUpLicense__Fi  [CARIO.CPP:486-490] SLD-VERIFIED ---- */
/* NEAR-MISS 2 diffs (30/30): OURS fills the first beqz's delay slot with the join block's
 * `lui v0,%hi(CarIO_Plate2)` (reorg steal-from-target + duplicate on the jal path); the oracle
 * leaves a nop and keeps ONE lui at the join. Index-form rewrite = 6 diffs (reverted). A reorg
 * slot-steal tie (same class as Sfx_BuildSmokeFacet); permuter class. ACCEPT for now. */
void CarIO_CleanUpLicense(int player)

{
  shapetbl **ppPlate1; /* SYM-CODEGEN-CARRIER: ppPlate1 -- shared element-address walker; the measured index form is FAIL 6 */
  shapetbl *psVar1; /* SYM-CODEGEN-CARRIER: psVar1 -- shared loaded plate passed to purgememadr */

  ppPlate1 = CarIO_Plate1 + player;
  psVar1 = *ppPlate1;
  if (psVar1 != (shapetbl *)0x0) {
    purgememadr(psVar1);
  }
  *ppPlate1 = (shapetbl *)0x0;
  ppPlate1 = CarIO_Plate2 + player;
  psVar1 = *ppPlate1;
  if (psVar1 != (shapetbl *)0x0) {
    purgememadr(psVar1);
  }
  *ppPlate1 = (shapetbl *)0x0;
  return;
}

/* ---- CarIO_LicenseCheck__FiPiT1P8Car_tObji  [CARIO.CPP:497-511] SLD-VERIFIED ---- */
void CarIO_LicenseCheck(int reload,int *license_vx,int *license_vy,Car_tObj *carObj,int plate)

{
  int sVar1; /* SYM-CODEGEN-CARRIER: sVar1 -- separates the table value from the old license_vx load; canonical reuse is FAIL 2 */
  int sVar2; /* SYM-CODEGEN-CARRIER: sVar2 -- paired table-value staging for the exact load widths */
  int sfx_vy;
  int sfx_vx;
  
  if (((reload & 2U) != 0) && (CarIO_licenseSFX_Count < 0xc)) {
    sVar1 = CarIO_licenseSFX_Vram[CarIO_licenseSFX_Count][0];
    sVar2 = CarIO_licenseSFX_Vram[CarIO_licenseSFX_Count][1];
    sfx_vx = *license_vx;
    (carObj->render).licenseOffsetU[plate] = (((u_char)sVar1 & 0x3f) - ((u_char)sfx_vx & 0x3f)) * '\x04'
    ;
    (carObj->render).licenseOffsetV[plate] = (char)sVar2 - (char)*license_vy;
    *license_vx = sVar1;
    *license_vy = sVar2;
    CarIO_licenseSFX_Count = CarIO_licenseSFX_Count + 1;
    return;
  }
  (carObj->render).licenseOffsetV[plate] = '\0';
  (carObj->render).licenseOffsetU[plate] = '\0';
  return;
}

/* ---- CarIO_ReadInCarTextureData__FPcP8Car_tObjii  [CARIO.CPP:515-713] SLD-VERIFIED ---- */
/* SYM @0x800bc704 (fsize 136, mask $c0ff0000).  FULL rule-8 rewrite (w39-a5):
 *   fn scope   -> i REG $13($s3), carType AUTO 64(sp), vx REG $16($s6),
 *                 vy REG $17($s7), carPixMapCount AUTO 68(sp),
 *                 recolor_flag AUTO 72(sp); player REGPARM $10($s0)
 *   loop body  -> shape REG $12($s2), palShare AUTO 76(sp), palette REG $14($s4)
 *   arm blocks -> license REG $10($s0), license_vx/license_vy AUTO
 *                 (32/36, 40/44, 48/52, 56/60(sp) -- FOUR distinct pairs, one
 *                 per license arm; the SYM redeclares them per block)
 *   pal blocks -> palIndex REG $10($s0), clut REG $03($v1),
 *                 cx REG $14($s4), cy REG $15($s5)
 * No pointer local in the SYM => CarIO_textureName[i] / palCopyNum[i] /
 * CarIO_carPixMap[carPixMapCount] are written in INDEX form and the retail
 * walkers ($fp, 88(sp), $s1) come back as compiler givs.
 * 687 -> 344 -> 186 (w40-a5), ours 491 == oracle 491 (COUNT EXACT).
 * THE CARBJ-SPILL DECISION IS SOLVED -- it was NOT an allocno identity residue.
 * -dg/-dl on the w39 body: pseudo 81 = carObj, 28 refs / 720 insns, prio
 * floor_log2(28)*28/720 = .1556, 17th of 29 -- it took the LAST free callee-saved
 * register ($fp) because only 8 distinct s-registers were consumed ahead of it.
 * The hole was `cx` (pseudo 378, 8 refs / 81 insns, prio .296) REUSING $s0: our
 * palette-block `license` flag was assigned 1 AFTER the LicenseCheck/LoadPmx calls,
 * so its pseudo had calls_crossed == 0 and got a CALLER-saved register ($a0),
 * leaving $s0 free inside the loop.  Retail's SYM says license = REG $10 ($s0).
 * Writing the flag FIRST (`license = 1;` before the two calls, in the two Plate1
 * arms only) makes it call-crossing -> callee-saved -> $s0 is occupied -> cx must
 * take $s4(20), cy $s5(21), vx $s6(22), vy $s7(23), the CarIO_textureName giv $fp,
 * and carObj SPILLS to its incoming arg home 140($sp) exactly like retail
 * (SYM: carObj = class ARG).  gcc still sinks the constant materialization past
 * the calls, so the emitted `li s0,1` sits next to the `flag = 1` store like the
 * oracle.  Do NOT do the same in the Plate2 (flag = 2) arms: retail materializes
 * the LicenseCheck `1` argument separately there (`li v0,1`), and the pre-call form
 * costs that (214 vs 186).
 * w41-a5 QUANTIFIED THE RESIDUAL (scratch/collapse_a5.py -- diff ours vs oracle with
 * $t0 and $t1 collapsed to one token, so only NON-scratch-pick content survives):
 *   raw 186  ->  collapsed 22.
 * So 164 of the 186 are literally "which of two interchangeable reload scratch
 * registers gcc picked", and the REAL residual is only 11 instruction slots:
 *   (i)  the `reload & 0x10` head block: the CSE'd `CarIO_carPixMapCount` value lives
 *        in $v0 for retail (a normally-allocated pseudo) but in a reload scratch for
 *        us, so retail's pool starts one register earlier for the whole function.
 *        This is the ONE decision that produces the entire t0/t1 alternation.
 *   (ii) `lw a0,136(sp)` one slot late; (iii) `addiu s1,s1,16` one slot early;
 *   (iv) the loop tail's `sw <count>,68(sp)`: retail puts it in the back-edge `j`
 *        delay slot, ours emits it before the `j`.
 * A global $t0<->$t1 rename does NOT clean it (186 -> 70) because the pool
 * ALTERNATES phase between regions -- confirming this is pool ORDER, not a rotation.
 * ⇒ the next handle is (i) alone: get the head-block value into a real pseudo
 * ($v0) instead of a spill reload.  Register-use census ours-vs-oracle over the whole
 * function (scratch/regcensus): v0 222/225, t0 54/48, t1 46/49, every other register
 * IDENTICAL -- i.e. the census difference IS the output of the pick, not its input,
 * so "reshape which caller-saved regs the body consumes" has nothing to bite on.
 * RESIDUAL 186 (89 diff lines) -- structurally identical, three classes:
 *  (a) ~75 lines are a pure $t0<->$t1 alternation on RELOAD scratch registers for
 *      the spilled parms/locals (ours starts the spill pool at $t0/$t1 where retail
 *      starts at $v0/$t0).  gcc-2.8 reload picks spill registers via
 *      order_regs_for_reload = ascending hard_reg_n_uses, a whole-function property;
 *      no source lever reaches it.
 *      w42-a5 -dg RECEIPT (tools/rtl_dump.py cario.cpp -dg ->
 *      scratch/rtl/cario.i.greg): the dump literally prints `Spilling reg 8.` /
 *      `Spilling reg 9.` for this function -- $t0/$t1 ARE our reload spill pool,
 *      confirmed, not inferred.  29 allocnos are offered; the `Register
 *      dispositions` list omits 80 81 82 85 88 89 195 226 267 323 544 (eleven
 *      allocnos get NO hard reg and live in memory), and ~150 of the surviving
 *      pseudos are `in 2` ($v0).  That $v0 population is exactly why
 *      order_regs_for_reload never offers $v0 as a spill register for us while
 *      retail's build did: hard_reg_n_uses[$v0] is huge here.  Any fix has to
 *      REDUCE the number of pseudos homed in $v0 across the whole body -- a
 *      whole-function property, no local statement reshape touches it.
 *      collapse.py re-measured this wave: raw 186 -> 22 with {$t0,$t1} collapsed,
 *      -> 12 with {$v0,$v1,$t0,$t1} collapsed.
 *  (b) 3 one-insn scheduling slots (the CarIO_carPixMapCount/textureStartIndex
 *      block's reload order, the locateshapez a0/a1 arg-load order, the
 *      recolor_flag reload in the palIndex block).
 *  (c) the Plate2 arm's `li s0,1` sinking (see above).
 * w53-a4 re-gate + independent triage (184 diffs, count EXACT 491/491): the "no structural
 * defect left" reading is confirmed by two instruments the receipt above predates.
 * tools/chunkdiff.py reports **0 mismatched runs >= 6** -- there is no block-sized
 * divergence anywhere in 491 insns -- and tools/diffsrc.py spreads the residual over ~50
 * source statements with a MAXIMUM of 5 diff insns on any one of them (top: the two
 * `i == CarIO_licensePlate[carType][0]` guards 5/4, the palCopyNum copy 4, recolor_flag 3).
 * posdiff: first-use register order IDENTICAL to retail through all 17 registers, alpha-
 * renamed LCS 416/491.  A defect that is diffuse, count-exact, and register-order-identical
 * is the reload spill-pool identity named in (a), not a set of 50 statement-level misses --
 * do not open this function statement-by-statement; the only live route is reducing the
 * whole-body $v0 population (or the permuter). */
void CarIO_ReadInCarTextureData(char *shpfile,Car_tObj *carObj,int reload,int player)

{
  int i;
  int carType;
  int vx;
  int vy;
  int carPixMapCount;
  int recolor_flag;

  recolor_flag = 8;
  carType = (carObj->render).currentCarType;
  if ((reload & 1U) == 0) {
    if (R3DCar_InMenu == 0) {
      vx = (carObj->render).VRamX = CarIO_carVRamSlots[CarIO_carVRamCount][0];
      vy = (carObj->render).VRamY = CarIO_carVRamSlots[CarIO_carVRamCount][1];
      if (carType < 0x1c) {
        /* oracle: `andi v0,inside,1; beqz v0,<+3 arm>` -- the inside!=0 case is
         * the FALL-THROUGH, so it is the if-BODY (arm order was inverted). */
        if (((carObj->render).inside & 1U) != 0) {
          /* SYM block line 22: `index` REG $02($v0) -- the /3 quotient is a
           * NAMED local in retail, not an inline subexpression. */
          int index;

          index = CarIO_carVRamCount / 3;
          CarIO_carVRamCount = CarIO_carVRamCount + CarIO_carVRamAdd[index] * 3;
        }
        else {
          CarIO_carVRamCount = CarIO_carVRamCount + 3;
        }
      }
      else {
        CarIO_carVRamCount = CarIO_carVRamCount + 1;
      }
    }
    else {
      vx = (carObj->render).VRamX = CarIO_carVRamSlotsMenu[CarIO_carVRamCount][0];
      vy = (carObj->render).VRamY = CarIO_carVRamSlotsMenu[CarIO_carVRamCount][1];
      CarIO_carVRamCount = CarIO_carVRamCount + CarIO_carVRamAdd[CarIO_carVRamCount];
    }
  }
  else {
    vx = (carObj->render).VRamX;
    vy = (carObj->render).VRamY;
  }
  if ((reload & 0x10U) == 0) {
    carPixMapCount = CarIO_carPixMapCount;
    (carObj->render).textureStartIndex = CarIO_carPixMapCount;
  }
  else {
    carPixMapCount = (carObj->render).textureStartIndex;
  }
  /* MATCH (w62-a14, 184 -> 35): THE RELOAD SPILL-POOL IDENTITY IS SOURCE-REACHABLE.
   * The w41/w42/w53 receipts below priced the residual as "164 of 184 are which of
   * two interchangeable reload scratch registers gcc picked ... a whole-function
   * property, no source lever reaches it".  A single READ-ONLY FENCE OPERAND on the
   * memory-homed `carPixMapCount` (SYM AUTO 68(sp)) at the head-block join flips the
   * whole $t0/$t1 alternation: the extra reference makes the pool order match
   * retail's for the rest of the function.  MEASURED from the 184 basin -- fence on
   * carPixMapCount here 35 (kept), identity launder here 37, the same read-only
   * fence on the other memory-homed local `carType` 35 (same flip -- the dial is the
   * spilled-local REFERENCE, not the value), on `vx`/`vy`/`reload` (all register
   * locals) exactly 184 = inert, on `recolor_flag` 198, on `i` 230.  POSITION is a
   * hard dial: at `i = 0` 57, at `Texture_ResetPaletteSharing()` 74, at the
   * `Texture_palCopy` store 179.  NOT a scheduling barrier: a void fence
   * (`""`, `"i"(0)`, volatile, or a "memory" clobber) in the same slot is exactly
   * 184.  COST: +1 insn (492 vs retail's 491 -- the fence's operand is a `lw` of the
   * spilled slot), the only known price for -149 diffs; a second operand costs +2
   * more insns and undoes the flip (187 @494).
   * w63-a14 (still 19 @492 vs 491): THE 4th-DIAL r/m/g CONSTRAINT SWEEP, DONE.
   * 14C names the spill-pool ref dial's constraint letter as a 4th axis, so all three
   * were priced here from the 19 basin (the whole residual is now this fence's own
   * `lw t1,68(sp)` plus the register picks in the `reload & 0x10` head block):
   *     "r"(carPixMapCount)   19 @492   (kept)
   *     "g"(carPixMapCount)  186 @491   = EXACTLY the no-fence baseline -> "g" let gcc
   *                                       satisfy the operand from the register the
   *                                       value already sits in, so no memory ref, no
   *                                       hard_reg_n_uses bump, dial INERT
   *     "m"(carPixMapCount)  622 @499   (a real MEM operand reshapes the frame)
   *     "g"/"m" on carType   186 / 233
   *     "m" x2 / "m"+"m"     622 / 633
   * LAW CANDIDATE (catalog): on the spill-pool ref dial the constraint letter is NOT a
   * free choice -- only "r" buys the dial, because the dial IS the forced reload; "g"
   * is inert by construction and "m" changes the frame instead.  The +1 insn is
   * therefore STRUCTURAL to this instrument, not an artifact to be tuned away.
   * ALSO FALSIFIED (same basin): the fence moved INSIDE the two arms of the
   * `reload & 0x10` if/else (then-arm, else-arm, or both) is exactly 186 = inert,
   * because inside an arm the value is already live in a register -- only the JOIN
   * position forces the reload.  Both arms PLUS the join = 20 @493.  Position sweep
   * re-run from this basin (04Z): join 19, at the `textureOffsetV` block end 41, at
   * `i = 0` 41.  The join stays the unique optimum.
   * NEXT ANGLE (untried, named): make the fence's reload COINCIDE with a reload retail
   * already has -- retail's first real 0x44(sp) load is at .L800BC974
   * (`lw t1,0x44(sp)` feeding `sll s1,t1,4` in the Texture_ResetPaletteSharing jal
   * delay slot).  A fence placed so its `lw` merges with that one would buy the dial
   * at zero net insns; the position probe could not reach it because the anchor text
   * around Texture_ResetPaletteSharing is shared with the sibling functions.
   * w63-a14 / W63-A2 DEVICE CROSS-CHECK -- THE SPILL-POOL DIAL IS A **REF** DIAL, NOT A
   * **LIVE** DIAL (a boundary result for the new FOREIGN-OPERAND FENCE).  A2's device
   * `__asm__("" : : "r"(OTHER_LIVE_VALUE))` buys +1 REG_LIVE_LENGTH for every pseudo
   * live across it at ZERO emitted bytes.  Both halves reproduce exactly here:
   *   - ZERO-INSN CONFIRMED: adding 1 or 3 such fences beside the existing
   *     carPixMapCount fence keeps the count at 492 (operands vx / vy / player, all
   *     register-resident).  A non-register-resident operand does cost one
   *     (`shpfile` 493 @188) -- the receipt's "operand must be register-resident" gate.
   *   - AND DIFF-NEUTRAL: every zero-insn configuration measures EXACTLY 19, and
   *     REPLACING the memory-operand fence with a foreign-operand one measures 186 =
   *     the no-fence baseline.  So the live-length axis does not touch this residual
   *     at all; what flips order_regs_for_reload is the forced MEMORY REFERENCE
   *     (hard_reg_n_uses), which only the "r"-on-a-memory-homed-local form emits.
   * ⇒ report to the lab: the 14C spill-pool ref dial and the A2 live extender are
   * ORTHOGONAL instruments; do not substitute one for the other, and this fn is a
   * clean negative witness for the live axis.
   * ===== W71-A7 (2026-08-21): 19 STAYS @492/491.  The DEVICE-FORM axis (the one the
   * w63 "r"/"g"/"m" sweep left open -- volatile-vs-not) is now closed too, re-gated
   * from the 19 basin: the NON-volatile W69 identity launder
   * `__asm__("" : "=r"(carPixMapCount) : "0"(carPixMapCount))` = 21 (worse, and it does
   * not shed the +1 insn); a non-volatile launder on carType carrying "m"(carPixMapCount)
   * = 677 @504; the volatile fence with BOTH "r" and "m" on carPixMapCount = 623 @500
   * (the frame-reshape the w63 note predicts for any real MEM operand); "r" on
   * carPixMapCount PLUS "r" on carType = 188 @493.  So the landed form really is the
   * unique one, and its +1 `lw` is structural to the instrument.  The head-block arm
   * itself was also re-probed: chained assignment 169, statements swapped 169 -- the
   * spill-pool pick in that arm is NOT reachable by re-spelling the CSE.  Route unchanged
   * (reduce the whole-body $v0 population, or the permuter).
   * ===== W72-A15 (2026-08-22): 19 STAYS @492/491, and the residual now carries a
   * QUANTIFIED HARDNESS CERTIFICATE instead of a hypothesis.
   * THE FRAME-SLOT REFERENCE CENSUS (new instrument, one objdump + one .s scan; ours
   * vs oracle over ALL 33 stack slots this fn touches):
   *     off 16/20/24/28  10/6/6/6   == oracle      off 88   5 == 5
   *     off 32..60 (the 4 license_vx/vy pairs)  2 == 2 each   off 96..132  2 == 2 each
   *     off 64 (carType) 3 == 3     off 72 (recolor_flag) 9 == 9
   *     off 76/80/84 (palShare) 3 == 3            off 136  4 == 4
   *     off 140 (carObj ARG) 16 == 16             off 144 (reload) 8 == 8
   *     off 68 (carPixMapCount)  **8 vs 7**  <-- the ONLY divergence, and it is the
   *                                              fence's own `lw t1,68(sp)`.
   * => EVERY spilled value in this function is referenced exactly as often as retail
   * references it.  So the `order_regs_for_reload` divergence is NOT a frame-reference-
   * count question at all -- hard_reg_n_uses is dominated by the ~150 pseudos homed in
   * $v0 (the w42 -dg receipt), and the landed fence flips the pool as a SIDE EFFECT of
   * a reference retail does not have.  That is why no operand, position, constraint or
   * device form can shed the +1 insn: the instrument is buying the right answer with the
   * wrong evidence.  (Reusable: run this census before spending another wave on any
   * "spill-pool identity" -- if the profile already matches, the dial is elsewhere.)
   * ALSO: the residual is now CONFINED TO ONE BASIC BLOCK.  side_by_side shows the other
   * ~480 insns byte-identical; the whole 19 is the `reload & 0x10` head block, where
   * retail picks {value=$v0, carObj=$t0} in the then-arm and $t1 in the else-arm while we
   * pick {$t0,$t1} and $t0.
   * FALSIFIED THIS WAVE (all re-gated from the 19 basin, none reach below 19):
   *   - HEAD-BLOCK SPELLINGS: a named `int n` temp for the CSE'd value 19 (inert, gcc
   *     merges it) . n + field-store first 169 . n + identity launder 19 . n + read-only
   *     fence 169 . n + a `do{...}while(0)` depth wrapper 20 @493 / whole-arm wrapper
   *     194 @487 . `n | 0` re-mask 19 . reading the local back for the field store 19 .
   *     the field store first off the GLOBAL 169 . a join-form `int n` assigned in both
   *     arms with one store after 144 @493 .
   *   - ARM SWAP (`if ((reload & 0x10U) != 0)` with the bodies exchanged): 22 @**491**
   *     -- COUNT-EXACT, i.e. the fence's reload merges away -- but 3 diffs worse; the
   *     same trade appears with a two-operand `"r"(reload),"r"(carPixMapCount)` fence
   *     (24 @491).  Recorded because a future count-exactness bar may prefer them.
   *   - FENCE OPERAND (the w63 sweep extended to every local): `reload` 186 @491 (inert
   *     -- it IS spilled, which refutes the w62 "register local" reading of why it is
   *     inert; the real reason is that its slot is already referenced enough), `player`
   *     186, `recolor_flag` 188 @491, `i` 232, `carType` 19, `shpfile` 19 -- so THREE
   *     different memory-homed operands all buy exactly the same flip, confirming the
   *     dial is "one more reference to any under-referenced spilled slot".
   *   - HARD-REG CLOBBERS on the fence (the 20B preference-killer): "$8"($t0) 225,
   *     "$9"($t1) 121, "$3"($v1) 19 (inert); clobbers placed inside the then-arm 224/236.
   *     Consistent with the 20B limit -- reload1.c puts every asm-used hard reg into
   *     bad_spill_regs FUNCTION-WIDE, and $t0/$t1 ARE retail's spill pool here.
   *   - FENCE POSITION re-swept including the one slot the w63 note named as untried
   *     (the `.L800BC974` join = right after the `R3DCar_InMenu` recolor block, where
   *     retail's own `lw t1,0x44(sp)` giv-init sits): there alone 181 @492, there PLUS
   *     the head-block fence 28 @493, inside the recolor block 48 @**491**, before the
   *     `Texture_palCopy` store 181 / +keep 28 @493.  The merge the w63 note hoped for
   *     does not happen -- at that point the pool order is already decided.
   * => CLOSED at the source level.  The only live routes remain (a) the whole-body $v0
   * population (a global property; instrument = the -dg `Register dispositions` list),
   * or (b) a PER_FN_TEXT_MOVES row for the eight head-block insns -- orchestrator
   * wiring, and cheap here because the block is 8 insns and everything else matches.
   * ===== W74-A13 (2026-08-23): 19 STAYS @492/491.  ROUTE (b) IS REFUTED AND THE
   * MECHANISM IS NOW A VALIDATED MODEL INSTEAD OF A HYPOTHESIS.
   * (1) TEXT_MOVES CANNOT EXPRESS THIS RESIDUAL -- the order is ALREADY retail's.
   *     side_by_side over the head block, ours | retail, insn for insn:
   *        lw t0,0(gp)     | lw v0,0(gp)        lw t1,140(sp) | lw t0,140(sp)
   *        sw t0,68(sp)    | sw v0,68(sp)       j T           | j T
   *        sw t0,2116(t1)  | sw v0,2116(t0)     [else arm] t0 | t1 (x3)
   *     Same opcodes, same operands, SAME SEQUENCE -- only the REGISTER NAMES differ
   *     (+ the fence's own `lw t1,68(sp)`).  The line-move engine moves whole lines; no
   *     permutation of a stream containing `lw t0,0(gp)` can ever produce one
   *     containing `lw v0,0(gp)`.  LAW: read the sbs before specifying a TEXT_MOVES
   *     row set -- "count-exact + N diffs" is NOT sufficient; the diff must be a
   *     PERMUTATION (same multiset of lines).  For CreateLicense above it is; here it
   *     is not, and w72 named this route without running that check.
   * (2) THE RESIDUAL IS A RELOAD SPILL-POOL *MEMBERSHIP* FACT, AND THE ROUND-ROBIN
   *     MODEL IS NOW VALIDATED BY PREDICTION.  NEW ZERO-INSN INSTRUMENT: a bare
   *     hard-reg clobber with an IMMEDIATE operand, `__asm__("" : : "i"(0) : "$N")`,
   *     emits NOTHING (count stays 491) yet moves the whole function's reload scratch
   *     assignment.  Fence-free sweep at the head-block join, all @491:
   *        $2 v0 186 = baseline (inert)   $3 v1 186   $8 t0 **140**   $9 t1 206
   *        $10 t2 / $11 t3 / $12 t4 / $13 t5 / $14 t6 / $15 t7 / $24 t8 / $25 t9,
   *        and $4-$7 a0-a3: all exactly 186 = inert.
   *     ONLY $t0 and $t1 are live -- i.e. exactly our spill pool, which is therefore
   *     PROVEN to be the 2-register set {$t0,$t1}.  Clobbering $t0 shifts it to
   *     {$t1,$t2} and the ENTIRE function rotates one step (predicted, then confirmed
   *     insn by insn); clobbering $t0+$t1 shifts it to {$t2,$t3} (234 @491).  Retail
   *     allocates $v0 as the head-block value's scratch while using $t0/$t1 identically
   *     everywhere else, so RETAIL'S POOL CONTAINS $v0 AND OURS DOES NOT.
   * (3) MUTUAL-EXCLUSION CERTIFICATE (the 20B-limit applied to this fn): the ONLY
   *     zero-insn device that touches the pool is the hard-reg clobber, and reload1.c
   *     puts every asm-used hard reg into bad_spill_regs FUNCTION-WIDE -- so a clobber
   *     can only REMOVE a register from the pool, never ADD one.  Naming $v0 in an asm
   *     is exactly the thing that forbids $v0 from being a spill reg ("$2" measures
   *     186 = inert for precisely that reason).  => NO zero-insn device can produce
   *     retail's pool; any device that buys the resync must emit a reference, which
   *     costs the +1 insn.  That is the landed fence, and it is now PROVEN minimal
   *     within the device family rather than merely un-falsified.
   *     Corollary for the lab: the fence does NOT fix the pool -- it CONSUMES one extra
   *     pool slot at the join, which re-syncs the round-robin cursor with retail's
   *     3-register rotation for the remaining ~380 insns.  That is the precise sense in
   *     which it "buys the right answer with the wrong evidence" (w72 frame-slot census).
   * ALSO FALSIFIED THIS WAVE (all count-checked, none below 19):
   *   - r-fence PLUS a separate zero-insn clobber (a different position from w72's
   *     clobber-on-the-fence sweep): $2/$3/$10/$11/$12/$24 all 19 @492 (inert),
   *     $8 225, $9 121.
   *   - the w72 ARM-SWAP basin re-priced with the new dial: swap+fence 22 @**491**
   *     (count-exact, reproduced), swap+no-fence 189 @490 (one SHORT), and every
   *     swap x clobber cell 22/124/137/189/209/222 -- nothing under 22.
   *   - PER-TU FLAG IDENTITY (diagnostic, whole-TU): no_schedule_insns 265 @494,
   *     no_schedule_insns2 141 @506, no_split_addresses 465 @524, no_strength_reduce
   *     689 @496, g_value 4 221 @490, g_value 0 342 @501.  The wired -G8 + default
   *     flag set is the optimum; no flag axis reaches the pool.
   * (4) RTL RECEIPT (tools/rtl_dump.py -dl): `carPixMapCount` is pseudo **88** and the
   *     head block is `(set (reg/v:SI 88) (mem (symbol_ref "CarIO_carPixMapCount")))`
   *     followed by `(set (mem (plus (reg 81) 2116)) (reg 88))` -- there is NO separate
   *     value temp, the variable pseudo IS the value, and 88 is in the w42 -dg list of
   *     11 allocnos that get NO hard register.  So this is not a "make a temp win $v0"
   *     problem either; it is the pool.
   * => The live route is now singular and precisely stated: get $v0 into
   * order_regs_for_reload's chosen spill set, i.e. lower hard_reg_n_uses[$v0] below
   * hard_reg_n_uses[$t1] for the whole body.  That is a global property of the ~150
   * $v0-homed pseudos and is NOT reachable from this function's statements, from any
   * fence/clobber/launder form, or from any per-TU flag on the board.  Do NOT re-open
   * the head-block spellings, the fence operand/constraint/position/device axes, the
   * arm swap, or a TEXT_MOVES row: all are closed with receipts.
   * ===== W75-A11 (2026-08-23): 19 STAYS @492/491, but the W74-A13 CONCLUSION IS
   * REFUTED -- "retail's spill pool contains $v0" is IMPOSSIBLE, and the live
   * route reverts to the w41 reading (i) with a mechanism behind it.
   * (1) THE REFUTATION, from reload1.c order_regs_for_reload (:3840) + a register
   *     census of the oracle.  potential_reload_regs run[1] is
   *     "hard_reg_n_uses == 0 AND call_used, ASCENDING regno", and run[3] (uses
   *     != 0, sorted by increasing uses) comes AFTER every zero-use register.
   *     Oracle register census (asm/nonmatchings/main/<this fn>.s):
   *         v0 184 | v1 83 | t0 46 | t1 45 | t2..t9 **0** | a0 31 a1 27 a2 12 a3 11
   *     So retail's run[1] contains $t2..$t9 (eight registers with zero uses).
   *     For $v0 to be a spill register it would have to be in run[1] as well,
   *     i.e. NO pseudo allocated to $v0 anywhere -- yet retail computes real
   *     values into $v0 with no spill store around them (`andi v0,t1,16; bnez
   *     v0`, `lhu v0,2240(t1)`, `sll v0,v1,16` ...), which is an ALLOCATED
   *     pseudo, not a reload scratch (an unallocated pseudo's DEF must be
   *     followed by a store to its home; there is none).  And even if it were,
   *     $v0=2 would be picked BEFORE $t0=8 ascending, so the head-block pair
   *     would be ($v0,$v1)-flavoured, not ($v0,$t0).  => retail's pool is
   *     {$t0,$t1} exactly like ours, and `lw v0,0(gp)` in the head block is an
   *     ALLOCATED PSEUDO, not a spill reload.
   * (2) WHAT THAT MEANS (and it makes the fence's behaviour finally coherent):
   *     the head block consumes TWO pool slots for us ($t0 for the value,
   *     $t1 for the carObj ARG reload) but only ONE for retail ($t0 for carObj;
   *     the value lives in an allocated pseudo $v0).  ONE extra round-robin step
   *     at insn ~105 is precisely what de-phases allocate_reload_reg's cursor
   *     (`i = (i+1) % n_spills`, reload1.c:5091) for the remaining ~380 insns --
   *     and the landed r-fence re-phases it by consuming one MORE slot at the
   *     join.  That is the mechanism behind w74's "buys the right answer with
   *     the wrong evidence", stated causally.
   * (3) THE LIVE ROUTE IS THEREFORE NOT "reduce the whole-body $v0 population"
   *     (a global property nobody can move) BUT the w41 reading (i): make the
   *     head-block value an ALLOCATED PSEUDO distinct from the memory-homed
   *     `carPixMapCount` (pseudo 88).  Retail's RTL must be
   *       (set (reg T) (mem gprel)) ; (set (reg 88) (reg T)) ; (set (mem field) (reg T))
   *     with T in $v0 and 88 memory-homed, so `(set 88 T)` prints as
   *     `sw v0,68(sp)`.  Ours has NO T -- rtl_dump -dl shows
   *     `(set (reg/v:SI 88) (mem (symbol_ref ...)))` directly.  If T is created,
   *     the fence should also become unnecessary (the cursor never de-phases),
   *     which would shed the +1 insn as well => 491 count-exact.
   * (4) FALSIFIED THIS WAVE (real gate runs, from the 19 basin):
   *     - MEMORY-RESIDENT-FROM-THE-START: `(void)&carPixMapCount;` in place of
   *       the fence (make the local addressable so every access is a MEM and the
   *       value necessarily gets its own temp) = **466 @499** -- put_var_into_stack
   *       reshapes the whole frame.  Dead end; the temp must come from the
   *       expression, not from the variable's storage class.
   *     - PER-FN CC1 FLAG AXIS (new; instrument scratchpad/w75/vprobe_flag.py, a
   *       generic per-FUNCTION flag splice on build.py's _apply_fn_splice):
   *       -fno-caller-saves 19 @492, -fno-thread-jumps 19, -fno-peephole 19,
   *       -fno-function-cse 19 (all INERT); -fno-cse-follow-jumps 27 @496,
   *       -fno-cse-skip-blocks 32 @497, -fno-rerun-cse-after-loop 33 @498,
   *       -fno-force-mem 41 @492, -fno-expensive-optimizations 87 @492.
   *       Nothing under 19; the flag axis is CLOSED (this complements the w74
   *       per-TU flag row, which covered a different six).
   *     - NAMED TEMP re-confirmed inert (19 @492), AND the merger is NOT
   *       local-alloc.c's optimize_reg_copy_1/2: with `int n = CarIO_carPixMapCount;
   *       carPixMapCount = n; field = n;` PLUS per-fn -fno-expensive-optimizations
   *       (which disables BOTH copy optimizers) the head block still emits
   *       `lw t0,0(gp)` (87 @492 overall).  T is collapsed into pseudo 88
   *       EARLIER than local-alloc -- at expand/cse -- so any escape has to be
   *       a tree-level one.
   *     - FIELD RE-READ form (`field = CarIO_carPixMapCount; carPixMapCount =
   *       field;` in the then-arm -- semantically identical, and the one shape
   *       that structurally MUST create a temp): 169 @492.  It reverses the two
   *       stores, so reorg steals the wrong one into the `j` delay slot.
   * NEXT NAMED ANGLE (unwalked, and now the ONLY one): a head-block spelling in
   * which the loaded value and the memory-homed local have OVERLAPPING live
   * ranges (catalog 22C-7) so cse/copy-prop cannot collapse T into pseudo 88 --
   * every previously tried `int n` form let them stay sequential, which is
   * exactly the condition 22C-7 says keeps them one qty. */
  __asm__("" : : "r"(carPixMapCount));
  if ((reload & 8U) != 0) {
    if (((carObj->render).inside & 1U) != 0) {
      int index;

      index = vx - 0x200;
      if (R3DCar_InMenu == 0) {
        index = vx - 0x280;
      }
      /* the `>> 6` is its OWN statement on the named local: the oracle emits the
       * `sra v1,v1,6` at the two arms' merge point, BEFORE the carVRamOffset base
       * is materialized (folded into the subscript it lands after the lui/addiu). */
      index = index >> 6;
      vx = vx + CarIO_carVRamOffset[index];
    }
    (carObj->render).textureOffsetU = (short)((vx & 0x3f) << 2);
    (carObj->render).textureOffsetV = (u_short)vy & 0xff;
  }
  i = 0;
  if (R3DCar_InMenu == 0) {
    /* oracle: `lw t1,72(sp); ori t1,t1,0x10; sw t1,72(sp)` -- an OR into the
     * already-stored 8, NOT a fresh `recolor_flag = 0x18` store. */
    recolor_flag = recolor_flag | 0x10;
  }
  Texture_palCopy = (carObj->render).palCopy;
  Texture_ResetPaletteSharing();
  /* MATCH (w62-a14, 35 -> 19): the loop-tail COMMA ORDER.  Both builds emit the
   * same two spilled-giv increments (68(sp) += 1 = carPixMapCount, 88(sp) += 2);
   * retail issues carPixMapCount's load/add/store FIRST, so the comma operands go
   * in that order.  Measured: swapped 19 (kept), original 35, moving the increment
   * into the body 47 @486 (drops 5 insns). */
  for (; i < 0x33; carPixMapCount = carPixMapCount + 1, i = i + 1) {
    shapetbl *shape;
    int palShare;
    int palette;

    /* MATCH (w50-a6, 186 -> 184): the sibling UpdateCarTextureData's flag-store lever --
     * writing `palette = 1;` AFTER the locateshapez call lets dbr use the flag store as
     * the `jal`'s delay-slot filler instead of emitting it ahead of the arg setup.  It
     * transfers only partially here (the sibling went 7 -> PASS); the comma-order swap
     * that cracked the sibling's tail is NEGATIVE on this fn (188), so the two loops'
     * residuals are NOT the same cluster despite the identical source shape. */
    shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].pal);
    palette = 1;
    palShare = CarIO_textureName[i].palShare;
    if ((shape == (shapetbl *)0x0) && (palShare == 0)) {
      palette = 0;
      shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].tex);
    }
    if (i == 0x14) {
      recolor_flag = 0;
    }
    if (shape != (shapetbl *)0x0) {
      int license;

      license = 0;
      if (recolor_flag != 0) {
        (carObj->render).palCopyNum[i] = (short)Texture_palNum;
      }
      if (carType < 0x16) {
        if (i == CarIO_licensePlate[carType][0]) {
          int license_vx;
          int license_vy;

          license_vx = vx + CarIO_licensePlate[carType][1];
          license_vy = vy + CarIO_licensePlate[carType][2];
          /* `license = 1` is set BEFORE the two calls (the flag-first spelling):
           * that is what makes the pseudo CALL-CROSSING, so gcc must give it a
           * callee-saved register -- retail's `license` REG $10($s0) per the SYM.
           * With it set after the calls the flag is caller-saved ($a0) and $s0
           * stays free INSIDE the loop, which lets `cx` reuse $s0; that single
           * reuse shifts palette/cx/cy/vx/vy one register each and hands $fp to
           * carObj instead of spilling it to its ARG home 140($sp).  gcc still
           * SINKS the constant materialization past the calls here (the `li s0,1`
           * lands next to the `flag = 1` store exactly as the oracle does). */
          license = 1;
          CarIO_LicenseCheck(reload,&license_vx,&license_vy,carObj,0);
          Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate1[player],recolor_flag,license_vx,
                     license_vy,-1,-1,&CarIO_carPixMap[carPixMapCount]);
          CarIO_carPixMap[carPixMapCount].flag = 1;
        }
        else if (i == CarIO_licensePlate[carType][3]) {
          int license_vx;
          int license_vy;

          license_vx = vx + CarIO_licensePlate[carType][4];
          license_vy = vy + CarIO_licensePlate[carType][5];
          CarIO_LicenseCheck(reload,&license_vx,&license_vy,carObj,1);
          Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate2[player],recolor_flag,license_vx,
                     license_vy,-1,-1,&CarIO_carPixMap[carPixMapCount]);
          license = 1;
          CarIO_carPixMap[carPixMapCount].flag = 2;
        }
      }
      if (license == 0) {
        Texture_LoadPmx((char *)0x0,(char *)shape,recolor_flag,vx,vy,-1,-1,
                   &CarIO_carPixMap[carPixMapCount]);
      }
      if (i == 0x20) {
        ChangeTPage(&CarIO_carPixMap[carPixMapCount].tpage,2);
      }
      CarIO_carPixMap[carPixMapCount].flag = CarIO_carPixMap[carPixMapCount].flag | 0x80;
    }
    if (palette != 0) {
      int palIndex;

      palIndex = carPixMapCount;
      if (palShare != 0) {
        palIndex = palShare + -1;
        if (recolor_flag != 0) {
          (carObj->render).palCopyNum[i] = (carObj->render).palCopyNum[palIndex];
        }
        palIndex = palIndex + (carObj->render).textureStartIndex;
      }
      shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].tex);
      if (shape != (shapetbl *)0x0) {
        int license;
        u_short clut;
        int cx;
        int cy;

        license = 0;
        clut = CarIO_carPixMap[palIndex].clut;
        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);
        if (carType < 0x16) {
          if (i == CarIO_licensePlate[carType][0]) {
            int license_vx;
            int license_vy;

            license_vx = vx + CarIO_licensePlate[carType][1];
            license_vy = vy + CarIO_licensePlate[carType][2];
            license = 1;      /* flag-first: keeps `license` call-crossing -> $s0 */
            CarIO_LicenseCheck(reload,&license_vx,&license_vy,carObj,0);
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate1[player],0x20,license_vx,license_vy,
                       cx,cy,&CarIO_carPixMap[carPixMapCount]);
            CarIO_carPixMap[carPixMapCount].flag = 1;
          }
          else if (i == CarIO_licensePlate[carType][3]) {
            int license_vx;
            int license_vy;

            license_vx = vx + CarIO_licensePlate[carType][4];
            license_vy = vy + CarIO_licensePlate[carType][5];
            CarIO_LicenseCheck(reload,&license_vx,&license_vy,carObj,1);
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate2[player],0x20,license_vx,license_vy,
                       cx,cy,&CarIO_carPixMap[carPixMapCount]);
            license = 1;
            CarIO_carPixMap[carPixMapCount].flag = 2;
          }
        }
        if (license == 0) {
          Texture_LoadPmx((char *)0x0,(char *)shape,0x20,vx,vy,cx,cy,
                     &CarIO_carPixMap[carPixMapCount]);
        }
        if (i == 0x20) {
          ChangeTPage(&CarIO_carPixMap[carPixMapCount].tpage,2);
        }
        if (palShare == 0) {
          CarIO_carPixMap[carPixMapCount].flag = CarIO_carPixMap[carPixMapCount].flag | 0x80;
        }
      }
    }
  }
  if ((reload & 0x80U) != 0) {
    CarIO_carPixMapCount = carPixMapCount;
  }
  return;
}

/* ---- CarIO_UpdateCarTextureData__FPcP8Car_tObji  [CARIO.CPP:718-849] SLD-VERIFIED ---- */
void CarIO_UpdateCarTextureData(char *shpfile,Car_tObj *carObj,int player)

{
  /* SYM @0x800bceb0 (fsize 104, mask $c0ff0000).  FULL rule-8 rewrite (w39-a5):
   *   fn scope    -> i REG $16($s6), carType/vx/vy/carPixMapCount AUTO
   *                  (32/36/40/44(sp)), recolor_flag REG $1e($fp)
   *   loop body   -> shape REG $11($s1), palShare AUTO 48(sp),
   *                  palette AUTO 52(sp)
   *   arm blocks  -> license REG $10($s0), clut REG $03($v1),
   *                  cx REG $13($s3), cy REG $14($s4)
   *   palette blk -> palIndex REG $10($s0)
   * There is NO pointer local in the SYM: the retail walkers (s5 = &carPixMap
   * element, s7 = &CarIO_textureName[i], 60(sp) = &carObj->..palCopyNum[i])
   * are compiler GIVs, so every access is written in INDEX form (catalog:
   * "SYM has only i => the pointers are givs").  player (REGPARM $10) is only
   * ever used as CarIO_PlateN[player], so gcc hoists player*4 to 56(sp).
 * 459 -> 97 (rule-8 rewrite) -> 27 (palShare ref-count lever, below) -> 25 (w42-a5).
 * (b) IS SOLVED (w42-a5): the `addu a1,v0,s5` / oracle `addu a1,s5,v0` operand order
 * was NOT an unreachable RTL canonicalization -- writing the pmx address with the
 * SCALED INDEX TERM FIRST in an explicit int-cast
 * (`(Draw_tPixMap *)(carPixMapCount * 16 + (int)CarIO_carPixMap)`, catalog 5.0c
 * commutative-addu-operand-order) reproduces it, 27 -> 25, no cascade.
 * RESIDUAL 25 diffs (ours 301 / oracle 298 = +3), ONE cluster, scheduling:
 *  (a) the spilled `&carObj->..palCopyNum[i]` giv (60(sp)).  Raw oracle
 *      @0x800BCF74: the loop TOP is the `slti` and `sw $t0,0x3C($sp)` sits in the
 *      guard `beqz`'s DELAY SLOT, i.e. the giv's memory copy is written once per
 *      iteration INSIDE the loop, and the tail only does `j; addiu $t0,$t0,2`
 *      (no store).  Ours writes 60(sp) twice -- once in the preheader (`lw
 *      t0,108(sp); nop; sw t0,60(sp)`, +1 nop +1 store) and once at the loop tail
 *      -- which is also why our `jal locateshapez` slot is a nop (dbr scans back
 *      from the branch and stops at the `slti` that sets its condition reg, so it
 *      can never reach our preheader store).  = the whole +3.  Reload/dbr
 *      placement of a spilled giv; no source spelling reached it this wave.
 * Per-TU flag probes on cario.cpp (w39-a5, all measured over ALL 11 fns):
 *   no_split_addresses 459->402/Update, ReadIn 344->512, LicenseCheck PASS->11  WORSE
 *   no_schedule_insns  Update->265 but ReadIn 344->603                          WORSE
 *   no_schedule_insns2 Update->139 but breaks 6 currently-PASSing fns           WORSE
 *   no_strength_reduce Update->379, CopyToShape 51->55                          WORSE
 * => cario.obj is a STOCK-FLAG object (only the proven g_value:8 stays). */
  int i;
  int carType;
  int vx;
  int vy;
  int carPixMapCount;
  int recolor_flag;

  carPixMapCount = (carObj->render).textureStartIndex;
  carType = (int)(carObj->render).currentCarType;
  vx = (int)(carObj->render).VRamX;
  vy = (int)(carObj->render).VRamY;
  recolor_flag = 8;
  if (R3DCar_InMenu == 0) {
    recolor_flag = 0x18;
  }
  Texture_palCopy = (carObj->render).palCopy;
  Texture_ResetPaletteSharing();
  /* MATCH (w50-a6, 25 -> 7, ours 301 -> 299 vs oracle 298): the two spilled counters'
   * TAIL ORDER is set by the comma-expression order.  Retail updates carPixMapCount
   * (44(sp)) FIRST and the palCopyNum giv (60(sp)) last, with `addiu t0,t0,2` in the
   * back-`j` delay slot; our `i` -first order emitted the 60(sp) group first and left the
   * 44(sp) store as the `j` filler.  Swapping the two comma operands is semantically
   * identical (neither reads the other) and also lets dbr fill the guard `beqz` slot,
   * which is what removed the two nops.  (Falsified from this basin: an explicit while
   * form with both bumps at the bottom 372 @290; a `(short *)palCopyNum` pointer view 25.) */
  for (i = 0; i < 0x33; carPixMapCount = carPixMapCount + 1, i = i + 1) {
    shapetbl *shape;
    int palShare;
    int palette;

    /* MATCH (w50-a6, 7 -> PASS 298/298): retail sets up locateshapez's two args BEFORE
     * materializing the `palette` flag and fills the `jal`'s delay slot with the
     * `sw t0,52(sp)` flag store.  Written before the call, the store is already emitted
     * when dbr scans back and the slot gets a nop; written AFTER the call statement it
     * becomes the slot filler.  (Any of the three post-call positions -- after the call,
     * after the palShare read, immediately before the guard -- gates PASS.) */
    shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].pal);
    palette = 1;
    palShare = CarIO_textureName[i].palShare;
    if ((shape == (shapetbl *)0x0) && (palShare == 0)) {
      palette = 0;
      shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].tex);
    }
    if (i == 0x14) {
      recolor_flag = 0;
    }
    if (shape != (shapetbl *)0x0) {
      Draw_tPixMap *pmx; /* SYM-CODEGEN-CARRIER: pmx -- holds the index-term-first pixmap address */

      /* MATCH: index term FIRST in the address add -- the oracle emits
       * `addu a1,s5,v0` (scaled index, then the gp-loaded base); the natural
       * `&CarIO_carPixMap[carPixMapCount]` gives `addu a1,v0,s5` (base first).
       * Catalog 5.0c commutative-addu-operand-order. */
      pmx = (Draw_tPixMap *)(carPixMapCount * 16 + (int)CarIO_carPixMap);
      if ((pmx->flag & 0x80) == 0) continue;
      {
        int license;
        u_short clut;
        int cx;
        int cy;

        license = 0;
        clut = pmx->clut;
        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);
        if (recolor_flag != 0) {
          Texture_palNum = (int)(carObj->render).palCopyNum[i];
        }
        if (carType < 0x16) {
          if (i == CarIO_licensePlate[carType][0]) {
            license = 1;
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate1[player],recolor_flag,
                       vx + CarIO_licensePlate[carType][1],
                       vy + CarIO_licensePlate[carType][2],cx,cy,pmx);
          }
          else if (i == CarIO_licensePlate[carType][3]) {
            license = 1;
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate2[player],recolor_flag,
                       vx + CarIO_licensePlate[carType][4],
                       vy + CarIO_licensePlate[carType][5],cx,cy,pmx);
          }
        }
        if (license == 0) {
          Texture_LoadPmx((char *)0x0,(char *)shape,recolor_flag,vx,vy,cx,cy,
                     &CarIO_carPixMap[carPixMapCount]);
        }
        if (i == 0x20) {
          ChangeTPage(&CarIO_carPixMap[carPixMapCount].tpage,2);
        }
        CarIO_carPixMap[carPixMapCount].flag = CarIO_carPixMap[carPixMapCount].flag | 0x80;
      }
    }
    if (palette != 0) {
      int palIndex;

      palIndex = carPixMapCount;
      if (palShare != 0) {
        /* the oracle computes `palShare - 1` ONCE into palIndex (delay slot of
         * the recolor_flag guard) and then ADDS textureStartIndex to it -- so
         * palShare is referenced 5x, not 6x.  That one ref is load-bearing:
         * -dl gives palShare 12 refs / 170 insns (prio 3*12/170 = .212) vs
         * recolor_flag 14 / 211 (.199), which is exactly why OUR build gave
         * palShare $s7 and spilled recolor_flag.  At 10 refs palShare drops to
         * .176 and the pair swaps to the retail assignment. */
        palIndex = palShare + -1;
        if (recolor_flag != 0) {
          (carObj->render).palCopyNum[i] = (carObj->render).palCopyNum[palIndex];
        }
        palIndex = palIndex + (carObj->render).textureStartIndex;
      }
      shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].tex);
      if (shape != (shapetbl *)0x0) {
        int license;
        u_short clut;
        int cx;
        int cy;

        license = 0;
        clut = CarIO_carPixMap[palIndex].clut;
        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);
        if (carType < 0x16) {
          if (i == CarIO_licensePlate[carType][0]) {
            license = 1;
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate1[player],0x20,
                       vx + CarIO_licensePlate[carType][1],
                       vy + CarIO_licensePlate[carType][2],cx,cy,
                       &CarIO_carPixMap[carPixMapCount]);
          }
          else if (i == CarIO_licensePlate[carType][3]) {
            license = 1;
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate2[player],0x20,
                       vx + CarIO_licensePlate[carType][4],
                       vy + CarIO_licensePlate[carType][5],cx,cy,
                       &CarIO_carPixMap[carPixMapCount]);
          }
        }
        if (license == 0) {
          Texture_LoadPmx((char *)0x0,(char *)shape,0x20,vx,vy,cx,cy,
                     &CarIO_carPixMap[carPixMapCount]);
        }
        if (i == 0x20) {
          ChangeTPage(&CarIO_carPixMap[carPixMapCount].tpage,2);
        }
        if (palShare == 0) {
          CarIO_carPixMap[carPixMapCount].flag = CarIO_carPixMap[carPixMapCount].flag | 0x80;
        }
      }
    }
  }
  return;
}

/* ---- CarIO_ReleaseCarCluts__FP8Car_tObj  [CARIO.CPP:856-871] SLD-VERIFIED ---- */
void CarIO_ReleaseCarCluts(Car_tObj *carObj)

{
  /* SYM @0x800bd358: fsize 32, mask $80030000 (ra,s1,s0) -- EXACTLY two REG
   * locals, i=$10($s0) and carPixMapCount=$11($s1).  The old 26-local Ghidra
   * soup (incl. a `char letter[5]`) inflated the frame 32->40 and swapped the
   * two saved regs. */
  int i;
  int carPixMapCount;

  carPixMapCount = (carObj->render).textureStartIndex;
  i = 0;
  do {
    if ((CarIO_carPixMap[carPixMapCount].flag & 0x80) != 0) {
      CarIO_carPixMap[carPixMapCount].flag = 0;
      Texture_MenuReleaseClutId(CarIO_carPixMap[carPixMapCount].clut);
    }
    i = i + 1;
    carPixMapCount = carPixMapCount + 1;
  } while (i < 0x33);
  return;
}

/* end of cario.cpp */
