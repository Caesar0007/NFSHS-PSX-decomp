.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching tournPointsCompare__FPcT0, 0x8C

glabel tournPointsCompare__FPcT0
    /* 23250 80032A50 1180033C */  lui        $v1, %hi(tournamentManager)
    /* 23254 80032A54 D84A6324 */  addiu      $v1, $v1, %lo(tournamentManager)
    /* 23258 80032A58 18016324 */  addiu      $v1, $v1, 0x118
    /* 2325C 80032A5C 0000A590 */  lbu        $a1, 0x0($a1)
    /* 23260 80032A60 00008490 */  lbu        $a0, 0x0($a0)
    /* 23264 80032A64 00110500 */  sll        $v0, $a1, 4
    /* 23268 80032A68 21384300 */  addu       $a3, $v0, $v1
    /* 2326C 80032A6C 00110400 */  sll        $v0, $a0, 4
    /* 23270 80032A70 21304300 */  addu       $a2, $v0, $v1
    /* 23274 80032A74 0C00E394 */  lhu        $v1, 0xC($a3)
    /* 23278 80032A78 0C00C294 */  lhu        $v0, 0xC($a2)
    /* 2327C 80032A7C 00000000 */  nop
    /* 23280 80032A80 23186200 */  subu       $v1, $v1, $v0
    /* 23284 80032A84 1180023C */  lui        $v0, %hi(Cars_gNewCarStatsList)
    /* 23288 80032A88 12006014 */  bnez       $v1, .L80032AD4
    /* 2328C 80032A8C 44FB4824 */   addiu     $t0, $v0, %lo(Cars_gNewCarStatsList)
    /* 23290 80032A90 0500E380 */  lb         $v1, 0x5($a3)
    /* 23294 80032A94 0500C280 */  lb         $v0, 0x5($a2)
    /* 23298 80032A98 00000000 */  nop
    /* 2329C 80032A9C 23186200 */  subu       $v1, $v1, $v0
    /* 232A0 80032AA0 0C006014 */  bnez       $v1, .L80032AD4
    /* 232A4 80032AA4 80100500 */   sll       $v0, $a1, 2
    /* 232A8 80032AA8 80180400 */  sll        $v1, $a0, 2
    /* 232AC 80032AAC 21186400 */  addu       $v1, $v1, $a0
    /* 232B0 80032AB0 40190300 */  sll        $v1, $v1, 5
    /* 232B4 80032AB4 21186800 */  addu       $v1, $v1, $t0
    /* 232B8 80032AB8 21104500 */  addu       $v0, $v0, $a1
    /* 232BC 80032ABC 40110200 */  sll        $v0, $v0, 5
    /* 232C0 80032AC0 21104800 */  addu       $v0, $v0, $t0
    /* 232C4 80032AC4 8400638C */  lw         $v1, 0x84($v1)
    /* 232C8 80032AC8 8400428C */  lw         $v0, 0x84($v0)
    /* 232CC 80032ACC 00000000 */  nop
    /* 232D0 80032AD0 23186200 */  subu       $v1, $v1, $v0
  .L80032AD4:
    /* 232D4 80032AD4 0800E003 */  jr         $ra
    /* 232D8 80032AD8 21106000 */   addu      $v0, $v1, $zero
endlabel tournPointsCompare__FPcT0
