.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VSyncCallbacks, 0x30

glabel VSyncCallbacks
    /* E3110 800F2910 1380023C */  lui        $v0, %hi(D_80135B80)
    /* E3114 800F2914 805B428C */  lw         $v0, %lo(D_80135B80)($v0)
    /* E3118 800F2918 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E311C 800F291C 1000BFAF */  sw         $ra, 0x10($sp)
    /* E3120 800F2920 1400428C */  lw         $v0, 0x14($v0)
    /* E3124 800F2924 00000000 */  nop
    /* E3128 800F2928 09F84000 */  jalr       $v0
    /* E312C 800F292C 00000000 */   nop
    /* E3130 800F2930 1000BF8F */  lw         $ra, 0x10($sp)
    /* E3134 800F2934 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E3138 800F2938 0800E003 */  jr         $ra
    /* E313C 800F293C 00000000 */   nop
endlabel VSyncCallbacks
