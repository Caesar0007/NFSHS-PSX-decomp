#ifndef _ADDTIMER_H_
#define _ADDTIMER_H_

#include "eac_types.h"

extern int (*tmrsub[8])(void);

extern void addtimer(int (*fn)(void));   /* @0x800EAFE8 */
extern void deltimer(int (*fn)(void));   /* @0x800EB048 */

#endif
