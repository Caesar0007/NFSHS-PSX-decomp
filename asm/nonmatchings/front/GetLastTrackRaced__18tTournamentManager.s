.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetLastTrackRaced__18tTournamentManager, 0x70

glabel GetLastTrackRaced__18tTournamentManager
    /* 23C8C 8003348C 0400838C */  lw         $v1, 0x4($a0)
    /* 23C90 80033490 1800858C */  lw         $a1, 0x18($a0)
    /* 23C94 80033494 40100300 */  sll        $v0, $v1, 1
    /* 23C98 80033498 21104300 */  addu       $v0, $v0, $v1
    /* 23C9C 8003349C 80100200 */  sll        $v0, $v0, 2
    /* 23CA0 800334A0 2110A200 */  addu       $v0, $a1, $v0
    /* 23CA4 800334A4 02004390 */  lbu        $v1, 0x2($v0)
    /* 23CA8 800334A8 0800828C */  lw         $v0, 0x8($a0)
    /* 23CAC 800334AC 00000000 */  nop
    /* 23CB0 800334B0 21186200 */  addu       $v1, $v1, $v0
    /* 23CB4 800334B4 80100300 */  sll        $v0, $v1, 2
    /* 23CB8 800334B8 21104300 */  addu       $v0, $v0, $v1
    /* 23CBC 800334BC 80100200 */  sll        $v0, $v0, 2
    /* 23CC0 800334C0 21104300 */  addu       $v0, $v0, $v1
    /* 23CC4 800334C4 80100200 */  sll        $v0, $v0, 2
    /* 23CC8 800334C8 21104500 */  addu       $v0, $v0, $a1
    /* 23CCC 800334CC 26004390 */  lbu        $v1, 0x26($v0)
    /* 23CD0 800334D0 0C00828C */  lw         $v0, 0xC($a0)
    /* 23CD4 800334D4 00000000 */  nop
    /* 23CD8 800334D8 21186200 */  addu       $v1, $v1, $v0
    /* 23CDC 800334DC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 23CE0 800334E0 80100300 */  sll        $v0, $v1, 2
    /* 23CE4 800334E4 21104300 */  addu       $v0, $v0, $v1
    /* 23CE8 800334E8 C0100200 */  sll        $v0, $v0, 3
    /* 23CEC 800334EC 2128A200 */  addu       $a1, $a1, $v0
    /* 23CF0 800334F0 2415A280 */  lb         $v0, 0x1524($a1)
    /* 23CF4 800334F4 0800E003 */  jr         $ra
    /* 23CF8 800334F8 00000000 */   nop
endlabel GetLastTrackRaced__18tTournamentManager
