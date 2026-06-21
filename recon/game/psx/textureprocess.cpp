/* game/psx/textureprocess.cpp -- RECONSTRUCTED (NFS4 PSX color-CLUT + fog + world-color; C++ TU)
 *   16 fns: TextureProcess_* (translucency/CLUT depth-color), Fog_* (keyframe fog triggers),
 *   CV_* (world-color vertex processing). No GTE.
 */
#include "../../nfs4_types.h"
#include "textureprocess_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
BWorldSm_Pos *fogslicePos;
FogKey *Fog_gHeadKey;
TP_ZPaletteSystem TP_gZPaletteSystem;
int Fog_gNumKeys;
int gZDepth;

/* Fog_MakeTrackPathName function-local static string buffer (SYM STAT fogstrspc) */
static char fogstrspc[256];


/* ---- TextureProcess_TransColorCheck__FPci  [TEXTUREPROCESS.CPP:47-62] SLD-VERIFIED ---- */
int TextureProcess_TransColorCheck(char *data,int numentry)

{
  u_short uVar1;
  int translucent_flag;
  
  translucent_flag = 0;
  while (numentry = numentry + -1, numentry != -1) {
    uVar1 = *(u_short *)data;
    data = (char *)((int)data + 2);
    translucent_flag = translucent_flag | (u_int)(0x8000 < uVar1);
  }
  return translucent_flag;
}

/* ---- TextureProcess_ColorClut__FiiPciii  [TEXTUREPROCESS.CPP:356-410] SLD-FLAG:NONMONO ---- */
void TextureProcess_ColorClut(int level,int maxlevel,char *data,int numentry,int cx,int cy)
{
  short newdata [256];
  char *sourcedata;
  short *p;
  int contrasttemp;
  int j;
  u_short color;
  int r;
  int g;
  int b;
  int temp;
  int rawr;
  int rawg;
  int rawb;

  sourcedata = data;
  j = 0;
  p = newdata;
  contrasttemp = (TrackSpec_gSpec.fogspec.contrast * level) / (maxlevel + -1);
  while (j < numentry) {
    color = *(u_short *)sourcedata;
    if (color == 0) {
      *p = 0;
    }
    else {
      rawb = (color >> 7) & 0xf8;
      rawg = (color >> 2) & 0xf8;
      rawr = (color & 0x1f) * 8;
      temp = fixedmult(rawr - TrackSpec_gSpec.fogspec.color.r,contrasttemp);
      r = rawr - temp;
      if (r < 0) { r = 0; } else if (0xff < r) { r = 0xff; }
      temp = fixedmult(rawg - TrackSpec_gSpec.fogspec.color.g,contrasttemp);
      g = rawg - temp;
      if (g < 0) { g = 0; } else if (0xff < g) { g = 0xff; }
      temp = fixedmult(rawb - TrackSpec_gSpec.fogspec.color.b,contrasttemp);
      b = rawb - temp;
      if (b < 0) { b = 0; } else if (0xff < b) { b = 0xff; }
      if (b < 8) { b = 8; }                          /* keep a minimum blue so the pixel stays visible */
      *p = (color & 0x8000) | (short)(((b >> 3) & 0x1f) << 10) |
           (short)(((g >> 3) & 0x1f) << 5) | (short)((r >> 3) & 0x1f);
    }
    sourcedata = sourcedata + 2;
    p = p + 1;
    j = j + 1;
  }
  {
    RECT r;                          /* SYM names the blit rect `r`, block-scoped (shadows the loop's int r) */
    r.x = (short)cx;
    r.w = (short)numentry;
    r.y = (short)cy;
    r.h = 1;
    LoadImage(&r,(u_long *)newdata);
  }
}

/* ---- TextureProcess_DepthColorCluts__FPci  [TEXTUREPROCESS.CPP:422-462] SLD-VERIFIED ---- */
int TextureProcess_DepthColorCluts(char *data,int numentry)
{
  int i;
  int cx;
  int cy;
  int ret;

  DrawSync(0);
  i = 0;
  while (i < 0x10) {
    Texture_GetClutId(0x10 < numentry,&cx,&cy);
    gClutDepth[TP_gZPaletteSystem.numdepthclut][i] = (short)((cy << 6) | ((cx >> 4) & 0x3f));
    TextureProcess_ColorClut(i,0x10,data,numentry,cx,cy);
    i = i + 1;
  }
  ret = TP_gZPaletteSystem.numdepthclut;
  TP_gZPaletteSystem.numdepthclut = ret + 1;
  return ret;
}

/* ---- Fog_CheckRange__FiP6FogKey  [TEXTUREPROCESS.CPP:639-661] SLD-VERIFIED ---- */
FogKey * Fog_CheckRange(int currentslice,FogKey *fkey)

{
  FogKey *keynext;
  FogKey *pFVar1;
  int iVar2;
  int iVar3;
  
  keynext = fkey->next;
  iVar2 = (int)fkey->slice;
  iVar3 = (int)keynext->slice;
  if (iVar3 < iVar2) {
    if ((iVar2 <= currentslice) || (pFVar1 = (FogKey *)0x0, currentslice < iVar3)) {
      return fkey;
    }
  }
  else {
    pFVar1 = (FogKey *)0x0;
    if ((iVar2 <= currentslice) && (pFVar1 = fkey, iVar3 <= currentslice)) {
      pFVar1 = (FogKey *)0x0;
    }
  }
  return pFVar1;
}

/* ---- Fog_FindKey__FiP6FogKey  [TEXTUREPROCESS.CPP:665-695] SLD-VERIFIED ---- */
FogKey * Fog_FindKey(int currentslice,FogKey *fkey)

{
  FogKey *pFVar1;
  
  if (fkey == (FogKey *)0x0) {
    fkey = Fog_gHeadKey;
  }
  pFVar1 = Fog_CheckRange(currentslice,fkey);
  if (pFVar1 == (FogKey *)0x0) {
    if (currentslice < fkey->slice) {
      do {
        fkey = fkey->prev;
        pFVar1 = Fog_CheckRange(currentslice,fkey);
      } while (pFVar1 == (FogKey *)0x0);
    }
    else {
      do {
        fkey = fkey->next;
        pFVar1 = Fog_CheckRange(currentslice,fkey);
      } while (pFVar1 == (FogKey *)0x0);
    }
  }
  return fkey;
}

/* ---- Fog_AllocKey__Fv  [TEXTUREPROCESS.CPP:716-726] SLD-VERIFIED ---- */
FogKey * Fog_AllocKey(void)

{
  int *piVar1;
  FogKey *pFVar2;
  int i;
  
  i = 0;
  pFVar2 = Fog_gBuf;
  piVar1 = openkeys;
  do {
    i = i + 1;
    if (*piVar1 == 1) {
      *piVar1 = 0;
      return pFVar2;
    }
    pFVar2 = pFVar2 + 1;
    piVar1 = piVar1 + 1;
  } while (i < 0x20);
  return (FogKey *)0x0;
}

/* ---- Fog_AddKey__Fii  [TEXTUREPROCESS.CPP:733-790] SLD-VERIFIED ---- */
void Fog_AddKey(int slice,int distance)

{
  FogKey *newkey;
  FogKey *insertkey;
  FogKey *savenextkey;
  
  newkey = Fog_AllocKey();
  insertkey = Fog_gHeadKey;
  newkey->prev = (FogKey *)0x0;
  newkey->next = (FogKey *)0x0;
  newkey->slice = (short)slice;
  newkey->distance = (short)distance;
  if (insertkey == (FogKey *)0x0) {
    Fog_gHeadKey = newkey;
    newkey->next = newkey;
    newkey->prev = newkey;
  }
  else {
    if (insertkey != insertkey->next) {
      insertkey = Fog_FindKey(slice,(FogKey *)0x0);
    }
    if (insertkey->slice == slice) {
      return;
    }
    savenextkey = insertkey->next;
    insertkey->next = newkey;
    newkey->prev = insertkey;
    newkey->next = savenextkey;
    savenextkey->prev = newkey;
  }
  Fog_gNumKeys = Fog_gNumKeys + 1;
  return;
}

/* ---- Fog_Update__Fi  [TEXTUREPROCESS.CPP:840-884] SLD-VERIFIED ---- */
void Fog_Update(int player)
{
  int currentslice;
  FogKey *key;
  FogKey *nextkey;
  int nextslice;
  int diffslice;
  int diffdistance;
  int final_dist;
  int numslices;

  if (Fog_gNumKeys != 1) {
    BWorldSm_FindClosestQuadRez(&gCView.cview.translation,fogslicePos + player,1);
    currentslice = fogslicePos[player].slice;
    key = Fog_FindKey(currentslice,Fog_gCurrentKey[player]);
    Fog_gCurrentKey[player] = key;
    nextkey = key->next;
    TrackSpec_gSpec.fogspec.start = key->distance;
    nextslice = nextkey->slice;
    if (key->distance != nextkey->distance) {
      if (nextslice < key->slice) {
        numslices = gNumSlices;
        nextslice = nextslice + numslices;
        if ((-1 < currentslice) && (currentslice < key->slice)) {
          currentslice = currentslice + numslices;
        }
      }
      diffdistance = nextkey->distance - key->distance;
      diffslice = nextslice - key->slice;
      final_dist = ((currentslice - key->slice) * diffdistance) / diffslice;
      TrackSpec_gSpec.fogspec.start = key->distance + final_dist;
    }
  }
}

/* ---- Fog_MakeTrackPathName__FPc  [TEXTUREPROCESS.CPP:1015-1022] SLD-VERIFIED ---- */
char * Fog_MakeTrackPathName(char *ext)

{
  sprintf(fogstrspc,"%sTr%02d%s",Paths_Paths[6],GameSetup_gData.track & 0xf,ext);
  return fogstrspc;
}

/* ---- Fog_ReadFogKeys__Fv  [TEXTUREPROCESS.CPP:1026-1078] SLD-VERIFIED ---- */
int Fog_ReadFogKeys(void)

{
  u_int *puVar1;
  u_int *puVar2;
  bool bVar3;
  char *strspc;
  int i;
  char *ext;
  u_int *puVar5;
  int *readmem;
  u_int numkeys;
  
  if ((GameSetup_gData.Time == 0) || (GameSetup_gData.Weather == 0)) {
    if (GameSetup_gData.Time == 0) {
      if (GameSetup_gData.Weather == 0) {
        ext = ".fog";
      }
      else {
        ext = "W.fog";
      }
    }
    else {
      ext = "N.fog";
    }
  }
  else {
    ext = "S.fog";
  }
  strspc = Fog_MakeTrackPathName(ext);
  readmem = (int *)loadfileadr(strspc,0);
  i = 0;
  if (readmem != (u_int *)0x0) {
    numkeys = *readmem;
    i = 0;
    if (numkeys < 0x20) {
      bVar3 = 0 < (int)numkeys;
      puVar5 = readmem;
      while (bVar3) {
        puVar1 = puVar5 + 1;
        puVar2 = puVar5 + 2;
        puVar5 = puVar5 + 2;
        i = i + 1;
        Fog_AddKey(*puVar1,*puVar2);
        bVar3 = i < (int)numkeys;
      }
      purgememadr(readmem);
      i = 1;
    }
    else {
      i = 0;
    }
  }
  return i;
}

/* ---- Fog_InitFogTriggers__Fv  [TEXTUREPROCESS.CPP:1082-1119] SLD-VERIFIED ---- */
void Fog_InitFogTriggers(void)

{
  int *openkey_walk;
  int num_player;
  int i;
  int k;
  int slice_off;
  
  i = 0x1f;
  openkey_walk = openkeys + 0x1f;
  Fog_gNumKeys = 0;
  Fog_gHeadKey = (FogKey *)0x0;
  do {
    *openkey_walk = 1;
    i = i + -1;
    openkey_walk = openkey_walk + -1;
  } while (-1 < i);
  num_player = Fog_ReadFogKeys();
  if (num_player == 0) {
    Fog_AddKey(0,TrackSpec_gSpec.fogspec.start);
  }
  num_player = 1;
  Fog_gCurrentKey[0] = Fog_gHeadKey;
  Fog_gCurrentKey[1] = Fog_gHeadKey;
  if (GameSetup_gData.commMode == 1) {
    num_player = 2;
  }
  fogslicePos = reservememadr("fog pos",num_player * 0x84,0);
  k = 0;
  if (num_player != 0) {
    slice_off = 0;
    do {
      k = k + 1;
      BWorldSm_SetSlice(0,(BWorldSm_Pos *)((int)fogslicePos->quadPts + slice_off + -8));
      slice_off = slice_off + 0x84;
    } while (k < num_player);
  }
  return;
}

/* ---- Fog_DeInitFogTriggers__Fv  [TEXTUREPROCESS.CPP:1123-1124] SLD-VERIFIED ---- */
void Fog_DeInitFogTriggers(void)

{
  purgememadr(fogslicePos);
  return;
}

/* ---- TextureProcess_Init__Fv  [TEXTUREPROCESS.CPP:1135-1137] SLD-VERIFIED ---- */
void TextureProcess_Init(void)

{
  gZDepth = 0x10;
  TP_gZPaletteSystem.numdepthclut = 0;
  return;
}

/* ---- CV_ProcessWorldColors_FINAL__FiP7CVECTORs  [TEXTUREPROCESS.CPP:1156-1179] SLD-VERIFIED ---- */
void CV_ProcessWorldColors_FINAL(int constrast,CVECTOR *color,short brightness)
{
  int i;
  int r;
  int g;
  int b;
  int temp;
  u_char *light;

  for (i = 0; i < Chunk_numLight; i = i + 1) {
    light = &Chunk_lightTable[i].r;
    temp = fixedmult((u_int)light[0] - (u_int)color->r,constrast);
    temp = (u_int)light[0] - temp;
    r = 0;
    if ((-1 < temp) && (r = temp, 0xff < temp)) { r = 0xff; }
    temp = fixedmult((u_int)light[1] - (u_int)color->g,constrast);
    temp = (u_int)light[1] - temp;
    g = 0;
    if ((-1 < temp) && (g = temp, 0xff < temp)) { g = 0xff; }
    temp = fixedmult((u_int)light[2] - (u_int)color->b,constrast);
    temp = (u_int)light[2] - temp;
    b = 0;
    if ((-1 < temp) && (b = temp, 0xff < temp)) { b = 0xff; }
    r = r + brightness;
    g = g + brightness;
    b = b + brightness;
    if (0xff < r) { r = 0xff; }
    if (r < 0) { r = 0; }
    if (0xff < g) { g = 0xff; }
    if (g < 0) { g = 0; }
    if (0xff < b) { b = 0xff; }
    if (b < 0) { b = 0; }
    light[0] = (u_char)r;
    light[1] = (u_char)g;
    light[2] = (u_char)b;
  }
}

/* ---- CV_ColorTracks__Fiii  [TEXTUREPROCESS.CPP:1183-1257] SLD-VERIFIED ---- */
void CV_ColorTracks(int track,int weather,int night)

{
  u_char uVar1;
  short sVar2;
  short brightness;
  int contrast;
  CVECTOR color;
  
  memset(&color,0,4);
  brightness = 0;
  sVar2 = 0;
  if (GameSetup_gData.commMode == 1) {
    if (((track == 2) && (weather == 1)) && (night == 1)) {
      contrast = -0x9c80;
      uVar1 = '\x10';
CVColor_setColorG:
      color.g = uVar1;
      brightness = 0x10;
      goto CVColor_emitFinal;
    }
    if (track == 3) {
      if ((weather == 0) && (night == 1)) {
        contrast = -0xf400;
        goto CVColor_emitFinal;
      }
      if ((weather == 1) && (night == 1)) {
        contrast = -0x7400;
        color.r = '\x10';
        color.g = '\0';
        color.b = '\0';
        color.cd = '\0';
        brightness = 0x10;
        goto CVColor_emitFinal;
      }
    }
    if (track == 4) {
      if ((weather == 0) && (night == 1)) {
        contrast = -0x7800;
        goto CVColor_emitFinal;
      }
      if ((weather == 1) && (night == 1)) {
        contrast = -0x10000;
        uVar1 = '\x18';
        goto CVColor_setColorG;
      }
    }
    if (((track == 6) && (weather == 0)) && (night == 1)) {
      contrast = -0x9610;
      brightness = 0x31;
      goto CVColor_emitFinal;
    }
    if (((track == 7) && (weather == 0)) && (night == 1)) {
      contrast = -0xb400;
      brightness = 0x14;
      goto CVColor_emitFinal;
    }
    if (((track != 8) || (weather != 0)) || (night != 1)) {
      contrast = 0;
      brightness = sVar2;
      if (((track == 10) && (weather == 1)) && (night == 1)) {
        contrast = -0x5400;
      }
      goto CVColor_emitFinal;
    }
  }
  else {
    contrast = 0;
    brightness = sVar2;
    if (((track != 8) || (weather != 0)) || (night != 1)) goto CVColor_emitFinal;
  }
  contrast = 0x6800;
  brightness = 0x16;
CVColor_emitFinal:
  CV_ProcessWorldColors_FINAL(contrast,&color,brightness);
  return;
}

/* ---- CV_InitColorVertices__Fv  [TEXTUREPROCESS.CPP:1539-1541] SLD-VERIFIED ---- */
void CV_InitColorVertices(void)

{
  int diffslice;
  int numslices;
  int diffdistance;
  int final_dist;
  int nextslice;
  int i;
  int g;
  u_short color;
  int contrasttemp;
  int j;
  char *sourcedata;
  short newdata [256];
  
  CV_ColorTracks(GameSetup_gData.track & 0xf,GameSetup_gData.Weather,GameSetup_gData.Time);
  return;
}

/* end of textureprocess.cpp */
