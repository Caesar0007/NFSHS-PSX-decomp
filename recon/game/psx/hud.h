/* game/psx/hud.h — reconstructed from game/psx/hud.cpp (62 fns) */
#ifndef _GAME_PSX_HUD_H_
#define _GAME_PSX_HUD_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Hud_CreateHudViews(void);   /* SYM 41fff1 @0x800d1a80 */
void Hud_GoTpage(int page);   /* SYM 420015 @0x800d1d6c */
void Hud_DebugInfo(void);   /* SYM 420032 @0x800d1dfc */
void Hud_DebugCrap(void);   /* SYM 420051 @0x800d1f90 */
void Hud_BuildSprite(SPRT * sprt,int shapeIdx,int x,int y,u_long color,int trans);   /* SYM 420070 @0x800d1f98 */
void Hud_BuildSprite2(SPRT * sprt,int shapeIdx,int x,int y);   /* SYM 42009c @0x800d2044 */
void Hud_FBuildSprite(int shapeIdx,int x,int y,u_long color,int trans);   /* SYM 4200c6 @0x800d2070 */
void Hud_BuildSpriteFromFont(SPRT * sprt,char ch,int x,int y);   /* SYM 4200ed @0x800d2104 */
void Hud_BuildF3(POLY_F3 * prim,HudPmx_tShape * shape,int x,int y,u_long color);   /* SYM 42011e @0x800d21c4 */
void Hud_BuildGT4(POLY_GT4 * prim,HudPmx_tShape * shape,int x,int y,u_long color);   /* SYM 420157 @0x800d2288 */
void Hud_BuildFT4(POLY_FT4 * prim,HudPmx_tShape * shape,int x,int y,u_long color,int trans);   /* SYM 420192 @0x800d2334 */
void Hud_BuildMirrorFT4(POLY_FT4 * prim,HudPmx_tShape * shape,int x,int y,u_long color,int trans);   /* SYM 4201ce @0x800d2424 */
void Hud_BuildMapMirrorFT4(POLY_FT4 * prim,HudPmx_tShape * shape,int x,int y,u_long color,int trans);   /* SYM 420210 @0x800d2528 */
void Hud_BuildF4(POLY_F4 * prim,int trans,int x,int y,int w,int h,u_long color);   /* SYM 420255 @0x800d2634 */
void Hud_BuildG4(POLY_G4 * prim,int trans,int x,int y,int w,int h,u_long col1,u_long col2,u_long col3,u_long col4);   /* SYM 420281 @0x800d26d8 */
void Hud_BuildF4o(POLY_F4 * prim,int trans,int x,int y,int w,int h,u_long color,signed char x0off,signed char x1off);   /* SYM 4202b3 @0x800d2794 */
void Hud_FBuildGT4(HudPmx_tShape * shape,int x,int y,u_long col1);   /* SYM 4202e4 @0x800d2868 */
void Hud_FBuildFT4(HudPmx_tShape * shape,int x,int y,u_long col1);   /* SYM 420316 @0x800d28f4 */
void Hud_FBuildF4(int transparent,int x,int y,int w,int h,u_long col1,char x0off,char x1off);   /* SYM 420348 @0x800d2984 */
void Hud_Kill(void);   /* SYM 42038a @0x800d2aa4 */
void Hud_Init0(void);   /* SYM 4203a4 @0x800d2af4 */
void Hud_InitMapFrame(int i,int mode);   /* SYM 4203bf @0x800d2b4c */
void Hud_BuildTimeSprites(SPRT * sprt,char * str,int x,int y);   /* SYM 4203e2 @0x800d2ef8 */
void Hud_Init(void);   /* SYM 420411 @0x800d302c */
void Hud_InitTables(void);   /* SYM 42042b @0x800d39ec */
void Hud_BuildETimeString(SPRT * sprt,int time);   /* SYM 42044b @0x800d3a18 */
bool Hud_BuildDistanceString(SPRT * sprt,int player);   /* SYM 420477 @0x800d3ba4 */
void Hud_BuildTimeString(SPRT * sprt,int time);   /* SYM 4204a6 @0x800d3d44 */
void Hud_BuildTach(int player);   /* SYM 4204d1 @0x800d3e94 */
int Hud_BuildString(char * str,int x,int y,int color,int player,bool justwidth);   /* SYM 4204f0 @0x800d42c8 */
void Hud_BuildNumbers0(int player);   /* SYM 420517 @0x800d4624 */
void Hud_BuildNumbers(int player);   /* SYM 42053a @0x800d4e70 */
void Hud_InitMap(void);   /* SYM 42055c @0x800d5a48 */
void Hud_BuildMapMarkers(int player);   /* SYM 420579 @0x800d5ae8 */
void Hud_WingmanFlash(int player,int index);   /* SYM 42059e @0x800d5fb8 */
void Hud_BuildWingmanInterface(int player);   /* SYM 4205c1 @0x800d606c */
void Hud_InitCdPlayer(void);   /* SYM 4205ec @0x800d63b8 */
void Hud_BuildCdPlayer(int type,int);   /* SYM 42060e @0x800d63dc */
int Hud_BuildRadar(int player);   /* SYM 420632 @0x800d6b48 */
void Hud_BuildReplay(void);   /* SYM 420652 @0x800d7250 */
int Hud_NextPlayer(int player);   /* SYM 420673 @0x800d754c */
char * Hud_NextPlayerNameOrCarOrTime(int player);   /* SYM 420693 @0x800d76b0 */
void Hud_RenderMapView(void);   /* SYM 4206c2 @0x800d7838 */
void Hud_BlackThinBox(int x,int y,int w,int h);   /* SYM 4206e5 @0x800d7abc */
void Hud_Draw321Num(int x,int y,int num,int flare_intensity,int,int);   /* SYM 42070a @0x800d7ca8 */
void Hud_Render321Go(void);   /* SYM 42072f @0x800d7e64 */
void BigBTCTime(int secs);   /* SYM 420750 @0x800d7fb0 */
void Hud_RenderHudView(void);   /* SYM 42076c @0x800d82d0 */
void Hud_RenderTacView(void);   /* SYM 42078f @0x800d8c48 */
void Hud_ParseTime(int nTime,char * sLapTime);   /* SYM 4207b2 @0x800d8d64 */
void Hud_RenderPauseBox(int x,int y,int w,int h);   /* SYM 4207d3 @0x800d8ed0 */
void Hud_Render(void);   /* SYM 4207fa @0x800d9058 */
void Hud_PositionMap(void);   /* SYM 420816 @0x800d94c0 */
void Hud_BTC_Update(char * perpname,int timeleft,bool userHasControl);   /* SYM 420837 @0x800d95c8 */
void Hud_BustedOverlayOn(int time,char * name,bool caught,short player);   /* SYM 42085a @0x800d962c */
void Hud_BustedOverlayOff(void);   /* SYM 420883 @0x800d97e4 */
void Hud_Reset(void);   /* SYM 4208a9 @0x800d97f0 */
void Hud_BTC_QuitOut(void);   /* SYM 4208c4 @0x800d9848 */
void Hud_BTC_BonusTime(long extratime);   /* SYM 4208e5 @0x800d990c */
void Hud_Perp_OverlayOn(int player,int level);   /* SYM 420908 @0x800d9924 */
void Hud_Perp_OverlayOff(int player);   /* SYM 42092d @0x800d9950 */

#endif /* _GAME_PSX_HUD_H_ */
