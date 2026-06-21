/* frontend/psx/psxfront_externs.h - reconstructed extern decls (from Ghidra signatures).
 * NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_PSXFRONT_EXTERNS_H_
#define _FRONTEND_PSX_PSXFRONT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

typedef void EAC_timerproc(void);   /* fn type; EAC_timerproc* = void(*)(void) */

extern "C" {
void AudioCmn_LoadFESamples(void);
void Audio_DeInitDriver(void);
void Audio_InitDriver(int buffersize, int spusize);
void CarIO_CleanUp(void);
void CarIO_ReStart(void);
void CarIO_StartUp(void);
void ClearPrimitivesBuffer(void);
void DrawC_ReadeMapData(void);
void Draw_DirectSetEnvironment(int x, int y, int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);
void Draw_InitViewOT(void);
void Draw_InitViews(void);
int Draw_SetView(int x0, int y0, int x1, int y1, int w, int h, int dtd, int isbg, int otsize);
void Draw_SetViewMemBudget(int viewid, int totalmem);
void FETextRender_SetABR(int abr, bool trans);
void FETexture_LoadPmx(char * f, int index, tTexture_ShapeInfo * dest);
void Fe3D_InitShowroom(void);
void FeTools_init(void);
void Front_InitialMemCardCheck(void);
void Front_SecondaryMemCardCheck(void);
void Platform_ResetDCTBuffer(void);
void R3DCar_CleanUp(void);
void R3DCar_DeInstantiate3DCar(Car_tObj * carObj);
void R3DCar_DeInstantiate3DCarMenu(Car_tObj * carObj);
void R3DCar_Instantiate3DCar(Car_tObj * carObj, int index);
void R3DCar_PostStartUp(void);
void R3DCar_StartUp(void);
void SetPlayList(int ivealreadygotone);
void TextSys_LoadWords(int language);
void Texture_CleanupMenuTexture(void);
void Texture_InitMenuClut(void);
void Texture_InitMenuTexture(void);
void Texture_KillMenuTexture(void);
int elapsedticks(void);
int play_movie(char movie);
void trap(int code);
   /* eaclib timer proc (from pad.c) */

/* --- external game globals (Ghidra-typed) --- */
extern u_char CF_DVLC[49096];
extern int ComingIntoTheFrontEndTheVeryFirstTime;
extern int DrawC_gMenuColor[2];
extern int DrawC_gMenuLights;
extern int DrawC_gMenuLightsDirection;
extern int Draw_gDoVSync;
extern int Draw_gPlayer1View;
extern int Draw_gRearView;
extern char GameSetup_gCarNames[51][5];
extern GameSetup_tData GameSetup_gData;
extern char *Paths_Paths[50];
extern int R3DCar_InMenu;
extern u_char *Render_gPacketPtr;   /* GPU packet build cursor (byte-arith) */
extern u_char *Render_gPalettePtr;   /* GPU packet build cursor (byte-arith) */
extern u_long font_tint;
extern tfrontEnd frontEnd;
extern DRender_tView gCView;
extern tTexture_ShapeInfo *gCurrentShapes;
extern dflip gEnviro[2];
extern int gFlip;
extern u_short gFontClut;
extern int gMenuRotate[2];
extern int inFrontEnd;
extern int screenbpp;
extern int screenwidth;
}
#endif