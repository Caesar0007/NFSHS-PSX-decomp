.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DMACallback, 0x30

glabel DMACallback
    /* E30AC 800F28AC 1380023C */  lui        $v0, %hi(D_80135B80)
    /* E30B0 800F28B0 805B428C */  lw         $v0, %lo(D_80135B80)($v0)
    /* E30B4 800F28B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E30B8 800F28B8 1000BFAF */  sw         $ra, 0x10($sp)
    /* E30BC 800F28BC 0400428C */  lw         $v0, 0x4($v0)
    /* E30C0 800F28C0 00000000 */  nop
    /* E30C4 800F28C4 09F84000 */  jalr       $v0
    /* E30C8 800F28C8 00000000 */   nop
    /* E30CC 800F28CC 1000BF8F */  lw         $ra, 0x10($sp)
    /* E30D0 800F28D0 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E30D4 800F28D4 0800E003 */  jr         $ra
    /* E30D8 800F28D8 00000000 */   nop
endlabel DMACallback
