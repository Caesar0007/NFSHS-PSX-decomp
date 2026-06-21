/* game/common/hudpmx.cpp -- RECONSTRUCTED (NFS4 HUD pixmap/shape loader; C++ TU).
 *   3 free fns: HudPmx_LoadShape (locate+LoadPmx a HUD shape), HudPmx_InitTextures (build the
 *   HUD glyph/icon texture set), HudPmx_Kill. GTE-free.
 */
#include "../../nfs4_types.h"
#include "hudpmx_externs.h"

/* ---- HudPmx.obj OWNED globals ($gp state) ---- */
char  *gHudFont;        /* 0x8013dda4 */
char  *gShpfile;        /* 0x8013dda8 */
char   loadShapeXOff;   /* 0x8013ddac */
/* Note: the two patchable HUD shape-name buffers @0x8013cd34/0x8013cd3c are the SYM STAT locals
   `alph` (char[5]="alpX"), materialized as scoped statics inside InitTextures; the other 8 names
   (alTR/alCI/.. @0x8013cd44+) are anonymous .rodata strings -> emitted as string literals. */
/* ---- HudPmx.obj OWNED data tables ---- */
HudPmx_tUV     HudPmx_gHudNumberUV[10];   /* 0x80110c70 */
HudPmx_tShape  HudPmx_gShapes[175];        /* 0x80110c98 */

/* ---- intra-TU forward declarations ---- */
void HudPmx_LoadShape(char *n,Draw_tPixMap *s);
void HudPmx_InitTextures(void);
void HudPmx_Kill(void);


/* ---- HudPmx_LoadShape__FPcP13HudPmx_tShape  [HUDPMX.CPP:24-36] SLD-VERIFIED ---- */
void HudPmx_LoadShape(char *n,Draw_tPixMap *s)

{
  u_short uVar1;
  void *shp;
  
  shp = locateshape(gShpfile,n);
  uVar1 = *(u_short *)((int)shp + 4);
  s[1].u0 = (char)uVar1;
  s[1].v0 = (char)((u_short)uVar1 >> 8);
  s[1].clut = *(u_short *)((int)shp + 6);
  Texture_LoadPmx(gShpfile,n,0x41,loadShapeXOff + 0x80,0x80,-1,-1,s);
  return;
}

/* ---- HudPmx_InitTextures__Fv  [HUDPMX.CPP:40-204] SLD-VERIFIED ---- */
void HudPmx_InitTextures(void)

{
  char * carType0;
  char * carType1;
  char * name;
  int i;
  char ** tachs;
  int ntachs;
  char * mapname;
  HudPmx_tShape * shapes;
  int u;
  int v;
  int w;
  int h;
  int yo;
  u_char **ppuVar1;
  void *pvVar2;
  u_int *puVar3;
  char **ppcVar4;
  u_int uVar5;
  u_char *puVar6;
  char *pcVar7;
  u_char *puVar8;
  char *pcVar9;
  u_char *puVar10;
  char *pcVar11;
  HudPmx_tUV *pHVar12;
  HudPmx_tShape *pHVar13;
  int iVar14;
  int iVar15;
  int iVar16;
  char acStack_648 [256];
  u_int local_548 [30];
  u_int local_4d0 [30];
  char acStack_458 [8];
  u_int local_450 [74];
  u_int local_328 [55];
  char *local_24c;
  char *local_244;
  char *local_240 [132];
  uchar local_30 [4];
  uchar local_2c [4];
  u_char auStack_28 [4];
  u_char auStack_24 [4];
  u_char auStack_20 [8];
  
  puVar3 = local_548;
  ppuVar1 = (u_char **)&Track_gShapeNamePtrs;
  do {
    puVar6 = ppuVar1[1];
    puVar8 = ppuVar1[2];
    puVar10 = ppuVar1[3];
    *puVar3 = *ppuVar1;
    puVar3[1] = puVar6;
    puVar3[2] = puVar8;
    puVar3[3] = puVar10;
    ppuVar1 = ppuVar1 + 4;
    puVar3 = puVar3 + 4;
  } while (ppuVar1 != (u_char **)&Track_gShapeNamePtrs_end);
  *puVar3 = (u_char *)Track_gShapeNamePtrs_end;
  puVar3 = local_4d0;
  ppuVar1 = (u_char **)&Track_gTachNamePtrs;
  do {
    puVar6 = ppuVar1[1];
    puVar8 = ppuVar1[2];
    puVar10 = ppuVar1[3];
    *puVar3 = *ppuVar1;
    puVar3[1] = puVar6;
    puVar3[2] = puVar8;
    puVar3[3] = puVar10;
    ppuVar1 = ppuVar1 + 4;
    puVar3 = puVar3 + 4;
  } while (ppuVar1 != gShapeNamePtrs_subList + 3);
  *puVar3 = gShapeNamePtrs_subList[3];
  sprintf(acStack_458,"mp%02d",GameSetup_gData.track);
  puVar3 = local_450;
  ppcVar4 = local_240;
  local_240[0] = "cmra";
  local_240[1] = "cam0";
  local_240[2] = "cam1";
  local_240[3] = "cam2";
  local_240[4] = "cam3";
  local_240[5] = "cam4";
  local_240[6] = "cam5";
  local_240[7] = "cam6";
  local_240[8] = "cam7";
  local_240[9] = "cam8";
  local_240[10] = "cam9";
  local_240[0xb] = "ca10";
  local_240[0xc] = "ca11";
  local_240[0xd] = "ca12";
  local_240[0xe] = "crn1";
  local_240[0xf] = "crn2";
  local_240[0x10] = "crn3";
  local_240[0x11] = "crn4";
  local_240[0x12] = "arrl";
  local_240[0x13] = "arrr";
  local_240[0x14] = "mwt1";
  local_240[0x15] = "mwt2";
  local_240[0x16] = "mwb1";
  local_240[0x17] = "mwb2";
  local_240[0x18] = "msid";
  local_240[0x19] = "msi2";
  local_240[0x1a] = "kmhh";
  local_240[0x1b] = "mphh";
  local_240[0x1c] = "gea1";
  local_240[0x1d] = "gea2";
  local_240[0x1e] = "gea3";
  local_240[0x1f] = "gea4";
  local_240[0x20] = "gea5";
  local_240[0x21] = "gea6";
  local_240[0x22] = "smln";
  local_240[0x23] = "smlr";
  local_240[0x24] = "pau0";
  local_240[0x25] = "pau1";
  local_240[0x26] = "pau2";
  local_240[0x27] = "pau3";
  local_240[0x28] = "rwid";
  local_240[0x29] = "rwi2";
  local_240[0x2a] = "rsid";
  local_240[0x2b] = "rsi2";
  local_240[0x2c] = "big0";
  local_240[0x2d] = "big1";
  local_240[0x2e] = "big2";
  local_240[0x2f] = "big3";
  local_240[0x30] = "big4";
  local_240[0x31] = "big5";
  local_240[0x32] = "big6";
  local_240[0x33] = "big7";
  local_240[0x34] = "big8";
  local_240[0x35] = "big9";
  local_240[0x36] = "sml1";
  local_240[0x37] = "sml2";
  local_240[0x38] = "sml3";
  local_240[0x39] = "sml4";
  local_240[0x3a] = "sml5";
  local_240[0x3b] = "sml6";
  local_240[0x3c] = "321d";
  local_240[0x3d] = "321l";
  local_240[0x3e] = "mpbt";
  local_240[0x3f] = "smlx";
  local_240[0x40] = "sml+";
  local_240[0x41] = "sml-";
  local_240[0x42] = "sml:";
  local_240[0x43] = "sml\"";
  local_240[0x44] = "sml\'";
  local_240[0x45] = "sml,";
  local_240[0x46] = "sml.";
  local_240[0x47] = "sml/";
  local_240[0x48] = "ahyp";
  local_240[0x49] = "acol";
  local_240[0x4a] = "a192";
  local_240[0x4b] = "a193";
  local_240[0x4c] = "a194";
  local_240[0x4e] = "a196";
  local_240[0x4f] = "a197";
  local_240[0x51] = "a199";
  local_240[0x52] = "a200";
  local_240[0x53] = "a201";
  local_240[0x55] = "a203";
  local_240[0x56] = "a204";
  local_240[0x57] = "a205";
  local_240[0x58] = "a206";
  local_240[0x59] = "a207";
  local_240[0x5b] = "a209";
  local_240[0x5c] = "a210";
  local_240[0x5d] = "a211";
  local_240[0x5e] = "a212";
  local_240[0x60] = "a214";
  local_240[99] = "a217";
  local_240[0x4d] = "wrng";
  local_240[0x50] = "wrng";
  local_240[0x54] = "wrng";
  local_240[0x5a] = "wrng";
  local_240[0x5f] = "wrng";
  local_240[0x61] = "wrng";
  local_240[0x62] = "wrng";
  local_240[100] = "a218";
  local_240[0x65] = "a219";
  local_240[0x66] = "a220";
  local_240[0x67] = "A229";
  local_240[0x69] = "time";
  local_240[0x6a] = "timb";
  local_240[0x6b] = "laps";
  local_240[0x6c] = "ejct";
  local_240[0x6d] = "play";
  local_240[0x6e] = "paus";
  local_240[0x6f] = "resg";
  local_240[0x70] = "rad0";
  local_240[0x71] = "rad1";
  local_240[0x72] = "s1/4";
  local_240[0x73] = "s1/2";
  local_240[0x74] = "spd2";
  local_240[0x75] = "spd1";
  local_240[0x76] = "plus";
  local_240[0x77] = "minu";
  local_240[0x79] = "plr1";
  local_240[0x7a] = "oppn";
  local_240[0x7b] = "barl";
  local_240[0x7c] = "barr";
  local_240[0x7d] = "barb";
  local_240[0x7e] = "baXl";
  local_240[0x7f] = "baXr";
  local_240[0x80] = "tacc";
  local_240[0x68] = "wrng";
  local_240[0x78] = acStack_458;
  local_240[0x82] = "tpno";
  local_240[0x81] = (char *)local_548[0];
  local_240[0x83] = (char *)local_548[0];
  do {
    pcVar7 = ppcVar4[1];
    pcVar9 = ppcVar4[2];
    pcVar11 = ppcVar4[3];
    *puVar3 = *ppcVar4;
    puVar3[1] = pcVar7;
    puVar3[2] = pcVar9;
    puVar3[3] = pcVar11;
    ppcVar4 = ppcVar4 + 4;
    puVar3 = puVar3 + 4;
  } while (ppcVar4 != (char **)local_30);
  loadShapeXOff = 0;
  sprintf(acStack_648,"%sfont.pfn",Paths_Paths[0x1a]);
  gHudFont = loadfileadrz(acStack_648,0);
  Font_LoadFont(gHudFont,0x80,0x80,1);
  pHVar12 = HudPmx_gHudNumberUV;
  for (iVar14 = 0; iVar14 < 10; iVar14 = iVar14 + 1) {
    Font_GetUVWH(iVar14 + 0x30U & 0xff,local_30,local_2c,auStack_28,auStack_24,auStack_20);
    pHVar12->u0 = local_30[0];
    pHVar12->v0 = local_2c[0];
    pHVar12->clut = gFontClut;
    pHVar12 = pHVar12 + 1;
  }
  pvVar2 = (void *)sprintf(acStack_648,"%shud.psh",Paths_Paths[0x1a]);
  loadfileadr(acStack_648,0);
  gShpfile = pvVar2;
  Texture_ResetPaletteSharing();
  if (GameSetup_gData.Time == 0) {
    if (0x1d < GameSetup_gData.carInfo[0].carType) {
      local_24c = "tbon";
    }
    else {
      local_24c = (char *)local_548[GameSetup_gData.carInfo[0].carType];
    }
    if (GameSetup_gData.carInfo[1].carType < 0x1e) {
      local_244 = (char *)local_548[GameSetup_gData.carInfo[1].carType];
      goto HudPmxInit_shapeLoadLoop;
    }
    local_244 = "tbon";
  }
  else {
    if (0x1d < GameSetup_gData.carInfo[0].carType) {
      local_24c = "nbon";
    }
    else {
      local_24c = (char *)local_4d0[GameSetup_gData.carInfo[0].carType];
    }
    if (GameSetup_gData.carInfo[1].carType < 0x1e) {
      local_244 = (char *)local_4d0[GameSetup_gData.carInfo[1].carType];
      goto HudPmxInit_shapeLoadLoop;
    }
    local_244 = "nbon";
  }
HudPmxInit_shapeLoadLoop:
  iVar14 = 0;
  puVar3 = local_450;
  pHVar13 = HudPmx_gShapes;
  do {
    uVar5 = *puVar3;
    puVar3 = puVar3 + 1;
    iVar14 = iVar14 + 1;
    HudPmx_LoadShape(uVar5,(Draw_tPixMap *)pHVar13);
    pHVar13 = pHVar13 + 1;
  } while (iVar14 < 0x83);
  iVar14 = -0x7feee918;
  for (iVar15 = 0x84; iVar15 < 0x9e; iVar15 = iVar15 + 1) {
    { static char alph [5] = "alpX";  /* @0x8013cd34, runtime-patched at [3] */
      alph[3] = (char)iVar15 + -0x43;
      HudPmx_LoadShape(alph,iVar14); }
    iVar14 = iVar14 + 0x14;
  }
  iVar14 = -0x7feee710;
  for (iVar15 = 0x9e; iVar15 < 0xa8; iVar15 = iVar15 + 1) {
    { static char alph [5] = "alpX";  /* @0x8013cd3c, runtime-patched at [3] */
      alph[3] = (char)iVar15 + -0x6e;
      HudPmx_LoadShape(alph,iVar14); }
    iVar14 = iVar14 + 0x14;
  }
  HudPmx_LoadShape("alTR",(Draw_tPixMap *)&HudPmx_gShapes[168] /* @0x801119b8 */);
  HudPmx_LoadShape("alCI",(Draw_tPixMap *)&HudPmx_gShapes[169] /* @0x801119cc */);
  HudPmx_LoadShape("alSQ",(Draw_tPixMap *)&HudPmx_gShapes[170] /* @0x801119e0 */);
  HudPmx_LoadShape("negA",(Draw_tPixMap *)&HudPmx_gShapes[171] /* @0x801119f4 */);
  HudPmx_LoadShape("negB",(Draw_tPixMap *)&HudPmx_gShapes[172] /* @0x80111a08 */);
  HudPmx_LoadShape("neg2",(Draw_tPixMap *)&HudPmx_gShapes[173] /* @0x80111a1c */);
  HudPmx_LoadShape("alUP",(Draw_tPixMap *)&HudPmx_gShapes[174] /* @0x80111a30 */);
  iVar16 = 0;
  puVar3 = local_328;
  iVar14 = 0x128;
  iVar15 = -0x7feeeda0;
  do {
    iVar16 = iVar16 + 1;
    HudPmx_LoadShape(*puVar3,iVar15);
    puVar3 = (u_int *)((int)local_450 + iVar14 + 4);
    iVar14 = iVar14 + 4;
    iVar15 = iVar15 + 0x14;
  } while (iVar16 < 0x1c);
  HudPmx_LoadShape("a229",(Draw_tPixMap *)&HudPmx_gShapes[103] /* @0x801114a4 */);
  HudPmx_LoadShape("ahyp",(Draw_tPixMap *)&HudPmx_gShapes[72] /* @0x80111238 */);
  HudPmx_LoadShape("acol",(Draw_tPixMap *)&HudPmx_gShapes[73] /* @0x8011124c */);
  if (DashHUD_gInfo.splitscreen != 0) {
    loadShapeXOff = 0x16;
    HudPmx_LoadShape(local_244,(Draw_tPixMap *)&HudPmx_gShapes[131] /* @0x801116d4 */);
  }
  purgememadr(gShpfile);
  return;
}

/* ---- HudPmx_Kill__Fv  [HUDPMX.CPP:209-210] SLD-VERIFIED ---- */
void HudPmx_Kill(void)

{
  purgememadr(gHudFont);
  return;
}

/* end of hudpmx.cpp */
