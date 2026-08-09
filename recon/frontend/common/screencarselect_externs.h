/* frontend/screens/screencarselect_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENCARSELECT_EXTERNS_H_
#define _FE_SCREENS_SCREENCARSELECT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
typedef int code(...);   /* Ghidra fn-ptr type for vtable dispatch */

/* ===== globals ===== */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tTrackManager      trackManager;
extern tGlobalMenuDefs   *menuDefs;
extern tFEApplication    *FEApp;
extern int                ticks[];
extern char              *Paths_Paths[];
extern int                kRGBVals[28];
extern char               textDefinitions[14][6];
extern tPadModuleState    gPadinfo;
extern int                screenheight, showRoomFlag, gFlip, gStopCommentaryNow;
extern int                gShowroomLights[];   /* store-[] lever: cc1 materialises addr in a genreg (sw $0,%lo($v0)) not $at */
extern int gMenuRotate[2];
extern u_long             gCameraRotation;
extern DRender_tView gCView;   /* W58-A1: real type (render.cpp @0x80116F7C); was mistyped int* */
extern Car_tObj *gCarObj[2];
char *PlayerName(int);
extern char               CURRENTLYUSINGMEMCARD;
extern GameSetup_tData GameSetup_gData;
extern tCarManager carManager;
void DrawC_MenuColorData(int, Car_tObj *, int);
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
static signed char gStateOverlays[8][4] = { /* STAT @0x80051fa4 (byte-exact) */
    {-1, 6, 0, -1},
    { 4, 6, 0, -1},
    {-1, 6, 2, -1},
    { 4, 6, 1, -1},
    {-1, 6, 3,  5},
    {-1,-1,-1, -1},
    {-1,-1,-1, -1},
    {-1,-1,-1, -1}
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
/* W58-A1 (08A phantom fix): the tScreen / tCarManager / tTrackManager / tVideoWall /
 * tDialogBase / tFEApplication entry points below were free `(...)`- or `(void*)`-typed
 * decls that mangled every call site to a symbol the link can never resolve
 * (`..__Fe` / `..__FPv`).  They are MEMBERS -- decls live in nfs4_types.h and the call
 * sites now use obj->Method(...) / obj.Method(...).  Byte-neutral (`this` rides $a0).
 * Removed here: UploadShapes, UploadSwapShapes, TransitionOff, TransitionOn,
 * SetAvailableIcon, SetOffset, SetValid, GetStockCar, GetNumPinkSlipsCars,
 * CalcUsedPrice, CheapestCarStockPrice, GetTrack, Hide, Display, Redraw. */
void  FreeShapes(tScreen*, tShapeInformation*);
void  InitializeShapes(tScreen*, tShapeInformation*, int);
void  AsyncLoadSwapShapeFile(tScreen*, char*);
void  AsyncLoadShapeFile(tScreen*, char*, tShapeInformation*);

/* ===== tVideoWall methods (free-fn form) ===== */
void TurnOn(tVideoWall*); void TurnOff(tVideoWall*); void TurnOffInstant(tVideoWall*);
void UpdateImages(tVideoWall*); void UpdateTransition(tVideoWall*); void Draw(tVideoWall*);
void SetAvailable(tVideoWall*, unsigned short); void SetAvailableText(tVideoWall*, short, short, short);
void Initialize(tVideoWall*, tTVConfig*, tTexture_ShapeInfo*, short, short, short*, short);

/* ===== FE / game / PsyQ helpers ===== */
int   CalcFadeVal(int, int);
char *TextSys_Word(int); int TextSys_WordX(int); int TextSys_WordY(int); int TextSys_WordFlags(int);
/* W58-A1: TextValue/Decrement/Increment are tListIteratorCar members (the free
 * `(void*,tPlayer)` decls mangled to ..__FPv7tPlayer -- an unlinkable phantom). */
void  DrawMoney(int, int, int, long, int, int);
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended *);
/* W58-A1 (08A phantom fix): true prototypes from configs/symbol_addrs.txt --
 * DrawShape_NFS4Rectangle__FR4RECT, DrawShape_NFS4RoundRectangle__FiR4RECTs. */
void  DrawShape_NFS4Rectangle(RECT &); void DrawShape_NFS4RoundRectangle(int, RECT &, short);
void  DrawSlider(short, short, short, short, short, short, short, short, short, bool, bool, short, short);
void  PSXDrawSquare(int,int,int,int,int);
void  FETextRender_FullTextRGB(char *, short, short, int, char, short);
void  FETextRender_MenuTextPositionedJustify(short, short, short, short, tMenuTextState, tMenuTextType);
void FETextRender_WordWrap(short index, RECT &r, tMenuTextState textState,
                           tMenuTextType textType);
void  FeAudio_AsyncPlaySpeech(int, int);
void *FECheat_IsCheatEnabled(tCheatCode);   /* W58-A1: FECheat_IsCheatEnabled__F10tCheatCode */
/* W58-A1: GetTrackByID / GetTrackToRace are tTrackManager / tTournamentManager members. */
int   LoadGame(short, bool, bool);
extern "C" int MCRD_handlecardevents(int);
char *Platform_GetDCTBuffer(int, char *); void Platform_ResetDCTBuffer();
/* W58-A1 (08A phantom fix): Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii.
 * The old `(...)` decl also default-promoted the two float args to double at the call
 * site; the typed form keeps them float.  gCView is a real DRender_tView (render.cpp),
 * not an int* -- the W56-A1 "caller passes int**" note is fixed here at the decl. */
void  Draw_MenuRenderingView(Car_tObj *, DRender_tView *, int, int, int, unsigned long, int, float, float, int, int);
extern void *Draw_gPlayer1View;   /* int def in render.cpp */


/* re-added (varargs; one per line to avoid shared-line breakage) */
void  AudioMus_StopSong(int); void  CleanupSpinningCarsMenu(void); void  DeInit_Memcard(void);
/* W58-A1 (08A phantom fix): DrawShape_NFS4TransRectangle__FR4RECTs,
 * FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType. */
void  DrawShape_NFS4TransRectangle(RECT &, short); void  FETextRender_MenuTextPositioned(short, short, short, tMenuTextState, tMenuTextType); void  Init_Memcard(bool, bool);
 void  SetLicensePlate(void); void  TransformVector(...);
int GetNumOwnedCars(...); int GetNumTourneyCars(...);
extern "C" CARDINFO_def *MCRD_getcard(int);
void *Draw_GetDRAWENV(int, int); void *GetGarageCar(...); void *GetPinkSlipsCar(...);

void PreLoad(tScreen*);
#endif
