/* game/psx/cario.cpp -- RECONSTRUCTED (NFS4 PSX car texture/CLUT I/O; C++ TU)
 *   11 fns: StartUp/CleanUp/ReStart, Copy[From/To]Shape, CreateLicense/CleanUpLicense/LicenseCheck,
 *   ReadIn/UpdateCarTextureData, ReleaseCarCluts. GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "cario_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
Draw_tPixMap *CarIO_carPixMap;
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


/* ---- CarIO_StartUp__Fv  [CARIO.CPP:208-229] SLD-VERIFIED ---- */
void CarIO_StartUp(void)

{
  Draw_tPixMap *pDVar1;
  int i;
  int iVar2;
  
  if (CarIO_carPixMap == (Draw_tPixMap *)0x0) {
    CarIO_carPixMap = reservememadr("carPixMap",0x2640,0);
  }
  iVar2 = 0x263;
  pDVar1 = CarIO_carPixMap + 0x263;
  do {
    pDVar1->flag = 0;
    iVar2 = iVar2 + -1;
    pDVar1 = pDVar1 + -1;
  } while (-1 < iVar2);
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

/* ---- CarIO_ReStart__Fv  [CARIO.CPP:244-253] SLD-VERIFIED ---- */
void CarIO_ReStart(void)

{
  Draw_tPixMap *pDVar1;
  int i;
  int iVar2;
  
  iVar2 = 0x263;
  pDVar1 = CarIO_carPixMap + 0x263;
  do {
    pDVar1->flag = 0;
    iVar2 = iVar2 + -1;
    pDVar1 = pDVar1 + -1;
  } while (-1 < iVar2);
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
   * placement + cross-jump depth); STRONG floor at the source level. */
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
        int n0;
        int n1;
        int n2;
        int n3;

        pixel3 = source[i];
        n1 = (pixel3 & 0xf0) << 4;
        n2 = (pixel3 & 0xf00) >> 4;
        n0 = (pixel3 & 0xf) << 0xc;
        n3 = pixel3 >> 0xc;
        *dest++ = (short)(n0 | n1 | n2 | n3);
        i = i - 1;
      }
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
 * Next handle is a -dg allocno dump on this body, not more statement order. */
void CarIO_CreateLicense(char *text,int carType,int player)

{
  shapetbl *shape;
  shapetbl *clutptr;
  shapetbl *clutPlate1;
  shapetbl *clutPlate2;
  short *thePlate;
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
    do {
      int hdr;

      hdr = ((int *)shape)[i];
      *(int *)((char *)(CarIO_Plate1[player]) + i * 4) = hdr;
      *(int *)((char *)(CarIO_Plate2[player]) + i * 4) = hdr;
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
    *(u_int *)(CarIO_Plate1[player]) = *(u_char *)(CarIO_Plate1[player]) | 0x11800;
    *(u_int *)(CarIO_Plate2[player]) = *(u_char *)(CarIO_Plate2[player]) | 0x11800;
    CarIO_Plate2[player]->width = 0x18;
    CarIO_Plate1[player]->width = 0x18;
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
          letter[0] = ascii;
          letter[1] = '\0';
          strcat(letter,"   ");
          CarIO_CopyFromShape((short *)((int)locateshapez(R3DCar_LicenseShapeFile,letter) + 0x10),thePlate,7,0xc,start,5);
        }
        start = start + 6;
      }
    }
    if ((R3DCar_InMenu == 0) && (GameSetup_gData.mirrorTrack != 0)) {
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
  shapetbl **ppPlate1;
  shapetbl *psVar1;

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
  int sVar1;
  int sVar2;
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
 *  (b) 3 one-insn scheduling slots (the CarIO_carPixMapCount/textureStartIndex
 *      block's reload order, the locateshapez a0/a1 arg-load order, the
 *      recolor_flag reload in the palIndex block).
 *  (c) the Plate2 arm's `li s0,1` sinking (see above). */
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
  Texture_palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
  Texture_ResetPaletteSharing();
  for (; i < 0x33; i = i + 1, carPixMapCount = carPixMapCount + 1) {
    shapetbl *shape;
    int palShare;
    int palette;

    palette = 1;
    shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].pal);
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
 * 459 -> 97 (rule-8 rewrite) -> 27 (palShare ref-count lever, below).
 * RESIDUAL 27 diffs (ours 301 / oracle 298 = +3), TWO clusters, both scheduling:
 *  (a) the spilled `&carObj->..palCopyNum[i]` giv: retail emits its store ONCE, in
 *      the loop-guard `beqz`'s DELAY SLOT (shared by the preheader fall-through and
 *      the back edge); ours stores it separately in the preheader (+ a load-delay
 *      nop) and again at the loop tail.  Reload/dbr placement, not source-shaped.
 *  (b) `addu a1,v0,s5` vs the oracle's `addu a1,s5,v0` -- commutative operand order
 *      on the ONE pmx materialization (RTL canonicalization; every other addu in the
 *      function already matches).
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
  Texture_palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
  Texture_ResetPaletteSharing();
  for (i = 0; i < 0x33; i = i + 1, carPixMapCount = carPixMapCount + 1) {
    shapetbl *shape;
    int palShare;
    int palette;

    palette = 1;
    shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].pal);
    palShare = CarIO_textureName[i].palShare;
    if ((shape == (shapetbl *)0x0) && (palShare == 0)) {
      palette = 0;
      shape = (shapetbl *)locateshapez(shpfile,CarIO_textureName[i].tex);
    }
    if (i == 0x14) {
      recolor_flag = 0;
    }
    if (shape != (shapetbl *)0x0) {
      Draw_tPixMap *pmx;

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
