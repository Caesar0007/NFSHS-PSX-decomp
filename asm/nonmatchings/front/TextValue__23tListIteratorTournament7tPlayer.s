.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__23tListIteratorTournament7tPlayer, 0x58

glabel TextValue__23tListIteratorTournament7tPlayer
    /* 24628 80033E28 1180023C */  lui        $v0, %hi(D_80114722)
    /* 2462C 80033E2C 22474390 */  lbu        $v1, %lo(D_80114722)($v0)
    /* 24630 80033E30 1000858C */  lw         $a1, 0x10($a0)
    /* 24634 80033E34 40100300 */  sll        $v0, $v1, 1
    /* 24638 80033E38 21104300 */  addu       $v0, $v0, $v1
    /* 2463C 80033E3C 80100200 */  sll        $v0, $v0, 2
    /* 24640 80033E40 1800A58C */  lw         $a1, 0x18($a1)
    /* 24644 80033E44 0400838C */  lw         $v1, 0x4($a0)
    /* 24648 80033E48 2110A200 */  addu       $v0, $a1, $v0
    /* 2464C 80033E4C 02004290 */  lbu        $v0, 0x2($v0)
    /* 24650 80033E50 00006390 */  lbu        $v1, 0x0($v1)
    /* 24654 80033E54 00000000 */  nop
    /* 24658 80033E58 21186200 */  addu       $v1, $v1, $v0
    /* 2465C 80033E5C 80100300 */  sll        $v0, $v1, 2
    /* 24660 80033E60 21104300 */  addu       $v0, $v0, $v1
    /* 24664 80033E64 80100200 */  sll        $v0, $v0, 2
    /* 24668 80033E68 21104300 */  addu       $v0, $v0, $v1
    /* 2466C 80033E6C 80100200 */  sll        $v0, $v0, 2
    /* 24670 80033E70 2128A200 */  addu       $a1, $a1, $v0
    /* 24674 80033E74 2400A280 */  lb         $v0, 0x24($a1)
    /* 24678 80033E78 0800E003 */  jr         $ra
    /* 2467C 80033E7C 41034224 */   addiu     $v0, $v0, 0x341
endlabel TextValue__23tListIteratorTournament7tPlayer
