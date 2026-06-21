.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___24tMenuItemLeftRightSlider, 0x28

glabel ___24tMenuItemLeftRightSlider
    /* 15354 80024B54 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 15358 80024B58 0180023C */  lui        $v0, %hi(_vt_24tMenuItemLeftRightSlider)
    /* 1535C 80024B5C 78114224 */  addiu      $v0, $v0, %lo(_vt_24tMenuItemLeftRightSlider)
    /* 15360 80024B60 1000BFAF */  sw         $ra, 0x10($sp)
    /* 15364 80024B64 3792000C */  jal        ___20tMenuItemInteractive
    /* 15368 80024B68 180082AC */   sw        $v0, 0x18($a0)
    /* 1536C 80024B6C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 15370 80024B70 00000000 */  nop
    /* 15374 80024B74 0800E003 */  jr         $ra
    /* 15378 80024B78 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___24tMenuItemLeftRightSlider
