/* game/psx/cario.cpp -- RECONSTRUCTED (NFS4 PSX car texture/CLUT I/O; C++ TU)
 *   11 fns: StartUp/CleanUp/ReStart, Copy[From/To]Shape, CreateLicense/CleanUpLicense/LicenseCheck,
 *   ReadIn/UpdateCarTextureData, ReleaseCarCluts. GTE-free. Full SYM-locals applied.
 */
#include "cario_types.h"
#include "cario_externs.h"

/* retail CarIO.obj .data (0x8011e804..0x8011ec18) and the texture-name literal pool in its
 * .sdata (0x8013d520..0x8013d71c, -G8 small literals emitted in first-use order).  Values
 * read from the retail image; the STAT/EXT classes follow the SYM. */
static CarIO_textureInfo CarIO_textureName[51] = {   /* SYM: STAT, 0x8011e804 */
  { "frnt", "Pfrn", 0 }, { "rear", "Prea", 0 }, { "side", "Psid", 0 }, { "top1", "Ptp1", 0 },
  { "top2", "Ptp2", 0 }, { "dHiF", "", 1 }, { "dHiR", "", 2 }, { "dHiS", "", 3 },
  { "dTp1", "", 4 }, { "dTop", "", 5 }, { "dLoF", "", 1 }, { "dLoR", "", 2 },
  { "dLoS", "", 3 }, { "wndw", "Pwnd", 0 }, { "ftdm", "Pftd", 0 }, { "splr", "Pspl", 0 },
  { "ext2", "Pex2", 0 }, { "ext3", "Pex3", 0 }, { "ext4", "Pex4", 0 }, { "whl ", "Pwhl", 0 },
  { "ext1", "", 0 }, { "botm", "", 0 }, { "whlI", "", 0 }, { "tred", "", 0 },
  { "bROf", "", 0 }, { "bSOf", "", 0 }, { "rvOf", "", 0 }, { "sFOf", "", 0 },
  { "sROf", "", 0 }, { "ltOf", "", 0 }, { "bROn", "", 0 }, { "bSOn", "", 0 },
  { "shdw", "", 0 }, { "sFOn", "", 0 }, { "sROn", "", 0 }, { "ltOn", "", 0 },
  { "dcl1", "", 0 }, { "dcl2", "", 0 }, { "dcl3", "", 0 }, { "dcl4", "", 0 },
  { "dcl5", "", 0 }, { "dcl6", "", 0 }, { "ins0", "", 0 }, { "ins1", "", 0 },
  { "ins2", "", 0 }, { "ins3", "", 0 }, { "ins4", "", 0 }, { "ins5", "", 0 },
  { "ins6", "", 0 }, { "ins7", "", 0 }, { "ins8", "", 0 },
};
short CarIO_carVRamSlots[18][2] = {
  { 640, 256 }, { 640, 341 }, { 640, 426 }, { 704, 256 }, { 704, 341 }, { 704, 426 },
  { 768, 256 }, { 768, 341 }, { 768, 426 }, { 832, 256 }, { 832, 341 }, { 832, 426 },
  { 896, 256 }, { 896, 341 }, { 896, 426 }, { 960, 256 }, { 960, 341 }, { 960, 426 } };
short CarIO_carVRamSlotsMenu[6][2] = { { 512, 0 }, { 576, 0 }, { 640, 0 }, { 704, 0 }, { 640, 0 }, { 704, 0 } };
short CarIO_carVRamAdd[6] = { 2, 1, 2, 1, 2, 1 };
short CarIO_carVRamOffset[6] = { 64, 0, -32, 64, 0, -32 };
short CarIO_licensePlate[22][6] = {
  { 27, 58, 22, 33, 58, 110 }, { 33, 58, 110, 26, 58, 0 }, { 27, 58, 22, 33, 58, 110 },
  { 33, 58, 110, 18, 58, 234 }, { 27, 58, 22, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 },
  { 18, 58, 234, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 },
  { 26, 58, 0, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 },
  { 33, 58, 110, 17, 58, 212 }, { 33, 58, 110, 18, 58, 234 }, { 27, 58, 22, 33, 58, 110 },
  { 33, 58, 110, 26, 58, 0 }, { 27, 58, 22, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 },
  { 26, 58, 0, 33, 58, 110 }, { 27, 58, 22, 33, 58, 110 }, { 33, 58, 110, 26, 58, 0 },
  { 0, 0, 0, 0, 0, 0 } };
short CarIO_licenseSFX_Vram[12][2] = {
  { 960, 426 }, { 966, 426 }, { 972, 426 }, { 978, 426 }, { 984, 426 }, { 990, 426 },
  { 996, 426 }, { 1002, 426 }, { 1008, 426 }, { 1014, 426 }, { 960, 448 }, { 966, 448 } };
/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
Draw_tPixMap *CarIO_carPixMap = 0;   /* @0x8013d71c  W67-A4: explicit =0 -- retail
    emits this cell AFTER the texture-name literal pool and BEFORE the TU's -G8 literal
    pool 0x8013d720..0x8013d73c ("plate1" "plate2" "blnk" "   "), so it cannot have been
    tentative (16E =0 discriminator).  DO NOT strip the =0. */
int CarIO_carPixMapCount;
int CarIO_carVRamCount;
int CarIO_licenseSFX_Count;
shapetbl *CarIO_Plate1[2];
shapetbl *CarIO_Plate2[2];
/* last deferred small global of CarIO.obj (.sdata 0x8013d758, after Plate2): the
 * front-end flag psxfront.cpp toggles. */
int inFrontEnd;

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
  /* retail: this TU's .rodata opens with an UNREFERENCED "SimpleMem" literal ahead of this
   * function's own constants (the dead tag string most objects carry); the constant-false
   * call keeps the string and adds no code. */
  if (0) reservememadr("SimpleMem",0,0);

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

/* ---- CarIO_CopyFromShape__FPsT0iiii  [CARIO.CPP:258-342] ----
 * Capture the masked word in each retail rollOver, then shift that real value.
 * The column for-loop owns the nested rotation region. Native locals/scopes
 * and all113 instructions match; complete source-line attribution is separate. */
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
void CarIO_CopyFromShape(short *source,short *dest,int w,int h,int x,int y)

{
  int columns = w >> 2, mask = w & 3;
  u_short firstMask;
  u_short lastMask;
  u_short lastLastMask;

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
    rollOver = lastMask & 0xf000;
    lastMask = lastMask << 4;
    rollOver >>= 0xc;
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
      rollOver = current & 0xf000;
      current = current << 4;
      rollOver >>= 0xc;
      next <<= 4;
      next |= rollOver;
    }
    i = 1;
    dest[0] &= firstMask;
    dest[0] |= current;
    for (; i < columns - 1; i++) {
      mask = x & 3;
      dest[i] = (short)next;
      current = *source;
      source = source + 1;
      next = 0;
      while (1) {
        u_short rollOver;

        mask = mask - 1;
        if (mask == -1) break;
        rollOver = current & 0xf000;
        current = current << 4;
        rollOver >>= 0xc;
        next <<= 4;
        next |= rollOver;
      }
      dest[i] |= current;
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

/* ---- CarIO_CopyToShape__FPsT0i  [CARIO.CPP:347-374] ----
 * The mirror for-loop reproduces retail pixel3 and all six declaring regions.
 * Nibble carriers/empty fence and full line attribution remain source review. */
void CarIO_CopyToShape(short *source,short *dest,int mirror)

{
  int h = 0x16;
  while (1) {
    int i;

    h = h - 1;
    if (h == -1) break;
    if (mirror == 0) {
      for (i = 0; i < 6; i++) {
        *dest++ = source[i];
      }
      source = source + 0xc;
    }
    else {
      for (i = 5; ; i--) {
        u_short pixel3;

        if (i < 0) break;
        /* SOURCE-REVIEW-UNRESOLVED: these parallel nibble objects are absent
         * from retail SYM. Current direct/accumulating forms change allocation;
         * that is not proof four source declarations were originally present. */
        int n0, n1, n2, n3;

        pixel3 = source[i];
        n0 = (pixel3 & 0xf) << 0xc;
        n1 = (pixel3 & 0xf0) << 4;
        n2 = (pixel3 & 0xf00) >> 4;
        pixel3 = pixel3 >> 0xc;
        n3 = pixel3;
        *dest++ = (short)(n0 | n1 | n2 | n3);
      }
      /* SOURCE-REVIEW-UNRESOLVED: without this existing zero-template fence,
       * GCC still merges the two source-advance tails (40 versus42 words).
       * Original source separation remains unrecovered. */
      __asm__("");
      source = source + 0xc;
    }
  }
  return;
}

/* ---- CarIO_CreateLicense__FPcii [CARIO.CPP:379-483] ----
 * Retail root order is i, clutPlate1/2, thePlate, shape, clutptr. The no-plate
 * early return leaves the text phase as a root child; letter/ascii belong to
 * the non-space glyph body. Index-first chained header stores and chained
 * next/width assignments need no p1/p2/q1/q2/r1 declarations.
 * All229 instructions and native local/scope records agree. Historical partial
 * sweeps do not prove source-object necessity or justify post-compile rewriting.
 * The existing ASCII identity boundary and full SLD remain source review. */
void CarIO_CreateLicense(char *text,int carType,int player)

{
  int i;
  shapetbl *clutPlate1;
  shapetbl *clutPlate2;
  short *thePlate;
  shapetbl *shape;
  shapetbl *clutptr;

  if (carType >= 0x16) {
    CarIO_Plate2[player] = (shapetbl *)0x0;
    CarIO_Plate1[player] = (shapetbl *)0x0;
    return;
  }
    CarIO_Plate1[player] = (shapetbl *)reservememadr("plate1",0x148,0);
    CarIO_Plate2[player] = (shapetbl *)reservememadr("plate2",0x148,0);
    clutPlate1 = CarIO_Plate1[player] + 0xe;
    clutPlate2 = CarIO_Plate2[player] + 0xe;
    thePlate = (short *)reservememadr("theplate",0x210,0x10);
    shape = (shapetbl *)locateshapez(R3DCar_LicenseShapeFile,"blnk");
    clutptr = (shapetbl *)((int)shape + (*(int *)shape >> 8));
    i = 0;
    do {
      *(int *)(i * 4 + (int)CarIO_Plate1[player]) =
          *(int *)(i * 4 + (int)CarIO_Plate2[player]) = ((int *)shape)[i];
      i = i + 1;
    } while (i < 4);
    i = 0;
    do {
      ((int *)clutPlate1)[i] = ((int *)clutPlate2)[i] = ((int *)clutptr)[i];
      i = i + 1;
    } while (i < 0xc);
    CarIO_Plate1[player]->next = CarIO_Plate2[player]->next = 0x118;
    CarIO_Plate1[player]->width = CarIO_Plate2[player]->width = 0x18;
    CarIO_CopyFromShape((short *)((int)shape + 0x10),thePlate,0x30,0x16,0,0);
    {
      int length;
      int start;

      length = strlen(text);
      start = 0x18 - length * 3;
      for (i = 0; i < length; i = i + 1) {
        if (text[i] != ' ') {
          char letter [5];
          char ascii;

          ascii = text[i];

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
          /* SOURCE-REVIEW-UNRESOLVED: removing this old identity boundary
           * still changes the switch allocation (29dif/230 after scope repair). */
          char savedAscii = ascii; ascii = 0; ascii = savedAscii;
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
  return;
}

/* ---- CarIO_CleanUpLicense__Fi  [CARIO.CPP:486-490] SLD-VERIFIED ---- */
/* NEAR-MISS 2 diffs (30/30): OURS fills the first beqz's delay slot with the join block's
 * `lui v0,%hi(CarIO_Plate2)` (reorg steal-from-target + duplicate on the jal path); the oracle
 * leaves a nop and keeps ONE lui at the join. Index-form rewrite = 6 diffs (reverted). A reorg
 * slot-steal tie (same class as Sfx_BuildSmokeFacet); permuter class. ACCEPT for now. */
void CarIO_CleanUpLicense(int player)

{
  /* plain indexed form: no locals, as the SYM records none */
  if (CarIO_Plate1[player] != (shapetbl *)0x0) {
    purgememadr(CarIO_Plate1[player]);
  }
  CarIO_Plate1[player] = (shapetbl *)0x0;
  if (CarIO_Plate2[player] != (shapetbl *)0x0) {
    purgememadr(CarIO_Plate2[player]);
  }
  CarIO_Plate2[player] = (shapetbl *)0x0;
  return;
}

/* ---- CarIO_LicenseCheck__FiPiT1P8Car_tObji  [CARIO.CPP:497-511] ----
 * sfx_vx/sfx_vy are the new table coordinates. The old X input is an anonymous
 * word load; mask it as int rather than narrowing the memory access to a byte.
 * Both source arms fall through, reproducing retail's local/scope contract.
 * Complete relative line attribution is checked separately. */
void CarIO_LicenseCheck(int reload,int *license_vx,int *license_vy,Car_tObj *carObj,int plate)

{
  if (((reload & 2U) != 0) && (CarIO_licenseSFX_Count < 0xc)) {
    int sfx_vx, sfx_vy;
    sfx_vx = CarIO_licenseSFX_Vram[CarIO_licenseSFX_Count][0];
    sfx_vy = CarIO_licenseSFX_Vram[CarIO_licenseSFX_Count][1];
    (carObj->render).licenseOffsetU[plate] =
        ((sfx_vx & 0x3f) - (*license_vx & 0x3f)) * 4;
    (carObj->render).licenseOffsetV[plate] = (char)sfx_vy - (char)*license_vy;
    *license_vx = sfx_vx;
    *license_vy = sfx_vy;
    CarIO_licenseSFX_Count = CarIO_licenseSFX_Count + 1;
  } else {
    (carObj->render).licenseOffsetU[plate] =
        (carObj->render).licenseOffsetV[plate] = '\0';
  }
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
    (carObj->render).textureStartIndex = CarIO_carPixMapCount;
    carPixMapCount = CarIO_carPixMapCount;
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

/* ---- CarIO_UpdateCarTextureData__FPcP8Car_tObji  [CARIO.CPP:718-849] ----
 * Missing initial shapes may still need palette handling. Existing shapes
 * require an enabled cache entry before either phase. This shared eligibility
 * owner restores the retail scopes and permits direct index-first addresses,
 * with no pmx source object. Full relative SLD remains independently checked. */
/* Historical source-ancestor measurements below; current verified body is
 * 298/298 PASS with exact native locals/regions (2026-10-09), not the old
 * 25-diff residual. Full source-line attribution remains unresolved.
 * SYM @0x800bceb0 (fsize 104, mask $c0ff0000). FULL rule-8 rewrite (w39-a5):
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
void CarIO_UpdateCarTextureData(char *shpfile,Car_tObj *carObj,int player)

{
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
    if (shape == (shapetbl *)0x0 ||
        ((((Draw_tPixMap *)(carPixMapCount * 16 + (int)CarIO_carPixMap))->flag & 0x80) != 0)) {
      if (shape != (shapetbl *)0x0) {
        int license;
        u_short clut;
        int cx;
        int cy;

        license = 0;
        clut = ((Draw_tPixMap *)(carPixMapCount * 16 + (int)CarIO_carPixMap))->clut;
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
                       vy + CarIO_licensePlate[carType][2],cx,cy,
                       (Draw_tPixMap *)(carPixMapCount * 16 + (int)CarIO_carPixMap));
          }
          else if (i == CarIO_licensePlate[carType][3]) {
            license = 1;
            Texture_LoadPmx((char *)0x0,(char *)CarIO_Plate2[player],recolor_flag,
                       vx + CarIO_licensePlate[carType][4],
                       vy + CarIO_licensePlate[carType][5],cx,cy,
                       (Draw_tPixMap *)(carPixMapCount * 16 + (int)CarIO_carPixMap));
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
