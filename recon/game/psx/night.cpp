/* game/psx/night.cpp -- RECONSTRUCTED (NFS4 PSX night-driving lighting/colour system; C++ TU)
 *   19 fns: colour-table build (FindClosestColor / CreateNightTable[Element] / GenerateAll),
 *   headlight + cop-strobe + weather colour setup, lightning effects (Generate/Pause/Do),
 *   Init/Kill/Restart night driving, SetEnviroment, AdditiveNightCalc. No GTE.
 */
#include "../../nfs4_types.h"
#include "night_externs.h"

/* ---- Night.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero; extern-vs-SYM disagreements resolved to SYM) ---- */
u_char       Night_gCopCarTypeColorIdx[2];   /* @0x8013d9e2  (bss(zero)) */
char         lightningInit = 1;   /* @0x8013D9FE */
char         Night_gCopCountryLightTbl[2][5][2] = { 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1 };   /* @0x80120d18 */
int          Night_gLightningPauseAreas[16][2];   /* @0x80120d2c  (bss(zero)) */
CVECTOR      Night_gAdditiveHeadlightColor[16];   /* @0x80120dbc  (bss(zero)) */
char         Night_gDrawLightning;   /* @0x8013d9e0  (bss(zero)) */
u_char       (*Night_gPlayerLightingTable)[256][16];   /* @0x8013d9e4  (bss(zero)) */
u_char       (*Night_gCopLightingTableRed)[256][8];   /* @0x8013d9e8  (bss(zero)) */
u_char       (*Night_gCopLightingTableBlue)[256][8];   /* @0x8013d9ec  (bss(zero)) */
/* Night_gWeatherLightingTable[2] is modelled as its TWO retail per-element gp-rel symbols
   (StatsTimer/overlays.cpp model, catalog sec.E dual-model + wave-13 "unsized-array asm-label
   view"): the oracle reaches the CONSTANT-index sites (Night_KillNightDriving [0] and [1])
   through a one-instruction %gp_rel(Night_gWeatherLightingTable) / %gp_rel(D_8013D9F4), which
   an 8-byte object can never produce under -G4, while the WALKING-BASE sites
   (Night_InitWeatherTables / Night_SetWeatherColors, and draww.cpp's Night_NightCalc) address
   the base absolutely with %hi/%lo(Night_gWeatherLightingTable) -- reproduced by the unsized
   asm-label array VIEW below.  The two 4-byte .comm symbols land adjacently in .sbss in
   declaration order, so the array view still reaches both words: KEEP THEM ADJACENT.
   The view MUST carry its CORRECT size [2], NOT the usual unsized `[]` (methodology
   sec.3.12 #5): an UNKNOWN-size extern makes cc1plus emit the `la sym` assembler MACRO,
   which GNU-as expands with a SEPARATE scratch (`lui v0,%hi; addiu s0,v0,%lo`), whereas
   retail's base-walk sites use the SELF-TEMP form (`lui s0,%hi; addiu s0,s0,%lo`) that
   only gcc's own split-address lowering produces -- and that lowering needs a KNOWN size
   over the -G threshold.  Sized [2] = 8 bytes > -G8's threshold-inclusive small test for
   an EXTERN of known size here, so gcc lowers it itself.  Measured: unsized -> 6/8 diffs
   on Night_InitWeatherTables/Night_SetWeatherColors, sized [2] -> 4/PASS. */
u_char       (*Night_gWeatherLightingTable)[256];   /* @0x8013d9f0  = [0]  (bss(zero)) */
u_char       (*D_8013D9F4)[256];   /* @0x8013d9f4  = [1] retail per-element gp-rel alias (bss(zero)) */
extern u_char (*Night_gWeatherLightingTable_arr[2])[256] asm("Night_gWeatherLightingTable"); /* array VIEW -- MUST be sized [2] */
char         CopCarTypeLights[6] = { 0, 0, 1, 0, 1, 1 };   /* @0x8013d9f8 */
int          gNight_renderNight;   /* @0x8013da28  (bss(zero)) */
int          Night_gXDist;   /* @0x8013da2c  (bss(zero)) */
int          Night_gZNear;   /* @0x8013da30  (bss(zero)) */
int          Night_gZDist;   /* @0x8013da34  (bss(zero)) */
int          Night_gXDistShift;   /* @0x8013da38  (bss(zero)) */
int          Night_gZDistShift;   /* @0x8013da3c  (bss(zero)) */
char         *Night_gNightTbl;   /* @0x8013da40  (bss(zero)) */
int          Night_gLightningType;   /* @0x8013da44  (bss(zero)) */
u_char       (*Night_gCurrentNightColor)[256][16];   /* @0x8013da48  (bss(zero)) */
/* Night_gCopColor[2]: same per-element gp-rel dual-model as Night_gWeatherLightingTable above --
   Night_SetCopColor stores both elements through %gp_rel(Night_gCopColor)/%gp_rel(D_8013DA50),
   while draww.cpp's Night_NightCopCalc indexes the base at RUNTIME via %hi/%lo(Night_gCopColor)
   (that TU keeps its own `extern u_char (*Night_gCopColor[2])[256][8];` array decl).
   KEEP THE TWO .comm SYMBOLS ADJACENT (declaration order == .sbss order). */
u_char       (*Night_gCopColor)[256][8];   /* @0x8013da4c  = [0] (bss(zero)) */
u_char       (*D_8013DA50)[256][8];   /* @0x8013da50  = [1] retail per-element gp-rel alias (bss(zero)) */
CVECTOR      Night_gNightAmbientColor;   /* @0x8013da54  (bss(zero)) */
CVECTOR      Night_gColor[2];   /* @0x8013da58  (bss(zero)) */
int          Night_gTotalLights;   /* @0x8013da60  (bss(zero)) */
int          Night_gLightning;   /* @0x8013da64  (bss(zero)) */
int          Night_gNextLightning;   /* @0x8013da68  (bss(zero)) */
int          Night_gEndNextLightning;   /* @0x8013da6c  (bss(zero)) */
int          Night_gNextFlicker;   /* @0x8013da70  (bss(zero)) */
int          Night_gFlashAzimuth;   /* @0x8013da74  (bss(zero)) */
char         Night_gShowForks;   /* @0x8013da78  (bss(zero)) */
int          Night_gFlashIntensity;   /* @0x8013da7c  (bss(zero)) */
long         Night_gPlayerHeadLightColor[2];   /* @0x8013da80  (bss(zero)) */
/* Night_gWeatherColor[2]: same per-element gp-rel dual-model -- Night_InitWeatherTables stores
   both words through %gp_rel(Night_gWeatherColor)/%gp_rel(D_8013DA8C), while
   Night_SetWeatherColors (and drawc.cpp's DrawC_NightHeadlight) walk the base absolutely.
   KEEP THE TWO .comm SYMBOLS ADJACENT (declaration order == .sbss order). */
long         Night_gWeatherColor;   /* @0x8013da88  = [0] (bss(zero)) */
long         D_8013DA8C;   /* @0x8013da8c  = [1] retail per-element gp-rel alias (bss(zero)) */
extern long  Night_gWeatherColor_arr[2] asm("Night_gWeatherColor"); /* array VIEW -- MUST be sized [2] */
tNightInitCache *gNightInitCache;   /* @0x8013da90  (bss(zero)) */
tCompRGB     *gTableCache;   /* @0x8013da94  (bss(zero)) */
char         *nightfile;   /* @0x8013da98  (bss(zero)) */


/* ---- Night_FindClosestColor__FG7CVECTORPi  [NIGHT.CPP:134-175] SLD-VERIFIED ----
 * SEALED 50/50 PASS (w38-a10; was an 82-diff far-miss at ours 52 / oracle 50).
 * FIVE stacked levers, all SYM/oracle-derived (SYM block @43bbac):
 *  (1) the search cursor is NOT a walking `tCompRGB *p` -- the oracle re-loads
 *      %gp_rel(gTableCache) INSIDE the loop and adds a *3 offset giv
 *      (`addiu t1,t1,3`), i.e. the source indexes the GLOBAL: gTableCache[search].
 *      (gcc must reload the pointer because the `*bestIndex` store may alias it.)
 *  (2) the zero-trip guard compares the VARIABLE, `if (search < maxLights)`
 *      (oracle `slt v0,a3,v1; beqz`), not the literal `1 < maxLights`
 *      (which folds to `slti v0,v1,2; bnez`).
 *  (3) diffSum is a term-by-term ACCUMULATION (3 statements), not one sum
 *      expression -- makes diffSum's own pseudo hold the running sum from the
 *      first product (oracle `mflo a0 ... addu a0,a0,a2 ... addu a0,a0,t9`);
 *      the single expression built the sum in a fresh temp (+1 insn).
 *  (4) `bestDiff = 0x2fa03;` is the FIRST statement -- its long live range
 *      LOWERS its allocno priority so it lands on $t0 and `search` wins $a3
 *      (SYM: bestDiff $8 = t0, search $7 = a3). Initialising it just before the
 *      guard inverted the pair (28 diffs, count already exact).
 *  (5) inside the if-body `bestDiff = diffSum;` precedes `*bestIndex = ...`.
 * `search` sits in its own nested SYM block (2nd `Block start line = 1`).
 * Prototype re-checked vs raw oracle: struct-by-value ARG colorMatch (spilled to
 * 0(sp) and re-read as 3 lbu), REGPARM $a1 bestIndex, INT return in $v0. */
int Night_FindClosestColor(CVECTOR colorMatch,int *bestIndex)

{
  int bestDiff;
  int diffR;
  int diffG;
  int diffB;
  int colorMatchr;
  int colorMatchg;
  int colorMatchb;
  int searchColorr;
  int searchColorg;
  int searchColorb;
  int diffSum;
  int maxLights;

  bestDiff = 0x2fa03;
  colorMatchr = colorMatch.r;
  colorMatchg = colorMatch.g;
  colorMatchb = colorMatch.b;
  {
  int search;

  search = 1;
  maxLights = Night_gTotalLights + 1;
  searchColorr = (u_char)gTableCache->r;
  searchColorg = (u_char)gTableCache->g;
  searchColorb = (u_char)gTableCache->b;
  if (search < maxLights) {
    do {
      diffR = colorMatchr - searchColorr;
      diffG = colorMatchg - searchColorg;
      diffB = colorMatchb - searchColorb;
      searchColorr = (u_char)gTableCache[search].r;
      searchColorg = (u_char)gTableCache[search].g;
      searchColorb = (u_char)gTableCache[search].b;
      diffSum = diffR * diffR;
      diffSum = diffSum + diffG * diffG;
      diffSum = diffSum + diffB * diffB;
      if (diffSum < bestDiff) {
        bestDiff = diffSum;
        *bestIndex = search + -1;
        if (diffSum < 0x40) {
          return diffSum;
        }
      }
      search = search + 1;
    } while (search < maxLights);
  }
  }
  return bestDiff;
}

/* ---- Night_CreateNightTableElement__FiliPUc  [NIGHT.CPP:181-231] SLD-VERIFIED ----
 * NEAR-MISS 56 diffs, COUNT-EXACT 113/113 (w40-a9; was 85 with 110/113).
 * Residual is a pure allocno swap against the SYM register map (sourceR $4/a0,
 * sourceG $5/a1, sourceB $3/v1, chr $3, chg $8/t0, chb $9/t1, b15 $7/a3, newR $6/a2,
 * newG $5/a1, newB $4/a0): ours puts b15 in $a1 and sourceG in $a3 (the SYM has them
 * the other way round) and swaps newG/newB between $a0 and $a1.  Priority estimate
 * says it is a razor edge -- b15 has 4 refs (floor_log2=2 -> weight 8) over ~40 insns,
 * sourceG 2 refs (weight 2) over ~8, so the b15-loses condition is len_b15 > 4*len_g,
 * i.e. right at the boundary.  FALSIFIED (all re-gate to 56 or worse): sources-before-
 * component-bytes (70), b15 computed after the bytes, b15 after the sources, fully
 * interleaved source/new pairs (84), b15 declared first, newG/newB decl swap,
 * sourceG/sourceB decl swap.  The prologue also copies $a3 into $s1 (colorval) after
 * $a0 into $s0 where retail does it first -- the same emission-order tie.
 * PROTOTYPE RE-CHECKED: 4 args (colorIndex REGPARM $10, colorH ARG stack, bright
 * REGPARM $6, colorval REGPARM $11), void return -- matches the SYM exactly. */
void Night_CreateNightTableElement(int colorIndex,long colorH,int bright,u_char *colorval)

{
  int sourceR;
  int sourceG;
  int sourceB;
  int chr;
  int chg;
  int chb;
  CVECTOR newColor;
  int b15;
  int newR;
  int newG;
  int newB;
  int bestIndex;

  b15 = bright * 0x111;
  /* colorH's THREE COMPONENT BYTES are read with lbu out of its ARG HOME on the stack
     (oracle `sw $a1,0x34($sp)` then `lbu 0x34($sp)` / `addiu $v1,$sp,0x34; lbu 1($v1);
     lbu 2($v1)`), which is also why the SYM classes colorH as ARG (stack) rather than
     REGPARM -- taking its address forces the spill.  The shift/mask spelling
     (`colorH & 0xff`, `>>8 & 0xff`, `>>16 & 0xff`) compiles to srl/andi and has no
     lbu at all. */
  chr = ((u_char *)&colorH)[0];
  chg = ((u_char *)&colorH)[1];
  chb = ((u_char *)&colorH)[2];
  sourceR = gTableCache[colorIndex].r;
  sourceG = gTableCache[colorIndex].g;
  sourceB = gTableCache[colorIndex].b;
  newR = sourceR + ((int)(chr * b15) >> 0xc);
  if (0xff < newR) newR = 0xff;
  newG = sourceG + ((int)(chg * b15) >> 0xc);
  if (0xff < newG) newG = 0xff;
  newB = sourceB + ((int)(chb * b15) >> 0xc);
  if (0xff < newB) newB = 0xff;
  /* `& ~7` (a register-held -8, oracle `addiu $v1,$zero,-0x8` + three `and`), NOT
     `& 0xf8` (which is a 16-bit unsigned immediate -> andi). */
  newColor.r = (u_char)(newR & ~7);
  newColor.g = (u_char)(newG & ~7);
  newColor.b = (u_char)(newB & ~7);
  /* newColor.cd is deliberately NOT initialised: the oracle builds the by-value CVECTOR
     argument by re-reading all four bytes back off the stack (`lbu $v0,0x13($sp)` for
     .cd) with no preceding store, so retail leaves it whatever was in the slot.  Harmless
     -- Night_FindClosestColor only reads .r/.g/.b -- but writing 0 costs an extra sb. */
  if (((Night_FindClosestColor(newColor,&bestIndex) < 0x201) || (Chunk_numLight + 4 <= colorIndex)) ||
      (0xff < Night_gTotalLights)) {
    *colorval = (u_char)bestIndex;
  }
  else {
    gTableCache[Night_gTotalLights].r = newColor.r;
    gTableCache[Night_gTotalLights].g = newColor.g;
    gTableCache[Night_gTotalLights].b = newColor.b;
    *colorval = (u_char)Night_gTotalLights;
    Night_gTotalLights = Night_gTotalLights + 1;
  }
  return;
}

/* ---- Night_CreateNightTable__FiliPA256_A16_Uc  [NIGHT.CPP:236-237] SLD-VERIFIED ---- */
void Night_CreateNightTable(int colorIndex,long colorH,int bright,u_char (*tbl)[256][16])

{
  Night_CreateNightTableElement(colorIndex,colorH,bright,(*tbl)[colorIndex] + bright);
  return;
}

/* ---- Night_GenerateNextLightningEvent__Fv  [NIGHT.CPP:347-353] SLD-VERIFIED ---- */
void Night_GenerateNextLightningEvent(void)

{
  u_int r;
  int fork;
  int rmask;
  int *ticksp;

  ticksp = &simGlobal.gameTicks;
  r = random();
  rmask = (r & 0x7ff) + 0x1f;
  Night_gNextLightning = *ticksp + rmask;
  r = random();
  rmask = (r & 0xf) + 0xf;
  Night_gEndNextLightning = Night_gNextLightning + rmask;
  Night_gNextFlicker = Night_gNextLightning;
  r = random();
  Night_gFlashAzimuth = r & 0xffff;
  fork = random();
  Night_gShowForks = (u_char)fork & 1;
  return;
}

/* ---- Night_PauseLightningEffect__Fi  [NIGHT.CPP:381-416] SLD-VERIFIED ---- */
void Night_PauseLightningEffect(int player)

{
  int track;
  int slice;
  int startp;
  int endp;
  int pause_flag;

  slice = Camera_gInfo[player].slicePos.slice;
  track = D_80113228[0];
  pause_flag = 0;
  startp = Night_gLightningPauseAreas[track][0];
  endp = Night_gLightningPauseAreas[track][1];
  if (startp < slice) {
    pause_flag = slice < endp;
  }
  if (Weather_gType == 0) {
    pause_flag = 1;
  }
  if (pause_flag != 0) {
    Night_gNextLightning = D_8011E0B0[0];
    Night_gEndNextLightning = D_8011E0B0[0];
  }
  return;
}

/* ---- Night_DoLightningEffect__FP13DRender_tView  [NIGHT.CPP:423-467] SLD-VERIFIED ---- */
void Night_DoLightningEffect(DRender_tView *Vi)

{
  u_int r;
  void *tunnel;
  
  if (Night_gLightning != 0) {
    AudioCmn_PlayThunder(Night_gFlashIntensity,Night_gFlashAzimuth);
    Hrz_LightningFlicker(0);
    Night_gLightning = 0;
  }
  if (((simGlobal.gameTicks > Night_gNextLightning) &&
      (simGlobal.gameTicks < Night_gEndNextLightning)) && (Night_gNextFlicker < simGlobal.gameTicks)
     ) {
    r = random();
    Night_gLightningType = r & 1;
    Hrz_LightningFlicker(1);
    tunnel = BWorldSm_TunnelFlagSm(&Camera_gInfo[Vi->player].slicePos);
    /* branched if/else, NOT `= (tunnel == 0)`: the oracle emits
       `beqz $v0,.L; addiu $v0,zero,1` + two separate `sb` stores with a `j` over the
       else arm; the boolean-expression form folds to a single sltiu. */
    if (tunnel != (void *)0x0) {
      Night_gDrawLightning = 0;
    }
    else {
      Night_gDrawLightning = 1;
    }
    Night_gLightning = 1;
    r = random();
    Night_gNextFlicker = simGlobal.gameTicks + (r & 3);
    r = random();
    Night_gFlashIntensity = (Night_gLightningType + 1) * (r & 0x1f) + 0x40;
    if (lightningInit != '\0') {
      if (Night_gShowForks != '\0') {
        Hrz_SetLightingPosInSky(Vi);
      }
      lightningInit = '\0';
    }
  }
  if (simGlobal.gameTicks > Night_gEndNextLightning) {
    Night_GenerateNextLightningEvent();
    Hrz_CalculateLightning();
    lightningInit = '\x01';
  }
  return;
}

typedef struct { int w[2]; } NightCopTablePair;

/* ---- Night_SetCopColor__FP18GameSetup_tCarData  [NIGHT.CPP:473-484] SLD-VERIFIED ----
 * NEAR-MISS 5 diffs (ours 38 / oracle 37).  Was 25, then 21 after the per-element
 * %gp_rel split of Night_gCopColor (w39-a9), then 5 after the SYM rewrite below.
 * SYM block @43c244 is the ground truth (fsize 16, mask $00000000 = NO saved regs,
 * ONE block, six locals):
 *    carinfo  REGPARM $4  = a0
 *    cartype  REG     $2         country REG $5 = a1        carTable REG $4
 *    copColors AUTO `ARY PTR ARY ARY UCHAR size 8 dims 3 2 256 8` @ -0x10 => sp+0
 *    col1     REG     $2         col2    REG $2
 * => the retail local is `u_char (*copColors[2])[256][8]` -- TWO entries at sp+0..7, NOT
 *    the four-entry sp+0..0xF table the old recon modelled.  The oracle's second pair at
 *    sp+8/sp+0xC is gcc's TEMPORARY for a LOCAL AGGREGATE INITIALIZER whose elements are
 *    NOT compile-time constants: `u_char (*copColors[2])[256][8] = { Red, Blue };` builds
 *    the value at sp+8/0xC and then movstrsi-copies it down to sp+0/4.  That is exactly
 *    the oracle's `sw v0,8(sp); sw v1,0xC(sp); lw a2,8(sp); lw a3,0xC(sp); sw a2,0(sp);
 *    sw a3,4(sp)` -- reproduced here for the right reason (the old recon got the same
 *    bytes out of a hand-written 4-slot array + a struct-assignment, which is why the
 *    SYM's `copColors` name/shape never fit).
 *    NEW CATALOG ROW: a local array with a NON-CONSTANT aggregate initializer = build-in-
 *    temp + block copy; the same values written as element assignments do NOT produce it.
 * `country` MUST be read BEFORE `cartype` (13 -> 5 diffs): it is what puts cartype in $a0
 * and country in $a1 like retail; the reverse order swaps them and cascades.
 * RESIDUAL 5: ours `lw v0,0(v0); nop; sw v0,%gp_rel(Night_gCopColor)` for the FIRST
 * element; retail loads it into $a0 and DEFERS the store past col2's index arithmetic,
 * which fills the load-delay slot (37 vs our 38 insns).  Tried and re-gated: moving the
 * store after `col2 = ...` (35 insns, 32 diffs -- gcc cross-merges the two stores),
 * hoisting both col1/col2 reads first (same 32), dropping the carTable temp (5, tie),
 * carTable typed `int` per the SYM (5, tie), carTable block-scoped (5, tie), a
 * `char *pair` local for the two country-table bytes (20, worse), flat single-scope
 * decls (5, tie).  Also survives -G8 and all four wired per-TU codegen flags. */
void Night_SetCopColor(GameSetup_tCarData *carinfo)

{
  int cartype;
  int country;
  u_char (*carTable)[256][8];

  country = carinfo->Country;
  cartype = Night_gCopCarTypeColorIdx[carinfo->carType];
  {
    u_char (*copColors[2])[256][8] = { Night_gCopLightingTableRed,
                                       Night_gCopLightingTableBlue };
    int col1;
    int col2;

    col1 = (u_char)Night_gCopCountryLightTbl[cartype][country][0];
    carTable = copColors[col1];
    Night_gCopColor = carTable;
    col2 = (u_char)Night_gCopCountryLightTbl[cartype][country][1];
    D_8013DA50 = copColors[col2];
  }
  return;
}

/* ---- Night_InitPlayerHeadLightColor__Fi  [NIGHT.CPP:488-496] SLD-VERIFIED ---- */
void Night_InitPlayerHeadLightColor(int player)

{

  if (Night_gPlayerLightingTable == (u_char (*) [256] [16])0x0) {
    Night_gPlayerLightingTable = reservememadr("plnight",0x1000,0);
  }
  Night_gPlayerHeadLightColor[player] = *(long *)&TrackSpec_gSpec.nightspec.nightcolor;
  return;
}

/* ---- Night_SetPlayerHeadLightColor__Fiii  [NIGHT.CPP:501-503] SLD-VERIFIED ---- */
/* SEALED 15/15 PASS (w39-a9).  The prior "GENUINE FLOOR. ACCEPT." verdict here (a 10-diff
 * v0/v1 register-materialization tie-break on &Night_gPlayerHeadLightColor[player]) was
 * WRONG -- it was a per-OBJ TOOLCHAIN-IDENTITY artifact, not an allocator tie-break:
 * night.obj was built -G8, not -G4.  Proof: the retail oracle reaches the night-OWNED,
 * 8-BYTE Night_gPlayerHeadLightColor (long[2] @0x8013da80) with a one-instruction
 * %gp_rel in Night_GenerateAllLightTables -- impossible under -G4.  Under -G8 cc1plus
 * emits the `la $r,sym` assembler MACRO instead of pre-splitting it into a schedulable
 * `lui %hi / addiu %lo` pair, and the macro expansion is retail's.  See the
 * "recon/game/psx/night.cpp" entry in tools/build.py PER_TU_FLAGS.  No source change. */
void Night_SetPlayerHeadLightColor(int player,int colorIndex,int bright)

{
  Night_CreateNightTable(colorIndex,Night_gPlayerHeadLightColor[player],bright,Night_gPlayerLightingTable);
  return;
}

/* ---- Night_InitCopLightColors__Fv  [NIGHT.CPP:507-515] SLD-VERIFIED ---- */
void Night_InitCopLightColors(void)

{
  if (Night_gCopLightingTableRed == (u_char (*) [256] [8])0x0) {
    Night_gCopLightingTableRed = reservememadr("CopRed",0x800,0);
  }
  if (Night_gCopLightingTableBlue == (u_char (*) [256] [8])0x0) {
    Night_gCopLightingTableBlue = reservememadr("CopBlue",0x800,0);
  }
  return;
}

/* ---- Night_SetCopLightColors__Fii  [NIGHT.CPP:519-527] SLD-VERIFIED ---- */
void Night_SetCopLightColors(int colorIndex,int brighten)

{
  
  Night_CreateNightTableElement(colorIndex,0x602020,brighten,
             (*Night_gCopLightingTableBlue)[colorIndex] + (brighten >> 1));
  Night_CreateNightTableElement(colorIndex,0x101054,brighten,
             (*Night_gCopLightingTableRed)[colorIndex] + (brighten >> 1));
  return;
}

/* ---- Night_InitWeatherTables__Fv  [NIGHT.CPP:532-540] SLD-VERIFIED ---- */
/* NEAR-MISS 6 diffs, insn count now EXACT 33/33 (was 20 diffs at 35/33).  Residual 2 is
 * GONE: the old note's "Night_gWeatherColor[0]/[1] per-element gp-rel = confirmed
 * toolchain floor, NOT source-reachable" verdict was WRONG -- splitting the 8-byte array
 * into its two retail per-element symbols (Night_gWeatherColor / D_8013DA8C, + the
 * unsized asm-label array view for Night_SetWeatherColors' base walk) reproduces both
 * %gp_rel stores.  REMAINING 6: the oracle materializes Night_gWeatherLightingTable's
 * base DIRECTLY into s0 (`lui s0; addiu s0,s0,lo`), ours self-temps via v0 (`lui v0;
 * addiu s0,v0,lo`) -- the sec.3.15 v0-vs-dest register-materialization tie-break, shared
 * with the sibling Night_SetWeatherColors below -- which the sized-[2] array-VIEW fix has
 * since SEALED (it cut this fn 6 -> 4 too; see that fn's note).  What is LEFT here is the
 * same self-temp materialization surviving the shape fix because the `wtnight` string
 * literal (D_8013DA18) competes for the slot: ours `lui v0,%hi; sw s0,16(sp); addiu
 * s0,v0,%lo`, retail `sw s0,16(sp); lui s0,%hi; addiu s0,s0,%lo`.  Survives -G8 and all
 * four wired per-TU
 * codegen flags (w39-a9 probe: no_split_addresses +4, no_schedule_insns +6,
 * no_schedule_insns2 +14, no_strength_reduce 0). */
/* SEALED 33/33 PASS (w41-a7).  The w40 note called the residual 4 an untouchable
 * "callee-save emission-order tie-break" -- it was NOT: the recon carried TWO FABRICATED
 * locals.  The SYM 8c block (nfs4-f-v3.txt:43c5b0) declares exactly ONE named local for
 * this function, `i` = REG $0x11 = $s1, inside a NESTED block (Block start line 1 >
 * Block start line 1 > i > Block end line 6 > Block end line 8) -- there is no
 * `tbl_walk` walking pointer and no `alloc_buf` call-result temp.  Both were compiler
 * artifacts transcribed as C: the walker is loop.c's giv for the index form, and the
 * call result is stored straight through.  Rewriting to the SYM shape (a block-scoped
 * `i`, plain `for (i = 0; i < 2; i++)` index form over the sized [2] array VIEW, and the
 * reservememadr() result assigned directly to the element) makes gcc regenerate the
 * strength-reduced walker AND fixes the prologue order in one edit.  Constant bound 2
 * => gcc rotates the `for` to the oracle's guard-free bottom-tested do-while. */
void Night_InitWeatherTables(void)

{
  {
    int i;

    for (i = 0; i < 2; i = i + 1) {
      if (Night_gWeatherLightingTable_arr[i] == 0) {
        Night_gWeatherLightingTable_arr[i] =
            (u_char (*)[256])reservememadr("wtnight",0x100,0);
      }
    }
  }
  Night_gWeatherColor = 0x574054;
  D_8013DA8C = 0x6c4040;
  return;
}

/* ---- Night_SetWeatherColors__Fi  [NIGHT.CPP:544-546] SLD-VERIFIED ---- */
/* SEALED 31/31 PASS (w39-a9).  The prior note certified this as a "GENUINE FLOOR" --
 * the sec.3.15 v0-vs-dest register-materialization tie-break (ours `lui v0; addiu s1,v0,lo`,
 * retail `lui s1; addiu s1,s1,lo`).  It was NOT a floor: it was the DECLARED SHAPE of the
 * two base-walk arrays.  An UNSIZED `extern T g[]` view makes cc1plus emit the `la sym`
 * assembler MACRO, and GNU-as expands that with a separate scratch; giving the view its
 * CORRECT size [2] lets gcc lower the address ITSELF (split-addresses) into the self-temp
 * `lui sN,%hi; addiu sN,sN,%lo` retail uses.  Exactly IDT Ch9's own rule -- "either omit
 * the size or give the CORRECT size" -- read in the OTHER direction from methodology
 * sec.3.12 #5's usual unsized-array lever. */
void Night_SetWeatherColors(int colorIndex)

{
  long colorH;
  u_char (*wtbl) [256];
  u_char (**wtblp) [256];
  long *color_walk;
  int i;

  i = 0;
  color_walk = Night_gWeatherColor_arr;
  wtblp = Night_gWeatherLightingTable_arr;
  do {
    colorH = *color_walk;
    color_walk = color_walk + 1;
    wtbl = *wtblp;
    wtblp = wtblp + 1;
    i = i + 1;
    Night_CreateNightTableElement(colorIndex,colorH,0xf,*wtbl + colorIndex);
  } while (i < 2);
  return;
}

/* ---- Night_GenerateAllLightTables__Fv  [NIGHT.CPP:556-625] SLD-VERIFIED ---- */
void Night_GenerateAllLightTables(void)

{
  /* SYM: STAT char[16].  Retail passes colorCreationTable[i] (a dither-ordered brightness
     permutation, D_80120DAC = 00 0F 07 05 0B 0D 03 09 01 0E 0A 04 02 0C 06 08) as the
     BRIGHTNESS argument of BOTH Night_SetPlayerHeadLightColor and Night_SetCopLightColors
     (oracle `addu $v0,$s0,$s4; lbu $s1,0($v0)` then `addu $a2,$s1,zero` / `addu $a1,$s1,zero`);
     the old body passed the raw loop counter -- a REAL BUG (wrong headlight/cop-light
     brightness slot filled for every colour). */
  static char colorCreationTable[16] = {0,15,7,5,11,13,3,9,1,14,10,4,2,12,6,8};

  gNightInitCache = (tNightInitCache *)&Render_gPalettePtr;
  gTableCache = (tCompRGB *)&Render_gPalettePtr;
  Night_gTotalLights = Chunk_numLight;
  {
    int i;

    i = 0;
    do {
      gTableCache[i].r = Chunk_lightTable[i].r;
      gTableCache[i].g = Chunk_lightTable[i].g;
      gTableCache[i].b = Chunk_lightTable[i].b;
      i = i + 1;
    } while (i < 0x100);
  }
  {
    int colorIndex;
    int i;

    colorIndex = 0;
    while (colorIndex < Night_gTotalLights) {
      {
        int i;

        if (GameSetup_gData.Weather == 1) {
          Night_SetWeatherColors(colorIndex);
          i = 0;
        }
        else {
          i = 0;
        }
        while (i < 0x10) {
          int bright;

          bright = colorCreationTable[i];
          Night_SetPlayerHeadLightColor(0,colorIndex,bright);
          if ((GameSetup_gData.cops != 0) && (i < 8)) {
            Night_SetCopLightColors(colorIndex,bright);
          }
          i = i + 1;
        }
      }
      colorIndex = colorIndex + 1;
    }
  }
  {
    int i;

    i = 0;
    do {
      Chunk_lightTable[i].r = gTableCache[i].r;
      Chunk_lightTable[i].g = gTableCache[i].g;
      Chunk_lightTable[i].b = gTableCache[i].b;
      i = i + 1;
    } while (i < 0x100);
  }
  /* the .g/.b components MUST be read through a CVECTOR-typed view, not a byte cast:
     the struct-typed MEM keeps gcc from folding the access into the one-instruction
     %gp_rel(sym+N) assembler macro, so the base address is LICM-hoisted into a register
     and the two components are read as 1($a3)/2($a3) -- exactly the oracle
     (`lui $a3,%hi(sym); addiu $a3,$a3,%lo(sym)` in the preheader, `lbu $v0,0x1($a3)` /
     `lbu $v0,0x2($a3)`), while element [0] stays %gp_rel.  A byte-pointer spelling
     (`*(u_char*)((char*)sym+1)` or `((u_char*)sym)[1]`) gp-rels all three and is 2 short. */
  {
    int i;

    i = 0;
    do {
      Night_gAdditiveHeadlightColor[i].r =
           (u_char)((int)((u_int)(u_char)Night_gPlayerHeadLightColor[0] * i) / 0xf);
      Night_gAdditiveHeadlightColor[i].g =
           (u_char)((int)((u_int)((CVECTOR *)Night_gPlayerHeadLightColor)->g * i) / 0xf);
      Night_gAdditiveHeadlightColor[i].b =
           (u_char)((int)((u_int)((CVECTOR *)Night_gPlayerHeadLightColor)->b * i) / 0xf);
      i = i + 1;
    } while (i < 0x10);
  }
  return;
}

/* ---- Night_InitNightDriving__Fv  [NIGHT.CPP:631-680] SLD-VERIFIED ---- */
void Night_InitNightDriving(void)

{
  char *mem;          /* SYM: the ONLY REG local ($10 = s0) -- it serves TWO roles,
                         first the loadshapeadr buffer then the locateshape result */
  char name [256];    /* SYM: AUTO char[256] @ -0x110 => sp+16 */

  /* ONE `&&` expression, ONE store: the oracle computes the flag in $v0 (`addu
     $v0,zero,zero` in the Time==0 beqz delay slot, xori/sltu otherwise) and stores it
     once at the join, then RE-TESTS Time (same CSE'd $v1) to gate the depth-cue clear
     and RE-LOADS the flag for the early-out.  A leading `= 0` plus an overwrite emits
     two stores; an if/else pair or a ternary both come out 4-7 instructions long
     (measured).  Same lever family as methodology sec.3.12 #7. */
  gNight_renderNight = GameSetup_gData.Time != 0 && GameSetup_gData.commMode != 1;
  if ((GameSetup_gData.Time != 0) && (gNight_renderNight == 0)) {
    /* the whole 4-byte CVECTOR is cleared with ONE word store (oracle
       `sw $zero,0xF0($v0)`), not four `sb`s; distance is an int at +0xF4
       (`sw $v1,0xF4($v0)`).  Per-field byte clears cost 4 extra instructions. */
    TrackSpec_gSpec.depthcuespec.distance = 0xff;
    *(u_long *)&TrackSpec_gSpec.depthcuespec.color = 0;
  }
  if (gNight_renderNight == 0) {
    return;
  }
  sprintf(name,"%snight.psh",Paths_Paths[0x19]);
  /* no `sz`/`shp` locals: the SYM lists only `mem` and `name`.  Both filesize() results
     are consumed straight out of $v0 (the second one lands in the blockmove arg while
     the loadshapeadr pointer is parked in $s0 from the jal delay slot), and `mem`
     carries the shape buffer BEFORE it carries the locateshape result. */
  nightfile = (char *)reservememadr("night.psh",filesize(name),0);
  mem = (char *)loadshapeadr(name,(void *)0x0);
  blockmove(mem,nightfile,filesize(name));
  purgememadr(mem);
  /* locateshape is 2-arg (recon/eaclib/psx/eacpsxz/locatshp.c: `void *locateshape(void
     *shapefile,int *namekey)`); the oracle sets NO fresh $a2 here -- the old 3rd arg was
     a phantom read of the stale blockmove size. */
  mem = (char *)locateshape(nightfile,"nght");
  Night_gNightTbl = mem + 0x10;
  Night_InitPlayerHeadLightColor(0);
  if (GameSetup_gData.cops != 0) {
    Night_InitCopLightColors();
  }
  if (GameSetup_gData.Weather == 1) {
    Night_InitWeatherTables();
  }
  Night_GenerateAllLightTables();
  if (GameSetup_gData.Weather == 1) {
    Night_gLightning = 0;
    Night_gNextLightning = D_8011E0B0[0] + (random() & 0x1ff);
    Night_gEndNextLightning = Night_gNextLightning + (random() & 0x31);
    Night_gNextFlicker = Night_gNextLightning;
    Hrz_CalculateLightning();
  }
  return;
}

/* ---- Night_KillNightDriving__Fv  [NIGHT.CPP:687-719] SLD-VERIFIED ---- */
/* SEALED 40/40 PASS (w39-a9).  The prior note certified the last two purge-blocks as a
 * "confirmed toolchain floor" (gp-rel-INTO-an-array-ELEMENT, catalog sec.E / Hud_Reset)
 * because Night_gWeatherLightingTable is ALSO indexed with a runtime variable in
 * draww.cpp.  That was WRONG on the "can't split" premise: the split is per-TU, and
 * draww.cpp keeps its own array-shaped extern (which is the form ITS oracle wants).
 * Splitting the definition here into the two retail per-element symbols
 * Night_gWeatherLightingTable / D_8013D9F4 (+ an unsized asm-label array VIEW for this
 * TU's own base-walk sites) reproduces both %gp_rel stores exactly. */
void Night_KillNightDriving(void)

{
  if (nightfile != (char *)0x0) {
    purgememadr(nightfile);
  }
  nightfile = (char *)0x0;
  if (Night_gPlayerLightingTable != (u_char (*) [256] [16])0x0) {
    purgememadr(Night_gPlayerLightingTable);
  }
  Night_gPlayerLightingTable = (u_char (*) [256] [16])0x0;
  if (Night_gCopLightingTableRed != (u_char (*) [256] [8])0x0) {
    purgememadr(Night_gCopLightingTableRed);
  }
  Night_gCopLightingTableRed = (u_char (*) [256] [8])0x0;
  if (Night_gCopLightingTableBlue != (u_char (*) [256] [8])0x0) {
    purgememadr(Night_gCopLightingTableBlue);
  }
  Night_gCopLightingTableBlue = (u_char (*) [256] [8])0x0;
  if (Night_gWeatherLightingTable != (u_char (*) [256])0x0) {
    purgememadr(Night_gWeatherLightingTable);
  }
  Night_gWeatherLightingTable = (u_char (*) [256])0x0;
  if (D_8013D9F4 != (u_char (*) [256])0x0) {
    purgememadr(D_8013D9F4);
  }
  D_8013D9F4 = (u_char (*) [256])0x0;
  return;
}

/* ---- Night_RestartNightDriving__Fv  [NIGHT.CPP:723-730] SLD-VERIFIED ---- */
void Night_RestartNightDriving(void)

{
  u_int r;
  
  if ((GameSetup_gData.Weather == 1) && (GameSetup_gData.Time != 0)) {
    Night_gLightning = 0;
    r = random();
    Night_gNextLightning = simGlobal.gameTicks + (r & 0x1ff);
    r = random();
    Night_gEndNextLightning = Night_gNextLightning + (r & 0x31);
    Night_gNextFlicker = Night_gNextLightning;
    Hrz_LightningFlicker(0);
  }
  return;
}

/* ---- Night_SetEnviroment__FP13DRender_tView  [NIGHT.CPP:736-804] SLD-VERIFIED ----
 * NEAR-MISS 8 diffs, COUNT-EXACT 68/68.  ONE register-materialization tie in the
 * camera-flag guard: retail `lw $v0,0x4($v0)` (load dest REUSES its own base = self-temp)
 * + `addiu $v1,$zero,0x80` for the Night_gZNear constant; ours takes `lw v1,4(v0)` +
 * `li v0,128`, i.e. the constant's pseudo wins $v0 and pushes the loaded `.target`
 * pointer to $v1.  SYM block @43c9fa: fsize 24, mask $80010000 (s0 + ra only), Vi
 * REGPARM $10 = s0, and NO named locals at all -- so there is nothing left to wire in
 * (the `int mode;` here is an unused recon leftover; deleting it is diff-neutral, kept
 * only to document that it is not the lever).
 * STRONG FLOOR (w39-a9): 7 alternate source forms, ALL byte-identical at 8 diffs --
 * delete `mode` (8) · named `u_char *target` local before the guard (8) · same local
 * declared before the Night_gZNear store (8) · `(char *)`-based byte cast (8) ·
 * Night_gZNear store hoisted above the two shift stores (16, worse) · store folded into
 * the guard via a comma expression (11 at 69 insns, worse) · plus -G8 and all four wired
 * per-TU codegen flags (no_split_addresses 31, no_schedule_insns 33, no_schedule_insns2
 * 22, no_strength_reduce 8 -- all >= current).  Prototype re-checked vs the raw oracle:
 * single REGPARM $a0 (Vi), VOID return ($v0 holds the last guard byte at the exit). */
/* NEAR-MISS 8 diffs, COUNT-EXACT 68/68 (w40-a9): a $v0/$v1 rotation on the
 * `Camera_gInfo[Vi->player].target` load -- ours `lw $v1,4($v0)` (separate temp) + `li
 * $v0,128`, retail `lw $v0,4($v0)` (SELF-temp, dest reuses the just-computed base) + `li
 * $v1,128`.  Falsified: hoisting `Night_gZNear = 0x80;` above the two shift assignments
 * (16, worse), and two other spellings of the target byte read (`((u_char*)t)[0x447]`,
 * `*(u_char*)((char*)t+0x447)`) -- both byte-identical at 8.  Sec.3.15 scratch-register
 * tie-break class. */
void Night_SetEnviroment(DRender_tView *Vi)

{
  int mode;
  
  if (GameSetup_gData.Time != 0) {
    Night_gDrawLightning = '\0';
    Night_gCurrentNightColor = Night_gPlayerLightingTable;
    if ((GameSetup_gData.Weather == 1) &&
       (Night_PauseLightningEffect(Vi->player), Vi->player == 0)) {
      Night_DoLightningEffect(Vi);
    }
    Night_gXDistShift = 10;
    Night_gZDistShift = 0xc;
    Night_gZNear = 0x80;
    if ((*((u_char *)Camera_gInfo[Vi->player].target + 0x447) & 4) != 0) {
      Night_gZDistShift = 0xd;
      Night_gXDistShift = 0xb;
    }
    if (Camera_GetMode(Vi->player) == 0) {
      Night_gZNear = -0x200;
    }
    Night_gXDist = 1 << (Night_gXDistShift);
    Night_gZDist = 1 << (Night_gZDistShift);
    Night_gZDistShift = Night_gZDistShift + -6;
    Night_gXDistShift = Night_gXDistShift + -5;
  }
  return;
}

/* ---- Night_AdditiveNightCalc__FP6VECTORP7CVECTOR  [NIGHT.CPP:811-861] SLD-VERIFIED ----
 * NEAR-MISS 77 diffs (ours 65 / oracle 64).  The ONE extra instruction is a copy of the
 * `color` parameter out of its home register (`addu $t3,$a1,zero` at insn 1): our build
 * gives `xdist` $a1 -- which IS color's home -- so color has to be relocated, and that
 * one decision rotates the whole body.  Retail keeps color in $a1 for the entire
 * function and puts xdist in $a2 (SYM: xdist $6, zfar $6, newB $6, z $3/v1, x $4/a0,
 * znear $7/a3, newR $7, newG $8/t0, index/lookup $2/v0, addColor $3).
 * FALSIFIED (11 shapes, every one re-gates to exactly 77/65 -- byte-identical output):
 * znear/zfar before z; z between them; decl-with-init; xdist before x; zfar-before-znear
 * decl order; z-after-index decl order; `z > znear`; `x > -xdist`; both; `zfar > z`;
 * and swapping the two halves of the `index` expression (81, worse).
 * PROTOTYPE RE-CHECKED against the SYM: 2 REGPARM args (v $4, color $5), void return,
 * fsize 0 / mask 0 (true leaf, which we reproduce).
 * w41-a7: 77 -> 71 via the in-place `x = x + xdist;` (see below), and the -dg/-dl dumps
 * now give the exact mechanism for the rest.  Allocation order (global.c priority
 * floor_log2(refs)*refs/live_length) is  x(4 refs/10 = 0.80) > xdist(4/11 = 0.73) >
 * z(4/16 = 0.50) = zfar(2/4 = 0.50) > znear(4/17) > ... > color(7 refs/120 = 0.117,
 * SECOND-TO-LAST).  Two consequences, and they are the whole 71:
 *  - `v` (allocno 80) carries "preferences: 3 4" ($v1 + its own $a0 home), and
 *    find_reg SKIPS any hard reg a CONFLICTING allocno prefers, so every allocno that
 *    conflicts with `v` (z, zfar, znear, xdist...) is pushed off $v1 and $a0.  x does
 *    NOT conflict with v, so x -- allocated first -- takes $v1.  Retail has x in $a0 and
 *    z in $v1, i.e. retail allocated z BEFORE x; ours cannot, because 4/16 < 4/10.
 *  - with $v1/$a0 skipped, zfar and xdist both land on $a1 -- which is `color`'s
 *    parameter home -- so color, allocated almost last, is evicted to $t3 and pays the
 *    ONE extra instruction (`addu $t3,$a1,zero` at insn 1).  color cannot win $a1 by
 *    priority (it would need >30 refs) and it carries no $a1 preference in our RTL.
 * FALSIFIED this wave on top of the 11 earlier shapes: in-place `z = z - znear;` (83),
 * both in-place (75), and hoisting `x` to the outer block (77).
 * The open route is making `z`'s allocno outrank `x`'s (shorten z's live range below 10
 * insns or lengthen x's past 16) WITHOUT adding instructions -- everything tried so far
 * moves refs, which moves priority the wrong way. */
void Night_AdditiveNightCalc(VECTOR *v,CVECTOR *color)

{
  int z;
  int index;
  int znear;
  int zfar;

  z = v->vz;
  znear = Night_gZNear;
  zfar = znear + (1 << (Night_gZDistShift + 6));
  if ((znear < z) && (z < zfar)) {
    int x;
    int xdist;

    x = v->vx;
    xdist = 1 << (Night_gXDistShift + 5);
    if ((-xdist < x) && (x < xdist)) {
      int lookup;
      short newR;
      short newG;
      short newB;
      long addColor;

      /* `x` is mutated IN PLACE: the oracle's `addu $a0,$a0,$a2` reuses x's own
         register for the sum (catalog in-place-mutation lever); the two-operand
         form inside the index expression picks a fresh destination. (77 -> 71) */
      x = x + xdist;
      index = (((z - znear) >> Night_gZDistShift) << 6) + (x >> Night_gXDistShift);
      addColor = *(long *)&Night_gAdditiveHeadlightColor[(u_char)Night_gNightTbl[index]];
      lookup = (int)addColor;
      newR = (short)(color->r + (lookup & 0xff));
      newG = (short)(color->g + ((lookup & 0xff00) >> 8));
      newB = (short)(color->b + (((u_int)lookup >> 0x10) & 0xff));
      if (0xff < newR) newR = 0xff;
      if (0xff < newG) newG = 0xff;
      if (0xff < newB) newB = 0xff;
      color->r = (u_char)newR;
      color->g = (u_char)newG;
      color->b = (u_char)newB;
    }
  }
  return;
}

/* end of night.cpp */
