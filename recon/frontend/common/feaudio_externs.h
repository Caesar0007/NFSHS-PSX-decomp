#include "../../lib/libfns.h"
/* feaudio_externs.h -- externs referenced by feaudio.cpp (canonical decls from siblings + SYM Globals) */
#ifndef FEAUDIO_EXTERNS_H
#define FEAUDIO_EXTERNS_H

/* globals (SYM Globals.jsonl)
   🔴 DO NOT RE-SORT ginfo / speechfileHeader / currentSpeechViv /
   commentaryActualLevel (17B EXTERN-ORDER LAW): they are the TU-owned TENTATIVE
   definitions of Feaudio.obj, so they emit in the order their identifiers are
   FIRST DECLARED -- these four lines -- AFTER the initialised objects.  Retail
   run (SYM Feaudio.obj block): 0x800514c8 gStopCommentaryNow (=0, initialised,
   so it leads) -> gCurrentVIV -> allLanguages -> ginfo -> speechfileHeader ->
   currentSpeechViv -> commentaryActualLevel. */
extern SPEECHINFO  ginfo;                 /* 0x800514e8  STRUCT tag SPEECHINFO (NOT char[256]) */
extern LUMPYHEAD  *speechfileHeader[];    /* 0x8005150c  PTR STRUCT -- unsized-array form: non-gp +
                                             separate v0 scratch for value-load into arg reg */
extern char        currentSpeechViv[40];  /* 0x80051510  ARY CHAR dims 40 */
extern char       *allLanguages[6];       /* 0x800514d0  ARY PTR CHAR dims 6 */
extern int         commentaryActualLevel; /* 0x80051538  INT */
extern signed char gCurrentVIV;           /* 0x800514cc  CHAR */
extern char        bigBuf[];              /* 0x80010000  shared big buffer */
extern char       *Paths_Paths[];
extern int         gMasterFENarrationLevel, gMasterMusicLevel, gStopCommentaryNow;

/* free functions (SNDPSXZ.LIB + nsync + CRT; sigs inferred from call sites) */
void   AudioMus_Volume(int);

/* same-TU forward decls (called before defined) */
char *FeAudio_StartBigfileRead(char *fname, int offset, int length, int *vivHandle);
void  FeAudio_LocateBigfile(LUMPYHEAD *bigfileHeader, char *name, int *offset, int *length);

#endif
