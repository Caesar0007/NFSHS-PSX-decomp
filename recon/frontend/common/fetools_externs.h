/* frontend/common/fetools_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FETOOLS_EXTERNS_H_
#define _FE_FETOOLS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- globals ---- */
extern char *Paths_Paths[];
extern char *font12[];      /* unsized array (§3.15): forces separate-$v0 scratch on value-load */
extern char *font18[];
extern char *fontTitle[];
extern short currentSize[]; /* unsized-array view (sec.3.15): forces address into a genreg (sh v0,%lo($v1)) not the $at store-macro */

/* ---- libc / psyq ---- */

/* ---- engine / front-end helpers ---- */
int   DrawShapeExtended(int shape, int a, int x, int y, int e, int f, tDrawShapeExtended *flags);
int   Font_ExitFromGame(void);
int   Font_LoadFont(char *data, int a, int b, char c);
int   Font_DeInit(void);
char *TextSys_Word(int id);

#endif
