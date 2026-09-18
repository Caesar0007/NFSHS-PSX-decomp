#ifndef _ADDTIMER_H_
#define _ADDTIMER_H_

#include "eac_types.h"

extern void (*tmrsub[8])(void);

/* The callbacks are `void (*)(void)`: no SYM record types tmrsub, and every
 * game caller (clock, fememcard, memcard, screenmemcard, psxfront) registers a
 * void function -- retail compiled that, so EA's prototype took void fns.
 * tmrint ignores the slot's return.  Codegen-neutral vs the old `int (*)()`. */
extern void addtimer(void (*fn)(void));   /* @0x800EAFE8 */
extern void deltimer(void (*fn)(void));   /* @0x800EB048 */

#endif
