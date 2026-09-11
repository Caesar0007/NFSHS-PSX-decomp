#ifndef _CDFS_H_
#define _CDFS_H_

#include "eac_types.h"

extern int  CD_systaskfunc(void);                             /* @0x800F9AE8 */
extern void CD_timerfunc(void); /* @0x800F9C44 (cdfs read watchdog/poll, below)             */
extern void CdReadyHandler(unsigned char intr, unsigned char *result);  /* @0x800F9CA4 */

/* ---- cdfs internal forward decls (mutually recursive CD machinery) ---- */
extern unsigned char *readsectorB(void);                       /* @0x800FA154 */
extern void loaddirinfo(int startSector, int numSectors, int maxEntries); /* @0x800FA1A8 */

extern int dircompare(const void *a, const void *b);        /* @0x800FA344 (cdfs, below)   */
extern void CD_Restore(void);   /* 0x800FA364 */

extern int CD_Init(int maxOpen, int numEntries, void *buffer, void (*callback)(int));   /* 0x800FA394 */
extern int CD_Restart(int startSector);                      /* @0x800FA4A8 */
extern int CD_Open(char *name, int flags, int *outp);   /* 0x800FA554 */
extern int CD_Close(int handle);   /* 0x800FA65C */
extern int CD_Read(int dev, int dest, int offset, int len);   /* 0x800FA678 */
extern int CD_Stopread(int dev);   /* 0x800FA904 */
extern int CD_Getinfo(int handle, int namebuf, int *sizeout);   /* 0x800FA920 */

#endif
