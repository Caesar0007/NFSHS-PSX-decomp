#ifndef SCREENPOST_EXTERNS_H
#define SCREENPOST_EXTERNS_H
/* frontend/screens/screencarselect_externs.h - reconstructed externs. NOT original. */
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
extern int                screenheight, showRoomFlag, gFlip, gShowroomLights, gStopCommentaryNow;
extern int gMenuRotate[2];
extern u_long             gCameraRotation;
/* TRUE TYPE (was `int *`; W62-A17, the 10E class): SYM nfs4-f-v3.txt
   `96 Def2 class EXT type STRUCT size 140 tag DRender_tView name gCView` @0x80116f7c,
   matching the owner def in game/common/render.cpp.  A pointer decl here would read the
   struct's own first word as an address. */
extern DRender_tView gCView;
extern Car_tObj *gCarObj[2];
char *PlayerName(int);
/* TRUE TYPE = 4-byte BOOL (was `char`; W62-A17) -- SYM `class EXT type BOOL` @0x80051a7c,
   oracle census 7 lw / 8 sw, zero byte ops; next symbol at +4. */
extern int                CURRENTLYUSINGMEMCARD;
extern GameSetup_tData GameSetup_gData;
extern tCarManager carManager;
void DrawC_MenuColorData(int, Car_tObj *, int);
extern int DrawC_gMenuLights, DrawC_gMenuLightsDirection;

/* ===== ScreenCarSelect.obj ===== */
extern PinkSlipsCarSelectState PinkSlipsScreenState[2];
/* NOTE: the ScreenCarSelect.obj file-statics (gKnots/gCatmullRom/remap/textVals/tvOrder/
 * gStateOverlays/gOverlayPositions/gRotateOffset/gSwapFileName/WaitingString @0x80051e78..0x80052c58)
 * were duplicated here as zero-init `static` decls -- DEAD in this TU (screenpost.cpp never
 * references them) and a per-TU shadow copy of data owned+materialized byte-exact in
 * screencarselect_externs.h. Removed 2026-07-16 (w10-a4 data-audit); they were Category-A
 * scanner noise, not real externs of this TU. */
/* vtable data refs (Ghidra _DAT_) + per-class vtables */
extern __vtbl_ptr_type tScreenCarSelect_vtable[], tScreenCarSelectDuel_vtable[], tScreenCarSelectTwoPlayer_vtable[], tScreenPinkSlipStandings_vtable[];
/* singletons (EXT) */
extern tScreenCarSelect *screenCarSelect;   /* def in screencarselect.cpp */

/* ===== base ctor/dtor helpers ===== */
void tScreen_ctor(tScreen*); void tScreen_dtor(tScreen*);
void tScreenCarSelect_ctor(tScreenCarSelect*); void tScreenCarSelect_dtor(tScreenCarSelect*);
void tScreenCarSelectTwoPlayer_ctor(tScreenCarSelectTwoPlayer*); void tScreenCarSelectTwoPlayer_dtor(tScreenCarSelectTwoPlayer*);
void tScreenCarSelectDuel_dtor(tScreenCarSelectDuel*); void tScreenPinkSlipsCarSelect_dtor(tScreenPinkSlipsCarSelect*);

/* ===== tScreen helpers (free-fn form) ===== */
void  DrawBackgroundImage(tScreen*, int, int, tTexture_ShapeInfo*, int) __asm__("DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi");  /* w64 unlock: member form (A19 2.4) */
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
short TextValue(void*, tPlayer) __asm__("TextValue__23tListIteratorTournament7tPlayer");  /* W65-A3 (calltarget): REVERTS the w64 "hierarchy binds BASE" alias -- the ORACLE is the authority and DrawBackground__26tScreenTournamentStandings's single (tail-merged) jal names the tListIteratorTournament override, which is also the static type of BOTH ternary operands (menuDefs->iteratorSpecialEvent / ->iteratorTournament). */ void Decrement(void*, tPlayer); void Increment(void*, tPlayer);
void  DrawMoney(int, int, int, long, int, int);
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended *);
void  DrawShape_NFS4Rectangle(...); void DrawShape_NFS4RoundRectangle(int, RECT*, short);
void  DrawSlider(short, short, short, short, short, short, short, short, short, bool, bool, short, short);
void  PSXDrawSquare(int,int,int,int,int);
void  FETextRender_FullTextRGB(char *, short, short, int, char, short);
void  FETextRender_MenuTextPositionedJustify(short, short, short, short, tMenuTextState, tMenuTextType);
void FETextRender_WordWrap(...);
void  FeAudio_AsyncPlaySpeech(int, int);
void *FECheat_IsCheatEnabled(...);
int  GetNumPinkSlipsCars(...);
void*  GetStockCar(...);   /* W58-A1: GetTrack is a tTrackManager member (free decl mangled to the unlinkable GetTrack__FP13tTrackManagersPv) */
tTrackInformation *GetTrackByID(tTrackManager*, short); void GetTrackToRace(tTournamentManager*, void*);
int   LoadGame(short, bool, bool);
extern "C" int MCRD_handlecardevents(int);
char *Platform_GetDCTBuffer(int, char *); void Platform_ResetDCTBuffer();
void  Draw_MenuRenderingView(Car_tObj *, DRender_tView *, int, int, int, unsigned long, int, float, float, int, int); extern void *Draw_gPlayer1View;   /* int def in render.cpp */
void  SetOffset(...);
void  SetValid(...); void Hide(void*); void Display(void*); void Redraw(void*);


/* re-added (varargs; one per line to avoid shared-line breakage) */
void  AudioMus_StopSong(int); void  CleanupSpinningCarsMenu(void); void  DeInit_Memcard(void);
void  DrawShape_NFS4TransRectangle(...); void  FETextRender_MenuTextPositioned(...); void  Init_Memcard(bool, bool);
 void  SetLicensePlate(void); void  TransformVector(...); void  UploadSwapShapes(...);
int CalcUsedPrice(...); long CheapestCarStockPrice(...); int GetNumOwnedCars(...); int GetNumTourneyCars(...);
extern "C" CARDINFO_def *MCRD_getcard(int);
void *Draw_GetDRAWENV(int, int); void *GetGarageCar(...); void *GetPinkSlipsCar(...); void *GetStockCar(...);

void PreLoad(tScreen*);

/* --- ScreenPost.obj-specific externs --- */
int   FeTools_FormatMoney(char *out, long amount);
int   FETextRender_FullTextRGB(char *s, short x, short y, int col, char a, int b) __asm__("FETextRender_FullTextRGB__FPcssics");  /* w64 unlock: last parm is short in retail (A19 2.4) */
int   FETextRender_FullTextFade(int, char *, short, short, tMenuTextType, tMenuTextState, short);
/* W58-A1 (08A phantom fix): FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType. */
int   FETextRender_MenuTextPositionedJustifyFade(int, short, short, short, short, tMenuTextState, tMenuTextType);
int   AudioCmn_PlayFESFX(int);
/* W58-A1 (08A phantom fix): CalcTrackFinishDamageBill / GetAwardInformation /
 * PlayerRanking / TournPointTotal are tTournamentManager MEMBERS -- free `(...)`
 * decls dropped; call sites now use tournamentManager./tm-> member form. */
int   Front_GetTrackRaced(void);
int   PSXDrawBrightEndLine(int, int, int, int, int, int, int, int);
char *Stattool_GetAINameFromPersonality(tPersonalities);
extern "C" int textpixels(char *);
/* W66-A3 (link): this is tScreen::ProcessInput written in the flattened free-fn
 * form (§3.23b) -- and the free form MANGLES DIFFERENTLY, so the reference was a
 * real undefined symbol that the gate's reloc-name leniency hid (the oracle for
 * ProcessInput__24tScreenPinkSlipStandings… jal's the method form).  An asm-label
 * on the declaration fixes the emitted name only: the ABI is identical (`this` in
 * $a0 == the explicit first pointer arg), so the bytes cannot move, and the
 * `int` return keeps the existing `return tScreen_ProcessInput(...)` body legal
 * (the base method is void; retail's $v0 there is incidental). */
int   tScreen_ProcessInput(tScreen *, tPlayer, tInputKeyType &, tMenuCommand &)
    __asm__("ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand");
extern tTexture_ShapeInfo *gCurrentShapes[];
extern __nfs4_vtbl_ptr_t tScreenTournamentStandings_vtable[10], tScreenTournamentStandings3item_vtable[10], tScreenPinkSlipStandings_vtable[10];

/* ===== singletons owned by ScreenPost.obj (.bss zero, referenced cross-TU: front.cpp/femenudefs) ===== */
tScreenTournamentStandings      *screenTournamentStandings      = 0;   /* @0x80051e68 bss(zero) */
tScreenTournamentStandings3item *screenTournamentStandings3item = 0;   /* @0x80051e6c bss(zero) */
tScreenPinkSlipStandings        *screenPinkSlipStandings        = 0;   /* @0x80051e70 bss(zero) */

#endif
