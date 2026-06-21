.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TournPointTotal__18tTournamentManagerPs, 0x1C

glabel TournPointTotal__18tTournamentManagerPs
    /* 2428C 80033A8C 0000A284 */  lh         $v0, 0x0($a1)
    /* 24290 80033A90 00000000 */  nop
    /* 24294 80033A94 00110200 */  sll        $v0, $v0, 4
    /* 24298 80033A98 21208200 */  addu       $a0, $a0, $v0
    /* 2429C 80033A9C 24018294 */  lhu        $v0, 0x124($a0)
    /* 242A0 80033AA0 0800E003 */  jr         $ra
    /* 242A4 80033AA4 00000000 */   nop
endlabel TournPointTotal__18tTournamentManagerPs
