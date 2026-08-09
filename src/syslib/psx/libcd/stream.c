#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", StSetStream);
INCLUDE_ASM("asm/nonmatchings/main", StClearRing);
INCLUDE_ASM("asm/nonmatchings/main", StSetRing);
/* w52-a2: func_800FC4E4 re-attributed to eaclib eacpsxz/stream.c (it is
 * locaterequest's 2nd linked copy; libcd stream fns live @0x800F8-9xxx). */
