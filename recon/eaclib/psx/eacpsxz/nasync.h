#ifndef _NASYNC_H_
#define _NASYNC_H_

#include "eac_types.h"
#include "../../../lib/nasync.h"

extern void queueadd(AsyncQueue *q, AsyncReq *n);   /* @0x800F0B1C */
extern AsyncReq *queuefetch(AsyncQueue *q);   /* @0x800F0B74 */
extern int newrequestid(AsyncReq *r);   /* @0x800F0BC0 */
extern void cancelrequest(AsyncReq *r);   /* @0x800F0C50 */
extern void finishrequest(AsyncReq *r);   /* @0x800F0CE8 */
extern int loadfileclosecallback(int id, int status, AsyncReq *req);   /* @0x800F0D24 */
extern void loadfilereadcallback(int id, int status, AsyncReq *req);   /* @0x800F0D80 */
extern int loadfilesizecallback(int id, int status, AsyncReq *req);   /* @0x800F0E54 */
extern int loadfileopencallback(int id, int status, AsyncReq *req);   /* @0x800F0F18 */
extern int loadsegreadcallback(int id, int status, AsyncReq *req);   /* @0x800F1024 */
extern int asyncsystemtask(void);   /* @0x800F1120 */
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
