.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memcmp, 0x4C

glabel memcmp
    /* F3F34 80103734 D40D0408 */  j          .L80103750
    /* F3F38 80103738 00000000 */   nop
  .L8010373C:
    /* F3F3C 8010373C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* F3F40 80103740 0300C01C */  bgtz       $a2, .L80103750
    /* F3F44 80103744 0100A524 */   addiu     $a1, $a1, 0x1
    /* F3F48 80103748 DE0D0408 */  j          .L80103778
    /* F3F4C 8010374C 21100000 */   addu      $v0, $zero, $zero
  .L80103750:
    /* F3F50 80103750 00008390 */  lbu        $v1, 0x0($a0)
    /* F3F54 80103754 0000A290 */  lbu        $v0, 0x0($a1)
    /* F3F58 80103758 00000000 */  nop
    /* F3F5C 8010375C F7FF6210 */  beq        $v1, $v0, .L8010373C
    /* F3F60 80103760 01008424 */   addiu     $a0, $a0, 0x1
    /* F3F64 80103764 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* F3F68 80103768 00008390 */  lbu        $v1, 0x0($a0)
    /* F3F6C 8010376C 0000A290 */  lbu        $v0, 0x0($a1)
    /* F3F70 80103770 00000000 */  nop
    /* F3F74 80103774 23106200 */  subu       $v0, $v1, $v0
  .L80103778:
    /* F3F78 80103778 0800E003 */  jr         $ra
    /* F3F7C 8010377C 00000000 */   nop
endlabel memcmp
    /* F3F80 80103780 00000000 */  nop
