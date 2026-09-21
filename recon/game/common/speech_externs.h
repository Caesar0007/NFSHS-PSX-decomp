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

/* ---- speech-event trigger fns: SPCHEVNT.C is #included into speech.cpp (it is part of Speech.obj), real prototypes there ---- */


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

#endif /* SPEECH_EXTERNS_H */
