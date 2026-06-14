.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Save__11SaveSurfaceP14Trk_NewSimQuad, 0x64

glabel Save__11SaveSurfaceP14Trk_NewSimQuad
    /* AB70C 800BAF0C 21308000 */  addu       $a2, $a0, $zero
    /* AB710 800BAF10 0000C784 */  lh         $a3, 0x0($a2)
    /* AB714 800BAF14 0200C284 */  lh         $v0, 0x2($a2)
    /* AB718 800BAF18 00000000 */  nop
    /* AB71C 800BAF1C 2A104700 */  slt        $v0, $v0, $a3
    /* AB720 800BAF20 11004014 */  bnez       $v0, .L800BAF68
    /* AB724 800BAF24 00000000 */   nop
    /* AB728 800BAF28 0F00A010 */  beqz       $a1, .L800BAF68
    /* AB72C 800BAF2C C0100700 */   sll       $v0, $a3, 3
    /* AB730 800BAF30 0400C38C */  lw         $v1, 0x4($a2)
    /* AB734 800BAF34 00000000 */  nop
    /* AB738 800BAF38 21104300 */  addu       $v0, $v0, $v1
    /* AB73C 800BAF3C 000045AC */  sw         $a1, 0x0($v0)
    /* AB740 800BAF40 0000C284 */  lh         $v0, 0x0($a2)
    /* AB744 800BAF44 0400C38C */  lw         $v1, 0x4($a2)
    /* AB748 800BAF48 0000A490 */  lbu        $a0, 0x0($a1)
    /* AB74C 800BAF4C C0100200 */  sll        $v0, $v0, 3
    /* AB750 800BAF50 21104300 */  addu       $v0, $v0, $v1
    /* AB754 800BAF54 040044A0 */  sb         $a0, 0x4($v0)
    /* AB758 800BAF58 0000C294 */  lhu        $v0, 0x0($a2)
    /* AB75C 800BAF5C 00000000 */  nop
    /* AB760 800BAF60 01004224 */  addiu      $v0, $v0, 0x1
    /* AB764 800BAF64 0000C2A4 */  sh         $v0, 0x0($a2)
  .L800BAF68:
    /* AB768 800BAF68 0800E003 */  jr         $ra
    /* AB76C 800BAF6C 00000000 */   nop
endlabel Save__11SaveSurfaceP14Trk_NewSimQuad
