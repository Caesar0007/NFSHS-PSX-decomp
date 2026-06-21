.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Value__21tListIteratorCarColor7tPlayer, 0x60

glabel Value__21tListIteratorCarColor7tPlayer
    /* 8D48 80018548 1000828C */  lw         $v0, 0x10($a0)
    /* 8D4C 8001854C 00000000 */  nop
    /* 8D50 80018550 00004590 */  lbu        $a1, 0x0($v0)
    /* 8D54 80018554 1400828C */  lw         $v0, 0x14($a0)
    /* 8D58 80018558 1800838C */  lw         $v1, 0x18($a0)
    /* 8D5C 8001855C 21104500 */  addu       $v0, $v0, $a1
    /* 8D60 80018560 1800A300 */  mult       $a1, $v1
    /* 8D64 80018564 00004390 */  lbu        $v1, 0x0($v0)
    /* 8D68 80018568 1C00858C */  lw         $a1, 0x1C($a0)
    /* 8D6C 8001856C 40100300 */  sll        $v0, $v1, 1
    /* 8D70 80018570 21104300 */  addu       $v0, $v0, $v1
    /* 8D74 80018574 00190200 */  sll        $v1, $v0, 4
    /* 8D78 80018578 21104300 */  addu       $v0, $v0, $v1
    /* 8D7C 8001857C 0400A38C */  lw         $v1, 0x4($a1)
    /* 8D80 80018580 80100200 */  sll        $v0, $v0, 2
    /* 8D84 80018584 21186200 */  addu       $v1, $v1, $v0
    /* 8D88 80018588 00006280 */  lb         $v0, 0x0($v1)
    /* 8D8C 8001858C 0400838C */  lw         $v1, 0x4($a0)
    /* 8D90 80018590 12300000 */  mflo       $a2
    /* 8D94 80018594 2110C200 */  addu       $v0, $a2, $v0
    /* 8D98 80018598 21186200 */  addu       $v1, $v1, $v0
    /* 8D9C 8001859C 00006290 */  lbu        $v0, 0x0($v1)
    /* 8DA0 800185A0 0800E003 */  jr         $ra
    /* 8DA4 800185A4 00000000 */   nop
endlabel Value__21tListIteratorCarColor7tPlayer
