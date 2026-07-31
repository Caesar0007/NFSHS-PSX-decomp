/* frontend/common/weather.cpp -- RECONSTRUCTED (NFS4 PSX particle weather; C++ TU)
 *   25 free fns Weather_*: snow/rain/splat particle system. State machine (density/intensity),
 *   GTE-transformed particle rendering. GTE COP2 ops via PsyQ libgte macros (weather_externs.h).
 */
#include "../../nfs4_types.h"
#include "weather_externs.h"

/* This TU's original obj (WEATHER.CPP) reaches the packet/palette scratchpad pointers via their
 * FIXED scratchpad storage address (0x1F800004 / 0x1F800000) rather than the linked symbol --
 * every oracle site (Weather_CreateSnow/CreateRain/CreateSplat/DoWeather) shows a literal
 * lui-ori 0x1F800004 / lui-lw 0x1F800000, not a %hi/%lo(sym) reloc (same pattern already
 * fixed in game/psx/sfx.cpp's Sfx_AdditivePrim/Sfx_BuildSouffleFacet). */
#define RENDER_PACKETPTR_ADDR (*(u_char **)0x1F800004)
#define RENDER_PALETTEPTR_ADDR (*(u_char **)0x1F800000)

/* Weather_gLastProcessTime[2] (weather_externs.h) is declared as ONE 8-byte array, but the
 * Weather_Init/Weather_Restart oracles reach its CONSTANT-index elements as TWO INDEPENDENT
 * %gp_rel(D_8013DE54)/%gp_rel(D_8013DE58) globals -- no address materialization at all -- not
 * via a computed array-index off one base (8 bytes is over this build's -G4 small-data
 * threshold as ONE object, but each 4-byte element alone qualifies). Model that TRUE per-element
 * storage as two real tentative-def scalars (section 3.12 #6 gp-rel-owner lever, applied per-
 * element) for those two constant-index call sites. Weather_DoWeather's VARIABLE-index access
 * (player 0/1) instead genuinely needs base+offset array codegen in its oracle (real `addu
 * a1,s0,v0` with s0=player<<2) -- unresolved as its own near-miss, not attempted this pass --
 * so it keeps referencing the header's array form, tentative-defined here as a SEPARATE object
 * (0-initialized same as the scalars; Init/Restart write both forms in every real code path so
 * they stay in sync at runtime -- a known duality to collapse when Weather_DoWeather is sealed). */
int Weather_gLastProcessTime0;
int Weather_gLastProcessTime1;
#define WEATHER_GLASTPROCESSTIME0 Weather_gLastProcessTime0
#define WEATHER_GLASTPROCESSTIME1 Weather_gLastProcessTime1
int Weather_gLastProcessTime[2];

/* ---- SPLIT-STORAGE data-mat for the four per-player server arrays (w39-a6) ----------------
 * Oracle evidence (Weather_Init__Fv.s): every CONSTANT-index element is reached through its
 * OWN one-instruction %gp_rel symbol -- %gp_rel(Weather_gSplatInfoServer) for [0] and
 * %gp_rel(D_8013DBCC) for [1], likewise Weather_gPServer/D_8013DBD4,
 * Weather_gPrevPServer/D_8013DBDC, Weather_gDrawnServer/D_8013DBE4.  An `extern T x[2]`
 * declaration can NEVER produce that: 8 bytes is over this build's -G4 threshold as ONE
 * object, so both elements come out as absolute lui/%lo pairs (+1 insn each, 8 sites).
 * Each 4-byte ELEMENT alone IS gp-eligible, so the true storage shape is one tentative def
 * per element (methodology 3.12 #6 applied per-element).
 * The RUNTIME-index site (Weather_DoWeather `[player]`) genuinely wants an absolute array
 * base -- its oracle has `lui/addiu %hi/%lo(Weather_gPServer)` etc.  That is served by an
 * UNSIZED asm-label array VIEW aliased onto element [0]'s symbol: unsized + extern keeps it
 * out of maspsx's sbss_entries, and `gp_allow_la` is off, so `la` stays absolute.  The view
 * ALIASES the real storage (no duplicated object, unlike the older gLastProcessTime duality). */
Weather_tSplatInfo *Weather_gSplatInfoServer;   /* [0] @0x8013dbc8 */
Weather_tSplatInfo *Weather_gSplatInfoServer1;  /* [1] @0x8013dbcc (oracle D_8013DBCC) */
SVECTOR            *Weather_gPServer;           /* [0] @0x8013dbd0 */
SVECTOR            *Weather_gPServer1;          /* [1] @0x8013dbd4 (oracle D_8013DBD4) */
DVECTOR            *Weather_gPrevPServer;       /* [0] @0x8013dbd8 */
DVECTOR            *Weather_gPrevPServer1;      /* [1] @0x8013dbdc (oracle D_8013DBDC) */
char               *Weather_gDrawnServer;       /* [0] @0x8013dbe0 */
char               *Weather_gDrawnServer1;      /* [1] @0x8013dbe4 (oracle D_8013DBE4) */

extern Weather_tSplatInfo *Weather_gSplatInfoServerA[] asm("Weather_gSplatInfoServer");
extern SVECTOR            *Weather_gPServerA[]         asm("Weather_gPServer");
extern DVECTOR            *Weather_gPrevPServerA[]     asm("Weather_gPrevPServer");
extern char               *Weather_gDrawnServerA[]     asm("Weather_gDrawnServer");

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

/* ---- Weather_SetMatrix__FP10matrixtdef  [WEATHER.CPP:112-123] SLD-VERIFIED ----
 * SEALED (49/49 PASS): SYM shows THREE nested block scopes each with fresh r0/r1/r2
 * (third block's r2 = $4/a0 reuses the dead param reg). MATCH: SYM block scopes are
 * load-bearing (catalog SS A DrawW_WorldSetUpMatrix row) -- one fn-scope decl set kept
 * the block-1 coloring on the last row. */
void Weather_SetMatrix(matrixtdef *m)
{
  MATRIX mpsx;

  {
    int r0;
    int r1;
    int r2;

    r0 = m->m[0];
    r1 = m->m[3];
    r2 = m->m[6];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mpsx.m[0][0] = (short)r0;
    mpsx.m[0][1] = (short)r1;
    mpsx.m[0][2] = (short)r2;
  }
  {
    int r0;
    int r1;
    int r2;

    r0 = m->m[1];
    r1 = m->m[4];
    r2 = m->m[7];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mpsx.m[1][0] = (short)r0;
    mpsx.m[1][1] = (short)r1;
    mpsx.m[1][2] = (short)r2;
  }
  {
    int r0;
    int r1;
    int r2;

    r0 = m->m[2];
    r1 = m->m[5];
    r2 = m->m[8];
    mpsx.t[0] = 0;
    mpsx.t[1] = 0;
    mpsx.t[2] = 0;
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mpsx.m[2][0] = (short)r0;
    mpsx.m[2][1] = (short)r1;
    mpsx.m[2][2] = (short)r2;
  }
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

/* ---- Weather_InitSplats__Fv  [WEATHER.CPP:182-191] SLD-VERIFIED ----
 * NEAR-MISS 7 diffs (68/69 insns, down from 11): moving `splat_i = 0` to be the FIRST statement
 * (before gs/commModeNetwork) fixed the callee-saved SAVE ORDER (oracle inits+saves $s2 first, as
 * the loop counter is the first-used var per IDA sub_800E1FD8). Also made the return type the TRUE
 * `int` per IDA (`BOOL f(){ for(i=0;;++i){ result=i<19; if(i>=19)break; ...} return result; }`) --
 * the SYM types it VOID but the codegen returns the loop's final `i<19` in $v0 (same void-return
 * mistype class as Ghidra, methodology 3.2; the sole caller ignores the value so `int` is harmless).
 * Kept the plain `% 320`/`% y_max`/`% 300` (gcc-2.8 -O2 auto-emits the multu+mfhi magic-divide; a
 * 64-bit cast forced an unwanted mflo). SEALED (69/69 PASS): the no-rotation shape is the catalog
 * B-row EXIT-IN-THE-MIDDLE form -- `while(true){ result = i<19; if (result==0) break; body; i++; }`
 * (increment at body END, break tested via the result var, NOT a for(;;i++) head-increment) keeps
 * the oracle's top-test `slti;beqz->exit` + unconditional `j` back-edge. MATCH: exit-in-the-middle
 * no-rotation + result-var break. */
int Weather_InitSplats(void)

{
  u_int rnd;
  u_int uVar1;
  int ySize;
  u_int y_max;
  int i;
  int splat_i;
  int result;
  GameSetup_tData *gs;
  int commModeNetwork;

  splat_i = 0;
  gs = &GameSetup_gData;
  commModeNetwork = 1;
  while (true) {
    result = splat_i < 0x13;
    if (result == 0) break;
    y_max = 0xf0;
    if (gs->commMode == commModeNetwork) {
      y_max = 0x78;
    }
    rnd = random();
    Weather_gSplatInfo[splat_i].pos.vx = (short)(rnd % 320);
    uVar1 = random();
    if (y_max == 0) {
    }
    Weather_gSplatInfo[splat_i].pos.vy = (short)(uVar1 % y_max);
    uVar1 = random();
    Weather_gSplatInfo[splat_i].startTick = uVar1 % 300;
    splat_i = splat_i + 1;
  }
  return result;
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

/* ---- Weather_ChangeDensityState__Fv  [WEATHER.CPP:253-269] SLD-VERIFIED ----
 * Oracle keeps Weather_GetNewState()'s result in a REGISTER ($a0) through both conditional
 * overrides, only committing to Weather_gDensityChangeFactor ONCE at the end (with the goalState
 * add + the ==0 check both reading that same held value) -- not re-storing the raw pre-override
 * return value to the global first. */
void Weather_ChangeDensityState(void)

{
  int statechange;
  int goalPlusChange;

  statechange = Weather_GetNewState();
  goalPlusChange = Weather_gDensityGoalState + statechange;
  if (goalPlusChange >= 4) {
    statechange = -1;
  }
  else if (goalPlusChange < 0) {
    statechange = 1;
  }
  Weather_gDensityChangeFactor = statechange;
  Weather_gDensityGoalState = Weather_gDensityGoalState + statechange;
  if (statechange == 0) {
    Weather_gDensityTimerGoal = simGlobal.gameTicks + 0x400;
  }
  return;
}

/* ---- Weather_ChangeIntensityState__Fv  [WEATHER.CPP:273-292] SLD-VERIFIED ----
 * Same held-register-temp fix as Weather_ChangeDensityState: keep Weather_GetNewState()'s result
 * in a local through both conditional overrides, commit to the global ONCE at the end. */
void Weather_ChangeIntensityState(void)

{
  int statechange;
  int goalPlusChange;

  statechange = Weather_GetNewState();
  goalPlusChange = Weather_gIntensityGoalState + statechange;
  if (Weather_gTrackIntensityLimit < goalPlusChange) {
    statechange = -1;
  }
  else if (goalPlusChange < 0) {
    statechange = 1;
  }
  Weather_gIntensityChangeFactor = statechange;
  Weather_gIntensityGoalState = Weather_gIntensityGoalState + statechange;
  if (statechange == 0) {
    Weather_gIntensityTimerGoal = simGlobal.gameTicks + 0x400;
  }
  return;
}

/* ---- Weather_ChangeDensityBasedOnTime__Fv  [WEATHER.CPP:296-319] SLD-VERIFIED ---- */
void Weather_ChangeDensityBasedOnTime(void)

{
  if (Weather_gDensityChangeFactor <= 0) goto WeatherDensity_checkZero;
  if (Weather_gSys.num[0] < Weather_gDensityTbl[Weather_gDensityGoalState])
  goto WeatherDensity_numAdd;
  goto WeatherDensity_call;
WeatherDensity_checkZero:
  if (Weather_gDensityChangeFactor >= 0) goto WeatherDensity_checkTime;
  if (!(Weather_gSys.num[0] > Weather_gDensityTbl[Weather_gDensityGoalState]))
  goto WeatherDensity_call;
  goto WeatherDensity_numAdd;
WeatherDensity_checkTime:
  if (simGlobal.gameTicks <= Weather_gDensityTimerGoal) goto WeatherDensity_numAdd;
WeatherDensity_call:
  Weather_ChangeDensityState();
WeatherDensity_numAdd:
  Weather_gSys.num[0] = Weather_gSys.num[0] + Weather_gDensityChangeFactor;
  if (Weather_gSys.num[0] < 1) {
    Weather_gSys.num[0] = 0;
  }
  return;
}

/* ---- Weather_ChangeIntensityBasedOnTime__Fv  [WEATHER.CPP:323-350] SLD-VERIFIED ----
 * NEAR-MISS 4 diffs (62/62 insns, down from 56 diffs): goto-based control-flow rewrite matching
 * the oracle's exact branch graph (fixes the Weather_ChangeDensityBasedOnTime family of bugs) +
 * explicit if/else for the Weather_gType tail (was a compact bool-store). Residual: one
 * beqz/bnez polarity flip on the FIRST branch's slt -- direct-condition form places the slt
 * correctly but wrong branch sense; negated form gets the right branch sense but the compiler
 * hoists the slt past an unconditional j (looks like a scheduling tie-break, same family as the
 * TrsProj_TransformProjectVertex register-coloring residual). Tried >=, <=-with-swapped-operands,
 * !(<) -- none land both position AND polarity simultaneously. */
void Weather_ChangeIntensityBasedOnTime(void)

{
  if (Weather_gIntensityChangeFactor <= 0) goto WeatherIntensity_checkZero;
  if (!((int)Weather_gSys.velocity.vy < Weather_gIntensityTbl[Weather_gIntensityGoalState]))
  goto WeatherIntensity_call;
  goto WeatherIntensity_velYUpdate;
WeatherIntensity_checkZero:
  if (Weather_gIntensityChangeFactor >= 0) goto WeatherIntensity_checkTime;
  if ((int)Weather_gSys.velocity.vy > Weather_gIntensityTbl[Weather_gIntensityGoalState])
  goto WeatherIntensity_velYUpdate;
  goto WeatherIntensity_call;
WeatherIntensity_checkTime:
  if (simGlobal.gameTicks <= Weather_gIntensityTimerGoal) goto WeatherIntensity_velYUpdate;
WeatherIntensity_call:
  Weather_ChangeIntensityState();
WeatherIntensity_velYUpdate:
  Weather_gSys.velocity.vy = Weather_gSys.velocity.vy + (short)Weather_gIntensityChangeFactor;
  if (Weather_gSys.velocity.vy < -0x20) {
    Weather_gType = 1;
  }
  else {
    Weather_gType = 0;
  }
  return;
}

/* ---- Weather_InitStateControls__Fv  [WEATHER.CPP:355-387] SLD-VERIFIED ---- */
void Weather_InitStateControls(void)

{
  int track;

  track = GameSetup_gData.track;
  Weather_gTrackIntensityLimit = Weather_gTrackIntensityLimitTbl[track];
  if ((track == 0) || (track == 4)) {
    Weather_gSnowTrack = 1;
    Weather_gIntensityGoalState = 3;
  }
  else {
    Weather_gSnowTrack = 0;
    Weather_gIntensityGoalState = 0;
  }
  Weather_gSys.velocity.vy = (short)Weather_gIntensityTbl[Weather_gIntensityGoalState];
  if (Weather_gIntensityGoalState == 3) {
    Weather_gType = 0;
  }
  else {
    Weather_gType = 1;
  }
  Weather_gDensityGoalState = 3;
  Weather_gIntensityChangeFactor = 0;
  Weather_gDensityChangeFactor = 0;
  Weather_gIntensityTimerGoal = simGlobal.gameTicks + 0x400;
  Weather_gSys.num[0] = Weather_gDensityTbl[3];
  Weather_gDensityTimerGoal = simGlobal.gameTicks + 0x400;
  timechange = simGlobal.gameTicks;
  return;
}

/* ---- Weather_Restart__Fv  [WEATHER.CPP:391-402] SLD-VERIFIED ----
 * SEALED (was NEAR-MISS 18 diffs, ours 33/oracle 31): the two Weather_gLastProcessTime[N]=
 * simGlobal.gameTicks stores were emitting absolute lui/addiu addressing off ONE shared base
 * register (gcc CSE'd the array base across both constant-index stores), while the oracle
 * reaches each element via its OWN independent %gp_rel(D_8013DE54/58) -- no address
 * materialization at all. Root cause: the split-per-element storage fix above (see the
 * WEATHER_GLASTPROCESSTIME0/1 comment near the top of the file). Fixed by writing through
 * those two real tentative-def scalars instead of Weather_gLastProcessTime[N]; PASS 31/31. */
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
    WEATHER_GLASTPROCESSTIME1 = simGlobal.gameTicks;
    WEATHER_GLASTPROCESSTIME0 = simGlobal.gameTicks;
    do {
      pcVar1 = Weather_gWasDrawn + iVar2;
      iVar2 = iVar2 + 1;
      *pcVar1 = '\0';
    } while (iVar2 < 0x98);
  }
  return;
}

/* ---- Weather_Init__Fv  [WEATHER.CPP:414-496] SLD-VERIFIED ----
 * NEXT LEVER (w38-a8, measured but NOT applied -- needs a coordinated data-mat pass):
 * the dominant residual here is gp-rel-vs-absolute.  The oracle reaches the four
 * per-player server arrays through PER-ELEMENT gp-rel symbols --
 *   Weather_gSplatInfoServer / D_8013DBCC(=+4), Weather_gPServer / D_8013DBD4(+4),
 *   Weather_gPrevPServer / D_8013DBDC(+4), Weather_gDrawnServer / D_8013DBE4(+4)
 * (also D_8013DE4C/54/58) -- while this TU only declares them `extern T x[2]`, so we
 * emit absolute lui/%lo pairs.  They are owned by weather.cpp (no other TU references
 * them: `grep -rl Weather_gPServer recon/` = weather.cpp + its externs header).
 * FIX = the established in-file duality (see the Weather_gLastProcessTime0/1 block at
 * the top of this file): tentative-define one 4-byte scalar PER ELEMENT for the
 * CONSTANT-index sites (Weather_Init) and keep the real `T x[2]` array for the
 * variable-index sites (Weather_DoWeather's `[player]`), writing both at every
 * mutation.  SYM block locals for this fn: i $s0 (block @line 7), sv $s2 (PTR SVECTOR,
 * block @line 62). */
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
    WEATHER_GLASTPROCESSTIME1 = simGlobal.gameTicks;
    WEATHER_GLASTPROCESSTIME0 = simGlobal.gameTicks;
    Weather_gPServer = Weather_gPos;
    Weather_gPrevPServer = Weather_gPrevPos;
    Weather_gDrawnServer = Weather_gWasDrawn;
    Weather_gSplatInfoServer = Weather_gSplatInfo;
    if (GameSetup_gData.commMode == 1) {
      Weather_gPServer1 = Weather_gPos + 0x4c;
      Weather_gPrevPServer1 = Weather_gPrevPos + 0x4c;
      Weather_gDrawnServer1 = Weather_gWasDrawn + 0x4c;
      Weather_gSys.num[0] = 0x4c;
      Weather_gSys.num[1] = 0x4c;
      Weather_gSplatInfoServer1 = Weather_gSplatInfo + 9;
    }
    /* MATCH (w39-a6): these four are plain STRUCT ASSIGNMENTS, not the hand-unrolled
     * copy loops Ghidra printed.  The oracle emits gcc's own movstrsi expansion:
     * coorddef (12B) -> straight-line 3x lw + 3x sw; matrixtdef (36B) -> a 4-word/iter
     * loop with an end-pointer `bne` + a 1-word tail (methodology 3.25 3d(a)).  Note the
     * second copy of each pair READS BACK the destination just written (prevCamPos[1],
     * prevCamMat[0]) -- the oracle's `lw t2,12(v1)` / `addu v1,a3,zero` prove the source
     * is the freshly-stored copy, not a second read of Camera_gInfo. */
    /* MATCH (w39-a6): TWO separate base locals.  The oracle carries an extra
     * `addu t1,a3,zero` copy of &prevCamMat that is used ONLY as the second copy's
     * destination base (`addiu a0,t1,36`) -- the cse.c double-evaluation shape
     * (catalog: one anonymous + one named evaluation of the same address expr yields
     * a register COPY).  One shared local is 1 insn short and shifts the whole
     * movstrsi scratch pool down a register (t1-t4 vs the oracle's t2-t5): 85 diffs.
     * Two locals => 211/211 count-exact and the entire block byte-matches (12 diffs). */
    pmVar5 = prevCamMat;
    pmVar4 = prevCamMat;
    prevCamPos[1] = Camera_gInfo[0].position;
    prevCamPos[0] = prevCamPos[1];
    pmVar5[0] = Camera_gInfo[0].rotation;
    pmVar4[1] = pmVar5[0];
    pSVar10 = Weather_gPos;
    iVar6 = 0x97;
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

/* ---- Weather_TransformVertex__FP10matrixtdefiP7SVECTOR  [WEATHER.CPP:581-615] SLD-VERIFIED ----
 * NEAR-MISS 32 diffs (49/49 insns, down from 39): moved the loop's break-test BEFORE `next=s+1`
 * (oracle computes `next` only on the non-exiting path) -- the earlier form computed `next`
 * unconditionally every iteration incl. the final exit. Residual: a pure `next` register
 * coloring swap (ours=v0, oracle=a1) cascading into the tv.vx/vy/vz field-register triple
 * shifting by one slot; no ABI anchor found (next isn't a call-arg/return at its use point) --
 * same permuter-class coloring-tiebreak family as TrsProj_TransformProjectVertex. */
void Weather_TransformVertex(matrixtdef *m,int n,SVECTOR *s)
{
  int r0;
  int r1;
  int r2;
  VECTOR tv;
  SVECTOR *next;

  Weather_SetMatrix(m);
  gte_ldv0(s);
  gte_mvmva(1,0,0,0,0);
  n = n + -1;
  gte_stlvnl(&tv);
  while (true) {
    n = n + -1;
    if (n == -1) break;
    next = s + 1;
    gte_ldv0(next);
    gte_mvmva(1,0,0,0,0);
    r0 = tv.vx;
    r1 = tv.vy;
    r2 = tv.vz;
    s->vx = (short)r0;
    s->vy = (short)r1;
    s->vz = (short)r2;
    gte_stlvnl(&tv);
    s = next;
  }
  r0 = tv.vx;
  r1 = tv.vy;
  r2 = tv.vz;
  s->vx = (short)r0;
  s->vy = (short)r1;
  s->vz = (short)r2;
}

/* ---- Weather_CheckAndResetParticles__FP7SVECTOR  [WEATHER.CPP:623-668] SLD-VERIFIED ----
 * SEALED w39-a6 (was 118 diffs, ours 215 / oracle 223).  Four levers:
 *  1. NO shared-tail gotos.  Ghidra funnelled the six wrap arms through
 *     `goto WeatherReset_frontWrap/topCheck` shared stores; the oracle writes the full
 *     `pt->vX = base + random()%span` in EACH arm and lets gcc cross-jump-merge only the
 *     last 2 insns (`addu v0,v0,v1; sh v0,OFF(s2)`).  A source-level funnel merges far
 *     more than retail did (catalog: funnel vars/labels PREVENT the match).
 *  2. `-Weather_gSys.width + 0x40`, not `0x40 - Weather_gSys.width` (oracle negu+addiu 64
 *     vs our li 64 + subu).
 *  3. `zfar / 2` written as a plain signed divide -- the transcribed magic
 *     `(a - (a>>31)) >> 1` emits sra+subu where gcc's own /2 idiom is srl 31 + addu.
 *  4. COMPARE OPERAND ORDER = evaluation order: the oracle loads `pt->vX` BEFORE the
 *     Weather_gSys field, so the tests must be spelled `pt->vx > Weather_gSys.width`
 *     (not `width < pt->vx`).  That was the last 6 diffs -> PASS 223/223. */
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
  if ((int)pt->vx > (int)Weather_gSys.width) {
    pt->vx = (short)(-Weather_gSys.width + 0x40);
    rnd = random();
    if ((int)Weather_gSys.height == 0) {
    }
    pt->vy = Weather_gSys.bottom + (short)(rnd % (u_int)(int)Weather_gSys.height);
    uVar1 = random();
    if ((int)Weather_gSys.length == 0) {
    }
    pt->vz = Weather_gSys.znear + (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    sVar3 = 1;
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
    pt->vz = Weather_gSys.znear + (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    sVar3 = 2;
  }
  if (pt->vz > Weather_gSys.zfar) {
    pt->vz = Weather_gSys.znear + 0x40;
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    if ((int)Weather_gSys.height == 0) {
    }
    pt->vy = Weather_gSys.bottom + (short)(uVar1 % (u_int)(int)Weather_gSys.height);
    sVar3 = 3;
  }
  else if ((int)pt->vz < (int)Weather_gSys.znear) {
    sVar3 = 4;
    uVar1 = random();
    uVar2 = (u_int)(((int)((u_int)(u_short)Weather_gSys.zfar << 0x10) >> 0x10) / 2);
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
    pt->vy = Weather_gSys.bottom + (short)(uVar1 % (u_int)(int)Weather_gSys.height);
  }
  if (pt->vy > Weather_gSys.top) {
    pt->vy = Weather_gSys.bottom + 0x40;
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    if ((int)Weather_gSys.length == 0) {
    }
    pt->vz = Weather_gSys.znear + (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    sVar3 = 5;
  }
  else if ((int)pt->vy < (int)Weather_gSys.bottom) {
    pt->vy = Weather_gSys.top + -0x40;
    uVar1 = random();
    if ((int)Weather_gSys.width == 0) {
    }
    pt->vx = (short)(uVar1 % (u_int)(int)Weather_gSys.width) * 2 - Weather_gSys.width;
    uVar1 = random();
    if ((int)Weather_gSys.length == 0) {
    }
    pt->vz = Weather_gSys.znear + (short)(uVar1 % (u_int)(int)Weather_gSys.length);
    sVar3 = 6;
  }
  return sVar3;
}

/* ---- Weather_QuickReOrthogonalize__FP10matrixtdefT0  [WEATHER.CPP:673-700] SLD-VERIFIED ----
 * SYM (fsize 72, ra+s0-s7): rot $s5, rotNew $s4; AUTO upvector @-0x38 (coorddef);
 * REG locals nrotx $s4(=rotNew), nroty $s6, nrotz $s3, roty $s7, rotz $s2.
 * 🔴 BUG FIXED: the previous body initialised `upvector` from prevLookBehind[]/
 * prevCameraMode[] (Weather_DoWeather's file statics) -- the raw oracle copies the
 * three words of the .rodata constant D_80056B2C = {0, 0x10000, 0} (the +Y world-up
 * vector, 16.16) into the stack slot, i.e. an initialised local aggregate.  The old
 * form read unrelated globals => wrong up-vector at runtime.
 * The dot product is expanded THREE times (test + both ternary arms) = an ABS() macro
 * over a DOT() macro, and there is no SYM local for it. */
void Weather_QuickReOrthogonalize
               (matrixtdef *rot,matrixtdef *rotNew)

{
  coorddef upvector = {0,0x10000,0};
  coorddef *nrotx;
  coorddef *nroty;
  coorddef *nrotz;
  coorddef *roty;
  coorddef *rotz;

  nrotx = (coorddef *)rotNew;
  nroty = (coorddef *)(rotNew->m + 3);
  nrotz = (coorddef *)(rotNew->m + 6);
  roty = (coorddef *)(rot->m + 3);
  rotz = (coorddef *)(rot->m + 6);
  *nrotz = *rotz;
  Math_NormalizeVector(nrotz);
  if (0xfd70 <
      (0 < fixedmult(upvector.x,rotz->x) + fixedmult(upvector.y,rotz->y) +
           fixedmult(upvector.z,rotz->z) ?
       fixedmult(upvector.x,rotz->x) + fixedmult(upvector.y,rotz->y) +
       fixedmult(upvector.z,rotz->z) :
       -(fixedmult(upvector.x,rotz->x) + fixedmult(upvector.y,rotz->y) +
         fixedmult(upvector.z,rotz->z)))) {
    upvector = *roty;
  }
  nrotx->x = fixedmult(upvector.y,nrotz->z) - fixedmult(upvector.z,nrotz->y);
  nrotx->y = fixedmult(upvector.z,nrotz->x) - fixedmult(upvector.x,nrotz->z);
  nrotx->z = fixedmult(upvector.x,nrotz->y) - fixedmult(upvector.y,nrotz->x);
  Math_NormalizeVector(nrotx);
  nroty->x = fixedmult(nrotz->y,nrotx->z) - fixedmult(nrotz->z,nrotx->y);
  nroty->y = fixedmult(nrotz->z,nrotx->x) - fixedmult(nrotz->x,nrotx->z);
  nroty->z = fixedmult(nrotz->x,nrotx->y) - fixedmult(nrotz->y,nrotx->x);
  return;
}
/* ---- Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc  [WEATHER.CPP:704-887] SLD-VERIFIED ----
 * SYM (fsize 264, ra+s0-s6): Vi $s3, num $s4, wpt $s5, wd $s6; fn-block n $t2 +
 * AUTOs matdiff -0xf8, orthoMat -0xd0, velocity_vector_change -0xa8,
 * total_vector_change -0xa0, Weather_gTransformedRandomVelocityVectors[12] -0x80.
 * SIBLING BLOCKS each redeclare temp_vector -0x98 / result -0x90 (and the particle
 * loop's `pt` shares the -0x98 slot) -- one fn-scope decl set costs an extra 8 bytes
 * of frame.  The particle loop has its OWN `n` (SYM: class REG type LONG, $s0).
 * 🔴 BUG: the turbulence table reads must be SIGN-extended (oracle sll 24/sra 24);
 * `char` is UNSIGNED on this build, so the plain char reads silently turned negative
 * velocity components into +128..+255.
 */
void Weather_ProcessParticles(DRender_tView *Vi,int num,SVECTOR *wpt,char *wd)
{
  int n;
  matrixtdef matdiff;
  matrixtdef orthoMat;
  SVECTOR velocity_vector_change;
  SVECTOR total_vector_change;
  SVECTOR temp_vector;
  VECTOR result;
  SVECTOR Weather_gTransformedRandomVelocityVectors [12];

  /* re-orthogonalize the camera matrix, build the frame-to-frame difference matrix, and transform
     every particle by it so the whole field rotates rigidly with the camera */
  Weather_QuickReOrthogonalize(&Vi->cview.mrotationInvRaw,&orthoMat);
  Math_fasttransmult(&prevCamMat[Vi->player],&orthoMat,&matdiff);
  transpose(&orthoMat,&prevCamMat[Vi->player]);
  Weather_TransformVertex(&matdiff,num,wpt);
  Weather_SetMatrix(&Vi->cview.mrotationInvRaw);

  /* camera translation delta since last frame, rotated into camera space -> total_vector_change */
  {
    coorddef *cp;

    coorddef *tr = &Vi->cview.translation;

    temp_vector.vx = (short)((Vi->cview.translation.x - prevCamPos[Vi->player].x) / 0x400);
    temp_vector.vy = (short)((tr->y - prevCamPos[Vi->player].y) / 0x400);
    temp_vector.vz = (short)((tr->z - prevCamPos[Vi->player].z) / 0x400);
    gte_ldv0(&temp_vector);
    gte_mvmva(1,0,0,0,0);
    cp = &prevCamPos[Vi->player];
    *cp = *tr;
    gte_stlvnl(&result);
    total_vector_change.vx = -(short)result.vx;
    total_vector_change.vy = -(short)result.vy;
    total_vector_change.vz = -(short)result.vz;
  }

  /* wind/gravity velocity, rotated into camera space; folded into total_vector_change */
  {
    SVECTOR *vel = &Weather_gSys.velocity;

    temp_vector.vx = vel->vx;
    temp_vector.vy = vel->vy;
    temp_vector.vz = vel->vz;
    gte_ldv0(&temp_vector);
    gte_mvmva(1,0,0,0,0);
    gte_stlvnl(&result);
    velocity_vector_change.vx = (short)result.vx;
    velocity_vector_change.vy = (short)result.vy;
    velocity_vector_change.vz = (short)result.vz;
    total_vector_change.vx = total_vector_change.vx + velocity_vector_change.vx;
    total_vector_change.vz = total_vector_change.vz + velocity_vector_change.vz;
    total_vector_change.vy = total_vector_change.vy + velocity_vector_change.vy;
  }

  /* rotate the 12 turbulence velocity vectors into camera space (frame-local copy) */
  {
    signed char *vel;

    vel = (signed char *)Weather_gRandomVelocityVectors;
    n = 0;
    while (1) {
      if (12 <= n) break;
      temp_vector.vx = vel[0];
      temp_vector.vy = vel[1];
      temp_vector.vz = vel[2];
      gte_ldv0(&temp_vector);
      gte_mvmva(1,0,0,0,0);
      gte_stlvnl(&result);
      Weather_gTransformedRandomVelocityVectors[n].vx = (short)result.vx;
      Weather_gTransformedRandomVelocityVectors[n].vy = (short)result.vy;
      Weather_gTransformedRandomVelocityVectors[n].vz = (short)result.vz;
      vel = vel + 3;
      n = n + 1;
    }
  }

  /* advance every particle by (camera comp + wind) + its turbulence vector; wrap + flag resets */
  {
    SVECTOR *tv;
    long n;
    short reset;

    tv = wpt;
    n = 0;
    while (1) {
      if (num <= n) break;
      temp_vector.vx = Weather_gTransformedRandomVelocityVectors[n % 12].vx +
              (tv->vx + total_vector_change.vx);
      temp_vector.vy = Weather_gTransformedRandomVelocityVectors[n % 12].vy +
              (tv->vy + total_vector_change.vy);
      temp_vector.vz = Weather_gTransformedRandomVelocityVectors[n % 12].vz +
              (tv->vz + total_vector_change.vz);
      reset = Weather_CheckAndResetParticles(&temp_vector);
      /* MATCH: the oracle writes vx+vy as ONE aligned word (lw 0x70(sp); sw 0(s2))
       * then vz as a halfword -- a COORD16/6-byte struct assign compiles to the
       * align-2 lwl/lwr/swl/swr soup instead, so the word pun is the faithful form. */
      *(long *)&tv->vx = *(long *)&temp_vector.vx;
      tv->vz = temp_vector.vz;
      if (reset != 0) {
        wd[n] = 0;
      }
      tv = tv + 1;
      n = n + 1;
    }
  }
}
/* ---- Weather_CreateSnow__FP7SVECTOR  [WEATHER.CPP:923-961] SLD-VERIFIED ---- */
void Weather_CreateSnow(SVECTOR *pt)
{
  SVECTOR gv [4];
  POLY_FT4 *prim;
  Draw_tPixMap *pmx;
  u_int *pal;
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
  prim = (POLY_FT4 *)RENDER_PACKETPTR_ADDR;
  pal = (u_int *)RENDER_PALETTEPTR_ADDR;
  *(u_int *)prim = *(u_int *)prim & 0xff000000 | *pal & 0xffffff;
  RENDER_PACKETPTR_ADDR = RENDER_PACKETPTR_ADDR + 0x28;
  *pal = *pal & 0xff000000 | (u_int)prim & 0xffffff;
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
    prim = (LINE_G2 *)RENDER_PACKETPTR_ADDR;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)RENDER_PALETTEPTR_ADDR & 0xffffff;
    RENDER_PACKETPTR_ADDR = RENDER_PACKETPTR_ADDR + 0x14;
    *(u_int *)RENDER_PALETTEPTR_ADDR = *(u_int *)RENDER_PALETTEPTR_ADDR & 0xff000000 | (u_int)prim & 0xffffff;
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
    prim = (LINE_G2 *)RENDER_PACKETPTR_ADDR;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)RENDER_PALETTEPTR_ADDR & 0xffffff;
    RENDER_PACKETPTR_ADDR = RENDER_PACKETPTR_ADDR + 0x14;
    *(u_int *)RENDER_PALETTEPTR_ADDR = *(u_int *)RENDER_PALETTEPTR_ADDR & 0xff000000 | (u_int)prim & 0xffffff;
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
  
  prim = RENDER_PACKETPTR_ADDR;
  tp3 = RENDER_PALETTEPTR_ADDR;
  ts3 = (splat->pos).vx;
  ts1 = (splat->pos).vy;
  *(u_int *)RENDER_PACKETPTR_ADDR =
       *(u_int *)RENDER_PACKETPTR_ADDR & 0xff000000 | *(u_int *)RENDER_PALETTEPTR_ADDR & 0xffffff;
  uv_pack = (u_int)RENDER_PACKETPTR_ADDR & 0xffffff;
  RENDER_PACKETPTR_ADDR = RENDER_PACKETPTR_ADDR + 0x28;
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
/* w39-a6: 117 -> 62 diffs, count EXACT 113/113.  Levers:
 *  - no `new_count` funnel: Ghidra routed every arm through a shared
 *    `gCurrentNumSplats = new_count;` store; the oracle only stores in the retire arm
 *    (sw s1,%gp_rel(gCurrentNumSplats)) and j's straight to the loop increment.
 *  - the retire guard is POSITIVE: `if (num < gCurrentNumSplats && i == gCurrentNumSplats-1)`
 *    (oracle slt s4,a2 / beqz body / bne s1,v0 body), not the inverted `||` + comma form.
 *  - `(u_int)random() % K` inline, no named u_int temp: the temp costs an extra
 *    `addu a0,v0,zero` to preserve the dividend at every one of the 4 modulo sites.
 *    (a plain `random() % K` would be a SIGNED modulo -- oracle uses multu.)
 *  - plain top-tested `while (i < gCurrentNumSplats)`: gcc rotates it and CSEs the
 *    guard load with the loop-carried one ($a2 reused), where the if+do/while form
 *    reloads gCurrentNumSplats inside the body.
 * RESIDUAL 62 = giv-anchor: gcc anchors the loop walker at +4 (startTick, the LAST
 * access in body order -- combine_givs rule) and walks a second IV at +0; the oracle
 * anchors at +0 and re-COPIES it (addu s2,s0,zero in a jal delay slot) for the pos.vy
 * store.  Index form, cast-pointer spellings and per-field pointers all measured
 * neutral-or-worse. */
void Weather_DoSplats
               (int num,Weather_tSplatInfo *splats)

{
  short y_pos;
  u_int rnd;
  u_int uVar1;
  int i;

  if (gCurrentNumSplats < num) {
    gCurrentNumSplats = num;
  }
  i = 0;
  while (i < gCurrentNumSplats) {
      if (splats->startTick <= simGlobal.gameTicks) {
        if (splats->startTick + 0x20 < simGlobal.gameTicks) {
          if ((num < gCurrentNumSplats) && (i == gCurrentNumSplats + -1)) {
            gCurrentNumSplats = i;
          }
          else {
            (splats->pos).vx = (short)((u_int)random() % 320);
            if (GameSetup_gData.commMode == 1) {
              y_pos = (short)((u_int)random() % 0xf0 >> 1);
            }
            else {
              y_pos = (short)((u_int)random() % 0xf0);
            }
            (splats->pos).vy = y_pos;
            splats->startTick = simGlobal.gameTicks + (u_int)random() % 100;
          }
        }
        else {
          Weather_CreateSplat(splats);
        }
      }
      splats = splats + 1;
      i = i + 1;
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
  u_int *pal;

  player = Vi->player;
  wpt = Weather_gPServerA[player];
  wprevpt = Weather_gPrevPServerA[player];
  wd = Weather_gDrawnServerA[player];
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
      Weather_DoSplats(Weather_gSys.num[player] >> 3,Weather_gSplatInfoServerA[player]);
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
    prim = (DR_MODE *)RENDER_PACKETPTR_ADDR;
    pal = (u_int *)RENDER_PALETTEPTR_ADDR;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *pal & 0xffffff;
    RENDER_PACKETPTR_ADDR = RENDER_PACKETPTR_ADDR + 0xc;
    *pal = *pal & 0xff000000 | (u_int)prim & 0xffffff;
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
