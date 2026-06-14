.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetStatus__10AnimScript, 0x14

glabel GetStatus__10AnimScript
    /* 64F1C 8007471C 1000828C */  lw         $v0, 0x10($a0)
    /* 64F20 80074720 00000000 */  nop
    /* 64F24 80074724 0000428C */  lw         $v0, 0x0($v0)
    /* 64F28 80074728 0800E003 */  jr         $ra
    /* 64F2C 8007472C 2B100200 */   sltu      $v0, $zero, $v0
endlabel GetStatus__10AnimScript
