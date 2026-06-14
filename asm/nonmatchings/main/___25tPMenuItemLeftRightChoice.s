.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tPMenuItemLeftRightChoice, 0x28

glabel ___25tPMenuItemLeftRightChoice
    /* 97D9C 800A759C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97DA0 800A75A0 0580023C */  lui        $v0, %hi(_vt_25tPMenuItemLeftRightChoice)
    /* 97DA4 800A75A4 24624224 */  addiu      $v0, $v0, %lo(_vt_25tPMenuItemLeftRightChoice)
    /* 97DA8 800A75A8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97DAC 800A75AC 429D020C */  jal        ___21tPMenuItemInteractive
    /* 97DB0 800A75B0 080082AC */   sw        $v0, 0x8($a0)
    /* 97DB4 800A75B4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97DB8 800A75B8 00000000 */  nop
    /* 97DBC 800A75BC 0800E003 */  jr         $ra
    /* 97DC0 800A75C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25tPMenuItemLeftRightChoice
