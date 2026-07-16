/* frontend/screens/screencarselect_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENCARSELECT_EXTERNS_H_
#define _FE_SCREENS_SCREENCARSELECT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
typedef int code(...);   /* Ghidra fn-ptr type for vtable dispatch */
extern int _i, _reflection;   /* DrawCar Ghidra phantom locals */

/* ===== globals ===== */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tTrackManager      trackManager;
extern tGlobalMenuDefs   *menuDefs;
extern tFEApplication    *FEApp;
extern int                ticks;
extern char              *Paths_Paths[];
extern int                kRGBVals[28];
extern char               textDefinitions[14][6];
extern tPadModuleState    gPadinfo;
extern int                screenheight, showRoomFlag, gFlip, gStopCommentaryNow;
extern int                gShowroomLights[];   /* store-[] lever: cc1 materialises addr in a genreg (sw $0,%lo($v0)) not $at */
extern int gMenuRotate[2];
extern u_long             gCameraRotation;
extern int *gCView;
extern Car_tObj *gCarObj[2];
char *PlayerName(...);
extern char               CURRENTLYUSINGMEMCARD;
extern GameSetup_tData GameSetup_gData;
extern tCarManager carManager;
void DrawC_MenuColorData(...);
extern int DrawC_gMenuLights, DrawC_gMenuLightsDirection;

/* ===== statics owned by ScreenCarSelect.obj ===== */
extern PinkSlipsCarSelectState PinkSlipsScreenState[2];
static int  gKnots[8][5] = {              /* STAT @0x80051e78 spline knots (byte-exact from image) */
    {491520, -524288, 17039360, 131072, 0},
    {491520, -524288, 17039360, 131072, 0},
    {196608, -524288, 17039360, 6684672, 11206656},
    {196608, -524288, 17039360, 6684672, 22347776},
    {688128, -524288, 17039360, -4718592, 33554432},
    {196608, -524288, 17039360, 6684672, 44761088},
    {196608, -524288, 17039360, 6684672, 55902208},
    {196608, -524288, 17039360, 6684672, 55902208}
};
static int  gCatmullRom[4][4] = {         /* STAT @0x80051f18 Catmull-Rom basis (16.16) */
    {-65536, 196608, -196608, 65536},
    {131072, -327680, 262144, -65536},
    {-65536, 0, 65536, 0},
    {0, 131072, 0, 0}
};
static tCarStatType remap[5] = { (tCarStatType)0, (tCarStatType)2, (tCarStatType)1, (tCarStatType)3, (tCarStatType)4 };  /* STAT @0x80051f58 */
static short textVals[5], text2PVals[5];  /* STAT @0x80051f6c/f78 */
static short tvOrder[10], tvSplitOrder[5];/* STAT @0x80051f84/f98 */
static char gStateOverlays[1][32] = {     /* STAT @0x80051fa4 (byte-exact) */
    {-1, 6, 0, -1, 4, 6, 0, -1, -1, 6, 2, -1, 4, 6, 1, -1, -1, 6, 3, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
};
static char gOverlayPositions[1][112] = { /* STAT @0x80051fc4 (byte-exact) */
    {34, 1, 0, 1, -56, 0, 12, 0, 34, 1, -56, 0, -56, 0, 12, 0,
     -43, 0, 0, 1, 32, 1, 41, 0, -43, 0, -71, 0, 32, 1, 41, 0,
     -43, 0, 0, 1, 32, 1, 41, 0, -43, 0, -71, 0, 32, 1, 41, 0,
     -43, 0, 0, 1, 32, 1, 41, 0, -43, 0, -71, 0, 32, 1, 41, 0,
     69, 1, 5, 0, -94, 0, 24, 0, 69, 1, 29, 0, -94, 0, 24, 0,
     -17, 1, 21, 0, 3, 0, 3, 0, -43, 0, 21, 0, 29, 1, 105, 0,
     -120, -1, -120, 0, -126, 0, 77, 0, 0, 0, -120, 0, -126, 0, 77, 0}
};
static int  gRotateOffset[4];             /* STAT @0x80052c18 */
static char gSwapFileName[2][40];         /* STAT @0x80052c28 */
static char WaitingString[50];            /* STAT @0x80052c58 */
/* vtable data refs (Ghidra _DAT_) + per-class vtables */
extern __vtbl_ptr_type tScreenCarSelect_vtable[], tScreenCarSelectDuel_vtable[], tScreenCarSelectTwoPlayer_vtable[], tScreenPinkSlipsCarSelect_vtable[];
/* singletons (EXT) */
tScreenCarSelect *screenCarSelect;

/* ===== base ctor/dtor helpers ===== */
void tScreen_ctor(tScreen*); void tScreen_dtor(tScreen*, int __in_chrg);
void tScreenCarSelect_ctor(tScreenCarSelect*); void tScreenCarSelect_dtor(tScreenCarSelect*);
void tScreenCarSelectTwoPlayer_ctor(tScreenCarSelectTwoPlayer*); void tScreenCarSelectTwoPlayer_dtor(tScreenCarSelectTwoPlayer*);
void tScreenCarSelectDuel_dtor(tScreenCarSelectDuel*); void tScreenPinkSlipsCarSelect_dtor(tScreenPinkSlipsCarSelect*);

/* ===== tScreen helpers (free-fn form) ===== */
void  DrawBackgroundImage(tScreen*, int, int, tTexture_ShapeInfo*, int);
void *IsShapeFileLoaded(tScreen*, tShapeInformation*);
void  UploadShapes(...);
void  FreeShapes(tScreen*, tShapeInformation*);
void  InitializeShapes(tScreen*, tShapeInformation*, int);
void  AsyncLoadSwapShapeFile(tScreen*, char*);
void  AsyncLoadShapeFile(tScreen*, char*, tShapeInformation*);
void TransitionOff(...); void TransitionOn(...);

/* ===== tVideoWall methods (free-fn form) ===== */
void TurnOn(tVideoWall*); void TurnOff(tVideoWall*); void TurnOffInstant(tVideoWall*);
void UpdateImages(tVideoWall*); void UpdateTransition(tVideoWall*); void Draw(tVideoWall*);
void SetAvailable(tVideoWall*, unsigned short); void SetAvailableText(tVideoWall*, short, short, short);
void  SetAvailableIcon(...);
void Initialize(tVideoWall*, tTVConfig*, tTexture_ShapeInfo*, short, short, short*, short);

/* ===== FE / game / PsyQ helpers ===== */
int   CalcFadeVal(int, int);
char *TextSys_Word(int); int TextSys_WordX(int); int TextSys_WordY(int); int TextSys_WordFlags(int);
short TextValue(void*, tPlayer); void Decrement(void*, tPlayer); void Increment(void*, tPlayer);
void  DrawMoney(...);
void  DrawShapeExtended(...);
void  DrawShape_NFS4Rectangle(...); void DrawShape_NFS4RoundRectangle(int, RECT*, short);
void  DrawSlider(...);
void  PSXDrawSquare(int,int,int,int,int);
void  FETextRender_FullTextRGB(...);
void  FETextRender_MenuTextPositionedJustify(short, short, short, short, tMenuTextState, tMenuTextType);
void FETextRender_WordWrap(...);
void  FeAudio_AsyncPlaySpeech(...);
void *FECheat_IsCheatEnabled(...);
int  GetNumPinkSlipsCars(...);
void*  GetStockCar(...); void GetTrack(tTrackManager*, unsigned short, void*);
tTrackInformation *GetTrackByID(tTrackManager*, short); void GetTrackToRace(tTournamentManager*, void*);
int   LoadGame(...);
void  MCRD_handlecardevents(...);
char *Platform_GetDCTBuffer(...); void Platform_ResetDCTBuffer();
void  Draw_MenuRenderingView(...); extern void *Draw_gPlayer1View;   /* int def in render.cpp */
void  SetOffset(...);
void  SetValid(...); void Hide(void*); void Display(void*); void Redraw(void*);


/* re-added (varargs; one per line to avoid shared-line breakage) */
void  AudioMus_StopSong(...); void  CleanupSpinningCarsMenu(...); void  DeInit_Memcard(...);
void  DrawShape_NFS4TransRectangle(...); void  FETextRender_MenuTextPositioned(...); void  Init_Memcard(...);
 void  SetLicensePlate(...); void  TransformVector(...); void  UploadSwapShapes(...);
int CalcUsedPrice(...); long CheapestCarStockPrice(...); int GetNumOwnedCars(...); int GetNumTourneyCars(...);
CARDINFO_def *MCRD_getcard(...);
void *Draw_GetDRAWENV(...); void *GetGarageCar(...); void *GetPinkSlipsCar(...); void *GetStockCar(...);

void PreLoad(tScreen*);
#endif
