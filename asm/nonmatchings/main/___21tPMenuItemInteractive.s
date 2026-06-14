.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___21tPMenuItemInteractive, 0x28

glabel ___21tPMenuItemInteractive
    /* 97D08 800A7508 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97D0C 800A750C 0580023C */  lui        $v0, %hi(_vt_21tPMenuItemInteractive)
    /* 97D10 800A7510 5C624224 */  addiu      $v0, $v0, %lo(_vt_21tPMenuItemInteractive)
    /* 97D14 800A7514 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97D18 800A7518 019D020C */  jal        ___10tPMenuItem
    /* 97D1C 800A751C 080082AC */   sw        $v0, 0x8($a0)
    /* 97D20 800A7520 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97D24 800A7524 00000000 */  nop
    /* 97D28 800A7528 0800E003 */  jr         $ra
    /* 97D2C 800A752C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___21tPMenuItemInteractive
