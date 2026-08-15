/* lib/nfile.h -- EA "FILE" async file-operation layer shared types (struct-first nfile pass, 2026-06-10).
 *   Reconstructed from nfs4-f.exe (disasm-v3). NOT original source.  Single source of truth for the
 *   nfile.obj + nasync.obj reconstructions (EACPSXZ.LIB).  Structs are BYTE-EXACT in size; the known
 *   fields are named and the rest padded.  Grow this header as the 27+23 functions are reconstructed.
 *
 *   One global FileMgr @0x8013EA88 owns an array of FileOp (op queue) and FileHandle (open files):
 *     reserveop/freeop allocate/clear a 0x30-byte FileOp ; reservehandle/freehandle a 0x4C-byte handle.
 *   Allocation runs inside a PSX interrupt-disabled critical section (cop0 in the asm).
 */
#ifndef LIB_NFILE_H
#define LIB_NFILE_H

#ifdef __cplusplus
extern "C" {
#endif

/* ---- one file operation : 0x30 (48) bytes, array at FileMgr.oparray ---- */
typedef struct FileOp {
    unsigned int id;       /* +0x00 packed op id: bits24-31 = op index (byte3), bits20-23 = type     */
                           /*        nibble (0 == free, set to 1 on reserve), bits0-19 = request seq */
    int  cancelreq;        /* +0x04 set to 1 to request cancel of the in-flight op (FILE_cancelop)    */
    int  status;           /* +0x08 operation status (FILE_opstatus returns this; 0 == none)         */
    int  error;            /* +0x0C error code (FILE_operror returns this)                            */
    int  prio;             /* +0x10 queue priority (also reused as an input arg by open/read/size)    */
    int  param;            /* +0x14 callback parameter                                                */
    int  result18;         /* +0x18 completeop result for op types 6/8 (e.g. size)                    */
    int  result1C;         /* +0x1C completeop result for op types 4/5 (e.g. read bytes)              */
    unsigned char _g20[0x24 - 0x20];
    int  result24;         /* +0x24 completeop result for op types 2/9 (e.g. open handle)             */
    void (*callback)(void);/* +0x28 completion callback fn ptr                                        */
    struct FileOp *qnext;  /* +0x2C next op in the priority-sorted pending queue                       */
} FileOp;                  /* 0x30 */

/* ---- one open-file handle : 0x4C (76) bytes, array at FileMgr.handlearray ----
 *  Layout recovered from FILE_open + iFILE_ExecCommand: the 0x40-byte filename is copied to +0x0C, so
 *  with +0x00 device control, +0x04 size and +0x08 flags it exactly fills the 0x4C slot (0x0C+0x40). */
typedef struct FileHandle {
    int  inuse;            /* +0x00 nonzero == allocated (also reused as the device/file-control word)  */
    int  size;             /* +0x04 file size in bytes (set from getfilesize; FILE_read clamps to it)   */
    int  flags;            /* +0x08 open flags / state                                                  */
    char name[0x40];       /* +0x0C filename (strncpy'd by FILE_open, 0x40 bytes -> fills to 0x4C)       */
} FileHandle;              /* 0x4C */

/* ---- the FILE manager singleton @0x8013EA88 ---- */
typedef struct FileMgr {
    int         opcount;       /* +0x00 number of op slots   (aliased as the `gFileDevice` symbol)  */
    int         handlecount;   /* +0x04 number of file handles                                      */
    int         idmask;        /* +0x08 = 0xFF                                                       */
    int         state;         /* +0x0C dispatcher state (>= 2 means the pending queue is active)    */
    int         cbpending;     /* +0x10 count of pending completion callbacks                       */
    FileOp     *curop;         /* +0x14 the op currently being dispatched (never reordered)          */
    FileOp     *oparray;       /* +0x18 op slot array  (reservememadr-allocated buffer)             */
    FileHandle *handlearray;   /* +0x1C handle array   (== oparray + opcount*0x30)                  */
    FileOp     *queuehead;     /* +0x20 head of the priority-sorted pending-op queue (@0x8013EAA8)   */
    void       *devicelist;    /* +0x24 head of the open-device linked list (node+4=handle, +0xC=next)*/
    unsigned char _g28[0x30 - 0x28];   /* mem/callback fields TBD                                   */
} FileMgr;                     /* >= 0x30 */

extern FileMgr gFileMgr;       /* @0x8013EA88 (data-materialization pass owns) */

/* sequence counter (20-bit wrap) used to stamp request ids */
extern int gFileOpSeq;         /* @0x8013DC50 */

/* shared helper (eacpsxz @0x800F17A0) */
void blockclear(void *dst, int n);

/* ---- PSX interrupt-disabled critical section (cop0 mtc0/mfc0 in the asm). ----
 *  On the MIPS target these disable/restore IRQs around the op/handle table edits; on a portable
 *  host build they are no-ops (single-threaded).  Faithful to intent; the table edits are atomic. */
#if defined(__mips__)
/* real recompile would emit the EnterCriticalSection / ExitCriticalSection (cop0) sequence */
void FILE_enterCS(void);
void FILE_leaveCS(void);
#else
static inline void FILE_enterCS(void) {}
static inline void FILE_leaveCS(void) {}
#endif

#ifdef __cplusplus
}
#endif
#endif /* LIB_NFILE_H */
