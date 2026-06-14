.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_AddBank__FPciT0i, 0x128

glabel AudioCmn_AddBank__FPciT0i
    /* AC564 800BBD64 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* AC568 800BBD68 1800B0AF */  sw         $s0, 0x18($sp)
    /* AC56C 800BBD6C 21808000 */  addu       $s0, $a0, $zero
    /* AC570 800BBD70 2000B2AF */  sw         $s2, 0x20($sp)
    /* AC574 800BBD74 2190A000 */  addu       $s2, $a1, $zero
    /* AC578 800BBD78 2400B3AF */  sw         $s3, 0x24($sp)
    /* AC57C 800BBD7C 2198C000 */  addu       $s3, $a2, $zero
    /* AC580 800BBD80 2800B4AF */  sw         $s4, 0x28($sp)
    /* AC584 800BBD84 21A0E000 */  addu       $s4, $a3, $zero
    /* AC588 800BBD88 21180002 */  addu       $v1, $s0, $zero
    /* AC58C 800BBD8C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AC590 800BBD90 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* AC594 800BBD94 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* AC598 800BBD98 1000A2AF */  sw         $v0, 0x10($sp)
    /* AC59C 800BBD9C 00000292 */  lbu        $v0, 0x0($s0)
    /* AC5A0 800BBDA0 00000000 */  nop
    /* AC5A4 800BBDA4 0C004010 */  beqz       $v0, .L800BBDD8
    /* AC5A8 800BBDA8 21880000 */   addu      $s1, $zero, $zero
    /* AC5AC 800BBDAC 5C000424 */  addiu      $a0, $zero, 0x5C
    /* AC5B0 800BBDB0 00006290 */  lbu        $v0, 0x0($v1)
  .L800BBDB4:
    /* AC5B4 800BBDB4 00000000 */  nop
    /* AC5B8 800BBDB8 02004414 */  bne        $v0, $a0, .L800BBDC4
    /* AC5BC 800BBDBC 00000000 */   nop
    /* AC5C0 800BBDC0 01007024 */  addiu      $s0, $v1, 0x1
  .L800BBDC4:
    /* AC5C4 800BBDC4 01006324 */  addiu      $v1, $v1, 0x1
    /* AC5C8 800BBDC8 00006290 */  lbu        $v0, 0x0($v1)
    /* AC5CC 800BBDCC 00000000 */  nop
    /* AC5D0 800BBDD0 F8FF4014 */  bnez       $v0, .L800BBDB4
    /* AC5D4 800BBDD4 00000000 */   nop
  .L800BBDD8:
    /* AC5D8 800BBDD8 1000A427 */  addiu      $a0, $sp, 0x10
    /* AC5DC 800BBDDC 7B9F030C */  jal        SNDbankadd
    /* AC5E0 800BBDE0 21286002 */   addu      $a1, $s3, $zero
    /* AC5E4 800BBDE4 21204000 */  addu       $a0, $v0, $zero
    /* AC5E8 800BBDE8 07000224 */  addiu      $v0, $zero, 0x7
    /* AC5EC 800BBDEC 11008214 */  bne        $a0, $v0, .L800BBE34
    /* AC5F0 800BBDF0 00000000 */   nop
    /* AC5F4 800BBDF4 1000A48F */  lw         $a0, 0x10($sp)
    /* AC5F8 800BBDF8 D99E030C */  jal        SNDbankheadersize
    /* AC5FC 800BBDFC 00000000 */   nop
    /* AC600 800BBE00 21200002 */  addu       $a0, $s0, $zero
    /* AC604 800BBE04 21284000 */  addu       $a1, $v0, $zero
    /* AC608 800BBE08 CF94030C */  jal        reservememadr
    /* AC60C 800BBE0C 21300000 */   addu      $a2, $zero, $zero
    /* AC610 800BBE10 21884000 */  addu       $s1, $v0, $zero
    /* AC614 800BBE14 1000A58F */  lw         $a1, 0x10($sp)
    /* AC618 800BBE18 EA9E030C */  jal        SNDbankheadercopy
    /* AC61C 800BBE1C 21202002 */   addu      $a0, $s1, $zero
    /* AC620 800BBE20 1000A48F */  lw         $a0, 0x10($sp)
    /* AC624 800BBE24 D99E030C */  jal        SNDbankheadersize
    /* AC628 800BBE28 00000000 */   nop
    /* AC62C 800BBE2C 8FEF0208 */  j          .L800BBE3C
    /* AC630 800BBE30 23904202 */   subu      $s2, $s2, $v0
  .L800BBE34:
    /* AC634 800BBE34 CCD1010C */  jal        AudioClc_SndError__Fi
    /* AC638 800BBE38 00000000 */   nop
  .L800BBE3C:
    /* AC63C 800BBE3C 5095030C */  jal        purgememadr
    /* AC640 800BBE40 21206002 */   addu      $a0, $s3, $zero
    /* AC644 800BBE44 21104002 */  addu       $v0, $s2, $zero
    /* AC648 800BBE48 1180033C */  lui        $v1, %hi(gSndBnk)
    /* AC64C 800BBE4C A8E86324 */  addiu      $v1, $v1, %lo(gSndBnk)
    /* AC650 800BBE50 40201400 */  sll        $a0, $s4, 1
    /* AC654 800BBE54 21209400 */  addu       $a0, $a0, $s4
    /* AC658 800BBE58 80200400 */  sll        $a0, $a0, 2
    /* AC65C 800BBE5C 1000A58F */  lw         $a1, 0x10($sp)
    /* AC660 800BBE60 21208300 */  addu       $a0, $a0, $v1
    /* AC664 800BBE64 080091AC */  sw         $s1, 0x8($a0)
    /* AC668 800BBE68 000085AC */  sw         $a1, 0x0($a0)
    /* AC66C 800BBE6C 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* AC670 800BBE70 2800B48F */  lw         $s4, 0x28($sp)
    /* AC674 800BBE74 2400B38F */  lw         $s3, 0x24($sp)
    /* AC678 800BBE78 2000B28F */  lw         $s2, 0x20($sp)
    /* AC67C 800BBE7C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* AC680 800BBE80 1800B08F */  lw         $s0, 0x18($sp)
    /* AC684 800BBE84 0800E003 */  jr         $ra
    /* AC688 800BBE88 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AudioCmn_AddBank__FPciT0i
