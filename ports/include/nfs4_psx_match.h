#ifndef NFS4_PSX_MATCH_H
#define NFS4_PSX_MATCH_H
#include <stdint.h>

/* These are ordinary-C PSX matching variants, separate from the portable API.
 * shapecount requires a 4-byte-aligned, native-little-endian shape file. */
uint32_t nfs4_match_shapecount(const uint32_t *file);
uint32_t nfs4_match_setclipwindow(void);
#endif
