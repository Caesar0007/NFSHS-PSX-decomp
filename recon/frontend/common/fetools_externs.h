/* frontend/common/fetools_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FETOOLS_EXTERNS_H_
#define _FE_FETOOLS_EXTERNS_H_
#include "fetools_types.h"

/* ---- globals ---- */
extern char *Paths_Paths[];
extern char *font12;       /* SYM PTR CHAR */
extern char *font18;
extern char *fontTitle;
extern short currentSize;  /* SYM SHORT */

/* ---- libc / psyq ---- */

/* ---- engine / front-end helpers ---- */
int   DrawShapeExtended(int shape, int a, int x, int y, int e, int f, tDrawShapeExtended *flags);
int   Font_ExitFromGame(void);
int   Font_LoadFont(char *data, int a, int b, char c);
int   Font_DeInit(void);
char *TextSys_Word(int id);

extern "C" {
char *loadfileadrz(...);
int purgememadr(...);
int sprintf(...);
unsigned int strlen(...);
}

#endif
