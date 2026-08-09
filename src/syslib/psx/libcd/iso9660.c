#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", CdSearchFile);
/* @0x800F9984 libcd's lowercase cd_read.  Its oracle lives under the ADDRESS-ONLY filename
 * func_800F9984.s (the glabel inside is still `cd_read`) because `cd_read` and eaclib's
 * `CD_Read` @0x800FA678 case-FOLD to one string on NTFS: `INCLUDE_ASM(..., cd_read)` here
 * silently assembled CD_Read.s, giving expected iso9660.c.o a DUPLICATE definition of
 * eaclib's CD_Read, leaving `cd_read` UNDEFINED, and adding a phantom 0.00%% MATCH_PROGRESS
 * row.  Same defect class as CD_init/CD_Init (see src/syslib/psx/libcd/drv.c).  W52-A10. */
INCLUDE_ASM("asm/nonmatchings/main", func_800F9984);
INCLUDE_ASM("asm/nonmatchings/main", _cd_cmp_name);
INCLUDE_ASM("asm/nonmatchings/main", _cd_find_path);
INCLUDE_ASM("asm/nonmatchings/main", CD_newmedia);
INCLUDE_ASM("asm/nonmatchings/main", CD_cachefile);
