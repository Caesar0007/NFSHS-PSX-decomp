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
u_char       (*Night_gWeatherLightingTable[2])[256];   /* @0x8013d9f0  (bss(zero)) */
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
u_char       (*Night_gCopColor[2])[256][8];   /* @0x8013da4c  (bss(zero)) */
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
long         Night_gWeatherColor[2];   /* @0x8013da88  (bss(zero)) */
tNightInitCache *gNightInitCache;   /* @0x8013da90  (bss(zero)) */
tCompRGB     *gTableCache;   /* @0x8013da94  (bss(zero)) */
char         *nightfile;   /* @0x8013da98  (bss(zero)) */


/* ---- Night_FindClosestColor__FG7CVECTORPi  [NIGHT.CPP:134-175] SLD-VERIFIED ---- */
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
  int search;
  tCompRGB *p;

  colorMatchr = colorMatch.r;
  colorMatchg = colorMatch.g;
  colorMatchb = colorMatch.b;
  search = 1;
  maxLights = Night_gTotalLights + 1;
  searchColorr = (u_char)gTableCache->r;
  searchColorg = (u_char)gTableCache->g;
  searchColorb = (u_char)gTableCache->b;
  bestDiff = 0x2fa03;
  if (1 < maxLights) {
    p = gTableCache + 1;
    do {
      diffR = colorMatchr - searchColorr;
      diffG = colorMatchg - searchColorg;
      diffB = colorMatchb - searchColorb;
      searchColorr = (u_char)p->r;
      searchColorg = (u_char)p->g;
      searchColorb = (u_char)p->b;
      diffSum = diffR * diffR + diffG * diffG + diffB * diffB;
      if (diffSum < bestDiff) {
        *bestIndex = search + -1;
        bestDiff = diffSum;
        if (diffSum < 0x40) {
          return diffSum;
        }
      }
      search = search + 1;
      p = p + 1;
    } while (search < maxLights);
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
/* NEAR-MISS 8 diffs (29/29): oracle: `andi v0,v0,0x7ff; lw v1,%lo(simGlobal.gameTicks)(v1); addiu v0,v0,31`
 * (keeps random result in v0 for +31). Ours: `addiu v1,v1,31` (adds +31 to gameTicks instead).
 * Both produce the same sum; difference is which operand gets +31. Load-delay scheduling +
 * register assignment floor — tried 2 levers (explicit grouping worsens to 12, original 8). ACCEPT. */
void Night_GenerateNextLightningEvent(void)

{
  u_int r;
  int fork;

  r = random();
  Night_gNextLightning = simGlobal.gameTicks + (r & 0x7ff) + 0x1f;
  r = random();
  Night_gEndNextLightning = Night_gNextLightning + (r & 0xf) + 0xf;
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
  track = GameSetup_gData.track;
  pause_flag = 0;
  startp = Night_gLightningPauseAreas[track][0];
  endp = Night_gLightningPauseAreas[track][1];
  if (startp < slice) {
    pause_flag = slice < endp;
  }
  if (GameSetup_gData.Weather != 1) {
    pause_flag = 1;
  }
  if (pause_flag != 0) {
    Night_gNextLightning = simGlobal.gameTicks;
    Night_gEndNextLightning = simGlobal.gameTicks;
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

/* ---- Night_SetCopColor__FP18GameSetup_tCarData  [NIGHT.CPP:473-484] SLD-VERIFIED ---- */
void Night_SetCopColor(GameSetup_tCarData *carinfo)

{
  u_char*copColors[2][256][8];
  int cartype;
  int country;
  int col1;
  int col2;
  u_char (*carTable[4])[256][8];

  carTable[2] = Night_gCopLightingTableRed;
  carTable[3] = Night_gCopLightingTableBlue;
  carTable[0] = Night_gCopLightingTableRed;
  carTable[1] = Night_gCopLightingTableBlue;
  cartype = Night_gCopCarTypeColorIdx[carinfo->carType];
  country = carinfo->Country;
  col1 = (u_char)Night_gCopCountryLightTbl[cartype][country][0];
  Night_gCopColor[0] = carTable[col1];
  col2 = (u_char)Night_gCopCountryLightTbl[cartype][country][1];
  Night_gCopColor[1] = carTable[col2];
  return;
}

/* ---- Night_InitPlayerHeadLightColor__Fi  [NIGHT.CPP:488-496] SLD-VERIFIED ---- */
void Night_InitPlayerHeadLightColor(int player)

{
  
  if (Night_gPlayerLightingTable == (u_char (*) [256] [16])0x0) {
    Night_gPlayerLightingTable = reservememadr("plnight",0x1000,0);
  }
  *(CVECTOR *)(Night_gPlayerHeadLightColor + player) = TrackSpec_gSpec.nightspec.nightcolor;
  return;
}

/* ---- Night_SetPlayerHeadLightColor__Fiii  [NIGHT.CPP:501-503] SLD-VERIFIED ---- */
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
void Night_InitWeatherTables(void)

{
  void *alloc_buf;
  u_char *tbl_walk;
  int i;
  
  i = 0;
  tbl_walk = (u_char *)Night_gWeatherLightingTable;
  do {
    if (*(int *)tbl_walk == 0) {
      alloc_buf = reservememadr("wtnight",0x100,0);
      *(void **)tbl_walk = alloc_buf;
    }
    i = i + 1;
    tbl_walk = tbl_walk + 4;
  } while (i < 2);
  Night_gWeatherColor[0] = 0x574054;
  Night_gWeatherColor[1] = 0x6c4040;
  return;
}

/* ---- Night_SetWeatherColors__Fi  [NIGHT.CPP:544-546] SLD-VERIFIED ---- */
/* NEAR-MISS 8 diffs (31/31): oracle loads Night_gWeatherColor → s1 via `lui s1; addiu s1,s1,lo`
 * (destination = source in addiu). Ours: `lui v0; addiu s1,v0,lo` (v0 temp for high part).
 * Same pattern for Night_gWeatherLightingTable → s0. Register coloring floor — tried 3 levers
 * (restructure body, reversed init order, original). ACCEPT. */
void Night_SetWeatherColors(int colorIndex)

{
  long colorH;
  u_char (*wtbl) [256];
  u_char (**wtblp) [256];
  long *color_walk;
  int i;

  i = 0;
  color_walk = Night_gWeatherColor;
  wtblp = Night_gWeatherLightingTable;
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
    Night_gNextLightning = simGlobal.gameTicks + (r & 0x1ff);
    r = random();
    Night_gEndNextLightning = Night_gNextLightning + (r & 0x31);
    Night_gNextFlicker = Night_gNextLightning;
    Hrz_CalculateLightning();
  }
  return;
}

/* ---- Night_KillNightDriving__Fv  [NIGHT.CPP:687-719] SLD-VERIFIED ---- */
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
  if (Night_gWeatherLightingTable[0] != (u_char (*) [256])0x0) {
    purgememadr(Night_gWeatherLightingTable[0]);
  }
  Night_gWeatherLightingTable[0] = (u_char (*) [256])0x0;
  if (Night_gWeatherLightingTable[1] != (u_char (*) [256])0x0) {
    purgememadr(Night_gWeatherLightingTable[1]);
  }
  Night_gWeatherLightingTable[1] = (u_char (*) [256])0x0;
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
    if ((Camera_gInfo[Vi->player].target[1].shadowCoord[2].y & 0x4000000) != 0) {
      Night_gZDistShift = 0xd;
      Night_gXDistShift = 0xb;
    }
    mode = Camera_GetMode(Vi->player);
    if (mode == 0) {
      Night_gZNear = -0x200;
    }
    Night_gXDist = 1 << (Night_gXDistShift & 0x1fU);
    Night_gZDist = 1 << (Night_gZDistShift & 0x1fU);
    Night_gZDistShift = Night_gZDistShift + -6;
    Night_gXDistShift = Night_gXDistShift + -5;
  }
  return;
}

/* ---- Night_AdditiveNightCalc__FP6VECTORP7CVECTOR  [NIGHT.CPP:811-861] SLD-VERIFIED ---- */
void Night_AdditiveNightCalc(VECTOR *v,CVECTOR *color)

{
  int z;
  int index;
  int znear;
  int zfar;
  int x;
  int xdist;
  int lookup;
  short newR;
  short newG;
  short newB;
  long addColor;

  z = v->vz;
  znear = Night_gZNear;
  zfar = 1 << (Night_gZDistShift + 6 & 0x1fU);
  if ((znear < z) && (z < znear + zfar)) {
    x = v->vx;
    xdist = 1 << (Night_gXDistShift + 5 & 0x1fU);
    if ((-xdist < x) && (x < xdist)) {
      index = (((z - znear) >> Night_gZDistShift) << 6) + ((x + xdist) >> Night_gXDistShift);
      addColor = *(long *)&Night_gAdditiveHeadlightColor[(u_char)Night_gNightTbl[index]];
      lookup = (int)addColor;
      newR = (short)(color->r + (lookup & 0xff));
      if (0xff < newR) newR = 0xff;
      newG = (short)(color->g + ((lookup & 0xff00) >> 8));
      if (0xff < newG) newG = 0xff;
      newB = (short)(color->b + ((lookup >> 0x10) & 0xff));
      if (0xff < newB) newB = 0xff;
      color->r = (u_char)newR;
      color->g = (u_char)newG;
      color->b = (u_char)newB;
    }
  }
  return;
}

/* end of night.cpp */
