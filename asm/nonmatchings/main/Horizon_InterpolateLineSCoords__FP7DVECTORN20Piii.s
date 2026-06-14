.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii, 0x140

glabel Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
    /* BFD74 800CF574 1400A28F */  lw         $v0, 0x14($sp)
    /* BFD78 800CF578 1000AB8F */  lw         $t3, 0x10($sp)
    /* BFD7C 800CF57C 27004010 */  beqz       $v0, .L800CF61C
    /* BFD80 800CF580 21488000 */   addu      $t1, $a0, $zero
    /* BFD84 800CF584 23006019 */  blez       $t3, .L800CF614
    /* BFD88 800CF588 21400000 */   addu      $t0, $zero, $zero
    /* BFD8C 800CF58C FFFF0A34 */  ori        $t2, $zero, 0xFFFF
  .L800CF590:
    /* BFD90 800CF590 0000C284 */  lh         $v0, 0x0($a2)
    /* BFD94 800CF594 0000A384 */  lh         $v1, 0x0($a1)
    /* BFD98 800CF598 0000E48C */  lw         $a0, 0x0($a3)
    /* BFD9C 800CF59C 23104300 */  subu       $v0, $v0, $v1
    /* BFDA0 800CF5A0 18008200 */  mult       $a0, $v0
    /* BFDA4 800CF5A4 0000A394 */  lhu        $v1, 0x0($a1)
    /* BFDA8 800CF5A8 12100000 */  mflo       $v0
    /* BFDAC 800CF5AC 02004104 */  bgez       $v0, .L800CF5B8
    /* BFDB0 800CF5B0 00000000 */   nop
    /* BFDB4 800CF5B4 21104A00 */  addu       $v0, $v0, $t2
  .L800CF5B8:
    /* BFDB8 800CF5B8 03140200 */  sra        $v0, $v0, 16
    /* BFDBC 800CF5BC 21106200 */  addu       $v0, $v1, $v0
    /* BFDC0 800CF5C0 000022A5 */  sh         $v0, 0x0($t1)
    /* BFDC4 800CF5C4 0200C284 */  lh         $v0, 0x2($a2)
    /* BFDC8 800CF5C8 0200A384 */  lh         $v1, 0x2($a1)
    /* BFDCC 800CF5CC 0000E48C */  lw         $a0, 0x0($a3)
    /* BFDD0 800CF5D0 23104300 */  subu       $v0, $v0, $v1
    /* BFDD4 800CF5D4 18008200 */  mult       $a0, $v0
    /* BFDD8 800CF5D8 0200A394 */  lhu        $v1, 0x2($a1)
    /* BFDDC 800CF5DC 12100000 */  mflo       $v0
    /* BFDE0 800CF5E0 02004104 */  bgez       $v0, .L800CF5EC
    /* BFDE4 800CF5E4 00000000 */   nop
    /* BFDE8 800CF5E8 21104A00 */  addu       $v0, $v0, $t2
  .L800CF5EC:
    /* BFDEC 800CF5EC 03140200 */  sra        $v0, $v0, 16
    /* BFDF0 800CF5F0 21106200 */  addu       $v0, $v1, $v0
    /* BFDF4 800CF5F4 020022A5 */  sh         $v0, 0x2($t1)
    /* BFDF8 800CF5F8 0400E724 */  addiu      $a3, $a3, 0x4
    /* BFDFC 800CF5FC 0400A524 */  addiu      $a1, $a1, 0x4
    /* BFE00 800CF600 0400C624 */  addiu      $a2, $a2, 0x4
    /* BFE04 800CF604 01000825 */  addiu      $t0, $t0, 0x1
    /* BFE08 800CF608 2A100B01 */  slt        $v0, $t0, $t3
    /* BFE0C 800CF60C E0FF4014 */  bnez       $v0, .L800CF590
    /* BFE10 800CF610 04002925 */   addiu     $t1, $t1, 0x4
  .L800CF614:
    /* BFE14 800CF614 0800E003 */  jr         $ra
    /* BFE18 800CF618 00000000 */   nop
  .L800CF61C:
    /* BFE1C 800CF61C 0000E48C */  lw         $a0, 0x0($a3)
    /* BFE20 800CF620 FCFF6019 */  blez       $t3, .L800CF614
    /* BFE24 800CF624 21400000 */   addu      $t0, $zero, $zero
    /* BFE28 800CF628 FFFF0734 */  ori        $a3, $zero, 0xFFFF
  .L800CF62C:
    /* BFE2C 800CF62C 0000C284 */  lh         $v0, 0x0($a2)
    /* BFE30 800CF630 0000A384 */  lh         $v1, 0x0($a1)
    /* BFE34 800CF634 00000000 */  nop
    /* BFE38 800CF638 23104300 */  subu       $v0, $v0, $v1
    /* BFE3C 800CF63C 18008200 */  mult       $a0, $v0
    /* BFE40 800CF640 0000A394 */  lhu        $v1, 0x0($a1)
    /* BFE44 800CF644 12100000 */  mflo       $v0
    /* BFE48 800CF648 02004104 */  bgez       $v0, .L800CF654
    /* BFE4C 800CF64C 00000000 */   nop
    /* BFE50 800CF650 21104700 */  addu       $v0, $v0, $a3
  .L800CF654:
    /* BFE54 800CF654 03140200 */  sra        $v0, $v0, 16
    /* BFE58 800CF658 21106200 */  addu       $v0, $v1, $v0
    /* BFE5C 800CF65C 000022A5 */  sh         $v0, 0x0($t1)
    /* BFE60 800CF660 0200C284 */  lh         $v0, 0x2($a2)
    /* BFE64 800CF664 0200A384 */  lh         $v1, 0x2($a1)
    /* BFE68 800CF668 00000000 */  nop
    /* BFE6C 800CF66C 23104300 */  subu       $v0, $v0, $v1
    /* BFE70 800CF670 18008200 */  mult       $a0, $v0
    /* BFE74 800CF674 0200A394 */  lhu        $v1, 0x2($a1)
    /* BFE78 800CF678 12100000 */  mflo       $v0
    /* BFE7C 800CF67C 02004104 */  bgez       $v0, .L800CF688
    /* BFE80 800CF680 00000000 */   nop
    /* BFE84 800CF684 21104700 */  addu       $v0, $v0, $a3
  .L800CF688:
    /* BFE88 800CF688 03140200 */  sra        $v0, $v0, 16
    /* BFE8C 800CF68C 21106200 */  addu       $v0, $v1, $v0
    /* BFE90 800CF690 020022A5 */  sh         $v0, 0x2($t1)
    /* BFE94 800CF694 0400A524 */  addiu      $a1, $a1, 0x4
    /* BFE98 800CF698 0400C624 */  addiu      $a2, $a2, 0x4
    /* BFE9C 800CF69C 01000825 */  addiu      $t0, $t0, 0x1
    /* BFEA0 800CF6A0 2A100B01 */  slt        $v0, $t0, $t3
    /* BFEA4 800CF6A4 E1FF4014 */  bnez       $v0, .L800CF62C
    /* BFEA8 800CF6A8 04002925 */   addiu     $t1, $t1, 0x4
    /* BFEAC 800CF6AC 0800E003 */  jr         $ra
    /* BFEB0 800CF6B0 00000000 */   nop
endlabel Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
