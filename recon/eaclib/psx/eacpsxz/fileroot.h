#ifndef _FILEROOT_H_
#define _FILEROOT_H_

#include "eac_types.h"

/* the single-slot deferred PC-host read command (executed by readfile_systask).
 * @0x80140400 (.bss, 20B = 5 ints). The `extern` form below was only a DECLARATION
 * (a promise) -> the storage was never defined in any TU (surfaced by the link harness).
 * Defined here, its owning TU, since ReadCmd is a TU-local struct. Zero-init (BSS). */
struct ReadCmd {
    int pending;   /* +0x00 nonzero == a command is queued */
    int handle;    /* +0x04 dev descriptor (fs byte already masked off) */
    int dest;      /* +0x08 destination address */
    int offset;    /* +0x0C file offset */
    int len;       /* +0x10 byte count */
};
typedef struct ReadCmd ReadCmd;

extern void initfileio(void);   /* 0x800F3A34 */
extern void setdirectory(char *dir);   /* 0x800F3ACC */
extern int openfile(char *name, int flags, int *outp);   /* 0x800F3BE0 */
extern int closefile(int handle);   /* 0x800F3E84 */
extern int readfile(int handle, int dest, int offset, int len);   /* 0x800F3EE0 */
extern int readfile_systask(void);   /* 0x800F3F80 */
extern int writefile(int handle, int buf, int offset, int len);   /* 0x800F4020 */
extern int getfilesize(int handle);   /* 0x800F409C */
extern void stopreadfile(int handle);   /* 0x800F4100 */

#endif
