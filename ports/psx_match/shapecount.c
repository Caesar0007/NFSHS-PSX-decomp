#include "../include/nfs4_psx_match.h"

/* shapecount @0x800F0AAC: linked PsyQ 4.3 output is all three retail words.
 * A direct word view is valid on PSX; the general port uses endian-safe bytes. */
uint32_t nfs4_match_shapecount(const uint32_t *file)
{
    return file[2];
}
