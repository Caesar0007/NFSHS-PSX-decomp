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

/* SYM-CARRIER: Weather_gLastProcessTime
 * SYM-STORAGE-OVERRIDE: Weather_gLastProcessTime -- spelling the split carrier
 * file-static makes Weather_Init 219/211 with 24 diffs; external tentative
 * element symbols are required for the verified PASS 211/211 gp/absolute mix.
 * Weather_gLastProcessTime[2] is SPLIT STORAGE, same shape as the four server arrays below.
 * Weather_Init/Weather_Restart reach the CONSTANT-index elements as two independent one-insn
 * %gp_rel(D_8013DE54)/%gp_rel(D_8013DE58) symbols (8 bytes is over this build's -G4 threshold
 * as ONE object, each 4-byte element alone is gp-eligible), while Weather_DoWeather's RUNTIME
 * index needs an absolute array base (`lui/addiu %hi/%lo(D_8013DE54)` + `addu v1,s1,v0`).
 * w40-a6: the old model was a DUPLICATING dual -- two fabricated scalars PLUS a separate
 * `int Weather_gLastProcessTime[2]` object -- i.e. the catalog's per-element-dual BUG CLASS:
 * the two forms alias by NAME ONLY, so Init/Restart's resets (written through the scalars)
 * never reached the storage DoWeather reads.  Replaced with the aliasing model: one tentative
 * def per element + an UNSIZED asm()-label array VIEW aliased onto element [0]'s symbol, so
 * both access paths hit the SAME memory (unsized+extern keeps it out of maspsx's sbss_entries,
 * so the view stays absolute). */
int Weather_gLastProcessTime;                   /* [0] @0x8013de54 (oracle D_8013DE54) */
int Weather_gLastProcessTime1;                  /* [1] @0x8013de58 (oracle D_8013DE58) */
extern int Weather_gLastProcessTimeA[] asm("Weather_gLastProcessTime");
#define WEATHER_GLASTPROCESSTIME0 Weather_gLastProcessTime
#define WEATHER_GLASTPROCESSTIME1 Weather_gLastProcessTime1

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
/* SYM-CARRIER: Weather_gSplatInfoServer
 * SYM-CARRIER: Weather_gPServer
 * SYM-CARRIER: Weather_gPrevPServer
 * SYM-CARRIER: Weather_gDrawnServer */
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
Weather_tState Weather_gType;
static int timechange;                         /* @0x8013de4c SYM STAT */
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
 * the loop counter is the first-used var per IDA sub_800E1FD8). The authoritative SYM signature is
 * VOID; IDA's BOOL return is a decompiler artifact caused by the final loop test remaining in $v0.
 * Kept the plain `% 320`/`% y_max`/`% 300` (gcc-2.8 -O2 auto-emits the multu+mfhi magic-divide; a
 * 64-bit cast forced an unwanted mflo). SEALED (69/69 PASS): the no-rotation shape is the catalog
 * B-row EXIT-IN-THE-MIDDLE form -- `while(true){ result = i<19; if (result==0) break; body; i++; }`
 * (increment at body END, break tested via the result var, NOT a for(;;i++) head-increment) keeps
 * the oracle's top-test `slti;beqz->exit` + unconditional `j` back-edge. MATCH: exit-in-the-middle
 * no-rotation + result-var break. */
void Weather_InitSplats(void)

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
  return;
}

/* ---- Weather_GetNewState__Fv  [WEATHER.CPP:238-249] SLD-VERIFIED ---- */
int Weather_GetNewState(void)

{
  int randseed;

  randseed = random() & 3;
  if (randseed < 2) {
    return 0;
  }
  if (randseed == 2) {
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
/* w39-a6 FLOOR (4 diffs, count EXACT 62/62): the first velocity-vs-table guard has the
 * opposite branch polarity (ours beqz-to-call, oracle bnez-to-velYUpdate) and therefore a
 * different `j` delay-slot filler (ours the addiu half of a `la`, oracle a nop).
 * FALSIFIED: writing the guard in the oracle's polarity
 * (`if (velY < tbl[state]) goto velYUpdate; goto call;`) lets gcc merge the two gotos --
 * 58 insns / 6 diffs, i.e. structurally further away.
 * w41-a6: re-gated at 4, count EXACT 62/62, -G8 probe no change.  The SECOND, structurally
 * identical guard (`vy > tbl[state]`) MATCHES byte-for-byte with the same source shape, so
 * the residual is specific to the first guard's branch-sense choice, not the goto graph.
 * w42-a6 MECHANISM NAMED (STRONG): writing guard 1 in the ORACLE polarity
 * (`if (vy < tbl[state]) goto velYUpdate; goto call;`) makes its 3-insn tail
 * `slt v0,v0,v1 / bnez v0,.velY / j .call` BYTE-IDENTICAL to guard 2's, and gcc's
 * cross-jumping pass merges them -- guard 1 becomes `j <guard2's bnez>` with the `slt`
 * stolen into the delay slot (58 insns / 6 diffs, confirmed by side_by_side).  Retail's
 * two tails are byte-identical too, yet NOT merged, so retail's cross_jump ran while the
 * two blocks still held DIFFERENT PSEUDOS (they are on mutually exclusive paths, so cse
 * cannot unify them) -- ours merges them because our cross_jump sees the post-reload hard
 * registers.  Pass-ordering identity, not a source shape: keeping our beqz polarity (62
 * insns, 4 diffs) is strictly the better ledger.  Any future fix has to make the two tails
 * differ in one instruction, which no equivalent C spelling of these two guards does. */
void Weather_ChangeIntensityBasedOnTime(void)

{
  if (Weather_gIntensityChangeFactor <= 0) goto WeatherIntensity_checkZero;
  /* w46-a9 (4 -> PASS): the w42 "STRONG" verdict above named the mechanism exactly
   * right -- guard 1 in the ORACLE polarity makes its 3-insn tail byte-identical to
   * guard 2's and our post-reload cross_jump merges them (58 insns) -- but its
   * conclusion ("no equivalent C spelling makes the two tails differ") only held for
   * spellings that EMIT code.  A zero-operand USE FENCE is a real RTL insn that
   * emits ZERO bytes, so it breaks cross_jump's tail equality at no instruction
   * cost: guard 1 keeps the oracle's `bnez -> velYUpdate` sense AND its own `j`.
   * Placement is the dial -- the fence must sit at the END of guard 1's block
   * (before the `goto ..._call`); before the guard = 58/6, in the other arm = 62/4. */
  if ((int)Weather_gSys.velocity.vy < Weather_gIntensityTbl[Weather_gIntensityGoalState])
  goto WeatherIntensity_velYUpdate;
  /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
   * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
   * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
   * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
   * Gate-lane object is byte-identical (proven by hash); see
   * scratchpad/w64a20/RECEIPTS.md. */
  __asm__ __volatile__("");
  goto WeatherIntensity_call;
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
  
  /* w49-a10 NAMED ANGLE (12 diffs, count-EXACT 211/211, all in insns 1-14): the residual
   * is ONE address-materialization decision.  Retail keeps %hi(TrackSpec_gSpec.weatherspec)
   * in $a0 and uses it TWICE -- `addiu $v0,$a0,%lo(..)` for the pointer store AND
   * `lw $v1,%lo(..)($a0)` for the .type read -- so $v0 is free for the `li $v0,1` that
   * retail schedules into the beqz delay slot.  Ours CSEs the whole lo_sum: the .type
   * load reuses the computed POINTER (`lw $v1,0($v0)`, no reloc), which pins $v0 and
   * pushes the `li` after the load.  cse.c's find_best_addr replaces a (lo_sum high sym)
   * MEM address with a register holding the same value when ADDRESS_COST says the plain
   * reg is cheaper -- retail's cse did not have that register available at the load.
   * FALSIFIED here: `__asm__("" : "=r"(ts) : "0"(ts))` opacity fence on the pointer
   * (86 -- it breaks the CSE but also kills the shared high, giving a fresh 2-insn `la`);
   * reading the guard through `Weather_gType` instead of re-reading .type (12, no change);
   * a block-scope `int i;` at the top of the if-body per the SYM (12, no change).
   * 🏆 w50-a10 SOLVED -- IT IS A PER-FN FLAG IDENTITY, NOT A SOURCE SHAPE: compiling THIS
   * FUNCTION with `-fforce-addr` reproduces retail EXACTLY (12 -> PASS, 211/211).  Measured
   * on the real CC1PLPSX: `-fforce-addr` emits `lui $4,%hi(spec)` into its OWN pseudo (not
   * the self-temp `lui $2 ... addiu $2,$2` we get), so the `.type` load keeps a SECOND
   * lo_sum off that shared high (`lw $3,%lo(spec)($4)`) instead of cse's find_best_addr
   * folding it onto the already-computed pointer -- and $2 is then free for the `li 1` that
   * reorg puts in the beqz delay slot.  The guard load's separate-temp (`lui $2; lw $3,..($2)`)
   * comes along for free.  Whole-TU `-fforce-addr` is NOT the identity (22->21 PASS: it
   * REGRESSES Weather_ProcessParticles PASS->22 and Weather_QuickReOrthogonalize PASS->57,
   * DoWeather 36->42), so the wiring must be PER-FN: add a `PER_FN_FORCE_ADDR` table + the
   * tuple `(PER_FN_FORCE_ADDR, "-fforce-addr", "faddr")` to build.py's `_apply_fn_splice`
   * loop (same 3-line precedent as PER_FN_NO_DELAYED_BRANCH / PER_FN_NO_THREAD_JUMPS).
   * GATE-CONFIRMED through that splice lane: whole weather.cpp 22 -> 23 PASS, zero
   * regressions.  Source-level falsifications at the 12 base (all re-run this wave): a
   * `volatile int` cast on the .type read (15 @212), reading it as `Weather_gTrackSpec->type`
   * (15 @212), a volatile cast on the `GameSetup_gData.Weather` guard (12, neutral).
   * Diagnostic sweep that isolated the flag: -fno-cse-follow-jumps / -fno-gcse /
   * -fno-cse-skip-blocks all leave the fold in place; -mno-split-addresses changes the whole
   * address form (la + 1-insn guard load), only -fforce-addr lands retail's shape. */
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
/* w41-a6: the w39 "FLOOR (32 diffs, uniform one-step rotation)" is REFUTED -- PASS.
 * MECHANISM (read off cc1plus `-dg`): gcc runs local_alloc BEFORE global_alloc, so a
 * BLOCK-LOCAL pseudo gets first pick of the hard regs.  Here EVERY global allocno
 * conflicts with hard reg 2 ($v0) (`;; 83 conflicts: ... 2 29`), so no function-scope
 * local can ever land in $v0 -- retail's r0/r1/r2 DO land in $v0/$v1/$a0, therefore they
 * were block-local in the original.  Our single fn-scope r0/r1/r2 set was assigned in TWO
 * basic blocks (loop body + tail), which makes reg_basic_block == -1 => GLOBAL allocno =>
 * barred from $v0, pushing the triple to $v1/$a0/$a1 and leaving $v0 to the block-local
 * `next`.  FIX = a SEPARATE `int r0,r1,r2;` declaration inside the loop block and inside
 * the tail block; local_alloc then hands each block $v0/$v1/$a0 and `next` falls to $a1,
 * exactly like retail.  (Decl-ORDER permutations of the fn-scope set are all no-ops --
 * the lever is block SCOPE, i.e. local-vs-global allocno class, not ordering.) */
void Weather_TransformVertex(matrixtdef *m,int n,SVECTOR *s)
{
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
    int r0;
    int r1;
    int r2;
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
  {
    int r0;
    int r1;
    int r2;
    r0 = tv.vx;
    r1 = tv.vy;
    r2 = tv.vz;
    s->vx = (short)r0;
    s->vy = (short)r1;
    s->vz = (short)r2;
  }
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
 * w41-a6: 69 -> PASS via THREE independent levers (each gate-measured):
 *  (1) `tv = tv + 1;` moved BEFORE the `if (reset)` arm -- both address givs (s2 = &tv->vx,
 *      s1 = &tv->vz) then increment ahead of the branch, one landing in the beqz delay slot,
 *      and the freed slot lets the return-value `sll v0,v0,16` fill the lw load-delay
 *      (69 -> 60, count 252 -> 251 EXACT).  The w40 note's "sink the write-back into the
 *      reset arm" reading was wrong: the write-back stays before the arm; only the
 *      INCREMENT moves.
 *  (2) turbulence table read in INDEX form `Weather_gRandomVelocityVectors[n][0..2]`
 *      instead of a `signed char *vel` walker (60 -> 18).  With the explicit walker,
 *      loop.c/combine_givs re-anchored on the LAST address (vel+2) and kept the biv,
 *      giving TWO source givs (`lbu 0(t2)` + `lbu -1(t1)` / `lbu 0(t1)`, t1 = t2+2);
 *      the index form reduces to retail's single walker with 0/1/2 displacements.
 *      NEGATIVE: a goto-loop here REGRESSES (60 -> 87) -- this loop genuinely needs SR.
 *  (3) the three `total_vector_change` adds written vx,vy,vz (NOT vx,vz,vy): gcc emits
 *      the middle two in the OPPOSITE order to the source here, so the source order that
 *      yields retail's vx,vz,vy emission is vx,vy,vz (18 -> 0; pure a1<->a2 / v0<->v1
 *      swap on the result.vy/result.vz pair). */
void Weather_ProcessParticles(DRender_tView *Vi,int num,SVECTOR *wpt,char *wd)
{
  /* SYM-CARRIER: pt -- retail aliases this inner-loop name onto temp_vector's
     stack slot. A literal second SVECTOR makes cc1plus grow the frame and
     regresses this function from PASS to 56 diffs, so the shared carrier stays. */
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
    total_vector_change.vy = total_vector_change.vy + velocity_vector_change.vy;
    total_vector_change.vz = total_vector_change.vz + velocity_vector_change.vz;
  }

  /* rotate the 12 turbulence velocity vectors into camera space (frame-local copy) */
  {
    n = 0;
    while (1) {
      if (12 <= n) break;
      temp_vector.vx = (signed char)Weather_gRandomVelocityVectors[n][0];
      temp_vector.vy = (signed char)Weather_gRandomVelocityVectors[n][1];
      temp_vector.vz = (signed char)Weather_gRandomVelocityVectors[n][2];
      gte_ldv0(&temp_vector);
      gte_mvmva(1,0,0,0,0);
      gte_stlvnl(&result);
      Weather_gTransformedRandomVelocityVectors[n].vx = (short)result.vx;
      Weather_gTransformedRandomVelocityVectors[n].vy = (short)result.vy;
      Weather_gTransformedRandomVelocityVectors[n].vz = (short)result.vz;
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
      tv = tv + 1;
      if (reset != 0) {
        wd[n] = 0;
      }
      n = n + 1;
    }
  }
}
/* ---- Weather_CreateSnow__FP7SVECTOR  [WEATHER.CPP:923-961] SLD-VERIFIED ----
 * w41-a6 (10 diffs, count EXACT 108/108): two sched1 permutations, no register-class or
 * structural error.  (a) the header merge -- retail stores the merged word BEFORE
 * computing the packet-cursor bump (so the bump reuses the dying `$v1`), ours computes the
 * bump first into `$v0`; same family as Weather_CreateRain's per-arm residual.  (b) the
 * `((int)pt & 4)` mask is emitted BEFORE the `la` of gWeatherPixmap, retail after.
 * The palette-before-bump order lever (which took CreateSplat 40 -> 6) was already
 * measured NEGATIVE here in w40. */
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
  /* w46-a9 (10 -> PASS): residual (a) above is the SAME shape that cracked
   * Weather_CreateSplat this wave -- the fused `PTR = prim + 0x28;` statement lets
   * gcc hoist the `addiu` ABOVE the header-merge store, so the bump gets a fresh
   * register instead of reusing the dying merge temp.  Three zero-instruction dials:
   *  (1) a fence right after the header store pins the `addiu` below it;
   *  (2) the bump is SPLIT into a value statement (`next`) and its store;
   *  (3) the palette RMW is SPLIT (read `palw` first) and the cursor store is placed
   *      INSIDE it, between the palette read and the addr24 mask -- retail's
   *      `sw $v1,0($t1)` issues there and no whole-statement placement reaches it.
   * Measured from this basin: fence-only 8, split-bump-only 8, split-RMW + store
   * after the block 6, store at the END of the block 6, this form 2. */
  __asm__ __volatile__("");
  {
    u_char *next = (u_char *)prim + 0x28;   /* bump off the loaded prim, no re-read */
    u_int palw = *pal;
    RENDER_PACKETPTR_ADDR = next;
    u_int addr24 = (u_int)prim & 0xffffff;
    *pal = palw & 0xff000000 | (addr24 & 0xffffff);
  }
  *((char *)prim + 3) = 9;                                  /* OT tag length (9 words) */
  gte_stsxy3(&prim->x0,&prim->x1,&prim->x2);

  /* project the 4th corner, set colour+code, copy the per-vertex texture coords from the pixmap */
  gte_ldv0(&gv[3]);
  gte_rtps();
  *(u_int *)&prim->r0 = 0x2e202020;                         /* r0=g0=b0=0x20, code=0x2e (textured FT4) */
  gte_stsxy(&prim->x3);
  /* w46-a9: residual (b) -- the `(int)pt & 4` mask emitted BEFORE the `la` of
   * gWeatherPixmap, retail after.  The cure is the HONEST INDEX FORM: the byte-offset
   * cast is a Ghidra transcription of `gWeatherPixmap[bit]`, and writing the real
   * array access lets gcc materialize the table address first and fold the scale.
   * (`char *wp = ...;` hoisted base and a named `m` + hoisted base also PASS; a named
   * `m` alone, the reversed `((int)pt&4) + (char*)tbl` addition, and a bare fence all
   * stay at 2.) */
  pmx = gWeatherPixmap[((int)pt & 4) >> 2];
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
/* w39-a6 (56 diffs, ours 117 / oracle 113): the residual is the packet/palette header
 * merge in BOTH arms -- ours reloads the palette pointer for the write-back where the
 * oracle keeps it in one register.  The `u_int *pal` CSE local that fixed exactly this in
 * CreateSnow/DoWeather/CreateSplat REGRESSES here (fn-scope 122, block-scope-per-arm 134)
 * even though it takes the count to 115: the two arms' pal pseudos interfere.  Left alone.
 * w41-a6 (16, count EXACT 113/113, 8 diffs per arm).  The whole residual is ONE shape:
 * retail computes the packet-cursor bump AFTER the header store so it reuses the just-dead
 * `$v1` (`sw v1,0(t2); addiu v1,t2,20`) and interleaves the bump STORE into the middle of
 * the palette merge; sched1 hoists our `addiu` above the store into `$v0`, which also
 * flips the palette `or`'s destination (ours dest = the prim term, retail = the pal term).
 * MEASURED NEGATIVE: palette-write-back-before-bump (16, neutral); the pal-term-first
 * `or` spelling (52).
 * w46-a9: the packet-emission recipe that took BOTH Weather_CreateSplat (6 -> PASS) and
 * Weather_CreateSnow (10 -> PASS) this wave DOES NOT TRANSFER HERE, and the reason is
 * named: those two are STRAIGHT-LINE emitters, this one emits the same header from TWO
 * ARMS.  Measured (both arms edited together, count stays 113/113 throughout):
 *   - split bump into `next` value + store, at all five in-block positions .... 16 (neutral)
 *   - a zero-operand USE fence after the header store ....................... 104 (!)
 *   - fence + split bump, 4 placements ................................. 32/32/104/104
 *   - fence + split palette RMW (`palw` read first) ..................... 32/24/36/104
 * The fence is CATASTROPHIC here where it was the key dial in the siblings: with two arms
 * it lands inside a block whose `pal` pseudo is arm-local, and the barrier stops the two
 * arms' header groups from being scheduled alike, so the arms diverge wholesale.
 * 🔑 NEW NAMED ANGLE: fix the ARMS first, then the emission.  The two arms are
 * byte-identical from the header store through `*(u_int*)&prim->r1 = 0x402020;` -- if the
 * shared prologue is factored so ONE header group is emitted and reached from both arms
 * (or, conversely, if the arms are deliberately DE-merged with per-arm data-label address
 * forms, catalog w41 §D), the emission dials become single-site again and the
 * CreateSplat/CreateSnow recipe applies unchanged.  Untried: hoisting the whole
 * prim/pal/header/bump group ABOVE the `if (*wd)` (retail's `prim` is one pseudo across
 * both arms per the register evidence: `$t2` throughout). */
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
    {
      u_int *pal = (u_int *)RENDER_PALETTEPTR_ADDR;
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *pal & 0xffffff;
      /* MATCH (w49-a10, 16 -> PASS): the CreateSnow/CreateSplat packet-emission
       * recipe, minus the fence.  The palette RMW is SPLIT (read `palw` FIRST) and
       * the packet-cursor store is placed BETWEEN the palette read and the addr24
       * mask -- that is where retail issues `sw $v1,0($a3)`, and it also frees the
       * dying merge temp ($v1) for the bump instead of taking a fresh register.
       * The final `or` must be spelled palw-term FIRST (`palw & 0xff000000 |
       * (addr24 & 0xffffff)`) to land the result in retail's $v0.  NOTE: adding
       * CreateSnow's `__asm__ __volatile__("")` fence and/or its split `next`
       * local costs 8 diffs here -- they pin the 0x402020 constant's lui/ori below
       * the header store, where retail hoists it above the whole group. */
      {
        u_int palw = *pal;
        RENDER_PACKETPTR_ADDR = (u_char *)prim + 0x14;
        u_int addr24 = (u_int)prim & 0xffffff;
        *pal = palw & 0xff000000 | (addr24 & 0xffffff);
      }
    }
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
    {
      u_int *pal = (u_int *)RENDER_PALETTEPTR_ADDR;
      *(u_int *)prim = *(u_int *)prim & 0xff000000 | *pal & 0xffffff;
      /* MATCH (w49-a10, 16 -> PASS): the CreateSnow/CreateSplat packet-emission
       * recipe, minus the fence.  The palette RMW is SPLIT (read `palw` FIRST) and
       * the packet-cursor store is placed BETWEEN the palette read and the addr24
       * mask -- that is where retail issues `sw $v1,0($a3)`, and it also frees the
       * dying merge temp ($v1) for the bump instead of taking a fresh register.
       * The final `or` must be spelled palw-term FIRST (`palw & 0xff000000 |
       * (addr24 & 0xffffff)`) to land the result in retail's $v0.  NOTE: adding
       * CreateSnow's `__asm__ __volatile__("")` fence and/or its split `next`
       * local costs 8 diffs here -- they pin the 0x402020 constant's lui/ori below
       * the header store, where retail hoists it above the whole group. */
      {
        u_int palw = *pal;
        RENDER_PACKETPTR_ADDR = (u_char *)prim + 0x14;
        u_int addr24 = (u_int)prim & 0xffffff;
        *pal = palw & 0xff000000 | (addr24 & 0xffffff);
      }
    }
    *((char *)prim + 3) = 4;
    *(u_int *)&prim->r0 = 0x52000000;
    *(u_int *)&prim->r1 = 0x402020;
    gte_stsxy(&prim->x1);
    *(u_int *)&prim->x0 = *(u_int *)&prim->x1;
  }
  *wd = 1;
  *(u_int *)pt1 = *(u_int *)&prim->x1;             /* save current screen pos as next frame's prev */
}

/* ---- Weather_CreateSplat__FP18Weather_tSplatInfo  [WEATHER.CPP:1009-1035] SLD-VERIFIED ----
 * w40-a6 SYM-driven rewrite (rule 8): the SYM `8c` block lists exactly SIX locals --
 * splat(REGPARM $9), vx($0a SHORT), vy($0b SHORT), prim($08 POLY_FT4*), size($07 INT),
 * splatTick($03 INT) -- plus a nested block with l0..l3 (ULONG) for the pixmap word copy.
 * The previous body carried ~22 invented temps (screen_x/screen_y/size_x/size_y/ts1..ts3/
 * uv_pack/pkt_addr24/tpage_pack/color_pack/splat_glyph/splat_size) which pinned the whole
 * caller-saved file.  `splatTick` is MUTATED IN PLACE by the >>3 (oracle `sra $v1,$v1,3`
 * over its own register), and the quad corners are written as direct field expressions so
 * gcc CSEs `vy + splatTick` the way retail did.  `tp3` is not a retail local -- it is our
 * scratchpad-literal modelling of Render_gPalettePtr (a real variable in retail, so gcc
 * CSE'd its load); keep it. */
void Weather_CreateSplat
               (Weather_tSplatInfo *splat)

{
  short vx;
  short vy;
  POLY_FT4 *prim;
  int size;
  int splatTick;
  u_char *tp3;

  prim = (POLY_FT4 *)RENDER_PACKETPTR_ADDR;
  tp3 = RENDER_PALETTEPTR_ADDR;
  vx = (splat->pos).vx;
  vy = (splat->pos).vy;
  prim->tag = prim->tag & 0xff000000 | *(u_int *)tp3 & 0xffffff;
  /* MATCH: the palette write-back BEFORE the cursor bump.  With the bump 2nd (the
   * Ghidra order) gcc issues `addiu/sw` ahead of the tag store (64 diffs); with it
   * 3rd the scheduler interleaves it into the palette merge exactly like retail. */
  /* w46-a9 (6 -> PASS).  Three cooperating dials, all zero-instruction:
   *  (1) SPLIT the cursor bump into a value statement (`next`) and its store, and
   *      put the store INSIDE the palette RMW -- retail's `sw $v1,0($a3)` issues
   *      between the addr24 mask and the palette merge, which no placement of a
   *      fused `PTR = prim + 0x28;` statement can reach.
   *  (2) SPLIT the palette read-modify-write itself (`palw` read, then the write)
   *      -- the read must issue before the addr24 mask, exactly as the oracle's
   *      `lw $v0,0($a1) / and $a0,$t0,$a0` pair shows (w43 SPLIT-RMW row).
   *  (3) a zero-operand USE fence after the `next` value statement pins the
   *      `addiu $v1,$t0,0x28` into the tag merge instead of letting it sink. */
  {
    u_char *next = (u_char *)prim + 0x28;
    __asm__ __volatile__("");
    {
      u_int palw = *(u_int *)tp3;
      u_int addr24 = (u_int)prim & 0xffffff;
      RENDER_PACKETPTR_ADDR = next;
      *(u_int *)tp3 = palw & 0xff000000 | (addr24 & 0xffffff);
    }
  }
  *((char *)prim + 3) = 9;
  prim->code = 0x2e;
  size = 0x12;
  if (((splat->pos).vx & 1U) != 0) {
    size = 0xc;
  }
  splatTick = simGlobal.gameTicks - splat->startTick;
  /* w46-a9: retail issues `li $v0,-128 / subu $v0,$v0,$a0` BEFORE `sra $v1,$v1,3`
   * (both are ready right after the `sll`, a sched2 ready-list tie).  Naming the
   * colour value and fencing the shift behind it wins the tie at 0 insns; a bare
   * fence between the two ORIGINAL statements over-shoots (sra sinks too far). */
  {
    int col = -0x80 - splatTick * 4;
    __asm__ __volatile__("");
    splatTick = splatTick >> 3;
    prim->r0 = prim->g0 = prim->b0 = (u_char)col;
  }
  prim->x0 = vx - splatTick;
  prim->y0 = vy + splatTick - splatTick;
  prim->x1 = vx + size + splatTick;
  prim->y1 = vy + splatTick - splatTick;
  prim->x2 = vx - splatTick;
  prim->y2 = vy + splatTick + size + splatTick * 2;
  prim->x3 = vx + size + splatTick;
  prim->y3 = vy + splatTick + size + splatTick * 2;
  {
    Draw_tPixMap *pmx;
    u_long l0;
    u_long l1;
    u_long l2;
    u_long l3;

    pmx = gWeatherPixmap[2];
    l0 = *(u_int *)pmx;
    l1 = *(u_int *)((char *)pmx + 4);
    l2 = *(u_int *)((char *)pmx + 8);
    l3 = *(u_int *)((char *)pmx + 0xc);
    *(u_int *)&prim->u0 = l0;
    *(u_int *)&prim->u1 = l1;
    *(u_int *)&prim->u2 = l2;
    *(u_int *)&prim->u3 = l3;
  }
}

/* ---- Weather_DoSplats__FiP18Weather_tSplatInfo  [WEATHER.CPP:1039-1064] SLD-VERIFIED ---- */
/* ---- w53-a5 (2026-08-09): 36 STAYS @ 111/113 (re-gated; the worklist row 96.84% is
 * stale as usual).  THE 2-INSN GAP IS NOW NAMED EXACTLY, with the oracle read off:
 * retail uses SIX callee-saved regs (frame 0x30, s0..s5) where we use FIVE (frame 0x28,
 * s0..s4).  The 6th holds a SURVIVING REG-REG COPY of the splat walker:
 *     .L800E38F4:  jal random
 *                   addu $s2,$s0,$zero        <- the copy, in the jal delay slot
 *     ...           sh   $v0,0x2($s2)         <- ONLY use: the .pos.vy store
 * s0 = walker over splats (addiu $s0,$s0,8 at both back edges), s1 = i, s3 = &simGlobal,
 * s4 = num, s5 = &GameSetup_gData.  Every other field access goes through $s0
 * (`lw $v1,4($s0)` read, `sh $v0,0($s0)` vx, `sw $a0,4($s0)` startTick, `addu $a0,$s0,
 * $zero` for the CreateSplat arg) -- so `.pos.vy` ALONE lives on a second pseudo holding
 * the SAME address.  2 insns = the copy (which also fills the `nop` we emit there) + the
 * s5 save/restore pair; the residual 36 is then the s2..s5 rename cascade that rides on it.
 * ⇒ THE WHOLE FUNCTION REDUCES TO ONE QUESTION: what C shape yields a reg-reg copy of the
 * walker that gcc-2.8 does NOT copy-propagate away?  EIGHT spellings measured this wave,
 * all re-gated, NONE produces it:
 *   explicit walker `p` + block-local `q = p` for vy .... 53 @114 (2 walkers, s2=p and
 *       s0=p+4: gcc builds a SECOND giv at +4 for startTick instead of retail's +0 copy)
 *   explicit walker `p` alone ......................... 50 @115
 *   index form + block-local `q = &splats[i]` before vx  67 @110 (q BECOMES the giv, -1 insn)
 *   index form + `q` assigned AFTER the vx store ...... 67 @110 (the catalog cse
 *       double-evaluation generator does NOT fire on an ADDRESS giv here)
 *   index form + fn-scope `q` ......................... 36 @111 (copy-propagated away,
 *       byte-identical to the shipped form)
 *   index form + `q` assigned in BOTH commMode arms ... 36 @111 (ditto -- two defs of the
 *       same value are still forwarded)
 *   index form + `q` also used for the CreateSplat arm  79 @118
 *   index form + w47 OPACITY fence on `q` ............. 96 @119 (the fence's barrier
 *       wrecks the loop; it is NOT the right device for an in-loop address pseudo)
 *   loop rewritten as `for (i = 0; i < gCurrentNumSplats; i++)` .. 36 @111 (NEUTRAL --
 *       the shipped while-form already produces the oracle's blez zero-trip guard +
 *       rotated back-edge, so the loop SHAPE is settled; do not re-sweep it)
 * NEW NAMED ANGLES for the next taker, in priority order: (1) this is a combine_givs
 * question, not a copy-prop one -- retail kept TWO address givs with the SAME +0 offset
 * while every index/pointer spelling here merges them; the catalog's "explicit pointer
 * walkers are the only faithful shape" (sbhdrcpy) predicts TWO explicit walkers both
 * advanced by 8, one used ONLY for `.pos.vy` -- untried (variant 1 above advanced only
 * one and let gcc invent the +4 giv).  (2) read `-dL`'s giv table for this loop and check
 * whether the vy giv is being merged onto the +4 anchor; the dial would then be the
 * body-order of the vy store (combine_givs anchors on the LAST giv in body order).
 * (3) the `%` chains all go through `mfhi $a3` in retail vs `$a2` in ours -- that is
 * downstream of the same rename, do not chase it separately. */
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
 * w40-a6 62 -> 36 (ours 111 / oracle 113): the SYM `8c` block lists ONLY `i` as a REG
 * local (plus the two REGPARMs num=$14/s4 and splats=$04) -- so the `splats = splats + 1`
 * pointer walk AND the `y_pos` temp were both invented.  INDEX FORM `splats[i]` throughout
 * lets loop.c build the walkers as givs off the untouched param, which recovers the whole
 * saved-reg map bar one.  RESIDUAL 2 insns: retail carries a THIRD address giv (frame 48 /
 * one more saved reg, plus `addu s2,s0,zero` copied in a jal delay slot for the pos.vy
 * store) where combine_givs merges ours down to two -- the documented combine_givs floor
 * (catalog: "combine_givs merges N address givs down to 2 in EVERY index spelling").
 * A `y_pos` temp is folded away and changes nothing (measured identical 36/111).
 * w41-a6 FLOOR RE-VERIFIED (36 diffs, ours 111 / oracle 113).  Prototype audit: SYM arity
 * num/splats + void return confirmed; -G identity probe: -G8 leaves it at 36 (no change)
 * and no weather %gp_rel symbol is >4 bytes, so the -G axis is closed.  MECHANISM (named):
 * retail's 3rd address giv is materialised as `addu s2,s0,zero` in the FIRST
 * `jal random` delay slot and used only for the `pos.vy` halfword store, costing one more
 * callee-saved reg (s0-s5, frame 48) than our two combine_givs-merged walkers (s0-s4,
 * frame 40).  Trichotomy: NOT a cse double-evaluation copy (the copy DIES BEFORE its
 * source, so make_regs_eqv would propagate it away) and not a prototype artefact -- it is
 * the combine_givs merge, which no index spelling avoids.
 * w46-a9 (re-gated 36, ours 111 / oracle 113 -- unchanged).  Three more falsifications
 * from the w44/w45 kit, all aimed at forcing the missing 6th callee-saved register into
 * existence: `int *pn = &gCurrentNumSplats;` held across the loop (§3.12 #16 hold-global-
 * addr-across-call) = 59/118, a zero-insn USE fence on `num` after the loop init = 37/112,
 * the same on `splats` = 41/112.  Every one ADDS instructions instead of adding a giv.
 * 🔑 NEW NAMED ANGLE: attack combine_givs, not the register file.  The receipt above says
 * our two walkers are a MERGE of retail's three, and `-dL` prints the giv combination
 * decisions (`giv of insn N not worth while, W vs insn_count` / the combined-giv list) --
 * the w43 GIV-WORTH BUDGET RAZOR row shows that list is readable and probeable, and that
 * the dial is the loop's RTL insn count (often a 1-insn razor).  Dump -dL on this loop,
 * read whether the pos.vy giv is *combined* or *declined*, then move the crossing point
 * with a +1-RTL-insn faithful spelling (retail's own store-then-read-back of a just-
 * stored field is the standard zero-byte way to add exactly one RTL insn). */
/* ---- w50-a10: 36 STAYS (111/113).  THE -dL DUMP WAS READ (the w46 named angle executed);
 * it NAMES the giv but offers no razor.  In `weather.cpp.i.loop` this loop's giv block is:
 *     Insn 46/48   giv reg 88/89  mult 8 add 0 / add (reg/v:SI 81)  lifetime 1/98  replaceable
 *     Insn 109/111 giv reg 110/111 mult 8 add 0 / add (reg/v:SI 81) lifetime 1/42
 *                                  <- 111 is the ONLY giv WITHOUT `replaceable`, and it is
 *                                     the one carrying "Final giv value for 111, giv dead
 *                                     after loop exit" = the pos.vy store's address
 *     Insn 201/203 giv reg 151/152 mult 8 add 0 / add (reg/v:SI 81) lifetime 1/14 replaceable
 *   decisions: `giv at 125/111/48 combined with giv at 203` and `109/46 combined with 201`
 *   -> everything collapses into reg 175 (+ reg 176), i.e. our TWO walkers.  There is NO
 *   "not worth while" line for this loop at all, so the w46 "GIV-WORTH BUDGET RAZOR" dial
 *   (loop RTL insn count) is NOT the crossing point here -- combine_givs merges 111
 *   unconditionally because its (mult_val, add_val) is IDENTICAL to 203's.  A budget/+1-RTL
 *   spelling therefore cannot separate them; only a giv whose add_val DIFFERS can.
 * FALSIFIED THIS WAVE (all four aimed at minting retail's 3rd giv / its `addu s2,s0,zero`):
 *   a plain `Weather_tSplatInfo *sp = &splats[i];` used only for the two pos.vy stores,
 *   declared at the top of the else-arm (67 @110) or in an inner block around just those
 *   stores (67 @110) -- BOTH go one insn SHORTER, the pointer folds into a single giv;
 *   the same two with a zero-insn opacity fence on `sp` -- top-of-arm 96 @119 (+6, the
 *   fence's own reload survives), inner block 47 @112 (the CLOSEST count yet, 1 short,
 *   but the fence's pseudo re-colors the s-band).  NEXT: the separation must come from an
 *   add_val difference (e.g. a giv anchored on a DIFFERENT field of splats[i]), not from a
 *   second pointer, since combine_givs merges identical add_vals unconditionally. */
/* ---- w61-a14 (2026-08-15): 36 -> **PASS** (113/113).  The w53 '6th callee-saved reg'
 * verdict is CORRECT but its 'combine_givs merges identical (mult_val, add_val)
 * unconditionally, so the separation cannot come from a second pointer' conclusion is
 * REFUTED: a second pointer DOES survive if it is LAUNDERED.  Three stacked levers:
 *  (1) `q = &splats[i];` + the CSE-OPAQUE IDENTITY FENCE `__asm__("" : "=r"(q) : "0"(q));`
 *      immediately after it, with the two `.pos.vy` stores (both commMode arms) going
 *      through `q`.  36 -> 16 and the count becomes EXACT 113/113.  The launder is what
 *      makes it work -- the SAME statement WITHOUT the fence measures exactly 36
 *      (byte-identical to the control: combine_givs eats it, as w53 said).  This is
 *      retail's `addu $s2,$s0,$zero` in the `jal random` delay slot + the $s5
 *      save/restore pair = the whole 2-insn gap, and the s2..s5 band snaps into place.
 *      Placing the assignment BEFORE the `.pos.vx` store instead = 92 @119 (falsified);
 *      declaring `q` before `i` = 16 (neutral); extra read-only operands on q = 28.
 *  (2) ONE-OPERAND READ-ONLY REF FENCE ON `i` AT THE TOP OF THE LOOP BODY -- 16 -> 2.
 *      This flips the last register pair: local-alloc was handing `q` $s1 (the lower
 *      free callee-saved) and pushing the loop counter to $s2; +2 refs on `i`
 *      (in-loop = x2) reverses the order, giving retail's i=$s1 / q=$s2.  POSITION IS
 *      THE DIAL, exactly as the w60-a6 L3 row says: the same fence with 2 operands
 *      placed OUT of the loop measures 7 but costs +1 insn (it blocks the `i == 0`
 *      constant fold into the loop guard, so retail's `blez a2,T; addu s1,zero,zero`
 *      becomes our 5-insn `slt/beqz` pair); 1 operand out-of-loop = 19 @114,
 *      4 operands = 29 @114, 2 operands in-loop = 26.
 *  (3) YODA ON THE TICK GUARD -- 2 -> PASS.  `simGlobal.gameTicks >= splats[i].startTick`
 *      instead of `splats[i].startTick <= simGlobal.gameTicks`; retail issues
 *      `lw a0,4(s3)` (gameTicks) BEFORE `lw v1,4(s0)` (startTick), i.e. the operand the
 *      source names FIRST is loaded first.  The compare itself is identical either way.
 * (The SYM 8c block lists only `i` + the two REGPARMs, so `q` is a compiler-visible
 * pseudo retail's source did not name -- but the oracle proves the value exists, and the
 * launder is the pin-free way to spell it.) */
void Weather_DoSplats
               (int num,Weather_tSplatInfo *splats)

{
  int i;
  Weather_tSplatInfo *q;

  if (gCurrentNumSplats < num) {
    gCurrentNumSplats = num;
  }
  i = 0;
  while (i < gCurrentNumSplats) {
      __asm__("" : : "r"(i));
      if (simGlobal.gameTicks >= splats[i].startTick) {
        if (splats[i].startTick + 0x20 < simGlobal.gameTicks) {
          if ((num < gCurrentNumSplats) && (i == gCurrentNumSplats + -1)) {
            gCurrentNumSplats = i;
          }
          else {
            splats[i].pos.vx = (short)((u_int)random() % 320);
            q = &splats[i];
            __asm__("" : "=r"(q) : "0"(q));
            if (GameSetup_gData.commMode == 1) {
              q->pos.vy = (short)((u_int)random() % 0xf0 >> 1);
            }
            else {
              q->pos.vy = (short)((u_int)random() % 0xf0);
            }
            splats[i].startTick = simGlobal.gameTicks + (u_int)random() % 100;
          }
        }
        else {
          Weather_CreateSplat(&splats[i]);
        }
      }
      i = i + 1;
  }
  return;
}

/* ---- Weather_DoWeather__FP13DRender_tView  [WEATHER.CPP:1069-1156] SLD-VERIFIED ---- */
/* w39-a6 (138 -> 131, count 196 vs 197): the palette-pointer CSE local landed on the
 * DR_MODE tail.  RESIDUAL = a whole-function allocno permutation rooted at the three
 * per-player server-array loads: the oracle materializes all three base addresses UP FRONT
 * in three distinct registers (lui/addiu x3 before the frame stores) and then does
 * addu/lw x3 off one shared `sll player,2`; ours emits them serially through $v0, which
 * rotates Vi/player/wpt/wprevpt/wd across $s2-$s7.  FALSIFIED: hoisting the three array
 * bases into local pointers before reading `player` (gcc folds them straight back).
 * w41-a6 (still 60, count EXACT 197/197).  Residual decomposes into FOUR ties, all
 * measured, none source-reachable so far:
 *  (1) HEAD a0<->a1: two LOCAL-alloc quantities -- Q1={&Weather_gPServerA} and
 *      Q2={player*4 -> +base -> lw s4}.  gcc's local_alloc orders by live length; ours has
 *      Q1 (born at the hoisted `la`, ~17 insns) longer than Q2 (~8), so Q1 takes $a0 --
 *      retail has them the other way round.  MEASURED NEGATIVE: reversing the three
 *      array-read statements, routing the index through a second local, wrapping the three
 *      reads in a block scope (all exactly 60).
 *  (2) the two `sll sN,s2,2` sites emit one slot after the `lui/addiu` pair, retail one
 *      slot before (4 diffs).
 *  (3) the Camera_GetMode result: retail copies `$v0` into `$a1` in the following load's
 *      delay slot; ours nops it.  MEASURED NEGATIVE: an explicit copy-through local
 *      (`n = Camera_GetMode(...); mode = n;`) = 96 diffs / +2 insns.
 *  (4) the DR_MODE tail: t1<->t2 rotation of the two hoisted 0x00ffffff / 0xff000000 mask
 *      literals (SAME materialization order, reversed registers -- a local_alloc tie) plus
 *      the packet-cursor bump scheduled 2 slots late.  MEASURED NEGATIVE: moving the bump
 *      between the two merges = 66.  The IDENTICAL t1<->t2 rotation appears in
 *      Font_TextXY's tail, so one lever would fix both.
 *  -G8 IDENTITY PROBE: -G8 gives 58 (2 better) with zero regressions across the TU, but
 *  every %gp_rel symbol in the weather oracles is <=4 bytes (the >4-byte server arrays are
 *  modelled as per-element split storage and their RUNTIME-index sites use an absolute
 *  base), so there is no positive -G8 discriminator -- NOT adopted.
 * ---- w50-a10: 40 -> 36, count still EXACT 197/197, zero TU regressions.  LANDED: the
 * zero-insn OPACITY FENCE on `ab` (see the MATCH comment at its assignment) -- it fixes
 * tie (3)'s ORDER half: retail loads Input_gLookBehind[player] BEFORE building the
 * prevLookBehind[] address, ours built the address first; the fence is the value-numbering
 * barrier that stops cse from hoisting the address computation over the load.  The residual
 * is now TWO clusters, both pure 2-register rotations at exact count:
 *   (A) head a0<->a1: retail index=$a0 / &Weather_gPServerA=$a1, ours mirrored (8 lines).
 *   (B) 54-76: retail keeps `ab` AND then `mode` in $a1 (with a real `addu a1,v0,zero` copy
 *       of the Camera_GetMode result filling the jal delay slot where ours nops), ours keeps
 *       them in $v1/$v0 with no copy -- the delete_noop_moves "retail keeps a copy" identity.
 * FALSIFIED THIS WAVE at the 40 base: fence on `mode` (49 @198 -- it DOES mint the copy but
 * as an extra insn, not in the slot), fence on `ab`+`mode` together (45 @198), fence on
 * `player` (50), do{}while(0) depth wrapper on the three server-array reads (50), the same
 * wrapper on just the first read (50), reversing the three reads to wd/wprevpt/wpt (36,
 * neutral -- re-confirms the w41 measurement in the new basin), fence on `wpt` (56). */
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
  int *plb;
  u_int *pal;

  /* NEAR-MISS 36 (count EXACT 197/197) -- CLASSIFIED (W55-A16).  allocsim replicates
     this function's GLOBAL handout 25/25 EXACTLY, so none of the residual is a global
     allocno tie and reqdelta has no dial to offer.  Every diff is a swap between two
     BLOCK-LOCAL qtys that local-alloc.c (not global.c) hands out:
       blocks 1-4: the `lo_sum(&Weather_gPServer)` base (ours $a0 / oracle $a1) vs the
                   scaled index `sll s2,2` (ours $a1 / oracle $a0) -- RTL p92 vs p95,
                   neither of which appears in `;; N regs to allocate:`;
       blocks 5-8: the `ab` load and the prevLookBehind address, same $v1<->$a1 swap.
     qtyprio puts p95 (refs=4, live=8) at QTY_PRI 1.0 while p92 is a 2-ref lo_sum, so the
     order is decided by local-alloc's GROUP-1/GROUP-2 suggestion split, which is the
     catalog's named 06E instrument gap ("local-alloc QTY handouts, outside allocsim's
     model") and needs tools/qtytrace.py against an INSTRUMENTED cc1 to dial.  Do not
     spend more source-shape guesses here until that instrument exists. */
  /* MATCH (w60-a6): 36 -> 30, count still EXACT 197/197.  The w55 verdict above ("do not
     spend more source-shape guesses until qtytrace exists") is HALF-refuted: the $a0<->$a1
     swap on the base/scaled-index pair at :1505-1507 IS reachable with a plain ref dial --
     a zero-insn read-only fence on `player` placed AFTER the three array reads (+1 ref,
     out-of-loop) flips the whole 4-block cascade (blocks 1-4 of the w55 census).
     POSITION IS THE DIAL, not the operand count: after the three reads = 30; BEFORE them
     = 46 (worse than baseline); 1, 2 and 3 operands all measure 30, so take one.
     ALSO MEASURED, NOT LANDED: index-term-first cast spelling on all three reads
     (`*(T **)((player << 2) + (int)Weather_gPServerA)`) = 36, exactly neutral -- the
     sec.5.0c commutative-addu operand order is ALREADY right in both builds here (both
     emit `addu rD,<index>,<base>`), so only the register assignment differed; and a named
     `int one = 1;` for the `commMode != 1` compare (aimed at retail's early `li $a2,1`,
     residual block 2 below) = 29 diffs but 198 insns -- REJECTED, the count must stay exact.
     RESIDUAL 30, two clusters: (a) retail materializes the `1` of the commMode compare ~10
     slots early (`li $a2,1` at index 18, SLD 1086) and loads commMode into $v0 rather than
     $v1 -- a scheduler hoist of a ready `li`, and the named-constant device pays an insn for
     it; (b) the $v1<->$a1 swap on the `ab` load / prevLookBehind address (w55 blocks 5-8),
     untouched by this fence and still the 06E local-alloc-QTY instrument gap. */
  /* MATCH (w61-a14, 2026-08-15): 30 -> 18, count still EXACT 197/197.  The w55 'do not
     spend more source-shape guesses until qtytrace exists' verdict is now FULLY refuted --
     the w55 blocks-5-8 $v1<->$a1 swap (the `ab` load vs the prevLookBehind address, filed
     as the 06E local-alloc-QTY instrument gap) IS source-reachable:
      (1) give the prevLookBehind slot a REAL POINTER LOCAL `plb` and LAUNDER it with the
          CSE-opaque identity fence `__asm__("" : "=r"(plb) : "0"(plb));` -- 30 -> 20.
          The SAME pointer WITHOUT the launder measures exactly 30 (byte-identical to the
          control): cse folds the address straight back into the two `s1 + %lo` rtxes, so
          the launder is the whole lever, not the naming.  Zero-insn.
      (2) `clean_up = 0;` moved BELOW the plb setup -- 20 -> 18; retail issues
          `addu s0,zero,zero` in the `beq a1,v0` DELAY SLOT, which it can only do if the
          statement is adjacent to the guard.
     FALSIFIED from the 30 basin (all re-gated, count-exact unless noted): read-only ref
     fences on `ab` after the opacity fence x1/x2 (30/30, byte-identical), after
     `clean_up = 0` (32), after the prevLookBehind store (32); fence on `mode` x1 (39 @198)
     and an identity launder on `mode` (39 @198) -- the tie-(3) `addu a1,v0,zero` copy of
     the Camera_GetMode result still resists (a tied launder shares the register, so it
     cannot manufacture a copy; that residual + the head `li a2,1` scheduler hoist are the
     whole remaining 18).  From the 20 basin an `ab` fence is neutral again (20). */
  /* ---- MATCH (w63-a13, 2026-08-15): 18 -> 6 diffs, count still EXACT 197/197.  BOTH of
     the w61 "whole remaining 18" clusters are now cracked, and neither needed the qtytrace
     instrument the w55 verdict demanded.
     (1) THE Camera_GetMode COPY -- see the 12D staging receipt at its call site below
         (`ab` carries the mode; the SYM has no `mode` local).  18 -> 12.
     (2) THE HEAD `li a2,1` HOIST -- 12 -> 6, and it is TWO cooperating source facts:
         (a) read commMode into a local `cm` BEFORE the three server-array reads, so its
             load is schedulable alongside them (retail interleaves it: lw s6, lw s7,
             lw v0=commMode, lw s4).  With the read left after the array reads the
             `__asm__("" : : "r"(player))` fence BELOW them is a scheduling barrier that
             pins the commMode load past all three -> a load-delay `nop` (+1 insn), which
             is exactly why every earlier "name the constant" probe measured 198.
         (b) name the compare's `1` (`int one = 1;`) immediately above that fence, so the
             constant is born early and lives across the array reads = retail's `li a2,1`
             at index 18.
         POSITION IS THE WHOLE DIAL for (a): cm read BEFORE the three array reads = 6;
         between reads 1 and 2 = 22; between 2 and 3 = 22; AFTER them = 5 diffs but 198
         insns (count-inexact, rejected by the bar).  For (b): `one` above the fence = 6;
         `one` alone with cm left inline = 7 @198; `one` shared with the other two literal
         1s in the fn (`clean_up = ab == 1`, `clean_up = 1`) = 33 @200.
     🔴 BASIN NOTE (04Z, another confirmation on this belt): the w60 receipt REJECTED a
     named `int one = 1;` as "29 diffs but 198 insns"; in the post-12D basin the identical
     declaration is count-EXACT and worth 6.  That falsification was basin-relative.
     ALSO FALSIFIED from the 12 and 6 basins (all re-gated): a read-only fence or an
     identity launder on `cm` (12/12/12, byte-identical) . a 2-operand `player` fence
     (12) . moving the `player` fence below the commMode guard (18, i.e. the fence's
     position is still load-bearing) . `cm` as a split decl+assign (6, bit-identical) .
     a `*(volatile int *)&` view on the commMode read (6, bit-identical) .
     `int gt = simGlobal.gameTicks;` hoisted at the LastProcessTime guard (6) .
     index-term-first cast spelling on Weather_gLastProcessTimeA (14, worse).
     RESIDUAL 6, two clusters, both count-exact:
       (A) 23-26: retail materialises the commMode base as a SELF-TEMP
           (`lui v0,0 ... lw v0,0(v0)`) born AFTER the three addu's; ours hoists that
           `lui` into the early lui group and gives it its own scratch ($a3), so the load
           reads `lw v0,0(a3)`.  Same self-temp-vs-separate-scratch class as
           methodology 3.15 / catalog E.
       (B) 89-92: `sll s0,s2,2` emitted one slot AFTER the `lui/addiu` pair where retail
           has it one slot BEFORE -- the surviving half of the w41 tie (2). */
  /* ===== 🏆 w64-a13 (2026-08-15): CLUSTER (B) IS SOLVED -- **6 -> 4, count still EXACT
   * 197/197**, via ONE PER_FN_TEXT_MOVES row (the 12F/15D pure-line-relocation class).
   * Probe-verified TWICE with tools/vprobe.py + W60_TEXT_MOVES_FILE; the row file is kept
   * at scratchpad/w64a13/tm_weather.json.
   * ORCHESTRATOR WIRING SPEC -- build.py PER_FN_TEXT_MOVES:
   *
   *   "recon/game/psx/weather.cpp": {
   *       "Weather_DoWeather__FP13DRender_tView": [
   *           {"take":  r"\tsll\t\$16,\$18,2\n",
   *            "after": r"\tlui\t\$3,%hi\(simGlobal\+4\) # high\n"
   *                     r"(?=\tlui\t\$2,%hi\(Weather_gLastProcessTime\))"},
   *       ],
   *   },
   *
   * `sll $16,$18,2` occurs exactly ONCE in the fn region; the anchor is lookahead-pinned on
   * the following `lui $2,%hi(Weather_gLastProcessTime)` line (numeric registers, label-
   * agnostic, per the 15D anchor law).
   * SEMANTICS: the moved `sll $16,$18,2` reads $18 and writes $16; the two lines it hops
   * over are `lui $2,%hi(Weather_gLastProcessTime)` / `addiu $2,$2,%lo(...)`, which read and
   * write only $2.  Its consumer `addu $5,$16,$2` still follows both.  Disjoint def/use
   * sets in both directions -- a pure scheduling permutation, retail's own order.
   * CLUSTER (A) STAYS (the commMode self-temp).  TEXT_MOVES cannot express it: moving our
   * hoisted `lui $7,%hi(GameSetup_gData+12)` down to its load would still leave `lui $7 /
   * lw $2,%lo(..)($7)` against retail's self-temp `lui $2 / lw $2,%lo(..)($2)` -- the
   * REGISTER differs, and a text move never renames.  Source levers FALSIFIED this wave
   * (all re-gated from the 6 base): the `"r"(player)` fence hoisted ABOVE the cm read 30 .
   * a second fence there as well 30 . an RO fence on `cm` right after the read 30 . the cm
   * read moved down to just above the guard 7 @198 . the read spelled inline at the guard
   * 7 @198 . the read through an explicit `((GameSetup_tData *)&GameSetup_gData)->commMode`
   * pointer form 6 (bit-identical).  The three 30s are one mechanism: any barrier above the
   * array reads re-pins the whole prologue lui group.
   * NEXT TAKER for (A): the lui is hoisted into the PROLOGUE lui group by sched1, and it is
   * the hoist (not the declaration shape) that forces the separate scratch -- so the device
   * has to keep the lui adjacent to its load without adding a barrier above the array
   * reads.  §3.12 #5's declaration axis does not apply (this is a struct FIELD of an
   * already-absolute global, and the pointer-form spelling measures bit-identical).
   * w67-a7: the position-pinned MACRO-form device (15E menu form 1) is UNREACHABLE for a
   * struct FIELD on this lane: a scalar view `extern int X __asm__("GameSetup_gData+12")`
   * makes cc1 emit `.extern GameSetup_gData+12,4` and GNU-as rejects the expression in
   * the directive (junk at end of line).  An offset-free array view keeps the split
   * (schedulable) form, so the macro route needs a symbol AT the field address, which
   * does not exist.  Cluster (A) stays the named sched1-hoist angle. */
  player = Vi->player;
  int cm = GameSetup_gData.commMode;
  wpt = Weather_gPServerA[player];
  wprevpt = Weather_gPrevPServerA[player];
  wd = Weather_gDrawnServerA[player];
  int one = 1;
  __asm__("" : : "r"(player));
  if ((cm != one) && (0x20 < simGlobal.gameTicks - timechange)) {
    timechange = simGlobal.gameTicks;
    if (Weather_gSnowTrack == 0) {
      Weather_ChangeIntensityBasedOnTime();
    }
    Weather_ChangeDensityBasedOnTime();
  }
  if (Weather_gSys.num[0] != 0) {
    /* force a wasDrawn-clear when the look-behind state or the camera mode just changed */
    ab = Input_gLookBehind[player];
    /* MATCH (w50-a10): OPACITY FENCE -- retail keeps `ab` in a caller-saved arg
     * reg ($a1) whose value cse/copy-prop would otherwise fold into the compare,
     * and loads it BEFORE building the prevLookBehind[] address.  The zero-insn
     * identity fence blocks the value-numbering that reorders the two.  40->36. */
    __asm__("" : "=r"(ab) : "0"(ab));
    plb = &prevLookBehind[player];
    __asm__("" : "=r"(plb) : "0"(plb));
    clean_up = 0;
    if (ab != *plb) {
      clean_up = ab == 1;
    }
    *plb = ab;
    /* MATCH (w63-a13, 18 -> 12, count still EXACT 197/197): THE 12D DEAD-PSEUDO STAGING
     * LAW, and the SYM is the proof.  The `8c` block lists exactly
     * {n,wpt,wprevpt,wd,player,ab,clean_up,i,prim} -- there is NO `mode` local, and
     * retail carries the Camera_GetMode result in $a1, which is `ab`'s own register.
     * `ab` is DEAD after `*plb = ab;`, so retail simply REUSED IT.  Assigning into the
     * existing variable (instead of adding a `mode` pseudo) mints retail's
     * `addu a1,v0,zero` copy in the jal delay slot for free -- the copy that four waves
     * of fences and launders on a separate `mode` could not manufacture (w41 explicit
     * copy-through-local 96 @199 . w50 fence on mode 49 @198 . w61 fence 39 @198 and
     * identity launder 39 @198, all rejected on count).  12D's rule reads exactly:
     * "do NOT add a variable -- find the EXISTING variable that owns that register". */
    ab = Camera_GetMode(player);
    if (ab != prevCameraMode[player]) {
      clean_up = 1;
    }
    prevCameraMode[player] = ab;
    if (clean_up != 0) {
      i = 0;
      if (0 < Weather_gSys.num[player]) {
        do {
          wd[i] = 0;
          i = i + 1;
        } while (i < Weather_gSys.num[player]);
      }
    }
    if (1 < simGlobal.gameTicks - Weather_gLastProcessTimeA[player]) {
      Weather_gLastProcessTimeA[player] = simGlobal.gameTicks;
      Weather_ProcessParticles(Vi,Weather_gSys.num[player],wpt,wd);
    }
    Weather_SetIdentMatrix();
    if (Camera_gInfo[player].inCar) {
      Weather_DoSplats(Weather_gSys.num[player] >> 3,Weather_gSplatInfoServerA[player]);
    }
    /* emit one snow/rain primitive per particle.
     * MATCH: INDEX form `wpt[n]` / `wprevpt[n]`, NOT an in-place `wpt++` walk.  The SYM
     * `8c` block lists exactly {n,wpt,wprevpt,wd,player,ab,clean_up,i,prim} -- there are NO
     * cursor locals -- so the oracle's preheader `addu s0,s6,zero` / `addu s2,s7,zero` +
     * `addiu s0,s0,8` / `addiu s2,s2,4` are loop.c GIVs strength-reduced out of the index
     * form.  In-place `wpt++` gives the loop's refs to wpt itself and mis-colors the whole
     * saved-reg file; a hand-written cursor pair reproduces the insns but not the coloring. */
    n = 0;
    if (0 < Weather_gSys.num[player]) {
      do {
        if (Weather_gType == Weather_kRain) {
          Weather_CreateRain(wpt + n,wprevpt + n,wd + n);
        }
        else {
          Weather_CreateSnow(wpt + n);
        }
        n = n + 1;
      } while (n < Weather_gSys.num[player]);
    }
    /* tail: link a DR_MODE primitive into the OT to reset the texture page */
    prim = (DR_MODE *)RENDER_PACKETPTR_ADDR;
    pal = (u_int *)RENDER_PALETTEPTR_ADDR;
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *pal & 0xffffff;
    /* MATCH: bump the cursor off the ALREADY-LOADED `prim`, not by re-reading the
     * scratchpad slot -- the oracle has `addiu v1,a0,12; sw v1,0(t3)` (2 insns) where a
     * re-read spelling emits lw+addiu+sw (3). */
    /* MATCH: palette write-back BEFORE the cursor bump (same order lever as
     * Weather_CreateSplat) -- the scheduler then interleaves the bump into the
     * palette merge like retail. */
    /* w46-a9 (46 -> 42): the CreateSplat/CreateSnow packet-emission recipe, partially.
     * The cursor bump is SPLIT into a value statement and its store, the palette RMW is
     * SPLIT (read first), and the cursor store is placed BETWEEN the palette read and the
     * addr24 mask.  Measured here: this form 42 · with a leading zero-byte fence 48 ·
     * fence + store after the mask 48 · fence + store last 52 · fence only 52 · split
     * bump without the palette split 46/46.  Unlike the two sibling emitters a fence is
     * NEGATIVE here (this tail sits at the end of a 197-insn function whose residual is a
     * whole-function allocno permutation, so the barrier costs more than it buys). */
    {
      u_char *next = (u_char *)prim + 0xc;
      u_int palw = *pal;
      RENDER_PACKETPTR_ADDR = next;
      u_int addr24 = (u_int)prim & 0xffffff;
      *pal = palw & 0xff000000 | (addr24 & 0xffffff);
    }
    SetDrawMode(prim,0,0,0x20,(RECT *)0x0);
  }
}

/* ---- Weather_BuildWeather__FP13DRender_tView  [WEATHER.CPP:1159-1186] SLD-VERIFIED ---- */
void Weather_BuildWeather(DRender_tView *Vi)

{
  BOOL pvVar1;

  if ((GameSetup_gData.Weather != 0) &&
     (pvVar1 = BWorldSm_TunnelFlagSm
                         (&Camera_gInfo[Vi->player].slicePos), pvVar1 == 0)) {
    Weather_DoWeather(Vi);
  }
  return;
}

/* end of weather.cpp */

/* owning-TU def (link-harness) */
