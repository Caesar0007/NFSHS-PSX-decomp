/* frontend/common/weather.cpp -- RECONSTRUCTED (NFS4 PSX particle weather; C++ TU)
 *   25 free fns Weather_*: snow/rain/splat particle system. State machine (density/intensity),
 *   GTE-transformed particle rendering. GTE COP2 ops via PsyQ libgte macros (weather_externs.h).
 */
#include "../../nfs4_types.h"
#include "weather_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
CWeatherSpec *Weather_gTrackSpec;
DVECTOR *Weather_gPrevPos;
SVECTOR *Weather_gPos;
Weather_tSplatInfo *Weather_gSplatInfo;
char *Weather_gWasDrawn;
int Weather_gDensityChangeFactor;
int Weather_gDensityGoalState;
int Weather_gDensityTimerGoal;
int Weather_gIntensityChangeFactor;
int Weather_gIntensityGoalState;
int Weather_gIntensityTimerGoal;
int Weather_gSnowTrack;
int Weather_gTrackIntensityLimit;
int Weather_gType;
int gCurrentNumSplats;

/* DoWeather function-local statics (SYM STAT class; persist across frames) */
static int prevCameraMode[2];
static int prevLookBehind[2];


/* ---- Weather_GetNumParticles__Fi  [WEATHER.CPP:107-108] SLD-VERIFIED ---- */
int Weather_GetNumParticles(int player)

{
  return Weather_gSys.num[0];
}

/* ---- Weather_SetMatrix__FP10matrixtdef  [WEATHER.CPP:112-123] SLD-VERIFIED ---- */
void Weather_SetMatrix(matrixtdef *m)
{
  int r0;
  int r1;
  int r2;
  MATRIX mpsx;

  mpsx.m[0][0] = (short)((int)m->m[0] >> 4);
  mpsx.m[0][1] = (short)((int)m->m[3] >> 4);
  mpsx.m[0][2] = (short)((int)m->m[6] >> 4);
  mpsx.m[1][0] = (short)((int)m->m[1] >> 4);
  mpsx.m[1][1] = (short)((int)m->m[4] >> 4);
  mpsx.m[1][2] = (short)((int)m->m[7] >> 4);
  mpsx.t[0] = 0;
  mpsx.t[1] = 0;
  mpsx.t[2] = 0;
  mpsx.m[2][0] = (short)((int)m->m[2] >> 4);
  mpsx.m[2][1] = (short)((int)m->m[5] >> 4);
  mpsx.m[2][2] = (short)((int)m->m[8] >> 4);
  gte_SetRotMatrix(&mpsx);
  gte_SetTransMatrix(&mpsx);
}

/* ---- Weather_SetIdentMatrix__Fv  [WEATHER.CPP:127-139] SLD-VERIFIED ---- */
void Weather_SetIdentMatrix(void)
{
  MATRIX Ident;

  Ident.m[0][0] = 0x1000;
  Ident.m[0][1] = 0;
  Ident.m[0][2] = 0;
  Ident.m[1][0] = 0;
  Ident.m[1][1] = -0x1000;
  Ident.m[1][2] = 0;
  Ident.m[2][0] = 0;
  Ident.m[2][1] = 0;
  Ident.m[2][2] = 0x1000;
  Ident.t[0] = 0;
  Ident.t[1] = 0;
  Ident.t[2] = 0;
  gte_SetRotMatrix(&Ident);
  gte_SetTransMatrix(&Ident);
}

/* ---- Weather_InitSnow__Fv  [WEATHER.CPP:150-162] SLD-VERIFIED ---- */
void Weather_InitSnow(void)

{
  Weather_gSys.num[0] = 0x96;
  Weather_gSys.width = 0x280;
  Weather_gSys.znear = 0x140;
  Weather_gSys.zfar = 0x640;
  Weather_gSys.length = 0x500;
  Weather_gSys.bottom = -0x140;
  Weather_gSys.top = 0x3c0;
  Weather_gSys.velocity.vy = -0x12;
  Weather_gSys.height = 0x500;
  Weather_gSys.velocity.vx = 0;
  Weather_gSys.velocity.vz = 0;
  Weather_gSys.hdist = 0xa0;
  return;
}

/* ---- Weather_InitRain__Fv  [WEATHER.CPP:166-178] SLD-VERIFIED ---- */
void Weather_InitRain(void)

{
  Weather_gSys.num[0] = 0x96;
  Weather_gSys.width = 0x440;
  Weather_gSys.znear = 0x180;
  Weather_gSys.zfar = 0xa00;
  Weather_gSys.length = 0x880;
  Weather_gSys.bottom = -0x140;
  Weather_gSys.height = 0x580;
  Weather_gSys.velocity.vy = -0x68;
  Weather_gSys.top = 0x440;
  Weather_gSys.velocity.vx = 0;
  Weather_gSys.velocity.vz = 0;
  Weather_gSys.hdist = 0xa0;
  return;
}

/* ---- Weather_InitSplats__Fv  [WEATHER.CPP:182-191] SLD-VERIFIED ---- */
void Weather_InitSplats(void)

{
  u_int rnd;
  u_int uVar1;
  int ySize;
  u_int y_max;
  int i;
  int splat_i;
  
  for (splat_i = 0; splat_i < 0x13; splat_i = splat_i + 1) {
    y_max = 0xf0;
    if (GameSetup_gData.commMode == 1) {
      y_max = 0x78;
    }
    rnd = random();
    Weather_gSplatInfo[splat_i].pos.vx =
         (short)rnd + (short)((unsigned long long)rnd * 0xcccccccd >> 0x28) * -0x140;
    uVar1 = random();
    if (y_max == 0) {
    }
    Weather_gSplatInfo[splat_i].pos.vy = (short)(uVar1 % y_max);
    uVar1 = random();
    Weather_gSplatInfo[splat_i].startTick = uVar1 % 300;
  }
  return;
}

/* ---- Weather_GetNewState__Fv  [WEATHER.CPP:238-249] SLD-VERIFIED ---- */
int Weather_GetNewState(void)

{
  int r;

  r = random() & 3;
  if (r < 2) {
    return 0;
  }
  if (r == 2) {
    return 1;
  }
  return -1;
}

/* ---- Weather_ChangeDensityState__Fv  [WEATHER.CPP:253-269] SLD-VERIFIED ---- */
void Weather_ChangeDensityState(void)

{
  int statechange;
  
  Weather_gDensityChangeFactor = Weather_GetNewState();
  if (Weather_gDensityGoalState + Weather_gDensityChangeFactor < 4) {
    if (Weather_gDensityGoalState + Weather_gDensityChangeFactor < 0) {
      Weather_gDensityChangeFactor = 1;
    }
  }
  else {
    Weather_gDensityChangeFactor = -1;
  }
  Weather_gDensityGoalState = Weather_gDensityGoalState + Weather_gDensityChangeFactor;
  if (Weather_gDensityChangeFactor == 0) {
    Weather_gDensityTimerGoal = simGlobal.gameTicks + 0x400;
  }
  return;
}

/* ---- Weather_ChangeIntensityState__Fv  [WEATHER.CPP:273-292] SLD-VERIFIED ---- */
void Weather_ChangeIntensityState(void)

{
  int statechange;
  
  Weather_gIntensityChangeFactor = Weather_GetNewState();
  if (Weather_gTrackIntensityLimit < Weather_gIntensityGoalState + Weather_gIntensityChangeFactor) {
    Weather_gIntensityChangeFactor = -1;
  }
  else if (Weather_gIntensityGoalState + Weather_gIntensityChangeFactor < 0) {
    Weather_gIntensityChangeFactor = 1;
  }
  Weather_gIntensityGoalState = Weather_gIntensityGoalState + Weather_gIntensityChangeFactor;
  if (Weather_gIntensityChangeFactor == 0) {
    Weather_gIntensityTimerGoal = simGlobal.gameTicks + 0x400;
  }
  return;
}

/* ---- Weather_ChangeDensityBasedOnTime__Fv  [WEATHER.CPP:296-319] SLD-VERIFIED ---- */
void Weather_ChangeDensityBasedOnTime(void)

{
  if (Weather_gDensityChangeFactor < 1) {
    if (Weather_gDensityChangeFactor < 0) {
      if (Weather_gDensityTbl[Weather_gDensityGoalState] < Weather_gSys.num[0])
      goto WeatherDensity_numAdd;
    }
    else if (simGlobal.gameTicks <= Weather_gDensityTimerGoal) goto WeatherDensity_numAdd;
  }
  else if (Weather_gSys.num[0] < Weather_gDensityTbl[Weather_gDensityGoalState])
  goto WeatherDensity_numAdd;
  Weather_ChangeDensityState();
WeatherDensity_numAdd:
  Weather_gSys.num[0] = Weather_gSys.num[0] + Weather_gDensityChangeFactor;
  if (Weather_gSys.num[0] < 1) {
    Weather_gSys.num[0] = 0;
  }
  return;
}

/* ---- Weather_ChangeIntensityBasedOnTime__Fv  [WEATHER.CPP:323-350] SLD-VERIFIED ---- */
void Weather_ChangeIntensityBasedOnTime(void)

{
  if (Weather_gIntensityChangeFactor < 1) {
    if (Weather_gIntensityChangeFactor < 0) {
      if (Weather_gIntensityTbl[Weather_gIntensityGoalState] < (int)Weather_gSys.velocity.vy)
      goto WeatherIntensity_velYUpdate;
    }
    else if (simGlobal.gameTicks <= Weather_gIntensityTimerGoal) goto WeatherIntensity_velYUpdate;
  }
  else if ((int)Weather_gSys.velocity.vy < Weather_gIntensityTbl[Weather_gIntensityGoalState])
  goto WeatherIntensity_velYUpdate;
  Weather_ChangeIntensityState();
WeatherIntensity_velYUpdate:
  Weather_gSys.velocity.vy = Weather_gSys.velocity.vy + (short)Weather_gIntensityChangeFactor;
  Weather_gType = (Weather_tState)(Weather_gSys.velocity.vy < -0x20);
  return;
}

/* ---- Weather_InitStateControls__Fv  [WEATHER.CPP:355-387] SLD-VERIFIED ---- */
void Weather_InitStateControls(void)

{
  int track;
  
  Weather_gTrackIntensityLimit = Weather_gTrackIntensityLimitTbl[GameSetup_gData.track];
  if ((GameSetup_gData.track == 0) || (GameSetup_gData.track == 4)) {
    Weather_gSnowTrack = 1;
    Weather_gIntensityGoalState = 3;
  }
  else {
    Weather_gSnowTrack = 0;
    Weather_gIntensityGoalState = 0;
  }
  Weather_gSys.velocity.vy = (short)Weather_gIntensityTbl[Weather_gIntensityGoalState];
  Weather_gType = (Weather_tState)(Weather_gIntensityGoalState != 3);
  Weather_gDensityGoalState = 3;
  Weather_gIntensityChangeFactor = 0;
  Weather_gDensityChangeFactor = 0;
  Weather_gIntensityTimerGoal = simGlobal.gameTicks + 0x400;
  Weather_gSys.num[0] = Weather_gDensityTbl[3];
  Weather_gDensityTimerGoal = simGlobal.gameTicks + 0x400;
  timechange = simGlobal.gameTicks;
  return;
}

/* ---- Weather_Restart__Fv  [WEATHER.CPP:391-402] SLD-VERIFIED ---- */
void Weather_Restart(void)

{
  char *pcVar1;
  int i;
  int iVar2;
  
  if (GameSetup_gData.Weather != 0) {
    if (GameSetup_gData.commMode != 1) {
      Weather_InitStateControls();
    }
    iVar2 = 0;
    Weather_gLastProcessTime[1] = simGlobal.gameTicks;
    Weather_gLastProcessTime[0] = simGlobal.gameTicks;
    do {
      pcVar1 = Weather_gWasDrawn + iVar2;
      iVar2 = iVar2 + 1;
      *pcVar1 = '\0';
    } while (iVar2 < 0x98);
  }
  return;
}

/* ---- Weather_Init__Fv  [WEATHER.CPP:414-496] SLD-VERIFIED ---- */
void Weather_Init(void)

{
  u_int uVar1;
  char *pcVar2;
  int *piVar3;
  matrixtdef *pmVar4;
  matrixtdef *pmVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int i;
  short *psVar9;
  SVECTOR *sv;
  SVECTOR *pSVar10;
  
  Weather_gTrackSpec = &TrackSpec_gSpec.weatherspec;
  if (GameSetup_gData.Weather != 0) {
    Weather_gType = TrackSpec_gSpec.weatherspec.type;
    if (TrackSpec_gSpec.weatherspec.type == 1) {
      Weather_InitRain();
    }
    else if (TrackSpec_gSpec.weatherspec.type == 0) {
      Weather_InitSnow();
    }
    if (Weather_gSplatInfo == (Weather_tSplatInfo *)0x0) {
      Weather_gSplatInfo = reservememadr("raindrop",0xa8,0);
    }
    if (Weather_gPos == (SVECTOR *)0x0) {
      Weather_gPos = reservememadr("weather1",0x4c0,0);
    }
    if (Weather_gPrevPos == (DVECTOR *)0x0) {
      Weather_gPrevPos = reservememadr("weather2",0x260,0);
    }
    if (Weather_gWasDrawn == (char *)0x0) {
      Weather_gWasDrawn = reservememadr("weather3",0x98,0);
    }
    Weather_gLastProcessTime[1] = simGlobal.gameTicks;
    Weather_gLastProcessTime[0] = simGlobal.gameTicks;
    Weather_gPServer[0] = Weather_gPos;
    Weather_gPrevPServer[0] = Weather_gPrevPos;
    Weather_gDrawnServer[0] = Weather_gWasDrawn;
    Weather_gSplatInfoServer[0] = Weather_gSplatInfo;
    if (GameSetup_gData.commMode == 1) {
      Weather_gPServer[1] = Weather_gPos + 0x4c;
      Weather_gPrevPServer[1] = Weather_gPrevPos + 0x4c;
      Weather_gDrawnServer[1] = Weather_gWasDrawn + 0x4c;
      Weather_gSys.num[0] = 0x4c;
      Weather_gSys.num[1] = 0x4c;
      Weather_gSplatInfoServer[1] = Weather_gSplatInfo + 9;
    }
    pmVar5 = prevCamMat;
    pmVar4 = &Camera_gInfo[0].rotation;
    prevCamPos[1].x = Camera_gInfo[0].position.x;
    prevCamPos[1].y = Camera_gInfo[0].position.y;
    prevCamPos[1].z = Camera_gInfo[0].position.z;
    prevCamPos[0].x = Camera_gInfo[0].position.x;
    prevCamPos[0].y = Camera_gInfo[0].position.y;
    prevCamPos[0].z = Camera_gInfo[0].position.z;
    piVar3 = pmVar5->m;
    do {
      iVar6 = pmVar4->m[1];
      iVar7 = pmVar4->m[2];
      iVar8 = pmVar4->m[3];
      *piVar3 = pmVar4->m[0];
      piVar3[1] = iVar6;
      piVar3[2] = iVar7;
      piVar3[3] = iVar8;
      pmVar4 = (matrixtdef *)(pmVar4->m + 4);
      piVar3 = piVar3 + 4;
    } while (pmVar4 != (matrixtdef *)(Camera_gInfo[0].rotation.m + 8));
    *piVar3 = Camera_gInfo[0].rotation.m[8];
    piVar3 = prevCamMat[1].m;
    do {
      iVar6 = *(int *)((int)pmVar5 + 4);
      iVar7 = *(int *)((int)pmVar5 + 8);
      iVar8 = *(int *)((int)pmVar5 + 0xc);
      *piVar3 = pmVar5->m[0];
      piVar3[1] = iVar6;
      piVar3[2] = iVar7;
      piVar3[3] = iVar8;
      pSVar10 = Weather_gPos;
      pmVar5 = (matrixtdef *)((int)pmVar5 + 0x10);
      piVar3 = piVar3 + 4;
    } while (pmVar5 != (matrixtdef *)(prevCamMat[0].m + 8));
    iVar6 = 0x97;
    *piVar3 = prevCamMat[0].m[8];
    psVar9 = &pSVar10->vz;
    do {
      iVar6 = iVar6 + -1;
      uVar1 = random();
      if ((int)Weather_gSys.width == 0) {
      }
      pSVar10->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
      uVar1 = random();
      if ((int)Weather_gSys.height == 0) {
      }
      psVar9[-1] = Weather_gSys.bottom + (short)(uVar1 % (u_int)(int)Weather_gSys.height);
      uVar1 = random();
      if ((int)Weather_gSys.length == 0) {
      }
      pSVar10 = pSVar10 + 1;
      *psVar9 = Weather_gSys.znear + (short)(uVar1 % (u_int)(int)Weather_gSys.length);
      psVar9 = psVar9 + 4;
    } while (iVar6 != -1);
    iVar6 = 0;
    do {
      pcVar2 = Weather_gWasDrawn + iVar6;
      iVar6 = iVar6 + 1;
      *pcVar2 = '\0';
    } while (iVar6 < 0x98);
    gCurrentNumSplats = 0;
    Weather_InitSplats();
  }
  return;
}

/* ---- Weather_DeInit__Fv  [WEATHER.CPP:501-527] SLD-VERIFIED ---- */
void Weather_DeInit(void)

{
  if (GameSetup_gData.Weather != 0) {
    if (Weather_gSplatInfo != (Weather_tSplatInfo *)0x0) {
      purgememadr(Weather_gSplatInfo);
    }
    if (Weather_gPos != (SVECTOR *)0x0) {
      purgememadr(Weather_gPos);
    }
    if (Weather_gPrevPos != (DVECTOR *)0x0) {
      purgememadr(Weather_gPrevPos);
    }
    if (Weather_gWasDrawn != (char *)0x0) {
      purgememadr(Weather_gWasDrawn);
    }
    Weather_gSplatInfo = (Weather_tSplatInfo *)0x0;
    Weather_gPos = (SVECTOR *)0x0;
    Weather_gPrevPos = (DVECTOR *)0x0;
    Weather_gWasDrawn = (char *)0x0;
  }
  return;
}

/* ---- Weather_TransformVertex__FP10matrixtdefiP7SVECTOR  [WEATHER.CPP:581-615] SLD-VERIFIED ---- */
void Weather_TransformVertex(matrixtdef *m,int n,SVECTOR *s)
{
  int r0;
  int r1;
  int r2;
  VECTOR tv;
  SVECTOR *next;
  int i;

  Weather_SetMatrix(m);
  gte_ldv0(s);
  gte_mvmva();
  i = n + -1;
  gte_stlvnl(&tv);
  while (true) {
    i = i + -1;
    next = s + 1;
    if (i == -1) break;
    gte_ldv0(next);
    gte_mvmva();
    s->vx = (short)tv.vx;
    s->vy = (short)tv.vy;
    s->vz = (short)tv.vz;
    gte_stlvnl(&tv);
    s = next;
  }
  s->vx = (short)tv.vx;
  s->vy = (short)tv.vy;
  s->vz = (short)tv.vz;
}

/* ---- Weather_CheckAndResetParticles__FP7SVECTOR  [WEATHER.CPP:623-668] SLD-VERIFIED ---- */
short Weather_CheckAndResetParticles(SVECTOR *pt)

{
  u_int rnd;
  u_int uVar1;
  u_int uVar2;
  short flag;
  short sVar3;
  SVECTOR *pt_reg;
  short z_off;
  short sVar4;
  short reset_flag;
  
  sVar3 = 0;
  if ((int)Weather_gSys.width < (int)pt->vx) {
    rnd = 0x40 - Weather_gSys.width;
    pt->vx = (short)rnd;
    rnd = random();
    if ((int)Weather_gSys.height == 0) {
    }
    pt->vy = Weather_gSys.bottom + (short)(rnd % (u_int)(int)Weather_gSys.height);
    uVar1 = random();
    z_off = (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    if ((int)Weather_gSys.length == 0) {
    }
    sVar3 = 1;
WeatherReset_frontWrap:
    pt->vz = Weather_gSys.znear + z_off;
  }
  else if ((int)pt->vx < -(int)Weather_gSys.width) {
    pt->vx = Weather_gSys.width + -0x40;
    uVar1 = random();
    if ((int)Weather_gSys.height == 0) {
    }
    pt->vy = Weather_gSys.bottom + (short)(uVar1 % (u_int)(int)Weather_gSys.height);
    uVar1 = random();
    if ((int)Weather_gSys.length == 0) {
    }
    z_off = (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    sVar3 = 2;
    goto WeatherReset_frontWrap;
  }
  if (Weather_gSys.zfar < pt->vz) {
    pt->vz = Weather_gSys.znear + 0x40;
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    sVar4 = (short)(uVar1 % (u_int)(int)Weather_gSys.height);
    if ((int)Weather_gSys.height == 0) {
    }
    sVar3 = 3;
  }
  else {
    if (Weather_gSys.znear <= pt->vz) goto WeatherReset_topCheck;
    sVar3 = 4;
    uVar1 = random();
    uVar2 = ((int)((u_int)(u_short)Weather_gSys.zfar << 0x10) >> 0x10) -
            ((int)((u_int)(u_short)Weather_gSys.zfar << 0x10) >> 0x1f) >> 1;
    if (uVar2 == 0) {
    }
    pt->vz = Weather_gSys.znear + (short)(uVar1 % uVar2);
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    if ((int)Weather_gSys.height == 0) {
    }
    sVar4 = (short)(uVar1 % (u_int)(int)Weather_gSys.height);
  }
  pt->vy = Weather_gSys.bottom + sVar4;
WeatherReset_topCheck:
  if (Weather_gSys.top < pt->vy) {
    pt->vy = Weather_gSys.bottom + 0x40;
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    reset_flag = (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    if ((int)Weather_gSys.length == 0) {
    }
    sVar3 = 5;
  }
  else {
    if (Weather_gSys.bottom <= pt->vy) {
      return sVar3;
    }
    pt->vy = Weather_gSys.top + -0x40;
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    if ((int)Weather_gSys.length == 0) {
    }
    reset_flag = (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    sVar3 = 6;
  }
  pt->vz = Weather_gSys.znear + reset_flag;
  return sVar3;
}

/* ---- Weather_QuickReOrthogonalize__FP10matrixtdefT0  [WEATHER.CPP:673-700] SLD-VERIFIED ---- */
void Weather_QuickReOrthogonalize
               (matrixtdef *rot,matrixtdef *rotNew)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  coorddef *rotz;
  coorddef *nrotz;
  coorddef *v;
  coorddef *nrotx;
  matrixtdef *rot_reg;
  coorddef *nroty;
  coorddef *roty;
  coorddef upvector;
  
  iVar4 = prevCameraMode[0];
  iVar2 = prevLookBehind[1];
  iVar3 = prevLookBehind[0];
  v = (coorddef *)(rotNew->m + 6);
  upvector.x = prevLookBehind[0];
  upvector.y = prevLookBehind[1];
  upvector.z = prevCameraMode[0];
  iVar5 = rot->m[7];
  iVar6 = rot->m[8];
  rotNew->m[6] = rot->m[6];
  rotNew->m[7] = iVar5;
  rotNew->m[8] = iVar6;
  Math_NormalizeVector(v);
  iVar5 = fixedmult(iVar3,rot->m[6]);
  iVar6 = fixedmult(iVar2,rot->m[7]);
  iVar1 = fixedmult(iVar4,rot->m[8]);
  if (iVar5 + iVar6 + iVar1 < 1) {
    iVar3 = fixedmult(iVar3,rot->m[6]);
    iVar2 = fixedmult(iVar2,rot->m[7]);
    iVar4 = fixedmult(iVar4,rot->m[8]);
    iVar3 = -(iVar3 + iVar2 + iVar4);
  }
  else {
    iVar5 = fixedmult(iVar3,rot->m[6]);
    iVar2 = fixedmult(iVar2,rot->m[7]);
    iVar3 = fixedmult(iVar4,rot->m[8]);
    iVar3 = iVar5 + iVar2 + iVar3;
  }
  if (0xfd70 < iVar3) {
    upvector.x = rot->m[3];
    upvector.y = rot->m[4];
    upvector.z = rot->m[5];
  }
  iVar3 = fixedmult(upvector.y,rotNew->m[8]);
  iVar2 = fixedmult(upvector.z,rotNew->m[7]);
  rotNew->m[0] = iVar3 - iVar2;
  iVar3 = fixedmult(upvector.z,v->x);
  iVar2 = fixedmult(upvector.x,rotNew->m[8]);
  rotNew->m[1] = iVar3 - iVar2;
  iVar3 = fixedmult(upvector.x,rotNew->m[7]);
  iVar2 = fixedmult(upvector.y,v->x);
  rotNew->m[2] = iVar3 - iVar2;
  Math_NormalizeVector((coorddef *)rotNew);
  iVar3 = fixedmult(rotNew->m[7],rotNew->m[2]);
  iVar2 = fixedmult(rotNew->m[8],rotNew->m[1]);
  rotNew->m[3] = iVar3 - iVar2;
  iVar3 = fixedmult(rotNew->m[8],rotNew->m[0]);
  iVar2 = fixedmult(v->x,rotNew->m[2]);
  rotNew->m[4] = iVar3 - iVar2;
  iVar3 = fixedmult(v->x,rotNew->m[1]);
  iVar2 = fixedmult(rotNew->m[7],rotNew->m[0]);
  rotNew->m[5] = iVar3 - iVar2;
  return;
}

/* ---- Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc  [WEATHER.CPP:704-887] SLD-VERIFIED ---- */
void Weather_ProcessParticles(DRender_tView *Vi,int num,SVECTOR *wpt,char *wd)
{
  matrixtdef matdiff;
  matrixtdef orthoMat;
  SVECTOR velocity_vector_change;
  SVECTOR total_vector_change;
  SVECTOR Weather_gTransformedRandomVelocityVectors [12];
  SVECTOR temp_vector;
  VECTOR result;
  coorddef *cp;
  char *vel;
  SVECTOR *tv;
  SVECTOR pt;
  int n;

  /* re-orthogonalize the camera matrix, build the frame-to-frame difference matrix, and transform
     every particle by it so the whole field rotates rigidly with the camera */
  Weather_QuickReOrthogonalize(&Vi->cview.mrotationInvRaw,&orthoMat);
  Math_fasttransmult(&prevCamMat[Vi->player],&orthoMat,&matdiff);
  transpose(&orthoMat,&prevCamMat[Vi->player]);
  Weather_TransformVertex(&matdiff,num,wpt);
  Weather_SetMatrix(&Vi->cview.mrotationInvRaw);

  /* camera translation delta since last frame, rotated into camera space -> total_vector_change */
  cp = &prevCamPos[Vi->player];
  temp_vector.vx = (short)((Vi->cview.translation.x - cp->x) / 0x400);
  temp_vector.vy = (short)((Vi->cview.translation.y - cp->y) / 0x400);
  temp_vector.vz = (short)((Vi->cview.translation.z - cp->z) / 0x400);
  gte_ldv0(&temp_vector);
  gte_mvmva();
  cp->x = Vi->cview.translation.x;
  cp->y = Vi->cview.translation.y;
  cp->z = Vi->cview.translation.z;
  gte_stlvnl(&result);
  total_vector_change.vy = -(short)result.vy;
  total_vector_change.vx = -(short)result.vx;
  total_vector_change.vz = -(short)result.vz;

  /* wind/gravity velocity, rotated into camera space; folded into total_vector_change */
  temp_vector.vx = Weather_gSys.velocity.vx;
  temp_vector.vy = Weather_gSys.velocity.vy;
  temp_vector.vz = Weather_gSys.velocity.vz;
  gte_ldv0(&temp_vector);
  gte_mvmva();
  gte_stlvnl(&result);
  total_vector_change.vx = total_vector_change.vx + (short)result.vx;
  velocity_vector_change.vx = (short)result.vx;
  velocity_vector_change.vy = (short)result.vy;
  velocity_vector_change.vz = (short)result.vz;
  total_vector_change.vz = total_vector_change.vz + (short)result.vz;
  total_vector_change.vy = total_vector_change.vy + (short)result.vy;

  /* rotate the 12 turbulence velocity vectors into camera space (frame-local copy) */
  vel = (char *)Weather_gRandomVelocityVectors;
  for (n = 0; n < 12; n = n + 1) {
    temp_vector.vx = vel[0];
    temp_vector.vy = vel[1];
    temp_vector.vz = vel[2];
    gte_ldv0(&temp_vector);
    gte_mvmva();
    gte_stlvnl(&result);
    Weather_gTransformedRandomVelocityVectors[n].vx = (short)result.vx;
    Weather_gTransformedRandomVelocityVectors[n].vy = (short)result.vy;
    Weather_gTransformedRandomVelocityVectors[n].vz = (short)result.vz;
    vel = vel + 3;
  }

  /* advance every particle by (camera comp + wind) + its turbulence vector; wrap + flag resets */
  tv = wpt;
  for (n = 0; n < num; n = n + 1) {
    pt.vx = Weather_gTransformedRandomVelocityVectors[n % 12].vx + (tv->vx + total_vector_change.vx);
    pt.vy = Weather_gTransformedRandomVelocityVectors[n % 12].vy + (tv->vy + total_vector_change.vy);
    pt.vz = Weather_gTransformedRandomVelocityVectors[n % 12].vz + (tv->vz + total_vector_change.vz);
    if (Weather_CheckAndResetParticles(&pt) != 0) {
      wd[n] = 0;
    }
    tv->vx = pt.vx;
    tv->vy = pt.vy;
    tv->vz = pt.vz;
    tv = tv + 1;
  }
}

/* ---- Weather_CreateSnow__FP7SVECTOR  [WEATHER.CPP:923-961] SLD-VERIFIED ---- */
void Weather_CreateSnow(SVECTOR *pt)
{
  SVECTOR gv [4];
  POLY_FT4 *prim;
  Draw_tPixMap *pmx;
  unsigned long l0;
  unsigned long l1;
  unsigned long l2;
  unsigned long l3;

  /* build the 4 corners of the snowflake quad (the packed SVECTOR[4] copies the compiler emitted
     as lwl/lwr/swl/swr unaligned word moves -- here in their faithful struct-assignment form) */
  gv[0] = *pt;
  gv[1] = gv[0];
  gv[2] = gv[1];
  gv[1].vx = gv[1].vx + 0xa;
  gv[2].vy = gv[2].vy - 0xa;
  gv[3] = gv[1];
  gv[3].vy = gv[2].vy;

  /* project corners 0..2 with the GTE, link a POLY_FT4 into the ordering table */
  gte_ldv3(&gv[0],&gv[1],&gv[2]);
  gte_rtpt();
  prim = (POLY_FT4 *)Render_gPacketPtr;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x28;
  *(u_int *)Render_gPalettePtr = *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
  *((char *)prim + 3) = 9;                                  /* OT tag length (9 words) */
  gte_stsxy3(&prim->x0,&prim->x1,&prim->x2);

  /* project the 4th corner, set colour+code, copy the per-vertex texture coords from the pixmap */
  gte_ldv0(&gv[3]);
  gte_rtps();
  *(u_int *)&prim->r0 = 0x2e202020;                         /* r0=g0=b0=0x20, code=0x2e (textured FT4) */
  gte_stsxy(&prim->x3);
  pmx = *(Draw_tPixMap **)((char *)gWeatherPixmap + ((int)pt & 4));
  l0 = *(u_int *)pmx;
  l1 = *(u_int *)((char *)pmx + 4);
  l2 = *(u_int *)((char *)pmx + 8);
  l3 = *(u_int *)((char *)pmx + 0xc);
  *(u_int *)&prim->u0 = l0;
  *(u_int *)&prim->u1 = l1;
  *(u_int *)&prim->u2 = l2;
  *(u_int *)&prim->u3 = l3;
}

/* ---- Weather_CreateRain__FP7SVECTORP7DVECTORPc  [WEATHER.CPP:967-1005] SLD-VERIFIED ---- */
void Weather_CreateRain(SVECTOR *pt0,DVECTOR *pt1,char *wd)
{
  LINE_G2 *prim;
  SVECTOR gv;
  int nx;
  int ny;

  gv = *pt0;
  if (*wd != '\0') {
    /* have a previous screen position -> draw the motion-blur streak from it to the current point */
    nx = pt1->vx;
    ny = pt1->vy;
    gte_ldv0(&gv);
    gte_rtps();
    prim = (LINE_G2 *)Render_gPacketPtr;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x14;
    *(u_int *)Render_gPalettePtr = *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
    *((char *)prim + 3) = 4;                       /* OT tag length (4 words) */
    *(u_int *)&prim->r0 = 0x52000000;              /* rgb0=0, code=0x52 (LINE_G2) */
    *(u_int *)&prim->r1 = 0x402020;                /* r1=0x20,g1=0x20,b1=0x40 */
    gte_stsxy(&prim->x1);                          /* current projected pos -> streak end */
    prim->x0 = (short)((nx + prim->x1 * 3) / 4);   /* streak start: weighted toward the end */
    prim->y0 = (short)((ny + prim->y1) / 2);
  }
  else {
    /* first frame for this drop -> zero-length line at the current point */
    gte_ldv0(&gv);
    gte_rtps();
    prim = (LINE_G2 *)Render_gPacketPtr;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x14;
    *(u_int *)Render_gPalettePtr = *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
    *((char *)prim + 3) = 4;
    *(u_int *)&prim->r0 = 0x52000000;
    *(u_int *)&prim->r1 = 0x402020;
    gte_stsxy(&prim->x1);
    *(u_int *)&prim->x0 = *(u_int *)&prim->x1;
  }
  *wd = 1;
  *(u_int *)pt1 = *(u_int *)&prim->x1;             /* save current screen pos as next frame's prev */
}

/* ---- Weather_CreateSplat__FP18Weather_tSplatInfo  [WEATHER.CPP:1009-1035] SLD-VERIFIED ---- */
void Weather_CreateSplat
               (Weather_tSplatInfo *splat)

{
  short screen_x;
  u_char splat_glyph;
  u_long l3;
  int color_pack;
  u_long l0;
  short screen_y;
  int splatTick;
  u_long l1;
  short size_y;
  int uv_pack;
  int pkt_addr24;
  u_long l2;
  short splat_size;
  int tpage_pack;
  short size_x;
  int size;
  short vx;
  short vy;
  u_char *prim;
  u_char *tp3;
  short ts2;
  short ts1;
  short ts3;
  
  prim = Render_gPacketPtr;
  tp3 = Render_gPalettePtr;
  ts3 = (splat->pos).vx;
  ts1 = (splat->pos).vy;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  uv_pack = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x28;
  *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | uv_pack;
  prim[3] = 9;
  prim[7] = 0x2e;
  splat_size = 0x12;
  if (((splat->pos).vx & 1U) != 0) {
    splat_size = 0xc;
  }
  splatTick = simGlobal.gameTicks - splat->startTick;
  splat_glyph = (char)splatTick * -4 + 0x80;
  ts2 = (short)(splatTick >> 3);
  size_x = ts3 - ts2;
  prim[6] = splat_glyph;
  prim[5] = splat_glyph;
  prim[4] = splat_glyph;
  size_y = (ts1 + ts2) - ts2;
  screen_y = ts3 + splat_size + ts2;
  screen_x = ts1 + ts2 + splat_size + ts2 * 2;
  *(short *)(prim + 0x1a) = screen_x;
  *(short *)(prim + 0x22) = screen_x;
  *(short *)(prim + 8) = size_x;
  *(short *)(prim + 10) = size_y;
  *(short *)(prim + 0x10) = screen_y;
  *(short *)(prim + 0x12) = size_y;
  *(short *)(prim + 0x18) = size_x;
  *(short *)(prim + 0x20) = screen_y;
  pkt_addr24 = *(int *)&gWeatherPixmap[2]->u1;
  tpage_pack = *(int *)&gWeatherPixmap[2]->u2;
  color_pack = *(int *)&gWeatherPixmap[2]->u3;
  *(u_int *)(prim + 0xc) = *(u_int *)gWeatherPixmap[2];
  *(int *)(prim + 0x14) = pkt_addr24;
  *(int *)(prim + 0x1c) = tpage_pack;
  *(int *)(prim + 0x24) = color_pack;
  return;
}

/* ---- Weather_DoSplats__FiP18Weather_tSplatInfo  [WEATHER.CPP:1039-1064] SLD-VERIFIED ---- */
void Weather_DoSplats
               (int num,Weather_tSplatInfo *splats)

{
  short y_pos;
  u_int rnd;
  u_int uVar1;
  Weather_tSplatInfo *in_t1_local;
  int i;
  int local_s1_64;
  int num_reg;
  int new_count;
  
  if (gCurrentNumSplats < num) {
    gCurrentNumSplats = num;
  }
  local_s1_64 = 0;
  if (0 < gCurrentNumSplats) {
    do {
      new_count = gCurrentNumSplats;
      if (splats->startTick <= simGlobal.gameTicks) {
        if (splats->startTick + 0x20 < simGlobal.gameTicks) {
          if ((gCurrentNumSplats <= num) ||
             (new_count = local_s1_64, local_s1_64 != gCurrentNumSplats + -1)) {
            rnd = random();
            (splats->pos).vx = (short)rnd + (short)((unsigned long long)rnd * 0xcccccccd >> 0x28) * -0x140;
            if (GameSetup_gData.commMode == 1) {
              uVar1 = random();
              y_pos = (short)(uVar1 % 0xf0 >> 1);
            }
            else {
              uVar1 = random();
              y_pos = (short)uVar1 + (short)(uVar1 / 0xf0) * -0xf0;
            }
            (splats->pos).vy = y_pos;
            uVar1 = random();
            splats->startTick = simGlobal.gameTicks + uVar1 % 100;
            new_count = gCurrentNumSplats;
          }
        }
        else {
          Weather_CreateSplat(splats);
          new_count = gCurrentNumSplats;
        }
      }
      gCurrentNumSplats = new_count;
      splats = splats + 1;
      local_s1_64 = local_s1_64 + 1;
    } while (local_s1_64 < gCurrentNumSplats);
  }
  return;
}

/* ---- Weather_DoWeather__FP13DRender_tView  [WEATHER.CPP:1069-1156] SLD-VERIFIED ---- */
void Weather_DoWeather(DRender_tView *Vi)
{
  SVECTOR *wpt;
  DVECTOR *wprevpt;
  char *wd;
  int player;
  int ab;
  int clean_up;
  int i;
  int n;
  int mode;
  DR_MODE *prim;

  player = Vi->player;
  wpt = Weather_gPServer[player];
  wprevpt = Weather_gPrevPServer[player];
  wd = Weather_gDrawnServer[player];
  if ((GameSetup_gData.commMode != 1) && (0x20 < simGlobal.gameTicks - timechange)) {
    timechange = simGlobal.gameTicks;
    if (Weather_gSnowTrack == 0) {
      Weather_ChangeIntensityBasedOnTime();
    }
    Weather_ChangeDensityBasedOnTime();
  }
  if (Weather_gSys.num[0] != 0) {
    /* force a wasDrawn-clear when the look-behind state or the camera mode just changed */
    ab = Input_gLookBehind[player];
    clean_up = 0;
    if (ab != prevLookBehind[player]) {
      clean_up = ab == 1;
    }
    prevLookBehind[player] = ab;
    mode = Camera_GetMode(player);
    if (mode != prevCameraMode[player]) {
      clean_up = 1;
    }
    prevCameraMode[player] = mode;
    if (clean_up != 0) {
      i = 0;
      if (0 < Weather_gSys.num[player]) {
        do {
          wd[i] = 0;
          i = i + 1;
        } while (i < Weather_gSys.num[player]);
      }
    }
    if (1 < simGlobal.gameTicks - Weather_gLastProcessTime[player]) {
      Weather_gLastProcessTime[player] = simGlobal.gameTicks;
      Weather_ProcessParticles(Vi,Weather_gSys.num[player],wpt,wd);
    }
    Weather_SetIdentMatrix();
    if (Camera_gInfo[player].inCar) {
      Weather_DoSplats(Weather_gSys.num[player] >> 3,Weather_gSplatInfoServer[player]);
    }
    /* emit one snow/rain primitive per particle; wpt + wprevpt advance in lockstep */
    n = 0;
    if (0 < Weather_gSys.num[player]) {
      do {
        if (Weather_gType == Weather_kRain) {
          Weather_CreateRain(wpt,wprevpt,wd + n);
        }
        else {
          Weather_CreateSnow(wpt);
        }
        wpt = wpt + 1;
        wprevpt = wprevpt + 1;
        n = n + 1;
      } while (n < Weather_gSys.num[player]);
    }
    /* tail: link a DR_MODE primitive into the OT to reset the texture page */
    prim = (DR_MODE *)Render_gPacketPtr;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *(u_int *)Render_gPalettePtr = *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
    SetDrawMode(prim,0,0,0x20,(RECT *)0x0);
  }
}

/* ---- Weather_BuildWeather__FP13DRender_tView  [WEATHER.CPP:1159-1186] SLD-VERIFIED ---- */
void Weather_BuildWeather(DRender_tView *Vi)

{
  void *pvVar1;

  if ((GameSetup_gData.Weather != 0) &&
     (pvVar1 = BWorldSm_TunnelFlagSm
                         (&Camera_gInfo[Vi->player].slicePos), pvVar1 == (void *)0x0)) {
    Weather_DoWeather(Vi);
  }
  return;
}

/* end of weather.cpp */

/* owning-TU def (link-harness) */
int timechange;
