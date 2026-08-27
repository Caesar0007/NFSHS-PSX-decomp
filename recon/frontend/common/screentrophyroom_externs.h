/* frontend/screens/screentrophyroom_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTROPHYROOM_EXTERNS_H_
#define _FE_SCREENS_SCREENTROPHYROOM_EXTERNS_H_
#include "screentrophyroom_types.h"

/* --- globals --- */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tGlobalMenuDefs   *menuDefs;
extern int                ticks;
extern tTexture_ShapeInfo *gCurrentShapes;
extern tPadModuleState    gPadinfo;

/* --- data owned by ScreenTrophyRoom.obj (EXT linkage) --- */
tScreenTrophyRoom *screenTrophyRoom;                 /* EXT @0x80052060 (runtime-set) */
char gSwapFileName[16];                              /* EXT @0x80052064 */
extern __vtbl_ptr_type tScreenTrophyRoom_vtable[];              /* _vt.17tScreenTrophyRoom @0x80011e28 */

/* --- base tScreen ctor/dtor (name==class -> rendered as free helpers) --- */
void tScreen_ctor(tScreen *s);
void tScreen_dtor(tScreen *s);

/* --- tScreen helpers (base passed explicitly) --- */
void  DrawBackgroundImage(tScreen *s, int startShape, int numShapes, tTexture_ShapeInfo *shapes, int flip) asm("DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi");
bool IsShapeFileLoaded(tScreen *s, tShapeInformation *shp) asm("IsShapeFileLoaded__7tScreenR17tShapeInformation");
void  UploadSwapShapes(tScreen *s, int n) asm("UploadSwapShapes__7tScreeni");
void  InitializeShapes(tScreen *s, tShapeInformation *shp, int n) asm("InitializeShapes__7tScreenR17tShapeInformationUi");
void  AsyncLoadShapeFile(tScreen *s, char *name, tShapeInformation *shp) asm("AsyncLoadShapeFile__7tScreenPcR17tShapeInformation");
void  AsyncLoadSwapShapeFile(tScreen *s, char *name) asm("AsyncLoadSwapShapeFile__7tScreenPc");
void  FreeShapes(tScreen *s, tShapeInformation *shp) asm("FreeShapes__7tScreenR17tShapeInformation");
void  PreLoad(tScreen *s) asm("PreLoad__7tScreen");
void  ProcessInput(tScreen *s, tPlayer p, tInputKeyType &k, tMenuCommand &c) asm("ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand");

/* --- FE / game / PsyQ helpers (de-namespaced) --- */
void  GetTrophyName(tTournamentManager *tm, tTourneyInfo *ti, tTrophySize sz, char *buf, int n) asm("GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci");
void  AudioCmn_PlayFESFX(int sfx);
void  FETexture_LoadPmxAtOffset(char *file, int off, tTexture_ShapeInfo *shapes, int a, int b);
void  DrawShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  ScaleShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  PSXDrawBrightEndLine(int a, int b, int c, int d, int e, int f, int g, int h);
void  FETextRender_MenuTextPositionedJustifyFade(int fade, short index, short x, short y, short j, tMenuTextState st, tMenuTextType tt)
    asm("FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType");
char *TextSys_Word(int id);
int   CalcFadeVal(int rgb, int amount);
void  FETextRender_FullTextRGB(char *s, short x, short y, int rgb, char a, short b);

extern "C" {
int purgememadr(void *);
int systemtask(int);
}

#endif
