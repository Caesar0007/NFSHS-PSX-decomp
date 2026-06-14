.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__32tPMenuItemLeftRightSliderIndexedb, 0x4C

glabel Draw__32tPMenuItemLeftRightSliderIndexedb
    /* 98528 800A7D28 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9852C 800A7D2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 98530 800A7D30 21808000 */  addu       $s0, $a0, $zero
    /* 98534 800A7D34 1800BFAF */  sw         $ra, 0x18($sp)
    /* 98538 800A7D38 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9853C 800A7D3C 1400028E */  lw         $v0, 0x14($s0)
    /* 98540 800A7D40 00000000 */  nop
    /* 98544 800A7D44 00004290 */  lbu        $v0, 0x0($v0)
    /* 98548 800A7D48 0C00118E */  lw         $s1, 0xC($s0)
    /* 9854C 800A7D4C 80100200 */  sll        $v0, $v0, 2
    /* 98550 800A7D50 21102202 */  addu       $v0, $s1, $v0
    /* 98554 800A7D54 729E020C */  jal        Draw__25tPMenuItemLeftRightSliderb
    /* 98558 800A7D58 0C0002AE */   sw        $v0, 0xC($s0)
    /* 9855C 800A7D5C 0C0011AE */  sw         $s1, 0xC($s0)
    /* 98560 800A7D60 1800BF8F */  lw         $ra, 0x18($sp)
    /* 98564 800A7D64 1400B18F */  lw         $s1, 0x14($sp)
    /* 98568 800A7D68 1000B08F */  lw         $s0, 0x10($sp)
    /* 9856C 800A7D6C 0800E003 */  jr         $ra
    /* 98570 800A7D70 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw__32tPMenuItemLeftRightSliderIndexedb
