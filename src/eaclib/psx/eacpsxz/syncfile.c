#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", FILE_opensync);
INCLUDE_ASM("asm/nonmatchings/main", FILE_readsync);
INCLUDE_ASM("asm/nonmatchings/main", FILE_closesync);
INCLUDE_ASM("asm/nonmatchings/main", FILE_sizesync);
INCLUDE_ASM("asm/nonmatchings/main", FILE_addbigsync);
INCLUDE_ASM("asm/nonmatchings/main", FILE_delbigsync);
INCLUDE_ASM("asm/nonmatchings/main", synccallback);
INCLUDE_ASM("asm/nonmatchings/main", syncblockio);
