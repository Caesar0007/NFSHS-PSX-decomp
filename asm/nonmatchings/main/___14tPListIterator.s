.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14tPListIterator, 0x34

glabel ___14tPListIterator
    /* 9780C 800A700C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97810 800A7010 0580023C */  lui        $v0, %hi(_vt_14tPListIterator)
    /* 97814 800A7014 34634224 */  addiu      $v0, $v0, %lo(_vt_14tPListIterator)
    /* 97818 800A7018 0100A530 */  andi       $a1, $a1, 0x1
    /* 9781C 800A701C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97820 800A7020 0300A010 */  beqz       $a1, .L800A7030
    /* 97824 800A7024 080082AC */   sw        $v0, 0x8($a0)
    /* 97828 800A7028 6B8F020C */  jal        __builtin_delete
    /* 9782C 800A702C 00000000 */   nop
  .L800A7030:
    /* 97830 800A7030 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97834 800A7034 00000000 */  nop
    /* 97838 800A7038 0800E003 */  jr         $ra
    /* 9783C 800A703C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14tPListIterator
