#ifndef _SYSTASK_H_
#define _SYSTASK_H_

#include "eac_types.h"

extern void         addsystemtask(unsigned int (*taskFn)(int, int), int period, int delay);   /* @0x800E6AF4 */
extern void         delsystemtask(unsigned int (*taskFn)(int, int));   /* @0x800E6BA8 */
extern unsigned int systemtask(int arg1);   /* @0x800E6C04 */

#endif
