/* game/common/trgsfx.cpp -- RECONSTRUCTED (NFS4 trigger-SFX gating front-end; C++ TU)
 *   11 fns: TrgSfx_AddEnviroEffect / AddCarSfx / AddCarWheelSfx / AddCarExtraCheck /
 *   AddCarExtraSfx / AddCarSplash (throttled Souffle_Add wrappers), TrgSfx_CrashCar
 *   (crash debris), TrgSfx_AddSkidmark (per-wheel skid-trail state machine -> Skidmark_*),
 *   TrgSfx_Init/Restart/KillTrgSfx (state reset). No GTE.
 */
#include "../../nfs4_types.h"
#include "trgsfx_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int gTAddCSmoke;
int gTAddCarWheelDelay;


/* ---- TrgSfx_AddEnviroEffect__FiiP8coorddefT2  [TRGSFX.CPP:45-53] SLD-VERIFIED ---- */
void TrgSfx_AddEnviroEffect(int obj,int type,coorddef *emitterpt,coorddef *vec)

{
  if (10 < simGlobal.gameTicks - gTEnviroEffect[obj & 7]) {
    gTEnviroEffect[obj & 7] = simGlobal.gameTicks;
    Souffle_Add(emitterpt,type,vec,0,0,0);
  }
  return;
}

/* ---- TrgSfx_AddCarSfx__FiP8coorddefiT1  [TRGSFX.CPP:64-72] SLD-VERIFIED ---- */
void TrgSfx_AddCarSfx(int car,coorddef *skidpt,int type,coorddef *vec)

{
  if (7 < simGlobal.gameTicks - gTAddCarSfx[car & 7]) {
    gTAddCarSfx[car & 7] = simGlobal.gameTicks;
    Souffle_Add(skidpt,type,vec,0,0,0);
  }
  return;
}

/* ---- TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i  [TRGSFX.CPP:77-88] SLD-VERIFIED ---- */
void TrgSfx_AddCarWheelSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay)

{
  coorddef dir;
  
  if (delay < simGlobal.gameTicks - gTAddCarWheelSfx[car & 7][wheel]) {
    dir.y = vec->y;
    dir.x = vec->x >> 1;
    dir.z = vec->z >> 1;
    gTAddCarWheelSfx[car & 7][wheel] = simGlobal.gameTicks;
    Souffle_Add(skidpt,type,&dir,0,0,0);
  }
  return;
}

/* ---- TrgSfx_AddCarExtraCheck__Fii  [TRGSFX.CPP:93-97] SLD-VERIFIED ---- */
int TrgSfx_AddCarExtraCheck(int car,int wheel)

{
  return (simGlobal.gameTicks - gTAddCarExtraSfx[car & 7][wheel] < 8 ^ 1);
}

/* ---- TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii  [TRGSFX.CPP:101-111] SLD-VERIFIED ---- */
void TrgSfx_AddCarExtraSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int velY,int ground,
               int colour)

{
  coorddef dir;
  
  dir.x = vec->x;
  dir.z = vec->z;
  dir.y = vec->y + (velY >> 3);
  gTAddCarExtraSfx[car & 7][wheel] = simGlobal.gameTicks;
  Souffle_Add(skidpt,type,&dir,0,ground,colour);
  return;
}

/* ---- TrgSfx_AddCarSplash__FiiP8coorddefiT2ii  [TRGSFX.CPP:122-133] SLD-VERIFIED ---- */
void TrgSfx_AddCarSplash(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay,int velXZ)

{
  coorddef dir;
  
  if (delay < simGlobal.gameTicks - gTAddCarWheelSfx[car & 7][wheel]) {
    dir.y = vec->y;
    dir.x = vec->x >> 1;
    dir.z = vec->z >> 1;
    gTAddCarWheelSfx[car & 7][wheel] = simGlobal.gameTicks;
    Souffle_Add(skidpt,type,&dir,velXZ,0,0);
  }
  return;
}

/* ---- TrgSfx_CrashCar__FP8coorddef  [TRGSFX.CPP:146-163] SLD-VERIFIED ---- */
void TrgSfx_CrashCar(coorddef *location)

{
  u_int rnd;
  Souffle_tISouffle *is;

  if (4 < simGlobal.gameTicks - gTAddCSmoke) {
    gTAddCSmoke = simGlobal.gameTicks;
    rnd = random();
    if ((rnd & 0xf) != 0) {
      is = Souffle_Add(location,1,(coorddef *)0x0,0,0,0);
      is->motion.y = is->motion.y + 0xf5c;
    }
    is = Souffle_Add(location,3,(coorddef *)0x0,0,0,0);
    is->motion.y = is->motion.y + 0xf5c;
  }
  return;
}

/* ---- TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji  [TRGSFX.CPP:179-277] SLD-VERIFIED ---- */
void TrgSfx_AddSkidmark(int car,int wheel,coorddef *skidpt,int end,int intensity,Car_tObj *carObj,int type)

{
  int velXZ;
  int slice;
  int tireWidth;
  int c;
  int value;
  int temp;
  int dx;
  int dz;
  int dist;
  int MaxDist;
  int near;
  u_char shade;
  CVECTOR color;
  coorddef *linvel;

  velXZ = carObj->N.speedXZ;
  slice = (int)carObj->N.simRoadInfo.slice;
  tireWidth = (wheel < 2) ? carObj->N.wheelWidthF : carObj->N.wheelWidthB;
  c = car & 7;
  value = (intensity * 0xff) / 0x70000;
  if (value >= 0x100) value = 0xff;
  shade = (u_char)value;
  color.b = shade;
  color.g = shade;
  color.r = shade;
  linvel = &carObj->N.linearVel;
  skidpt->x = skidpt->x + (linvel->x >> 6);
  skidpt->y = skidpt->y + (linvel->y >> 6);
  skidpt->z = skidpt->z + (linvel->z >> 6);
  temp = gStatusSm[c][wheel];
  if (temp == 0) {
    if (end == 0) {
      gStatusSm[c][wheel] = 1;
      gPrevSkidSm[c][wheel].clr = color;
      gPrevSkidSm[c][wheel].type = type;
      gPrevSkidSm[c][wheel].pt = *skidpt;
      gPrevSkidSm[c][wheel].nseg = (Skidmark_Segment *)0x0;
    }
  }
  else if (end == 0) {
    near = 0;
    if (gPrevSkidSm[c][wheel].nseg != (Skidmark_Segment *)0x0) {
      dx = gPrevSkidSm[c][wheel].pt.x - skidpt->x;
      if (dx < 1) dx = skidpt->x - gPrevSkidSm[c][wheel].pt.x;
      dz = gPrevSkidSm[c][wheel].pt.z - skidpt->z;
      if (dz < 1) dz = skidpt->z - gPrevSkidSm[c][wheel].pt.z;
      MaxDist = (velXZ < 0xa0000) ? 0x3000 : 0xc000;
      dist = (dz < dx) ? dx + (dz >> 2) : dz + (dx >> 2);
      if (dist < MaxDist) near = 1;
    }
    if (near != 0) {
      if (gStatusSm[c][wheel] == 2) {
        Skidmark_Stretch(gSaveSeg[c][wheel],gSaveChunk[c][wheel],&gPrevSkidSm[c][wheel],skidpt,&color,tireWidth,type);
      }
      else {
        gStatusSm[c][wheel] = 2;
        Skidmark_AddStretch(&gSaveSeg[c][wheel],&gSaveChunk[c][wheel],&gPrevSkidSm[c][wheel],skidpt,&color,tireWidth,type,slice);
      }
    }
    else {
      if (gStatusSm[c][wheel] == 2) {
        Skidmark_EndStretch(gSaveSeg[c][wheel],gSaveChunk[c][wheel],&gPrevSkidSm[c][wheel],skidpt,&color,tireWidth,type);
      }
      else {
        Skidmark_Add(&gPrevSkidSm[c][wheel],skidpt,&color,tireWidth,type,slice);
      }
      gStatusSm[c][wheel] = 1;
    }
  }
  else {
    if (temp == 2) {
      Skidmark_Stretch(gSaveSeg[c][wheel],gSaveChunk[c][wheel],&gPrevSkidSm[c][wheel],skidpt,&color,tireWidth,type);
    }
    else {
      Skidmark_Add(&gPrevSkidSm[c][wheel],skidpt,&color,tireWidth,type,slice);
    }
    gStatusSm[c][wheel] = 0;
  }
  return;
}

/* ---- TrgSfx_InitTrgSfx__Fv  [TRGSFX.CPP:286-312] SLD-VERIFIED ---- */
void TrgSfx_InitTrgSfx(void)

{
  int i;
  int j;
  int t;

  t = simGlobal.gameTicks;
  gTAddCSmoke = simGlobal.gameTicks;
  for (i = 0; i < 8; i = i + 1) {
    gTEnviroEffect[i] = t;
    gTAddCarSfx[i] = t;
    for (j = 0; j < 4; j = j + 1) {
      gTAddCarWheelSfx[i][j] = t;
      gTAddCarExtraSfx[i][j] = t;
      gStatusSm[i][j] = 0;
      gPrevSkidSm[i][j].pt.x = 0;
      gPrevSkidSm[i][j].pt.y = 0;
      gPrevSkidSm[i][j].pt.z = 0;
      gPrevSkidSm[i][j].nseg = (Skidmark_Segment *)0x0;
    }
  }
  gTAddCarWheelDelay = 8;
  if (GameSetup_gData.commMode == 1) {
    gTAddCarWheelDelay = 0xc;
  }
  return;
}

/* ---- TrgSfx_RestartTrgSfx__Fv  [TRGSFX.CPP:316-318] SLD-VERIFIED ---- */
void TrgSfx_RestartTrgSfx(void)

{
  TrgSfx_KillTrgSfx();
  TrgSfx_InitTrgSfx();
  return;
}

/* ---- TrgSfx_KillTrgSfx__Fv  [TRGSFX.CPP:322-323] SLD-VERIFIED ---- */
void TrgSfx_KillTrgSfx(void)

{
  
  return;
}

/* end of trgsfx.cpp */
