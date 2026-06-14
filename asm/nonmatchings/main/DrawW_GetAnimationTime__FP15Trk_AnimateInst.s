.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_GetAnimationTime__FP15Trk_AnimateInst, 0x84

glabel DrawW_GetAnimationTime__FP15Trk_AnimateInst
    /* B7E44 800C7644 1180023C */  lui        $v0, %hi(D_80113228)
    /* B7E48 800C7648 03008390 */  lbu        $v1, 0x3($a0)
    /* B7E4C 800C764C 2832458C */  lw         $a1, %lo(D_80113228)($v0)
    /* B7E50 800C7650 05006010 */  beqz       $v1, .L800C7668
    /* B7E54 800C7654 03000224 */   addiu     $v0, $zero, 0x3
    /* B7E58 800C7658 0300A210 */  beq        $a1, $v0, .L800C7668
    /* B7E5C 800C765C 07000224 */   addiu     $v0, $zero, 0x7
    /* B7E60 800C7660 0500A214 */  bne        $a1, $v0, .L800C7678
    /* B7E64 800C7664 00000000 */   nop
  .L800C7668:
    /* B7E68 800C7668 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* B7E6C 800C766C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* B7E70 800C7670 0800E003 */  jr         $ra
    /* B7E74 800C7674 00000000 */   nop
  .L800C7678:
    /* B7E78 800C7678 08008284 */  lh         $v0, 0x8($a0)
    /* B7E7C 800C767C 0A008384 */  lh         $v1, 0xA($a0)
    /* B7E80 800C7680 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* B7E84 800C7684 18004300 */  mult       $v0, $v1
    /* B7E88 800C7688 1280033C */  lui        $v1, %hi(animation_timer)
    /* B7E8C 800C768C 03008290 */  lbu        $v0, 0x3($a0)
    /* B7E90 800C7690 18F76324 */  addiu      $v1, $v1, %lo(animation_timer)
    /* B7E94 800C7694 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* B7E98 800C7698 80100200 */  sll        $v0, $v0, 2
    /* B7E9C 800C769C 21104300 */  addu       $v0, $v0, $v1
    /* B7EA0 800C76A0 0000428C */  lw         $v0, 0x0($v0)
    /* B7EA4 800C76A4 00000000 */  nop
    /* B7EA8 800C76A8 21184000 */  addu       $v1, $v0, $zero
    /* B7EAC 800C76AC 12280000 */  mflo       $a1
    /* B7EB0 800C76B0 2A106500 */  slt        $v0, $v1, $a1
    /* B7EB4 800C76B4 02004014 */  bnez       $v0, .L800C76C0
    /* B7EB8 800C76B8 00000000 */   nop
    /* B7EBC 800C76BC 2118A000 */  addu       $v1, $a1, $zero
  .L800C76C0:
    /* B7EC0 800C76C0 0800E003 */  jr         $ra
    /* B7EC4 800C76C4 21106000 */   addu      $v0, $v1, $zero
endlabel DrawW_GetAnimationTime__FP15Trk_AnimateInst
