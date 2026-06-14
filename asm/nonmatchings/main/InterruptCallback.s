.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InterruptCallback, 0x30

glabel InterruptCallback
    /* E307C 800F287C 1380023C */  lui        $v0, %hi(D_80135B80)
    /* E3080 800F2880 805B428C */  lw         $v0, %lo(D_80135B80)($v0)
    /* E3084 800F2884 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E3088 800F2888 1000BFAF */  sw         $ra, 0x10($sp)
    /* E308C 800F288C 0800428C */  lw         $v0, 0x8($v0)
    /* E3090 800F2890 00000000 */  nop
    /* E3094 800F2894 09F84000 */  jalr       $v0
    /* E3098 800F2898 00000000 */   nop
    /* E309C 800F289C 1000BF8F */  lw         $ra, 0x10($sp)
    /* E30A0 800F28A0 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E30A4 800F28A4 0800E003 */  jr         $ra
    /* E30A8 800F28A8 00000000 */   nop
endlabel InterruptCallback
