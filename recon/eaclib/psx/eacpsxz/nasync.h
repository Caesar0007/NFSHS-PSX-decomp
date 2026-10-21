#ifndef _NASYNC_H_
#define _NASYNC_H_

#include "eac_types.h"
#include "../../../lib/nasync.h"

extern void initasync(int numreq, int blocksize, int memclass);   /* @0x800F11B0 */
extern int asyncloadfilecallback(char *name, int memclass, void (*cb)(int));   /* @0x800F12B0 */
extern int asyncloadfile(char *name, int memclass);   /* @0x800F1368 */
extern int asyncloadfileatcallback(char *name, void *dest, void (*cb)(int));   /* @0x800F1388 */
extern int asyncloadfileat(char *name, void *dest);   /* @0x800F143C */
extern void setasyncfile(char *name);   /* @0x800F145C */
extern int asyncloadsegmentcallback(char *offset, void *dest, int size, void (*cb)(int));   /* @0x800F14BC */
extern int asyncloadsegment(char *offset, void *dest, int size);   /* @0x800F15B0 */
extern int cancelasyncload(int id);   /* @0x800F15D0 */
extern char *getasyncreadadr(int id);   /* @0x800F1640 */
extern int getasyncreadstatus(int id);   /* @0x800F16D8 */

#endif
