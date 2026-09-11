#ifndef _MEMSTD_H_
#define _MEMSTD_H_

#include "eac_types.h"

typedef struct MemBlock {
    unsigned short   magic;     /* +0x00  'MB'/'FB'/0x4253 sentinel            */
    unsigned short   flags;     /* +0x02  bit0x4000=on-freelist; low nibble=class id */
    int              size;      /* +0x04  payload size                         */
    struct MemBlock *physnext;  /* +0x08  next block by address (adjacent)     */
    struct MemBlock *physprev;  /* +0x0C  prev block by address                */
    struct MemBlock *freenext;  /* +0x10  free-list forward  (overlays payload)*/
    struct MemBlock *freeprev;  /* +0x14  free-list backward                   */
} MemBlock;

typedef struct MemClass {
    char       name[8];         /* +0x00  class name (strcpy'd)                */
    MemBlock  *phys_first;      /* +0x08  first physical block (=membuf)       */
    MemBlock  *phys_last;       /* +0x0C  last  physical block (=HIGH block)   */
    MemBlock   freehead;        /* +0x10  embedded free-ring sentinel MemBlock */
                                /*        (magic@+0x10 size@+0x14 next@+0x20 prev@+0x24) */
    int        granularity;     /* +0x28  per-alloc size granularity           */
    int        alignment;       /* +0x2C  buffer/alloc alignment               */
    int        infosize;        /* +0x30  per-block overhead reserved          */
    int        flags;           /* +0x34  class flags (0x100=named,0x700 mask) */
    void      *mutex;           /* +0x38  optional mutex handle                */
    int        field3c;         /* +0x3C  user field                          */
} MemClass;

extern MemBlock *FREE_find(MemClass *mb, int size, int reverse);   /* @0x800E4D4C */
extern MemBlock *FREE_findlargest(MemClass *mb, int size, int reverse);   /* @0x800E4DB0 */
extern void FREE_add(MemClass *mb, MemBlock *node);   /* @0x800E4E70 */
extern void FREE_remove(MemClass *mb, MemBlock *node);   /* @0x800E4F04 */
extern int initmemblock(MemBlock *blk, char *name, int size, int tailextra, int flags, MemBlock *physprev, MemBlock *physnext);   /* @0x800E4F2C */
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
