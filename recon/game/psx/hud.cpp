/* game/psx/hud.cpp -- RECONSTRUCTED (NFS4 PSX in-race HUD; C++ TU)
 *   62 fns: sprite/poly builders, tachometer, number rasterizer, mini-map + radar,
 *   CD player, wingman interface, render views (hud/tac/map/stats), 3-2-1-GO, BTC/busted.
 *   Reconstructed with full SYM-locals applied (audited).
 */
#include "../../nfs4_types.h"
#include "hud_externs.h"

/* ---- Hud.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero; extern-vs-SYM disagreements resolved to SYM) ---- */
int          BigBTCTime_state1 = 50;   /* @0x8013d920 */
int          BigBTCTime_state2;   /* @0x8013d924  (bss(zero)) */
signed char  oldCountdown = -1;   /* @0x8013D91D */
tSmallCoordXY Hud_gElementPositions[2][19] = { { {22, 54}, {159, 19}, {8, 19}, {18, 35}, {8, 204}, {221, 24}, {23, -2}, {21, -2}, {23, -3}, {2, -4}, {7, 50}, {4, 18}, {-41, 0}, {90, 212}, {253, 162}, {8, 196}, {218, 20}, {160, 97}, {160, 97} }, { {22, 56}, {252, 17}, {8, 17}, {26, 30}, {8, 101}, {128, 18}, {23, -2}, {21, -2}, {23, -3}, {2, -1}, {7, 52}, {4, 18}, {-42, 0}, {90, 105}, {259, 60}, {8, 72}, {215, 22}, {160, 99}, {160, 42} } };   /* @0x80120924 */
u_long       day_needle[30] = { 657850u, 16053492u, 657850u, 657850u, 657850u, 236260u, 657850u, 657850u, 657850u, 657850u, 526344u, 657850u, 16053492u, 43184u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 43184u, 657850u, 0, 0, 0 };   /* @0x801209bc */
u_long       night_needle[30] = { 657850u, 1147055u, 4168420u, 657850u, 657850u, 236260u, 657850u, 657850u, 657850u, 657850u, 526344u, 4110581u, 2648104u, 43184u, 657850u, 657850u, 4110581u, 4168420u, 657850u, 657850u, 657850u, 657850u, 657850u, 657850u, 4110581u, 43184u, 657850u, 0, 0, 0 };   /* @0x80120a34 */
u_long       Hud_Character[5] = { 4347332u, 4337928u, 15776284u, 7617052u, 0 };   /* @0x80120aac */
float        fMapScaleX[11] = { 39.5f, 50.0f, 44.0f, 43.5f, 39.5f, 52.599998474121094f, 43.400001525878906f, 33.5f, 35.599998474121094f, 29.799999237060547f, 38.0f };   /* @0x80120ac0 */
float        fMapScaleY[11] = { 40.79999923706055f, 50.0f, 46.099998474121094f, 45.29999923706055f, 36.70000076293945f, 51.20000076293945f, 42.400001525878906f, 32.5f, 37.29999923706055f, 27.399999618530273f, 37.900001525878906f };   /* @0x80120aec */
short        fMapOffX[11] = { 7, 0, 16, 3, -88, 19, 2, -5, -3, 45, 4 };   /* @0x80120b18 */
short        fMapOffY[11] = { 7, 0, -3, 2, -12, -7, 7, 4, 0, -32, -2 };   /* @0x80120b30 */
short        fMapRotate[11] = { 4032, 0, 454, 2476, 3694, 3689, 3758, 3822, 1370, 3808, 32 };   /* @0x80120b48 */
CVECTOR      Hud_gMarkerColor[12];   /* @0x80120b60  (bss(zero)) */
CVECTOR      Hud_gCopMarkerColor[12];   /* @0x80120b90  (bss(zero)) */
char         HudminChar[6] = { 58, 58, 39, 39, 39, 46 };   /* @0x8013d89c */
char         HudsecChar[6] = { 46, 58, 34, 34, 34, 44 };   /* @0x8013d8a4 */
int          BTC_playedsoundalready;   /* @0x8013d8ac  (bss(zero)) */
char         Hud_gWingmanInterface[2];   /* @0x8013d8b0  (bss(zero)) */
char         Hud_gWingmanFlashIcon[2];   /* @0x8013d8b4  (bss(zero)) */
int          Hud_gWingmanFlashTicks[2];   /* @0x8013d8b8  (bss(zero)) */
int          Hud_gDebugInfo = 1;   /* @0x8013d8c0 */
int          HudBustedOverlay;   /* @0x8013d928  (bss(zero)) */
int          Hud_gCdActive;   /* @0x8013d92c  (bss(zero)) */
int          Hud_ActivateCDPlayer;   /* @0x8013d930  (bss(zero)) */
int          BTC_Countdown;   /* @0x8013d934  (bss(zero)) */
int          FinalBTC_Countdown;   /* @0x8013d938  (bss(zero)) */
int          Hud_BeTheCop;   /* @0x8013d93c  (bss(zero)) */
int          Hud_kTurnSongOffNext;   /* @0x8013d940  (bss(zero)) */
short        HudBustedOverlayPlayer;   /* @0x8013d944  (bss(zero)) */
int          mapMarkerMCos;   /* @0x8013d948  (bss(zero)) */
int          mapMarkerMSin;   /* @0x8013d94c  (bss(zero)) */
int          Hud_gHudView[2];   /* @0x8013d950  (bss(zero)) */
int          Hud_gMapView[2];   /* @0x8013d958  (bss(zero)) */
int          Hud_gTacView[2];   /* @0x8013d960  (bss(zero)) */
int          Hud_gStatsView;   /* @0x8013d968  (bss(zero)) */
int          HudMapOffsetY;   /* @0x8013d96c  (bss(zero)) */
long         gMapRotate;   /* @0x8013d970  (bss(zero)) */
long         gMapScaleX;   /* @0x8013d974  (bss(zero)) */
long         gMapScaleY;   /* @0x8013d978  (bss(zero)) */
int          gMapOffX;   /* @0x8013d97c  (bss(zero)) */
int          gMapOffY;   /* @0x8013d980  (bss(zero)) */
int          Hud_gCdLastTick;   /* @0x8013d984  (bss(zero)) */
int          Hud_gCdScrollTitle;   /* @0x8013d988  (bss(zero)) */
tSmallCoordXY *g1Player;   /* @0x8013de04  (bss(zero)) */
SPRT         *gSprite0;   /* @0x8013de08  (bss(zero)) */
SPRT         *gSprite1;   /* @0x8013de0c  (bss(zero)) */
char         currentSpriteTransparent;   /* @0x8013de10  (bss(zero)) */
int          currentSpriteColor;   /* @0x8013de14  (bss(zero)) */
int          HudSplitTimeDiff1[2];   /* @0x8013de18  (bss(zero)) */
int          HudSplitTimeDiff2[2];   /* @0x8013de20  (bss(zero)) */
int          BTC_BonusTime;   /* @0x8013de28  (bss(zero)) */
int          BTC_BonusTimeTick;   /* @0x8013de2c  (bss(zero)) */
int          BTC_UserHasControl;   /* @0x8013de30  (bss(zero)) */
/* PerpOverlayOn[2] @0x8013de38 (bss(zero)). LANDED (Hud_Reset__Fv 8->2 diffs, insn count exact
 * 22/22): the oracle reaches this array's CONSTANT-index [0]/[1] clears in Hud_Reset as two
 * INDEPENDENT %gp_rel(D_8013DE38)/%gp_rel(D_8013DE3C) 4-byte scalars (each <=G4 -> gp-rel; both
 * listed in configs/gp_rel_symbols.txt), while Hud_Init/Perp_OverlayOn/Off/RenderHudView use
 * runtime-index/pointer-walk/byte-offset and keep absolute array codegen. Our gcc-2.8.0 CSEs the
 * two adjacent constant-index stores onto ONE absolute base (lui+sw+addiu+sw), so GAS -G4 sees one
 * 8-byte object, not two 4-byte ones. Split into two tentative-def scalars (weather.cpp
 * Weather_gLastProcessTime0/1 precedent) -- defeats the CSE, reproduces the per-element gp-rel.
 * The residual 2 is a genuine `lui $a1,%hi(BTC_CurrentPerpName)` HOIST-POSITION scheduling tie
 * (oracle emits it before `lui $v1,%hi(Hud_NextPerp)`, ours after -- tried reordering the loop
 * body statement that consumes BTC_CurrentPerpName, regressed 2->6, reverted; not source-reachable).
 * ⚠️ KNOWN DUALITY, NOT COLLAPSED (same open issue as weather.cpp Weather_gLastProcessTime0/1):
 * PerpOverlayOn0/1 are a SEPARATE (not memory-aliased) object from PerpOverlayOn[0..1].
 * Hud_Reset now only WRITES the scalars, not the array -- Hud_RenderHudView reads the array
 * (`*(int*)((int)PerpOverlayOn+viewOff) != 0`, ~line 3351) and Perp_OverlayOn/Off (~line
 * 3849/3881) write the array by player index. So Hud_Reset() no longer actually zeroes the
 * PerpOverlayOn[] runtime state a renderer can observe -- if it was left nonzero by a prior
 * Perp_OverlayOn() and Hud_Reset() runs without an intervening Perp_OverlayOff()/Hud_Init(),
 * Hud_RenderHudView could show a stale busted-overlay message. Flagged as a real behavior
 * change, not silently accepted; a full fix needs a link-level aliasing pass (out of scope for
 * a single-diff codegen lever, and out of scope for this pass' file-only mandate). */
int          PerpOverlayOn0;   /* per-element gp-rel dual (Hud_Reset constant-index site) */
int          PerpOverlayOn1;   /* per-element gp-rel dual (Hud_Reset constant-index site) */
int          PerpOverlayOn[2];   /* @0x8013de38  (bss(zero)) */
int          PerpOverlayMessage[2];   /* @0x8013de40  (bss(zero)) */
int          Hud_gShowedCDPlayer;   /* @0x8013de48  (bss(zero)) */
DR_MODE      gTPage0[2][4];   /* @0x8013e390  (bss?) */
DR_MODE      gTPage1[2][4];   /* @0x8013e3f0  (bss?) */
POLY_F4      gHudF4[14];   /* @0x8013e450  (bss?) */
POLY_FT4     gHudFT4[10];   /* @0x8013e5a0  (bss?) */
POLY_G4      gHudG4[8];   /* @0x8013e730  (bss?) */
char         BTC_CurrentPerpName[10];   /* @0x8013e850  (bss?) */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Hud_CreateHudViews(void);
void Hud_GoTpage(int page);
void Hud_DebugInfo(void);
void Hud_DebugCrap(void);
void Hud_BuildSprite(SPRT *sprt,int shapeIdx,int x,int y,u_long color,int trans);
void Hud_BuildSprite2(SPRT *sprt,int shapeIdx,int x,int y);
void Hud_FBuildSprite(int shapeIdx,int x,int y,u_long color,int trans);
void Hud_BuildSpriteFromFont(SPRT *sprt,char ch,int x,int y);
void Hud_BuildF3(POLY_F3 *prim,HudPmx_tShape *shape,int x,int y,u_long color);
void Hud_BuildGT4(POLY_GT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color);
void Hud_BuildFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans);
void Hud_BuildMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans);
void Hud_BuildMapMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans);
void Hud_BuildF4(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color);
void Hud_BuildF4o(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color,signed char x0off,signed char x1off);
void Hud_FBuildGT4(HudPmx_tShape *shape, int x, int y, u_long col1);
void Hud_FBuildFT4(HudPmx_tShape *shape, int x, int y, u_long col1);
void Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char x0off, char x1off);
void uppercase(char *string);
void Hud_Kill(void);
void Hud_Init0(void);
void Hud_InitMapFrame(int i,int mode);
void Hud_BuildTimeSprites(SPRT *sprt,char *str,int x,int y);
void Hud_Init(void);
void Hud_InitTables(void);
void Hud_BuildETimeString(SPRT *sprt,int time);
void * Hud_BuildDistanceString(SPRT *sprt,int player);
void Hud_BuildTimeString(SPRT *sprt,int time);
void Hud_BuildTach(int player);
int Hud_BuildString(char *str,int x,int y,int color,int player,bool justwidth);
void Hud_BuildNumbers0(int player);
void Hud_BuildNumbers(int player);
void Hud_InitMap(void);
void Hud_BuildMapMarkers(int player);
void Hud_WingmanFlash(int player,int index);
void Hud_BuildWingmanInterface(int player);
void Hud_InitCdPlayer(void);
int Hud_BuildCdPlayer(int type,int arg1);
int Hud_BuildRadar(int player);
void Hud_BuildReplay(void);
int Hud_NextPlayer(int player);
char * Hud_NextPlayerNameOrCarOrTime(int player);
void Hud_RenderMapView(void);
void Hud_BlackThinBox(int x, int y, int w, int h);
int Hud_Draw321Num(int x,int y,int num,int flare_intensity,int arg4,int arg5);
void Hud_Render321Go(void);
void BigBTCTime(int secs);
void Hud_RenderHudView(void);
void Hud_RenderTacView(void);
void Hud_ParseTime(int nTime,char *sLapTime);
void Hud_RenderPauseBox(int x, int y, int w, int h);
void Hud_Render(void);
void Hud_PositionMap(void);
void Hud_BTC_Update(char *perpname,int timeleft,bool userHasControl);
void Hud_BustedOverlayOn(int time,char *name,bool caught,short player);
void Hud_BustedOverlayOff(void);
void Hud_Reset(void);
void Hud_BTC_QuitOut(void);
void Hud_BTC_BonusTime(long extratime);
void Hud_Perp_OverlayOn(int player,int level);
void Hud_Perp_OverlayOff(int player);


/* ---- Hud_CreateHudViews__Fv  [HUD.CPP:273-375] SLD-VERIFIED ---- */
void Hud_CreateHudViews(void)
{
  int i;

  Hud_InitTables();
  Hud_BeTheCop = 0;
  for (i = 0; i < GameSetup_gData.numCars; i++) {
    if (GameSetup_gData.carInfo[i].carClass & 0x40) Hud_BeTheCop = 1;
  }
  if (GameSetup_gData.numPlayerRaceCars >= 2) {
    HudMapOffsetY = -6;
  } else if ((GameSetup_gData.numPlayerRaceCars + GameSetup_gData.numOpponentRaceCars) == 1
             || Hud_BeTheCop != 0) {
    HudMapOffsetY = 8;
  } else {
    HudMapOffsetY = 0;
  }
  if (GameSetup_gData.commMode == 1) {
    Hud_gMapView[0] = Draw_SetView(0x105, HudMapOffsetY + 0x13e, 0x245, HudMapOffsetY + 0x13e, 0x2d, 0x30, 0, 0, 1);
    Hud_gMapView[1] = Draw_SetView(0x105, HudMapOffsetY + 0x1a9, 0x245, HudMapOffsetY + 0x1a9, 0x2d, 0x30, 0, 0, 1);
    Hud_gHudView[0] = Draw_SetView(0,     0x100, 0x140, 0x100, 0x140, 0x78, 0, 0, 1);
    Hud_gHudView[1] = Draw_SetView(0,     0x178, 0x140, 0x178, 0x140, 0x78, 0, 0, 1);
    Hud_gTacView[0] = Draw_SetView(0x115, 0x113, 0x255, 0x113, 0x1c, 0x1c, 0, 0, 1);
    Hud_gTacView[1] = Draw_SetView(0x115, 0x17c, 0x255, 0x17c, 0x1c, 0x1c, 0, 0, 1);
  } else {
    Hud_gMapView[0] = Draw_SetView(0xff,  HudMapOffsetY + 0x1a4, 0x23f, HudMapOffsetY + 0x1a4, 0x2d, 0x30, 0, 0, 1);
    Hud_gHudView[0] = Draw_SetView(0,     0x100, 0x140, 0x100, 0x140, 0xf0, 0, 0, 1);
    Hud_gTacView[0] = Draw_SetView(0xb8,  0x115, 0x1f8, 0x115, 0x1c, 0x1c, 0, 0, 1);
  }
  Hud_gStatsView = Draw_SetView(0, 0x100, 0x140, 0x100, 0x140, 0xf0, 0, 0, 1);
}

/* ---- Hud_GoTpage__Fi  [HUD.CPP:380-383] SLD-VERIFIED ---- */
void Hud_GoTpage(int page)

{
  int addr_24;
  u_int tp1_hi;
  DR_MODE *prim;
  u_char *p;
  u_char *tp1;

  addr_24 = (int)&Render_gPalettePtr;
  p = Render_gPacketPtr;
  tp1 = Render_gPalettePtr;
  *(u_int *)p =
       *(u_int *)p & 0xff000000 | *(u_int *)*(u_char **)addr_24 & 0xffffff;
  tp1_hi = *(u_int *)tp1 & 0xff000000;
  Render_gPacketPtr = p + 0xc;
  addr_24 = (u_int)p & 0xffffff;
  *(u_int *)tp1 = tp1_hi | addr_24;
  SetDrawMode((DR_MODE *)p,0,0,(page * 0x40 + 0x80U & 0x3ff) >> 6,(RECT *)0x0);
  return;
}

/* ---- Hud_DebugInfo__Fv  [HUD.CPP:479-531] SLD-VERIFIED ---- */
void Hud_DebugInfo(void)
{
  char string[20];
  int  b, t;

  sprintf(string, "SLC %d", (int)(Cars_gList[0]->N).simRoadInfo.slice);
  Font_TextXY(string, 0xe6, 0x2d);
  Hud_FBuildF4(1, 0xe6, 0x30, textpixels(string) + 5, 10, 0x50505, '\0', '\0');
  b = AudioMus_Buffered();
  t = AudioMus_Threshold();
  sprintf(string, "AUD %d.%d/%d.%d", b / 1000, (b % 1000) / 100, t / 1000, (t % 1000) / 100);
  Font_TextXY(string, 0xe6, 0x23);
  Hud_FBuildF4(1, 0xe6, 0x26, textpixels(string) + 5, 10, 0x50505, '\0', '\0');
  CopSpeak_Debug();
}

/* ---- Hud_DebugCrap__Fv  [HUD.CPP:536-551] SLD-VERIFIED ---- */
void Hud_DebugCrap(void)

{
  return;
}

/* ---- Hud_BuildSprite__FP4SPRTiiiUli  [HUD.CPP:556-569] SLD-VERIFIED ---- */
void Hud_BuildSprite(SPRT *sprt,int shapeIdx,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_short uVar2;
  int tu1;
  HudPmx_tShape *shape;
  HudPmx_tShape *pHVar3;
  u_int uVar4;
  u_int uVar5;
  
  pHVar3 = HudPmx_gShapes + shapeIdx;
  SetSemiTrans(sprt,trans);
  *(u_char *)((int)&sprt->tag + 3) = 4;
  uVar4 = color | 0x66000000;
  *(u_int *)&sprt->r0 = uVar4;
  uVar5 = y << 0x10 | x;
  *(u_int *)&sprt->x0 = uVar5;
  *(u_int *)&sprt->u0 = *(u_int *)&pHVar3->pixmap;
  *(u_int *)&sprt->w = (int)HudPmx_gShapes[shapeIdx].height << 0x10 | (int)HudPmx_gShapes[shapeIdx].width;
  return;
}

/* ---- Hud_BuildSprite2__FP4SPRTiii  [HUD.CPP:573-574] SLD-VERIFIED ---- */
void Hud_BuildSprite2(SPRT *sprt,int shapeIdx,int x,int y)

{
  Hud_BuildSprite(sprt,shapeIdx,x,y,currentSpriteColor,(u_int)(u_char)currentSpriteTransparent);
  return;
}

/* ---- Hud_FBuildSprite__FiiiUli  [HUD.CPP:579-582] SLD-VERIFIED ---- */
/* NEAR-MISS 24 diffs (37/37, count matches -- pure coloring): oracle loads the 5th stack
 * arg `trans` LATE (register $t1, right before it's stored into the Hud_BuildSprite arg
 * slot) and gives $t2 to the Render_gPacketPtr scratchpad-address scratch (loaded early);
 * ours swaps the two ($t1=scratch-addr early, $t2=trans loaded early too) -- a v0/v1 swap
 * on the tag-merge masks cascades from the same root. Tried: dropping the tu1/prev_hi
 * locals (inlining the palette tag-merge) -- regressed to 37 diffs (worse). Genuine
 * allocator/scheduling tie-break for a stack-passed trailing arg; accepted near-miss. */
void Hud_FBuildSprite(int shapeIdx,int x,int y,u_long color,int trans)

{
  int tu1;
  u_char *prim;
  u_char *prev_pkt;
  u_int   prev_hi;

  prim = Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)prim =
       *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  prev_hi = *(u_int *)prev_pkt & 0xff000000;
  Render_gPacketPtr = prim + 0x14;
  tu1 = (u_int)prim & 0xffffff;
  *(u_int *)prev_pkt = prev_hi | tu1;
  Hud_BuildSprite((SPRT *)prim,shapeIdx,x,y,color,trans);
  return;
}

/* ---- Hud_BuildSpriteFromFont__FP4SPRTcii  [HUD.CPP:586-600] SLD-VERIFIED ---- */
void Hud_BuildSpriteFromFont(SPRT *sprt,char ch,int x,int y)

{
  u_int uVar1;
  int u;
  int v;
  int w;
  int h;
  int yo;
  
  Font_GetUVWH(ch,&u,&v,&w,&h,&yo);
  *(u_char *)((int)&sprt->tag + 3) = 4;
  *(u_int *)&sprt->r0 = currentSpriteColor | 0x66000000;
  *(u_int *)&sprt->x0 = (y + yo) * 0x10000 | x;
  sprt->u0 = (u_char)u;
  sprt->v0 = (u_char)v;
  sprt->clut = gFontClut;
  sprt->w = (short)w;
  sprt->h = (short)h;
  return;
}

/* ---- Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl  [HUD.CPP:620-625] SLD-VERIFIED ---- */
void Hud_BuildF3(POLY_F3 *prim,HudPmx_tShape *shape,int x,int y,u_long color)

{
  u_int uVar1;
  int iVar2;
  int iVar3;

  *(u_int *)&prim->r0 = color;
  SetPolyF3(prim);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  iVar2 = (short)shape->height / 2;
  *(u_int *)&prim->x1 = (y - iVar2) * 0x10000 | x + shape->width;
  iVar3 = (short)shape->height / 2;
  *(u_int *)&prim->x2 = (y + iVar3) * 0x10000 | x + shape->width;
  return;
}

/* ---- Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl  [HUD.CPP:629-643] SLD-VERIFIED ---- */
void Hud_BuildGT4(POLY_GT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color)

{
  u_char uVar1;
  u_short uVar2;
  u_int uVar3;
  int tu2;
  int uv23_pack;
  int tpage_clut;
  int w_h_pack;
  
  *(u_char *)((int)&prim->tag + 3) = 0xc;
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->r0 = color | 0x3e000000;
  *(u_int *)&prim->r1 = color;
  *(u_int *)&prim->r2 = color;
  *(u_int *)&prim->r3 = color;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  return;
}

/* ---- Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli  [HUD.CPP:647-658] SLD-VERIFIED ---- */
void Hud_BuildFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_short uVar2;
  u_int uVar3;
  int tu2;
  int tu3;
  int tu4;
  int tu5;
  
  *(u_int *)&prim->r0 = color;
  SetPolyFT4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  return;
}

/* ---- Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli  [HUD.CPP:662-677] SLD-VERIFIED ---- */
void Hud_BuildMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_char uVar2;
  u_short uVar3;
  u_int uVar4;
  int tu2;
  int tu3;
  int tu4;
  int tu5;
  
  *(u_int *)&prim->r0 = color;
  SetPolyFT4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  prim->u1 = prim->u1 - 1;
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  prim->u3 = prim->u3 - 1;
  return;
}

/* ---- Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli  [HUD.CPP:682-704] SLD-VERIFIED ---- */
void Hud_BuildMapMirrorFT4(POLY_FT4 *prim,HudPmx_tShape *shape,int x,int y,u_long color,int trans)

{
  u_char uVar1;
  u_char uVar2;
  u_short uVar3;
  u_int uVar4;
  int tu2;
  int tu3;
  
  *(u_int *)&prim->r0 = color;
  SetPolyFT4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x + shape->width;
  *(u_int *)&prim->u0 = *(u_int *)((char *)&shape->pixmap + 0x0);
  *(u_int *)&prim->x1 = y << 0x10 | x;
  *(u_int *)&prim->u1 = *(u_int *)((char *)&shape->pixmap + 0x4);
  prim->x0 = prim->x0 + -3;
  prim->x1 = prim->x1 + -3;
  *(u_int *)&prim->x2 = (y + shape->height) * 0x10000 | x + shape->width;
  *(u_int *)&prim->u2 = *(u_int *)((char *)&shape->pixmap + 0x8);
  *(u_int *)&prim->x3 = (y + shape->height) * 0x10000 | x;
  *(u_int *)&prim->u3 = *(u_int *)((char *)&shape->pixmap + 0xc);
  prim->x2 = prim->x2 + -3;
  prim->x3 = prim->x3 + -3;
  return;
}

/* ---- Hud_BuildF4__FP7POLY_F4iiiiiUl  [HUD.CPP:712-724] SLD-VERIFIED ---- */
void Hud_BuildF4(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color)

{
  u_int uVar3;

  *(u_int *)&prim->r0 = color;
  SetPolyF4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->x1 = y << 0x10 | x + w;
  uVar3 = (y + h) * 0x10000;
  *(u_int *)&prim->x2 = uVar3 | x;
  *(u_int *)&prim->x3 = uVar3 | x + w;
  return;
}

/* ---- Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl  [HUD.CPP:728-743] SLD-VERIFIED ---- */
void Hud_BuildG4(POLY_G4 *prim,int trans,int x,int y,int w,int h,u_long col1,u_long col2,u_long col3,
               u_long col4)

{
  u_int uVar3;

  *(u_int *)&prim->r0 = col1;
  *(u_int *)&prim->r1 = col2;
  *(u_int *)&prim->r2 = col3;
  *(u_int *)&prim->r3 = col4;
  SetPolyG4(prim);
  SetSemiTrans(prim,trans);
  *(u_int *)&prim->x0 = y << 0x10 | x;
  *(u_int *)&prim->x1 = y << 0x10 | x + w;
  uVar3 = (y + h) * 0x10000;
  *(u_int *)&prim->x2 = uVar3 | x;
  *(u_int *)&prim->x3 = uVar3 | x + w;
  return;
}

/* ---- Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc  [HUD.CPP:747-757] SLD-VERIFIED ---- */
void Hud_BuildF4o(POLY_F4 *prim,int trans,int x,int y,int w,int h,u_long color,signed char x0off,signed char x1off)

{
  u_int uVar1;
  u_int uVar2;
  u_int uVar3;
  u_int uVar4;

  *(u_int *)&prim->r0 = color;
  SetPolyF4(prim);
  SetSemiTrans(prim,trans);
  uVar2 = y << 0x10 | x + x0off;
  *(u_int *)&prim->x0 = uVar2;
  uVar1 = y << 0x10 | x + w + (int)x1off;
  *(u_int *)&prim->x1 = uVar1;
  uVar3 = (y + h) * 0x10000;
  uVar4 = uVar3 | x;
  *(u_int *)&prim->x2 = uVar4;
  uVar3 = uVar3 | x + w;
  *(u_int *)&prim->x3 = uVar3;
  return;
}

/* ---- Hud_FBuildGT4__FP13HudPmx_tShapeiiUl  [HUD.CPP:762-765] SLD-VERIFIED ---- */
void Hud_FBuildGT4(HudPmx_tShape *shape, int x, int y, u_long col1)
{
  POLY_GT4 *prim;
  u_char   *prev_pkt;
  u_int     prev_hi;
  int       pkt_addr24;

  prim     = (POLY_GT4 *)Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)prim =
       *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  prev_hi = *(u_int *)prev_pkt & 0xff000000;
  Render_gPacketPtr = (u_char *)prim + 0x34;
  pkt_addr24 = (u_int)prim & 0xffffff;
  *(u_int *)prev_pkt = prev_hi | pkt_addr24;
  Hud_BuildGT4(prim, shape, x, y, col1);
}

/* ---- Hud_FBuildFT4__FP13HudPmx_tShapeiiUl  [HUD.CPP:768-771] SLD-VERIFIED ---- */
void Hud_FBuildFT4(HudPmx_tShape *shape, int x, int y, u_long col1)
{
  POLY_FT4 *prim;
  u_char   *prev_pkt;
  u_int     prev_hi;
  int       pkt_addr24;

  prim     = (POLY_FT4 *)Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)prim =
       *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  prev_hi = *(u_int *)prev_pkt & 0xff000000;
  Render_gPacketPtr = (u_char *)prim + 0x28;
  pkt_addr24 = (u_int)prim & 0xffffff;
  *(u_int *)prev_pkt = prev_hi | pkt_addr24;
  Hud_BuildFT4(prim, shape, x, y, col1, 0);
}

/* ---- Hud_FBuildF4__FiiiiiUlcc  [HUD.CPP:776-795] SLD-VERIFIED ----
 * NEAR-MISS 38 diffs (48/48 insn count exact): unlike the sibling Hud_FBuildGT4/FT4 (4 params,
 * fit a0-a3, PASS), this fn has 8 params -- w in $a3, h/col1/x0off/x1off reloaded from the
 * caller's stack area at sp+0x40/0x44/0x48/0x4c -- so the Render_gPacketPtr/PalettePtr MMIO
 * scratch-address idiom (§3.6b, identical body to the passing siblings) now competes for
 * caller-saved $t-regs with those 4 stack reloads. Oracle picks $t5 for the packet-ptr scratch
 * + $t3/$t4 for the two stack reloads it needs early; ours picks $t3 for the scratch + $t4/$t5
 * for the reloads -- a uniform register-class shift, insn-for-insn identical otherwise. Matches
 * the catalog's "register-materialization FLOOR (§3.15 v0-vs-a2 tie-break)" row E: maspsx/gcc
 * pick the address scratch from allocator state, not source-shapable without a working permuter.
 * Accepted as a near-miss floor. */
void Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char x0off, char x1off)
{
  POLY_F4 *prim;
  u_char  *prev_pkt;
  u_int    prev_hi;
  int      pkt_addr24;

  prim     = (POLY_F4 *)Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)prim =
       *(u_int *)prim & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  prev_hi = *(u_int *)prev_pkt & 0xff000000;
  Render_gPacketPtr = (u_char *)prim + 0x18;
  pkt_addr24 = (u_int)prim & 0xffffff;
  *(u_int *)prev_pkt = prev_hi | pkt_addr24;
  Hud_BuildF4o(prim, transparent, x, y, w, h, col1, x0off, x1off);
}

/* ---- uppercase__FPc  [HUD.CPP:790-795] SLD-VERIFIED ---- */
void uppercase(char *string)

{
  u_int uVar1;
  int n;
  u_char *pbVar2;

  uVar1 = strlen(string);
  n = 0;
  if (0 < (int)uVar1) {
    do {
      pbVar2 = (u_char *)(string + n);
      if ((u_int)(*pbVar2 - 0x61) < 0x1au) {
        *pbVar2 = *pbVar2 + (u_char)0xe0;
      }
      n = n + 1;
    } while (n < (int)uVar1);
  }
  return;
}

/* ---- Hud_Kill__Fv  [HUD.CPP:800-808] SLD-VERIFIED ---- */
void Hud_Kill(void)

{
  HudPmx_Kill();
  if (gSprite0 != (SPRT *)0x0) {
    purgememadr(gSprite0);
  }
  gSprite0 = (SPRT *)0x0;
  if (gSprite1 != (SPRT *)0x0) {
    purgememadr(gSprite1);
  }
  gSprite1 = (SPRT *)0x0;
  return;
}

/* ---- Hud_Init0__Fv  [HUD.CPP:813-820] SLD-VERIFIED ---- */
void Hud_Init0(void)

{
  gSprite0 = reservememadr("HUD1",0x80c,0);
  if (GameSetup_gData.commMode == 1) {
    gSprite1 = reservememadr("HUD2",0x80c,0);
  }
  return;
}

/* ---- Hud_InitMapFrame__Fii  [HUD.CPP:827-874] SLD-VERIFIED ---- */
void Hud_InitMapFrame(int i,int mode)

{
  SPRT *gSprt1;
  POLY_F4 *HudF4;
  POLY_FT4 *HudFT4;
  long splitY;
  int lx;
  int h1;
  int h2;
  int h3;
  int w1;
  int w2;
  int w3;

  if (i != 0) {
    gSprt1 = gSprite1;
  }
  else {
    gSprt1 = gSprite0;
  }
  HudF4 = gHudF4;
  if (i != 0) {
    HudF4 = gHudF4 + 7;
  }
  HudFT4 = gHudFT4;
  if (i != 0) {
    HudFT4 = gHudFT4 + 5;
  }
  splitY = 0;
  if (i != 0) {
    splitY = -0xd;
  }
  h1 = (int)HudPmx_gShapes[0xe].height;
  w1 = (int)HudPmx_gShapes[0xe].width;
  lx = (int)g1Player[0xe].x;
  h3 = h1 - (int)HudPmx_gShapes[0x14].height;
  w3 = w1 - (int)HudPmx_gShapes[0x18].width;
  h2 = (int)HudPmx_gShapes[0x18].height;
  w2 = (int)HudPmx_gShapes[0x14].width;
  if (mode == 1) {
    lx = lx + -0x1e;
  }
  currentSpriteColor = 0xff5721;
  currentSpriteTransparent = '\0';
  Hud_BuildSprite2(gSprt1 + 0x3f,0xe,lx,g1Player[0xe].y + HudMapOffsetY + splitY);
  Hud_BuildSprite2(gSprt1 + 0x40,0xf,g1Player[0xe].x + w1 + w2,
             g1Player[0xe].y + HudMapOffsetY + splitY);
  Hud_BuildSprite2(gSprt1 + 0x41,0x10,lx,g1Player[0xe].y + HudMapOffsetY + h1 + h2 + splitY);
  Hud_BuildSprite2(gSprt1 + 0x42,0x11,g1Player[0xe].x + w1 + w2,
             g1Player[0xe].y + HudMapOffsetY + h1 + h2 + splitY);
  Hud_BuildSprite2(gSprt1 + 0x43,mode + 0x14,lx + w1,g1Player[0xe].y + HudMapOffsetY + splitY);
  Hud_BuildSprite2(gSprt1 + 0x44,mode + 0x14,lx + w1,
             g1Player[0xe].y + HudMapOffsetY + h1 + h2 + h3 + splitY);
  Hud_BuildSprite2(gSprt1 + 0x45,0x18,lx,g1Player[0xe].y + HudMapOffsetY + h1 + splitY)
  ;
  Hud_BuildSprite2(gSprt1 + 0x46,0x18,g1Player[0xe].x + w1 + w2 + w3,
             g1Player[0xe].y + HudMapOffsetY + h1 + splitY);
  Hud_BuildF4(HudF4 + 4,1,0,0,0x2d,0x30,0);
  if (GameSetup_gData.mirrorTrack != 0) {
    Hud_BuildMapMirrorFT4(HudFT4,HudPmx_gShapes + 0x78,0,0,0x808080,1);
  }
  else {
    Hud_BuildFT4(HudFT4,HudPmx_gShapes + 0x78,0,0,0x808080,1);
  }
  Hud_BuildFT4(HudFT4 + 1,HudPmx_gShapes + 0x70,0,0,0x808080,1);
  Hud_BuildMirrorFT4(HudFT4 + 2,HudPmx_gShapes + 0x70,(int)HudPmx_gShapes[0x70].width,0,0x808080,1);
  Hud_BuildFT4(HudFT4 + 3,HudPmx_gShapes + 0x71,0,0,0x808080,1);
  Hud_BuildMirrorFT4(HudFT4 + 4,HudPmx_gShapes + 0x71,(int)HudPmx_gShapes[0x71].width,0,0x808080,1);
  return;
}

/* ---- Hud_BuildTimeSprites__FP4SPRTPcii  [HUD.CPP:883-923] SLD-VERIFIED ---- */
void Hud_BuildTimeSprites(SPRT *sprt,char *str,int x,int y)

{
  char cVar2;
  charactertbl *pcVar6;
  int w;
  int c;
  u_int uVar7;
  char langSec;
  char langMin;
  u_char bVar3;
  u_char bVar4;
  u_char bVar5;
  /* Ghidra hand-expanded these 2 as unaligned lwl/lwr bit-math on a stack
     pointer; the oracle is a plain compiler-generated rodata->stack aggregate
     copy (movstrsi shape, catalog wave-4 row) of a 6-char literal init. */
  char minSep [6] = {':', ':', '\'', '\'', '\'', '.'} /* @0x8013d8dc */;
  char secSep [6] = {'.', ':', '"',  '"',  '"',  ','} /* @0x8013d8e4 */;

  langMin = minSep[GameSetup_gData.userSetting.language];
  langSec = secSep[GameSetup_gData.userSetting.language];
  c = (u_char)*str;
  while (c != 0) {
    if (c == 0x4d) {
      c = langMin;
    }
    if (c == 0x53) {
      c = langSec;
    }
    w = (signed char)((charactertbl *)Font_Getcharacter(c))->advance + 1;
    Hud_BuildSpriteFromFont(sprt++,(char)c,x,y);
    str = str + 1;
    x = x + w;
    c = (u_char)*str;
  }
  return;
}

/* ---- Hud_Init__Fv  [HUD.CPP:930-1153] SLD-VERIFIED ---- */
void Hud_Init(void)

{
  int x;
  int y;
  int i;
  int j;
  int w1;
  int w2;
  u_long textcolour;
  SPRT *gSprt1;
  POLY_F4 *HudF4;
  POLY_G4 *HudG4;
  long splitY;
  int timelapshift;
  SPRT *spriteReplay;
  int baseX;
  int baseY;

  textcolour = 0xa0a0a0;
  i = 0;
  do {
    j = 0;
    do {
      SetDrawMode(&gTPage0[i][j],0,0,2,(RECT *)0x0);
      SetDrawMode(&gTPage1[i][j],0,0,3,(RECT *)0x0);
      j = j + 1;
    } while (j < 4);
    i = i + 1;
  } while (i < 2);
  i = 0;
  while (true) {
    if (DashHUD_gInfo.splitscreen < i) break;
    if (i != 0) {
      gSprt1 = gSprite1;
    }
    else {
      gSprt1 = gSprite0;
    }
    HudF4 = gHudF4;
    if (i != 0) {
      HudF4 = gHudF4 + 7;
    }
    HudG4 = gHudG4;
    if (i != 0) {
      HudG4 = gHudG4 + 4;
    }
    splitY = 0;
    if (i != 0) {
      splitY = -0xf;
    }
    timelapshift = (GameSetup_gData.carInfo[i].HudTime == 0) * 0x10;
    if (GameSetup_gData.carInfo[i].HudLapnum == 0) {
      timelapshift = timelapshift + 0x10;
    }
    Hud_BuildSprite(gSprt1,0x68,g1Player->x,(g1Player->y + splitY) - timelapshift,0xbebe,0);
    currentSpriteColor = 0x808080;
    Hud_BuildSprite2(gSprt1 + 1,0x80,g1Player[1].x,g1Player[1].y + splitY);
    j = 0x81;
    if (i != 0) {
      j = 0x83;
    }
    Hud_BuildSprite2(gSprt1 + 2,j,0,0);
    *(int *)&gSprt1[2].w = 0x1c001c;
    w1 = HudPmx_gShapes[0x6b].width;
    w2 = 0x46;
    if (Hud_BeTheCop != 0) {
      w2 = 0x2e;
    }
    x = g1Player[2].x;
    y = g1Player[2].y + splitY;
    Hud_BuildSprite2(gSprt1 + 4,0x69,x,y);
    x = x + w1;
    Hud_BuildG4(HudG4,1,x,y,w2,10,0,0x707070,0,0x707070);
    x = x + w2;
    Hud_BuildSprite2(gSprt1 + 5,0x7d,x,y);
    Hud_BuildF4(HudF4,1,x,y + 7,7,3,0x707070);
    w1 = HudPmx_gShapes[0x6b].width;
    x = g1Player[3].x;
    timelapshift = (GameSetup_gData.carInfo[i].HudTime == 0) * 0x10;
    y = (g1Player[3].y + splitY) - timelapshift;
    Hud_BuildSprite2(gSprt1 + 6,0x6b,x,y);
    x = x + w1;
    Hud_BuildG4(HudG4 + 1,1,x,y,0x1d,10,0,0x707070,0,0x707070);
    x = x + 0x1d;
    Hud_BuildF4(HudF4 + 1,1,x,y + 7,7,3,0x707070);
    Hud_BuildSprite2(gSprt1 + 7,0x7d,x,y);
    w1 = HudPmx_gShapes[0x6b].width;
    x = g1Player[4].x;
    y = g1Player[4].y + splitY;
    Hud_BuildSprite2(gSprt1 + 8,0x69,x,y);
    x = x + w1;
    Hud_BuildG4(HudG4 + 3,1,x,y,0x3c,10,0,0x707070,0,0x707070);
    x = x + 0x3c;
    Hud_BuildF4(HudF4 + 2,1,x,y + 7,7,3,0x707070);
    Hud_BuildSprite2(gSprt1 + 9,0x7d,x,y);
    w1 = HudPmx_gShapes[0x76].width;
    w2 = 0x26;
    if (Hud_BeTheCop == 0) {
      w2 = 0x32;
      if (GameSetup_gData.checkpointHUD[i] == 0) {
        w2 = 0x3d;
      }
    }
    if (Hud_BeTheCop != 0) {
      x = g1Player[2].x + 0xe;
    }
    else {
      x = g1Player[5].x;
    }
    if (Hud_BeTheCop != 0) {
      y = g1Player[2].y + (splitY + 0xe);
    }
    else {
      y = g1Player[5].y + splitY;
    }
    Hud_BuildSprite2(gSprt1 + 10,0x76,x,y);
    x = x + w1;
    Hud_BuildG4(HudG4 + 2,1,x,y,w2,10,0,0x707070,0,0x707070);
    x = x + w2;
    Hud_BuildF4(HudF4 + 3,1,x,y + 7,7,3,0x707070);
    Hud_BuildSprite(gSprt1 + 0xb,0x7d,x,y,0x808080,0);
    currentSpriteColor = textcolour;
    Hud_BuildTimeSprites(gSprt1 + 0xc,"00M00S00",g1Player[2].x + g1Player[6].x,
               g1Player[2].y + splitY + g1Player[6].y);
    Hud_BuildTimeSprites(gSprt1 + 0x14,"0/0",g1Player[3].x + g1Player[7].x,
               (g1Player[3].y + g1Player[7].y + splitY) - timelapshift);
    currentSpriteColor = 0xa0a0a0;
    Hud_BuildTimeSprites(gSprt1 + 0x17,"0M00S00",g1Player[4].x + g1Player[8].x,
               g1Player[4].y + g1Player[8].y + splitY + 1);
    if (Hud_BeTheCop != 0) {
      x = g1Player[2].x + 0x10;
    }
    else {
      x = g1Player[5].x + g1Player[9].x;
    }
    if (Hud_BeTheCop != 0) {
      y = g1Player[2].y + (splitY + 0xc);
    }
    else {
      y = g1Player[5].y + splitY + 1;
    }
    spriteReplay = gSprt1 + 0x1e;
    Hud_BuildTimeSprites(spriteReplay,
               (GameSetup_gData.checkpointHUD[i] == 0) ? "0M00S00" : "0.000",
               x + HudPmx_gShapes[0x76].width,y);
    HudSplitTimeDiff1[i] = spriteReplay[1].y0 - spriteReplay[0].y0;
    currentSpriteColor = textcolour;
    HudSplitTimeDiff2[i] = spriteReplay[4].y0 - spriteReplay[0].y0;
    w1 = HudPmx_gShapes[0x2c].width;
    w2 = HudPmx_gShapes[0x47].width;
    x = g1Player[0xe].x + g1Player[10].x;
    y = g1Player[0xe].y + HudMapOffsetY + g1Player[10].y + splitY;
    if ((i == 0) && (DashHUD_gInfo.splitscreen != 0)) {
      y = y + -2;
    }
    j = 0;
    Hud_BuildSprite(gSprt1 + 0x28,0x3e,g1Player[0xe].x + 0x13,y + -1,0x808080,0);
    Hud_BuildSprite2(gSprt1 + 0x25,0x2c,x,y);
    x = x + w1;
    Hud_BuildSprite2(gSprt1 + 0x26,0x47,x,y);
    Hud_BuildSprite2(gSprt1 + 0x27,0x36,x + w2,y);
    currentSpriteColor = 0x808080;
    x = g1Player[1].x + g1Player[0xb].x;
    y = g1Player[1].y + g1Player[0xb].y + splitY;
    Hud_BuildSprite2(gSprt1 + 0x31,0x1a,x + -1,y);
    Hud_BuildSprite2(gSprt1 + 0x32,0x1b,x + -2,y + -1);
    do {
      Hud_BuildSprite2(gSprt1 + 0x29 + j,j + 0x1c,x + 2,y + 6);
      j = j + 1;
    } while (j < 8);
    Hud_InitMapFrame(i,0);
    i = i + 1;
  }
  gSprt1 = gSprite0;
  j = 0;
  currentSpriteColor = 0x808080;
  currentSpriteTransparent = 1;
  baseX = g1Player[0xd].x;
  baseY = g1Player[0xd].y;
  Hud_BuildSprite2(gSprt1 + 0x37,0x6f,baseX,baseY);
  Hud_BuildSprite2(gSprt1 + 0x33,0x6c,baseX + 0x12,baseY);
  Hud_BuildSprite2(gSprt1 + 0x34,0x6e,baseX + 0x25,baseY);
  Hud_BuildSprite2(gSprt1 + 0x35,0x3f,baseX + 0x3a,baseY);
  Hud_BuildSprite2(gSprt1 + 0x38,0x72,baseX + 0x4a,baseY);
  Hud_BuildSprite2(gSprt1 + 0x36,0,baseX + 0x6d,baseY + -7);
  Hud_BuildSprite2(gSprt1 + 0x39,3,0,baseY + 4);
  currentSpriteTransparent = 0;
  Hud_InitCdPlayer();
  Hud_Reset();
  BTC_BonusTime = 0;
  BTC_Countdown = 0;
  FinalBTC_Countdown = 0;
  BTC_UserHasControl = 0;
  HudBustedOverlay = 0;
  do {
    PerpOverlayOn[j] = 0;
    PerpOverlayMessage[j] = 0;
    j = j + 1;
  } while (j < 2);
  Hud_kTurnSongOffNext = 0;
  return;
}

/* ---- Hud_InitTables__Fv  [HUD.CPP:1227-1228] SLD-VERIFIED ---- */
void Hud_InitTables(void)

{
  tSmallCoordXY (*patVar1) [19];
  
  patVar1 = Hud_gElementPositions;
  if (1 < GameSetup_gData.numPlayerRaceCars) {
    patVar1 = Hud_gElementPositions + 1;
  }
  g1Player = *patVar1;
  return;
}

/* ---- Hud_BuildETimeString__FP4SPRTi  [HUD.CPP:1232-1248] SLD-VERIFIED ---- */
void Hud_BuildETimeString(SPRT *sprt,int time)

{
  int min;
  int sec;
  int hun;
  int temp1;
  int temp2;

  if (time < 0) {
    time = 0;
  }
  temp2 = time;
  if (time < 0) {
    temp2 = -time;
  }
  temp1 = temp2 / 0x40;
  hun = (temp2 - temp1 * 0x40) * 100 / 0x40;
  min = (temp1 / 0x3c) % 0x3c;
  sec = temp1 % 0x3c;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun % 10];
  return;
}

/* ---- Hud_BuildDistanceString__FP4SPRTi  [HUD.CPP:1253-1269] SLD-VERIFIED ---- */
void * Hud_BuildDistanceString(SPRT *sprt,int player)

{
  int slices;
  int dist;

  dist = (Cars_gHumanRaceCarList[player]->stats).checkpointUpdate * 6;
  slices = __builtin_abs(dist);
  if (GameSetup_gData.checkpointHUD[player] == 2) {
    slices = (slices * 1000) / 0x647;
  }
  if (9999 < slices) {
    return (void *)0x0;
  }
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[slices / 1000];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[(slices % 1000) / 100];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[(slices % 100) / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[slices % 10];
  return (void *)0x1;
}

/* ---- Hud_BuildTimeString__FP4SPRTi  [HUD.CPP:1273-1288] SLD-VERIFIED ---- */
void Hud_BuildTimeString(SPRT *sprt,int time)

{
  int min;
  int sec;
  int hun;
  int temp1;
  int temp2;

  time = __builtin_abs(time);
  temp1 = time / 0x40;
  temp2 = time - temp1 * 0x40;
  min = temp1 / 0x3c;
  sec = temp1 % 0x3c;
  hun = temp2 * 100 / 0x40;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[min % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[sec % 10];
  sprt = sprt + 2;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun / 10];
  sprt = sprt + 1;
  *(int *)&sprt->u0 = *(int *)&HudPmx_gHudNumberUV[hun % 10];
  return;
}

/* ---- Hud_BuildTach__Fi  [HUD.CPP:1376-1442] SLD-VERIFIED ---- */
void Hud_BuildTach(int player)

{
  u_long clut;
  u_char *prim;
  short ts3;
  short ts4;
  short ts1;
  int rpm;
  int tachNeedle_p;
  int needle_y;
  int needle_x;
  int lookupResult;
  int fangle_norm;
  int rpm_norm;
  int tachShape_p;
  int color_pack;
  int needle_idx2;
  int carType;
  void *tp9;
  int needle_idx;
  u_int uVar1;
  u_long y;
  int sin1;
  int ti2;
  u_long x;
  int fangle;
  int arg1_00;
  int loc_48;
  int sin;
  int cos;
  SPRT *gSprt1;
  int cos1;
  u_long color;
  int loc_28;
  int loc_24;
  int loc_20;
  int loc_1c;
  int loc_18;
  int loc_14;
  int loc_10;
  int loc_c;
  int loc_8;
  int loc_4;
  u_char *prim2;
  u_char *tp2;
  u_char *tp3;
  u_char *tp1;
  
  if (player != 0) {
    gSprt1 = gSprite1;
  }
  else {
    gSprt1 = gSprite0;
  }
  rpm_norm = GameSetup_gData.carInfo[player].carType;
  carType = 0x1d;
  if (rpm_norm < 0x1e) {
    carType = rpm_norm;
  }
  if (GameSetup_gData.Time != 0) {
    tachShape_p = (int)night_needle;
  }
  else {
    tachShape_p = (int)day_needle;
  }
  color = *(u_long *)(tachShape_p + carType * 4);
  arg1_00 = (DashHUD_gInfo.rpm * 0x10000) / 0x2a30 + 0x5999;
  if (arg1_00 < 0x5999) {
    arg1_00 = 0x5999;
  }
  if (0x13334 < arg1_00) {
    arg1_00 = 0x13334;
  }
  fixedsincos(arg1_00,&sin,&cos);
  /* needle glyph shapes: player0 = &HudPmx_gShapes[0x81] (0x801116AC), player1 =
   * &HudPmx_gShapes[0x83] (0x801116D4) -- were disguised bare VAs -0x7feee954/-0x7feee92c */
  if (player != 0) {
    tachNeedle_p = (int)&HudPmx_gShapes[0x83];
  }
  else {
    tachNeedle_p = (int)&HudPmx_gShapes[0x81];
  }
  clut = *(u_long *)tachNeedle_p;
  clut = clut & 0xffff0000;   /* in-place mutate: load lands in clut's reg directly */
  needle_y = fixedmult(cos,0x1d);
  needle_x = fixedmult(sin,0x1d);
  if (player != 0) {
    uVar1 = (clut | (needle_x + 0x9d) << 8) | (needle_y + 0x75);
  }
  else {
    uVar1 = (clut | (needle_x + 0x9d) << 8) | (needle_y + 0x1d);
  }
  *(u_int *)&gSprt1[2].u0 = uVar1;   /* word-fused u0/v0/clut store */
  cos1 = fixedmult(cos,10) + 0xe;
  ti2 = fixedmult(sin,10) + 0xe;   /* sin1 (SYM: $s6) */
  {
    u_char *pal;

    prim = Render_gPacketPtr;
    pal = Render_gPalettePtr;
    tp9 = (void *)(prim + 0x14);
    *(u_int *)prim = *(u_int *)prim & 0xff000000 | *(u_int *)pal & 0xffffff;
    Render_gPacketPtr = prim + 0x14;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)prim & 0xffffff;
    *(u_int *)tp9 = *(u_int *)tp9 & 0xff000000 | *(u_int *)pal & 0xffffff;
    Render_gPacketPtr = prim + 0x24;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tp9 & 0xffffff;
    ((u_char *)tp9)[3] = 3;
    *(short *)((u_char *)tp9 + 8) = 0xe - (short)needle_y;
    *(u_long *)((u_char *)tp9 + 4) = color + 0x484848 | 0x42000000;
    *(short *)((u_char *)tp9 + 10) = 0xe - (short)needle_x;
    *(short *)((u_char *)tp9 + 0xe) = (short)ti2;
    *(u_short *)((u_char *)tp9 + 0xc) = (u_short)cos1;
    prim2 = Render_gPacketPtr;
    pal = Render_gPalettePtr;
    *(u_int *)prim2 = *(u_int *)prim2 & 0xff000000 | *(u_int *)pal & 0xffffff;
    Render_gPacketPtr = prim2 + 0x14;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)prim2 & 0xffffff;
  }
  Hud_BuildF3((POLY_F3 *)prim,HudPmx_gShapes + 0x82,cos1,ti2,color);
  Hud_BuildF3((POLY_F3 *)prim2,HudPmx_gShapes + 0x82,cos1,ti2,0);
  prim[7] = prim[7] & 0xfd;
  fixedsincos(arg1_00 + -0x200,&sin,&cos);
  ts3 = 0xe - (short)fixedmult(cos,0x20);
  *(short *)(prim + 0xc) = ts3;
  *(short *)(prim2 + 0xc) = ts3;
  ts4 = 0xe - (short)fixedmult(sin,0x20);
  *(short *)(prim + 0xe) = ts4;
  *(short *)(prim2 + 0xe) = ts4;
  fixedsincos(arg1_00 + 0x200,&sin,&cos);
  ts1 = 0xe - (short)fixedmult(cos,0x20);
  *(short *)(prim + 0x10) = ts1;
  *(short *)(prim2 + 0x10) = ts1;
  ts1 = 0xe - (short)fixedmult(sin,0x20);
  *(short *)(prim + 0x12) = ts1;
  *(short *)(prim2 + 0x12) = ts1;
  tp3 = Render_gPalettePtr;
  *(short *)(prim2 + 10) = *(short *)(prim2 + 10) + 2;
  *(short *)(prim2 + 0x12) = ts1 + 2;
  *(short *)(prim2 + 0xe) = *(short *)(prim2 + 0xe) + 2;
  gSprt1[2].tag = (u_long *)((u_int)gSprt1[2].tag & 0xff000000 | *(u_int *)tp3 & 0xffffff);
  *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | (u_int)(gSprt1 + 2) & 0xffffff;
  return;
}

/* ---- Hud_BuildString__FPciiiib  [HUD.CPP:1450-1544] SLD-VERIFIED ---- */
int Hud_BuildString(char *str,int x,int y,int color,int player,bool justwidth)

{
  char cVar1;
  short sVar2;
  int offy;
  char alphShape;
  int ix;
  int i;
  int ox;
  int numch;

  Hud_GoTpage(1);
  ox = x;
  numch = strlen(str);
  i = 0;
  ix = x;
  do {
    if (numch <= i) {
      Hud_GoTpage(0);
      return ix - ox;
    }
    cVar1 = *str;
    if (cVar1 == ' ') {
      ix = ix + 3;
    }
    else if (cVar1 == '*') {
      if (gPadinfo.buf[0].ID == '#') {
        sVar2 = HudPmx_gShapes[0xad].width;
        if (justwidth == 0) {
          Hud_FBuildSprite(0xad,ix + 2,y,color,0);
          sVar2 = HudPmx_gShapes[0xad].width;
        }
      }
      else {
        sVar2 = HudPmx_gShapes[0xaa].width;
        if (justwidth == 0) {
          Hud_FBuildSprite(0xaa,ix + 2,y,color,0);
          sVar2 = HudPmx_gShapes[0xaa].width;
        }
      }
      ix = ix + 5 + (int)sVar2;
      if (GameSetup_gData.commMode == 1) {
        if (gPadinfo.buf[4].ID == '#') {
          if (gPadinfo.buf[0].ID != '#') {
HudBuildStr_hashMarker:
            if (gPadinfo.buf[4].ID == '#') {
              if (justwidth == 0) {
                Hud_FBuildSprite(0xad,ix,y,color,0);
              }
              offy = (int)HudPmx_gShapes[0xad].width;
              ix = ix + 3;
            }
            else {
              if (justwidth == 0) {
                Hud_FBuildSprite(0xaa,ix,y,color,0);
              }
              offy = (int)HudPmx_gShapes[0xaa].width;
              ix = ix + 3;
            }
            goto HudBuildStr_accumWidth;
          }
        }
        else if (gPadinfo.buf[0].ID == '#') goto HudBuildStr_hashMarker;
      }
    }
    else {
      offy = 0;
      if (cVar1 == '^') {
        alphShape = 0xaa;
        if (gPadinfo.buf[player * 4].ID == '#') {
          alphShape = 0xad;
        }
      }
      else if (cVar1 == '(') {
        alphShape = 0xa9;
        if (gPadinfo.buf[player * 4].ID == '#') {
          alphShape = 0xab;
        }
      }
      else if (cVar1 == ')') {
        alphShape = 0xa8;
        if (gPadinfo.buf[player * 4].ID == '#') {
          alphShape = 0xac;
        }
      }
      else if (cVar1 == '&') {
        alphShape = 0xae;
      }
      else {
        alphShape = cVar1 + 0x6e;
        if (9 < (u_char)(cVar1 - 0x30U)) {
          if (cVar1 == '-') {
            alphShape = 0x48;
          }
          else if (cVar1 == ':') {
            alphShape = 0x49;
          }
          else {
            alphShape = cVar1 + 0x8a;
            if ((u_char)(cVar1 + 0x40U) < 0x1d) {
              offy = -1;
            }
            else {
              alphShape = *str + 0x43;
              if (*str == -0x1b) {
                alphShape = 0x67;
                offy = -1;
              }
            }
          }
        }
      }
      if (justwidth == 0) {
        Hud_FBuildSprite((u_int)alphShape,ix,y + offy,color,0);
      }
      offy = (int)HudPmx_gShapes[alphShape].width;
      ix = ix + 1;
HudBuildStr_accumWidth:
      ix = ix + offy;
    }
    str = str + 1;
    i = i + 1;
  } while( true );
}

/* PsyQ libgpu P_TAG head-word shape (addr:24|len:8) -- the original tag-link code is the
 * SDK addPrim()/setaddr()/getaddr() macro family operating on this bitfield. */
typedef struct { unsigned addr:24; unsigned len:8; } Hud_PTag;

/* ---- Hud_BuildNumbers0__Fi  [HUD.CPP:1551-1712] SLD-VERIFIED ----
 * SYM-structured rewrite (rule 8): fn-scope locals = exactly the SYM set (i, pSprt, HudF4,
 * HudG4, splitY, y) + block-scoped {j,num}/{j} per loop region (SYM shows 4 nested-block `j`
 * redeclarations).  Key oracle-derived shapes: pSprt select = if/ELSE (one gp-rel load per
 * path); HudF4/HudG4 selects = in-place `+= 7`/`+= 4` (addiu s6,s6,0xA8 conditional add);
 * ETimeString arg = ternary (no unconditional laptime pre-load); tag-link walk loops cache
 * the palette ptr in a block-local `pal` (oracle hoists it), while the GoTpage digit loops
 * re-read Render_gPalettePtr per branch (calls clobber it -- no cache var there). */
void Hud_BuildNumbers0(int player)

{
  int i;
  SPRT *pSprt;
  POLY_F4 *HudF4;
  POLY_G4 *HudG4;
  int splitY;
  int y;
  int primAddr;

  if (player != 0) {
    pSprt = gSprite1;
  }
  else {
    pSprt = gSprite0;
  }
  HudF4 = gHudF4;
  if (player != 0) {
    HudF4 = HudF4 + 7;
  }
  HudG4 = gHudG4;
  if (player != 0) {
    HudG4 = HudG4 + 4;
  }
  y = 0;
  if (player != 0) {
    y = -0xf;
  }
  if (GameSetup_gData.carInfo[player].HudTime != 0) {
    if ((DashHUD_gInfo.flashtime == 0) || ((simGlobal.gameTicks & 0x10U) == 0)) {
      Hud_BuildETimeString(pSprt + 12,
                           Hud_BeTheCop != 0 ? BTC_Countdown : DashHUD_gInfo.laptime);
    }
    {
      u_int *pal;
      {
        int j;
        int num;

        num = 8;
        if (Hud_BeTheCop != 0) {
          num = 5;
        }
        j = 0xc;
        num = num + j;
        if (j < num) {
          pal = (u_int *)Render_gPalettePtr;
          do {
            pSprt[j].tag = pSprt[j].tag & 0xff000000 | *pal & 0xffffff;
            *pal = *pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
            j = j + 1;
          } while (j < num);
        }
      }
      {
        int j;

        j = 4;
        pal = (u_int *)Render_gPalettePtr;
        do {
          pSprt[j].tag = pSprt[j].tag & 0xff000000 | *pal & 0xffffff;
          *pal = *pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
          j = j + 1;
        } while (j < 6);
        pal = (u_int *)Render_gPalettePtr;
        HudG4->tag = HudG4->tag & 0xff000000 | *pal & 0xffffff;
        *pal = *pal & 0xff000000 | (u_int)HudG4 & 0xffffff;
        HudF4->tag = HudF4->tag & 0xff000000 | *pal & 0xffffff;
        *pal = *pal & 0xff000000 | (u_int)HudF4 & 0xffffff;
      }
    }
  }
  if (Hud_BeTheCop == 0) {
    i = g1Player[5].y;
    i = i + y;
    i = i + g1Player[9].y;
    pSprt[10].y0 = i;
    HudG4[2].y0 = i;
    HudG4[2].y1 = i;
    HudG4[2].y2 = i + 10;
    HudG4[2].y3 = i + 10;
    pSprt[11].y0 = i;
    HudF4[3].y0 = i + 7;
    HudF4[3].y1 = i + 7;
    HudF4[3].y2 = i + 10;
    HudF4[3].y3 = i + 10;
    i = i + 1;
    pSprt[30].y0 = i;
    pSprt[32].y0 = i;
    pSprt[33].y0 = i;
    pSprt[31].y0 = *(u_short *)&HudSplitTimeDiff1[player] + i;
    pSprt[35].y0 = i;
    pSprt[36].y0 = i;
    pSprt[34].y0 = *(u_short *)&HudSplitTimeDiff2[player] + i;
  }
  primAddr = BTC_BonusTime;
  if ((BTC_BonusTime != 0) && (Hud_BeTheCop != 0)) {
    if (GameSetup_gData.carInfo[player].HudTime == 0) {
      return;
    }
    {
      int j;
      u_char *pal;
      SPRT *p;

      p = pSprt + 30;
      *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x76].pixmap);
      if (primAddr < 0) {
        primAddr = 0;
      }
      Hud_BuildTimeString(p,primAddr);
      j = 0x1e;
      pal = Render_gPalettePtr;
      do {
        pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
        j = j + 1;
      } while (j < 0x22);
      j = 10;
      do {
        if (j == 10) {
          Hud_GoTpage(0);
          pSprt[10].tag =
               pSprt[10].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
          *(u_int *)Render_gPalettePtr =
               *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[10] & 0xffffff;
          Hud_GoTpage(1);
        }
        else {
          pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
          *(u_int *)Render_gPalettePtr =
               *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
        }
        j = j + 1;
      } while (j < 0xc);
    }
  }
  else {
    if (GameSetup_gData.checkpointType == 0) {
      return;
    }
    if (GameSetup_gData.checkpointHUD[player] == 0) {
      if ((Cars_gHumanRaceCarList[player]->stats).checkpointDisplay < 1) {
        return;
      }
      i = (Cars_gHumanRaceCarList[player]->stats).checkpointDifference;
      if (i < -0x95ff) {
        return;
      }
      if (0x95ff < i) {
        return;
      }
      if (Hud_BeTheCop != 0) {
        return;
      }
      if (DashHUD_gInfo.wrongway[player] != 0) {
        return;
      }
      if (i < 0) {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x77].pixmap);
      }
      else {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x76].pixmap);
      }
      {
        int j;
        u_char *pal;
        SPRT *p;

        Hud_BuildTimeString(pSprt + 30,(Cars_gHumanRaceCarList[player]->stats).checkpointDifference);
        j = 0x1e;
        pal = Render_gPalettePtr;
        do {
          pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
          j = j + 1;
        } while (j < 0x25);
        j = 10;
        do {
          if (j == 10) {
            Hud_GoTpage(0);
            pSprt[10].tag =
                 pSprt[10].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
            *(u_int *)Render_gPalettePtr =
                 *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[10] & 0xffffff;
            Hud_GoTpage(1);
          }
          else {
            pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
            *(u_int *)Render_gPalettePtr =
                 *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
          }
          j = j + 1;
        } while (j < 0xc);
      }
    }
    else {
      i = (int)Hud_BuildDistanceString(pSprt + 30,player);
      if (i == 0) {
        return;
      }
      if ((Cars_gHumanRaceCarList[player]->stats).checkpointUpdate < 0) {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x77].pixmap);
      }
      else {
        *(u_int *)&pSprt[10].u0 = *(int *)&(HudPmx_gShapes[0x76].pixmap);
      }
      {
        int j;
        u_char *pal;
        SPRT *p;

        j = 0x1e;
        pal = Render_gPalettePtr;
        do {
          pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
          j = j + 1;
        } while (j < 0x23);
        j = 10;
        do {
          if (j == 10) {
            Hud_GoTpage(0);
            pSprt[10].tag =
                 pSprt[10].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
            *(u_int *)Render_gPalettePtr =
                 *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[10] & 0xffffff;
            Hud_GoTpage(1);
          }
          else {
            pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
            *(u_int *)Render_gPalettePtr =
                 *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
          }
          j = j + 1;
        } while (j < 0xc);
      }
    }
  }
  {
    u_char *pal;

    pal = Render_gPalettePtr;
    HudG4[2].tag = HudG4[2].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&HudG4[2] & 0xffffff;
    HudF4[3].tag = HudF4[3].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&HudF4[3] & 0xffffff;
  }
  return;
}

/* ---- Hud_BuildNumbers__Fi  [HUD.CPP:1721-1897] SLD-VERIFIED ----
 * SYM-structured rewrite (rule 8), twin of Hud_BuildNumbers0: fn-scope locals per SYM
 * (i/pSprt/HudF4/HudG4/splitY + speed/hun/ten/x/y/w1/w2/w3/w7/color2/prim/SpeedColor, AUTO ones
 * spill), block-scoped j per merge region.  Oracle-derived shapes: pSprt select = if/ELSE, +=
 * selects testing the `i = player` copy (i lives to the 2nd HudTach test -> callee $s2 like the
 * oracle); tag-links = pSprt[j] index loops with a per-region pal cache; GoTpage merges =
 * direct Render_gPalettePtr macro (call-clobber forces the reload); carInfo[j].HudMap after the
 * position loop is the RETAIL code's own out-of-range index (j==0x28) -- kept faithfully. */
void Hud_BuildNumbers(int player)

{
  int i;
  SPRT *pSprt;
  POLY_F4 *HudF4;
  POLY_G4 *HudG4;
  int splitY;
  int speed;
  int hun;
  int ten;
  int x;
  int y;
  int w1;
  int w2;
  int w3;
  int w7;
  int color2;
  POLY_GT4 *prim;
  u_long SpeedColor;

  i = player;
  if (player != 0) {
    pSprt = gSprite1;
  }
  else {
    pSprt = gSprite0;
  }
  HudF4 = gHudF4;
  if (i != 0) {
    HudF4 = HudF4 + 7;
  }
  HudG4 = gHudG4;
  if (i != 0) {
    HudG4 = HudG4 + 4;
  }
  splitY = 0;
  if (i != 0) {
    splitY = -0xf;
  }
  if (((GameSetup_gData.carInfo[player].HudLapnum != 0) && (Hud_BeTheCop == 0)) &&
     (DashHUD_gInfo.maxlaps != 1)) {
    int j;
    u_char *pal;

    *(int *)&pSprt[20].u0 = *(int *)&HudPmx_gHudNumberUV[DashHUD_gInfo.lap];
    *(int *)&pSprt[22].u0 = *(int *)&HudPmx_gHudNumberUV[DashHUD_gInfo.maxlaps];
    j = 0x14;
    pal = Render_gPalettePtr;
    do {
      pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
      j = j + 1;
    } while (j < 0x17);
    j = 6;
    pal = Render_gPalettePtr;
    do {
      pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
      j = j + 1;
    } while (j < 8);
    pal = Render_gPalettePtr;
    HudG4[1].tag = HudG4[1].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&HudG4[1] & 0xffffff;
    HudF4[1].tag = HudF4[1].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&HudF4[1] & 0xffffff;
  }
  if ((((GameSetup_gData.carInfo[player].HudTime != 0) && (DashHUD_gInfo.record != 0)) &&
      ((DashHUD_gInfo.record < 0x9600 && ((Hud_BeTheCop == 0 && (Hud_gShowedCDPlayer == 0)))))) &&
     (DashHUD_gInfo.maxlaps != 1)) {
    int j;
    u_char *pal;

    if ((DashHUD_gInfo.flashtime == 0) || ((simGlobal.gameTicks & 0x10U) == 0)) {
      Hud_BuildTimeString(pSprt + 23,DashHUD_gInfo.record);
    }
    j = 0x17;
    pal = Render_gPalettePtr;
    do {
      pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
      j = j + 1;
    } while (j < 0x1e);
    j = 8;
    pal = Render_gPalettePtr;
    do {
      pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
      j = j + 1;
    } while (j < 10);
    pal = Render_gPalettePtr;
    HudG4[3].tag = HudG4[3].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&HudG4[3] & 0xffffff;
    HudF4[2].tag = HudF4[2].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&HudF4[2] & 0xffffff;
  }
  if (((GameSetup_gData.carInfo[player].HudPosition != 0) && (Hud_BeTheCop == 0)) &&
     (1 < DashHUD_gInfo.opponents)) {
    int j;
    u_char *pal;

    pSprt[37].x0 = (g1Player[0xe].x + g1Player[10].x + HudPmx_gShapes[0x2c].width + -2) -
                   HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;
    *(int *)&pSprt[37].u0 = *(int *)&HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].pixmap;
    pSprt[37].w = HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;
    *(u_int *)&pSprt[39].u0 = *(u_int *)&HudPmx_gShapes[DashHUD_gInfo.opponents + 0x35].pixmap;
    pSprt[39].w = HudPmx_gShapes[DashHUD_gInfo.opponents + 0x35].width;
    j = 0x25;
    pal = Render_gPalettePtr;
    do {
      pSprt[j].tag = pSprt[j].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[j] & 0xffffff;
      j = j + 1;
    } while (j < 0x28);
    if (GameSetup_gData.carInfo[j].HudMap != 0) {  /* retail bug: j==0x28, not player */
      Hud_GoTpage(0);
      pSprt[40].tag = pSprt[40].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[40] & 0xffffff;
      Hud_GoTpage(1);
    }
  }
  Hud_GoTpage(0);
  if (GameSetup_gData.carInfo[player].HudTach != 0) {
    switch (DashHUD_gInfo.gear) {
    case 0:
      pSprt[48].tag = pSprt[48].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[48] & 0xffffff;
      break;
    case 1:
      pSprt[47].tag = pSprt[47].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[47] & 0xffffff;
      break;
    default:
      pSprt[DashHUD_gInfo.gear + 39].tag =
           pSprt[DashHUD_gInfo.gear + 39].tag & 0xff000000 |
           *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 |
           (u_int)&pSprt[DashHUD_gInfo.gear + 39] & 0xffffff;
      break;
    }
    if (GameSetup_gData.carInfo[player].HudSpeed == 0) {
      pSprt[50].tag = pSprt[50].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[50] & 0xffffff;
    }
    else {
      pSprt[49].tag = pSprt[49].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)&pSprt[49] & 0xffffff;
    }
  }
  Hud_GoTpage(1);
  if (GameSetup_gData.carInfo[i].HudTach != 0) {
    speed = fixedmult(GameSetup_gData.carInfo[player].HudSpeedMult,DashHUD_gInfo.speed);
    if (speed < 0) {
      speed = speed + 0xffff;
    }
    SpeedColor = 0xc8c8c8;
    color2 = 0x505050;
    speed = speed >> 0x10;
    w1 = HudPmx_gShapes[0x2c].width + 1;
    w2 = w1 + HudPmx_gShapes[0x2d].width >> 1;
    w7 = w1 + HudPmx_gShapes[0x33].width >> 1;
    w3 = w1 - w2;
    x = w1 * 2 + ((int)g1Player[1].x + (int)g1Player[0xc].x + 4);
    y = (int)g1Player[1].y + (int)g1Player[0xc].y + splitY;
    prim = (POLY_GT4 *)Render_gPacketPtr;
    Render_gPacketPtr = Render_gPacketPtr + 0x34;
    prim->tag = prim->tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    *(u_int *)Render_gPalettePtr =
         *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
    hun = speed / 100;
    ten = speed / 10 + hun * -10;
    Hud_BuildGT4(prim,HudPmx_gShapes + speed % 10 + 0x2c,x,y,SpeedColor);
    *(u_int *)&prim->r3 = color2;
    *(u_int *)&prim->r2 = color2;
    if (ten == 1) {
      x = x - w2;
    }
    else if (ten == 7) {
      x = x - w7;
    }
    else {
      x = x - w1;
    }
    if ((hun != 0) || (ten != 0)) {
      prim = (POLY_GT4 *)Render_gPacketPtr;
      Render_gPacketPtr = Render_gPacketPtr + 0x34;
      prim->tag = prim->tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
      Hud_BuildGT4(prim,HudPmx_gShapes + ten + 0x2c,x,y,SpeedColor);
      *(u_int *)&prim->r3 = color2;
      *(u_int *)&prim->r2 = color2;
    }
    if (ten == 1) {
      x = x - w3;
    }
    if (hun != 0) {
      prim = (POLY_GT4 *)Render_gPacketPtr;
      Render_gPacketPtr = Render_gPacketPtr + 0x34;
      prim->tag = prim->tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)prim & 0xffffff;
      Hud_BuildGT4(prim,HudPmx_gShapes + hun + 0x2c,
                   (x + -1) - (int)HudPmx_gShapes[hun + 0x2c].width,y,SpeedColor);
      *(u_int *)&prim->r3 = color2;
      *(u_int *)&prim->r2 = color2;
    }
  }
  if ((DashHUD_gInfo.wrongway[player] != 0) && ((simGlobal.gameTicks >> 5 & 1U) != 0)) {
    u_char *pal;

    pal = Render_gPalettePtr;
    pSprt[0].tag = pSprt[0].tag & 0xff000000 | *(u_int *)pal & 0xffffff;
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&pSprt[0] & 0xffffff;
  }
  return;
}

/* ---- Hud_InitMap__Fv  [HUD.CPP:1917-1926] SLD-VERIFIED ----
 * PASS (40/40). SYM shows ONE local (`i`): the walk pointers were compiler givs, not source
 * vars -- the index form `Hud_gMarkerColor[i] = Cars_gRaceCarList[i]->carInfo->HudColour` with
 * the Ghidra guard shape (cached count + do-while) strength-reduces to the oracle's exact
 * dual-giv loops and colors all three temps correctly. */
void Hud_InitMap(void)

{
  int iVar4;
  int i;

  iVar4 = Cars_gNumRaceCars;
  i = 0;
  if (0 < Cars_gNumRaceCars) {
    do {
      *(int *)&Hud_gMarkerColor[i] = Cars_gRaceCarList[i]->carInfo->HudColour;
      i = i + 1;
    } while (i < iVar4);
  }
  iVar4 = Cars_gNumCopCars;
  i = 0;
  if (0 < Cars_gNumCopCars) {
    do {
      *(int *)&Hud_gCopMarkerColor[i] = Cars_gCopCarList[i]->carInfo->HudColour;
      i = i + 1;
    } while (i < iVar4);
  }
  return;
}

/* ---- Hud_BuildMapMarkers__Fi  [HUD.CPP:2019-2133] SLD-VERIFIED ---- */
void Hud_BuildMapMarkers(int player)

{
  /* SYM-exact locals: i=$s5, rx=$s2, rz=$s1, x=$s3, z=$s0, cenX/cenZ AUTO (stack),
   * mapy=$fp; per-loop blocks: sprt(=$a2/$a3) + slice(=$v1). mapx (0x16) is fully
   * const-propagated (li t0,0x16 rematerialized at each call site) so it has no SYM
   * record; player is unused (REGPARM stays in $a0). Slice stride = 0x20 bytes. */
  int i;
  int rx;
  int rz;
  int x;
  int z;
  int cenX;
  int cenZ;
  int mapy;
  int mapx;

  cenX = gMapOffX;
  cenZ = gMapOffY + 2;
  mapx = 0x16;
  mapy = 0x18;
  i = 0;
  while (true) {
    if (Cars_gNumCopCars <= i) break;
    if (Cars_gCopCarList[i]->N.active != '\0') {
      SPRT *sprt;
      int slice;
      u_char *pal;
      u_char **pktcell;

      slice = Cars_gCopCarList[i]->N.simRoadInfo.slice;
      rx = BWorldSm_slices[slice].center[0] / gMapScaleX;
      rz = BWorldSm_slices[slice].center[2] / gMapScaleY;
      x = (cenX + fixedmult(mapMarkerMCos,rx)) - fixedmult(mapMarkerMSin,rz);
      z = cenZ + fixedmult(mapMarkerMSin,rx) + fixedmult(mapMarkerMCos,rz);
      if (GameSetup_gData.mirrorTrack != 0) {
        x = -x;
      }
      pktcell = (u_char **)0x1F800004;   /* one addr materialization per iter (shared by read+bump) -- keeps the 0x1F800004 constant un-hoisted like retail */
      sprt = (SPRT *)*pktcell;
      pal = Render_gPalettePtr;
      *(u_int *)sprt = *(u_int *)sprt & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)sprt & 0xffffff;
      *pktcell = (u_char *)sprt + 0x14;
      if ((*(u_int *)((char *)Cars_gCopCarList[i] + 0x570) & 2) != 0) {
        currentSpriteColor = ((gFlip == 0) && (simVar.quickPauseSim == 0)) ? 0xff0000 : 0xff;
      }
      else {
        currentSpriteColor = *(u_long *)&Hud_gCopMarkerColor[i];
      }
      Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);
    }
    i = i + 1;
  }
  i = 0;
  while (true) {
    if (Cars_gNumRaceCars <= i) break;
    if (Cars_gRaceCarList[i]->N.active != '\0') {
      SPRT *sprt;
      int slice;
      u_char *pal;
      u_char **pktcell;

      slice = Cars_gRaceCarList[i]->N.simRoadInfo.slice;
      rx = BWorldSm_slices[slice].center[0] / gMapScaleX;
      rz = BWorldSm_slices[slice].center[2] / gMapScaleY;
      x = (cenX + fixedmult(mapMarkerMCos,rx)) - fixedmult(mapMarkerMSin,rz);
      z = cenZ + fixedmult(mapMarkerMSin,rx) + fixedmult(mapMarkerMCos,rz);
      if (GameSetup_gData.mirrorTrack != 0) {
        x = -x;
      }
      pktcell = (u_char **)0x1F800004;   /* see cop loop */
      sprt = (SPRT *)*pktcell;
      pal = Render_gPalettePtr;
      *(u_int *)sprt = *(u_int *)sprt & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)sprt & 0xffffff;
      *pktcell = (u_char *)sprt + 0x14;
      if ((Cars_gRaceCarList[i]->carFlags & 0x200U) != 0) {
        if ((*(u_int *)((char *)Cars_gRaceCarList[i] + 0x570) & 2) != 0) {
          currentSpriteColor = ((gFlip == 0) && (simVar.quickPauseSim == 0)) ? 0xff0000 : 0xff;
        }
        else {
          currentSpriteColor = *(u_long *)&Hud_gMarkerColor[i];
        }
        Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,currentSpriteColor,0);
      }
      else if ((Cars_gRaceCarList[i]->carFlags & 4U) != 0) {
        Hud_BuildSprite(sprt,0x79,mapx + x + -3 & 0xffff,mapy - z & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
      else {
        Hud_BuildSprite(sprt,0x7a,mapx + x + -2 & 0xffff,mapy - z & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
    }
    i = i + 1;
  }
}

/* ---- Hud_WingmanFlash__Fii  [HUD.CPP:2148-2157] SLD-VERIFIED ----
 * NEAR-MISS FLOOR (10 diffs, 45/45 insn count exact): the final `Hud_gWingmanFlashTicks[player] =
 * ticks + 100;` store's index (`sll _,player,2`) vs base-address (`lui/addiu Hud_gWingmanFlashTicks`)
 * sub-expressions land in swapped registers (ours: base->v1 first then index->a0; oracle:
 * index->v1 first then base->a0) with the final sum/store register swapped to match (a0 vs v1).
 * Tried: swap statement order vs Hud_gWingmanFlashIcon store (regressed 10->36, reverted), operand
 * order `100+ticks` (no change), explicit pointer form `*(Hud_gWingmanFlashTicks+player)=` (no
 * change) -- all reverted. This is the catalog's documented "sll-index vs base SCHEDULING" floor
 * (methodology §3.12 tail, same family as Hud_Perp_OverlayOff/On): a pre-register-allocation gcc
 * instruction-scheduling pick between two equivalent temp regs, not reachable from source. Accept. */
void Hud_WingmanFlash(int player,int index)

{

  if ((Replay_ReplayMode < 2) && (HudBustedOverlay == 0)) {
    if (Hud_gWingmanInterface[player] != '\x01') {
      Hud_InitMapFrame(player,1);
      Hud_gWingmanInterface[player] = '\x01';
    }
    Hud_gWingmanFlashIcon[player] = (char)index;
    Hud_gWingmanFlashTicks[player] = ticks + 100;
  }
  return;
}

/* ---- Hud_BuildWingmanInterface__Fi  [HUD.CPP:2162-2196] SLD-VERIFIED ---- */
void Hud_BuildWingmanInterface(int player)

{
  /* SYM locals: splitY=$t0, flashTicks=$s3, poly=$a0 (POLY_F4*), x=$s7, y=$s4; block i=$s2.
   * g1Player[0xe].x read once (s1), the -0x1b string-x CSEs into s0. */
  int splitY;
  int flashTicks;
  POLY_F4 *poly;
  int x;
  int y;

  splitY = 0;
  if (player != 0) {
    splitY = -0xf;
  }
  flashTicks = Hud_gWingmanFlashTicks[player] - ticks;
  x = (int)g1Player[0xe].x;
  y = g1Player[0xe].y + HudMapOffsetY + splitY + 2;
  Hud_BuildString(TextSys_Word(0x29),x - 0x1b,y + 3,0x808080,0,false);
  Hud_BuildString(TextSys_Word(0x2a),x - 0x1b,y + 0xc,0x808080,player,false);
  Hud_BuildString(TextSys_Word(0x2b),x - 0x1b,y + 0x15,0x808080,player,false);
  Hud_BuildString(TextSys_Word(0x2c),x - 0x1b,y + 0x1e,0x808080,player,false);
  Hud_BuildString(TextSys_Word(0x2d),x - 0x1b,y + 0x27,0x808080,player,false);
  if (0 < flashTicks) {
    poly = (POLY_F4 *)Render_gPacketPtr;
    *(u_int *)poly = *(u_int *)poly & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    Render_gPacketPtr = (u_char *)poly + 0x18;
    *(u_int *)Render_gPalettePtr =
         *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)poly & 0xffffff;
    Hud_BuildF4(poly,0,x - 0x10,y + ((u_char)Hud_gWingmanFlashIcon[player] + 1) * 9 + 2,0x3f,8,
               (flashTicks % 0x14) * 10);
  }
  {
    int i;

    i = 0;
    do {
      poly = (POLY_F4 *)Render_gPacketPtr;
      *(u_int *)poly = *(u_int *)poly & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      Render_gPacketPtr = (u_char *)poly + 0x18;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)poly & 0xffffff;
      Hud_BuildF4(poly,0,x - 0x1c,y + i * 9 + 2,0x4b,7,0);
      i = i + 1;
    } while (i < 5);
  }
  poly = (POLY_F4 *)Render_gPacketPtr;
  *(u_int *)poly = *(u_int *)poly & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  Render_gPacketPtr = (u_char *)poly + 0x18;
  *(u_int *)Render_gPalettePtr =
       *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)poly & 0xffffff;
  Hud_BuildF4(poly,1,x - 0x1c,y,0x4b,0x30,0);
  return;
}

/* ---- Hud_InitCdPlayer__Fv  [HUD.CPP:2215-2219] SLD-VERIFIED ---- */
void Hud_InitCdPlayer(void)

{
  Hud_gCdLastTick = 0;
  Hud_gCdScrollTitle = 0;
  Hud_gCdActive = 0;
  Hud_ActivateCDPlayer = (u_int)(Replay_ReplayMode < 2);
  return;
}

/* ---- Hud_BuildCdPlayer__Fii  [HUD.CPP:2225-2487] SLD-VERIFIED ---- */
int Hud_BuildCdPlayer(int type,int arg1)

{
  bool bVar2;
  int sec;
  u_int uVar5;
  int w;
  u_char *p;
  int tx;
  char *s;
  int box_transp;
  int box_x;
  int box_y;
  int box_w;
  int box_h;
  char *artist;
  char *title;
  int index;
  int time;
  char strindex [4];
  char strscrolltitle [30];
  char strartist [30];
  char strtitle [30];
  char strtime [10];
  char strtest [2];
  static bool keepup;   /* SYM: fn-local STAT BOOL @0x8013D900 (was wrongly a file-scope int) */

  /* SYM-exact locals (8c block @0x800d63dc): x=$s7=g1Player[0xf].x+2, y=$fp=g1Player[0xf].y+2
   * (fused with the +2 directly -- SYM has NO separate raw-x local), index=$s4, time=$s5,
   * title=$s1, artist=$s0, dx=$s3, tx=$a1, w=$v1, min=$a2, sec=$v0, s=$a2 (scroll-copy cursor). */
  int x = g1Player[0xf].x + 2;
  int y = g1Player[0xf].y + 2;
  if (type == 0) {
    keepup = 1;
  }
  int dx = 0;
  strtest[1] = 0;
  AudioMus_tCurrentSong *currentSong = AudioMus_GetCurrentSong();
  if (currentSong == (AudioMus_tCurrentSong *)0x0) {
    return 0;
  }
  if (Hud_gCdActive == 0) {
    bVar2 = false;
    if ((((simGlobal.gameTicks < 0x240) || (((u_char)countdown < 4 && (Hud_BeTheCop == 0)))) ||
        ((uVar5 = PAD_state(4), (uVar5 & 0x400) != 0 &&
         (DashHUD_gInfo.splitscreen != 0)))) ||
       ((uVar5 = PAD_state(0), (uVar5 & 0x400) != 0 &&
        ((Hud_BeTheCop == 0 || (DashHUD_gInfo.splitscreen != 0)))))) {
      bVar2 = true;
    }
    /* oracle shape: nested if/goto (NOT a flattened || chain) -- gPadinfo.buf[0] gate
     * falls through to the buf[4] gate on failure, and a Hud_BeTheCop!=0 && splitscreen==0
     * combo also falls through instead of short-circuiting. §asm_pattern_catalog funnel class. */
    if (!bVar2) {
      if ((gPadinfo.buf[0].ID == '#') && (0xbf < gPadinfo.buf[0].data.negcon.leftshift)) {
        if ((Hud_BeTheCop != 0) && (DashHUD_gInfo.splitscreen == 0)) goto HudCdPlay_checkBuf4;
        goto HudCdPlay_activateGate;
      }
HudCdPlay_checkBuf4:
      if ((gPadinfo.buf[4].ID == '#') && (0xbf < gPadinfo.buf[4].data.negcon.leftshift) &&
          (DashHUD_gInfo.splitscreen != 0)) {
        goto HudCdPlay_activateGate;
      }
    }
    else {
HudCdPlay_activateGate:
      Hud_gCdActive = 1;
      Hud_ActivateCDPlayer = 1;
    }
  }
  if (Hud_ActivateCDPlayer != 0) {
    if (Hud_BeTheCop != 0) {
      Hud_gCdActive = 1;
    }
    Hud_ActivateCDPlayer = 0;
    Hud_gCdScrollTitle = 1;
    Hud_gCdLastTick = ticks;
    if (type == 0) {
      keepup = 1;
    }
    else {
      keepup = 0;
    }
  }
  if (keepup != 0) {
    type = 0;
  }
  time = currentSong->remaining;
  index = currentSong->index;
  if ((currentSong->info).title == (char *)0x0) {
    title = (char *)0x0;
  }
  else {
    title = strtitle;
    sprintf(title,"%s",(currentSong->info).title);
  }
  if ((currentSong->info).artist == (char *)0x0) {
    artist = (char *)0x0;
  }
  else {
    artist = strartist;
    sprintf(artist,"%s",(currentSong->info).artist);
  }
  uppercase(title);
  if ((type == 0) && (artist != (char *)0x0)) {
    uppercase(artist);
  }
  if (Hud_gCdActive == 0) {
    Hud_kTurnSongOffNext = 1;
    return 1;
  }
  if (index < 1) {
    if (index == 0) {
      sprintf(strindex,"- -");
      tx = 0x44;
    }
    else if (index == -2) {
      sprintf(strindex,"- -");
      tx = 0x45;
    }
    else {
      sprintf(strindex,"- -");
      artist = (char *)0x0;
      if (title != (char *)0x0) goto HudCdPlay_nullStringFallback;
      tx = 0x46;
    }
    artist = (char *)0x0;
    title = TextSys_Word(tx);
HudCdPlay_nullStringFallback:
    if (title == (char *)0x0) {
      keepup = 0;
      Hud_gCdLastTick = ticks;
      goto HudCdPlay_buildOutString;
    }
  }
  else {
    sprintf(strindex,"%02d",index);
    if (title == (char *)0x0) {
      Hud_gCdScrollTitle = 1;
      Hud_gCdLastTick = ticks;
      goto HudCdPlay_nullStringFallback;
    }
  }
  if (Hud_gCdScrollTitle < Hud_BuildString(title,0,0,0,0,true) + 0x4c) {
    while (Hud_gCdLastTick < ticks) {
      Hud_gCdScrollTitle = Hud_gCdScrollTitle + 1;
      Hud_gCdLastTick = Hud_gCdLastTick + 4;
    }
  }
  else if (Hud_gCdLastTick + 0x80 < ticks) {
    Hud_gCdActive = 0;
  }
  dx = 0;
  s = strscrolltitle;
  tx = 0x4c - Hud_gCdScrollTitle;
  if (*title != 0) {
    p = (u_char *)title;
    do {
      if ((int)((u_char *)title + 0x3f) <= (int)p) break;
      if (*p == 0x20) {
        w = 3;
      }
      else {
        if (*p - 0x30 < 10) {
          w = *p + 0x6e;
        }
        else {
          w = *p + 0x43;
        }
        w = HudPmx_gShapes[w].width + 1;
      }
      if (0x4b < tx + w) break;
      if (tx < 0) {
        dx = dx + w;
      }
      else {
        *s = *p;
        s = s + 1;
      }
      p = p + 1;
      tx = tx + w;
    } while (*p != 0);
  }
  *s = 0;
HudCdPlay_buildOutString:
  if (type == 0) {
    if (title == (char *)0x0) {
      return 1;
    }
    Hud_gShowedCDPlayer = 1;
    Hud_BuildString(strscrolltitle,(x + dx + 10) - (Hud_gCdScrollTitle - 0x4c),y + 0xa,
               0xbebe,0,false);
    if (artist != (char *)0x0) {
      Hud_BuildString(artist,x + 0xa,y + 0x13,0x808080,0,false);
    }
    Hud_GoTpage(0);
    Hud_BlackThinBox(g1Player[0xf].x + 10,g1Player[0xf].y + 10,0x50,0x12);
    box_w = 0x50;
    box_h = 0x12;
    box_y = g1Player[0xf].y + 10;
    box_transp = 0;
    box_x = g1Player[0xf].x + 10;
  }
  else {
    Hud_gShowedCDPlayer = 1;
    Font_TextColor(4);
    Font_TextXY(strindex,x,y - 2);
    if (title != (char *)0x0) {
      Font_TextColor(3);
      Hud_BuildString(strscrolltitle,(x + dx + 0x16) - (Hud_gCdScrollTitle - 0x4c),y + 3,
                 0xbebe,0,false);
      Hud_GoTpage(0);
      if (index != 0) {
        int min = time / 60000;
        sec = (time % 60000) / 1000;
        sprintf(strtime,"%1d%c%02d",min,
                   (u_int)(u_char)"::\'\'\'."[GameSetup_gData.userSetting.language],
                   sec);
        Font_TextColor(4);
        Font_TextXY(strtime,(x - textpixels(strtime)) + 0x5c,y + 0xc);
      }
    }
    Hud_BlackThinBox((int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0x1c);
    Hud_FBuildF4(0,(int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0xe,0,'\0','\0');
    Hud_FBuildF4(0,(int)g1Player[0xf].x,g1Player[0xf].y + 0x1b,0x66,1,0,'\0','\0');
    box_w = 0x66;
    box_y = (int)g1Player[0xf].y;
    box_transp = 1;
    box_x = (int)g1Player[0xf].x;
    box_h = 0x1c;
  }
  Hud_FBuildF4(box_transp,box_x,box_y,box_w,box_h,0,'\0','\0');
  return box_h;
}

/* ---- Hud_BuildRadar__Fi  [HUD.CPP:2497-2614] SLD-VERIFIED ---- */
int Hud_BuildRadar(int player)

{
  /* SYM-exact locals (8c block @0x800d6b48): car=$v0, i=$s0, x=$a1, z=$v0, cenX=$t3,
   * cenZ=$t2, mapx=$fp, mapz=$s7(constants 22/24 held callee-saved), m00=$t6, m01=$t5,
   * m10=$t4, m11=$a0, scr AUTO -0xE0, visible=$s6; sprt block-local per draw loop.
   * player is ARG class (stack-spilled, reloaded 0xF8(sp) at each use). */
  BO_tNewtonObj *car;
  int i;
  int x;
  int z;
  int cenX;
  int cenZ;
  int mapx;
  int mapz;
  int m00;
  int m01;
  int m10;
  int m11;
  coorddef scr [15];
  int visible;

  car = Camera_gInfo[player].anchor;
  visible = 0;
  mapx = 0x16;
  mapz = 0x18;
  m00 = car->orientMat.m[0] >> 8;   /* +0xF0 */
  m01 = car->orientMat.m[6] >> 8;   /* +0x108 */
  m10 = car->orientMat.m[2] >> 8;   /* +0xF8 */
  m11 = car->orientMat.m[8] >> 8;   /* +0x110 */
  cenX = car->position.x >> 8;
  cenZ = -car->position.z >> 8;
  for (i = 0; i < Cars_gNumRaceCars; i++) {
    x = (Cars_gRaceCarList[i]->N.position.x >> 8) - cenX;
    z = (-Cars_gRaceCarList[i]->N.position.z >> 8) - cenZ;
    scr[i].x = m00 * x + m01 * z >> 0x10;
    scr[i].z = m10 * x + m11 * z >> 0x11;
    if (GameSetup_gData.mirrorTrack != 0) {
      scr[i].x = -scr[i].x;
    }
    if ((Cars_gRaceCarList[i]->N.active != '\0') && (Cars_gRaceCarList[i]->carIndex != player)) {
      if ((-mapx < scr[i].x) && (scr[i].x < mapx)) {
        if ((-mapz < scr[i].z) && (scr[i].z < mapz)) {
          visible = 1;
        }
      }
    }
  }
  for (i = 0; i < Cars_gNumCopCars; i++) {
    if (Cars_gCopCarList[i]->N.active != '\0') {
      x = (Cars_gCopCarList[i]->N.position.x >> 8) - cenX;
      z = (-Cars_gCopCarList[i]->N.position.z >> 8) - cenZ;
      scr[Cars_gNumRaceCars + i].x = m00 * x + m01 * z >> 0x10;
      scr[Cars_gNumRaceCars + i].z = m10 * x + m11 * z >> 0x11;
      if (GameSetup_gData.mirrorTrack != 0) {
        scr[Cars_gNumRaceCars + i].x = -scr[Cars_gNumRaceCars + i].x;
      }
      if ((-mapx < scr[Cars_gNumRaceCars + i].x) && (scr[Cars_gNumRaceCars + i].x < mapx)) {
        if ((-mapz < scr[Cars_gNumRaceCars + i].z) && (scr[Cars_gNumRaceCars + i].z < mapz)) {
          visible = 1;
        }
      }
    }
  }
  if (visible == 0) {
    for (i = 0; i < Cars_gNumRaceCars; i++) {
      if (Cars_gRaceCarList[i]->N.active != '\0') {
        scr[i].x = scr[i].x >> 2;
        scr[i].z = scr[i].z >> 2;
        if (Cars_gRaceCarList[i]->carIndex != player) {
          if ((-mapx < scr[i].x) && (scr[i].x < mapx) && (-mapz < scr[i].z) && (scr[i].z < mapz)) {
            visible = 2;
          }
        }
      }
    }
    for (i = 0; i < Cars_gNumCopCars; i++) {
      scr[i + Cars_gNumRaceCars].x = scr[i + Cars_gNumRaceCars].x >> 2;
      scr[i + Cars_gNumRaceCars].z = scr[i + Cars_gNumRaceCars].z >> 2;
      if ((-mapx < scr[i + Cars_gNumRaceCars].x) && (scr[i + Cars_gNumRaceCars].x < mapx) &&
          (-mapz < scr[i + Cars_gNumRaceCars].z) && (scr[i + Cars_gNumRaceCars].z < mapz)) {
        visible = 2;
      }
    }
  }
  i = 0;
  while (true) {
    if (Cars_gNumCopCars <= i) break;
    if (Cars_gCopCarList[i]->N.active != '\0') {
      SPRT *sprt;
      u_char *pal;
      u_int tag;

      sprt = (SPRT *)Render_gPacketPtr;
      pal = Render_gPalettePtr;
      *(u_int *)sprt = *(u_int *)sprt & 0xff000000 | *(u_int *)pal & 0xffffff;
      tag = *(u_int *)pal;
      Render_gPacketPtr = (u_char *)sprt + 0x14;
      *(u_int *)pal = tag & 0xff000000 | (u_int)sprt & 0xffffff;
      if ((gFlip == 0) && (simVar.quickPauseSim == 0)) {
        currentSpriteColor = 0xff0000;
      }
      else {
        currentSpriteColor = 0xff;
      }
      Hud_BuildSprite(sprt,0x7a,scr[i + Cars_gNumRaceCars].x + mapx + -2 & 0xffff,
                 scr[i + Cars_gNumRaceCars].z + mapz & 0xffff,currentSpriteColor,0);
    }
    i = i + 1;
  }
  i = 0;
  while (true) {
    if (Cars_gNumRaceCars <= i) break;
    if ((i != player) && (Cars_gRaceCarList[i]->N.active != '\0')) {
      SPRT *sprt;
      u_char *pal;

      sprt = (SPRT *)Render_gPacketPtr;
      pal = Render_gPalettePtr;
      *(u_int *)sprt = *(u_int *)sprt & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)sprt & 0xffffff;
      Render_gPacketPtr = (u_char *)sprt + 0x14;
      if ((Cars_gRaceCarList[i]->carFlags & 4U) != 0) {
        Hud_BuildSprite(sprt,0x79,scr[i].x + mapx + -3 & 0xffff,scr[i].z + mapz & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
      else {
        Hud_BuildSprite(sprt,0x7a,scr[i].x + mapx + -2 & 0xffff,scr[i].z + mapz & 0xffff,
                   *(u_long *)&Hud_gMarkerColor[i],0);
      }
    }
    i = i + 1;
  }
  return visible;
}

/* ---- Hud_BuildReplay__Fv  [HUD.CPP:2752-2849] SLD-VERIFIED ---- */
void Hud_BuildReplay(void)

{
  /* SYM locals: i=$t1, hilite AUTO char[5] (template @0x8013d914 = {4,0,1,2,3}),
   * spr=$v1 (byte-offset walker in loop 1, then reused as the speed-glyph index). */
  int i;
  char hilite [5] = {4,0,1,2,3};
  int spr;
  SPRT *tSs1;
  u_char *pal;

  i = 0x33;
  do {
    tSs1 = gSprite0;
    *(u_int *)&tSs1[i].r0 = 0x66808080;
    i = i + 1;
  } while (i < 0x3f);
  *(u_int *)&tSs1[(u_char)hilite[Replay_ReplayInterface.selection] + 0x33].r0 = 0x6600bebe;
  if (Replay_ReplayInterface.selection == 3) {
    *(u_int *)&tSs1[0x38].r0 = 0x6600bebe;
  }
  *(u_int *)&gSprite0[0x34].u0 =
       *(u_int *)&(HudPmx_gShapes + 0x6e - Replay_ReplayInterface.pause)->pixmap.u0;
  if (Replay_ReplayInterface.speed != 1) {
    if (Replay_ReplayInterface.speed < 2) {
      spr = 0x74;
      if (Replay_ReplayInterface.speed == 0) {
        spr = 0x72;
      }
    }
    else {
      spr = 0x74;
      if (Replay_ReplayInterface.speed == 2) {
        spr = 0x75;
      }
    }
  }
  else {
    spr = 0x73;
  }
  gSprite0[0x38].u0 = HudPmx_gShapes[spr].pixmap.u0;
  gSprite0[0x38].v0 = HudPmx_gShapes[spr].pixmap.v0;
  *(u_int *)&gSprite0[0x39].u0 =
       *(u_int *)&HudPmx_gShapes[Replay_ReplayInterface.camera + 2].pixmap.u0;
  gSprite0[0x39].x0 = g1Player[0xd].x + 0x75;
  if (Replay_ReplayInterface.selection == 4) {
    *(u_int *)&gSprite0[0x39].r0 = 0x6600bebe;
  }
  else {
    *(u_int *)&gSprite0[0x39].r0 = 0x66808080;
  }
  i = 0x33;
  pal = Render_gPalettePtr;
  tSs1 = gSprite0;
  tSs1[0x39].tag =
       (u_long *)((u_int)tSs1[0x39].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
  *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&tSs1[0x39] & 0xffffff;
  do {
    tSs1[i].tag = (u_long *)((u_int)tSs1[i].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
    *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&tSs1[i] & 0xffffff;
    i = i + 1;
  } while (i < 0x38);
  tSs1 = gSprite0;
  pal = Render_gPalettePtr;
  tSs1[0x38].tag =
       (u_long *)((u_int)tSs1[0x38].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
  *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&tSs1[0x38] & 0xffffff;
  gTPage1[0][3].tag =
       (u_long *)((u_int)gTPage1[0][3].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
  *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&gTPage1[0][3] & 0xffffff;
  gTPage0[0][3].tag =
       (u_long *)((u_int)gTPage0[0][3].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
  *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&gTPage0[0][3] & 0xffffff;
  return;
}

/* D_8011321C == GameSetup_gData.reverseTrack (GameSetup_gData+0x30), same standalone-global
 * alias as recon/game/common/aiinit.cpp's D_8011321C precedent -- the oracle reaches it via a
 * bare lui/lw, not a GameSetup_gData struct-field offset. */
extern int D_8011321C;

/* ---- Hud_NextPlayer__Fi  [HUD.CPP:2862-2889] SLD-VERIFIED ----
 * FIXED (was 40 diffs, ours 85/oracle 89 -- 4 insns SHORT): the recon was missing the oracle's
 * `uVar5 = uVar5 ^ D_8011321C;` in-place update, done ONCE above the loop (the `xor s1,s1,v0`
 * in the `blez a1,RETURN` branch's delay slot, overwriting $s1 in place -- NOT a fresh var) --
 * a real correctness/structure gap, not just coloring. The old per-iteration
 * `if (uVar5 == GameSetup_gData.reverseTrack)` re-tested a struct-field load every iteration;
 * the oracle loads D_8011321C ONCE (as the standalone alias, matching aiinit.cpp's precedent)
 * and XORs it into uVar5 itself (loop-invariant), tested as `uVar5 == 0` (XOR-equal) each
 * iteration instead of re-comparing two live values. (A separate `direction` local -- the SYM's
 * declared-but-unused hint -- regressed 40->76 by giving the XOR result its OWN pseudo instead
 * of overwriting uVar5's; reverted to the in-place form.)
 * FURTHER: the outer OR-guard `if ((iVar1!=1)||(uVar5!=0)) {BODY} return -1;` produced the
 * WRONG branch polarity (oracle's short-circuit tail is `bnez s1,BODY` / fallthrough `j
 * RETURN_NEG1`, ours was `beqz s1,RETURN_NEG1` -- De Morgan-equivalent but different bytes).
 * Rewrote as the early-return AND form `if((iVar1==1)&&(uVar5==0)) return -1;` -- matches the
 * oracle's polarity, insn count went exact (89==89), 40->38. Two more polarity flips (De
 * Morgan, behavior-preserving) matched the remaining branches: `if(uVar3&4){ if(player==0)
 * return 8; return 7; }` -> `if(player!=0) return 7; return 8;` (38->32); `if(uVar5==0)
 * iVar1++ else iVar1--;` -> `if(uVar5!=0) iVar1-- else iVar1++;` (32->28).
 * RESIDUAL 28: oracle computes D_8011321C's ADDRESS speculatively in BOTH branch-delay-slots
 * leading into the loop-prep block (so $v0 already holds it when Cars_gNumCars is then forced
 * into $v1/$a1), because the ORIGINAL C's guard was the OR-short-circuit shape (address
 * materialized on both paths before the value is known to be needed); my AND/early-return
 * rewrite computes the early return WITHOUT touching D_8011321C, so $v0 is free at the merge
 * point and takes Cars_gNumCars instead -- a genuine register-materialization scheduling
 * difference downstream of the (correctness-preserving) polarity rewrite, not reachable without
 * un-doing the branch-polarity win. Net: 40->28, +1 real correctness fix (D_8011321C), insn
 * count exact. */
int Hud_NextPlayer(int player)

{
  int iVar4;
  int iVar1;
  u_int uVar3;
  int j;
  int i;
  Car_tObj *carObj;
  Car_tObj *carObj_00;
  int direction;
  u_int uVar5;

  uVar5 = (u_int)(0 < *(int *)((player << 2) + (int)Input_gLookBehind) != 0 < DashHUD_gInfo.wrongway[player]);
  carObj_00 = Cars_gHumanRaceCarList[player];
  if (1 < Cars_gNumRaceCars) {
    iVar1 = Stats_GetPosition(carObj_00);
    if ((iVar1 == 1) && (uVar5 == 0)) {
      return -1;
    }
    iVar4 = 0;
    uVar5 = uVar5 ^ D_8011321C;
    iVar1 = carObj_00->sortIndex;
    if (0 < Cars_gNumCars + -1) {
      do {
        if (uVar5 != 0) {
          iVar1 = iVar1 + -1;
        }
        else {
          iVar1 = iVar1 + 1;
        }
        if (iVar1 < 0) {
          iVar1 = iVar1 + Cars_gNumCars;
        }
        if (Cars_gNumCars <= iVar1) {
          iVar1 = 0;
        }
        carObj = Cars_gSortedList[iVar1];
        uVar3 = *(u_int *)((int)carObj + 0x260);
        if ((uVar3 & 4) != 0) {
          if (player != 0) {
            return 7;
          }
          return 8;
        }
        iVar4 = iVar4 + 1;
        if ((uVar3 & 8) != 0) {
          return *(int *)((int)carObj + 0x4ec);
        }
      } while (iVar4 < Cars_gNumCars + -1);
    }
  }
  return -1;
}

/* ---- Hud_NextPlayerNameOrCarOrTime__Fi  [HUD.CPP:2895-2924] SLD-VERIFIED ----
 * IMPROVED (was 64 diffs, ours 94/oracle 98 -- 4 SHORT; now 59, ours 97/oracle 98): sibling of
 * Hud_NextPlayer__Fi's bug -- missing the oracle's ONCE-hoisted `uVar4 ^= GameSetup_gData.
 * reverseTrack;` above the loop (here the field IS reached via the real struct-offset form,
 * `lw v0,0x30(t0)` off &GameSetup_gData -- unlike Hud_NextPlayer's standalone D_8011321C alias,
 * so no extern needed here). Applied the same 3-lever family: (1) OR-guard -> AND-early-return
 * `if((iVar1==1)&&(uVar4==0)) return "";` for branch polarity (De Morgan-equivalent); (2) hoist
 * + in-place `uVar4 ^= reverseTrack`, tested inverted (`if(uVar4!=0) iVar1-- else iVar1++`,
 * matching Hud_NextPlayer's needed inversion); (3) inverted the HudOpponentID==2 branch (return
 * the +0x249 form in the `==2` arm, +0x288 form as the fallthrough) to match the oracle's `beq`
 * sense. RESIDUAL 59: same register-materialization scheduling floor as Hud_NextPlayer (D_
 * string-literal/GameSetup_gData address hoisted speculatively in the oracle's OR-shaped delay
 * slots, freed up in ours by the AND/early-return rewrite) -- not chased further, diminishing
 * returns. Net: correctness fix landed (matches the already-fixed sibling), insn count 94->97
 * (of 98). */
char * Hud_NextPlayerNameOrCarOrTime(int player)

{
  int iVar1;
  int iVar2;
  int j;
  int i;
  int iVar3;
  Car_tObj *carObj;
  Car_tObj *carObj_00;
  int direction;
  u_int uVar4;
  
  uVar4 = (u_int)(0 < Input_gLookBehind[player] != 0 < DashHUD_gInfo.wrongway[player]);
  carObj_00 = Cars_gHumanRaceCarList[player];
  if (1 < Cars_gNumRaceCars) {
    iVar1 = Stats_GetPosition(carObj_00);
    iVar3 = 0;
    if ((iVar1 == 1) && (uVar4 == 0)) {
      return "";
    }
    {
      iVar1 = carObj_00->sortIndex;
      if (0 < Cars_gNumCars + -1) {
        uVar4 = uVar4 ^ GameSetup_gData.reverseTrack;
        do {
          if (uVar4 != 0) {
            iVar1 = iVar1 + -1;
          }
          else {
            iVar1 = iVar1 + 1;
          }
          if (iVar1 < 0) {
            iVar1 = iVar1 + Cars_gNumCars;
          }
          iVar2 = iVar1 << 2;
          if (Cars_gNumCars <= iVar1) {
            iVar1 = 0;
            iVar2 = 0;
          }
          iVar2 = *(int *)((int)Cars_gSortedList + iVar2);
          if ((*(u_int *)(iVar2 + 0x260) & 0xc) != 0) {
            if (GameSetup_gData.carInfo[player].HudOpponentID == 2) {
              return (char *)(iVar2 + 0x249);
            }
            return (char *)(*(int *)(iVar2 + 0x288) + 0x5c);
          }
          iVar3 = iVar3 + 1;
        } while (iVar3 < Cars_gNumCars + -1);
      }
    }
  }
  return "";
}

/* ---- Hud_RenderMapView__Fv  [HUD.CPP:2935-2980] SLD-VERIFIED ---- */
void Hud_RenderMapView(void)

{
  int tile_pmx_p;
  int ft4_iter_b;
  int tile_dest_p;
  int HudFT4;
  int j;
  int player;
  int tile_count;
  int current_tile_idx;
  u_char *tp2;
  u_char *tp1;
  u_char *tp3;
  
  tile_count = 0;
  current_tile_idx = 0;
  player = 0;
  while (true) {
    if (DashHUD_gInfo.splitscreen < player) break;
    /* was `*(int *)(track_geom_p + 0x450)` off &GameSetup_gData -- that read gData+0x450
     * (inside userSetting), NOT carInfo[player].HudMap at gData+0x89C+player*0xB4 as the
     * oracle does (LO16-blind verify hid it). Real field access re-creates the oracle's
     * 0xB4-stride anchored giv. */
    if (((GameSetup_gData.carInfo[player].HudMap != 0) &&
        (((dashhud_info *)((int)&DashHUD_gInfo + tile_count))->showhud[0] != 0)) &&
       (Hud_gWingmanInterface[player] == '\0')) {
      HudFT4 = (int)gHudFT4;
      if (player != 0) {
        HudFT4 = (int)(gHudFT4 + 5);
      }
      Draw_StartRenderingView(*(int *)((int)Hud_gMapView + tile_count));
      if (GameSetup_gData.carInfo[player].HudMap == 1) {
        Hud_BuildMapMarkers(player);
        tp1 = Render_gPalettePtr;
        ((POLY_FT4 *)HudFT4)->tag =
             (u_long *)
             ((u_int)((POLY_FT4 *)HudFT4)->tag & 0xff000000 |
             *(u_int *)Render_gPalettePtr & 0xffffff);
        *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | HudFT4 & 0xffffffU;
      }
      else {
        tile_pmx_p = Hud_BuildRadar(player);
        tp2 = Render_gPalettePtr;
        if (tile_pmx_p == 1) {
          ((POLY_FT4 *)(HudFT4 + 0x28))->tag =
               (u_long *)
               ((u_int)((POLY_FT4 *)(HudFT4 + 0x28))->tag & 0xff000000 |
               *(u_int *)Render_gPalettePtr & 0xffffff);
          *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | (u_int)(HudFT4 + 0x28) & 0xffffff;
          ((POLY_FT4 *)(HudFT4 + 0x50))->tag =
               (u_long *)
               ((u_int)((POLY_FT4 *)(HudFT4 + 0x50))->tag & 0xff000000 |
               (u_int)(HudFT4 + 0x28) & 0xffffff);
          ft4_iter_b = HudFT4 + 0x50;
        }
        else {
          ((POLY_FT4 *)(HudFT4 + 0x78))->tag =
               (u_long *)
               ((u_int)((POLY_FT4 *)(HudFT4 + 0x78))->tag & 0xff000000 |
               *(u_int *)Render_gPalettePtr & 0xffffff);
          *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | (u_int)(HudFT4 + 0x78) & 0xffffff;
          ((POLY_FT4 *)(HudFT4 + 0xa0))->tag =
               (u_long *)
               ((u_int)((POLY_FT4 *)(HudFT4 + 0xa0))->tag & 0xff000000 |
               (u_int)(HudFT4 + 0x78) & 0xffffff);
          ft4_iter_b = HudFT4 + 0xa0;
        }
        *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | ft4_iter_b & 0xffffffU;
      }
      tp3 = Render_gPalettePtr;
      /* &gTPage1[player][1] via the 0x30-stride walker (was the disguised bare VA
       * 0x8013E3FC = gTPage1 + 0xC) */
      tile_dest_p = (int)gTPage1 + current_tile_idx + 0xc;
      *(u_int *)tile_dest_p =
           *(u_int *)tile_dest_p & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | tile_dest_p & 0xffffffU;
      Draw_StopRenderingView(*(int *)((int)Hud_gMapView + tile_count));
    }
    tile_count = tile_count + 4;
    current_tile_idx = current_tile_idx + 0x30;
    player = player + 1;
  }
  return;
}

/* ---- Hud_BlackThinBox__Fiiii  [HUD.CPP:3082-3116] SLD-VERIFIED ---- */
static inline int hud_sub2(int a, int b) { return a - b; }

void Hud_BlackThinBox(int x, int y, int w, int h)
{
  short CORNERHEIGHT;
  int   CORNERWIDTH;
  int   x_left, top_w, side_y, side_h, x_right, y_bottom;

  CORNERWIDTH  = HudPmx_gShapes[0x11].width;
  x_left = hud_sub2(x + CORNERWIDTH, 2);
  top_w  = hud_sub2(w, CORNERWIDTH * 2) + 2;
  CORNERHEIGHT = HudPmx_gShapes[0x11].height;
  /* top edge */
  Hud_FBuildF4(0, x_left, hud_sub2(y, 2), top_w, 2, 0, '\0', '\0');
  /* left edge */
  side_y = hud_sub2(y + CORNERHEIGHT, 2);
  side_h = hud_sub2(h, CORNERHEIGHT * 2) + 4;
  Hud_FBuildF4(0, hud_sub2(x, 2), side_y, 2, side_h, 0, '\0', '\0');
  /* right edge */
  x_right = x + w;
  Hud_FBuildF4(0, hud_sub2(x_right, 2), side_y, 2, side_h, 0, '\0', '\0');
  /* bottom edge */
  y_bottom = y + h;
  Hud_FBuildF4(0, x_left, y_bottom, top_w, 2, 0, '\0', '\0');
  /* 4 rounded corners */
  Hud_FBuildGT4(&HudPmx_gShapes[0xe],  hud_sub2(x, 2),                 hud_sub2(y, 2),                    0);
  Hud_FBuildGT4(&HudPmx_gShapes[0xf],  hud_sub2(x_right, CORNERWIDTH), hud_sub2(y, 2),                    0);
  Hud_FBuildGT4(&HudPmx_gShapes[0x10], hud_sub2(x, 2),                 hud_sub2(y_bottom, hud_sub2(CORNERHEIGHT, 2)), 0);
  Hud_FBuildGT4(&HudPmx_gShapes[0x11], hud_sub2(x_right, CORNERWIDTH), hud_sub2(y_bottom, CORNERHEIGHT - 2), 0);
}

/* ---- Hud_Draw321Num__Fiiiiii  [HUD.CPP:3155-3254] SLD-VERIFIED ---- */
int Hud_Draw321Num(int x,int y,int num,int flare_intensity,int arg4,int arg5)

{
  u_int uVar1;
  int index;
  int x_00;
  int i;
  int iVar2;
  int iVar3;
  int k;
  u_int uVar4;
  int j;
  int iVar5;
  int iVar6;
  int by;
  
  if (flare_intensity != 0) {
    uVar4 = 0;
    iVar5 = 0;
    iVar6 = y;
    do {
      iVar2 = 0;
      iVar3 = x;
      do {
        if ((Hud_Character[num] & 1 << (uVar4)) != 0) {
          Flare_2DHalo(iVar3 + 4,iVar6 + 4,flare_intensity,flare_intensity,6);
        }
        iVar3 = iVar3 + 10;
        iVar2 = iVar2 + 1;
        uVar4 = uVar4 + 1;
      } while (iVar2 < 5);
      iVar5 = iVar5 + 1;
      iVar6 = iVar6 + 9;
    } while (iVar5 < 5);
  }
  Hud_BlackThinBox(x - 3, y - 2, 0x38, 0x31);
  uVar4 = 0;
  iVar5 = 0;
  iVar6 = y;
  do {
    iVar2 = 0;
    iVar3 = x;
    do {
      x_00 = iVar3 + 1;
      iVar3 = iVar3 + 10;
      iVar2 = iVar2 + 1;
      uVar1 = uVar4;
      uVar4 = uVar4 + 1;
      Hud_FBuildSprite((Hud_Character[num] & 1 << uVar1) != 0 | 0x3c,x_00,iVar6 + 1,0x808080,0);
    } while (iVar2 < 5);
    iVar5 = iVar5 + 1;
    iVar6 = iVar6 + 9;
  } while (iVar5 < 5);
  iVar6 = 0x31;
  Hud_FBuildF4(0, x - 3, y - 2, 0x38, 0x31, 0, '\0','\0');
  Hud_GoTpage(1);
  return iVar6;
}

/* ---- Hud_Render321Go__Fv  [HUD.CPP:3261-3339] SLD-VERIFIED ---- */
void Hud_Render321Go(void)

{
  static u_long countdownTick;
  u_long currentTick;
  u_int uVar1;
  int flare_intensity;
  int flare_intensity_00;
  int num;
  int num_00;
  u_long y;
  int y_00;
  u_long x;
  
  gCView.id = Hud_gStatsView;
  Draw_StartRenderingView(Hud_gStatsView);
  y_00 = (int)g1Player[0x11].y;
  x = 160;
  if ((int)oldCountdown != (u_int)(u_char)countdown) {
    oldCountdown = countdown;
    countdownTick_216 = ticks;
  }
  uVar1 = ticks - countdownTick_216;
  if ((u_char)countdown == 4) {
    if (uVar1 < 100) {
      flare_intensity_00 = 8000 - uVar1 * 0x50;
      goto HudRender321_drawCountNum;
    }
  }
  else if (uVar1 < 100) {
    flare_intensity_00 = 6000 - uVar1 * 0x3c;
    goto HudRender321_drawCountNum;
  }
  flare_intensity_00 = 0;
HudRender321_drawCountNum:
  num_00 = 4 - (u_int)(u_char)countdown;
  if ((u_char)countdown != 4) {
    Hud_Draw321Num(x-0x58,y_00,num_00,flare_intensity_00,1,0);
    Hud_Draw321Num(x-0x19,y_00,num_00,flare_intensity_00,0,0);
    Hud_Draw321Num(x+0x26,y_00,num_00,flare_intensity_00,0,1);
  }
  Draw_StopRenderingView(Hud_gStatsView);
  return;
}

/* ---- BigBTCTime__Fi  [HUD.CPP:3345-3423] SLD-VERIFIED ---- */
void BigBTCTime(int secs)

{
  static int lastsec;
  static int lastsectick;
  int iVar1;
  int iVar2;
  u_char *prim_00;
  int diff;
  int iVar3;
  int tens_digit;
  int color_pack;
  int ten;
  POLY_GT4 *prim;
  int x;
  int x_00;
  int Col_shadow;
  int Col2;
  int Col_main;
  int Col;
  int w1;
  int iVar4;
  int y;
  int y_00;
  int xx;
  int loc_40;
  int yy;
  int w2;
  u_char *tp4;
  u_char *tp3;
  u_char *tp2;
  short ts1;
  
  if (((BTC_BonusTime == 0) && (HudBustedOverlay == 0)) && (-1 < secs)) {
    if (secs != BigBTCTime_state1) {
      BigBTCTime_state2 = ticks;
      BigBTCTime_state1 = secs;
    }
    ts1 = g1Player[0xf].x;
    y_00 = (int)g1Player[0xf].y;
    x_00 = ts1 + 2;
    iVar3 = (int)HudPmx_gShapes[0x2d].width;
    iVar4 = HudPmx_gShapes[0x2c].width + 1;
    if (secs < 0xb) {
      if ((diff = ticks - BigBTCTime_state2) < 0x40) {
        Hud_BlackThinBox(x_00,y_00,iVar4 * 2,0xe);
        Hud_FBuildF4(0,x_00,y_00,iVar4 * 2,0xe,0,'\0','\0');
        BTC_playedsoundalready = 0;
        return;
      }
      Col = 200;
      if (BTC_playedsoundalready == 0) {
        AudioCmn_PlayWrongWaySFX();
        BTC_playedsoundalready = 1;
      }
      Col2 = 100;
    }
    else {
      Col = 0xc800;
      BTC_playedsoundalready = 0;
      Col2 = 0x6400;
    }
    tp3 = Render_gPacketPtr;
    tp2 = Render_gPalettePtr;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    tens_digit = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x34;
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tens_digit;
    iVar2 = secs / 10;
    Hud_BuildGT4((POLY_GT4 *)tp3,HudPmx_gShapes + secs % 10 + 0x2c,x_00 + iVar4 + -1,y_00,
               Col);
    *(int *)(tp3 + 0x28) = Col2;
    *(int *)(tp3 + 0x1c) = Col2;
    prim_00 = Render_gPacketPtr;
    tp4 = Render_gPalettePtr;
    if (iVar2 != 0) {
      iVar1 = iVar4;
      if (iVar2 == 1) {
        iVar1 = iVar3 + 1;
      }
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      color_pack = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x34;
      *(u_int *)tp4 = *(u_int *)tp4 & 0xff000000 | color_pack;
      Hud_BuildGT4((POLY_GT4 *)prim_00,HudPmx_gShapes + iVar2 + 0x2c,(x_00 + iVar4) - iVar1,y_00,
                 Col);
      *(int *)(prim_00 + 0x28) = Col2;
      *(int *)(prim_00 + 0x1c) = Col2;
    }
    Hud_BlackThinBox(x_00,y_00,iVar4 * 2,0xe);
    Hud_FBuildF4(0,x_00,y_00,iVar4 * 2,0xe,0,'\0','\0');
  }
  return;
}

/* ---- Hud_RenderHudView__Fv  [HUD.CPP:3426-3736] SLD-VERIFIED ---- */
void Hud_RenderHudView(void)
{
  /* SYM-exact shape (8c @0x800d82d0): fn-scope sBuildOutput[64] AUTO -0x80, j REG $fp;
   * splitY AUTO -0x40 (loop-body block); perp block: flare_intensity/x/y/ww/ww2/color/
   * flare_type (ww AUTO -0x3C = full text width, ww2 = half); showhud block: gSprt1=$s4,
   * nextplayer=$v0; inner: w1=$s2 w2=$s3 totalwidth=$s0 h=$v1; sprt-link block: i=$a2.
   * viewOff/tpageOff walkers of the old recon are compiler givs -> index-form [j]. */
  char sBuildOutput[64];
  int j;
  int viewOff;
  int tpageOff;

  viewOff = 0;
  tpageOff = 0;
  j = 0;
  while (true) {
    int splitY;

    if (DashHUD_gInfo.splitscreen < j) break;
    splitY = 0;
    if (j != 0) splitY = -0xf;
    Draw_StartRenderingView(*(int *)((int)Hud_gHudView + viewOff));
    Hud_DebugInfo();
    Hud_DebugCrap();
    if ((GameSetup_gData.raceType == 1) && (*(int *)((int)PerpOverlayOn + viewOff) != 0)) {
      int flare_intensity;
      u_long x;
      u_long y;
      u_long ww;
      u_long ww2;
      u_long color;
      int flare_type;

      ww = textpixels(TextSys_Word(*(int *)((int)PerpOverlayMessage + viewOff) + 0x41));
      y = g1Player[0x12].y + splitY;
      Font_TextColor(4);
      ww2 = ww >> 1;
      Font_TextXY(TextSys_Word(*(int *)((int)PerpOverlayMessage + viewOff) + 0x41),
                  0xa0 - (ww2 + 1), y);
      color = 0x800000;
      if ((simGlobal.gameTicks >> 4 & 1) != 0) color = 0x80;
      flare_type = 10;
      if ((simGlobal.gameTicks >> 4 & 1) != 0) flare_type = 8;
      x = 0xa0 - ww2;
      flare_intensity = 4000 - (simGlobal.gameTicks % 0xf) * 0xfa;
      Flare_2DHalo(x - 0x23, y + 8, flare_intensity, flare_intensity, flare_type);
      Flare_2DHalo(x - 0x2d, y + 8, flare_intensity, flare_intensity, flare_type);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], x - 0x26, y + 5, color);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], x - 0x30, y + 5, color);
      color = 0x800000;
      if ((simGlobal.gameTicks >> 4 & 1) == 0) color = 0x80;
      flare_type = 10;
      if ((simGlobal.gameTicks >> 4 & 1) == 0) flare_type = 8;
      Flare_2DHalo(ww2 + 0xc0, y + 8, flare_intensity, flare_intensity, flare_type);
      Flare_2DHalo(ww2 + 0xca, y + 8, flare_intensity, flare_intensity, flare_type);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], ww2 + 0xbd, y + 5, color);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], ww2 + 0xc7, y + 5, color);
      Hud_BlackThinBox(x - 0x31, y, ww + 0x62, 0x11);
      Hud_FBuildF4(0, x - 0x31, y, 0x17, 0x11, 0, '\0', '\0');
      Hud_FBuildF4(0, ww2 + 0xba, y, 0x15, 0x11, 0, '\0', '\0');
      Hud_FBuildF4(0, ww2 + 0xba, y + 3, 0x16, 0xb, 0, '\0', '\0');
      Hud_FBuildF4(1, x - 0x1a, y, ww + 0x36, 0x11, 0x461414, '\0', '\0');
    }
    if (j == DashHUD_gInfo.splitscreen) {
      if ((u_int)((BTC_Countdown >> 6) - 1U) < 0x1e) {
        BigBTCTime(BTC_Countdown >> 6);
      } else {
        Hud_BuildCdPlayer((0x23f < simGlobal.gameTicks) &&
                          ((3 < (u_char)countdown) || (Hud_BeTheCop != 0)), j);
      }
    }
    if (((dashhud_info *)((int)&DashHUD_gInfo + viewOff))->showhud[0] != 0) {
      SPRT *gSprt1;
      int nextplayer;

      if (j != 0) {
        gSprt1 = gSprite1;
      } else {
        gSprt1 = gSprite0;
      }
      DashHUD_CheckWrongWay(j);
      DashHUD_HUDCalc(j);
      Hud_BuildNumbers0(j);
      Hud_BuildNumbers(j);
      {
        u_char *pal;
        u_int *tagp;

        pal = Render_gPalettePtr;
        tagp = (u_int *)((int)gTPage0 + tpageOff);
        *tagp = *tagp & 0xff000000 | *(u_int *)pal & 0xffffff;
        *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & 0xffffff;
        if (GameSetup_gData.carInfo[j].HudTach != 0) {
          gSprt1[1].tag = (u_long *)((u_int)gSprt1[1].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
          *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)(gSprt1 + 1) & 0xffffff;
        }
      }
      if (GameSetup_gData.carInfo[j].HudMap != 0) {
        if (((GameSetup_gData.carInfo[j].HudOpponentID != 0) && (Hud_BeTheCop == 0)) &&
            (GameSetup_gData.commMode != 1)) {
          nextplayer = Hud_NextPlayer(j);
          if (-1 < nextplayer) {
            if ((nextplayer < 9) && (Hud_BeTheCop == 0)) {
              int w1;
              int w2;
              int totalwidth;
              int h;

              w1 = (int)HudPmx_gShapes[0xe].width;
              w2 = (int)HudPmx_gShapes[0x14].width;
              totalwidth = (int)HudPmx_gShapes[0x78].width + 2;
              sprintf(sBuildOutput, "%s", Hud_NextPlayerNameOrCarOrTime(j));
              Hud_GoTpage(1);
              uppercase(sBuildOutput);
              Hud_BuildString(sBuildOutput,
                              (int)g1Player[0xe].x +
                              (totalwidth - Hud_BuildString(sBuildOutput, 0, 0, 0, 0, true) >> 1),
                              ((g1Player[0xe].y + HudMapOffsetY + splitY) -
                               (int)HudPmx_gShapes[0xe].height) + 1, 0x808080, 0, false);
              Hud_GoTpage(0);
              Hud_FBuildGT4(&HudPmx_gShapes[0xe], (int)g1Player[0xe].x,
                            (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height,
                            0x808080);
              Hud_FBuildGT4(&HudPmx_gShapes[0xf], (int)g1Player[0xe].x + w1 + w2,
                            (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xf].height,
                            0x808080);
              Hud_FBuildF4(0, (int)g1Player[0xe].x + 2,
                           (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height,
                           w1 + w2 + 3, (int)HudPmx_gShapes[0xe].height, 0, '\0', '\0');
              h = 2;
              if (Hud_gWingmanInterface[j] == '\0') h = 3;
              Hud_FBuildF4(0, (int)g1Player[0xe].x, g1Player[0xe].y + HudMapOffsetY + splitY, 3, h,
                           0, '\0', '\0');
              Hud_FBuildF4(0, ((int)g1Player[0xe].x + w1 + w2 + (int)HudPmx_gShapes[0xf].width) - 3,
                           g1Player[0xe].y + HudMapOffsetY + splitY, 3, 3, 0, '\0', '\0');
            }
          }
        }
        {
          int i;
          u_char *pal;

          i = 0x3f;
          pal = Render_gPalettePtr;
          do {
            gSprt1[i].tag = (u_long *)((u_int)gSprt1[i].tag & 0xff000000 | *(u_int *)pal & 0xffffff);
            *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)&gSprt1[i] & 0xffffff;
            i = i + 1;
          } while (i < 0x47);
        }
      }
    }
    if (((j == 0) && (1 < Replay_ReplayMode)) && (Replay_ReplayInterface.statsScreen == 0)) {
      Hud_BuildReplay();
    }
    {
      u_char *pal;
      u_int *tagp;

      pal = Render_gPalettePtr;
      tagp = (u_int *)((int)gTPage1 + tpageOff);
      *tagp = *tagp & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & 0xffffff;
    }
    if (((((dashhud_info *)((int)&DashHUD_gInfo + viewOff))->showhud[0] != 0) &&
         (Hud_gWingmanInterface[j] != '\0')) && (Replay_ReplayMode < 2)) {
      Hud_BuildWingmanInterface(j);
    }
    {
      u_char *pal;
      u_int *tagp;
      int *viewp;

      pal = Render_gPalettePtr;
      viewp = (int *)((int)Hud_gHudView + viewOff);
      tagp = (u_int *)((int)gTPage0 + tpageOff + 0xc);
      viewOff = viewOff + 4;
      tpageOff = tpageOff + 0x30;
      *tagp = *tagp & 0xff000000 | *(u_int *)pal & 0xffffff;
      *(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & 0xffffff;
      Draw_StopRenderingView(*viewp);
    }
    j = j + 1;
  }
}

/* ---- Hud_RenderTacView__Fv  [HUD.CPP:3744-3764] SLD-VERIFIED ---- */
void Hud_RenderTacView(void)

{
  u_char *puVar1;
  int j;
  int player;
  DR_MODE *tag_walk;
  GameSetup_tData *car_walk;
  
  player = 0;
  if (-1 < DashHUD_gInfo.splitscreen) {
    tag_walk = gTPage1[0] + 2;
    car_walk = &GameSetup_gData;
    do {
      if ((car_walk->carInfo[0].HudTach != 0) && (DashHUD_gInfo.showhud[player] != 0)) {
        Draw_StartRenderingView(Hud_gTacView[player]);
        DashHUD_HUDCalc(player);
        Hud_BuildTach(player);
        puVar1 = Render_gPalettePtr;
        tag_walk->tag =
             (u_long *)((u_int)tag_walk->tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff);
        *(u_int *)puVar1 = *(u_int *)puVar1 & 0xff000000 | (u_int)tag_walk & 0xffffff;
        Draw_StopRenderingView(Hud_gTacView[player]);
      }
      tag_walk = tag_walk + 4;
      player = player + 1;
      car_walk = (GameSetup_tData *)((car_walk->controllerData).shockImpact + 1);
    } while (player <= DashHUD_gInfo.splitscreen);
  }
  return;
}

/* D_801132CC == GameSetup_gData.userSetting.language (GameSetup_gData+0xE0) -- standalone-global
 * alias, same precedent as D_8011321C above: the else-branch oracle reaches language via
 * lui/lw %lo(D_801132CC) with a SEPARATE scratch (unsized-array shape, methodology 3.12 #5),
 * while the then-branch uses the real struct-offset form off &GameSetup_gData. */
extern int D_801132CC[];

/* ---- Hud_ParseTime__FiPc  [HUD.CPP:3770-3801] SLD-VERIFIED ---- */
void Hud_ParseTime(int nTime,char *sLapTime)

{
  int centi_total;
  int min;
  bool showtime;
  int iVar1;
  int sec;

  if (nTime < 0) {
    nTime = 0;
  }
  showtime = nTime != 0;
  centi_total = nTime * 0x6400;
  if (centi_total < 0) {
    centi_total = centi_total + 0x3fff;
  }
  nTime = centi_total >> 0xe;
  min = (nTime / 6000) * 0x10000 >> 0x10;
  nTime = nTime + min * -6000;
  sec = (nTime / 100) * 0x10000 >> 0x10;
  nTime = nTime + sec * -100;
  if (!(min < 0x3c)) {
    showtime = 0;
  }
  if (showtime != 0) {
    sprintf(sLapTime,"%01d%c%02d%c%02d",min,
               (u_int)(u_char)HudminChar[GameSetup_gData.userSetting.language],sec,
               (u_int)(u_char)HudsecChar[GameSetup_gData.userSetting.language],
               nTime * 0x10000 >> 0x10);
  }
  else {
    iVar1 = D_801132CC[0];
    sprintf(sLapTime," - %c - - %c - -",
               (u_int)(u_char)HudminChar[iVar1],
               (u_int)(u_char)HudsecChar[iVar1]);
  }
  return;
}

/* ---- Hud_RenderPauseBox__Fiiii  [HUD.CPP:3812-3839] SLD-VERIFIED ---- */
void Hud_RenderPauseBox(int x, int y, int w, int h)
{
  short CORNERWIDTH, CORNERHEIGHT;

  CORNERWIDTH  = HudPmx_gShapes[0x11].width;
  CORNERHEIGHT = HudPmx_gShapes[0x11].height;
  /* 4 textured rounded corners */
  Hud_FBuildFT4(&HudPmx_gShapes[0xe],  x - 2,                 y + 0xa,                0);
  Hud_FBuildFT4(&HudPmx_gShapes[0xf],  (x + w) - CORNERWIDTH, y + 0xa,                0);
  Hud_FBuildFT4(&HudPmx_gShapes[0x10], x - 2,                 (y + h) - CORNERHEIGHT, 0);
  Hud_FBuildFT4(&HudPmx_gShapes[0x11], (x + w) - CORNERWIDTH, (y + h) - CORNERHEIGHT, 0);
  /* bottom highlight bar, frame, title strip, dark-red body fill */
  Hud_FBuildF4(0, x, (y + h) - 2, w, 2, 0, '\0', '\0');
  Hud_BlackThinBox(x, y, w, h);
  Hud_FBuildF4(0, x, y, w, 0xc, 0, '\0', '\0');
  Hud_FBuildF4(1, x, y + 0xc, w, h - 0xc, 0x461414, '\0', '\0');
}

/* ---- Hud_Render__Fv  [HUD.CPP:3846-3967] SLD-VERIFIED ---- */
void Hud_Render(void)

{
  short player;
  int countamount;
  int count;
  int wingmode;
  int i;

  if (Replay_ReplayInterface.statsScreen != 0) {
    if (simGlobal.gameTicks < 0x240) {
      DashHUD_gInfo.showhud[0] = 0;
      DashHUD_gInfo.showhud[1] = 0;
    }
    gCView.id = Hud_gStatsView;
    Draw_StartRenderingView(Hud_gStatsView);
    Hud_DebugCrap();
    Hud_RenderStatsView();
    Draw_StopRenderingView(Hud_gStatsView);
    return;
  }
  if (((HudBustedOverlay == 0) && (BTC_BonusTime != 0)) && (0xfa < ticks - BTC_BonusTimeTick)) {
    if (DashHUD_gInfo.splitscreen != 0) {
      if ((Cars_gRaceCarList[0]->carFlags & 0x200U) != 0) {
        countamount = 0xfa;
        if ((Cars_gRaceCarList[1]->carFlags & 0x200U) != 0) goto HudRender_setRateFast;
      }
      else {
        countamount = 0xfa;
      }
    }
    else {
HudRender_setRateFast:
      countamount = 0x32;
    }
    count = countamount;
    if (BTC_BonusTime < countamount) {
      count = BTC_BonusTime;
    }
    BTC_Countdown = BTC_Countdown + count;
    BTC_BonusTime = BTC_BonusTime - countamount;
    if (BTC_BonusTime < 0) {
      BTC_BonusTime = 0;
    }
  }
  if ((Hud_BeTheCop != 0) && (BTC_UserHasControl == 0)) {
    i = 0;
    if (-1 < DashHUD_gInfo.splitscreen) {
      do {
        Draw_StartRenderingView(Hud_gHudView[i]);
        Hud_GoTpage(1);
        if (((i == 0) && (1 < Replay_ReplayMode)) && (Replay_ReplayInterface.statsScreen == 0)) {
          Hud_BuildReplay();
        }
        if (i == DashHUD_gInfo.splitscreen) {
          countamount = 1;
          if ((simGlobal.gameTicks < 0x240) && (countdown == '\0')) {
            countamount = 0;
          }
          Hud_BuildCdPlayer(countamount,i);
        }
        if (DashHUD_gInfo.showhud[i] != 0) {
          Hud_DebugInfo();
          Hud_BuildNumbers0(i);
        }
        Hud_GoTpage(0);
        Draw_StopRenderingView(Hud_gHudView[i]);
        i = i + 1;
      } while (i <= DashHUD_gInfo.splitscreen);
    }
  }
  else {
    if ((HudBustedOverlay != 0) && (Replay_ReplayMode < 2)) {
      player = HudBustedOverlayPlayer;
      gCView.id = Hud_gStatsView;
      Draw_StartRenderingView(Hud_gStatsView);
      StatsTimer[player] = StatsTimer[player] + 1;
      Hud_BTCStats(player,false);
      Draw_StopRenderingView(Hud_gStatsView);
    }
    i = 0;
    while (i < 2) {
      wingmode = Input_WingCommandMode(i);
      if (((u_char)Hud_gWingmanInterface[i] == wingmode) && (HudBustedOverlay != 0)) {
HudRender_initMapFrame:
        Hud_gWingmanInterface[i] = 0;
        Hud_InitMapFrame(i,0);
      }
      else if (Hud_gWingmanFlashTicks[i] < ticks) {
        if ((u_char)Hud_gWingmanInterface[i] != wingmode) {
          if (1 < Replay_ReplayMode) goto HudRender_initMapFrame;
          if (HudBustedOverlay == 0) {
            Hud_InitMapFrame(i,wingmode);
            Hud_gWingmanInterface[i] = (char)wingmode;
          }
        }
        if (1 < Replay_ReplayMode) goto HudRender_initMapFrame;
      }
      i = i + 1;
    }
    Hud_gShowedCDPlayer = 0;
    if (((simGlobal.gameTicks < 0x240) && (countdown != '\0')) && (Hud_BeTheCop == 0)) {
      Hud_Render321Go();
    }
    Hud_RenderHudView();
    Hud_RenderMapView();
    Hud_RenderTacView();
  }
  return;
}

/* ---- Hud_PositionMap__Fv  [HUD.CPP:3980-3993] SLD-VERIFIED ---- */
void Hud_PositionMap(void)
{
  int track;

  gMapScaleX = (int)(fMapScaleX[track = GameSetup_gData.track] * 65536.0f);
  gMapScaleY = (int)(fMapScaleY[track] * 65536.0f);
  gMapOffX = fMapOffX[track];
  if (GameSetup_gData.mirrorTrack != 0) {
    gMapOffX = gMapOffX - 2;
  }
  gMapOffY   = fMapOffY[track];
  gMapRotate = fMapRotate[track];
  mapMarkerMCos = ccos(gMapRotate) << 4;
  mapMarkerMSin = csin(gMapRotate) << 4;
}

/* ---- Hud_BTC_Update__FPcib  [HUD.CPP:3998-4004] SLD-VERIFIED ---- */
void Hud_BTC_Update(char *perpname,int timeleft,bool userHasControl)

{
  
  sprintf(BTC_CurrentPerpName,perpname);
  BTC_UserHasControl = userHasControl;
  if ((BTC_BonusTime == 0) && (HudBustedOverlay == 0)) {
    BTC_Countdown = timeleft << 1;
  }
  return;
}

/* ---- Hud_BustedOverlayOn__FiPcbs  [HUD.CPP:4009-4046] SLD-VERIFIED ---- */
void Hud_BustedOverlayOn(int time,char *name,bool caught,short player)

{
  char *pcVar1;
  int iVar2;
  short *psVar3;
  int iVar4;
  int i;
  
  StatsTimer[player] = 0;
  if (Replay_ReplayMode < 2) {
    psVar3 = Hud_NextPerp + player;
    FinalBTC_Countdown = BTC_Countdown;
    sprintf(BTCPerpInfo[player][*psVar3].name,name);
    if (caught == 0) {
      i = 0;
      iVar4 = 0;
      do {
        psVar3 = Hud_NextPerp + i;
        iVar2 = (int)*psVar3;
        if ((iVar2 == 0) || (*(int *)(BTCPerpInfo[-1][iVar2 + 9].name + iVar4 + 0xc) != 0)) {
          pcVar1 = BTCPerpInfo[0][iVar2].name + iVar4 + 0xc;
          pcVar1[0] = '\0';
          pcVar1[1] = '\0';
          pcVar1[2] = '\0';
          pcVar1[3] = '\0';
          pcVar1 = BTCPerpInfo[0][*psVar3].name + iVar4 + 8;
          pcVar1[0] = '\0';
          pcVar1[1] = '\0';
          pcVar1[2] = '\0';
          pcVar1[3] = '\0';
          sprintf(BTCPerpInfo[0][*psVar3].name + iVar4,BTC_CurrentPerpName);
          *psVar3 = *psVar3 + 1;
        }
        i = i + 1;
        iVar4 = iVar4 + 0xa0;
      } while (i < 2);
    }
    else {
      BTCPerpInfo[player][*psVar3].caught = 1;
      BTCPerpInfo[player][*psVar3].time = time;
      *psVar3 = *psVar3 + 1;
    }
    HudBustedOverlay = 1;
    HudBustedOverlayPlayer = player;
  }
  return;
}

/* ---- Hud_BustedOverlayOff__Fv  [HUD.CPP:4051-4052] SLD-VERIFIED ---- */
void Hud_BustedOverlayOff(void)

{
  HudBustedOverlay = 0;
  return;
}

/* ---- Hud_Reset__Fv  [HUD.CPP:4056-4069] SLD-VERIFIED ---- */
void Hud_Reset(void)

{
  short *psVar1;
  int iVar2;
  int i;

  iVar2 = 0;
  if (Replay_ReplayMode < 2) {
    do {
      Hud_NextPerp[iVar2] = 0;
      iVar2 = iVar2 + 1;
      BTC_CurrentPerpName[0] = '\0';
    } while (iVar2 < 2);
  }
  BTC_BonusTime = 0;
  HudBustedOverlay = 0;
  PerpOverlayOn0 = 0;
  PerpOverlayOn1 = 0;
  BTC_UserHasControl = 0;
  return;
}

/* ---- Hud_BTC_QuitOut__Fv  [HUD.CPP:4074-4086] SLD-VERIFIED ----
 * PASS (49/49). The 2-D truth cracked it: BTCPerpInfo is [2][10], the row stride 0xA0 is a
 * strength-reduced giv of `BTCPerpInfo[slot_i][*perp_idx]` -- writing the natural 2-D accesses
 * (name/caught/time fields) reproduces the sprintf dest grouping AND the s1=s2 giv-init copy
 * that the old flattened row_off form could never reach. */
void Hud_BTC_QuitOut(void)

{
  short *perp_idx;
  tBTCPerpInfo *row_base;
  int row_off;
  int i;
  int slot_i;
  char *name_tail;

  if (HudBustedOverlay == 0) {
    slot_i = 0;
    do {
      perp_idx = Hud_NextPerp + slot_i;
      sprintf(BTCPerpInfo[slot_i][*perp_idx].name,BTC_CurrentPerpName);
      BTCPerpInfo[slot_i][*perp_idx].caught = 0;
      BTCPerpInfo[slot_i][*perp_idx].time = 0;
      *perp_idx = *perp_idx + 1;
      slot_i = slot_i + 1;
    } while (slot_i < 2);
  }
  return;
}

/* ---- Hud_BTC_BonusTime__Fl  [HUD.CPP:4091-4096] SLD-VERIFIED ---- */
void Hud_BTC_BonusTime(long extratime)

{
  BTC_BonusTime = extratime;
  BTC_BonusTimeTick = ticks;
  return;
}

/* ---- Hud_Perp_OverlayOn__Fii  [HUD.CPP:4100-4102] SLD-VERIFIED ---- */
void Hud_Perp_OverlayOn(int player,int level)

{
  *(int *)((player << 2) + (int)PerpOverlayOn) = 1;
  *(int *)((player << 2) + (int)PerpOverlayMessage) = level;
  return;
}

/* ---- Hud_Perp_OverlayOff__Fi  [HUD.CPP:4106-4107] SLD-VERIFIED ---- */
void Hud_Perp_OverlayOff(int player)

{
  int rpm;
  int slice;
  int temp1;
  int offy;
  int speed;
  int sec;
  char *artist;
  char *title;
  int rx;
  int flashTicks;
  int lx;
  char langSec;
  int ten;
  int w7;
  int sin;
  int cos;
  int ox;
  int cenX;
  int cenZ;
  int u;
  int v;
  int yo;

  *(int *)((player << 2) + (int)PerpOverlayOn) = 0;
  return;
}

/* end of hud.cpp */

/* owning-TU def (link-harness) */
int countdownTick_216;
