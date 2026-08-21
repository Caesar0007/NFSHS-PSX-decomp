/* frontend/common/femenuoptions_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEMENUOPTIONS_EXTERNS_H_
#define _FE_SCREENS_FEMENUOPTIONS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern tFEApplication *FEApp;
extern tfrontEnd frontEnd;
extern tPadModuleState gPadinfo;
extern int ticks[];   /* unsized array (§3.12 #5): oracle lui/lw separate-scratch (matches femenuextended/fescreen) */
extern int PulsateYellow;
extern short MENUUSERNAME_STARTY;   /* @0x800529b2 ScreenUserName.obj-owned (cross-TU) */
extern char *Paths_Paths[];
extern tGlobalMenuDefs *menuDefs;
/* class vtables (FeMenuOptions.obj-defined subclasses) */
extern __vtbl_ptr_type tMenuItemGoToMenuButtonFade_vtable[], tMenuItemLeftRightFade_vtable[], tOptionsMenu_vtable[],
  tInsideBoxMenu_vtable[], tMenuItemSlidingMenu_vtable[], tMenuItemSlidingActivated_vtable[],
  tMenuItemDisplayLeftRightChoice_vtable[], tMenuItemOnOffLeftRightChoice_vtable[], tMenuItemLeftRightAudioSlider_vtable[],
  tInsideBoxSongMenu_vtable[], tMenuItemControllerLeftRightChoice_vtable[], tInsideBoxLeftRightSlider_vtable[],
  tInsideBoxTwoWaySlider_vtable[], tUserNameMenuItem_vtable[], tMemoryCardMenuItem_vtable[],
  tInsideBoxControllerLeftRightSlider_vtable[];
/* engine helpers */
int   CalcFadeVal(int, int);  int CalcFadeVal3(int,int,int);
void  DrawShapeExtended(int,int,int,int,int,int,tDrawShapeExtended*);
void  ScaleShapeExtended(int,int,int,int,int,int,tDrawShapeExtended*);
void  PSXDrawSquare(int,int,int,int,int);  void PSXDrawTransSquare(int,int,int,int,int,short);
void  FeDraw_SetABRMode(int);  void Flare_2DHalo(int,int,int,int,int);
void  FETextRender_MenuTextPositioned(short,short,short,tMenuTextState,tMenuTextType);
void  FETextRender_MenuTextPositionedJustify(short,short,short,short,tMenuTextState,tMenuTextType);
int   TextSys_WordX(int);  int TextSys_WordY(int);  char *TextSys_Word(int);  extern "C" int textpixels(char*);
void  AudioCmn_PlayFESFX(int);  void AudioCmn_PlayFESFXVol(int,int);
/* batch externs */
extern tScreenAudio *screenAudio;  extern tScreenControllerConfig *screenControllerConfig[];   /* unsized array (§3.12 #5): oracle lui/lw separate-scratch */
extern tTexture_ShapeInfo *gHelpShapes;  extern tPlayer gMenu_SubMenuPlayer;
extern short menu_kUserNameRows;   /* SYM: $800529b0 94 Def class EXT type SHORT (was wrongly int -> sw/lw instead of sh/lh) */
int CalcFadeVal(int,int,int);  int CalcFadeVal(int,int,int,int);
void FETextRender_FullTextRGB(char*,short,short,int,char,short);
void FETextRender_FullText(char*,short,short,tMenuTextType,tMenuTextState,short);
void FETextRender_Title(short);  void FETextRender_SetABR(int,bool);
void FETextRender_WordWrapTextRGBJustify(char*,RECT&,int,int,int,bool);
int  CalcTextFadeSelToHi(tMenuTextType, short, short);  int CalcTextFadeUnselToSel(tMenuTextType, short, short);
void DrawSlider(short,short,short,short,short,short,short,short,short,bool,bool,short,short);
void AudioMus_SysStartUp(int, int, char *);  void AudioMus_SysCleanUp(void);  void AudioMus_StopSong(int);  void AudioMus_PlaySong(char *);
int AudioMus_GetSongList(char *, int);  void AudioMus_Volume(int);
bool FECheat_ActivateCheat(char*);  void s_lower(char*);  void s_upper(char*);
void FeTools_DrawPSXButton(u_char,u_short,int,int);
void Font_TextColor(int);  void Font_TextTint(int);  void Font_TextXY(char*,int,int);
void DrawShapeFlat(int,int,int,int,int);
extern char textDefinitions[14][6];  extern int kRGBVals[];  extern int screenheight;
int  GetHelpText(tScreenControllerConfig*) asm("GetHelpText__23tScreenControllerConfig");
extern char ginfo[256];  extern int gFlip;  extern int Draw_gPlayer1View;
void *Draw_GetDRAWENV(int,int);
int  TextSys_WordFlags(int);
void Stattool_SamNelsonsUpperLowerStringConverterForRecords(char*);
void FeMenuOptions_drawLeftFlareOut(int,int,int);  void FeAudio_AsyncPlaySpeech(int, int);
bool FECheat_ActivateBonusByCode(char*);
/* W58-A1 (08A phantom fix): CalcOnOffFade__F13tMenuTextTypesssRiT4 -- (tMenuTextType,
 * short,short,short,int&,int&); T4 = a repeat of param 4 (0-based) = int&.  The old
 * `(...)` decl mangled both call sites as CalcOnOffFade__Fe (never links). */
int  CalcOnOffFade(tMenuTextType, short, short, short, int &, int &);
#endif
