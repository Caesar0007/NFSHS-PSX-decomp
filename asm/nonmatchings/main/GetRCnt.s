.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetRCnt, 0x38

glabel GetRCnt
    /* DA70C 800E9F0C FFFF8330 */  andi       $v1, $a0, 0xFFFF
    /* DA710 800E9F10 03006228 */  slti       $v0, $v1, 0x3
    /* DA714 800E9F14 08004010 */  beqz       $v0, .L800E9F38
    /* DA718 800E9F18 00190300 */   sll       $v1, $v1, 4
    /* DA71C 800E9F1C 1280023C */  lui        $v0, %hi(D_801234B8)
    /* DA720 800E9F20 B834428C */  lw         $v0, %lo(D_801234B8)($v0)
    /* DA724 800E9F24 00000000 */  nop
    /* DA728 800E9F28 21186200 */  addu       $v1, $v1, $v0
    /* DA72C 800E9F2C 00006294 */  lhu        $v0, 0x0($v1)
    /* DA730 800E9F30 CFA70308 */  j          .L800E9F3C
    /* DA734 800E9F34 00000000 */   nop
  .L800E9F38:
    /* DA738 800E9F38 21100000 */  addu       $v0, $zero, $zero
  .L800E9F3C:
    /* DA73C 800E9F3C 0800E003 */  jr         $ra
    /* DA740 800E9F40 00000000 */   nop
endlabel GetRCnt
