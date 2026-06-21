.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___7tScreen, 0x34

glabel ___7tScreen
    /* 16878 80026078 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1687C 8002607C 0180023C */  lui        $v0, %hi(_vt_7tScreen)
    /* 16880 80026080 18144224 */  addiu      $v0, $v0, %lo(_vt_7tScreen)
    /* 16884 80026084 0100A530 */  andi       $a1, $a1, 0x1
    /* 16888 80026088 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1688C 8002608C 0300A010 */  beqz       $a1, .L8002609C
    /* 16890 80026090 600082AC */   sw        $v0, 0x60($a0)
    /* 16894 80026094 6B8F020C */  jal        __builtin_delete
    /* 16898 80026098 00000000 */   nop
  .L8002609C:
    /* 1689C 8002609C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 168A0 800260A0 00000000 */  nop
    /* 168A4 800260A4 0800E003 */  jr         $ra
    /* 168A8 800260A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___7tScreen
