.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__9tMenuItemiib, 0x3C

glabel Draw__9tMenuItemiib
    /* 15028 80024828 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1502C 8002482C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 15030 80024830 1800838C */  lw         $v1, 0x18($a0)
    /* 15034 80024834 00000000 */  nop
    /* 15038 80024838 20006284 */  lh         $v0, 0x20($v1)
    /* 1503C 8002483C 00000000 */  nop
    /* 15040 80024840 21208200 */  addu       $a0, $a0, $v0
    /* 15044 80024844 2400628C */  lw         $v0, 0x24($v1)
    /* 15048 80024848 00000000 */  nop
    /* 1504C 8002484C 09F84000 */  jalr       $v0
    /* 15050 80024850 2128E000 */   addu      $a1, $a3, $zero
    /* 15054 80024854 1000BF8F */  lw         $ra, 0x10($sp)
    /* 15058 80024858 00000000 */  nop
    /* 1505C 8002485C 0800E003 */  jr         $ra
    /* 15060 80024860 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw__9tMenuItemiib
