.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tInsideBoxLeftRightSlider, 0x28

glabel ___25tInsideBoxLeftRightSlider
    /* FAC8 8001F2C8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FACC 8001F2CC 0180023C */  lui        $v0, %hi(_vt_25tInsideBoxLeftRightSlider)
    /* FAD0 8001F2D0 C80B4224 */  addiu      $v0, $v0, %lo(_vt_25tInsideBoxLeftRightSlider)
    /* FAD4 8001F2D4 1000BFAF */  sw         $ra, 0x10($sp)
    /* FAD8 8001F2D8 D592000C */  jal        ___24tMenuItemLeftRightSlider
    /* FADC 8001F2DC 180082AC */   sw        $v0, 0x18($a0)
    /* FAE0 8001F2E0 1000BF8F */  lw         $ra, 0x10($sp)
    /* FAE4 8001F2E4 00000000 */  nop
    /* FAE8 8001F2E8 0800E003 */  jr         $ra
    /* FAEC 8001F2EC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25tInsideBoxLeftRightSlider
