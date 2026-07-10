/* lib/nasync.h -- EA async-loader shared types (nasync.obj, EACPSXZ.LIB).  Reconstructed from nfs4-f.exe
 *   (disasm-v3); NOT original source.  nasync layers a fire-and-forget async file loader ON TOP of the
 *   nfile FILE_* API: each load is an AsyncReq slot driven through open->size->read(chunked)->close->finish
 *   by FILE completion callbacks.  Slots live in a fixed `request[numrequests]` pool; a request id packs
 *   the slot index (low byte) with a rolling `requestidcounter` (upper bits) so stale ids are detectable.
 *   Free slots sit on `freequeue`; finished slots needing a user callback go on `callqueue`, drained by
 *   asyncsystemtask().  Allocation/queue edits run in a cop0 IRQ-disabled critical section (host no-op).
 */
#ifndef LIB_NASYNC_H
#define LIB_NASYNC_H

#ifdef __cplusplus
extern "C" {
#endif

/* ---- one async-load request : 0x2C (44) bytes, array at `request` ---- */
typedef struct AsyncReq {
    int id;                /* +0x00 (slotIndex in low byte) | (requestidcounter in upper bits)         */
    struct AsyncReq *next; /* +0x04 free/call-queue link                                                */
    int bytesread;         /* +0x08 bytes transferred so far (0 == not started; getasyncreadstatus)     */
    int status;            /* +0x0C 0 == active; 1 == cancel-requested; 2 == cancelled                  */
    int buffer;            /* +0x10 result buffer addr (1 == "allocate by size" sentinel until alloc'd) */
    int callback;          /* +0x14 optional user completion callback fn ptr (0 == poll-only)           */
    int fileop;            /* +0x18 in-flight FILE op id (FILE_completeop'd in each callback)            */
    int handle;            /* +0x1C FILE handle from FILE_open                                          */
    int offset;            /* +0x20 file read offset cursor                                             */
    int arg24;             /* +0x24 reservememadr mem-class (file load) / remaining size (segment load) */
    int dest;              /* +0x28 memory destination cursor                                           */
} AsyncReq;                /* 0x2C */

/* ---- a FIFO queue of requests : {head, tail} (8 bytes) ---- */
typedef struct AsyncQueue {
    AsyncReq *head;        /* +0x00 */
    AsyncReq *tail;        /* +0x04 */
} AsyncQueue;

/* ---- nasync globals (data-materialization pass owns the addresses) ---- */
extern AsyncReq  *request;          /* the request slot pool (reservememadr'd in initasync)            */
extern int        numrequests;      /* pool size                                                       */
extern int        readblocksize;    /* per-chunk read size                                             */
extern int        requestidcounter; /* rolling id stamp (+= 0x100, never 0)                            */
/* The two FIFOs live in .sbss as FOUR gp-addressable words (SYM: `freequeue` @0x8013DEA0, `callqueue`
 * @0x8013DEA8; the original EACLIB build gp-rels each word — initasync.s %gp_rel(D_8013DEA0..AC)).  Under
 * our -G4 an 8-byte AsyncQueue .comm cannot be gp-rel, so model each word as its own 4-byte tentative def
 * (value access = gp-rel, `la` of the head = absolute lui/addiu — byte-identical to retail; proven by
 * setasyncfile/asyncfilehandle).  `(AsyncQueue *)&freequeuehead` is the {head,tail} view for queueadd/fetch. */
extern AsyncReq  *freequeuehead;    /* @0x8013DEA0 : free-slot FIFO head                                */
extern AsyncReq  *freequeuetail;    /* @0x8013DEA4 : free-slot FIFO tail                                */
extern AsyncReq  *callqueuehead;    /* @0x8013DEA8 : finished-slot FIFO head (user callback pending)    */
extern AsyncReq  *callqueuetail;    /* @0x8013DEAC : finished-slot FIFO tail                            */
extern int        asyncfilehandle;  /* @0x8013DEB0 : the FILE handle set by setasyncfile (segment loads)*/
extern int        asyncfileoffset;  /* running file offset for segment loads                           */
extern void      *mutex;            /* allocmutex() handle                                             */

/* ---- cop0 IRQ-disabled critical section (host no-op; faithful intent on the MIPS target) ---- */
#if defined(__mips__)
void ASYNC_enterCS(void);
void ASYNC_leaveCS(void);
#else
static inline void ASYNC_enterCS(void) {}
static inline void ASYNC_leaveCS(void) {}
#endif

#ifdef __cplusplus
}
#endif
#endif /* LIB_NASYNC_H */
