#include "../../lib/libfns.h"
/* feapp_externs.h -- externs referenced by feapp.cpp (canonical decls from siblings + SYM Globals + usage inference) */
#ifndef FEAPP_EXTERNS_H
#define FEAPP_EXTERNS_H

/* global instances / data */
extern tFEApplication   *FEApp;
extern tfrontEnd         frontEnd;
extern tCarManager       carManager;
extern tGlobalMenuDefs  *menuDefs[];
extern tScreenUserName  *screenUserName;
extern GameSetup_tData   GameSetup_gData;
extern int               Cars_gNewCarStatsList;
extern tPadModuleState   gPadinfo;
extern u_char           *Render_gPacketPtr, *Render_gPalettePtr;
extern char              bigBuf[];
extern int               Cars_gNumRaceCars;
extern int               screenheight, ticks, gFlip, gLargestUnused, Draw_gPlayer1View, Draw_gDoVSync, currentVideo;

/* audio */
void AudioCmn_PlayFESFX(int);
void AudioCmn_LoadFESamples(void);
int  AudioMus_Buffered(void);
int  AudioMus_PlaySong(char *pattern);
void AudioMus_StopSong(int);
int  AudioMus_Threshold(void);
void AudioMus_Volume(int);
void Audio_InitDriver(...);
void Audio_DeInitDriver(void);
int  Audio_FECleanUp(void);
void FeAudio_systemtask(int);

/* draw / render */
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended *);
void *Draw_GetDRAWENV(int, int);
void  Draw_StartFrameRender(void);
void  Draw_StopFrameRender(void);
void  Draw_StartRenderingView(int view);
void  Draw_StopRenderingView(int view);
void  PSXFront_AllocateDrawMemory(void);
void  PSXFront_FreeDrawMemory(void);

/* text / tools / help shapes */
void FETextRender_FullText(char *, short, short, tMenuTextType, tMenuTextState, short);
void FETextRender_FullTextRGB(char *, short, short, int, char, short);
void FETextRender_SetABR(int, bool);
int  textpixels(char *);
char *TextSys_Word(int id);
void FeTools_init(void);
int  FeTools_deinit(void);
void LoadAllHelpShapes(void);
void FreeHelpShapeCluts(void);

/* input / clock / memcard / stats / misc subsystems */
int  FEInput_GetKeyFromPlayer(tPlayer, int);
void Front_ResetPSXController(int controller, int mode);
void Clock_SystemStartUp(void);
void Clock_SystemCleanUp(void);
int  Init_Memcard(...);
int  DeInit_Memcard(void);
int  StatChk_ClearNewRecords(void);
int  StatChk_IsRecordLapTime(...);
int  StatChk_IsTopTime(...);
int  SavePinkSlipsCarsWithErrorDialogs(...);
char *PlayerName(int);
int  MenuExtended_PostGameMenu(tMenuCommand &command);
void play_movie(int);

/* CRT */

/* tDialog* vtables (defined in FEDialog.obj) */
extern __vtbl_ptr_type tDialogBase_vtable[], tDialogHelp_vtable[], tDialogMessageString_vtable[], tDialogNoInputMessage_vtable[];
extern __vtbl_ptr_type tDialogMessageStringWithTimeout_vtable[];   /* @0x80010098 (vtables_tdialog.cpp) */

#endif
