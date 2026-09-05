#include "speech_types.h"
/* speech_externs.h -- cross-TU decls for game/common/speech.cpp (NFS4 cop speech/dispatch).
 *   Types in speech_types.h. speech.obj OWNS its globals + Speech_fgSpeech/fgUndefined (.cpp). */
#ifndef SPEECH_EXTERNS_H
#define SPEECH_EXTERNS_H

/* Narrow eaclib/libc boundary used by this owner. */
extern "C" {
int FILE_closesync(...);
int FILE_opensync(...);
int FILE_readsync(...);
int SNDstop(...);
void *SetSp(...);
int fixedmult(...);
int gettick(...);
int loadbigfileheader(...);
void *locatebigentry(...);
void *memcpy(...);
int purgememadr(...);
void *reservememadr(...);
int sprintf(...);
unsigned int strlen(...);
int strncmp(...);
int systemtask(...);
}

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
long SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY(void);   /* MATCH: true (void) sig per spchevnt.c:675 -- the `int = 0` default arg emitted a spurious `addu a0,zero,zero` in the jal delay slot (oracle: nop) */
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
long SPCHNFS_D_C_SPBLT_CONFIRMED(SPCHNFSType_POSITION *, int,
                                 SPCHNFSType_DISTANCE *, int,
                                 SPCHNFSType_SPIKE_BELT_SIDE *);
long SPCHNFS_S_C_SUPER_COP_ARRIVAL(int = 0, ...);
long SPCHNFS_S_C_SUPER_COP_CRITICISM(int = 0, ...);
long SPCHNFS_W_D_RDBLK_PLC(int = 0, ...);
long SPCHNFS_W_D_SPBLT_PLC(int = 0, ...);
}

/* ---- SPCH_ speech-runtime API: the SPCHPSXZ library's own headers (recon/eaclib/psx/spchpsxz) ---- */
extern "C" {
#include "eaclib/psx/spchpsxz/spch_externs.h"
}

/* ---- audio ---- */
/* W55-A2 BUGFIX (class-3, synthetic default-args): these four were placeholder
   `int f(int = 0, ...)` decls.  Under C++ linkage a variadic decl mangles to `__Fie`, so
   speech.o emitted `U AudioMus_PlaySong__Fie` / `AudioMus_StopSong__Fie` /
   `CopSpeak_DirectRequest__Fie` / `CopSpeak_GenericBankRequest__Fie` -- four PHANTOM
   symbols that can never link (verify_asm's reloc-name leniency hid them).  The true
   signatures come from the definitions (audiomus.cpp / copspeak.cpp) and are confirmed by
   configs/symbol_addrs.txt: AudioMus_StopSong__Fi, AudioMus_PlaySong__FPc,
   CopSpeak_DirectRequest__FillP8Car_tObjPc, CopSpeak_GenericBankRequest__FiP8Car_tObj. */
extern int AudioMus_PlaySong(char *pattern);
extern void AudioMus_StopSong(int fadeticks);
extern int AudioMus_Threshold(void);

/* ---- CopSpeak (sibling TU) ---- */
extern void CopSpeak_DirectRequest(int filehandle, long offset, long size, Car_tObj *car, char *name);
extern void CopSpeak_Flush(void);
extern void CopSpeak_GenericBankRequest(int patch, Car_tObj *car);
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
extern const __vtbl_ptr_type Speaker_vtable[] __asm__("_vt_Q26Speech7Speaker");
extern const __vtbl_ptr_type MobileSpeaker_vtable[] __asm__("_vt_Q26Speech13MobileSpeaker");
extern const __vtbl_ptr_type DispatchSpeaker_vtable[] __asm__("_vt_Q26Speech15DispatchSpeaker");

#endif /* SPEECH_EXTERNS_H */
