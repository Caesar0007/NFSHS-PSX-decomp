.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _chk_card_event_x, 0x3C

glabel _chk_card_event_x
    /* FA3C4 80109BC4 1580023C */  lui        $v0, %hi(D_80148A20)
    /* FA3C8 80109BC8 208A428C */  lw         $v0, %lo(D_80148A20)($v0)
    /* FA3CC 80109BCC 1580043C */  lui        $a0, %hi(D_80148A1C)
    /* FA3D0 80109BD0 1C8A848C */  lw         $a0, %lo(D_80148A1C)($a0)
    /* FA3D4 80109BD4 1580033C */  lui        $v1, %hi(D_80148A24)
    /* FA3D8 80109BD8 248A638C */  lw         $v1, %lo(D_80148A24)($v1)
    /* FA3DC 80109BDC 40100200 */  sll        $v0, $v0, 1
    /* FA3E0 80109BE0 21208200 */  addu       $a0, $a0, $v0
    /* FA3E4 80109BE4 80180300 */  sll        $v1, $v1, 2
    /* FA3E8 80109BE8 1580023C */  lui        $v0, %hi(D_80148A28)
    /* FA3EC 80109BEC 288A428C */  lw         $v0, %lo(D_80148A28)($v0)
    /* FA3F0 80109BF0 21208300 */  addu       $a0, $a0, $v1
    /* FA3F4 80109BF4 C0100200 */  sll        $v0, $v0, 3
    /* FA3F8 80109BF8 0800E003 */  jr         $ra
    /* FA3FC 80109BFC 21108200 */   addu      $v0, $a0, $v0
endlabel _chk_card_event_x
