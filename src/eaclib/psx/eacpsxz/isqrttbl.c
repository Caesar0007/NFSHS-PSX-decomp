#include "common.h"

/* W71-A15 attribution fix: remapshiftjiscode/decodeshiftjis belong to
 * textcode.obj (proven by .data adjacency -- textcode's SJIS remap table
 * D_8013BD50 ends exactly at 0x8013BE10 = isqrttbl -- and by the
 * obj-annotated disasm: isqrttbl.obj contributes no text). Their
 * INCLUDE_ASM lines moved to textcode.c; this is a pure data unit. */
