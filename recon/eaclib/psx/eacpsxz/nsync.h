#ifndef _NSYNC_H_
#define _NSYNC_H_

#include "eac_types.h"

typedef struct LoadArgs {
    char *name;      /* +0x00  source filename                                   */
    int   dest;      /* +0x04  fixed destination (loadfileat* family)            */
    int   memclass;  /* +0x08  allocator class id (loadfile* / bigfile family)   */
    int   abortval;  /* +0x0C  abort flag snapshot (0 for the "z" variants)      */
} LoadArgs;

extern int filesizeatomic(int retry, LoadArgs *a);   /* @0x800E5608 */
extern int filesize(char *name);   /* @0x800E566C */
extern void *loadfileadratomic(int retry, LoadArgs *a);   /* @0x800E56B0 */
extern int loadfileadrz(char *name, int memclass);   /* @0x800E57A8 */
extern int loadfileadr(char *name, int memclass);   /* @0x800E57E8 */
extern int loadfileatadratomic(int retry, LoadArgs *a);   /* @0x800E5830 */
extern int loadfileatadrz(char *name, int dest);   /* @0x800E58B0 */
extern int loadfileatadr(char *name, int dest);   /* @0x800E58F0 */
extern void *loadbigfileheaderatomic(int retry, LoadArgs *a);   /* @0x800E5938 */
extern int loadbigfileheader(char *name, int memclass);   /* @0x800E5A7C */

#endif
