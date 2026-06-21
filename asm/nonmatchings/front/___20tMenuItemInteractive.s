.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___20tMenuItemInteractive, 0x28

glabel ___20tMenuItemInteractive
    /* 150DC 800248DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 150E0 800248E0 0180023C */  lui        $v0, %hi(_vt_20tMenuItemInteractive)
    /* 150E4 800248E4 28124224 */  addiu      $v0, $v0, %lo(_vt_20tMenuItemInteractive)
    /* 150E8 800248E8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 150EC 800248EC D991000C */  jal        ___9tMenuItem
    /* 150F0 800248F0 180082AC */   sw        $v0, 0x18($a0)
    /* 150F4 800248F4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 150F8 800248F8 00000000 */  nop
    /* 150FC 800248FC 0800E003 */  jr         $ra
    /* 15100 80024900 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___20tMenuItemInteractive
