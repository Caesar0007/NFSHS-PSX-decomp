#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", InitCARD2);

/* Card-IRQ handler blob, 2nd half (1st half = InitCARD2+0x10) -- code-as-data, no
   C preimage. libcard's _copy_memcard_patch copies [InitCARD2+0x10 .. func_8010CA40)
   (28 words) into kernel RAM @0x0000DF80 as the replacement card interrupt handler;
   never called directly. Re-attributed here from the main.c catch-all (2026-06-24). */
INCLUDE_ASM("asm/nonmatchings/main", func_8010C9FC);
