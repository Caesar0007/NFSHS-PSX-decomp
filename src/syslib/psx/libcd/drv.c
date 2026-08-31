#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", CD_get_intr);
INCLUDE_ASM("asm/nonmatchings/main", CD_sync);
INCLUDE_ASM("asm/nonmatchings/main", CD_ready);
INCLUDE_ASM("asm/nonmatchings/main", CD_cw);
INCLUDE_ASM("asm/nonmatchings/main", CD_flush);
INCLUDE_ASM("asm/nonmatchings/main", CD_initvol);
INCLUDE_ASM("asm/nonmatchings/main", CD_initintr);
/* The original identifier is lowercase CD_init (retail SYM + canonical
 * LIBCD/BIOS.obj).  The oracle label remains suffixed solely because its file
 * case-collides with eaclib's CD_Init.s on NTFS. */
INCLUDE_ASM("asm/nonmatchings/main", CD_init_80108140);
__asm__(".globl CD_init\n"
        "CD_init = CD_init_80108140");
INCLUDE_ASM("asm/nonmatchings/main", CD_datasync);
INCLUDE_ASM("asm/nonmatchings/main", CD_getsector);
INCLUDE_ASM("asm/nonmatchings/main", CD_getsector2);
INCLUDE_ASM("asm/nonmatchings/main", CD_set_test_parmnum);
INCLUDE_ASM("asm/nonmatchings/main", _cd_intr_dispatch);
