#include "../../lib/libfns.h"
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
extern SndBnk_t gSndBnk[];                /* audiocmn.obj */
extern int   ticks;                       /* sys frame counter (EXT 0x8013dcac) */
extern int   ChangedEnabling;             /* PauseMenu.obj (EXT 0x8013d2ec) */
extern GameSetup_tData GameSetup_gData;   /* gamesetup.obj */

/* ---- cross-TU functions (audio) ---- */
                                   /* sndpsxz */
                                   /* sndpsxz */
extern void  AudioMus_AutoVolume(int target, int level);            /* audiomus.obj */
extern void  AudioMus_Volume(int level);                            /* audiomus.obj */
extern int   AudioCmn_MusicLevel(int masterLevel);                  /* audiocmn.obj */
extern int   AudioCmn_PlaySound(int bnkID, int a, int b, int c, int d);   /* audiocmn.obj */

/* ---- cross-TU functions (input / system) ---- */
extern int   Debounce(void *menu);
extern int   Input_Interface(int key, int debounce);
extern void  InGame_ResetPSXController(u_int port, int config);
                                    /* libgpu */
extern void  TextSys_LoadInGame(int language);                      /* textsys.obj */
extern void  TextSys_UnloadWords(void);                             /* textsys.obj */
extern void  Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char c0, char c1);  /* hud.obj */
extern void  Hud_RenderPauseBox(int x, int y, int w, int h);       /* hud.obj */
extern void *__builtin_new(u_int size);
extern void  __builtin_delete(void *p);

/* ---- tPMenu / tPMenuItem methods rendered as free fns by Ghidra (PauseMenu.obj) ---- */
extern int   IsEnabled(int item);
extern int   IsDisabled(int item);
extern int   ItemEnabledNum(void *menu, int item);     /* dropped-arg Logic site disasm-bound */
extern int   NumEnabledItems(void *menu);

/* ---- PauseMenu.obj menu-item ctors (free-fn, explicit pThis; variadic absorbs varying arg shapes)
 *   + dtors (free-fn, (pThis, in-charge-flag)).  mpause calls these cross-TU; PauseMenu.obj defines
 *   them member-style. ---- */
extern void  tPMenuItemNonInteractiveText_ct(int pThis, ...);
extern void  tPMenuItemCommandButton_ct(int pThis, ...);
extern void  tPMenuItemGoToMenuButton_ct(int pThis, ...);
extern void  tPMenuItemLeftRightChoice_ct(int pThis, ...);
extern void  tPMenuItemLeftRightSlider_ct(int pThis, ...);
extern void  tPMenuItemLeftRightSliderIndexed_ct(int pThis, ...);
extern void  tPListIterator_ct(int pThis, ...);
extern void  tPListIteratorIndexed_ct(int pThis, ...);
extern void  tPMenu_ct(int pThis, ...);

extern void  tPMenuItemNonInteractiveText_dt(void *pThis, int flag);
extern void  tPMenuItemCommandButton_dt(void *pThis, int flag);
extern void  tPMenuItemGoToMenuButton_dt(void *pThis, int flag);
extern void  tPMenuItemLeftRightChoice_dt(void *pThis, int flag);
extern void  tPMenuItemLeftRightSlider_dt(void *pThis, int flag);
extern void  tPMenuItemLeftRightSliderIndexed_dt(void *pThis, int flag);
extern void  tPListIterator_dt(void *pThis, int flag);
extern void  tPListIteratorIndexed_dt(void *pThis, int flag);
extern void  tPMenu_dt(void *pThis, int flag);

#endif /* MPAUSE_EXTERNS_H */
