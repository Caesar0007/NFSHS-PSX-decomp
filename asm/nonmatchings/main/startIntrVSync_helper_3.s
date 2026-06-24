.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching startIntrVSync_helper_3, 0x24

glabel startIntrVSync_helper_3
    /* F6E24 80106624 0600A010 */  beqz       $a1, .L80106640
    /* F6E28 80106628 FFFFA224 */   addiu     $v0, $a1, -0x1
    /* F6E2C 8010662C FFFF0324 */  addiu      $v1, $zero, -0x1
  .L80106630:
    /* F6E30 80106630 000080AC */  sw         $zero, 0x0($a0)
    /* F6E34 80106634 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F6E38 80106638 FDFF4314 */  bne        $v0, $v1, .L80106630
    /* F6E3C 8010663C 04008424 */   addiu     $a0, $a0, 0x4
  .L80106640:
    /* F6E40 80106640 0800E003 */  jr         $ra
    /* F6E44 80106644 00000000 */   nop
endlabel startIntrVSync_helper_3
    /* F6E48 80106648 00000000 */  nop
    /* F6E4C 8010664C 00000000 */  nop
    /* F6E50 80106650 00000000 */  nop
