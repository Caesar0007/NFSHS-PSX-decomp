#ifndef _FIXDDIV_H_
#define _FIXDDIV_H_

#include "eac_types.h"

extern int fixeddiv(int a, int b);   /* @0x800E4404 : host fallback (16.16 signed divide) */
extern int rdiv(int a, int b);          /* co-equal XDEF at the same address (asm label in fixddiv.c) */

#endif
