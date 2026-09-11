#ifndef _LOCATBIG_H_
#define _LOCATBIG_H_

#include "eac_types.h"

/* intra-obj forward decls (C-linkage) */
extern int   typeofbigfile      (void *hdr);   /* 0x800E5F1C */
extern int   sizeofbigfileheader(void *hdr);   /* 0x800E5F84 */
extern char *locatebigentryz    (void *buf, char *name, int index, int *offset, unsigned int *size);   /* 0x800E5FFC */
extern char *locatebigentry     (void *buf, char *name, int index, int *offset, unsigned int *size);   /* 0x800E61B8 */
extern int   locatebigoffset    (void *buf, char *name);   /* 0x800E61DC */
extern char *locatebig(void *buf, char *name);   /* 0x800E6218 */
extern int   bigcount(void *buf);   /* 0x800E6258 */

#endif
