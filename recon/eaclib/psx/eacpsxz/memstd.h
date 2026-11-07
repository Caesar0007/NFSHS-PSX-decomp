#ifndef _MEMSTD_H_
#define _MEMSTD_H_

#include "eac_types.h"

/* internals -> memstd_private.h (library sources only; no retail game object records them) */




























extern int MEM_infosize(int id);   /* @0x800E5008 */
extern int MEM_tailsize(char *name, int id);   /* @0x800E5030 */
extern int creatememclass(int id, char *name, char *membuf, int bufsize,
                          int granularity, int alignment, int infosize,
                          int lowguard, int reserved9, int highguard,
                          int usemutex, int field3c);   /* @0x800E5094 */
extern int largestunused(void);   /* @0x800E5284 */
extern int getblocksize(void *hdr);   /* @0x800E52D4 */
extern char *getblockname(void *p);   /* @0x800E52E0 */
extern void *reservememadr(char *name, int size, int classid);   /* @0x800E533C */
extern int purgememadr(void *p);   /* @0x800E5540 */

#endif
