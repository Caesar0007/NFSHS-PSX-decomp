.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VSyncCallback, 0x34

glabel VSyncCallback
    /* E30DC 800F28DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E30E0 800F28E0 1380023C */  lui        $v0, %hi(D_80135B80)
    /* E30E4 800F28E4 805B428C */  lw         $v0, %lo(D_80135B80)($v0)
    /* E30E8 800F28E8 21288000 */  addu       $a1, $a0, $zero
    /* E30EC 800F28EC 1000BFAF */  sw         $ra, 0x10($sp)
    /* E30F0 800F28F0 1400428C */  lw         $v0, 0x14($v0)
    /* E30F4 800F28F4 00000000 */  nop
    /* E30F8 800F28F8 09F84000 */  jalr       $v0
    /* E30FC 800F28FC 04000424 */   addiu     $a0, $zero, 0x4
    /* E3100 800F2900 1000BF8F */  lw         $ra, 0x10($sp)
    /* E3104 800F2904 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E3108 800F2908 0800E003 */  jr         $ra
    /* E310C 800F290C 00000000 */   nop
endlabel VSyncCallback
