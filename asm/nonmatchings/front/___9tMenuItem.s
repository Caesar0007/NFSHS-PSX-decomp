.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___9tMenuItem, 0x34

glabel ___9tMenuItem
    /* 14F64 80024764 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14F68 80024768 0180023C */  lui        $v0, %hi(_vt_9tMenuItem)
    /* 14F6C 8002476C 80124224 */  addiu      $v0, $v0, %lo(_vt_9tMenuItem)
    /* 14F70 80024770 0100A530 */  andi       $a1, $a1, 0x1
    /* 14F74 80024774 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14F78 80024778 0300A010 */  beqz       $a1, .L80024788
    /* 14F7C 8002477C 180082AC */   sw        $v0, 0x18($a0)
    /* 14F80 80024780 6B8F020C */  jal        __builtin_delete
    /* 14F84 80024784 00000000 */   nop
  .L80024788:
    /* 14F88 80024788 1000BF8F */  lw         $ra, 0x10($sp)
    /* 14F8C 8002478C 00000000 */  nop
    /* 14F90 80024790 0800E003 */  jr         $ra
    /* 14F94 80024794 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___9tMenuItem
