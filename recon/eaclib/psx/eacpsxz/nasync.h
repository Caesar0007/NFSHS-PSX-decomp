#ifndef _NASYNC_H_
#define _NASYNC_H_

#include "eac_types.h"
#include "../../../lib/nasync.h"

extern int initasync(int numreq, int blocksize, int memclass);   /* @0x800F11B0 */
extern int asyncloadfilecallback(int name, int memclass, int cb);   /* @0x800F12B0 */
extern int asyncloadfile(int name, int memclass);   /* @0x800F1368 */
extern int asyncloadfileatcallback(int name, int dest, int cb);   /* @0x800F1388 */
extern int asyncloadfileat(int name, int dest);   /* @0x800F143C */
extern void setasyncfile(int name);   /* @0x800F145C */
extern int asyncloadsegmentcallback(int offset, int dest, int size, int cb);   /* @0x800F14BC */
extern int asyncloadsegment(int offset, int dest, int size);   /* @0x800F15B0 */
extern int cancelasyncload(int id);   /* @0x800F15D0 */
extern int getasyncreadadr(int id);   /* @0x800F1640 */
extern int getasyncreadstatus(int id);   /* @0x800F16D8 */

#endif
