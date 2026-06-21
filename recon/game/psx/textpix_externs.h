#include "../../lib/libfns.h"
/* textpix_externs.h -- externs referenced by textpix.cpp (GAME/PSX/TEXTPIX.C text-width calc) */
#ifndef TEXTPIX_EXTERNS_H
#define TEXTPIX_EXTERNS_H

/* This module's own exported fns are UNMANGLED in the SYM (C source compiled here
 * as C++); declare them extern "C" so the definitions keep C linkage and match. */
#ifdef __cplusplus
extern "C" {
#endif
int textnpixels(char *str, int n);
int textpixels(char *string);
#ifdef __cplusplus
}
#endif

/* SJIS/ANSI code-point reader: reads the next glyph code from *str and advances *str.
 * The active decoder is selected by setfont and stored in the currentfont fn-ptr slot @ +0x160. */
typedef int (*FontDecoder)(char **str);

extern unsigned char currentfont[];            /* font-state blob @ 0x80135ba0; +0x160 = FontDecoder */
   /* eaclib EACPSXZ glyph-info lookup (charactertbl*) */

#endif /* TEXTPIX_EXTERNS_H */
