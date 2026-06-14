.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___32tPMenuItemLeftRightSliderIndexed, 0x28

glabel ___32tPMenuItemLeftRightSliderIndexed
    /* 984B4 800A7CB4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 984B8 800A7CB8 0580023C */  lui        $v0, %hi(_vt_32tPMenuItemLeftRightSliderIndexed)
    /* 984BC 800A7CBC B4614224 */  addiu      $v0, $v0, %lo(_vt_32tPMenuItemLeftRightSliderIndexed)
    /* 984C0 800A7CC0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 984C4 800A7CC4 1F9E020C */  jal        ___25tPMenuItemLeftRightSlider
    /* 984C8 800A7CC8 080082AC */   sw        $v0, 0x8($a0)
    /* 984CC 800A7CCC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 984D0 800A7CD0 00000000 */  nop
    /* 984D4 800A7CD4 0800E003 */  jr         $ra
    /* 984D8 800A7CD8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___32tPMenuItemLeftRightSliderIndexed
