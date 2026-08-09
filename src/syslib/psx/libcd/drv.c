#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", CD_get_intr);
INCLUDE_ASM("asm/nonmatchings/main", CD_sync);
INCLUDE_ASM("asm/nonmatchings/main", CD_ready);
INCLUDE_ASM("asm/nonmatchings/main", CD_cw);
INCLUDE_ASM("asm/nonmatchings/main", CD_flush);
INCLUDE_ASM("asm/nonmatchings/main", CD_initvol);
INCLUDE_ASM("asm/nonmatchings/main", CD_initintr);
/* @0x80108140 libcd's lowercase CD_init.  splat appended the VA to keep its oracle file
 * apart from eaclib's CD_Init @0x800FA394 -- the two names case-FOLD to the same string on
 * NTFS, so `INCLUDE_ASM(..., CD_init)` here silently assembles CD_Init.s (it did, in
 * src/syslib/psx/libmcrd/BIOS.c, giving expected BIOS.c.o a duplicate CD_Init and a phantom
 * 0.00%% MATCH_PROGRESS row).  The recon side uses the same VA-suffixed name. */
INCLUDE_ASM("asm/nonmatchings/main", CD_init_80108140);
INCLUDE_ASM("asm/nonmatchings/main", CD_datasync);
INCLUDE_ASM("asm/nonmatchings/main", CD_getsector);
INCLUDE_ASM("asm/nonmatchings/main", CD_getsector2);
INCLUDE_ASM("asm/nonmatchings/main", CD_set_test_parmnum);
INCLUDE_ASM("asm/nonmatchings/main", _cd_intr_dispatch);
