/* frontend/common/fetools_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FETOOLS_EXTERNS_H_
#define _FE_FETOOLS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- globals ---- */
extern char *Paths_Paths[];
extern char *font12;
extern char *font18;
extern char *fontTitle;
extern short currentSize;   /* SYM short (was wrongly int); fetextrender_externs.h agrees */

/* ---- libc / psyq ---- */

/* ---- engine / front-end helpers ---- */
int   DrawShapeExtended(int shape, int a, int x, int y, int e, int f, tDrawShapeExtended *flags);
int   Font_ExitFromGame(void);
int   Font_LoadFont(char *data, int a, int b, char c);
int   Font_DeInit(void);
char *TextSys_Word(int id);

#endif
