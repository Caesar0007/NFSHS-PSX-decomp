#ifndef _TIMER_H_
#define _TIMER_H_

#include "eac_types.h"
#include "vars.h"   /* vars.obj owns `ticks` (ABSOLUTE @0x8013DCAC) */

extern int gettick(void);        /* @0x800E8220 */
extern int elapsedticks(void);   /* @0x800E8230 */
extern void resettick(void);     /* @0x800E8260 */
extern void timedwait(int n);    /* @0x800E8284 */

#endif
