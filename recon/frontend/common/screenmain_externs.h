/* frontend/screens/screenmain_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENMAIN_EXTERNS_H_
#define _FE_SCREENS_SCREENMAIN_EXTERNS_H_
#include "screenmain_types.h"

extern "C" int rand(void);
extern "C" int sprintf(char *, const char *, ...);
extern "C" unsigned short GetClut(int, int);
extern "C" int GetTPage(...);
extern "C" int ClearImage(...);
extern "C" long DrawSync(...);
extern "C" int gettick(void);
extern "C" int purgememadr(...);

/* ===== globals ===== */
extern tfrontEnd          frontEnd;
extern tGlobalMenuDefs   *menuDefs;
extern tFEApplication    *FEApp;
extern int                ticks;
extern char              *Paths_Paths[];
extern tCreditManager     CreditManager;

/* ===== statics owned by ScreenMain.obj ===== */
extern tScreenMain       *screenMain;                /* EXT @0x80051E58 */
static char  tvOrder[16] = {5,14,3,8,6,0,11,13,2,15,4,10,1,12,7,9};   /* STAT @0x80051AA8 */
static int   tintColors[28] = {                                       /* STAT @0x80051AB8 */
    0x216b8e,0x216b8e,0x293700,0x293700,0x5c2a18,0x5c2a18,0x5c2a18,0x5c2a18,
    0x216b8e,0x216b8e,0x5c2a18,0x5c2a18,0x0c0c4d,0x0c0c4d,0x0c0c4d,0x0c0c4d,
    0x293700,0x293700,0x694d3e,0x694d3e,0x5c2a18,0x5c2a18,0x0c0c4d,0x0c0c4d,
    0x694d3e,0x694d3e,0x5f4431,0x5f4431};
static tVertex dropShadow[4][4] = {                                   /* STAT @0x80051B28 */
    {{163,42},{163,210},{183,52},{183,200}},
    {{163,42},{483,42},{183,52},{463,52}},
    {{483,42},{483,210},{463,52},{463,200}},
    {{163,210},{483,210},{183,200},{463,200}}};
static tVertex animLocations[4] = {{163,42},{403,42},{163,168},{403,168}};   /* STAT @0x80051B68 */
static char  numberValues[25];                       /* STAT @0x80052B90 (rand-filled at init) */
static char  gNameBuffer[32];                        /* STAT @0x80052BB0 */
static char  gPermBuffer[32];                         /* STAT @0x80052BD0 */

/* ===== free helpers (member fns rendered free by Ghidra; tScreen* first arg where applicable) ===== */
bool IsShapeFileLoaded(tScreen*, tShapeInformation*) asm("IsShapeFileLoaded__7tScreenR17tShapeInformation");
void  UploadShapes(tScreen*, tShapeInformation*, short, short, int, int) asm("UploadShapes__7tScreenR17tShapeInformationssss");
void  UploadSwapShapes(tScreen*, int) asm("UploadSwapShapes__7tScreeni");
void  AsyncLoadSwapShapeFile(tScreen*, char*) asm("AsyncLoadSwapShapeFile__7tScreenPc");
void  AsyncLoadShapeFile(tScreen*, char*, tShapeInformation*) asm("AsyncLoadShapeFile__7tScreenPcR17tShapeInformation");
void  InitializeShapes(tScreen*, tShapeInformation*, unsigned int) asm("InitializeShapes__7tScreenR17tShapeInformationUi");
void  FreeShapes(tScreen*, tShapeInformation*) asm("FreeShapes__7tScreenR17tShapeInformation");
void  DrawBackgroundImage(tScreen*, int, int, tTexture_ShapeInfo*, int) asm("DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi");

/* drawing / text / TV */
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
void  ScaleShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
void  PSXDrawTransSquare(int, int, int, int, int, short);
void  PSXDrawSquare(int, int, int, int, int);
void  FeDraw_SetABRMode(int);
void  FETextRender_SetABR(int, bool);
void  FETextRender_WordWrapTextRGB(char*, RECT&, int);
int   CalcFadeVal(int, int);
char *TextSys_Word(int);
void  DrawTV(tTVConfig*) asm("DrawTV__FR9tTVConfig");
void  InitTV(tTVConfig*, tTexture_ShapeInfo*, short) asm("InitTV__FR9tTVConfigP18tTexture_ShapeInfos");
void  TurnOnTV(tTVConfig*) asm("TurnOnTV__FR9tTVConfig");
void  TurnOffTV(tTVConfig*) asm("TurnOffTV__FR9tTVConfig");

/* credits manager (member fns rendered free by Ghidra) */
void  Init(tCreditManager*, u_long) asm("Init__14tCreditManageri");
void  DeInit(tCreditManager*) asm("DeInit__14tCreditManager");
void  Draw(tCreditManager*, int) asm("Draw__14tCreditManagerb");

/* video / credits / misc */
int   VIDEO_create(int, int, int, int, int);
void  VIDEO_spoolfile(int, char*);
void  VIDEO_startplayback(int);
void  VIDEO_abortplayback(int);
void  VIDEO_destroy(int);
int   VIDEO_state(int);
int   VIDEO_updateframexy(int, int, int);
void  FeAudio_systemtask(int);

#endif
