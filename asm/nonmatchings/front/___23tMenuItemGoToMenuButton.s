.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tMenuItemGoToMenuButton, 0x28

glabel ___23tMenuItemGoToMenuButton
    /* 15B7C 8002537C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 15B80 80025380 0180023C */  lui        $v0, %hi(_vt_23tMenuItemGoToMenuButton)
    /* 15B84 80025384 20114224 */  addiu      $v0, $v0, %lo(_vt_23tMenuItemGoToMenuButton)
    /* 15B88 80025388 1000BFAF */  sw         $ra, 0x10($sp)
    /* 15B8C 8002538C 3792000C */  jal        ___20tMenuItemInteractive
    /* 15B90 80025390 180082AC */   sw        $v0, 0x18($a0)
    /* 15B94 80025394 1000BF8F */  lw         $ra, 0x10($sp)
    /* 15B98 80025398 00000000 */  nop
    /* 15B9C 8002539C 0800E003 */  jr         $ra
    /* 15BA0 800253A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23tMenuItemGoToMenuButton
