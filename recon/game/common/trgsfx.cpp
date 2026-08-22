/* game/common/trgsfx.cpp -- RECONSTRUCTED (NFS4 trigger-SFX gating front-end; C++ TU)
 *   11 fns: TrgSfx_AddEnviroEffect / AddCarSfx / AddCarWheelSfx / AddCarExtraCheck /
 *   AddCarExtraSfx / AddCarSplash (throttled Souffle_Add wrappers), TrgSfx_CrashCar
 *   (crash debris), TrgSfx_AddSkidmark (per-wheel skid-trail state machine -> Skidmark_*),
 *   TrgSfx_Init/Restart/KillTrgSfx (state reset). No GTE.
 */
#include "trgsfx_types.h"
#include "trgsfx_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int gTAddCSmoke;
int gTAddCarWheelDelay;

/* SYM assigns this contiguous 0x640-byte zero-initialized run to TrgSfx.obj
 * (0x8011e1b0..0x8011e7f0).  Keep each object in a named section so the
 * reconstruction linker can preserve SYM order without exposing the run to
 * gcc 2.8.1's tentative-object sorting. */
int gTEnviroEffect[8]
    __attribute__((section(".data.trgsfx_t_enviro")));
int gTAddCarSfx[8]
    __attribute__((section(".data.trgsfx_t_car")));
int gTAddCarWheelSfx[8][4]
    __attribute__((section(".data.trgsfx_t_wheel")));
int gTAddCarExtraSfx[8][4]
    __attribute__((section(".data.trgsfx_t_extra")));
tSkid gPrevSkidSm[8][4]
    __attribute__((section(".data.trgsfx_prev_skid")));
int gStatusSm[8][4]
    __attribute__((section(".data.trgsfx_status")));
Skidmark_Segment *gSaveSeg[8][4]
    __attribute__((section(".data.trgsfx_save_seg")));
int gSaveChunk[8][4]
    __attribute__((section(".data.trgsfx_save_chunk")));


/* ---- TrgSfx_AddEnviroEffect__FiiP8coorddefT2  [TRGSFX.CPP:45-53] SLD-VERIFIED ---- */
void TrgSfx_AddEnviroEffect(int obj,int type,coorddef *emitterpt,coorddef *vec)

{
  int c;

  c = obj & 7;
  if (10 < TRGSFX_GAME_TICKS - gTEnviroEffect[c]) {
    gTEnviroEffect[c] = TRGSFX_GAME_TICKS;
    Souffle_Add(emitterpt,type,vec,0,0,0);
  }
  return;
}

/* ---- TrgSfx_AddCarSfx__FiP8coorddefiT1  [TRGSFX.CPP:64-72] SLD-VERIFIED ---- */
void TrgSfx_AddCarSfx(int car,coorddef *skidpt,int type,coorddef *vec)

{
  int c;

  c = car & 7;
  if (7 < TRGSFX_GAME_TICKS - gTAddCarSfx[c]) {
    gTAddCarSfx[c] = TRGSFX_GAME_TICKS;
    Souffle_Add(skidpt,type,vec,0,0,0);
  }
  return;
}

/* ---- TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i  [TRGSFX.CPP:77-88] SLD-VERIFIED ---- */
void TrgSfx_AddCarWheelSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay)

{
  car = car & 7;
  if (delay < TRGSFX_GAME_TICKS - gTAddCarWheelSfx[car][wheel]) {
    coorddef dir = *vec;
    dir.x = dir.x >> 1;
    dir.z = dir.z >> 1;
    gTAddCarWheelSfx[car][wheel] = TRGSFX_GAME_TICKS;
    Souffle_Add(skidpt,type,&dir,0,0,0);
  }
  return;
}

/* ---- TrgSfx_AddCarExtraCheck__Fii  [TRGSFX.CPP:93-97] SLD-VERIFIED ---- */
bool TrgSfx_AddCarExtraCheck(int car,int wheel)

{
  int c;

  c = car & 7;
  return (TRGSFX_GAME_TICKS - gTAddCarExtraSfx[c][wheel] < 8 ^ 1);
}

/* ---- TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii  [TRGSFX.CPP:101-111] SLD-VERIFIED ---- */
void TrgSfx_AddCarExtraSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int velY,int ground,
               int colour)

{
  coorddef dir;

  car = car & 7;
  dir = *vec;
  dir.y = dir.y + (velY >> 3);
  gTAddCarExtraSfx[car][wheel] = TRGSFX_GAME_TICKS;
  Souffle_Add(skidpt,type,&dir,0,ground,colour);
  return;
}

/* ---- TrgSfx_AddCarSplash__FiiP8coorddefiT2ii  [TRGSFX.CPP:122-133] SLD-VERIFIED ---- */
void TrgSfx_AddCarSplash(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay,int velXZ)

{
  car = car & 7;
  if (delay < TRGSFX_GAME_TICKS - gTAddCarWheelSfx[car][wheel]) {
    coorddef dir = *vec;
    dir.x = dir.x >> 1;
    dir.z = dir.z >> 1;
    gTAddCarWheelSfx[car][wheel] = TRGSFX_GAME_TICKS;
    Souffle_Add(skidpt,type,&dir,velXZ,0,0);
  }
  return;
}

/* ---- TrgSfx_CrashCar__FP8coorddef  [TRGSFX.CPP:146-163] SLD-VERIFIED ---- */
void TrgSfx_CrashCar(coorddef *location)

{
  u_int rnd;
  Souffle_tISouffle *is;

  if (4 < TRGSFX_GAME_TICKS - gTAddCSmoke) {
    gTAddCSmoke = TRGSFX_GAME_TICKS;
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
  int value;
  int temp;
  int dx;
  int dz;
  int dist;
  int MaxDist;
  int shade;
  CVECTOR color;
  coorddef *linvel;

  linvel = &carObj->N.linearVel;
  velXZ = carObj->N.speedXZ;
  slice = (int)carObj->N.simRoadInfo.slice;
  tireWidth = (wheel < 2) ? carObj->N.wheelWidthF : carObj->N.wheelWidthB;
  car &= 7;
  temp = (intensity * 0xff) / 0x70000;
  shade = 0xff;
  if (temp < 0x100) shade = temp;
  temp = shade;
  color.b = (u_char)temp;
  color.g = (u_char)temp;
  color.r = (u_char)temp;
  skidpt->x = skidpt->x + (linvel->x >> 6);
  skidpt->y = skidpt->y + (linvel->y >> 6);
  skidpt->z = skidpt->z + (linvel->z >> 6);
  temp = gStatusSm[car][wheel];
  if (temp == 0) {
    if (end == 0) {
      gStatusSm[car][wheel] = 1;
      gPrevSkidSm[car][wheel].clr = color;
      gPrevSkidSm[car][wheel].type = type;
      gPrevSkidSm[car][wheel].pt = *skidpt;
      gPrevSkidSm[car][wheel].nseg = (Skidmark_Segment *)0x0;
    }
  }
  else {
    if (end != 0) {
      if (temp == 2) {
        Skidmark_Stretch(gSaveSeg[car][wheel],gSaveChunk[car][wheel],&gPrevSkidSm[car][wheel],skidpt,&color,tireWidth,type);
      }
      else {
        Skidmark_Add(&gPrevSkidSm[car][wheel],skidpt,&color,tireWidth,type,slice);
      }
      gStatusSm[car][wheel] = 0;
    }
    else {
      value = 0;
      if (gPrevSkidSm[car][wheel].nseg != (Skidmark_Segment *)0x0) {
        dx = gPrevSkidSm[car][wheel].pt.x - skidpt->x;
        if (dx < 1) dx = skidpt->x - gPrevSkidSm[car][wheel].pt.x;
        dz = gPrevSkidSm[car][wheel].pt.z - skidpt->z;
        if (dz < 1) dz = skidpt->z - gPrevSkidSm[car][wheel].pt.z;
        MaxDist = (velXZ < 0xa0000) ? 0x3000 : 0xc000;
        dist = (dz < dx) ? dx + (dz >> 2) : dz + (dx >> 2);
        if (dist < MaxDist) value = 1;
      }
      if (value == 0) {
        if (gStatusSm[car][wheel] == 2) {
          Skidmark_EndStretch(gSaveSeg[car][wheel],gSaveChunk[car][wheel],&gPrevSkidSm[car][wheel],skidpt,&color,tireWidth,type);
        }
        else {
          Skidmark_Add(&gPrevSkidSm[car][wheel],skidpt,&color,tireWidth,type,slice);
        }
        gStatusSm[car][wheel] = 1;
      }
      else {
        if (gStatusSm[car][wheel] == 2) {
          Skidmark_Stretch(gSaveSeg[car][wheel],gSaveChunk[car][wheel],&gPrevSkidSm[car][wheel],skidpt,&color,tireWidth,type);
        }
        else {
          gStatusSm[car][wheel] = 2;
          Skidmark_AddStretch(&gSaveSeg[car][wheel],&gSaveChunk[car][wheel],&gPrevSkidSm[car][wheel],skidpt,&color,tireWidth,type,slice);
        }
      }
    }
  }
  return;
}

/* ---- TrgSfx_InitTrgSfx__Fv  [TRGSFX.CPP:286-312] SLD-VERIFIED ---- */
void TrgSfx_InitTrgSfx(void)

{
  int i;
  int j;
  int t;

  t = TRGSFX_GAME_TICKS;
  gTAddCSmoke = TRGSFX_GAME_TICKS;
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
  if (TRGSFX_COMM_MODE == 1) {
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
