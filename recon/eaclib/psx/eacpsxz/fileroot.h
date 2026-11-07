#ifndef _FILEROOT_H_
#define _FILEROOT_H_

#include "eac_types.h"

/* internals -> fileroot_private.h (library sources only; no retail game object records them) */












extern void initfileio(void);   /* 0x800F3A34 */
extern void setdirectory(char *dir);   /* 0x800F3ACC */
extern int openfile(char *name, int flags, int *outp);   /* 0x800F3BE0 */
extern int closefile(int handle);   /* 0x800F3E84 */
extern int readfile(int handle, int dest, int offset, int len);   /* 0x800F3EE0 */
extern unsigned int readfile_systask(int arg1, int arg2);   /* 0x800F3F80 */
extern int writefile(int handle, int buf, int offset, int len);   /* 0x800F4020 */
extern int getfilesize(int handle);   /* 0x800F409C */
extern void stopreadfile(int handle);   /* 0x800F4100 */

#endif
