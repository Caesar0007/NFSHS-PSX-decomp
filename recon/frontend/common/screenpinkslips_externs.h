/* frontend/screens/screenpinkslips_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENPINKSLIPS_EXTERNS_H_
#define _FE_SCREENS_SCREENPINKSLIPS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ===== globals ===== */
extern tfrontEnd          frontEnd;
extern tTrackManager      trackManager;
extern tGlobalMenuDefs   *menuDefs;
extern tFEApplication    *FEApp;
extern int                ticks;
extern char              *Paths_Paths[];

/* ===== statics owned by ScreenPinkSlips.obj ===== */
tScreenPinkSlips         *screenPinkSlips = 0;        /* @0x80051E64 bss(zero), owned here; referenced cross-TU (front.cpp/femenudefs) as pointer */
static char  imageTVOrder[4] = {1,2,0,3};             /* STAT @0x80051E60 - TV reveal order */
static char  gSwapFileName[20];                       /* STAT @0x80052C00 */

/* ===== free helpers (member fns rendered free by Ghidra; tScreen* first arg where applicable) ===== */
void *IsShapeFileLoaded(tScreen*, tShapeInformation*) asm("IsShapeFileLoaded__7tScreenR17tShapeInformation");
void  UploadSwapShapes(tScreen*, int) asm("UploadSwapShapes__7tScreeni");
void  AsyncLoadSwapShapeFile(tScreen*, char*) asm("AsyncLoadSwapShapeFile__7tScreenPc");
short TextValue(void*, tPlayer) asm("TextValue__18tListIteratorTrack7tPlayer");
void  Increment(void*, tPlayer) asm("Increment__18tListIteratorTrack7tPlayer");
void  Decrement(void*, tPlayer) asm("Decrement__18tListIteratorTrack7tPlayer");
void  GetTrack(tTrackManager*, unsigned short, void*) asm("GetTrack__13tTrackManagersR17tTrackInformation");

/* drawing / text */
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
void  DrawShape_NFS4RoundRectangle(int, RECT*, short) asm("DrawShape_NFS4RoundRectangle__FiR4RECTs");
void  FETextRender_MenuTextPositionedJustify(short, short, short, short, tMenuTextState, tMenuTextType);
void  Flare_2DHalo(int, int, int, int, int);
void  PSXDrawTransSquare(int, int, int, int, int, short);
void  FeDraw_SetABRMode(int);

/* TV tiles (FETv) */
void  DrawTV(tTVConfig*) asm("DrawTV__FR9tTVConfig");
void  InitTV(tTVConfig*, tTexture_ShapeInfo*, short) asm("InitTV__FR9tTVConfigP18tTexture_ShapeInfos");
void  TurnOnTV(tTVConfig*) asm("TurnOnTV__FR9tTVConfig");
void  TurnOffTV(tTVConfig*) asm("TurnOffTV__FR9tTVConfig");

/* video (FRONTEND::PSX::video) */
int   VIDEO_create(int, int, int, int, int);
void  VIDEO_spoolfile(int, char*);
void  VIDEO_startplayback(int);
void  VIDEO_abortplayback(int);
void  VIDEO_destroy(int);
int   VIDEO_state(int);
int   VIDEO_updateframexy(int, int, int);

/* libgpu / libc / eaclib */

#endif
