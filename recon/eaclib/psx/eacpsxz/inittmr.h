#ifndef _INITTMR_H_
#define _INITTMR_H_

#include "eac_types.h"

extern int initmemadr(int base, int size);   /* @0x800F4180 */
extern int inittimer(int hz);   /* @0x800F41F0 */
extern void restoretimer(void);   /* @0x800F4304 */
extern unsigned int tmrint(void);   /* @0x800F4328 */

#endif
