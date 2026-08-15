#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", ResetCallback);
INCLUDE_ASM("asm/nonmatchings/main", InterruptCallback);
INCLUDE_ASM("asm/nonmatchings/main", DMACallback);
INCLUDE_ASM("asm/nonmatchings/main", VSyncCallback);
INCLUDE_ASM("asm/nonmatchings/main", VSyncCallbacks);
INCLUDE_ASM("asm/nonmatchings/main", CheckCallback);
INCLUDE_ASM("asm/nonmatchings/main", SetIntrMask);
INCLUDE_ASM("asm/nonmatchings/main", _initIntr);
INCLUDE_ASM("asm/nonmatchings/main", _intrhand);
INCLUDE_ASM("asm/nonmatchings/main", _set_intr_callback);
INCLUDE_ASM("asm/nonmatchings/main", StopCallback);
INCLUDE_ASM("asm/nonmatchings/main", RestartCallback);
/* W67-A5: INTR.OBJ's _bzero_w is the 0x800F2E70 copy (this TU's region), not the
 * 0x80106924 one -- both TUs used to include the SAME _bzero_w.s, exporting one
 * global twice (the `_bzero_w' REAL dup in relink).  The _800F2E70 file carries
 * the retail bytes of THIS object's static copy, bound LOCAL. */
INCLUDE_ASM("asm/nonmatchings/main", _bzero_w_800F2E70);
