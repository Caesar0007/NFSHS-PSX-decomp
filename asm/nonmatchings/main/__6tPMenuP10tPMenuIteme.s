.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __6tPMenuP10tPMenuIteme, 0x4C

glabel __6tPMenuP10tPMenuIteme
    /* 987C8 800A7FC8 0400A5AF */  sw         $a1, 0x4($sp)
    /* 987CC 800A7FCC 0800A6AF */  sw         $a2, 0x8($sp)
    /* 987D0 800A7FD0 0C00A7AF */  sw         $a3, 0xC($sp)
    /* 987D4 800A7FD4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 987D8 800A7FD8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 987DC 800A7FDC 21808000 */  addu       $s0, $a0, $zero
    /* 987E0 800A7FE0 0580023C */  lui        $v0, %hi(_vt_6tPMenu)
    /* 987E4 800A7FE4 1C614224 */  addiu      $v0, $v0, %lo(_vt_6tPMenu)
    /* 987E8 800A7FE8 2000A627 */  addiu      $a2, $sp, 0x20
    /* 987EC 800A7FEC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 987F0 800A7FF0 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* 987F4 800A7FF4 500002AE */  sw         $v0, 0x50($s0)
    /* 987F8 800A7FF8 DF9F020C */  jal        tPMenuConstructor__6tPMenuP10tPMenuItemPv
    /* 987FC 800A7FFC 000000AE */   sw        $zero, 0x0($s0)
    /* 98800 800A8000 21100002 */  addu       $v0, $s0, $zero
    /* 98804 800A8004 1400BF8F */  lw         $ra, 0x14($sp)
    /* 98808 800A8008 1000B08F */  lw         $s0, 0x10($sp)
    /* 9880C 800A800C 0800E003 */  jr         $ra
    /* 98810 800A8010 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __6tPMenuP10tPMenuIteme
