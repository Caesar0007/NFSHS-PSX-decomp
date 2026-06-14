.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___6tPMenu, 0x34

glabel ___6tPMenu
    /* 98814 800A8014 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 98818 800A8018 0580023C */  lui        $v0, %hi(_vt_6tPMenu)
    /* 9881C 800A801C 1C614224 */  addiu      $v0, $v0, %lo(_vt_6tPMenu)
    /* 98820 800A8020 0100A530 */  andi       $a1, $a1, 0x1
    /* 98824 800A8024 1000BFAF */  sw         $ra, 0x10($sp)
    /* 98828 800A8028 0300A010 */  beqz       $a1, .L800A8038
    /* 9882C 800A802C 500082AC */   sw        $v0, 0x50($a0)
    /* 98830 800A8030 6B8F020C */  jal        __builtin_delete
    /* 98834 800A8034 00000000 */   nop
  .L800A8038:
    /* 98838 800A8038 1000BF8F */  lw         $ra, 0x10($sp)
    /* 9883C 800A803C 00000000 */  nop
    /* 98840 800A8040 0800E003 */  jr         $ra
    /* 98844 800A8044 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___6tPMenu
