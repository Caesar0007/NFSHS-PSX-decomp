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
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/vars.h"
}
extern bool  ChangedEnabling;             /* PauseMenu.obj (SYM EXT BOOL 0x8013d2ec) */
extern int GameSetup_gData[325][2]; /* word-pair view (2600 bytes): retail mpause.obj records no GameSetup_tData */

/* ---- cross-TU functions (audio) ---- */
                                   /* sndpsxz */
                                   /* sndpsxz */
extern void  AudioMus_AutoVolume(int target, int level);            /* audiomus.obj */
extern void  AudioMus_Volume(int level);                            /* audiomus.obj */
extern int   AudioCmn_MusicLevel(int masterLevel);                  /* audiocmn.obj */
extern int   AudioCmn_PlaySound(int bnkID, int a, int b, int c, int d);   /* audiocmn.obj */

/* ---- cross-TU functions (input / system) ---- */
extern int   Input_Interface(u_long key, int debounce);
extern void  InGame_ResetPSXController(int port, int config);
                                    /* libgpu */
extern void  TextSys_LoadInGame(int language);                      /* textsys.obj */
extern void  TextSys_UnloadWords(void);                             /* textsys.obj */
extern void  Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char c0, char c1);  /* hud.obj */
extern void  Hud_RenderPauseBox(int x, int y, int w, int h);       /* hud.obj */

/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" int DrawSync(int mode);
extern "C" int PadGetState(int port);
extern "C" {
#include "eaclib/psx/sndpsxz/sover.h"
#include "eaclib/psx/sndpsxz/sstop.h"
}

/* gettick is the EA name in retail SYM/MAP at800E8220; its timer body and the
 * matched NFS2 implementation read ticks. This local inline realization is
 * reconstructed: the literal original inline header/call spelling is unproved.
 * Header context preserves the supplied caller lines. The canonical vars.h
 * declaration already makes the IRQ-updated ticks volatile. */
static inline int gettick(void) { return ticks; }

#endif /* MPAUSE_EXTERNS_H */
