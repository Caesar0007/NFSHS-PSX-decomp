.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ResetCallback, 0x30

glabel ResetCallback
    /* E304C 800F284C 1380023C */  lui        $v0, %hi(D_80135B80)
    /* E3050 800F2850 805B428C */  lw         $v0, %lo(D_80135B80)($v0)
    /* E3054 800F2854 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E3058 800F2858 1000BFAF */  sw         $ra, 0x10($sp)
    /* E305C 800F285C 0C00428C */  lw         $v0, 0xC($v0)
    /* E3060 800F2860 00000000 */  nop
    /* E3064 800F2864 09F84000 */  jalr       $v0
    /* E3068 800F2868 00000000 */   nop
    /* E306C 800F286C 1000BF8F */  lw         $ra, 0x10($sp)
    /* E3070 800F2870 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E3074 800F2874 0800E003 */  jr         $ra
    /* E3078 800F2878 00000000 */   nop
endlabel ResetCallback
