#include "common.h"

/* Card-handler patch templates (code-as-data island, no C preimage): two BIOS
   trampolines -- jr 0xA000DFAC (words [0..0x14)) + jalr 0xA000DF80 ([0x14..]).
   _patch_card copies [0..0x14) over the BIOS B0[0x56] table-6 card handler;
   _patch_card2 copies [0x14..) over B0[0x57]. Referenced by %hi/%lo(func_8010CA40)
   in the copiers below, so the name must be preserved. Re-attributed here from the
   main.c catch-all (2026-06-24). */
INCLUDE_ASM("asm/nonmatchings/main", func_8010CA40);

INCLUDE_ASM("asm/nonmatchings/main", _copy_memcard_patch);
INCLUDE_ASM("asm/nonmatchings/main", _patch_card);
INCLUDE_ASM("asm/nonmatchings/main", _patch_card2);
