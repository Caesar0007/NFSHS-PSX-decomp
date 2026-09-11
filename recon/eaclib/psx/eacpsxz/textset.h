#ifndef _TEXTSET_H_
#define _TEXTSET_H_

#include "eac_types.h"

typedef int (*DecodeFn)(unsigned char **cursor);

extern void setfont(int fontId);   /* @0x800F2E94 */

#endif
