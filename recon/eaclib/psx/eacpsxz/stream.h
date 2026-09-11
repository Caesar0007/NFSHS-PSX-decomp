#ifndef _STREAM_H_
#define _STREAM_H_

#include "eac_types.h"

typedef struct StreamFilter {
    unsigned int mask;
    unsigned int value;
    unsigned int consumer;
} StreamFilter;

extern int  validatehandle(int handle, int *outObj, int *outHandle);   /* @0x800FC2F8 */
extern unsigned int inbetween(unsigned int a, unsigned int b, unsigned int c);   /* @0x800FC334 */
extern int  decbufferusage(int s, int amount);   /* @0x800FC374 */
extern int *getfreerequest(int s);   /* @0x800FC400 */
extern int  queuerequest(int s, int req);   /* @0x800FC478 */
extern int  freerequest(int s, int req);   /* @0x800FC548 */
extern unsigned int filterchunk(int s, int chunk);   /* @0x800FC5E4 */
extern int  parsechunks(int s);   /* @0x800FC634 */
extern void opencallback(int a0, int a1, int s);   /* @0x800FC810 */
extern void closecallback(int a0, int a1, int s);   /* @0x800FC850 */
extern int  readcallback(int a0, int a1, int s);   /* @0x800FC8A8 */
extern int  startnextrequest(int s, unsigned int prio);   /* @0x800FC9B4 */
extern int  restartstream(int s, unsigned int prio);   /* @0x800FCB44 */
extern int  STREAM_overhead(int numReq, int numFilters, int numConsumers);   /* @0x800FCDE0 */
extern int STREAM_create(int numReq, int numFilters, int numConsumers, int objbuf, int bufsize);   /* @0x800FCE14 */
extern void STREAM_setfilter(int consumer, int filterIdx, unsigned int mask, unsigned int match, int value);   /* @0x800FD054 */
extern void STREAM_destroy(int s);   /* @0x800FD144 */
extern void STREAM_setpriority(int s, int prioA, int prioB);   /* @0x800FD1F8 */
extern void STREAM_setgreedylevel(int s, int lvl);   /* @0x800FD248 */
extern void STREAM_setgreedystate(int s, int state);   /* @0x800FD2B4 */
extern unsigned int STREAM_queuefile(int s, char *name, int off, int len);   /* @0x800FD314 */
extern unsigned int STREAM_queuemem(int s, int blocklist, void *ptr, int len);   /* @0x800FD428 */
extern int  STREAM_cancelrequest(int s, int req);   /* @0x800FD554 */
extern void STREAM_kill(int s);   /* @0x800FD808 */
extern int  STREAM_get(int consumer);   /* @0x800FD9AC */
extern void STREAM_release(int s, int consumer);   /* @0x800FDAD0 */
extern int STREAM_gettable(int s);   /* @0x800FDBCC */
extern int STREAM_state(int s);   /* @0x800FDC04 */
extern int STREAM_isendofstream(int s);   /* @0x800FDC3C */
extern int STREAM_buffersize(int s);   /* @0x800FDC98 */
extern int STREAM_bufferusage(int s);   /* @0x800FDCE0 */

#endif
