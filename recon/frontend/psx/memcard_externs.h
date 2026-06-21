/* frontend/psx/memcard_externs.h - reconstructed extern decls (libmcrd/libgs/eaclib/libc)
 * referenced by MEMCARD.C. NOT an original header; added for standalone C++ compile.
 * Signatures inferred from PsyQ 4.3 libmcrd + call sites (refine if a call mismatches). */
#ifndef _FRONTEND_PSX_MEMCARD_EXTERNS_H_
#define _FRONTEND_PSX_MEMCARD_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

typedef unsigned short undefined2;   /* Ghidra pseudo-types used in decompiler output */
typedef unsigned int   undefined4;
extern int timerhz;
extern int ticks;

extern "C" {
/* EA shape helpers (build shapetbl type/clut words) */
unsigned int shapetype(int v);
unsigned int cluttype(int v);
/* PsyQ libmcrd */
long MemCardInit(long val);
long MemCardStart(void);
long MemCardStop(void);
void MemCardEnd(void);
long MemCardSync(long mode, long *result, long *result2);
long MemCardExist(long chan);
long MemCardAccept(long chan);
long MemCardReadFile(long chan, char *name, void *buf, long offset, long len);
long MemCardWriteFile(long chan, char *name, void *buf, long offset, long len);
long MemCardCreateFile(long chan, char *name, long nslots);
long MemCardDeleteFile(long chan, char *name);
long MemCardFormat(long chan);
long MemCardGetDirentry(long chan, char *pat, DIRENTRY *dir, int *count, long a, long b);
/* PsyQ libgs (shape) - returns pointer to the shape's CLUT data */
u_char *getshapeclut(shapetbl *shape, int src);
/* eaclib */
/* libetc */
/* libc */
/* sibling (other memcard TU) */
CARDINFO_def *MCRD_getcard(int card);
}
#endif
