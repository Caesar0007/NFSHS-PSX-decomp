/* eaclib/psx/eacpsxz/meminit.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\meminit.obj ; EACPSXZ.LIB.  1 fn @0x800F4178.  MEM_defaultevent -- the default
 *   (no-op) memory event handler.  Ghidra nfs4-f.exe.c + IDA sig.
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "meminit.h"

unsigned int MEM_defaultevent(void) {
    return 0;
}

/* what initmemadr needs (it lived in inittmr.c until 2026-09-21) */
extern int creatememclass();
extern int memclass[];

/* initmemadr @0x800F4180 : carve `base[size]` into the default memory class (id 0),
 * gran 8 / align 0x20 / no guards / MEM_defaultevent handler, and cache the class id. */
int initmemadr(int base, int size)
{
    char *name = "RAM";                 /* compiler-owned writable literal @0x8013DD48 */
    int r = creatememclass(0, name, (char *)base, size,
                           8, 0x20, 0, 0, 0, 0, 0, (int)MEM_defaultevent);
    memclass[1] = memclass[0];               /* cached copy @0x8013E904 */
    return r;
}
