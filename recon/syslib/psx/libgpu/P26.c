/* syslib/psx/libgpu/P26.c -- RECONSTRUCTED.  obj libgpu.lib(P26.OBJ): SetTile -- initialise a primitive (len 3, code 0x60).
 *   Retail LINKED this member (SYM FILE record, between libmath ADDMANT.obj and libgpu P09.obj) and its final link then
 *   REMOVED the function as unreferenced: that slot holds a 4-byte pad only.  Bytes: PsyQ 4.3 libgpu P26.obj. */
#include "../../../link_stripped.h"

extern void SetTile(void *p) LINK_STRIPPED;
extern void SetTile(void *p)
{
    ((unsigned char *)p)[3] = 3;        /* setlen  */
    ((unsigned char *)p)[7] = 0x60;     /* setcode */
}
