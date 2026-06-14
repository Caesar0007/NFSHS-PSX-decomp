.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tPMenuItemLeftRightSlider, 0x28

glabel ___25tPMenuItemLeftRightSlider
    /* 9807C 800A787C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 98080 800A7880 0580023C */  lui        $v0, %hi(_vt_25tPMenuItemLeftRightSlider)
    /* 98084 800A7884 EC614224 */  addiu      $v0, $v0, %lo(_vt_25tPMenuItemLeftRightSlider)
    /* 98088 800A7888 1000BFAF */  sw         $ra, 0x10($sp)
    /* 9808C 800A788C 429D020C */  jal        ___21tPMenuItemInteractive
    /* 98090 800A7890 080082AC */   sw        $v0, 0x8($a0)
    /* 98094 800A7894 1000BF8F */  lw         $ra, 0x10($sp)
    /* 98098 800A7898 00000000 */  nop
    /* 9809C 800A789C 0800E003 */  jr         $ra
    /* 980A0 800A78A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25tPMenuItemLeftRightSlider
