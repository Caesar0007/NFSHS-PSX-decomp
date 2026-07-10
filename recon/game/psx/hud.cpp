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
int          keepup;   /* @0x8013D900  (bss(zero)) */
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
/* PerpOverlayOn[2] @0x8013de38 (bss(zero)). NEAR-MISS FLOOR note (Hud_Reset__Fv, 8 diffs):
 * the oracle reaches this array's CONSTANT-index [0]/[1] clears as two INDEPENDENT
 * %gp_rel(D_8013DE38)/%gp_rel(D_8013DE3C) 4-byte scalars (each <=G4 -> gp-rel; both listed in
 * configs/gp_rel_symbols.txt), while Hud_Init/Perp_OverlayOn/Off/RenderHudView use runtime-index/
 * pointer-walk/byte-offset and keep absolute array codegen. Our gcc-2.8.0 CSEs the two adjacent
 * constant-index stores onto ONE absolute base (lui+sw+addiu+sw), so GAS -G4 sees one 8-byte
 * object, not two 4-byte ones. Splitting into two tentative-def scalars (weather.cpp
 * Weather_gLastProcessTime0/1 precedent) DOES defeat the CSE and reproduce the per-element gp-rel
 * (8 -> 2 diffs, insn count matches 22/22, 0 verify_asm regressions since .bss isn't byte-compared);
 * the residual 2 is a genuine `lui $a1,%hi(BTC_CurrentPerpName)` HOIST-POSITION scheduling tie
 * (oracle emits it before `lui $v1,%hi(Hud_NextPerp)`, ours after -- not source-reachable). NOT
 * landed: the scalar/array duality needs link-level aliasing verification (do the scalars overlay
 * &PerpOverlayOn[0..1] so Hud_Reset's clears stay runtime-faithful) -- a dedicated data-layout
 * pass, same open "duality to collapse" as weather.cpp. gp_rel_symbols.txt is CORRECT, not stale. */
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

/* ---- Hud_FBuildF4__FiiiiiUlcc  [HUD.CPP:776-795] SLD-VERIFIED ---- */
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
  int iVar1;
  int iVar2;
  int iVar3;
  long splitY;
  int iVar4;
  SPRT *gSprt1;
  int lx;
  int x;
  POLY_FT4 *HudFT4;
  int h1;
  int iVar6;
  int w1;
  int iVar7;
  int h2;
  int iVar8;
  POLY_F4 *HudF4;
  int h3;
  int w2;
  int w3;
  
  gSprt1 = gSprite0;
  if (i != 0) {
    gSprt1 = gSprite1;
  }
  HudF4 = gHudF4;
  if (i != 0) {
    HudF4 = (POLY_F4 *)(short *)((char *)&gHudF4 + 0xa8) /* @0x8013e4f8 */;
  }
  HudFT4 = gHudFT4;
  if (i != 0) {
    HudFT4 = gHudFT4 + 5;
  }
  iVar4 = 0;
  if (i != 0) {
    iVar4 = -0xd;
  }
  iVar6 = (int)HudPmx_gShapes[0xe].height;
  iVar7 = (int)HudPmx_gShapes[0xe].width;
  iVar1 = (int)HudPmx_gShapes[0x14].height;
  iVar2 = (int)HudPmx_gShapes[0x18].width;
  x = (int)g1Player[0xe].x;
  iVar8 = (int)HudPmx_gShapes[0x18].height;
  iVar3 = (int)HudPmx_gShapes[0x14].width;
  if (mode == 1) {
    x = x + -0x1e;
  }
  currentSpriteColor = 0xff5721;
  currentSpriteTransparent = '\0';
  Hud_BuildSprite2(gSprt1 + 0x3f,0xe,x,g1Player[0xe].y + HudMapOffsetY + iVar4);
  Hud_BuildSprite2(gSprt1 + 0x40,0xf,g1Player[0xe].x + iVar7 + iVar3,
             g1Player[0xe].y + HudMapOffsetY + iVar4);
  Hud_BuildSprite2(gSprt1 + 0x41,0x10,x,g1Player[0xe].y + HudMapOffsetY + iVar6 + iVar8 + iVar4);
  Hud_BuildSprite2(gSprt1 + 0x42,0x11,g1Player[0xe].x + iVar7 + iVar3,
             g1Player[0xe].y + HudMapOffsetY + iVar6 + iVar8 + iVar4);
  Hud_BuildSprite2(gSprt1 + 0x43,mode + 0x14,x + iVar7,g1Player[0xe].y + HudMapOffsetY + iVar4);
  Hud_BuildSprite2(gSprt1 + 0x44,mode + 0x14,x + iVar7,
             ((g1Player[0xe].y + HudMapOffsetY + iVar6 * 2 + iVar8) - iVar1) + iVar4);
  Hud_BuildSprite2(gSprt1 + 0x45,0x18,x,g1Player[0xe].y + HudMapOffsetY + iVar6 + iVar4)
  ;
  Hud_BuildSprite2(gSprt1 + 0x46,0x18,((int)g1Player[0xe].x + iVar7 * 2 + iVar3) - iVar2,
             g1Player[0xe].y + HudMapOffsetY + iVar6 + iVar4);
  Hud_BuildF4(HudF4 + 4,1,0,0,0x2d,0x30,0);
  if (GameSetup_gData.mirrorTrack == 0) {
    Hud_BuildFT4(HudFT4,HudPmx_gShapes + 0x78,0,0,0x808080,1);
  }
  else {
    Hud_BuildMapMirrorFT4(HudFT4,HudPmx_gShapes + 0x78,0,0,0x808080,1);
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
  char *pcVar1;
  char cVar2;
  u_char bVar3;
  u_char bVar4;
  u_char bVar5;
  charactertbl *pcVar6;
  int w;
  int c;
  u_int uVar7;
  char langSec;
  char langMin;
  char minSep [6];
  char secSep [6];
  
  pcVar1 = minSep + 3;
  uVar7 = (u_int)pcVar1 & 3;
  *(u_int *)(pcVar1 + -uVar7) =
       *(u_int *)(pcVar1 + -uVar7) & -1 << (uVar7 + 1) * 8 | 0x27273a3aU /* @0x8013d8dc */ >> (3 - uVar7) * 8;
  (*(int *)&(minSep)) = 0x27273a3aU /* @0x8013d8dc */;
  minSep[4] = 0x27 /* @0x8013d8e0 */;
  minSep[5] = 0x2e /* @0x8013d8e1 */;
  pcVar1 = secSep + 3;
  uVar7 = (u_int)pcVar1 & 3;
  *(u_int *)(pcVar1 + -uVar7) =
       *(u_int *)(pcVar1 + -uVar7) & -1 << (uVar7 + 1) * 8 | 0x22223a2eU /* @0x8013d8e4 */ >> (3 - uVar7) * 8;
  (*(int *)&(secSep)) = 0x22223a2eU /* @0x8013d8e4 */;
  secSep[4] = 0x22 /* @0x8013d8e8 */;
  secSep[5] = 0x2c /* @0x8013d8e9 */;
  bVar4 = minSep[GameSetup_gData.userSetting.language];
  bVar5 = secSep[GameSetup_gData.userSetting.language];
  bVar3 = *str;
  while (uVar7 = (u_int)bVar3, uVar7 != 0) {
    if (uVar7 == 0x4d) {
      uVar7 = (u_int)bVar4;
    }
    if (uVar7 == 0x53) {
      uVar7 = (u_int)bVar5;
    }
    pcVar6 = Font_Getcharacter(uVar7);
    cVar2 = pcVar6->advance;
    Hud_BuildSpriteFromFont(sprt,(char)uVar7,x,y);
    str = str + 1;
    x = x + cVar2 + 1;
    sprt = sprt + 1;
    bVar3 = *str;
  }
  return;
}

/* ---- Hud_Init__Fv  [HUD.CPP:930-1153] SLD-VERIFIED ---- */
void Hud_Init(void)

{
  int x;
  short sVar1;
  tSmallCoordXY *ptVar2;
  u_int uVar3;
  int *piVar4;
  int *piVar5;
  char *str;
  int baseY;
  DR_MODE *pDVar6;
  int y;
  DR_MODE *pDVar7;
  int iVar8;
  int iVar9;
  int baseX;
  int j;
  int iVar11;
  int w2;
  int iVar12;
  int w1;
  int iVar13;
  SPRT *gSprt1;
  POLY_G4 *HudG4;
  int iVar15;
  long splitY;
  int i;
  int iVar16;
  u_long textcolour;
  POLY_F4 *HudF4;
  int iStack_30;
  GameSetup_tData *pGStack_2c;
  
  iVar16 = 0;
  iVar13 = 0;
  do {
    j = 0;
    pDVar6 = gTPage0[0];
    pDVar7 = gTPage1[0];
    do {
      SetDrawMode((DR_MODE *)((int)pDVar6->code + iVar13 + -4),0,0,2,(RECT *)0x0);
      SetDrawMode((DR_MODE *)((int)pDVar7->code + iVar13 + -4),0,0,3,(RECT *)0x0);
      pDVar7 = pDVar7 + 1;
      j = j + 1;
      pDVar6 = pDVar6 + 1;
    } while (j < 4);
    iVar16 = iVar16 + 1;
    iVar13 = iVar13 + 0x30;
  } while (iVar16 < 2);
  iStack_30 = 0;
  pGStack_2c = &GameSetup_gData;
  SPRT *spriteReplay;
  int timelapshift;
  for (iVar13 = 0; gSprt1 = gSprite0, iVar13 <= DashHUD_gInfo.splitscreen; iVar13 = iVar13 + 1) {
    if (iVar13 != 0) {
      gSprt1 = gSprite1;
    }
    HudF4 = gHudF4;
    if (iVar13 != 0) {
      HudF4 = gHudF4 + 7;
    }
    HudG4 = gHudG4;
    if (iVar13 != 0) {
      HudG4 = gHudG4 + 4;
    }
    iVar16 = 0;
    if (iVar13 != 0) {
      iVar16 = -0xf;
    }
    j = (u_int)(pGStack_2c->carInfo[0].HudTime == 0) * 0x10;
    if (pGStack_2c->carInfo[0].HudLapnum == 0) {
      j = j + 0x10;
    }
    Hud_BuildSprite(gSprt1,0x68,(int)g1Player->x,(g1Player->y + iVar16) - timelapshift,0xbebe,0);
    currentSpriteColor = 0x808080;
    Hud_BuildSprite2(gSprt1 + 1,0x80,(int)g1Player[1].x,g1Player[1].y + iVar16);
    j = 0x81;
    if (iVar13 != 0) {
      j = 0x83;
    }
    Hud_BuildSprite2(gSprt1 + 2,j,0,0);
    gSprt1[2].w = 0x1c;
    gSprt1[2].h = 0x1c;
    j = (int)HudPmx_gShapes[0x6b].width;
    iVar12 = 0x46;
    if (Hud_BeTheCop != 0) {
      iVar12 = 0x2e;
    }
    sVar1 = g1Player[2].x;
    iVar8 = g1Player[2].y + iVar16;
    Hud_BuildSprite2(gSprt1 + 4,0x69,(int)sVar1,iVar8);
    j = sVar1 + j;
    Hud_BuildG4(HudG4,1,j,iVar8,iVar12,10,0,0x707070,0,0x707070);
    j = j + iVar12;
    Hud_BuildSprite2(gSprt1 + 5,0x7d,timelapshift,iVar8);
    Hud_BuildF4(HudF4,1,j,iVar8 + 7,7,3,0x707070);
    j = (int)HudPmx_gShapes[0x6b].width;
    sVar1 = g1Player[3].x;
    uVar3 = (u_int)(pGStack_2c->carInfo[0].HudTime == 0);
    iVar12 = g1Player[3].y + iVar16 + uVar3 * -0x10;
    Hud_BuildSprite2(gSprt1 + 6,0x6b,(int)sVar1,iVar12);
    j = sVar1 + j;
    Hud_BuildG4(HudG4 + 1,1,j,iVar12,0x1d,10,0,0x707070,0,0x707070);
    j = j + 0x1d;
    Hud_BuildF4(HudF4 + 1,1,j,iVar12 + 7,7,3,0x707070);
    Hud_BuildSprite2(gSprt1 + 7,0x7d,timelapshift,iVar12);
    j = (int)HudPmx_gShapes[0x6b].width;
    sVar1 = g1Player[4].x;
    iVar12 = g1Player[4].y + iVar16;
    Hud_BuildSprite2(gSprt1 + 8,0x69,(int)sVar1,iVar12);
    j = sVar1 + j;
    Hud_BuildG4(HudG4 + 3,1,j,iVar12,0x3c,10,0,0x707070,0,0x707070);
    j = j + 0x3c;
    Hud_BuildF4(HudF4 + 2,1,j,iVar12 + 7,7,3,0x707070);
    Hud_BuildSprite2(gSprt1 + 9,0x7d,timelapshift,iVar12);
    iVar12 = (int)HudPmx_gShapes[0x76].width;
    j = 0x26;
    if ((Hud_BeTheCop == 0) &&
       (j = 0x32, *(int *)((int)GameSetup_gData.checkpointHUD + iStack_30) == 0)) {
      j = 0x3d;
    }
    if (Hud_BeTheCop == 0) {
      iVar8 = (int)g1Player[5].x;
      iVar9 = g1Player[5].y + iVar16;
    }
    else {
      iVar8 = g1Player[2].x + 0xe;
      iVar9 = (int)g1Player[2].y + iVar16 + 0xe;
    }
    Hud_BuildSprite2(gSprt1 + 10,0x76,iVar8,iVar9);
    Hud_BuildG4(HudG4 + 2,1,iVar8 + iVar12,iVar9,j,10,0,0x707070,0,0x707070);
    j = iVar8 + iVar12 + j;
    Hud_BuildF4(HudF4 + 3,1,j,iVar9 + 7,7,3,0x707070);
    Hud_BuildSprite(gSprt1 + 0xb,0x7d,timelapshift,iVar9,0x808080,0);
    currentSpriteColor = 0xa0a0a0;
    Hud_BuildTimeSprites(gSprt1 + 0xc,"00M00S00",(int)g1Player[2].x + (int)g1Player[6].x,
               g1Player[2].y + iVar16 + (int)g1Player[6].y);
    Hud_BuildTimeSprites(gSprt1 + 0x14,"0/0",(int)g1Player[3].x + (int)g1Player[7].x,
               (int)g1Player[3].y + (int)g1Player[7].y + iVar16 + uVar3 * -0x10);
    currentSpriteColor = 0xa0a0a0;
    Hud_BuildTimeSprites(gSprt1 + 0x17,"0M00S00",(int)g1Player[4].x + (int)g1Player[8].x,
               (int)g1Player[4].y + (int)g1Player[8].y + iVar16 + 1);
    if (Hud_BeTheCop == 0) {
      j = (int)g1Player[5].x + (int)g1Player[9].x;
      iVar12 = g1Player[5].y + iVar16 + 1;
    }
    else {
      j = g1Player[2].x + 0x10;
      iVar12 = (int)g1Player[2].y + iVar16 + 0xc;
    }
    if (*(int *)((int)GameSetup_gData.checkpointHUD + iStack_30) == 0) {
      str = "0M00S00";
    }
    else {
      str = "0.000";
    }
    spriteReplay = gSprt1 + 0x1e;
    Hud_BuildTimeSprites(spriteReplay,str,j + HudPmx_gShapes[0x76].width,iVar12)
    ;
    *(int *)((int)HudSplitTimeDiff1 + iStack_30) = (int)gSprt1[0x1f].y0 - (int)gSprt1[0x1e].y0;
    ptVar2 = g1Player;
    currentSpriteColor = 0xa0a0a0;
    *(int *)((int)HudSplitTimeDiff2 + iStack_30) = (int)gSprt1[0x22].y0 - (int)gSprt1[0x1e].y0;
    iVar9 = (int)HudPmx_gShapes[0x2c].width;
    iVar8 = (int)HudPmx_gShapes[0x47].width;
    j = (int)ptVar2[0xe].x + (int)ptVar2[10].x;
    iVar12 = ptVar2[0xe].y + HudMapOffsetY + (int)ptVar2[10].y + iVar16;
    if ((iVar13 == 0) && (DashHUD_gInfo.splitscreen != 0)) {
      iVar12 = iVar12 + -2;
    }
    iVar11 = 0;
    iVar15 = 0x334;
    Hud_BuildSprite(gSprt1 + 0x28,0x3e,g1Player[0xe].x + 0x13,iVar12 + -1,0x808080,0);
    Hud_BuildSprite2(gSprt1 + 0x25,0x2c,j,iVar12);
    j = j + iVar9;
    Hud_BuildSprite2(gSprt1 + 0x26,0x47,j,iVar12);
    Hud_BuildSprite2(gSprt1 + 0x27,0x36,j + iVar8,iVar12);
    currentSpriteColor = 0x808080;
    j = (int)g1Player[1].x + (int)g1Player[0xb].x;
    iVar16 = (int)g1Player[1].y + (int)g1Player[0xb].y + iVar16;
    Hud_BuildSprite2(gSprt1 + 0x31,0x1a,j + -1,iVar16);
    Hud_BuildSprite2(gSprt1 + 0x32,0x1b,j + -2,iVar16 + -1);
    do {
      Hud_BuildSprite2((SPRT *)((int)&gSprt1->tag + iVar15),iVar11 + 0x1c,j + 2,iVar16 + 6);
      iVar11 = iVar11 + 1;
      iVar15 = iVar15 + 0x14;
    } while (iVar11 < 8);
    Hud_InitMapFrame(iVar13,0);
    iStack_30 = iStack_30 + 4;
    pGStack_2c = (GameSetup_tData *)((pGStack_2c->controllerData).shockImpact + 1);
  }
  j = 0;
  currentSpriteColor = 0x808080;
  currentSpriteTransparent = '\x01';
  iVar16 = (int)g1Player[0xd].x;
  iVar13 = (int)g1Player[0xd].y;
  Hud_BuildSprite2(gSprite0 + 0x37,0x6f,iVar16,iVar13);
  Hud_BuildSprite2(gSprt1 + 0x33,0x6c,iVar16 + 0x12,iVar13);
  Hud_BuildSprite2(gSprt1 + 0x34,0x6e,iVar16 + 0x25,iVar13);
  Hud_BuildSprite2(gSprt1 + 0x35,0x3f,iVar16 + 0x3a,iVar13);
  Hud_BuildSprite2(gSprt1 + 0x38,0x72,iVar16 + 0x4a,iVar13);
  Hud_BuildSprite2(gSprt1 + 0x36,0,iVar16 + 0x6d,iVar13 + -7);
  Hud_BuildSprite2(gSprt1 + 0x39,3,0,iVar13 + 4);
  currentSpriteTransparent = '\0';
  Hud_InitCdPlayer();
  Hud_Reset();
  piVar5 = PerpOverlayMessage;
  piVar4 = PerpOverlayOn;
  BTC_BonusTime = 0;
  BTC_Countdown = 0;
  FinalBTC_Countdown = 0;
  BTC_UserHasControl = 0;
  HudBustedOverlay = 0;
  do {
    *piVar4 = 0;
    *piVar5 = 0;
    piVar5 = piVar5 + 1;
    j = j + 1;
    piVar4 = piVar4 + 1;
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
  u_char uVar1;
  u_short uVar2;
  int temp2;
  HudPmx_tUV *pHVar3;
  int uv_pack;
  int tens_digit;
  int ones_idx;
  HudPmx_tUV *pHVar4;
  int ones_digit;
  int tpage_pack;
  int tens_idx;
  int temp1;
  int min;
  int sec_glyph;
  int sec;
  int min_glyph;
  
  if (time < 0) {
    time = 0;
  }
  if (time < 0) {
    time = -time;
  }
  temp2 = time;
  if (time < 0) {
    temp2 = time + 0x3f;
  }
  temp1 = temp2 >> 6;
  min_glyph = (time + temp1 * -0x40) * 100;
  sec_glyph = (temp1 / 0x3c) % 0x3c;
  if (min_glyph < 0) {
    min_glyph = min_glyph + 0x3f;
  }
  pHVar4 = HudPmx_gHudNumberUV + sec_glyph / 10;
  uVar1 = pHVar4->v0;
  uVar2 = pHVar4->clut;
  pHVar3 = HudPmx_gHudNumberUV + sec_glyph % 10;
  sprt->u0 = pHVar4->u0;
  sprt->v0 = uVar1;
  sprt->clut = uVar2;
  uVar1 = pHVar3->v0;
  uVar2 = pHVar3->clut;
  sprt[1].u0 = pHVar3->u0;
  sprt[1].v0 = uVar1;
  sprt[1].clut = uVar2;
  pHVar4 = HudPmx_gHudNumberUV + (temp1 % 0x3c) / 10;
  uVar1 = pHVar4->v0;
  uVar2 = pHVar4->clut;
  pHVar3 = HudPmx_gHudNumberUV + (temp1 % 0x3c) % 10;
  sprt[3].u0 = pHVar4->u0;
  sprt[3].v0 = uVar1;
  sprt[3].clut = uVar2;
  uVar1 = pHVar3->v0;
  uVar2 = pHVar3->clut;
  sprt[4].u0 = pHVar3->u0;
  sprt[4].v0 = uVar1;
  sprt[4].clut = uVar2;
  int hun = min_glyph >> 6;
  pHVar3 = HudPmx_gHudNumberUV + hun / 10;
  uVar1 = pHVar3->v0;
  uVar2 = pHVar3->clut;
  pHVar4 = HudPmx_gHudNumberUV + hun % 10;
  sprt[6].u0 = pHVar3->u0;
  sprt[6].v0 = uVar1;
  sprt[6].clut = uVar2;
  uVar1 = pHVar4->v0;
  uVar2 = pHVar4->clut;
  sprt[7].u0 = pHVar4->u0;
  sprt[7].v0 = uVar1;
  sprt[7].clut = uVar2;
  return;
}

/* ---- Hud_BuildDistanceString__FP4SPRTi  [HUD.CPP:1253-1269] SLD-VERIFIED ---- */
void * Hud_BuildDistanceString(SPRT *sprt,int player)

{
  u_char uVar1;
  u_short uVar2;
  int dist_alt;
  int uv_thou;
  int uv_hund;
  int uv_tens;
  int slices;
  int raw_cp;
  int uv_ones;
  HudPmx_tUV *pHVar3;
  int dist;
  
  raw_cp = (Cars_gHumanRaceCarList[player]->stats).checkpointUpdate;
  dist_alt = raw_cp * 6;
  if (dist_alt < 0) {
    dist_alt = raw_cp * -6;
  }
  if (GameSetup_gData.checkpointHUD[player] == 2) {
    dist_alt = (dist_alt * 1000) / 0x647;
  }
  if (dist_alt < 10000) {
    pHVar3 = HudPmx_gHudNumberUV + dist_alt / 1000;
    uVar1 = pHVar3->v0;
    uVar2 = pHVar3->clut;
    sprt->u0 = pHVar3->u0;
    sprt->v0 = uVar1;
    sprt->clut = uVar2;
    pHVar3 = HudPmx_gHudNumberUV + (dist_alt % 1000) / 100;
    uVar1 = pHVar3->v0;
    uVar2 = pHVar3->clut;
    sprt[2].u0 = pHVar3->u0;
    sprt[2].v0 = uVar1;
    sprt[2].clut = uVar2;
    pHVar3 = HudPmx_gHudNumberUV + (dist_alt % 100) / 10;
    uVar1 = pHVar3->v0;
    uVar2 = pHVar3->clut;
    sprt[3].u0 = pHVar3->u0;
    sprt[3].v0 = uVar1;
    sprt[3].clut = uVar2;
    pHVar3 = HudPmx_gHudNumberUV + dist_alt % 10;
    uVar1 = pHVar3->v0;
    uVar2 = pHVar3->clut;
    sprt[4].u0 = pHVar3->u0;
    sprt[4].v0 = uVar1;
    sprt[4].clut = uVar2;
    return (void *)0x1;
  }
  return (void *)0x0;
}

/* ---- Hud_BuildTimeString__FP4SPRTi  [HUD.CPP:1273-1288] SLD-VERIFIED ---- */
void Hud_BuildTimeString(SPRT *sprt,int time)

{
  u_char uVar1;
  u_short uVar2;
  HudPmx_tUV *pHVar3;
  int tens_digit;
  int uv_pack;
  int ones_idx;
  int tpage_pack;
  int tens_idx;
  int temp1;
  HudPmx_tUV *pHVar4;
  int ones_digit;
  int temp2;
  int hun;
  int sec;
  int sec_glyph;
  
  if (time < 0) {
    time = -time;
  }
  temp2 = time;
  if (time < 0) {
    temp2 = time + 0x3f;
  }
  temp1 = temp2 >> 6;
  sec_glyph = (time + temp1 * -0x40) * 100;
  if (sec_glyph < 0) {
    sec_glyph = sec_glyph + 0x3f;
  }
  int min = temp1 / 0x3c;
  pHVar3 = HudPmx_gHudNumberUV + min % 10;
  uVar1 = pHVar3->v0;
  uVar2 = pHVar3->clut;
  sprt->u0 = pHVar3->u0;
  sprt->v0 = uVar1;
  sprt->clut = uVar2;
  pHVar4 = HudPmx_gHudNumberUV + (temp1 % 0x3c) / 10;
  uVar1 = pHVar4->v0;
  uVar2 = pHVar4->clut;
  pHVar3 = HudPmx_gHudNumberUV + (temp1 % 0x3c) % 10;
  sprt[2].u0 = pHVar4->u0;
  sprt[2].v0 = uVar1;
  sprt[2].clut = uVar2;
  uVar1 = pHVar3->v0;
  uVar2 = pHVar3->clut;
  sprt[3].u0 = pHVar3->u0;
  sprt[3].v0 = uVar1;
  sprt[3].clut = uVar2;
  pHVar3 = HudPmx_gHudNumberUV + (sec_glyph >> 6) / 10;
  uVar1 = pHVar3->v0;
  uVar2 = pHVar3->clut;
  pHVar4 = HudPmx_gHudNumberUV + (sec_glyph >> 6) % 10;
  sprt[5].u0 = pHVar3->u0;
  sprt[5].v0 = uVar1;
  sprt[5].clut = uVar2;
  uVar1 = pHVar4->v0;
  uVar2 = pHVar4->clut;
  sprt[6].u0 = pHVar4->u0;
  sprt[6].v0 = uVar1;
  sprt[6].clut = uVar2;
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
  
  if (player == 0) {
    gSprt1 = gSprite0;
  }
  else {
    gSprt1 = gSprite1;
  }
  rpm_norm = GameSetup_gData.carInfo[player].carType;
  carType = 0x1d;
  if (rpm_norm < 0x1e) {
    carType = rpm_norm;
  }
  if (GameSetup_gData.Time == 0) {
    tachShape_p = (int)day_needle;
  }
  else {
    tachShape_p = (int)night_needle;
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
  if (player == 0) {
    tachNeedle_p = -0x7feee954;
  }
  else {
    tachNeedle_p = -0x7feee92c;
  }
  needle_idx = *(int *)tachNeedle_p;
  needle_y = fixedmult(cos,0x1d);
  needle_x = fixedmult(sin,0x1d);
  color_pack = needle_y + 0x1d;
  if (player != 0) {
    color_pack = needle_y + 0x75;
  }
  uVar1 = needle_idx & 0xffff0000U | (needle_x + 0x9d) * 0x100 | color_pack;
  gSprt1[2].u0 = (char)uVar1;
  gSprt1[2].v0 = (char)(uVar1 >> 8);
  gSprt1[2].clut = (short)(uVar1 >> 0x10);
  lookupResult = fixedmult(cos,10);
  cos1 = lookupResult + 0xe;
  fangle_norm = fixedmult(sin,10);
  prim = Render_gPacketPtr;
  tp1 = Render_gPalettePtr;
  ti2 = fangle_norm + 0xe;
  tp9 = Render_gPacketPtr + 0x14;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
  *(u_int *)(Render_gPacketPtr + 0x14) =
       *(u_int *)(Render_gPacketPtr + 0x14) & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x24;
  *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | (u_int)tp9 & 0xffffff;
  prim[0x17] = 3;
  *(short *)(prim + 0x1c) = 0xe - (short)needle_y;
  *(u_long *)(prim + 0x18) = color + 0x484848 | 0x42000000;
  *(short *)(prim + 0x1e) = 0xe - (short)needle_x;
  *(short *)(prim + 0x22) = (short)ti2;
  *(u_short *)(prim + 0x20) = (u_short)cos1;
  prim2 = Render_gPacketPtr;
  tp2 = Render_gPalettePtr;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  needle_idx2 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x14;
  *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | needle_idx2;
  Hud_BuildF3((POLY_F3 *)prim,HudPmx_gShapes + 0x82,cos1,ti2,color);
  Hud_BuildF3((POLY_F3 *)prim2,HudPmx_gShapes + 0x82,cos1,ti2,0);
  prim[7] = prim[7] & 0xfd;
  fixedsincos(arg1_00 + -0x200,&sin,&cos);
  ti2 = fixedmult(cos,0x20);
  ts3 = 0xe - (short)ti2;
  *(short *)(prim + 0xc) = ts3;
  *(short *)(prim2 + 0xc) = ts3;
  ti2 = fixedmult(sin,0x20);
  ts4 = 0xe - (short)ti2;
  *(short *)(prim + 0xe) = ts4;
  *(short *)(prim2 + 0xe) = ts4;
  fixedsincos(arg1_00 + 0x200,&sin,&cos);
  ti2 = fixedmult(cos,0x20);
  ts1 = 0xe - (short)ti2;
  *(short *)(prim + 0x10) = ts1;
  *(short *)(prim2 + 0x10) = ts1;
  ti2 = fixedmult(sin,0x20);
  ts1 = -(short)ti2 + 0xe;
  *(short *)(prim + 0x12) = ts1;
  *(short *)(prim2 + 0x12) = ts1;
  tp3 = Render_gPalettePtr;
  *(short *)(prim2 + 10) = *(short *)(prim2 + 10) + 2;
  *(short *)(prim2 + 0x12) = -(short)ti2 + 0x10;
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
  u_int uVar3;
  int iVar4;
  int offy;
  char alphShape;
  u_char bVar5;
  int ix;
  int i;
  int ox;
  int numch;
  
  Hud_GoTpage(1);
  uVar3 = strlen(str);
  i = 0;
  ix = x;
  do {
    if ((int)uVar3 <= i) {
      Hud_GoTpage(0);
      return ix - x;
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
              iVar4 = (int)HudPmx_gShapes[0xad].width;
              ix = ix + 3;
            }
            else {
              if (justwidth == 0) {
                Hud_FBuildSprite(0xaa,ix,y,color,0);
              }
              iVar4 = (int)HudPmx_gShapes[0xaa].width;
              ix = ix + 3;
            }
            goto HudBuildStr_accumWidth;
          }
        }
        else if (gPadinfo.buf[0].ID == '#') goto HudBuildStr_hashMarker;
      }
    }
    else {
      iVar4 = 0;
      if (cVar1 == '^') {
        bVar5 = 0xaa;
        if (gPadinfo.buf[player * 4].ID == '#') {
          bVar5 = 0xad;
        }
      }
      else if (cVar1 == '(') {
        bVar5 = 0xa9;
        if (gPadinfo.buf[player * 4].ID == '#') {
          bVar5 = 0xab;
        }
      }
      else if (cVar1 == ')') {
        bVar5 = 0xa8;
        if (gPadinfo.buf[player * 4].ID == '#') {
          bVar5 = 0xac;
        }
      }
      else if (cVar1 == '&') {
        bVar5 = 0xae;
      }
      else {
        bVar5 = cVar1 + 0x6e;
        if (9 < (u_char)(cVar1 - 0x30U)) {
          if (cVar1 == '-') {
            bVar5 = 0x48;
          }
          else if (cVar1 == ':') {
            bVar5 = 0x49;
          }
          else {
            bVar5 = cVar1 + 0x8a;
            if ((u_char)(cVar1 + 0x40U) < 0x1d) {
              iVar4 = -1;
            }
            else {
              bVar5 = *str + 0x43;
              if (*str == -0x1b) {
                bVar5 = 0x67;
                iVar4 = -1;
              }
            }
          }
        }
      }
      if (justwidth == 0) {
        Hud_FBuildSprite((u_int)bVar5,ix,y + iVar4,color,0);
      }
      iVar4 = (int)HudPmx_gShapes[bVar5].width;
      ix = ix + 1;
HudBuildStr_accumWidth:
      ix = ix + iVar4;
    }
    str = str + 1;
    i = i + 1;
  } while( true );
}

/* ---- Hud_BuildNumbers0__Fi  [HUD.CPP:1551-1712] SLD-VERIFIED ---- */
void Hud_BuildNumbers0(int player)

{
  int y;
  short spritePos_y;
  short scoreVal_short;
  int scoreVal_p;
  short sVar1;
  short sVar2;
  int iVar3;
  int digit_dst;
  u_int *digit_dst_b;
  int sprt_dst_a;
  int j;
  int digit_count;
  int value_remain;
  int primAddr;
  int splitY;
  SPRT *sprt;
  int i;
  int sprt_iter;
  int pSprt;
  int HudG4;
  int HudF4;
  int totalDigits;
  int totalDigits_2;
  u_int tpage_pack;
  int loc_28;
  int loc_24;
  int loc_20;
  int loc_1c;
  int loc_18;
  int loc_14;
  int loc_10;
  int loc_c;
  u_char *tp1;
  u_char *tp3;
  u_char *tp2;
  u_char *tp4;
  u_char bVar1;
  u_char *tp6;
  
  pSprt = (int)gSprite0;
  if (player != 0) {
    pSprt = (int)gSprite1;
  }
  HudF4 = (int)gHudF4;
  if (player != 0) {
    HudF4 = (int)(gHudF4 + 7);
  }
  HudG4 = (int)gHudG4;
  if (player != 0) {
    HudG4 = (int)(gHudG4 + 4);
  }
  spritePos_y = 0;
  if (player != 0) {
    spritePos_y = -0xf;
  }
  if (GameSetup_gData.carInfo[player].HudTime != 0) {
    if ((DashHUD_gInfo.flashtime == 0) || ((simGlobal.gameTicks & 0x10U) == 0)) {
      iVar3 = DashHUD_gInfo.laptime;
      if (Hud_BeTheCop != 0) {
        iVar3 = BTC_Countdown;
      }
      Hud_BuildETimeString((SPRT *)(pSprt + 0xf0),iVar3);
    }
    tp2 = Render_gPalettePtr;
    int num;
    num = 8;
    if (Hud_BeTheCop != 0) {
      num = 5;
    }
    digit_count = 0xc;
    if (0xc < num + 0xcU) {
      digit_dst = pSprt + 0xf0;
      do {
        digit_count = digit_count + 1;
        *(u_int *)digit_dst = *(u_int *)digit_dst & 0xff000000 | *(u_int *)tp2 & 0xffffff;
        *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | digit_dst & 0xffffffU;
        digit_dst = digit_dst + 0x14;
      } while (digit_count < (int)(num + 0xcU));
    }
    tp4 = Render_gPalettePtr;
    value_remain = 4;
    digit_dst_b = (u_int *)(pSprt + 0x50);
    do {
      value_remain = value_remain + 1;
      *digit_dst_b = *digit_dst_b & 0xff000000 | *(u_int *)tp4 & 0xffffff;
      *(u_int *)tp4 = *(u_int *)tp4 & 0xff000000 | (u_int)digit_dst_b & 0xffffff;
      tp3 = Render_gPalettePtr;
      digit_dst_b = digit_dst_b + 5;
    } while (value_remain < 6);
    ((POLY_G4 *)HudG4)->tag =
         (u_long *)
         ((u_int)((POLY_G4 *)HudG4)->tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff);
    *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | HudG4 & 0xffffffU;
    ((POLY_F4 *)HudF4)->tag =
         (u_long *)((u_int)((POLY_F4 *)HudF4)->tag & 0xff000000 | HudG4 & 0xffffffU);
    *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | HudF4 & 0xffffffU;
  }
  if (Hud_BeTheCop == 0) {
    sVar1 = g1Player[5].y + spritePos_y + g1Player[9].y;
    scoreVal_short = sVar1 + 10;
    *(short *)(pSprt + 0xd2) = sVar1;
    ((POLY_G4 *)(HudG4 + 0x48))->y0 = sVar1;
    ((POLY_G4 *)(HudG4 + 0x48))->y1 = sVar1;
    ((POLY_G4 *)(HudG4 + 0x48))->y2 = scoreVal_short;
    ((POLY_G4 *)(HudG4 + 0x48))->y3 = scoreVal_short;
    *(short *)(pSprt + 0xe6) = sVar1;
    sVar2 = sVar1 + 1;
    ((POLY_F4 *)(HudF4 + 0x48))->y0 = sVar1 + 7;
    ((POLY_F4 *)(HudF4 + 0x48))->y1 = sVar1 + 7;
    ((POLY_F4 *)(HudF4 + 0x48))->y2 = scoreVal_short;
    ((POLY_F4 *)(HudF4 + 0x48))->y3 = scoreVal_short;
    *(short *)(pSprt + 0x262) = sVar2;
    iVar3 = HudSplitTimeDiff1[player];
    *(short *)(pSprt + 0x28a) = sVar2;
    *(short *)(pSprt + 0x29e) = sVar2;
    *(short *)(pSprt + 0x276) = (short)iVar3 + sVar2;
    iVar3 = HudSplitTimeDiff2[player];
    *(short *)(pSprt + 0x2c6) = sVar2;
    *(short *)(pSprt + 0x2da) = sVar2;
    *(short *)(pSprt + 0x2b2) = (short)iVar3 + sVar2;
  }
  primAddr = BTC_BonusTime;
  if ((BTC_BonusTime == 0) || (Hud_BeTheCop == 0)) {
    if (GameSetup_gData.checkpointType == 0) {
      return;
    }
    if (GameSetup_gData.checkpointHUD[player] == 0) {
      if ((Cars_gHumanRaceCarList[player]->stats).checkpointDisplay < 1) {
        return;
      }
      iVar3 = (Cars_gHumanRaceCarList[player]->stats).checkpointDifference;
      if (iVar3 < -0x95ff) {
        return;
      }
      if (0x95ff < iVar3) {
        return;
      }
      if (Hud_BeTheCop != 0) {
        return;
      }
      if (DashHUD_gInfo.wrongway[player] != 0) {
        return;
      }
      if (iVar3 < 0) {
        *(u_int *)(pSprt + 0xd4) = (*(int *)&(HudPmx_gShapes[0x77].pixmap));
      }
      else {
        *(u_int *)(pSprt + 0xd4) = (*(int *)&(HudPmx_gShapes[0x76].pixmap));
      }
      sprt = (SPRT *)(pSprt + 600);
      iVar3 = 0x1e;
      Hud_BuildTimeString(sprt,(Cars_gHumanRaceCarList[player]->stats).checkpointDifference);
      tp6 = Render_gPalettePtr;
      do {
        iVar3 = iVar3 + 1;
        sprt->tag = (u_long *)((u_int)sprt->tag & 0xff000000 | *(u_int *)tp6 & 0xffffff);
        *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)sprt & 0xffffff;
        sprt = sprt + 1;
      } while (iVar3 < 0x25);
      iVar3 = 10;
      digit_dst_b = (u_int *)(pSprt + 200);
      totalDigits_2 = (u_int)digit_dst_b & 0xffffff;
      do {
        tp6 = Render_gPalettePtr;
        if (iVar3 == 10) {
          Hud_GoTpage(0);
          tp6 = Render_gPalettePtr;
          *(u_int *)(pSprt + 200) =
               *(u_int *)(pSprt + 200) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
          *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | totalDigits_2;
          Hud_GoTpage(1);
        }
        else {
          *digit_dst_b = *digit_dst_b & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
          *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)digit_dst_b & 0xffffff;
        }
        digit_dst_b = digit_dst_b + 5;
        iVar3 = iVar3 + 1;
      } while (iVar3 < 0xc);
    }
    else {
      scoreVal_p = (int)Hud_BuildDistanceString((SPRT *)(pSprt + 600),player);
      if (scoreVal_p == 0) {
        return;
      }
      if ((Cars_gHumanRaceCarList[player]->stats).checkpointUpdate < 0) {
        *(u_int *)(pSprt + 0xd4) = (*(int *)&(HudPmx_gShapes[0x77].pixmap));
      }
      else {
        *(u_int *)(pSprt + 0xd4) = (*(int *)&(HudPmx_gShapes[0x76].pixmap));
      }
      tp6 = Render_gPalettePtr;
      iVar3 = 0x1e;
      sprt_dst_a = pSprt + 600;
      do {
        iVar3 = iVar3 + 1;
        *(u_int *)sprt_dst_a = *(u_int *)sprt_dst_a & 0xff000000 | *(u_int *)tp6 & 0xffffff;
        *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | sprt_dst_a & 0xffffffU;
        sprt_dst_a = sprt_dst_a + 0x14;
      } while (iVar3 < 0x23);
      iVar3 = 10;
      digit_dst_b = (u_int *)(pSprt + 200);
      tpage_pack = (u_int)digit_dst_b & 0xffffff;
      do {
        tp6 = Render_gPalettePtr;
        if (iVar3 == 10) {
          Hud_GoTpage(0);
          tp6 = Render_gPalettePtr;
          *(u_int *)(pSprt + 200) =
               *(u_int *)(pSprt + 200) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
          *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | tpage_pack;
          Hud_GoTpage(1);
        }
        else {
          *digit_dst_b = *digit_dst_b & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
          *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)digit_dst_b & 0xffffff;
        }
        digit_dst_b = digit_dst_b + 5;
        iVar3 = iVar3 + 1;
      } while (iVar3 < 0xc);
    }
  }
  else {
    if (GameSetup_gData.carInfo[player].HudTime == 0) {
      return;
    }
    sprt_iter = pSprt + 600;
    bVar1 = BTC_BonusTime < 0;
    *(u_int *)(pSprt + 0xd4) = (*(int *)&(HudPmx_gShapes[0x76].pixmap));
    if ((bool)bVar1) {
      primAddr = 0;
    }
    Hud_BuildTimeString((SPRT *)sprt_iter,primAddr);
    tp1 = Render_gPalettePtr;
    iVar3 = 0x1e;
    do {
      iVar3 = iVar3 + 1;
      *(u_int *)sprt_iter = *(u_int *)sprt_iter & 0xff000000 | *(u_int *)tp1 & 0xffffff;
      *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | sprt_iter & 0xffffffU;
      sprt_iter = sprt_iter + 0x14;
    } while (iVar3 < 0x22);
    iVar3 = 10;
    digit_dst_b = (u_int *)(pSprt + 200);
    totalDigits = (u_int)digit_dst_b & 0xffffff;
    do {
      tp6 = Render_gPalettePtr;
      if (iVar3 == 10) {
        Hud_GoTpage(0);
        tp6 = Render_gPalettePtr;
        *(u_int *)(pSprt + 200) =
             *(u_int *)(pSprt + 200) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | totalDigits;
        Hud_GoTpage(1);
      }
      else {
        *digit_dst_b = *digit_dst_b & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)digit_dst_b & 0xffffff;
      }
      digit_dst_b = digit_dst_b + 5;
      iVar3 = iVar3 + 1;
    } while (iVar3 < 0xc);
  }
  tp6 = Render_gPalettePtr;
  ((POLY_G4 *)(HudG4 + 0x48))->tag =
       (u_long *)
       ((u_int)((POLY_G4 *)(HudG4 + 0x48))->tag & 0xff000000 |
       *(u_int *)Render_gPalettePtr & 0xffffff);
  *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)(HudG4 + 0x48) & 0xffffff;
  ((POLY_F4 *)(HudF4 + 0x48))->tag =
       (u_long *)
       ((u_int)((POLY_F4 *)(HudF4 + 0x48))->tag & 0xff000000 | (u_int)(HudG4 + 0x48) & 0xffffff);
  *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)(HudF4 + 0x48) & 0xffffff;
  return;
}

/* ---- Hud_BuildNumbers__Fi  [HUD.CPP:1721-1897] SLD-VERIFIED ---- */
void Hud_BuildNumbers(int player)

{
  int x;
  int uv_byte_pack;
  int uv_byte_pack_b;
  int tpage_word;
  u_int tpage_word_b;
  int color_pack;
  int tSs8;
  int y_00;
  u_int *tp1;
  int digit_iter_b;
  int j;
  int value_remain;
  int digit_iter;
  int digit_value;
  int speed;
  int tu11;
  int iVar1;
  int iVar2;
  int hun;
  int HudG4;
  POLY_GT4 *prim;
  int HudF4;
  int ti14;
  int iVar3;
  int w1;
  int iVar4;
  int w2;
  int iVar5;
  int pSprt;
  int ten;
  int splitY;
  int ti17;
  int w7;
  int i;
  int y;
  int w3;
  int color2;
  u_long SpeedColor;
  u_char *tp3;
  int ti2;
  u_char *tp8;
  u_char *tp7;
  u_char *tp9;
  short ts2;
  short ts3;
  u_char *tp6;
  u_char *tp5;
  u_char *tp4;
  short ts1;
  u_char *tp11;
  u_char *tp2;
  
  pSprt = (int)gSprite0;
  if (player != 0) {
    pSprt = (int)gSprite1;
  }
  HudF4 = (int)gHudF4;
  if (player != 0) {
    HudF4 = -0x7fec1b08;
  }
  HudG4 = (int)gHudG4;
  if (player != 0) {
    HudG4 = -0x7fec1840;
  }
  splitY = 0;
  if (player != 0) {
    splitY = -0xf;
  }
  if (((GameSetup_gData.carInfo[player].HudLapnum != 0) && (Hud_BeTheCop == 0)) &&
     (value_remain = 0x14, DashHUD_gInfo.maxlaps != 1)) {
    uv_byte_pack = *(int *)(HudPmx_gHudNumberUV + DashHUD_gInfo.lap);
    *(int *)(pSprt + 0x19c) = uv_byte_pack;
    uv_byte_pack_b = *(int *)(HudPmx_gHudNumberUV + DashHUD_gInfo.maxlaps);
    tp1 = (u_int *)(pSprt + 400);
    *(int *)(pSprt + 0x1c4) = uv_byte_pack_b;
    tp7 = Render_gPalettePtr;
    do {
      value_remain = value_remain + 1;
      *tp1 = *tp1 & 0xff000000 | *(u_int *)tp7 & 0xffffff;
      *(u_int *)tp7 = *(u_int *)tp7 & 0xff000000 | (u_int)tp1 & 0xffffff;
      tp8 = Render_gPalettePtr;
      tp1 = tp1 + 5;
    } while (value_remain < 0x17);
    digit_iter = 6;
    tp1 = (u_int *)(pSprt + 0x78);
    do {
      digit_iter = digit_iter + 1;
      *tp1 = *tp1 & 0xff000000 | *(u_int *)tp8 & 0xffffff;
      *(u_int *)tp8 = *(u_int *)tp8 & 0xff000000 | (u_int)tp1 & 0xffffff;
      tp5 = Render_gPalettePtr;
      tp1 = tp1 + 5;
    } while (digit_iter < 8);
    *(u_int *)(HudG4 + 0x24) =
         *(u_int *)(HudG4 + 0x24) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    tpage_word = HudG4 + 0x24U & 0xffffff;
    *(u_int *)tp5 = *(u_int *)tp5 & 0xff000000 | tpage_word;
    *(u_int *)(HudF4 + 0x18) = *(u_int *)(HudF4 + 0x18) & 0xff000000 | tpage_word;
    *(u_int *)tp5 = *(u_int *)tp5 & 0xff000000 | HudF4 + 0x18U & 0xffffff;
  }
  if ((((GameSetup_gData.carInfo[player].HudTime != 0) && (DashHUD_gInfo.record != 0)) &&
      ((DashHUD_gInfo.record < 0x9600 && ((Hud_BeTheCop == 0 && (Hud_gShowedCDPlayer == 0)))))) &&
     (DashHUD_gInfo.maxlaps != 1)) {
    if ((DashHUD_gInfo.flashtime == 0) || ((simGlobal.gameTicks & 0x10U) == 0)) {
      Hud_BuildTimeString((SPRT *)(pSprt + 0x1cc),DashHUD_gInfo.record);
    }
    tp3 = Render_gPalettePtr;
    digit_iter_b = 0x17;
    tp1 = (u_int *)(pSprt + 0x1cc);
    do {
      digit_iter_b = digit_iter_b + 1;
      *tp1 = *tp1 & 0xff000000 | *(u_int *)tp3 & 0xffffff;
      *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | (u_int)tp1 & 0xffffff;
      tp6 = Render_gPalettePtr;
      tp1 = tp1 + 5;
    } while (digit_iter_b < 0x1e);
    digit_iter_b = 8;
    tp1 = (u_int *)(pSprt + 0xa0);
    do {
      digit_iter_b = digit_iter_b + 1;
      *tp1 = *tp1 & 0xff000000 | *(u_int *)tp6 & 0xffffff;
      *(u_int *)tp6 = *(u_int *)tp6 & 0xff000000 | (u_int)tp1 & 0xffffff;
      tp2 = Render_gPalettePtr;
      tp1 = tp1 + 5;
    } while (digit_iter_b < 10);
    *(u_int *)(HudG4 + 0x6c) =
         *(u_int *)(HudG4 + 0x6c) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    tpage_word_b = HudG4 + 0x6cU & 0xffffff;
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tpage_word_b;
    *(u_int *)(HudF4 + 0x30) = *(u_int *)(HudF4 + 0x30) & 0xff000000 | tpage_word_b;
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | HudF4 + 0x30U & 0xffffff;
  }
  if (((GameSetup_gData.carInfo[player].HudPosition != 0) && (Hud_BeTheCop == 0)) &&
     (1 < DashHUD_gInfo.opponents)) {
    *(short *)(pSprt + 0x2ec) =
         (g1Player[0xe].x + g1Player[10].x + HudPmx_gShapes[0x2c].width + -2) -
         HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;
    color_pack = *(int *)&HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].pixmap;
    *(int *)(pSprt + 0x2f0) = color_pack;
    *(short *)(pSprt + 0x2f4) = HudPmx_gShapes[DashHUD_gInfo.position + 0x2c].width;
    *(u_int *)(pSprt + 0x318) =
         *(u_int *)&HudPmx_gShapes[DashHUD_gInfo.opponents + 0x35].pixmap;
    tp2 = Render_gPalettePtr;
    tp1 = (u_int *)(pSprt + 0x2e4);
    *(short *)(pSprt + 0x31c) = HudPmx_gShapes[DashHUD_gInfo.opponents + 0x35].width;
    digit_value = 0x25;
    do {
      digit_value = digit_value;
      digit_value = digit_value + 1;
      *tp1 = *tp1 & 0xff000000 | *(u_int *)tp2 & 0xffffff;
      *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | (u_int)tp1 & 0xffffff;
      tp1 = tp1 + 5;
    } while (digit_value < 0x28);
    if (GameSetup_gData.carInfo[digit_value + 1].HudMap != 0) {
      Hud_GoTpage(0);
      tp2 = Render_gPalettePtr;
      *(u_int *)(pSprt + 800) =
           *(u_int *)(pSprt + 800) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | pSprt + 800U & 0xffffff;
      Hud_GoTpage(1);
    }
  }
  Hud_GoTpage(0);
  tp2 = Render_gPalettePtr;
  if (GameSetup_gData.carInfo[player].HudTach == 0) goto HudNum_drawSpeedDigits;
  if (DashHUD_gInfo.gear == 0) {
    tpage_word_b = pSprt + 0x3c0;
    *(u_int *)(pSprt + 0x3c0) =
         *(u_int *)(pSprt + 0x3c0) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
HudNum_setPaletteTpage:
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tpage_word_b & 0xffffff;
  }
  else {
    if (DashHUD_gInfo.gear == 1) {
      tpage_word_b = pSprt + 0x3ac;
      *(u_int *)(pSprt + 0x3ac) =
           *(u_int *)(pSprt + 0x3ac) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      goto HudNum_setPaletteTpage;
    }
    digit_iter_b = DashHUD_gInfo.gear * 0x14 + pSprt;
    *(u_int *)(digit_iter_b + 0x30c) =
         *(u_int *)(digit_iter_b + 0x30c) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 |
                   DashHUD_gInfo.gear * 0x14 + pSprt + 0x30cU & 0xffffff;
  }
  tp2 = Render_gPalettePtr;
  if (GameSetup_gData.carInfo[player].HudSpeed == 0) {
    tSs8 = pSprt + 1000;
    *(u_int *)(pSprt + 1000) =
         *(u_int *)(pSprt + 1000) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  }
  else {
    tSs8 = pSprt + 0x3d4;
    *(u_int *)(pSprt + 0x3d4) =
         *(u_int *)(pSprt + 0x3d4) & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  }
  *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tSs8 & 0xffffffU;
HudNum_drawSpeedDigits:
  Hud_GoTpage(1);
  if (GameSetup_gData.carInfo[player].HudTach != 0) {
    digit_iter_b = fixedmult(GameSetup_gData.carInfo[player].HudSpeedMult,DashHUD_gInfo.speed);
    tp4 = Render_gPacketPtr;
    tp2 = Render_gPalettePtr;
    if (digit_iter_b < 0) {
      digit_iter_b = digit_iter_b + 0xffff;
    }
    digit_iter_b = digit_iter_b >> 0x10;
    iVar1 = (int)HudPmx_gShapes[0x2d].width;
    iVar2 = (int)HudPmx_gShapes[0x33].width;
    iVar4 = HudPmx_gShapes[0x2c].width + 1;
    ti14 = (int)g1Player[1].x + (int)g1Player[0xc].x;
    iVar3 = iVar4 * 2 + ti14 + 4;
    ts2 = g1Player[0xc].y;
    ts3 = g1Player[1].y;
    tu11 = (u_int)Render_gPacketPtr & 0xffffff;
    tp9 = Render_gPacketPtr + 0x34;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    Render_gPacketPtr = tp9;
    y_00 = (int)ts3 + (int)ts2 + splitY;
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tu11;
    iVar5 = iVar4 + iVar1 >> 1;
    iVar1 = digit_iter_b / 100;
    ti17 = digit_iter_b / 10 + iVar1 * -10;
    Hud_BuildGT4((POLY_GT4 *)tp4,HudPmx_gShapes + digit_iter_b % 10 + 0x2c,iVar3,y_00,0xc8c8c8);
    *(u_int *)(tp4 + 0x28) = 0x505050;
    *(u_int *)(tp4 + 0x1c) = 0x505050;
    tp11 = Render_gPacketPtr;
    tp2 = Render_gPalettePtr;
    if (ti17 == 1) {
      iVar3 = iVar3 - iVar5;
    }
    else if (ti17 == 7) {
      iVar3 = iVar3 - (iVar4 + iVar2 >> 1);
    }
    else {
      iVar3 = iVar3 - iVar4;
    }
    if ((iVar1 != 0) || (ti17 != 0)) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      tpage_word_b = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x34;
      *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tpage_word_b;
      Hud_BuildGT4((POLY_GT4 *)tp11,HudPmx_gShapes + ti17 + 0x2c,iVar3,y_00,0xc8c8c8);
      *(u_int *)(tp11 + 0x28) = 0x505050;
      *(u_int *)(tp11 + 0x1c) = 0x505050;
    }
    tp11 = Render_gPacketPtr;
    tp2 = Render_gPalettePtr;
    if (ti17 == 1) {
      iVar3 = iVar3 - (iVar4 - iVar5);
    }
    ts1 = HudPmx_gShapes[iVar1 + 0x2c].width;
    if (iVar1 != 0) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      tpage_word_b = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x34;
      *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tpage_word_b;
      Hud_BuildGT4((POLY_GT4 *)tp11,HudPmx_gShapes + iVar1 + 0x2c,(iVar3 + -1) - (int)ts1,y_00,
                 0xc8c8c8);
      *(u_int *)(tp11 + 0x28) = 0x505050;
      *(u_int *)(tp11 + 0x1c) = 0x505050;
    }
  }
  tp2 = Render_gPalettePtr;
  if ((DashHUD_gInfo.wrongway[player] != 0) && ((simGlobal.gameTicks >> 5 & 1U) != 0)) {
    *(u_int *)pSprt = *(u_int *)pSprt & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | pSprt & 0xffffffU;
  }
  return;
}

/* ---- Hud_InitMap__Fv  [HUD.CPP:1917-1926] SLD-VERIFIED ---- */
void Hud_InitMap(void)

{
  int iVar4;
  GameSetup_tCarData *pGVar5;
  int iVar6;
  Car_tObj **ppCVar7;
  CVECTOR *pCVar8;

  iVar4 = Cars_gNumRaceCars;
  iVar6 = 0;
  if (0 < Cars_gNumRaceCars) {
    pCVar8 = Hud_gMarkerColor;
    ppCVar7 = Cars_gRaceCarList;
    do {
      pGVar5 = (*ppCVar7)->carInfo;
      ppCVar7 = ppCVar7 + 1;
      iVar6 = iVar6 + 1;
      *(int *)pCVar8 = pGVar5->HudColour;
      pCVar8 = pCVar8 + 1;
    } while (iVar6 < iVar4);
  }
  iVar4 = Cars_gNumCopCars;
  iVar6 = 0;
  if (0 < Cars_gNumCopCars) {
    pCVar8 = Hud_gCopMarkerColor;
    ppCVar7 = Cars_gCopCarList;
    do {
      pGVar5 = (*ppCVar7)->carInfo;
      ppCVar7 = ppCVar7 + 1;
      iVar6 = iVar6 + 1;
      *(int *)pCVar8 = pGVar5->HudColour;
      pCVar8 = pCVar8 + 1;
    } while (iVar6 < iVar4);
  }
  return;
}

/* ---- Hud_BuildMapMarkers__Fi  [HUD.CPP:2019-2133] SLD-VERIFIED ---- */
void Hud_BuildMapMarkers(int player)

{
  u_char *sprt;
  int screen_x;
  int screen_y;
  int marker_type;
  int blip_glyph;
  int blip_color;
  int ti7;
  int ti8;
  int ti10;
  int color;
  int slice;
  int carRegion_p;
  int carRegion_alt;
  int tu8;
  int shapeIdx;
  int tu9;
  int z;
  int rz;
  int rx;
  int x;
  int world_x_off;
  int carInfo_iter;
  int marker_table;
  int i;
  int marker_idx;
  int carInfo_alt;
  int mapy;
  int rotated_x;
  int rotated_z;
  int rotated_z_b;
  int rotated_x_b;
  int loc_38;
  int loc_34;
  int cenX;
  int cenZ;
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
  u_char *tp1;
  u_char *tp2;
  u_char *tp3;
  int ti4;
  
  ti4 = gMapOffX;
  carInfo_iter = (int)Cars_gCopCarList;
  screen_x = gMapOffY + 2;
  for (marker_idx = 0; marker_idx < Cars_gNumCopCars; marker_idx = marker_idx + 1) {
    if (*(char *)(*(int *)carInfo_iter + 0x91) != '\0') {
      carRegion_p = (int)(BWorldSm_slices + *(short *)(*(int *)carInfo_iter + 8));
      rotated_x = *(int *)carRegion_p / gMapScaleX;
      rotated_z = *(int *)(carRegion_p + 8) / gMapScaleY;
      screen_y = fixedmult(mapMarkerMCos,rotated_x);
      marker_type = fixedmult(mapMarkerMSin,rotated_z);
      world_x_off = (ti4 + screen_y) - marker_type;
      blip_glyph = fixedmult(mapMarkerMSin,rotated_x);
      blip_color = fixedmult(mapMarkerMCos,rotated_z);
      tp2 = Render_gPacketPtr;
      tp1 = Render_gPalettePtr;
      if (GameSetup_gData.mirrorTrack != 0) {
        world_x_off = -world_x_off;
      }
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x14;
      if ((*(u_int *)(*(int *)carInfo_iter + 0x570) & 2) == 0) {
        currentSpriteColor = *(long *)(Hud_gCopMarkerColor + marker_idx);
      }
      else {
        ((u_char *)&(currentSpriteColor))[0] = 0xff;
        ((u_char *)&(currentSpriteColor))[1] = '\0';
        ((u_char *)&(currentSpriteColor))[2] = '\0';
        ((u_char *)&(currentSpriteColor))[3] = '\0';
        if ((gFlip == 0) &&
           (((u_char *)&(currentSpriteColor))[0] = 0xff, ((u_char *)&(currentSpriteColor))[1] = '\0',
           ((u_char *)&(currentSpriteColor))[2] = '\0', ((u_char *)&(currentSpriteColor))[3] = '\0',
           simVar.quickPauseSim == 0)) {
          ((u_char *)&(currentSpriteColor))[0] = '\0';
          ((u_char *)&(currentSpriteColor))[1] = '\0';
          ((u_char *)&(currentSpriteColor))[2] = 0xff;
          ((u_char *)&(currentSpriteColor))[3] = '\0';
        }
      }
      Hud_BuildSprite((SPRT *)tp2,0x7a,world_x_off + 0x14U & 0xffff,
                 0x18U - (screen_x + blip_glyph + blip_color) & 0xffff,currentSpriteColor,0);
    }
    carInfo_iter = carInfo_iter + 4;
  }
  marker_table = (int)Hud_gMarkerColor;
  carInfo_alt = (int)Cars_gRaceCarList;
  for (world_x_off = 0; world_x_off < Cars_gNumRaceCars; world_x_off = world_x_off + 1) {
    if (*(char *)(*(int *)carInfo_alt + 0x91) != '\0') {
      carRegion_alt = (int)(BWorldSm_slices + *(short *)(*(int *)carInfo_alt + 8));
      rotated_z_b = *(int *)carRegion_alt / gMapScaleX;
      rotated_x_b = *(int *)(carRegion_alt + 8) / gMapScaleY;
      ti7 = fixedmult(mapMarkerMCos,rotated_z_b);
      ti8 = fixedmult(mapMarkerMSin,rotated_x_b);
      ti8 = (ti4 + ti7) - ti8;
      rotated_z_b = fixedmult(mapMarkerMSin,rotated_z_b);
      ti10 = fixedmult(mapMarkerMCos,rotated_x_b);
      sprt = Render_gPacketPtr;
      tp3 = Render_gPalettePtr;
      if (GameSetup_gData.mirrorTrack != 0) {
        ti8 = -ti8;
      }
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
      tu8 = *(int *)(*(int *)carInfo_alt + 0x260);
      Render_gPacketPtr = Render_gPacketPtr + 0x14;
      if ((tu8 & 0x200U) == 0) {
        if ((tu8 & 4U) == 0) {
          shapeIdx = 0x7a;
          tu9 = ti8 + 0x14;
        }
        else {
          shapeIdx = 0x79;
          tu9 = ti8 + 0x13;
        }
        color = *(int *)marker_table;
      }
      else {
        if ((*(u_int *)(*(int *)carInfo_alt + 0x570) & 2) == 0) {
          color = *(int *)marker_table;
        }
        else {
          color = 0xff;
          if ((gFlip == 0) && (color = 0xff, simVar.quickPauseSim == 0)) {
            color = 0xff0000;
          }
        }
        shapeIdx = 0x79;
        tu9 = ti8 + 0x13;
        currentSpriteColor = color;
      }
      Hud_BuildSprite((SPRT *)sprt,shapeIdx,tu9 & 0xffff,0x18U - (screen_x + rotated_z_b + ti10) & 0xffff
                 ,color,0);
    }
    marker_table = marker_table + 4;
    carInfo_alt = carInfo_alt + 4;
  }
  return;
}

/* ---- Hud_WingmanFlash__Fii  [HUD.CPP:2148-2157] SLD-VERIFIED ---- */
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
  int wingmanText_p;
  int wingmanText_p2;
  char *pcVar1;
  int uv_pack;
  int color_pack;
  u_int uVar2;
  int y_01;
  int splitY;
  int screen_x_w;
  int y_temp;
  int i;
  int wingman_glyph;
  int request_type;
  int flashTicks;
  int wingman_state;
  int y;
  int y_00;
  int x;
  int loc_38;
  int loc_34;
  int loc_30;
  int loc_28;
  u_char *tp1;
  u_char *tp2;
  u_char *tp5;
  u_char *poly;
  u_char *tp3;
  u_char *tp4;
  
  screen_x_w = 0;
  if (player != 0) {
    screen_x_w = -0xf;
  }
  wingman_state = Hud_gWingmanFlashTicks[player] - ticks;
  wingman_glyph = (int)g1Player[0xe].x;
  y_00 = g1Player[0xe].y + HudMapOffsetY + screen_x_w + 2;
  wingmanText_p = (int)TextSys_Word(0x29);
  y_temp = wingman_glyph + -0x1b;
  Hud_BuildString((char *)wingmanText_p,y_temp,y_00 + 3,0x808080,0,false);
  wingmanText_p2 = (int)TextSys_Word(0x2a);
  Hud_BuildString((char *)wingmanText_p2,y_temp,y_00 + 0xc,0x808080,player,false);
  pcVar1 = TextSys_Word(0x2b);
  Hud_BuildString(pcVar1,y_temp,y_00 + 0x15,0x808080,player,false);
  pcVar1 = TextSys_Word(0x2c);
  Hud_BuildString(pcVar1,y_temp,y_00 + 0x1e,0x808080,player,false);
  pcVar1 = TextSys_Word(0x2d);
  Hud_BuildString(pcVar1,y_temp,y_00 + 0x27,0x808080,player,false);
  tp2 = Render_gPacketPtr;
  tp1 = Render_gPalettePtr;
  if (0 < wingman_state) {
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    color_pack = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | color_pack;
    Hud_BuildF4((POLY_F4 *)tp2,0,wingman_glyph + -0x10,y_00 + ((u_char)""[player] + 1) * 9 + 2,0x3f,8,
               (wingman_state % 0x14) * 10);
  }
  request_type = 0;
  i = 2;
  do {
    tp4 = Render_gPacketPtr;
    tp3 = Render_gPalettePtr;
    y_01 = y_00 + i;
    i = i + 9;
    request_type = request_type + 1;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    uv_pack = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | uv_pack;
    Hud_BuildF4((POLY_F4 *)tp4,0,wingman_glyph + -0x1c,y_01,0x4b,7,0);
    poly = Render_gPacketPtr;
    tp5 = Render_gPalettePtr;
  } while (request_type < 5);
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  uVar2 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x18;
  *(u_int *)tp5 = *(u_int *)tp5 & 0xff000000 | uVar2;
  Hud_BuildF4((POLY_F4 *)poly,1,wingman_glyph + -0x1c,y_00,0x4b,0x30,0);
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
  short sVar1;
  bool bVar2;
  int sec;
  int iVar3;
  AudioMus_tCurrentSong *pAVar4;
  u_int uVar5;
  u_char *s_00;
  int w;
  int iVar6;
  u_char *pbVar7;
  int tx;
  int iVar8;
  char *s;
  u_char *pbVar9;
  int box_transp;
  int box_x;
  char *artist;
  char *s_01;
  char *title;
  AudioMus_tCurrentSong *currentSong;
  int dx;
  int iVar10;
  int index;
  int iVar11;
  int time;
  int iVar12;
  int x;
  int iVar13;
  int y;
  char strindex [4];
  char strscrolltitle [30];
  char strartist [30];
  char strtitle [30];
  char strtime [10];
  char strtest [2];
  
  sVar1 = g1Player[0xf].x;
  iVar3 = (int)g1Player[0xf].y;
  iVar13 = sVar1 + 2;
  if (type == 0) {
    keepup = 1;
  }
  iVar10 = 0;
  pAVar4 = AudioMus_GetCurrentSong();
  if (pAVar4 == (AudioMus_tCurrentSong *)0x0) {
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
    if ((bVar2) ||
       ((((gPadinfo.buf[0].ID == '#' && (0xbf < gPadinfo.buf[0].data.negcon.leftshift)) &&
         ((Hud_BeTheCop == 0 || (DashHUD_gInfo.splitscreen != 0)))) ||
        (((gPadinfo.buf[4].ID == '#' && (0xbf < gPadinfo.buf[4].data.negcon.leftshift)) &&
         (DashHUD_gInfo.splitscreen != 0)))))) {
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
  iVar12 = pAVar4->remaining;
  iVar11 = pAVar4->index;
  s_00 = (u_char *)strtitle;
  if ((pAVar4->info).title == (char *)0x0) {
    s_00 = (u_char *)0x0;
  }
  else {
    sprintf((char *)s_00,"%s",(pAVar4->info).title);
  }
  s_01 = strartist;
  if ((pAVar4->info).artist == (char *)0x0) {
    s_01 = (char *)0x0;
  }
  else {
    sprintf(s_01,"%s",(pAVar4->info).artist);
  }
  uppercase((char *)s_00);
  if ((type == 0) && (s_01 != (char *)0x0)) {
    uppercase(s_01);
  }
  if (Hud_gCdActive == 0) {
    Hud_kTurnSongOffNext = 1;
    return 1;
  }
  if (iVar11 < 1) {
    if (iVar11 == 0) {
      sprintf(strindex,"- -");
      iVar8 = 0x44;
    }
    else if (iVar11 == -2) {
      sprintf(strindex,"- -");
      iVar8 = 0x45;
    }
    else {
      sprintf(strindex,"- -");
      s_01 = (char *)0x0;
      if (s_00 != (u_char *)0x0) goto HudCdPlay_nullStringFallback;
      iVar8 = 0x46;
    }
    s_01 = (char *)0x0;
    s_00 = (u_char *)TextSys_Word(iVar8);
HudCdPlay_nullStringFallback:
    if (s_00 == (u_char *)0x0) {
      keepup = 0;
      Hud_gCdLastTick = ticks;
      goto HudCdPlay_buildOutString;
    }
  }
  else {
    sprintf(strindex,"%02d",iVar11);
    if (s_00 == (u_char *)0x0) {
      Hud_gCdScrollTitle = 1;
      Hud_gCdLastTick = ticks;
      goto HudCdPlay_nullStringFallback;
    }
  }
  iVar10 = Hud_BuildString((char *)s_00,0,0,0,0,true);
  if (Hud_gCdScrollTitle < iVar10 + 0x4c) {
    while (Hud_gCdLastTick < ticks) {
      Hud_gCdScrollTitle = Hud_gCdScrollTitle + 1;
      Hud_gCdLastTick = Hud_gCdLastTick + 4;
    }
  }
  else if (Hud_gCdLastTick + 0x80 < ticks) {
    Hud_gCdActive = 0;
  }
  iVar10 = 0;
  pbVar9 = (u_char *)strscrolltitle;
  iVar8 = 0x4c - Hud_gCdScrollTitle;
  if (*s_00 != 0) {
    pbVar7 = s_00;
    do {
      if ((int)(s_00 + 0x3f) <= (int)pbVar7) break;
      if (*pbVar7 == 0x20) {
        iVar6 = 3;
      }
      else {
        if (*pbVar7 - 0x30 < 10) {
          iVar6 = *pbVar7 + 0x6e;
        }
        else {
          iVar6 = *pbVar7 + 0x43;
        }
        iVar6 = HudPmx_gShapes[iVar6].width + 1;
      }
      if (0x4b < iVar8 + iVar6) break;
      if (iVar8 < 0) {
        iVar10 = iVar10 + iVar6;
      }
      else {
        *pbVar9 = *pbVar7;
        pbVar9 = pbVar9 + 1;
      }
      pbVar7 = pbVar7 + 1;
      iVar8 = iVar8 + iVar6;
    } while (*pbVar7 != 0);
  }
  *pbVar9 = 0;
HudCdPlay_buildOutString:
  if (type == 0) {
    if (s_00 == (u_char *)0x0) {
      return 1;
    }
    Hud_gShowedCDPlayer = 1;
    Hud_BuildString(strscrolltitle,(iVar13 + iVar10 + 10) - (Hud_gCdScrollTitle + -0x4c),iVar3 + 0xc,
               0xbebe,0,false);
    if (s_01 != (char *)0x0) {
      Hud_BuildString(s_01,sVar1 + 0xc,iVar3 + 0x15,0x808080,0,false);
    }
    Hud_GoTpage(0);
    Hud_BlackThinBox(g1Player[0xf].x + 10,g1Player[0xf].y + 10,0x50,0x12);
    iVar10 = 0x50;
    iVar3 = 0x12;
    iVar11 = 0x12;
    iVar13 = g1Player[0xf].y + 10;
    box_transp = 0;
    box_x = g1Player[0xf].x + 10;
  }
  else {
    Hud_gShowedCDPlayer = 1;
    Font_TextColor(4);
    Font_TextXY(strindex,iVar13,iVar3);
    if (s_00 != (u_char *)0x0) {
      Font_TextColor(3);
      Hud_BuildString(strscrolltitle,(iVar13 + iVar10 + 0x16) - (Hud_gCdScrollTitle + -0x4c),iVar3 + 5,
                 0xbebe,0,false);
      Hud_GoTpage(0);
      if (iVar11 != 0) {
        int min = iVar12 / 60000;
        sprintf(strtime,"%1d%c%02d",min,
                   (u_int)(u_char)"::\'\'\'."[GameSetup_gData.userSetting.language],
                   (iVar12 % 60000) / 1000);
        Font_TextColor(4);
        iVar10 = textpixels(strtime);
        Font_TextXY(strtime,(iVar13 - iVar10) + 0x5c,iVar3 + 0xe);
      }
    }
    Hud_BlackThinBox((int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0x1c);
    Hud_FBuildF4(0,(int)g1Player[0xf].x,(int)g1Player[0xf].y,0x66,0xe,0,'\0','\0');
    Hud_FBuildF4(0,(int)g1Player[0xf].x,g1Player[0xf].y + 0x1b,0x66,1,0,'\0','\0');
    iVar10 = 0x66;
    iVar13 = (int)g1Player[0xf].y;
    box_transp = 1;
    box_x = (int)g1Player[0xf].x;
    iVar3 = 0x1c;
    iVar11 = 0x1c;
  }
  Hud_FBuildF4(box_transp,box_x,iVar13,iVar10,iVar11,0,'\0','\0');
  return iVar3;
}

/* ---- Hud_BuildRadar__Fi  [HUD.CPP:2497-2614] SLD-VERIFIED ---- */
int Hud_BuildRadar(int player)

{
  u_char *sprt;
  int z;
  int car;
  int ti6;
  int ti1;
  int ti2;
  int tu7;
  int color;
  int iVar1;
  int tC8;
  int iVar2;
  int m11;
  int m11_val;
  int iVar3;
  int x;
  int ti10;
  int pbVar3;
  int ti4;
  coorddef *pcVar4;
  int tpi11;
  int iVar5;
  Car_tObj **ppCVar6;
  int tu5;
  int carInfo_iter_r;
  int ti7;
  int track_dist;
  int ppCVar8;
  int cenZ;
  int cenZ_val;
  int cenX;
  int cenX_val;
  int m10;
  int m10_val;
  int m01;
  int m01_val;
  int m00;
  int m00_val;
  int i;
  int radar_blip_count;
  int ti11;
  int tp20;
  int visible;
  int alpha_val;
  int mapz;
  int mapx;
  int loc_e8;
  int loc_e4;
  coorddef scr [15];
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
  u_char *tp3;
  u_char *tp2;
  u_char *tp4;
  u_char bVar1;
  
  radar_blip_count = 0;
  alpha_val = 0;
  car = (int)Camera_gInfo[player].anchor;
  m00_val = *(int *)(car + 0xf0) >> 8;
  m01_val = *(int *)(car + 0x108) >> 8;
  m10_val = *(int *)(car + 0xf8) >> 8;
  m11_val = *(int *)(car + 0x110) >> 8;
  cenX_val = *(int *)(car + 0xa0) >> 8;
  cenZ_val = -*(int *)(car + 0xa8) >> 8;
  if (0 < Cars_gNumRaceCars) {
    carInfo_iter_r = (int)Cars_gRaceCarList;
    track_dist = 0;
    do {
      ti10 = (*(int *)(*(int *)carInfo_iter_r + 0xa0) >> 8) - cenX_val;
      ti6 = (-*(int *)(*(int *)carInfo_iter_r + 0xa8) >> 8) - cenZ_val;
      pbVar3 = (int)&scr[0].x + track_dist;
      *(int *)pbVar3 = m00_val * ti10 + m01_val * ti6 >> 0x10;
      *(int *)((int)&scr[0].z + track_dist) = m10_val * ti10 + m11_val * ti6 >> 0x11;
      if (GameSetup_gData.mirrorTrack != 0) {
        *(int *)pbVar3 = -*(int *)pbVar3;
      }
      if (((((*(char *)(*(int *)carInfo_iter_r + 0x91) != '\0') &&
            (*(int *)(*(int *)carInfo_iter_r + 0x254) != player)) && (-0x16 < *(int *)pbVar3)) &&
          ((*(int *)pbVar3 < 0x16 && (iVar1 = *(int *)((int)&scr[0].z + track_dist), -0x18 < iVar1))
          )) && (iVar1 < 0x18)) {
        alpha_val = 1;
      }
      carInfo_iter_r = carInfo_iter_r + 4;
      radar_blip_count = radar_blip_count + 1;
      track_dist = track_dist + 0xc;
    } while (radar_blip_count < Cars_gNumRaceCars);
  }
  ti11 = 0;
  if (0 < Cars_gNumCopCars) {
    ppCVar8 = (int)Cars_gCopCarList;
    ti7 = Cars_gNumRaceCars;
    do {
      tC8 = *(int *)ppCVar8;
      if (*(char *)(tC8 + 0x91) != '\0') {
        ti4 = (*(int *)(tC8 + 0xa0) >> 8) - cenX_val;
        ti1 = (-*(int *)(tC8 + 0xa8) >> 8) - cenZ_val;
        pcVar4 = scr + ti7;
        pcVar4->x = m00_val * ti4 + m01_val * ti1 >> 0x10;
        scr[ti7].z = m10_val * ti4 + m11_val * ti1 >> 0x11;
        if (GameSetup_gData.mirrorTrack != 0) {
          pcVar4->x = -pcVar4->x;
        }
        if (((-0x16 < pcVar4->x) && (pcVar4->x < 0x16)) &&
           ((-0x18 < scr[ti7].z && (scr[ti7].z < 0x18)))) {
          alpha_val = 1;
        }
      }
      ti7 = ti7 + 1;
      ti11 = ti11 + 1;
      ppCVar8 = ppCVar8 + 4;
    } while (ti11 < Cars_gNumCopCars);
  }
  if (alpha_val == 0) {
    iVar1 = 0;
    if (0 < Cars_gNumRaceCars) {
      tpi11 = (int)scr;
      ppCVar6 = Cars_gRaceCarList;
      do {
        if (((*ppCVar6)->N).active != '\0') {
          iVar2 = *(int *)(tpi11 + 8) >> 2;
          *(int *)tpi11 = *(int *)tpi11 >> 2;
          *(int *)(tpi11 + 8) = iVar2;
          if (((((*ppCVar6)->carIndex != player) && (-0x16 < *(int *)tpi11)) &&
              (*(int *)tpi11 < 0x16)) && ((-0x18 < iVar2 && (iVar2 < 0x18)))) {
            alpha_val = 2;
          }
        }
        tpi11 = tpi11 + 0xc;
        iVar1 = iVar1 + 1;
        ppCVar6 = ppCVar6 + 1;
      } while (iVar1 < Cars_gNumRaceCars);
    }
    iVar2 = 0;
    iVar1 = Cars_gNumRaceCars;
    if (0 < Cars_gNumCopCars) {
      do {
        pcVar4 = scr + iVar1;
        pcVar4->x = pcVar4->x >> 2;
        iVar5 = pcVar4->x;
        iVar3 = scr[iVar1].z >> 2;
        scr[iVar1].z = iVar3;
        if (((-0x16 < iVar5) && (iVar5 < 0x16)) && ((-0x18 < iVar3 && (iVar3 < 0x18)))) {
          alpha_val = 2;
        }
        iVar2 = iVar2 + 1;
        iVar1 = iVar2 + Cars_gNumRaceCars;
      } while (iVar2 < Cars_gNumCopCars);
    }
  }
  ppCVar6 = Cars_gCopCarList;
  for (iVar1 = 0; tp3 = Render_gPacketPtr, tp2 = Render_gPalettePtr, iVar1 < Cars_gNumCopCars;
      iVar1 = iVar1 + 1) {
    if (((*ppCVar6)->N).active != '\0') {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      tu7 = (u_int)Render_gPacketPtr & 0xffffff;
      bVar1 = gFlip != 0;
      Render_gPacketPtr = Render_gPacketPtr + 0x14;
      *(u_int *)tp2 = *(u_int *)tp2 & 0xff000000 | tu7;
      if (((bool)bVar1) || (currentSpriteColor = 0xff0000, simVar.quickPauseSim != 0)) {
        currentSpriteColor = 0xff;
      }
      Hud_BuildSprite((SPRT *)tp3,0x7a,scr[iVar1 + Cars_gNumRaceCars].x + 0x14U & 0xffff,
                 scr[iVar1 + Cars_gNumRaceCars].z + 0x18U & 0xffff,currentSpriteColor,0);
    }
    ppCVar6 = ppCVar6 + 1;
  }
  iVar2 = 0;
  tp20 = (int)Hud_gMarkerColor;
  ppCVar6 = Cars_gRaceCarList;
  for (iVar1 = 0; sprt = Render_gPacketPtr, tp4 = Render_gPalettePtr, iVar1 < Cars_gNumRaceCars;
      iVar1 = iVar1 + 1) {
    if ((iVar1 != player) && (((*ppCVar6)->N).active != '\0')) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)tp4 = *(u_int *)tp4 & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x14;
      if (((*ppCVar6)->carFlags & 4U) == 0) {
        iVar5 = *(int *)((int)&scr[0].z + iVar2);
        color = *(int *)(Hud_gMarkerColor + iVar1);
        iVar3 = 0x7a;
        tu5 = *(int *)((int)&scr[0].x + iVar2) + 0x14;
      }
      else {
        iVar5 = *(int *)((int)&scr[0].z + iVar2);
        color = *(int *)tp20;
        iVar3 = 0x79;
        tu5 = *(int *)((int)&scr[0].x + iVar2) + 0x13;
      }
      Hud_BuildSprite((SPRT *)sprt,iVar3,tu5 & 0xffff,iVar5 + 0x18U & 0xffff,color,0)
      ;
    }
    iVar2 = iVar2 + 0xc;
    tp20 = tp20 + 4;
    ppCVar6 = ppCVar6 + 1;
  }
  return alpha_val;
}

/* ---- Hud_BuildReplay__Fv  [HUD.CPP:2752-2849] SLD-VERIFIED ---- */
void Hud_BuildReplay(void)

{
  u_char uVar1;
  u_short uVar2;
  SPRT *pSVar3;
  HudPmx_tShape *pHVar4;
  int uv_byte_pack;
  int color_pack;
  int tpage_pack;
  int spr;
  int char_glyph;
  int char_w;
  int sprt_iter;
  int i;
  int char_idx;
  int iVar5;
  char hilite [5];
  int tu1;
  SPRT *tSs3;
  u_char *tp5;
  u_char *tp4;
  SPRT *tSs2;
  SPRT *tSs1;
  int tp2;
  
  tu1 = (u_int)(hilite + 3) & 3;
  tp2 = (int)(hilite + 3) - tu1;
  *(u_int *)tp2 = *(u_int *)tp2 & -1 << (tu1 + 1) * 8 | 0x02010004U /* @0x8013d914 */ >> (3 - tu1) * 8;
  (*(int *)&(hilite)) = 0x02010004U /* @0x8013d914 */;
  hilite[4] = 0x03 /* @0x8013d918 */;
  char_idx = 0x33;
  char_glyph = 0x3fc;
  do {
    tSs1 = gSprite0;
    char_idx = char_idx + 1;
    *(u_int *)(&gSprite0->r0 + char_glyph) = 0x66808080;
    char_glyph = char_glyph + 0x14;
  } while (char_idx < 0x3f);
  tSs3 = tSs1 + (u_char)hilite[Replay_ReplayInterface.selection] + 0x33;
  tSs3->r0 = 0xbe;
  tSs3->g0 = 0xbe;
  tSs3->b0 = '\0';
  tSs3->code = 'f';
  if (Replay_ReplayInterface.selection == 3) {
    tSs1[0x38].r0 = 0xbe;
    tSs1[0x38].g0 = 0xbe;
    tSs1[0x38].b0 = '\0';
    tSs1[0x38].code = 'f';
  }
  pHVar4 = HudPmx_gShapes + (0x6e - Replay_ReplayInterface.pause);
  uVar1 = (pHVar4->pixmap).v0;
  uVar2 = (pHVar4->pixmap).clut;
  pSVar3 = gSprite0;
  pSVar3[0x34].u0 = (pHVar4->pixmap).u0;
  pSVar3[0x34].v0 = uVar1;
  pSVar3[0x34].clut = uVar2;
  if (Replay_ReplayInterface.speed == 1) {
    char_w = 0x73;
  }
  else if (Replay_ReplayInterface.speed < 2) {
    char_w = 0x74;
    if (Replay_ReplayInterface.speed == 0) {
      char_w = 0x72;
    }
  }
  else {
    char_w = 0x74;
    if (Replay_ReplayInterface.speed == 2) {
      char_w = 0x75;
    }
  }
  gSprite0[0x38].u0 = HudPmx_gShapes[char_w].pixmap.u0;
  gSprite0[0x38].v0 = HudPmx_gShapes[char_w].pixmap.v0;
  pSVar3 = gSprite0;
  pHVar4 = HudPmx_gShapes + Replay_ReplayInterface.camera + 2;
  uVar1 = (pHVar4->pixmap).v0;
  uVar2 = (pHVar4->pixmap).clut;
  pSVar3[0x39].u0 = (pHVar4->pixmap).u0;
  pSVar3[0x39].v0 = uVar1;
  pSVar3[0x39].clut = uVar2;
  pSVar3[0x39].x0 = g1Player[0xd].x + 0x75;
  if (Replay_ReplayInterface.selection == 4) {
    tpage_pack = 0x6600bebe;
  }
  else {
    tpage_pack = 0x66808080;
  }
  pSVar3[0x39].r0 = (char)tpage_pack;
  tSs2 = gSprite0;
  tp4 = Render_gPalettePtr;
  pSVar3[0x39].g0 = (char)((u_int)tpage_pack >> 8);
  pSVar3[0x39].b0 = (char)((u_int)tpage_pack >> 0x10);
  pSVar3[0x39].code = (char)((u_int)tpage_pack >> 0x18);
  iVar5 = 0x33;
  sprt_iter = (int)(gSprite0 + 0x33);
  gSprite0[0x39].tag =
       (u_long *)((u_int)gSprite0[0x39].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff);
  *(u_int *)tp4 = *(u_int *)tp4 & 0xff000000 | (u_int)(tSs2 + 0x39) & 0xffffff;
  do {
    iVar5 = iVar5 + 1;
    *(u_int *)sprt_iter = *(u_int *)sprt_iter & 0xff000000 | *(u_int *)tp4 & 0xffffff;
    *(u_int *)tp4 = *(u_int *)tp4 & 0xff000000 | sprt_iter & 0xffffffU;
    pSVar3 = gSprite0;
    tp5 = Render_gPalettePtr;
    sprt_iter = sprt_iter + 0x14;
  } while (iVar5 < 0x38);
  gSprite0[0x38].tag =
       (u_long *)((u_int)gSprite0[0x38].tag & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff);
  *(u_int *)tp5 = *(u_int *)tp5 & 0xff000000 | (u_int)(pSVar3 + 0x38) & 0xffffff;
  gTPage1[0][3].tag =
       (u_long *)((u_int)gTPage1[0][3].tag & 0xff000000 | (u_int)(pSVar3 + 0x38) & 0xffffff);
  *(u_int *)tp5 = *(u_int *)tp5 & 0xff000000 | 0x13e414;
  gTPage0[0][3].tag = (u_long *)((u_int)gTPage0[0][3].tag & 0xff000000 | 0x13e414);
  *(u_int *)tp5 = *(u_int *)tp5 & 0xff000000 | 0x13e3b4;
  return;
}

/* ---- Hud_NextPlayer__Fi  [HUD.CPP:2862-2889] SLD-VERIFIED ---- */
int Hud_NextPlayer(int player)

{
  int iVar1;
  int iVar2;
  u_int uVar3;
  int j;
  int i;
  int iVar4;
  Car_tObj *carObj;
  Car_tObj *carObj_00;
  int direction;
  u_int uVar5;
  
  uVar5 = (u_int)(0 < Input_gLookBehind[player] != 0 < DashHUD_gInfo.wrongway[player]);
  carObj_00 = Cars_gHumanRaceCarList[player];
  if (1 < Cars_gNumRaceCars) {
    iVar1 = Stats_GetPosition(carObj_00);
    iVar4 = 0;
    if ((iVar1 != 1) || (uVar5 != 0)) {
      iVar1 = carObj_00->sortIndex;
      if (0 < Cars_gNumCars + -1) {
        do {
          if (uVar5 == GameSetup_gData.reverseTrack) {
            iVar1 = iVar1 + 1;
          }
          else {
            iVar1 = iVar1 + -1;
          }
          if (iVar1 < 0) {
            iVar1 = iVar1 + Cars_gNumCars;
          }
          iVar2 = iVar1 << 2;
          if (Cars_gNumCars <= iVar1) {
            iVar1 = 0;
            iVar2 = 0;
          }
          uVar3 = *(u_int *)(*(int *)((int)Cars_gSortedList + iVar2) + 0x260);
          if ((uVar3 & 4) != 0) {
            if (player == 0) {
              return 8;
            }
            return 7;
          }
          iVar4 = iVar4 + 1;
          if ((uVar3 & 8) != 0) {
            return *(int *)(*(int *)((int)Cars_gSortedList + iVar2) + 0x4ec);
          }
        } while (iVar4 < Cars_gNumCars + -1);
      }
    }
  }
  return -1;
}

/* ---- Hud_NextPlayerNameOrCarOrTime__Fi  [HUD.CPP:2895-2924] SLD-VERIFIED ---- */
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
    if ((iVar1 != 1) || (uVar4 != 0)) {
      iVar1 = carObj_00->sortIndex;
      if (0 < Cars_gNumCars + -1) {
        do {
          if (uVar4 == GameSetup_gData.reverseTrack) {
            iVar1 = iVar1 + 1;
          }
          else {
            iVar1 = iVar1 + -1;
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
            if (GameSetup_gData.carInfo[player].HudOpponentID != 2) {
              return (char *)(*(int *)(iVar2 + 0x288) + 0x5c);
            }
            return (char *)(iVar2 + 0x249);
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
  int track_geom_p;
  int current_tile_idx;
  u_char *tp2;
  u_char *tp1;
  u_char *tp3;
  
  tile_count = 0;
  current_tile_idx = 0;
  track_geom_p = (int)&GameSetup_gData;
  for (player = 0; player <= DashHUD_gInfo.splitscreen; player = player + 1) {
    if (((*(int *)(track_geom_p + 0x450) != 0) &&
        (*(int *)((int)DashHUD_gInfo.showhud + tile_count) != 0)) &&
       (Hud_gWingmanInterface[player] == '\0')) {
      HudFT4 = (int)gHudFT4;
      if (player != 0) {
        HudFT4 = (int)(gHudFT4 + 5);
      }
      Draw_StartRenderingView(*(int *)((int)Hud_gMapView + tile_count));
      if (*(int *)(track_geom_p + 0x450) == 1) {
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
      tile_dest_p = current_tile_idx + -0x7fec1c04;
      *(u_int *)tile_dest_p =
           *(u_int *)tile_dest_p & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | tile_dest_p & 0xffffffU;
      Draw_StopRenderingView(*(int *)((int)Hud_gMapView + tile_count));
    }
    tile_count = tile_count + 4;
    current_tile_idx = current_tile_idx + 0x30;
    track_geom_p = track_geom_p + 0xb4;
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
  u_long x;
  u_long y;
  u_char *puVar1;
  char   *pcVar2;
  u_int   uVar3, uVar4, uVar12;
  int     iVar8, iVar9, iVar11, iVar13;
  int     y_00, splitY, j;
  u_long  uVar10, color, ww, ww2;
  int     flare_intensity, flare_type;
  SPRT   *gSprt1;
  u_int  *puVar5;
  int    *piVar7;
  int     viewOff, tpageOff;
  char    sBuildOutput[64];

  viewOff = 0;
  tpageOff = 0;
  for (j = 0; j <= DashHUD_gInfo.splitscreen; j++) {
    splitY = 0;
    if (j != 0) splitY = -0xf;
    Draw_StartRenderingView(*(int *)((int)Hud_gHudView + viewOff));
    Hud_DebugInfo();
    Hud_DebugCrap();
    if ((GameSetup_gData.raceType == 1) && (*(int *)((int)PerpOverlayOn + viewOff) != 0)) {
      pcVar2 = TextSys_Word(*(int *)((int)PerpOverlayMessage + viewOff) + 0x41);
      uVar3 = textpixels(pcVar2);
      iVar13 = g1Player[0x12].y + splitY;
      Font_TextColor(4);
      pcVar2 = TextSys_Word(*(int *)((int)PerpOverlayMessage + viewOff) + 0x41);
      uVar12 = uVar3 >> 1;
      Font_TextXY(pcVar2, 0xa0 - (uVar12 + 1), iVar13);
      uVar4 = simGlobal.gameTicks >> 4 & 1;
      color = 0x800000;  if (uVar4 != 0) color = 0x80;
      ww = color;
      flare_type = 10;    if (uVar4 != 0) flare_type = 8;
      iVar11 = -(int)uVar12;
      y_00 = iVar13 + 8;
      flare_intensity = (simGlobal.gameTicks % 0xf) * -0xfa + 4000;
      Flare_2DHalo(iVar11 + 0x7d, y_00, flare_intensity, flare_intensity, flare_type);
      Flare_2DHalo(iVar11 + 0x73, y_00, flare_intensity, flare_intensity, flare_type);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], iVar11 + 0x7a, iVar13 + 5, color);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], iVar11 + 0x70, iVar13 + 5, ww);
      uVar4 = simGlobal.gameTicks >> 4 & 1;
      ww2 = 0x800000;     if (uVar4 == 0) ww2 = 0x80;
      flare_type = 10;    if (uVar4 == 0) flare_type = 8;
      Flare_2DHalo(uVar12 + 0xc0, y_00, flare_intensity, flare_intensity, flare_type);
      Flare_2DHalo(uVar12 + 0xca, y_00, flare_intensity, flare_intensity, flare_type);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], uVar12 + 0xbd, iVar13 + 5, ww2);
      Hud_FBuildGT4(&HudPmx_gShapes[0x3d], uVar12 + 0xc7, iVar13 + 5, ww2);
      Hud_BlackThinBox(iVar11 + 0x6f, iVar13, uVar3 + 0x62, 0x11);
      Hud_FBuildF4(0, iVar11 + 0x6f, iVar13, 0x17, 0x11, 0, '\0', '\0');
      Hud_FBuildF4(0, uVar12 + 0xba, iVar13, 0x15, 0x11, 0, '\0', '\0');
      Hud_FBuildF4(0, uVar12 + 0xba, iVar13 + 3, 0x16, 0xb, 0, '\0', '\0');
      Hud_FBuildF4(1, iVar11 + 0x86, iVar13, uVar3 + 0x36, 0x11, 0x461414, '\0', '\0');
    }
    if (j == DashHUD_gInfo.splitscreen) {
      if ((u_int)((BTC_Countdown >> 6) - 1U) < 0x1e) {
        BigBTCTime(BTC_Countdown >> 6);
      } else {
        iVar13 = 0;
        if (((0x23f < simGlobal.gameTicks) && (iVar13 = 1, (u_char)countdown < 4)) &&
            (Hud_BeTheCop == 0)) {
          iVar13 = 0;
        }
        Hud_BuildCdPlayer(iVar13, j);
      }
    }
    if (*(int *)((int)DashHUD_gInfo.showhud + viewOff) != 0) {
      int nextplayer, w1, w2, totalwidth, h, i;
      SPRT *gSprt1 = gSprite0;
      if (j != 0) gSprt1 = gSprite1;
      DashHUD_CheckWrongWay(j);
      DashHUD_HUDCalc(j);
      Hud_BuildNumbers0(j);
      Hud_BuildNumbers(j);
      puVar1 = Render_gPalettePtr;
      puVar5 = (u_int *)((int)gTPage0[0][0].code + tpageOff + -4);
      *puVar5 = *puVar5 & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *(u_int *)puVar1 = *(u_int *)puVar1 & 0xff000000 | (u_int)puVar5 & 0xffffff;
      if (GameSetup_gData.carInfo[j].HudTach != 0) {
        gSprt1[1].tag = (u_long *)((u_int)gSprt1[1].tag & 0xff000000 | (u_int)puVar5 & 0xffffff);
        *(u_int *)puVar1 = *(u_int *)puVar1 & 0xff000000 | (u_int)(gSprt1 + 1) & 0xffffff;
      }
      if (GameSetup_gData.carInfo[j].HudMap != 0) {
        if (((GameSetup_gData.carInfo[j].HudOpponentID != 0) && (Hud_BeTheCop == 0)) &&
            (GameSetup_gData.commMode != 1)) {
          nextplayer = Hud_NextPlayer(j);
          if (((-1 < nextplayer) && (nextplayer < 9)) && (Hud_BeTheCop == 0)) {
            totalwidth = (int)HudPmx_gShapes[0x78].width;
            w1 = (int)HudPmx_gShapes[0xe].width;
            w2 = (int)HudPmx_gShapes[0x14].width;
            pcVar2 = Hud_NextPlayerNameOrCarOrTime(j);
            sprintf(sBuildOutput, "%s", pcVar2);
            Hud_GoTpage(1);
            uppercase(sBuildOutput);
            nextplayer = Hud_BuildString(sBuildOutput, 0, 0, 0, 0, true);
            Hud_BuildString(sBuildOutput, (int)g1Player[0xe].x + ((totalwidth + 2) - nextplayer >> 1),
                            ((g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height) + 1,
                            0x808080, 0, false);
            Hud_GoTpage(0);
            Hud_FBuildGT4(&HudPmx_gShapes[0x1f], (int)g1Player[0xe].x,
                          (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height, 0x808080);
            Hud_FBuildGT4(&HudPmx_gShapes[0x20], (int)g1Player[0xe].x + w1 + w2,
                          (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xf].height, 0x808080);
            Hud_FBuildF4(0, (int)g1Player[0xe].x + 2,
                         (g1Player[0xe].y + HudMapOffsetY + splitY) - (int)HudPmx_gShapes[0xe].height,
                         w1 + w2 + 3, (int)HudPmx_gShapes[0xe].height, 0, '\0', '\0');
            iVar13 = 2;
            if (Hud_gWingmanInterface[j] == '\0') iVar13 = 3;
            Hud_FBuildF4(0, (int)g1Player[0xe].x, g1Player[0xe].y + HudMapOffsetY + splitY, 3, iVar13, 0, '\0', '\0');
            Hud_FBuildF4(0, ((int)g1Player[0xe].x + w1 + w2 + (int)HudPmx_gShapes[0xf].width) - 3,
                         g1Player[0xe].y + HudMapOffsetY + splitY, 3, 3, 0, '\0', '\0');
          }
        }
        puVar1 = Render_gPalettePtr;
        i = 0x3f;
        gSprt1 = gSprt1 + 0x3f;
        do {
          i = i + 1;
          gSprt1->tag = (u_long *)((u_int)gSprt1->tag & 0xff000000 | *(u_int *)puVar1 & 0xffffff);
          *(u_int *)puVar1 = *(u_int *)puVar1 & 0xff000000 | (u_int)gSprt1 & 0xffffff;
          gSprt1 = gSprt1 + 1;
        } while (i < 0x47);
      }
    }
    if (((j == 0) && (1 < Replay_ReplayMode)) && (Replay_ReplayInterface.statsScreen == 0)) {
      Hud_BuildReplay();
    }
    puVar1 = Render_gPalettePtr;
    puVar5 = (u_int *)((int)gTPage1[0][0].code + tpageOff + -4);
    *puVar5 = *puVar5 & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    *(u_int *)puVar1 = *(u_int *)puVar1 & 0xff000000 | (u_int)puVar5 & 0xffffff;
    if (((*(int *)((int)DashHUD_gInfo.showhud + viewOff) != 0) &&
         (Hud_gWingmanInterface[j] != '\0')) && (Replay_ReplayMode < 2)) {
      Hud_BuildWingmanInterface(j);
    }
    puVar1 = Render_gPalettePtr;
    piVar7 = (int *)((int)Hud_gHudView + viewOff);
    viewOff = viewOff + 4;
    puVar5 = (u_int *)((int)gTPage0[0][1].code + tpageOff + -4);
    tpageOff = tpageOff + 0x30;
    *puVar5 = *puVar5 & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    *(u_int *)puVar1 = *(u_int *)puVar1 & 0xff000000 | (u_int)puVar5 & 0xffffff;
    Draw_StopRenderingView(*piVar7);
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

/* ---- Hud_ParseTime__FiPc  [HUD.CPP:3770-3801] SLD-VERIFIED ---- */
void Hud_ParseTime(int nTime,char *sLapTime)

{
  int centi_total;
  int min;
  u_char showtime;
  int iVar1;
  int sec;
  
  if (nTime < 0) {
    nTime = 0;
  }
  centi_total = nTime * 0x6400;
  if (centi_total < 0) {
    centi_total = centi_total + 0x3fff;
  }
  min = ((centi_total >> 0xe) / 6000) * 0x10000 >> 0x10;
  iVar1 = (centi_total >> 0xe) + min * -6000;
  sec = (iVar1 / 100) * 0x10000 >> 0x10;
  if (min < 0x3c && nTime != 0) {
    sprintf(sLapTime,"%01d%c%02d%c%02d",min,
               (u_int)(u_char)"::\'\'\'."[GameSetup_gData.userSetting.language],sec,
               (u_int)(u_char)".:\"\"\","[GameSetup_gData.userSetting.language],
               (iVar1 + sec * -100) * 0x10000 >> 0x10);
  }
  else {
    sprintf(sLapTime," - %c - - %c - -",
               (u_int)(u_char)"::\'\'\'."[GameSetup_gData.userSetting.language],
               (u_int)(u_char)".:\"\"\","[GameSetup_gData.userSetting.language]);
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
  short player_00;
  int *piVar1;
  u_int mode;
  int countamount;
  int rate;
  int type;
  short player;
  int delta;
  int wingmode;
  int i;
  char *pcVar3;
  int *piVar4;
  short busted_player;
  
  player_00 = HudBustedOverlayPlayer;
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
  if (((HudBustedOverlay != 0) || (BTC_BonusTime == 0)) || (ticks - BTC_BonusTimeTick < 0xfb))
  goto HudRender_btcBonusClamp;
  if (DashHUD_gInfo.splitscreen == 0) {
HudRender_setRateFast:
    rate = 0x32;
  }
  else if ((Cars_gRaceCarList[0]->carFlags & 0x200U) == 0) {
    rate = 0xfa;
  }
  else {
    rate = 0xfa;
    if ((Cars_gRaceCarList[1]->carFlags & 0x200U) != 0) goto HudRender_setRateFast;
  }
  int count;
  count = rate;
  if (BTC_BonusTime < rate) {
    count = BTC_BonusTime;
  }
  BTC_BonusTime = BTC_BonusTime - rate;
  BTC_Countdown = BTC_Countdown + count;
  if (BTC_BonusTime < 0) {
    BTC_BonusTime = 0;
  }
HudRender_btcBonusClamp:
  if ((Hud_BeTheCop == 0) || (BTC_UserHasControl != 0)) {
    if ((HudBustedOverlay != 0) && (Replay_ReplayMode < 2)) {
      gCView.id = Hud_gStatsView;
      Draw_StartRenderingView(Hud_gStatsView);
      StatsTimer[player_00] = StatsTimer[player_00] + 1;
      Hud_BTCStats(player_00,false);
      Draw_StopRenderingView(Hud_gStatsView);
    }
    pcVar3 = Hud_gWingmanInterface;
    for (i = 0; i < 2; i = i + 1) {
      mode = Input_WingCommandMode(i);
      if (((u_char)*pcVar3 == mode) && (HudBustedOverlay != 0)) {
HudRender_initMapFrame:
        *pcVar3 = 0;
        Hud_InitMapFrame(i,0);
      }
      else if (Hud_gWingmanFlashTicks[i] < ticks) {
        if ((u_char)*pcVar3 != mode) {
          if (1 < Replay_ReplayMode) goto HudRender_initMapFrame;
          if (HudBustedOverlay == 0) {
            Hud_InitMapFrame(i,mode);
            *pcVar3 = (u_char)mode;
          }
        }
        if (1 < Replay_ReplayMode) goto HudRender_initMapFrame;
      }
      pcVar3 = pcVar3 + 1;
    }
    Hud_gShowedCDPlayer = 0;
    if (((simGlobal.gameTicks < 0x240) && (countdown != '\0')) && (Hud_BeTheCop == 0)) {
      Hud_Render321Go();
    }
    Hud_RenderHudView();
    Hud_RenderMapView();
    Hud_RenderTacView();
  }
  else {
    delta = 0;
    if (-1 < DashHUD_gInfo.splitscreen) {
      i = 0;
      piVar4 = Hud_gHudView;
      do {
        Draw_StartRenderingView(*piVar4);
        Hud_GoTpage(1);
        if (((delta == 0) && (1 < Replay_ReplayMode)) && (Replay_ReplayInterface.statsScreen == 0))
        {
          Hud_BuildReplay();
        }
        if (delta == DashHUD_gInfo.splitscreen) {
          type = 1;
          if ((simGlobal.gameTicks < 0x240) && (countdown == '\0')) {
            type = 0;
          }
          Hud_BuildCdPlayer(type,delta);
        }
        if (*(int *)((int)DashHUD_gInfo.showhud + i) != 0) {
          Hud_DebugInfo();
          Hud_BuildNumbers0(delta);
        }
        Hud_GoTpage(0);
        piVar1 = (int *)((int)Hud_gHudView + i);
        i = i + 4;
        piVar4 = piVar4 + 1;
        Draw_StopRenderingView(*piVar1);
        delta = delta + 1;
      } while (delta <= DashHUD_gInfo.splitscreen);
    }
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
    psVar1 = Hud_NextPerp;
    do {
      *psVar1 = 0;
      psVar1 = psVar1 + 1;
      iVar2 = iVar2 + 1;
      BTC_CurrentPerpName[0] = '\0';
    } while (iVar2 < 2);
  }
  BTC_BonusTime = 0;
  HudBustedOverlay = 0;
  PerpOverlayOn[0] = 0;
  PerpOverlayOn[1] = 0;
  BTC_UserHasControl = 0;
  return;
}

/* ---- Hud_BTC_QuitOut__Fv  [HUD.CPP:4074-4086] SLD-VERIFIED ----
 * NEAR-MISS 6 diffs (49/49, down from 8): SYM shows only block-scoped `i` -- the base ptr must be
 * a loop-hoisted pseudo, so BTCPerpInfo[0] is referenced INLINE (no row_base local init before the
 * loop; that low-numbered pseudo canonicalized the addu operand order the wrong way). name_tail
 * grouped as (idx*0x10 + row_off) + base matches the stores' addu order. Residual 6 = the sprintf
 * dest grouping: ours folds (row_off + base) into one temp, oracle keeps (idx*16+base) then
 * row_off+that -- reassociation tie, permuter class. row_base decl retained (unused). */
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
    row_off = 0;
    do {
      perp_idx = Hud_NextPerp + slot_i;
      sprintf(row_off + (char *)BTCPerpInfo[0][*perp_idx].name,BTC_CurrentPerpName);
      name_tail = (char *)BTCPerpInfo[0] + (*perp_idx * 0x10 + row_off);
      *(u_int *)(name_tail + 0xc) = 0;
      slot_i = slot_i + 1;
      name_tail = (char *)BTCPerpInfo[0] + (*perp_idx * 0x10 + row_off);
      *(u_int *)(name_tail + 8) = 0;
      *perp_idx = *perp_idx + 1;
      row_off = row_off + 0xa0;
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
