/* frontend/screens/screentracks_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTRACKS_EXTERNS_H_
#define _FE_SCREENS_SCREENTRACKS_EXTERNS_H_
#include "screentracks_types.h"

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
extern "C" {
int ClearImage(RECT *rect, unsigned char r, unsigned char g, unsigned char b);
int DrawSync(int mode);
int sprintf(char *buffer, char *fmt, ...);
unsigned short GetTPage(int tp, int abr, int x, int y);
}

/* --- globals --- */
extern tfrontEnd          frontEnd;
/* P891: scalar vars.obj cell (NFS4 019199 @8013DCAC); NFS2 13bb6c records INT. */
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
void  DrawShape_NFS4RoundRectangle(int textValue, RECT &r, short s);
void  FETextRender_MenuTextPositionedJustify(short index, short x, short y,
                                              short justify,
                                              tMenuTextState state,
                                              tMenuTextType type)
    asm("FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType");
void  PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
void  FeDraw_SetABRMode(int abr);
bool Front_EnableLocalSpeech();

/* --- list iterator / track manager (called as free fns) --- */





/* --- tScreen helpers (non-member; base passed explicitly) --- */





/* --- tVideoWall methods (free-fn form; called on this->fVideoWall) --- */











#endif
