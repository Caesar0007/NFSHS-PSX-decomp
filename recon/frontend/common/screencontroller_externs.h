/* frontend/common/screencontroller_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENCONTROLLER_EXTERNS_H_
#define _FE_SCREENS_SCREENCONTROLLER_EXTERNS_H_
#include "screencontroller_types.h"

extern tfrontEnd   frontEnd;
extern int  ticks;
extern u_char Force_rand_256[256];   /* @0x8011fc60 rumble noise LUT (owned by game/psx/force.cpp) */
extern u_char Force_gActAlign[6];    /* @0x8013d840 actuator alignment table (owned by game/psx/force.cpp) */
extern tGlobalMenuDefs *menuDefs[];
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
extern __vtbl_ptr_type tScreenControllerConfig_vtable[10];   /* @0x80012078 (vtables_tscreen2.cpp) */
int CalcFadeVal(int col1, int amount);            /* 2-arg overload */
int CalcFadeVal(int col1, int col2, int f1, int f2);  /* 4-arg overload */
void trap(int code);
extern "C" int textpixels(char *str);
extern tFEApplication *FEApp;
extern tPadModuleState gPadinfo;        /* pad-info (84B, SYM anon .63fake tag = tPadModuleState) */
extern int  mappings[3][13][3];         /* PSX->FE key mappings */
/* menu helpers + Pad actuator (dumped overloads wrong-class/const; real call types per this TU) */
void SetMenu(tMenuItemSlidingMenu *thisobj, bool i, void *menu) asm("SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu");
void *TransitionIsFinished(tOptionsMenu *thisobj) asm("TransitionIsFinished__12tOptionsMenu");
/* libmath soft-float runtime (REAL SYM fns @0x800f####; variadic: Ghidra splits doubles into int pairs) */
extern "C" { double __muldf3(double,double); int __fixdfsi(double);
int PadGetState(int);
void PadSetAct(int, u_char *, int);
int PadSetActAlign(int, u_char *);
void PadStartCom(void);
int rand(void);
int sprintf(char *, const char *, ...);
void settrans(int);
 }

/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */
void FETextRender_SetABR(int abr, bool trans);
void Flare_2DHalo(int x, int y, int scalex, int scaley, int type);
void Controller_SetRamp(void);
void Front_ResetPSXController(int player, int config);
void UploadSwapShapes(tScreen * thisobj, int numSwapShapes) asm("UploadSwapShapes__7tScreeni");
int GetPSXPadValue(int value, int player);
void PSXDrawSquare(int col, int x, int y, int w, int h);
int CalcFadeVal(int col1, int col2, int amount);
void FETextRender_FullTextRGB(char * sMenuText, short x, short y, int col, char size, short justify);
int InGame_GetDevice(int control);
char * TextSys_Word(int wordnum);
void AsyncLoadSwapShapeFile(tScreen * thisobj, char * fileName) asm("AsyncLoadSwapShapeFile__7tScreenPc");
void ScaleShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);
short Run(tDialogInteractive * thisobj) asm("Run__18tDialogInteractive");
void PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
void AudioCmn_PlayFESFX(int SFXnum);
void FeDraw_SetABRMode(int abr);
bool IsShapeFileLoaded(tScreen * thisobj, tShapeInformation * shapes) asm("IsShapeFileLoaded__7tScreenR17tShapeInformation");
void FETextRender_SetFont(int size);

#endif
