/* mpause_externs.h -- cross-TU decls for game/common/mpause.cpp (NFS4 in-race mini pause menu).
 *   Types (tPMenu*, tPMenuItem*, tPauseMenuDefs, tPListIterator*, SndBnk_t, GameSetup_tData,
 *   __vtbl_ptr_type, tPMenuCommand) live in nfs4_types.h.
 *   mpause.obj OWNS these globals (defined in the .cpp, NOT here): gPauseMenuDefs, gMPauseUpdate,
 *   gMPauseUpdateNextTime, InGameSelectListAudioMode, SelectListConfig, gPauseCurrentMenu,
 *   kMovingHighlight(Dir), gBackDepth, gBackList, wasActive/testSFX/playingSFX/vol/SFXHandle/
 *   lastplaytick.  Names recovered from SYM Globals via disasm-proto ($gp base 0x8013C54C). */
#ifndef MPAUSE_EXTERNS_H
#define MPAUSE_EXTERNS_H

/* ---- cross-TU globals ---- */
extern int   gStereoMode;                 /* audiocmn.obj */
extern int   Audio_direct3davail;         /* audio.obj */
extern int   gMasterMusicLevel, gMasterSFXLevel, gMasterEngineLevel,
             gMasterAmbientLevel, gMasterFENarrationLevel;   /* audiocmn.obj */
extern int   Replay_ReplayMode;           /* replay.obj */
extern char  Device_gPausePortIndex;      /* device.obj */
extern SndBnk_t gSndBnk[7];
extern int   ticks;                       /* sys frame counter (EXT 0x8013dcac) */
extern bool  ChangedEnabling;             /* PauseMenu.obj (SYM EXT BOOL 0x8013d2ec) */
extern GameSetup_tData GameSetup_gData;

/* ---- cross-TU functions (audio) ---- */
                                   /* sndpsxz */
                                   /* sndpsxz */
extern void  AudioMus_AutoVolume(int target, int level);            /* audiomus.obj */
extern void  AudioMus_Volume(int level);                            /* audiomus.obj */
extern int   AudioCmn_MusicLevel(int masterLevel);                  /* audiocmn.obj */
extern int   AudioCmn_PlaySound(int bnkID, int a, int b, int c, int d);   /* audiocmn.obj */

/* ---- cross-TU functions (input / system) ---- */
extern bool  Debounce(void *menu) asm("Debounce__6tPMenu");
extern int   Input_Interface(int key, int debounce) asm("Input_Interface__FUli");
extern void  InGame_ResetPSXController(u_int port, int config) asm("InGame_ResetPSXController__Fii");
                                    /* libgpu */
extern void  TextSys_LoadInGame(int language);                      /* textsys.obj */
extern void  TextSys_UnloadWords(void);                             /* textsys.obj */
extern void  Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char c0, char c1);  /* hud.obj */
extern void  Hud_RenderPauseBox(int x, int y, int w, int h);       /* hud.obj */
/* ---- tPMenu / tPMenuItem methods rendered as free fns by Ghidra (PauseMenu.obj) ---- */
extern int   IsEnabled(int item);
extern int   IsDisabled(int item);
extern int   ItemEnabledNum(void *menu, int item) asm("ItemEnabledNum__6tPMenui");     /* dropped-arg Logic site disasm-bound */
extern int   NumEnabledItems(void *menu) asm("NumEnabledItems__6tPMenu");

/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" int DrawSync(int mode);
extern "C" int PadGetState(int port);
extern "C" int SNDover(int handle);
extern "C" int SNDstop(int handle);

#endif /* MPAUSE_EXTERNS_H */
