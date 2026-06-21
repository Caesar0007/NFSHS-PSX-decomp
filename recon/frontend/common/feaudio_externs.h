#include "../../lib/libfns.h"
/* feaudio_externs.h -- externs referenced by feaudio.cpp (canonical decls from siblings + SYM Globals) */
#ifndef FEAUDIO_EXTERNS_H
#define FEAUDIO_EXTERNS_H

/* globals (SYM Globals.jsonl) */
extern SPEECHINFO  ginfo;                 /* 0x800514e8  STRUCT tag SPEECHINFO (NOT char[256]) */
extern LUMPYHEAD  *speechfileHeader;      /* 0x8005150c  PTR STRUCT */
extern char       *allLanguages[6];       /* 0x800514d0  ARY PTR CHAR dims 6 */
extern int         commentaryActualLevel; /* 0x80051538  INT */
extern char        gCurrentVIV;           /* 0x800514cc  CHAR */
extern char        bigBuf[];              /* 0x80010000  shared big buffer */
extern char       *Paths_Paths[];
extern int         gMasterFENarrationLevel, gMasterMusicLevel, gStopCommentaryNow;

/* free functions (SNDPSXZ.LIB + nsync + CRT; sigs inferred from call sites) */
void   AudioMus_Volume(int);

/* same-TU forward decls (called before defined) */
char *FeAudio_StartBigfileRead(char *fname, int offset, int length, int *vivHandle);
void  FeAudio_LocateBigfile(LUMPYHEAD *bigfileHeader, char *name, int *offset, int *length);

#endif
