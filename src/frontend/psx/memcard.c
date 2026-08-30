#include "common.h"

INCLUDE_ASM("asm/nonmatchings/front", MCRD_init);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_InitCard);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_restore);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_getopts);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_setopts);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_loadfile);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_DoFileLoad);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_savefile);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_DoFileWrite);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_DoFileDelete);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_handlecardevents);
INCLUDE_ASM("asm/nonmatchings/front", MCRD_fileexists);

/* W72-A7 attribution fix: MCRD_getcard belongs HERE (SYM SLD contiguous across
 * fileexists->getcard->timersub, all file=FRONTEND\PSX\MEMCARD.C, getcard at
 * MEMCARD.C:1364 -- no object boundary at 0x80050244; src/frontend/common/mcrd.c
 * was a phantom object). Recon body moved to recon/frontend/psx/memcard.c in
 * ec580509; this line + the unit/linker cleanup complete the move. */
INCLUDE_ASM("asm/nonmatchings/front", MCRD_getcard);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_timersub);
INCLUDE_ASM("asm/nonmatchings/front", garyMemCardGrabBlocks);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_LoadCard);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_FormatCard);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_HandleError);
INCLUDE_ASM("asm/nonmatchings/front", iMCRD_DefaultCBProc1);
INCLUDE_ASM("asm/nonmatchings/front", ascii2sjis);
INCLUDE_ASM("asm/nonmatchings/front", sjis2ascii);
