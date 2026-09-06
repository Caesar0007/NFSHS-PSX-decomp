/* Frozen original recon/game/psx/hud.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Hud_CreateHudViews__Fv(void);   /* :273 */
void Hud_GoTpage__Fi(int page);   /* :380 */
void Hud_DebugInfo__Fv(void);   /* :479 */
void Hud_DebugCrap__Fv(void);   /* :536 */
void Hud_BuildSprite__FP4SPRTiiiUli(SPRT *sprt, int shapeIdx, int x, int y, u_long color, int trans);   /* :556 */
void Hud_BuildSprite2__FP4SPRTiii(SPRT *sprt, int shapeIdx, int x, int y);   /* :573 */
void Hud_FBuildSprite__FiiiUli(int shapeIdx, int x, int y, u_long color, int trans);   /* :579 */
void Hud_BuildSpriteFromFont__FP4SPRTcii(SPRT *sprt, char ch, int x, int y);   /* :586 */
void Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl(POLY_F3 *prim, HudPmx_tShape *shape, int x, int y, u_long color);   /* :620 */
void Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl(POLY_GT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color);   /* :629 */
void Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli(POLY_FT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color, int trans);   /* :647 */
void Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli(POLY_FT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color, int trans);   /* :662 */
void Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli(POLY_FT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color, int trans);   /* :682 */
void Hud_BuildF4__FP7POLY_F4iiiiiUl(POLY_F4 *prim, int trans, int x, int y, int w, int h, u_long color);   /* :712 */
void Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl(POLY_G4 *prim, int trans, int x, int y, int w, int h, u_long col1, u_long col2, u_long col3, u_long col4);   /* :728 */
void Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc(POLY_F4 *prim, int trans, int x, int y, int w, int h, u_long color, int x0off, int x1off);   /* :747 */
void Hud_FBuildGT4__FP13HudPmx_tShapeiiUl(HudPmx_tShape *shape, int x, int y, u_long col1);   /* :762 */
void Hud_FBuildFT4__FP13HudPmx_tShapeiiUl(HudPmx_tShape *shape, int x, int y, u_long col1);   /* :768 */
void Hud_FBuildF4__FiiiiiUlcc(int transparent, int x, int y, int w, int h, u_long col1, int x0off, int x1off);   /* :776 */
void uppercase__FPc(char *string);   /* :790 */
void Hud_Kill__Fv(void);   /* :800 */
void Hud_Init0__Fv(void);   /* :813 */
void Hud_InitMapFrame__Fii(int i, int mode);   /* :827 */
void Hud_BuildTimeSprites__FP4SPRTPcii(SPRT *sprt, char *str, int x, int y);   /* :883 */
void Hud_Init__Fv(void);   /* :930 */
void Hud_InitTables__Fv(void);   /* :1227 */
void Hud_BuildETimeString__FP4SPRTi(SPRT *sprt, int time);   /* :1232 */
BOOL Hud_BuildDistanceString__FP4SPRTi(SPRT *sprt, int player);   /* :1253 */
void Hud_BuildTimeString__FP4SPRTi(SPRT *sprt, int time);   /* :1273 */
void Hud_BuildTach__Fi(int player);   /* :1376 */
int Hud_BuildString__FPciiiib(char *str, int x, int y, int color, int player, BOOL justwidth);   /* :1450 */
void Hud_BuildNumbers0__Fi(int player);   /* :1551 */
void Hud_BuildNumbers__Fi(int player);   /* :1721 */
void Hud_InitMap__Fv(void);   /* :1917 */
void Hud_BuildMapMarkers__Fi(int player);   /* :2019 */
void Hud_WingmanFlash__Fii(int player, int index);   /* :2148 */
void Hud_BuildWingmanInterface__Fi(int player);   /* :2162 */
void Hud_InitCdPlayer__Fv(void);   /* :2215 */
void Hud_BuildCdPlayer__Fii(int type);   /* :2225 */
int Hud_BuildRadar__Fi(int player);   /* :2497 */
void Hud_BuildReplay__Fv(void);   /* :2752 */
int Hud_NextPlayer__Fi(int player);   /* :2862 */
char * Hud_NextPlayerNameOrCarOrTime__Fi(int player);   /* :2895 */
void Hud_RenderMapView__Fv(void);   /* :2935 */
void Hud_BlackThinBox__Fiiii(int x, int y, int w, int h);   /* :3082 */
void Hud_Draw321Num__Fiiiiii(int x, int y, int num, int flare_intensity);   /* :3155 */
void Hud_Render321Go__Fv(void);   /* :3261 */
void BigBTCTime__Fi(int secs);   /* :3345 */
void Hud_RenderHudView__Fv(void);   /* :3426 */
void Hud_RenderTacView__Fv(void);   /* :3744 */
void Hud_ParseTime__FiPc(int nTime, char *sLapTime);   /* :3770 */
void Hud_RenderPauseBox__Fiiii(int x, int y, int w, int h);   /* :3812 */
void Hud_Render__Fv(void);   /* :3846 */
void Hud_PositionMap__Fv(void);   /* :3980 */
void Hud_BTC_Update__FPcib(char *perpname, int timeleft, BOOL userHasControl);   /* :3998 */
void Hud_BustedOverlayOn__FiPcbs(int time, char *name, BOOL caught, short player);   /* :4009 */
void Hud_BustedOverlayOff__Fv(void);   /* :4051 */
void Hud_Reset__Fv(void);   /* :4056 */
void Hud_BTC_QuitOut__Fv(void);   /* :4074 */
void Hud_BTC_BonusTime__Fl(long extratime);   /* :4091 */
void Hud_Perp_OverlayOn__Fii(int player, int level);   /* :4100 */
void Hud_Perp_OverlayOff__Fi(int player);   /* :4106 */
void (*p875_probe_0)(void) = &Hud_CreateHudViews__Fv;
void (*p875_probe_1)(int page) = &Hud_GoTpage__Fi;
void (*p875_probe_2)(void) = &Hud_DebugInfo__Fv;
void (*p875_probe_3)(void) = &Hud_DebugCrap__Fv;
void (*p875_probe_4)(SPRT *sprt, int shapeIdx, int x, int y, u_long color, int trans) = &Hud_BuildSprite__FP4SPRTiiiUli;
void (*p875_probe_5)(SPRT *sprt, int shapeIdx, int x, int y) = &Hud_BuildSprite2__FP4SPRTiii;
void (*p875_probe_6)(int shapeIdx, int x, int y, u_long color, int trans) = &Hud_FBuildSprite__FiiiUli;
void (*p875_probe_7)(SPRT *sprt, char ch, int x, int y) = &Hud_BuildSpriteFromFont__FP4SPRTcii;
void (*p875_probe_8)(POLY_F3 *prim, HudPmx_tShape *shape, int x, int y, u_long color) = &Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl;
void (*p875_probe_9)(POLY_GT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color) = &Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl;
void (*p875_probe_10)(POLY_FT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color, int trans) = &Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli;
void (*p875_probe_11)(POLY_FT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color, int trans) = &Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli;
void (*p875_probe_12)(POLY_FT4 *prim, HudPmx_tShape *shape, int x, int y, u_long color, int trans) = &Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli;
void (*p875_probe_13)(POLY_F4 *prim, int trans, int x, int y, int w, int h, u_long color) = &Hud_BuildF4__FP7POLY_F4iiiiiUl;
void (*p875_probe_14)(POLY_G4 *prim, int trans, int x, int y, int w, int h, u_long col1, u_long col2, u_long col3, u_long col4) = &Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl;
void (*p875_probe_15)(POLY_F4 *prim, int trans, int x, int y, int w, int h, u_long color, int x0off, int x1off) = &Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc;
void (*p875_probe_16)(HudPmx_tShape *shape, int x, int y, u_long col1) = &Hud_FBuildGT4__FP13HudPmx_tShapeiiUl;
void (*p875_probe_17)(HudPmx_tShape *shape, int x, int y, u_long col1) = &Hud_FBuildFT4__FP13HudPmx_tShapeiiUl;
void (*p875_probe_18)(int transparent, int x, int y, int w, int h, u_long col1, int x0off, int x1off) = &Hud_FBuildF4__FiiiiiUlcc;
void (*p875_probe_19)(char *string) = &uppercase__FPc;
void (*p875_probe_20)(void) = &Hud_Kill__Fv;
void (*p875_probe_21)(void) = &Hud_Init0__Fv;
void (*p875_probe_22)(int i, int mode) = &Hud_InitMapFrame__Fii;
void (*p875_probe_23)(SPRT *sprt, char *str, int x, int y) = &Hud_BuildTimeSprites__FP4SPRTPcii;
void (*p875_probe_24)(void) = &Hud_Init__Fv;
void (*p875_probe_25)(void) = &Hud_InitTables__Fv;
void (*p875_probe_26)(SPRT *sprt, int time) = &Hud_BuildETimeString__FP4SPRTi;
BOOL (*p875_probe_27)(SPRT *sprt, int player) = &Hud_BuildDistanceString__FP4SPRTi;
void (*p875_probe_28)(SPRT *sprt, int time) = &Hud_BuildTimeString__FP4SPRTi;
void (*p875_probe_29)(int player) = &Hud_BuildTach__Fi;
int (*p875_probe_30)(char *str, int x, int y, int color, int player, BOOL justwidth) = &Hud_BuildString__FPciiiib;
void (*p875_probe_31)(int player) = &Hud_BuildNumbers0__Fi;
void (*p875_probe_32)(int player) = &Hud_BuildNumbers__Fi;
void (*p875_probe_33)(void) = &Hud_InitMap__Fv;
void (*p875_probe_34)(int player) = &Hud_BuildMapMarkers__Fi;
void (*p875_probe_35)(int player, int index) = &Hud_WingmanFlash__Fii;
void (*p875_probe_36)(int player) = &Hud_BuildWingmanInterface__Fi;
void (*p875_probe_37)(void) = &Hud_InitCdPlayer__Fv;
void (*p875_probe_38)(int type) = &Hud_BuildCdPlayer__Fii;
int (*p875_probe_39)(int player) = &Hud_BuildRadar__Fi;
void (*p875_probe_40)(void) = &Hud_BuildReplay__Fv;
int (*p875_probe_41)(int player) = &Hud_NextPlayer__Fi;
char * (*p875_probe_42)(int player) = &Hud_NextPlayerNameOrCarOrTime__Fi;
void (*p875_probe_43)(void) = &Hud_RenderMapView__Fv;
void (*p875_probe_44)(int x, int y, int w, int h) = &Hud_BlackThinBox__Fiiii;
void (*p875_probe_45)(int x, int y, int num, int flare_intensity) = &Hud_Draw321Num__Fiiiiii;
void (*p875_probe_46)(void) = &Hud_Render321Go__Fv;
void (*p875_probe_47)(int secs) = &BigBTCTime__Fi;
void (*p875_probe_48)(void) = &Hud_RenderHudView__Fv;
void (*p875_probe_49)(void) = &Hud_RenderTacView__Fv;
void (*p875_probe_50)(int nTime, char *sLapTime) = &Hud_ParseTime__FiPc;
void (*p875_probe_51)(int x, int y, int w, int h) = &Hud_RenderPauseBox__Fiiii;
void (*p875_probe_52)(void) = &Hud_Render__Fv;
void (*p875_probe_53)(void) = &Hud_PositionMap__Fv;
void (*p875_probe_54)(char *perpname, int timeleft, BOOL userHasControl) = &Hud_BTC_Update__FPcib;
void (*p875_probe_55)(int time, char *name, BOOL caught, short player) = &Hud_BustedOverlayOn__FiPcbs;
void (*p875_probe_56)(void) = &Hud_BustedOverlayOff__Fv;
void (*p875_probe_57)(void) = &Hud_Reset__Fv;
void (*p875_probe_58)(void) = &Hud_BTC_QuitOut__Fv;
void (*p875_probe_59)(long extratime) = &Hud_BTC_BonusTime__Fl;
void (*p875_probe_60)(int player, int level) = &Hud_Perp_OverlayOn__Fii;
void (*p875_probe_61)(int player) = &Hud_Perp_OverlayOff__Fi;
