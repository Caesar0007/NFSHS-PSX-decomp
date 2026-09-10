#ifndef _MATH64A_H_
#define _MATH64A_H_

#include "eac_types.h"

extern void make64(int *out, int y, unsigned int shift);   /* @0x800FE488 math64a.obj */
extern int  divu64(int hi, int lo, unsigned int den);      /* @0x800FE4E0 math64a.obj */

#endif
