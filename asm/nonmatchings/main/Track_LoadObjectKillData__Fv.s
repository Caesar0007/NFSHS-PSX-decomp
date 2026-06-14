.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_LoadObjectKillData__Fv, 0x158

glabel Track_LoadObjectKillData__Fv
    /* AB5B4 800BADB4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* AB5B8 800BADB8 3400BFAF */  sw         $ra, 0x34($sp)
    /* AB5BC 800BADBC 3000B6AF */  sw         $s6, 0x30($sp)
    /* AB5C0 800BADC0 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* AB5C4 800BADC4 2800B4AF */  sw         $s4, 0x28($sp)
    /* AB5C8 800BADC8 2400B3AF */  sw         $s3, 0x24($sp)
    /* AB5CC 800BADCC 2000B2AF */  sw         $s2, 0x20($sp)
    /* AB5D0 800BADD0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* AB5D4 800BADD4 54EB020C */  jal        KillFile_OpenRead__Fv
    /* AB5D8 800BADD8 1800B0AF */   sw        $s0, 0x18($sp)
    /* AB5DC 800BADDC 21A84000 */  addu       $s5, $v0, $zero
    /* AB5E0 800BADE0 4000A012 */  beqz       $s5, .L800BAEE4
    /* AB5E4 800BADE4 21A00000 */   addu      $s4, $zero, $zero
    /* AB5E8 800BADE8 10001624 */  addiu      $s6, $zero, 0x10
  .L800BADEC:
    /* AB5EC 800BADEC 0000A28E */  lw         $v0, 0x0($s5)
    /* AB5F0 800BADF0 00000000 */  nop
    /* AB5F4 800BADF4 2A108202 */  slt        $v0, $s4, $v0
    /* AB5F8 800BADF8 38004010 */  beqz       $v0, .L800BAEDC
    /* AB5FC 800BADFC 2120A002 */   addu      $a0, $s5, $zero
    /* AB600 800BAE00 21288002 */  addu       $a1, $s4, $zero
    /* AB604 800BAE04 1000A627 */  addiu      $a2, $sp, 0x10
    /* AB608 800BAE08 65EB020C */  jal        KillFile_ReadEntry__FPciRiT2
    /* AB60C 800BAE0C 1400A727 */   addiu     $a3, $sp, 0x14
    /* AB610 800BAE10 1000A28F */  lw         $v0, 0x10($sp)
    /* AB614 800BAE14 00000000 */  nop
    /* AB618 800BAE18 C0180200 */  sll        $v1, $v0, 3
    /* AB61C 800BAE1C 23186200 */  subu       $v1, $v1, $v0
    /* AB620 800BAE20 6C0F828F */  lw         $v0, %gp_rel(Track_chunkList)($gp)
    /* AB624 800BAE24 00190300 */  sll        $v1, $v1, 4
    /* AB628 800BAE28 21304300 */  addu       $a2, $v0, $v1
    /* AB62C 800BAE2C 4000C58C */  lw         $a1, 0x40($a2)
    /* AB630 800BAE30 00000000 */  nop
    /* AB634 800BAE34 2700A010 */  beqz       $a1, .L800BAED4
    /* AB638 800BAE38 00000000 */   nop
    /* AB63C 800BAE3C 0000A28C */  lw         $v0, 0x0($a1)
    /* AB640 800BAE40 1400A48F */  lw         $a0, 0x14($sp)
    /* AB644 800BAE44 00000000 */  nop
    /* AB648 800BAE48 2A108200 */  slt        $v0, $a0, $v0
    /* AB64C 800BAE4C 21004010 */  beqz       $v0, .L800BAED4
    /* AB650 800BAE50 0400B224 */   addiu     $s2, $a1, 0x4
    /* AB654 800BAE54 07008018 */  blez       $a0, .L800BAE74
    /* AB658 800BAE58 21180000 */   addu      $v1, $zero, $zero
  .L800BAE5C:
    /* AB65C 800BAE5C 00004286 */  lh         $v0, 0x0($s2)
    /* AB660 800BAE60 01006324 */  addiu      $v1, $v1, 0x1
    /* AB664 800BAE64 21904202 */  addu       $s2, $s2, $v0
    /* AB668 800BAE68 2A106400 */  slt        $v0, $v1, $a0
    /* AB66C 800BAE6C FBFF4014 */  bnez       $v0, .L800BAE5C
    /* AB670 800BAE70 00000000 */   nop
  .L800BAE74:
    /* AB674 800BAE74 5000C28C */  lw         $v0, 0x50($a2)
    /* AB678 800BAE78 00000000 */  nop
    /* AB67C 800BAE7C 11004010 */  beqz       $v0, .L800BAEC4
    /* AB680 800BAE80 21880000 */   addu      $s1, $zero, $zero
    /* AB684 800BAE84 0000538C */  lw         $s3, 0x0($v0)
    /* AB688 800BAE88 00000000 */  nop
    /* AB68C 800BAE8C 0D00601A */  blez       $s3, .L800BAEC4
    /* AB690 800BAE90 04004424 */   addiu     $a0, $v0, 0x4
    /* AB694 800BAE94 21808000 */  addu       $s0, $a0, $zero
  .L800BAE98:
    /* AB698 800BAE98 21200002 */  addu       $a0, $s0, $zero
    /* AB69C 800BAE9C F974020C */  jal        Math_DistXZ__FP8coorddefT0
    /* AB6A0 800BAEA0 08004526 */   addiu     $a1, $s2, 0x8
    /* AB6A4 800BAEA4 99194228 */  slti       $v0, $v0, 0x1999
    /* AB6A8 800BAEA8 02004010 */  beqz       $v0, .L800BAEB4
    /* AB6AC 800BAEAC 00000000 */   nop
    /* AB6B0 800BAEB0 130016A2 */  sb         $s6, 0x13($s0)
  .L800BAEB4:
    /* AB6B4 800BAEB4 01003126 */  addiu      $s1, $s1, 0x1
    /* AB6B8 800BAEB8 2A103302 */  slt        $v0, $s1, $s3
    /* AB6BC 800BAEBC F6FF4014 */  bnez       $v0, .L800BAE98
    /* AB6C0 800BAEC0 14001026 */   addiu     $s0, $s0, 0x14
  .L800BAEC4:
    /* AB6C4 800BAEC4 02004292 */  lbu        $v0, 0x2($s2)
    /* AB6C8 800BAEC8 00000000 */  nop
    /* AB6CC 800BAECC 80004234 */  ori        $v0, $v0, 0x80
    /* AB6D0 800BAED0 020042A2 */  sb         $v0, 0x2($s2)
  .L800BAED4:
    /* AB6D4 800BAED4 7BEB0208 */  j          .L800BADEC
    /* AB6D8 800BAED8 01009426 */   addiu     $s4, $s4, 0x1
  .L800BAEDC:
    /* AB6DC 800BAEDC 5095030C */  jal        purgememadr
    /* AB6E0 800BAEE0 2120A002 */   addu      $a0, $s5, $zero
  .L800BAEE4:
    /* AB6E4 800BAEE4 3400BF8F */  lw         $ra, 0x34($sp)
    /* AB6E8 800BAEE8 3000B68F */  lw         $s6, 0x30($sp)
    /* AB6EC 800BAEEC 2C00B58F */  lw         $s5, 0x2C($sp)
    /* AB6F0 800BAEF0 2800B48F */  lw         $s4, 0x28($sp)
    /* AB6F4 800BAEF4 2400B38F */  lw         $s3, 0x24($sp)
    /* AB6F8 800BAEF8 2000B28F */  lw         $s2, 0x20($sp)
    /* AB6FC 800BAEFC 1C00B18F */  lw         $s1, 0x1C($sp)
    /* AB700 800BAF00 1800B08F */  lw         $s0, 0x18($sp)
    /* AB704 800BAF04 0800E003 */  jr         $ra
    /* AB708 800BAF08 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Track_LoadObjectKillData__Fv
