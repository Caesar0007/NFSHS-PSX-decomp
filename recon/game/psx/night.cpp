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

/* ---- Night_CreateNightTableElement__FiliPUc  [NIGHT.CPP:181-231] SLD-VERIFIED ---- */
void Night_CreateNightTableElement(int colorIndex,long colorH,int bright,u_char *colorval)

{
  int sourceR;
  int sourceG;
  int sourceB;
  int chr;
  int chg;
  int chb;
  int newR;
  int newG;
  int newB;
  int b15;
  CVECTOR newColor;
  int bestIndex;
  tCompRGB *p;

  b15 = bright * 0x111;
  p = gTableCache + colorIndex;
  chr = colorH & 0xff;
  chg = (u_int)colorH >> 8 & 0xff;
  chb = (u_int)colorH >> 0x10 & 0xff;
  sourceR = (u_char)p->r;
  newR = sourceR + ((int)(chr * b15) >> 0xc);
  if (0xff < newR) newR = 0xff;
  sourceG = (u_char)p->g;
  newG = sourceG + ((int)(chg * b15) >> 0xc);
  if (0xff < newG) newG = 0xff;
  sourceB = (u_char)p->b;
  newB = sourceB + ((int)(chb * b15) >> 0xc);
  if (0xff < newB) newB = 0xff;
  newColor.r = (u_char)newR & 0xf8;
  newColor.g = (u_char)newG & 0xf8;
  newColor.b = (u_char)newB & 0xf8;
  newColor.cd = 0;
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
  if (((Night_gNextLightning < simGlobal.gameTicks) &&
      (simGlobal.gameTicks < Night_gEndNextLightning)) && (Night_gNextFlicker < simGlobal.gameTicks)
     ) {
    r = random();
    Night_gLightningType = r & 1;
    Hrz_LightningFlicker(1);
    tunnel = BWorldSm_TunnelFlagSm(&Camera_gInfo[Vi->player].slicePos);
    Night_gDrawLightning = tunnel == (void *)0x0;
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
  if (Night_gEndNextLightning < simGlobal.gameTicks) {
    Night_GenerateNextLightningEvent();
    Hrz_CalculateLightning();
    lightningInit = '\x01';
  }
  return;
}

typedef struct { int w[2]; } NightCopTablePair;

/* ---- Night_SetCopColor__FP18GameSetup_tCarData  [NIGHT.CPP:473-484] SLD-VERIFIED ----
 * NEAR-MISS 25 diffs (ours 38 / oracle 37), was 39 (ours 36 / oracle 37).
 * MATCH (w38-a10): (1) cartype/country are read BEFORE the carTable fill
 * (oracle `lw v0,0(a0); lw a1,160(a0); lbu a0,0(v0)` precede the gp loads);
 * (2) the lower half of carTable[] is a two-word BLOCK COPY of the upper half,
 * not two more loads of the globals -- the oracle's `lw a2,8(sp); lw a3,12(sp);
 * sw a2,0(sp); sw a3,4(sp)` is gcc's movstrsi, reproduced with a same-sized
 * local struct assignment (a plain `carTable[0]=carTable[2]` gets copy-forwarded).
 * RESIDUAL: (a) the final two stores -- the oracle writes Night_gCopColor[0] and
 * [1] through SEPARATE per-element gp-rel symbols (%gp_rel(Night_gCopColor) and
 * %gp_rel(D_8013DA50)); ours materializes the 8-byte array base with lui/addiu
 * (+2 insns). The known fix is the per-element scalar split (catalog sec.E
 * dual-model / wave-13 per-field split), but Night_gCopColor is ALSO read with a
 * RUNTIME index by draww.cpp (DrawW cop-lighting lookup, another agent's TU), so
 * the split needs a coordinated dual-model change across both TUs -- NOT done
 * here (out of scope), flagged for a follow-up.  (b) cartype/country land on
 * $a1/$a0 instead of $a0/$a1; tried decl-order swap (no change), statement-order
 * swap (41, worse) and an explicit pointer-form index (39, worse). */
void Night_SetCopColor(GameSetup_tCarData *carinfo)

{
  int cartype;
  int country;
  int col1;
  int col2;
  u_char (*carTable[4])[256][8];

  cartype = Night_gCopCarTypeColorIdx[carinfo->carType];
  country = carinfo->Country;
  carTable[2] = Night_gCopLightingTableRed;
  carTable[3] = Night_gCopLightingTableBlue;
  *(NightCopTablePair *)&carTable[0] = *(NightCopTablePair *)&carTable[2];
  col1 = (u_char)Night_gCopCountryLightTbl[cartype][country][0];
  Night_gCopColor = carTable[col1];
  col2 = (u_char)Night_gCopCountryLightTbl[cartype][country][1];
  D_8013DA50 = carTable[col2];
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
 * with the sibling Night_SetWeatherColors below.  Survives -G8 and all four wired per-TU
 * codegen flags (w39-a9 probe: no_split_addresses +4, no_schedule_insns +6,
 * no_schedule_insns2 +14, no_strength_reduce 0). */
void Night_InitWeatherTables(void)

{
  void *alloc_buf;
  u_char *tbl_walk;
  int i;
  
  i = 0;
  tbl_walk = (u_char *)Night_gWeatherLightingTable_arr;
  do {
    if (*(int *)tbl_walk == 0) {
      alloc_buf = reservememadr("wtnight",0x100,0);
      *(void **)tbl_walk = alloc_buf;
    }
    i = i + 1;
    tbl_walk = tbl_walk + 4;
  } while (i < 2);
  Night_gWeatherColor = 0x574054;
  D_8013DA8C = 0x6c4040;
  return;
}

/* ---- Night_SetWeatherColors__Fi  [NIGHT.CPP:544-546] SLD-VERIFIED ---- */
/* NEAR-MISS 8 diffs (31/31): oracle loads Night_gWeatherColor → s1 via `lui s1; addiu s1,s1,lo`
 * (destination = source in addiu). Ours: `lui v0; addiu s1,v0,lo` (v0 temp for high part).
 * Same pattern for Night_gWeatherLightingTable → s0. Register-materialization tie-break
 * (catalog §E "v0-vs-a2"), not source-shapable: tried &arr[0] form, swapped init order,
 * i=0-after-inits, extra-pointer-then-copy (the exact lever that PASSed
 * Night_GenerateNextLightningEvent) — all no-change or regress (up to 20 diffs). Permuter
 * (short supervised grind, base score 80, 4 iters, no improvement) also didn't crack it.
 * GENUINE FLOOR. ACCEPT. */
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
  static char colorCreationTable[16];
  int colorIndex;
  int bright;
  int i;
  int tbl_off;
  CVECTOR *additive_walk;

  tbl_off = 0;
  gNightInitCache = (tNightInitCache *)&Render_gPalettePtr;
  gTableCache = (tCompRGB *)&Render_gPalettePtr;
  Night_gTotalLights = Chunk_numLight;
  i = 0;
  do {
    (&gTableCache->r)[tbl_off] = Chunk_lightTable[i].r;
    (&gTableCache->g)[tbl_off] = Chunk_lightTable[i].g;
    (&gTableCache->b)[tbl_off] = Chunk_lightTable[i].b;
    tbl_off = tbl_off + 3;
    i = i + 1;
  } while (i < 0x100);
  for (colorIndex = 0; colorIndex < Night_gTotalLights; colorIndex = colorIndex + 1) {
    bright = 0;
    if (GameSetup_gData.Weather == 1) {
      Night_SetWeatherColors(colorIndex);
      bright = 0;
    }
    for (; bright < 0x10; bright = bright + 1) {
      Night_SetPlayerHeadLightColor(0,colorIndex,bright);
      if ((GameSetup_gData.cops != 0) && (bright < 8)) {
        Night_SetCopLightColors(colorIndex,bright);
      }
    }
  }
  tbl_off = 0;
  i = 0;
  do {
    Chunk_lightTable[i].r = (&gTableCache->r)[tbl_off];
    Chunk_lightTable[i].g = (&gTableCache->g)[tbl_off];
    Chunk_lightTable[i].b = (&gTableCache->b)[tbl_off];
    tbl_off = tbl_off + 3;
    i = i + 1;
  } while (i < 0x100);
  i = 0;
  additive_walk = Night_gAdditiveHeadlightColor;
  do {
    additive_walk->r = (u_char)((int)((u_int)(u_char)Night_gPlayerHeadLightColor[0] * i) / 0xf);
    additive_walk->g =
         (u_char)((int)((u_int)*(u_char *)((char *)Night_gPlayerHeadLightColor + 1) * i) / 0xf);
    additive_walk->b =
         (u_char)((int)((u_int)*(u_char *)((char *)Night_gPlayerHeadLightColor + 2) * i) / 0xf);
    i = i + 1;
    additive_walk = additive_walk + 1;
  } while (i < 0x10);
  return;
}

/* ---- Night_InitNightDriving__Fv  [NIGHT.CPP:631-680] SLD-VERIFIED ---- */
void Night_InitNightDriving(void)

{
  char *mem;
  int sz;
  void *shp;
  u_int r;
  char name [256];

  gNight_renderNight = 0;
  if (GameSetup_gData.Time != 0) {
    gNight_renderNight = (int)(GameSetup_gData.commMode != 1);
    if (gNight_renderNight == 0) {
      TrackSpec_gSpec.depthcuespec.distance = 0xff;
      TrackSpec_gSpec.depthcuespec.color.r = '\0';
      TrackSpec_gSpec.depthcuespec.color.g = '\0';
      TrackSpec_gSpec.depthcuespec.color.b = '\0';
      TrackSpec_gSpec.depthcuespec.color.cd = '\0';
    }
  }
  if (gNight_renderNight == 0) {
    return;
  }
  sprintf(name,"%snight.psh",Paths_Paths[0x19]);
  sz = filesize(name);
  nightfile = (char *)reservememadr("night.psh",sz,0);
  shp = (void *)loadshapeadr(name,(void *)0x0);
  sz = filesize(name);
  blockmove(shp,nightfile,sz);
  purgememadr(shp);
  mem = (char *)locateshape(nightfile,"nght",sz);
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
    r = random();
    Night_gNextLightning = D_8011E0B0[0] + (r & 0x1ff);
    r = random();
    Night_gEndNextLightning = Night_gNextLightning + (r & 0x31);
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

/* ---- Night_SetEnviroment__FP13DRender_tView  [NIGHT.CPP:736-804] SLD-VERIFIED ---- */
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
 * NEAR-MISS 77 diffs (ours 65 / oracle 64), was 106 (ours 66 / oracle 64).
 * MATCH (w38-a10), all from the SYM block @43cab4 + the raw oracle:
 *  (1) SYM BLOCK SCOPES restored: {x,xdist} live in the z-guard block and
 *      {lookup,newR,newG,newB,addColor} in the x-guard block -- xdist REUSES
 *      zfar's register ($6) exactly because they are in disjoint blocks.
 *  (2) `zfar` holds znear + (1<<(gZDistShift+6)), i.e. the sum is computed
 *      SPECULATIVELY before the first guard (oracle `addu a2,a3,v0` precedes
 *      `slt v0,a3,v1; beqz`), not folded into the second compare.
 *  (3) the three channel SUMS are computed first, then the three clamps
 *      (oracle batches `addu`+copy trios then three slti/bnez/li 255).
 *  (4) the blue channel shift is LOGICAL: `((u_int)lookup >> 0x10) & 0xff`
 *      (oracle `srl`, not `sra`) -- a signed `int` shift emitted `sra`.
 * RESIDUAL (1 insn over + coloring): ours copies the `color` REGPARM out of
 * $a1 into $t3 because {zfar,xdist} win $a1, and newR/newG swap $a3<->$t0
 * (SYM: newR $7=a3, newG $8=t0, newB $6=a2). Tried: inlining zfar into the
 * condition (88), materializing zfar before z/znear (79), znear-before-z (77,
 * tie). This is the allocno-priority race between the short-lived guard temps
 * and the long-lived, few-ref `color` parameter. */
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

      index = (((z - znear) >> Night_gZDistShift) << 6) + ((x + xdist) >> Night_gXDistShift);
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
