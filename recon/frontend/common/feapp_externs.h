#include "../../lib/libfns.h"
/* feapp_externs.h -- externs referenced by feapp.cpp (canonical decls from siblings + SYM Globals + usage inference) */
#ifndef FEAPP_EXTERNS_H
#define FEAPP_EXTERNS_H

/* 🔴 DO NOT RE-SORT these three (17B EXTERN-ORDER LAW).  All three are TU-owned
   TENTATIVE definitions in feapp.cpp, so they are emitted in the order their
   identifiers are FIRST DECLARED -- which is here, not in the .cpp.  This order
   encodes FEApp.obj's retail .data run, from the SYM's own FEApp.obj block:
     0x800514b8 gLargestUnused (ULONG) -> +4 currentVideo (STAT, SYM offset $4,
     = the splat label D_800514BC) -> 0x800514c0 FEApp (PTR).
   (0x800514b4 gShowroomLights is NOT ours -- SYM puts it in fe3dmenu.obj.) */
extern int               gLargestUnused[];
extern int               currentVideo;

/* global instances / data */
extern tFEApplication   *FEApp;
extern tfrontEnd         frontEnd;
extern tCarManager       carManager;
extern tGlobalMenuDefs  *menuDefs[];
extern tScreenUserName  *screenUserName;
extern GameSetup_tData   GameSetup_gData;
extern Car_tStats         Cars_gNewCarStatsList[];   /* was stale scalar int; owner cars.cpp
                                     Car_tStats Cars_gNewCarStatsList[9] (array of value structs) */
extern tPadModuleState   gPadinfo;
extern char              bigBuf[];
extern char              D_80010044[];
extern char              D_80010048[];
extern int               Cars_gNumRaceCars;
extern int               screenheight, ticks, gFlip, Draw_gPlayer1View, Draw_gDoVSync;

/* audio */
void AudioCmn_PlayFESFX(int);
void AudioCmn_LoadFESamples(void);
int  AudioMus_Buffered(void);
int  AudioMus_PlaySong(char *pattern);
void AudioMus_StopSong(int);
int  AudioMus_Threshold(void);
void AudioMus_Volume(int);
void Audio_InitDriver(int, int);
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
extern "C" int textpixels(char *);
char *TextSys_Word(int id);
void FeTools_init(void);
int  FeTools_deinit(void);
void LoadAllHelpShapes(void);

/* input / clock / memcard / stats / misc subsystems */
int  FEInput_GetKeyFromPlayer(tPlayer, int) asm("FEInput_GetKeyFromPlayer__F7tPlayerl");
void Front_ResetPSXController(int controller, int mode);
void Clock_SystemStartUp(void);
void Clock_SystemCleanUp(void);
int  Init_Memcard(bool, bool);
int  DeInit_Memcard(void);
int  StatChk_ClearNewRecords(void);
void *StatChk_IsRecordLapTime(Car_tStats *, short, short *);
short StatChk_IsTopTime(Car_tStats *, short);
int  SavePinkSlipsCarsWithErrorDialogs(short, short, short);
char *PlayerName(int);
int  MenuExtended_PostGameMenu(tMenuCommand &command);
void play_movie(int) asm("play_movie__Fc");

/* CRT */

/* tDialog* vtables (defined in FEDialog.obj) */
extern __vtbl_ptr_type tDialogBase_vtable[], tDialogHelp_vtable[], tDialogMessageString_vtable[], tDialogNoInputMessage_vtable[];
extern __vtbl_ptr_type tDialogMessageStringWithTimeout_vtable[];   /* @0x80010098 (vtables_tdialog.cpp) */

#endif
