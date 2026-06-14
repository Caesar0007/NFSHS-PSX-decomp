.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AITrigger_Compare__FPCvT0, 0x18

glabel AITrigger_Compare__FPCvT0
    /* 63618 80072E18 0000828C */  lw         $v0, 0x0($a0)
    /* 6361C 80072E1C 0000A38C */  lw         $v1, 0x0($a1)
    /* 63620 80072E20 0400448C */  lw         $a0, 0x4($v0)
    /* 63624 80072E24 0400628C */  lw         $v0, 0x4($v1)
    /* 63628 80072E28 0800E003 */  jr         $ra
    /* 6362C 80072E2C 23108200 */   subu      $v0, $a0, $v0
endlabel AITrigger_Compare__FPCvT0
