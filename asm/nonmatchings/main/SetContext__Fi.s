.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetContext__Fi, 0x2C

glabel SetContext__Fi
    /* 6EC80 8007E480 80100400 */  sll        $v0, $a0, 2
    /* 6EC84 8007E484 21104400 */  addu       $v0, $v0, $a0
    /* 6EC88 8007E488 C0100200 */  sll        $v0, $v0, 3
    /* 6EC8C 8007E48C 23104400 */  subu       $v0, $v0, $a0
    /* 6EC90 8007E490 80100200 */  sll        $v0, $v0, 2
    /* 6EC94 8007E494 1180033C */  lui        $v1, %hi(D_8010EEB4)
    /* 6EC98 8007E498 B4EE6324 */  addiu      $v1, $v1, %lo(D_8010EEB4)
    /* 6EC9C 8007E49C 21104300 */  addu       $v0, $v0, $v1
    /* 6ECA0 8007E4A0 440282AF */  sw         $v0, %gp_rel(gCurrContext)($gp)
    /* 6ECA4 8007E4A4 0800E003 */  jr         $ra
    /* 6ECA8 8007E4A8 00000000 */   nop
endlabel SetContext__Fi
