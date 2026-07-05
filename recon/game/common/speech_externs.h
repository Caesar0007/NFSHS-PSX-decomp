#include "../../lib/libfns.h"
/* speech_externs.h -- cross-TU decls for game/common/speech.cpp (NFS4 cop speech/dispatch).
 *   Types in nfs4_types.h. speech.obj OWNS its globals + Speech_fgSpeech/fgUndefined (.cpp). */
#ifndef SPEECH_EXTERNS_H
#define SPEECH_EXTERNS_H

/* ---- speech-event trigger fns (spchevnt.cpp, unmangled C-linkage; variadic call sites) ---- */
extern "C" {
long SPCHNFS_C_A_CONFIRM(int = 0, ...);
long SPCHNFS_C_A_INTRO(int = 0, ...);
long SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS(int = 0, ...);
long SPCHNFS_C_C_IN_PURS_NEAR_PERP(int = 0, ...);
long SPCHNFS_C_C_NEW_OFFICER_ENGAGING(int = 0, ...);
long SPCHNFS_C_C_PERP_REAQUIRED(int = 0, ...);
long SPCHNFS_C_D_DURING_FALSE_ARREST(int = 0, ...);
long SPCHNFS_C_D_ENDGAME(int = 0, ...);
long SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR(int = 0, ...);
long SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS(int = 0, ...);
long SPCHNFS_C_D_IN_PURS_PERP_AIRBORN(int = 0, ...);
long SPCHNFS_C_D_PERP_APPREHENSION(int = 0, ...);
long SPCHNFS_C_D_PERP_CRASH_GEN(int = 0, ...);
long SPCHNFS_C_D_PERP_CRASH_ROLL(int = 0, ...);
long SPCHNFS_C_D_PERP_LOST(int = 0, ...);
long SPCHNFS_C_D_PERP_SIGHTED(int = 0, ...);
long SPCHNFS_C_D_RDBLK_FAILED(int = 0, ...);
long SPCHNFS_C_D_REQUEST_BKUP(int = 0, ...);
long SPCHNFS_C_D_REQUEST_EMS(int = 0, ...);
long SPCHNFS_C_D_REQ_RDBLK(int = 0, ...);
long SPCHNFS_C_D_REQ_SPBLT(int = 0, ...);
long SPCHNFS_C_D_SPBLT_FAILED(int = 0, ...);
long SPCHNFS_C_P_ARRESTED(int = 0, ...);
long SPCHNFS_C_P_BULLHORN_SPEECH(int = 0, ...);
long SPCHNFS_C_P_FALSE_ARREST_BULLHORN(int = 0, ...);
long SPCHNFS_C_P_TICKET(int = 0, ...);
long SPCHNFS_C_P_WARNING(int = 0, ...);
long SPCHNFS_D_A_CONFIRM(int = 0, ...);
long SPCHNFS_D_C_BEGIN_PURS_REP_SPDR(int = 0, ...);
long SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY(int = 0, ...);
long SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY(int = 0, ...);
long SPCHNFS_D_C_INTRO_CALL(int = 0, ...);
long SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM(int = 0, ...);
long SPCHNFS_D_C_IN_PURS_NEAR_PERP(int = 0, ...);
long SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM(int = 0, ...);
long SPCHNFS_D_C_PERP_APPREHENSION_REPLY(int = 0, ...);
long SPCHNFS_D_C_PERP_LOST_CONFIRM(int = 0, ...);
long SPCHNFS_D_C_PERP_SIGHTED_CONFIRM(int = 0, ...);
long SPCHNFS_D_C_RDBLK_CONFIRMED(int = 0, ...);
long SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY(int = 0, ...);
long SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY(int = 0, ...);
long SPCHNFS_D_C_SPBLT_CONFIRMED(int = 0, ...);
long SPCHNFS_S_C_SUPER_COP_ARRIVAL(int = 0, ...);
long SPCHNFS_S_C_SUPER_COP_CRITICISM(int = 0, ...);
long SPCHNFS_W_D_RDBLK_PLC(int = 0, ...);
long SPCHNFS_W_D_SPBLT_PLC(int = 0, ...);
long SPCH_AddBank(int = 0, ...);
long SPCH_ClearEventQueue(int = 0, ...);
long SPCH_Deinit(int = 0, ...);
long SPCH_GetSampleDataRate(int = 0, ...);
long SPCH_Init(int = 0, ...);
long SPCH_InitBankMem(int = 0, ...);
long SPCH_PlaySpeech(...);
long SPCH_ResolveData(int = 0, ...);
}

/* ---- SPCH_ speech-runtime API ---- */  /* (declared above; variadic) */

/* ---- audio ---- */
extern int AudioMus_PlaySong(int = 0, ...);
extern int AudioMus_StopSong(int = 0, ...);
extern int AudioMus_Threshold(int = 0, ...);

/* ---- CopSpeak (sibling TU) ---- */
extern int CopSpeak_DirectRequest(int = 0, ...);
extern int CopSpeak_Flush(int = 0, ...);
extern int CopSpeak_GenericBankRequest(int = 0, ...);
extern int CopSpeak_gSpchHandle;

/* ---- eaclib / PsyQ / file I/O ---- */

/* ---- libc ---- */

/* ---- GCC 2.7.2 runtime (C++ new/delete, soft-float) ---- */
extern void *__builtin_new(unsigned);
extern void __builtin_delete(void *);

/* ---- cross-TU globals (typed from SYM Globals.jsonl) ---- */
extern GameSetup_tData GameSetup_gData;
extern char GameSetup_gCarNames[51][5];
extern char *Paths_Paths[50];
extern int gNumSlices;
extern u_long gWSavePtr;
extern u_int fastRandom;
extern u_int randSeed;
extern u_int randtemp;
extern int stackSpeedUpEnbabledFlag;

/* ---- per-class vtables (data syms; assigned to _vf[31]) ---- */
extern __vtbl_ptr_type Speaker_vtable[];   /* @0x80055dc4 #75 data-mat (defined in speech.cpp) */
extern __vtbl_ptr_type MobileSpeaker_vtable[];   /* @0x80055bd4 #75 data-mat (defined in speech.cpp) */
extern __vtbl_ptr_type DispatchSpeaker_vtable[];   /* @0x80055ccc #75 data-mat (defined in speech.cpp) */

#endif /* SPEECH_EXTERNS_H */
