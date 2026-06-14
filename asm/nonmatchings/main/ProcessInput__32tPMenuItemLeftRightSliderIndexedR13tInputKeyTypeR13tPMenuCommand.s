.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand, 0x4C

glabel ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand
    /* 984DC 800A7CDC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 984E0 800A7CE0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 984E4 800A7CE4 21808000 */  addu       $s0, $a0, $zero
    /* 984E8 800A7CE8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 984EC 800A7CEC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 984F0 800A7CF0 1400028E */  lw         $v0, 0x14($s0)
    /* 984F4 800A7CF4 00000000 */  nop
    /* 984F8 800A7CF8 00004290 */  lbu        $v0, 0x0($v0)
    /* 984FC 800A7CFC 0C00118E */  lw         $s1, 0xC($s0)
    /* 98500 800A7D00 80100200 */  sll        $v0, $v0, 2
    /* 98504 800A7D04 21102202 */  addu       $v0, $s1, $v0
    /* 98508 800A7D08 2B9E020C */  jal        ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
    /* 9850C 800A7D0C 0C0002AE */   sw        $v0, 0xC($s0)
    /* 98510 800A7D10 0C0011AE */  sw         $s1, 0xC($s0)
    /* 98514 800A7D14 1800BF8F */  lw         $ra, 0x18($sp)
    /* 98518 800A7D18 1400B18F */  lw         $s1, 0x14($sp)
    /* 9851C 800A7D1C 1000B08F */  lw         $s0, 0x10($sp)
    /* 98520 800A7D20 0800E003 */  jr         $ra
    /* 98524 800A7D24 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand
