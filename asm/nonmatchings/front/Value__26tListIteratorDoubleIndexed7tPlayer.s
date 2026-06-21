.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__26tListIteratorDoubleIndexed7tPlayer, 0x3C

glabel Value__26tListIteratorDoubleIndexed7tPlayer
    /* 1497C 8002417C 1000828C */  lw         $v0, 0x10($a0)
    /* 14980 80024180 00000000 */  nop
    /* 14984 80024184 00004390 */  lbu        $v1, 0x0($v0)
    /* 14988 80024188 1400828C */  lw         $v0, 0x14($a0)
    /* 1498C 8002418C 00000000 */  nop
    /* 14990 80024190 18006200 */  mult       $v1, $v0
    /* 14994 80024194 1800828C */  lw         $v0, 0x18($a0)
    /* 14998 80024198 0400838C */  lw         $v1, 0x4($a0)
    /* 1499C 8002419C 00004290 */  lbu        $v0, 0x0($v0)
    /* 149A0 800241A0 12280000 */  mflo       $a1
    /* 149A4 800241A4 2110A200 */  addu       $v0, $a1, $v0
    /* 149A8 800241A8 21186200 */  addu       $v1, $v1, $v0
    /* 149AC 800241AC 00006290 */  lbu        $v0, 0x0($v1)
    /* 149B0 800241B0 0800E003 */  jr         $ra
    /* 149B4 800241B4 00000000 */   nop
endlabel Value__26tListIteratorDoubleIndexed7tPlayer
