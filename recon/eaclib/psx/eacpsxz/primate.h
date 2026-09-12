#ifndef _PRIMATE_H_
#define _PRIMATE_H_

#include "eac_types.h"

extern int drawpending;   /* @0x8013DD10: primate.c owns the initialized .sdata cell. */

extern void *initlinkmode(void *unused, int maxprimArg, int linkmode);   /* @0x800F05F4 */
extern void waitdraw(void);   /* @0x800F06E0 */
extern int settrans(int mode);   /* @0x800F070C */

#endif
