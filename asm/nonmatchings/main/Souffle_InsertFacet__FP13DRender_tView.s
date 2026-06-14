.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_InsertFacet__FP13DRender_tView, 0xEC

glabel Souffle_InsertFacet__FP13DRender_tView
    /* A85E8 800B7DE8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* A85EC 800B7DEC 2400B5AF */  sw         $s5, 0x24($sp)
    /* A85F0 800B7DF0 21A88000 */  addu       $s5, $a0, $zero
    /* A85F4 800B7DF4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A85F8 800B7DF8 21980000 */  addu       $s3, $zero, $zero
    /* A85FC 800B7DFC 2000B4AF */  sw         $s4, 0x20($sp)
    /* A8600 800B7E00 0800B426 */  addiu      $s4, $s5, 0x8
    /* A8604 800B7E04 1800B2AF */  sw         $s2, 0x18($sp)
    /* A8608 800B7E08 21906002 */  addu       $s2, $s3, $zero
    /* A860C 800B7E0C 2800BFAF */  sw         $ra, 0x28($sp)
    /* A8610 800B7E10 1400B1AF */  sw         $s1, 0x14($sp)
    /* A8614 800B7E14 1000B0AF */  sw         $s0, 0x10($sp)
  .L800B7E18:
    /* A8618 800B7E18 000F828F */  lw         $v0, %gp_rel(gCISouffle)($gp)
    /* A861C 800B7E1C 00000000 */  nop
    /* A8620 800B7E20 2A106202 */  slt        $v0, $s3, $v0
    /* A8624 800B7E24 22004010 */  beqz       $v0, .L800B7EB0
    /* A8628 800B7E28 21288002 */   addu      $a1, $s4, $zero
    /* A862C 800B7E2C FC0E828F */  lw         $v0, %gp_rel(gISouffle)($gp)
    /* A8630 800B7E30 3200063C */  lui        $a2, (0x320000 >> 16)
    /* A8634 800B7E34 21805200 */  addu       $s0, $v0, $s2
    /* A8638 800B7E38 0C001126 */  addiu      $s1, $s0, 0xC
    /* A863C 800B7E3C 62DF020C */  jal        Souffle_CircleClip__FP8coorddefT0i
    /* A8640 800B7E40 21202002 */   addu      $a0, $s1, $zero
    /* A8644 800B7E44 17004010 */  beqz       $v0, .L800B7EA4
    /* A8648 800B7E48 0A000224 */   addiu     $v0, $zero, 0xA
    /* A864C 800B7E4C 00000392 */  lbu        $v1, 0x0($s0)
    /* A8650 800B7E50 00000000 */  nop
    /* A8654 800B7E54 10006210 */  beq        $v1, $v0, .L800B7E98
    /* A8658 800B7E58 21202002 */   addu      $a0, $s1, $zero
    /* A865C 800B7E5C 30000526 */  addiu      $a1, $s0, 0x30
    /* A8660 800B7E60 1474030C */  jal        Sfx_Transform__FP8coorddefP7SVECTORT0
    /* A8664 800B7E64 21308002 */   addu      $a2, $s4, $zero
    /* A8668 800B7E68 30000286 */  lh         $v0, 0x30($s0)
    /* A866C 800B7E6C 34000386 */  lh         $v1, 0x34($s0)
    /* A8670 800B7E70 02004104 */  bgez       $v0, .L800B7E7C
    /* A8674 800B7E74 00000000 */   nop
    /* A8678 800B7E78 23100200 */  negu       $v0, $v0
  .L800B7E7C:
    /* A867C 800B7E7C 2A186200 */  slt        $v1, $v1, $v0
    /* A8680 800B7E80 08006014 */  bnez       $v1, .L800B7EA4
    /* A8684 800B7E84 00000000 */   nop
    /* A8688 800B7E88 00000292 */  lbu        $v0, 0x0($s0)
    /* A868C 800B7E8C 00000000 */  nop
    /* A8690 800B7E90 04004010 */  beqz       $v0, .L800B7EA4
    /* A8694 800B7E94 00000000 */   nop
  .L800B7E98:
    /* A8698 800B7E98 2120A002 */  addu       $a0, $s5, $zero
    /* A869C 800B7E9C E475030C */  jal        Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
    /* A86A0 800B7EA0 21280002 */   addu      $a1, $s0, $zero
  .L800B7EA4:
    /* A86A4 800B7EA4 44005226 */  addiu      $s2, $s2, 0x44
    /* A86A8 800B7EA8 86DF0208 */  j          .L800B7E18
    /* A86AC 800B7EAC 01007326 */   addiu     $s3, $s3, 0x1
  .L800B7EB0:
    /* A86B0 800B7EB0 2800BF8F */  lw         $ra, 0x28($sp)
    /* A86B4 800B7EB4 2400B58F */  lw         $s5, 0x24($sp)
    /* A86B8 800B7EB8 2000B48F */  lw         $s4, 0x20($sp)
    /* A86BC 800B7EBC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A86C0 800B7EC0 1800B28F */  lw         $s2, 0x18($sp)
    /* A86C4 800B7EC4 1400B18F */  lw         $s1, 0x14($sp)
    /* A86C8 800B7EC8 1000B08F */  lw         $s0, 0x10($sp)
    /* A86CC 800B7ECC 0800E003 */  jr         $ra
    /* A86D0 800B7ED0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Souffle_InsertFacet__FP13DRender_tView
