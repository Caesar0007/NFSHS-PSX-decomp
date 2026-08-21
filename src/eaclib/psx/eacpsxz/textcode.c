#include "common.h"
INCLUDE_ASM("asm/nonmatchings/main", decodeansi);
/* W71-A15 attribution fix (moved from isqrttbl.c; VA order 0x801069C4/0x801069EC) */
INCLUDE_ASM("asm/nonmatchings/main", remapshiftjiscode);
INCLUDE_ASM("asm/nonmatchings/main", decodeshiftjis);
