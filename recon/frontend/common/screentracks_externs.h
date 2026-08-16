/* frontend/screens/screentracks_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTRACKS_EXTERNS_H_
#define _FE_SCREENS_SCREENTRACKS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* --- globals --- */
extern tfrontEnd          frontEnd;
extern int                ticks[];   /* unsized array (§3.12 #5): oracle lui/lw separate-scratch (matches femenuextended/fescreen) */
extern tTrackManager      trackManager;
extern tGlobalMenuDefs   *menuDefs;
extern tFEApplication    *FEApp;
extern char              *Paths_Paths[];

/* --- storage owned by ScreenTracks.obj --- */
static short tvOrder[10] = { 2, 7, 4, 8, 1, 6, 0, 9, 3, 5 };   /* STAT @0x800520a0 */
static char  gSwapFileName[20];                                /* STAT @0x80052ca0 */
tScreenTrackSelect *screenTrackSelect;                         /* EXT  @0x800520b4 (runtime-set) */

/* --- PSX video player (nfs4::FRONTEND::PSX::video) --- */
int  VIDEO_create(int w, int h, int a, int b, int c);
int  VIDEO_state(int h);
int  VIDEO_updateframexy(int h, int x, int y);
void VIDEO_spoolfile(int h, char *name);
void VIDEO_startplayback(int h);
void VIDEO_abortplayback(int h);
void VIDEO_destroy(int h);

/* --- PsyQ / syslib --- */

/* --- FE draw / text / effect --- */
void  DrawShape_NFS4RoundRectangle(int textValue, RECT *r, short s) asm("DrawShape_NFS4RoundRectangle__FiR4RECTs");
void  FETextRender_MenuTextPositionedJustify(short index, short x, short y, short justify, tMenuTextState state, tMenuTextType type);
void  PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
void  FeDraw_SetABRMode(int abr);
BOOL Front_EnableLocalSpeech();

/* --- list iterator / track manager (called as free fns) --- */
short TextValue(tListIteratorTrack *it, tPlayer p) asm("TextValue__18tListIteratorTrack7tPlayer");
void  Decrement(tListIteratorTrack *it, tPlayer p) asm("Decrement__18tListIteratorTrack7tPlayer");
void  Increment(tListIteratorTrack *it, tPlayer p) asm("Increment__18tListIteratorTrack7tPlayer");
void  GetTrack(tTrackManager *tm, u_short track, tTrackInformation *out) asm("GetTrack__13tTrackManagersR17tTrackInformation");

/* --- tScreen helpers (non-member; base passed explicitly) --- */
BOOL IsShapeFileLoaded(tScreen *s, tShapeInformation *shp) asm("IsShapeFileLoaded__7tScreenR17tShapeInformation");
void UploadSwapShapes(tScreen *s, int n) asm("UploadSwapShapes__7tScreeni");
void AsyncLoadSwapShapeFile(tScreen *s, char *name) asm("AsyncLoadSwapShapeFile__7tScreenPc");
void DrawBackgroundImage(tScreen *s, int startShape, int numShapes, tTexture_ShapeInfo *shapes, int flip) asm("DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi");

/* --- tVideoWall methods (free-fn form; called on this->fVideoWall) --- */
void TurnOn(tVideoWall *vw) asm("TurnOn__10tVideoWall");
void TurnOff(tVideoWall *vw) asm("TurnOff__10tVideoWall");
void TurnOffInstant(tVideoWall *vw) asm("TurnOffInstant__10tVideoWall");
void Initialize(tVideoWall *vw, tTVConfig *cfgs, tTexture_ShapeInfo *shapes, short a, short b, short *order, short c) asm("Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss");
void SetAvailableText(tVideoWall *vw, short a, short b, short c) asm("SetAvailableText__10tVideoWallsss");
void SetAvailableIcon(tVideoWall *vw, short a, short b, short c, short d, tTexture_ShapeInfo *shapes) asm("SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo");
void SetAvailable(tVideoWall *vw, u_short avail) asm("SetAvailable__10tVideoWalls");
void UpdateImages(tVideoWall *vw) asm("UpdateImages__10tVideoWall");
void UpdateTransition(tVideoWall *vw) asm("UpdateTransition__10tVideoWall");
void Draw(tVideoWall *vw) asm("Draw__10tVideoWall");

#endif
