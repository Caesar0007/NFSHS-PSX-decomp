/* textset_private.h -- textset.obj internals: the glyph-decoder pointer type (textset.c only).
 * Game and frontend code include the public textset.h only. */
#ifndef _TEXTSET_PRIVATE_H_
#define _TEXTSET_PRIVATE_H_

#include "textset.h"

typedef int (*DecodeFn)(unsigned char **cursor);

#endif
