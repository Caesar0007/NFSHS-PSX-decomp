#ifndef _FIXDINV_H_
#define _FIXDINV_H_

#include "eac_types.h"

extern unsigned fixedinverse(int x);   /* @0x800ED3EC : host fallback (rounded reciprocal) */
extern unsigned rinverse(int x);        /* co-equal XDEF at the same address (asm label in fixdinv.c) */

#endif
