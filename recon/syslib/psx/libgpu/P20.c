/* syslib/psx/libgpu/P20.c -- RECONSTRUCTED.  obj libgpu.lib(P20.OBJ): SetSprt8 -- initialise a primitive (len 3, code 0x74).
 *   Retail LINKED this member (SYM FILE record, between libmath ADDMANT.obj and libgpu P09.obj) and its final link then
 *   REMOVED the function as unreferenced: that slot holds a 4-byte pad only.  Bytes: PsyQ 4.3 libgpu P20.obj. */
#include "../../../link_stripped.h"

extern void SetSprt8(void *p) LINK_STRIPPED;
extern void SetSprt8(void *p)
{
    ((unsigned char *)p)[3] = 3;        /* setlen  */
    ((unsigned char *)p)[7] = 0x74;     /* setcode */
}
