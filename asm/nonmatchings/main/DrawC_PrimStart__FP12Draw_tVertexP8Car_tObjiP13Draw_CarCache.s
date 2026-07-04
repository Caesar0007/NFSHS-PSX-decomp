.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache, 0xF40

glabel DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
    /* AF544 800BED44 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* AF548 800BED48 2800B2AF */  sw         $s2, 0x28($sp)
    /* AF54C 800BED4C 2190A000 */  addu       $s2, $a1, $zero
    /* AF550 800BED50 4000BEAF */  sw         $fp, 0x40($sp)
    /* AF554 800BED54 21F0C000 */  addu       $fp, $a2, $zero
    /* AF558 800BED58 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* AF55C 800BED5C 2198E000 */  addu       $s3, $a3, $zero
    /* AF560 800BED60 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* AF564 800BED64 21B80000 */  addu       $s7, $zero, $zero
    /* AF568 800BED68 1280083C */  lui        $t0, %hi(DrawC_gScreenMat)
    /* AF56C 800BED6C 4400BFAF */  sw         $ra, 0x44($sp)
    /* AF570 800BED70 3800B6AF */  sw         $s6, 0x38($sp)
    /* AF574 800BED74 3400B5AF */  sw         $s5, 0x34($sp)
    /* AF578 800BED78 3000B4AF */  sw         $s4, 0x30($sp)
    /* AF57C 800BED7C 2400B1AF */  sw         $s1, 0x24($sp)
    /* AF580 800BED80 2000B0AF */  sw         $s0, 0x20($sp)
    /* AF584 800BED84 BC085186 */  lh         $s1, 0x8BC($s2)
    /* AF588 800BED88 C8F40825 */  addiu      $t0, $t0, %lo(DrawC_gScreenMat)
    /* AF58C 800BED8C EAFF2226 */  addiu      $v0, $s1, -0x16
    /* AF590 800BED90 0600542C */  sltiu      $s4, $v0, 0x6
    /* AF594 800BED94 00000C8D */  lw         $t4, 0x0($t0)
    /* AF598 800BED98 04000D8D */  lw         $t5, 0x4($t0)
    /* AF59C 800BED9C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* AF5A0 800BEDA0 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* AF5A4 800BEDA4 08000C8D */  lw         $t4, 0x8($t0)
    /* AF5A8 800BEDA8 0C000D8D */  lw         $t5, 0xC($t0)
    /* AF5AC 800BEDAC 10000E8D */  lw         $t6, 0x10($t0)
    /* AF5B0 800BEDB0 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* AF5B4 800BEDB4 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* AF5B8 800BEDB8 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* AF5BC 800BEDBC 1280093C */  lui        $t1, %hi(DrawC_gScreenMat)
    /* AF5C0 800BEDC0 C8F42925 */  addiu      $t1, $t1, %lo(DrawC_gScreenMat)
    /* AF5C4 800BEDC4 14002C8D */  lw         $t4, 0x14($t1)
    /* AF5C8 800BEDC8 18002D8D */  lw         $t5, 0x18($t1)
    /* AF5CC 800BEDCC 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* AF5D0 800BEDD0 1C002E8D */  lw         $t6, 0x1C($t1)
    /* AF5D4 800BEDD4 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* AF5D8 800BEDD8 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* AF5DC 800BEDDC 000080C8 */  lwc2       $0, 0x0($a0)
    /* AF5E0 800BEDE0 040081C8 */  lwc2       $1, 0x4($a0)
    /* AF5E4 800BEDE4 00000000 */  nop
    /* AF5E8 800BEDE8 00000000 */  nop
    /* AF5EC 800BEDEC 0100184A */  .word 0x4A180001  /* rtps */
    /* AF5F0 800BEDF0 40006226 */  addiu      $v0, $s3, 0x40
    /* AF5F4 800BEDF4 00980C48 */  mfc2       $t4, $19 /* handwritten instruction */
    /* AF5F8 800BEDF8 00000000 */  nop
    /* AF5FC 800BEDFC 83600C00 */  sra        $t4, $t4, 2
    /* AF600 800BEE00 00004CAC */  sw         $t4, 0x0($v0)
    /* AF604 800BEE04 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* AF608 800BEE08 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* AF60C 800BEE0C 4000708E */  lw         $s0, 0x40($s3)
    /* AF610 800BEE10 0C004014 */  bnez       $v0, .L800BEE44
    /* AF614 800BEE14 43181000 */   sra       $v1, $s0, 1
    /* AF618 800BEE18 08006004 */  bltz       $v1, .L800BEE3C
    /* AF61C 800BEE1C 400063AE */   sw        $v1, 0x40($s3)
    /* AF620 800BEE20 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* AF624 800BEE24 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* AF628 800BEE28 00000000 */  nop
    /* AF62C 800BEE2C FDFF4224 */  addiu      $v0, $v0, -0x3
    /* AF630 800BEE30 2A104300 */  slt        $v0, $v0, $v1
    /* AF634 800BEE34 04004010 */  beqz       $v0, .L800BEE48
    /* AF638 800BEE38 00000000 */   nop
  .L800BEE3C:
    /* AF63C 800BEE3C 15FF0208 */  j          .L800BFC54
    /* AF640 800BEE40 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800BEE44:
    /* AF644 800BEE44 400060AE */  sw         $zero, 0x40($s3)
  .L800BEE48:
    /* AF648 800BEE48 4000628E */  lw         $v0, 0x40($s3)
    /* AF64C 800BEE4C 7808448E */  lw         $a0, 0x878($s2)
    /* AF650 800BEE50 80801000 */  sll        $s0, $s0, 2
    /* AF654 800BEE54 10008010 */  beqz       $a0, .L800BEE98
    /* AF658 800BEE58 640842AE */   sw        $v0, 0x864($s2)
    /* AF65C 800BEE5C 6C08828C */  lw         $v0, 0x86C($a0)
    /* AF660 800BEE60 00000000 */  nop
    /* AF664 800BEE64 380062AE */  sw         $v0, 0x38($s3)
    /* AF668 800BEE68 7008828C */  lw         $v0, 0x870($a0)
    /* AF66C 800BEE6C 00000000 */  nop
    /* AF670 800BEE70 880062AE */  sw         $v0, 0x88($s3)
    /* AF674 800BEE74 4000628E */  lw         $v0, 0x40($s3)
    /* AF678 800BEE78 6408838C */  lw         $v1, 0x864($a0)
    /* AF67C 800BEE7C 00000000 */  nop
    /* AF680 800BEE80 23104300 */  subu       $v0, $v0, $v1
    /* AF684 800BEE84 40100200 */  sll        $v0, $v0, 1
    /* AF688 800BEE88 400062AE */  sw         $v0, 0x40($s3)
    /* AF68C 800BEE8C 7408838C */  lw         $v1, 0x874($a0)
    /* AF690 800BEE90 AFFB0208 */  j          .L800BEEBC
    /* AF694 800BEE94 00000000 */   nop
  .L800BEE98:
    /* AF698 800BEE98 6C08428E */  lw         $v0, 0x86C($s2)
    /* AF69C 800BEE9C 00000000 */  nop
    /* AF6A0 800BEEA0 380062AE */  sw         $v0, 0x38($s3)
    /* AF6A4 800BEEA4 7008458E */  lw         $a1, 0x870($s2)
    /* AF6A8 800BEEA8 21204000 */  addu       $a0, $v0, $zero
    /* AF6AC 800BEEAC 02B7030C */  jal        ClearOTagR
    /* AF6B0 800BEEB0 880065AE */   sw        $a1, 0x88($s3)
    /* AF6B4 800BEEB4 400060AE */  sw         $zero, 0x40($s3)
    /* AF6B8 800BEEB8 7408438E */  lw         $v1, 0x874($s2)
  .L800BEEBC:
    /* AF6BC 800BEEBC 4000628E */  lw         $v0, 0x40($s3)
    /* AF6C0 800BEEC0 00000000 */  nop
    /* AF6C4 800BEEC4 80100200 */  sll        $v0, $v0, 2
    /* AF6C8 800BEEC8 400062AE */  sw         $v0, 0x40($s3)
    /* AF6CC 800BEECC 21104300 */  addu       $v0, $v0, $v1
    /* AF6D0 800BEED0 23105000 */  subu       $v0, $v0, $s0
    /* AF6D4 800BEED4 680842AE */  sw         $v0, 0x868($s2)
    /* AF6D8 800BEED8 8800628E */  lw         $v0, 0x88($s3)
    /* AF6DC 800BEEDC 00000000 */  nop
    /* AF6E0 800BEEE0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* AF6E4 800BEEE4 880062AE */  sw         $v0, 0x88($s3)
    /* AF6E8 800BEEE8 4408428E */  lw         $v0, 0x844($s2)
    /* AF6EC 800BEEEC 1480033C */  lui        $v1, %hi(CarIO_carPixMap)
    /* AF6F0 800BEEF0 1CD7638C */  lw         $v1, %lo(CarIO_carPixMap)($v1)
    /* AF6F4 800BEEF4 00110200 */  sll        $v0, $v0, 4
    /* AF6F8 800BEEF8 21186200 */  addu       $v1, $v1, $v0
    /* AF6FC 800BEEFC 600063AE */  sw         $v1, 0x60($s3)
    /* AF700 800BEF00 C8084292 */  lbu        $v0, 0x8C8($s2)
    /* AF704 800BEF04 00000000 */  nop
    /* AF708 800BEF08 EE0362A2 */  sb         $v0, 0x3EE($s3)
    /* AF70C 800BEF0C CA084292 */  lbu        $v0, 0x8CA($s2)
    /* AF710 800BEF10 00000000 */  nop
    /* AF714 800BEF14 EF0362A2 */  sb         $v0, 0x3EF($s3)
    /* AF718 800BEF18 CC084292 */  lbu        $v0, 0x8CC($s2)
    /* AF71C 800BEF1C 00000000 */  nop
    /* AF720 800BEF20 F60362A2 */  sb         $v0, 0x3F6($s3)
    /* AF724 800BEF24 CE084292 */  lbu        $v0, 0x8CE($s2)
    /* AF728 800BEF28 00000000 */  nop
    /* AF72C 800BEF2C F70362A2 */  sb         $v0, 0x3F7($s3)
    /* AF730 800BEF30 CD084292 */  lbu        $v0, 0x8CD($s2)
    /* AF734 800BEF34 32000424 */  addiu      $a0, $zero, 0x32
    /* AF738 800BEF38 FE0362A2 */  sb         $v0, 0x3FE($s3)
    /* AF73C 800BEF3C 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
    /* AF740 800BEF40 08F54224 */  addiu      $v0, $v0, %lo(DrawC_gOverlay)
    /* AF744 800BEF44 CF084392 */  lbu        $v1, 0x8CF($s2)
    /* AF748 800BEF48 64004224 */  addiu      $v0, $v0, 0x64
    /* AF74C 800BEF4C FF0363A2 */  sb         $v1, 0x3FF($s3)
  .L800BEF50:
    /* AF750 800BEF50 000040A4 */  sh         $zero, 0x0($v0)
    /* AF754 800BEF54 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* AF758 800BEF58 FDFF8104 */  bgez       $a0, .L800BEF50
    /* AF75C 800BEF5C FEFF4224 */   addiu     $v0, $v0, -0x2
    /* AF760 800BEF60 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* AF764 800BEF64 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* AF768 800BEF68 00000000 */  nop
    /* AF76C 800BEF6C 66014014 */  bnez       $v0, .L800BF508
    /* AF770 800BEF70 1E00023C */   lui       $v0, (0x1E0000 >> 16)
    /* AF774 800BEF74 1802438E */  lw         $v1, 0x218($s2)
    /* AF778 800BEF78 00000000 */  nop
    /* AF77C 800BEF7C 2A104300 */  slt        $v0, $v0, $v1
    /* AF780 800BEF80 07004010 */  beqz       $v0, .L800BEFA0
    /* AF784 800BEF84 1280043C */   lui       $a0, %hi(DrawC_gOverlay)
    /* AF788 800BEF88 08F58524 */  addiu      $a1, $a0, %lo(DrawC_gOverlay)
    /* AF78C 800BEF8C 08F58294 */  lhu        $v0, %lo(DrawC_gOverlay)($a0)
    /* AF790 800BEF90 0400A394 */  lhu        $v1, 0x4($a1)
    /* AF794 800BEF94 01004234 */  ori        $v0, $v0, 0x1
    /* AF798 800BEF98 F0FB0208 */  j          .L800BEFC0
    /* AF79C 800BEF9C 01006334 */   ori       $v1, $v1, 0x1
  .L800BEFA0:
    /* AF7A0 800BEFA0 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* AF7A4 800BEFA4 2A104300 */  slt        $v0, $v0, $v1
    /* AF7A8 800BEFA8 07004010 */  beqz       $v0, .L800BEFC8
    /* AF7AC 800BEFAC 08F58524 */   addiu     $a1, $a0, %lo(DrawC_gOverlay)
    /* AF7B0 800BEFB0 08F58294 */  lhu        $v0, %lo(DrawC_gOverlay)($a0)
    /* AF7B4 800BEFB4 0400A394 */  lhu        $v1, 0x4($a1)
    /* AF7B8 800BEFB8 02004234 */  ori        $v0, $v0, 0x2
    /* AF7BC 800BEFBC 02006334 */  ori        $v1, $v1, 0x2
  .L800BEFC0:
    /* AF7C0 800BEFC0 08F582A4 */  sh         $v0, %lo(DrawC_gOverlay)($a0)
    /* AF7C4 800BEFC4 0400A3A4 */  sh         $v1, 0x4($a1)
  .L800BEFC8:
    /* AF7C8 800BEFC8 2002438E */  lw         $v1, 0x220($s2)
    /* AF7CC 800BEFCC 1E00023C */  lui        $v0, (0x1E0000 >> 16)
    /* AF7D0 800BEFD0 2A104300 */  slt        $v0, $v0, $v1
    /* AF7D4 800BEFD4 07004010 */  beqz       $v0, .L800BEFF4
    /* AF7D8 800BEFD8 1280043C */   lui       $a0, %hi(DrawC_gOverlay)
    /* AF7DC 800BEFDC 08F58524 */  addiu      $a1, $a0, %lo(DrawC_gOverlay)
    /* AF7E0 800BEFE0 08F58294 */  lhu        $v0, %lo(DrawC_gOverlay)($a0)
    /* AF7E4 800BEFE4 0400A394 */  lhu        $v1, 0x4($a1)
    /* AF7E8 800BEFE8 00014234 */  ori        $v0, $v0, 0x100
    /* AF7EC 800BEFEC 05FC0208 */  j          .L800BF014
    /* AF7F0 800BEFF0 00016334 */   ori       $v1, $v1, 0x100
  .L800BEFF4:
    /* AF7F4 800BEFF4 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* AF7F8 800BEFF8 2A104300 */  slt        $v0, $v0, $v1
    /* AF7FC 800BEFFC 07004010 */  beqz       $v0, .L800BF01C
    /* AF800 800BF000 08F58524 */   addiu     $a1, $a0, %lo(DrawC_gOverlay)
    /* AF804 800BF004 08F58294 */  lhu        $v0, %lo(DrawC_gOverlay)($a0)
    /* AF808 800BF008 0400A394 */  lhu        $v1, 0x4($a1)
    /* AF80C 800BF00C 00024234 */  ori        $v0, $v0, 0x200
    /* AF810 800BF010 00026334 */  ori        $v1, $v1, 0x200
  .L800BF014:
    /* AF814 800BF014 08F582A4 */  sh         $v0, %lo(DrawC_gOverlay)($a0)
    /* AF818 800BF018 0400A3A4 */  sh         $v1, 0x4($a1)
  .L800BF01C:
    /* AF81C 800BF01C 2402438E */  lw         $v1, 0x224($s2)
    /* AF820 800BF020 1E00023C */  lui        $v0, (0x1E0000 >> 16)
    /* AF824 800BF024 2A104300 */  slt        $v0, $v0, $v1
    /* AF828 800BF028 06004010 */  beqz       $v0, .L800BF044
    /* AF82C 800BF02C 00000000 */   nop
    /* AF830 800BF030 1280033C */  lui        $v1, %hi(DrawC_gOverlay)
    /* AF834 800BF034 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AF838 800BF038 04006294 */  lhu        $v0, 0x4($v1)
    /* AF83C 800BF03C 19FC0208 */  j          .L800BF064
    /* AF840 800BF040 00044234 */   ori       $v0, $v0, 0x400
  .L800BF044:
    /* AF844 800BF044 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* AF848 800BF048 2A104300 */  slt        $v0, $v0, $v1
    /* AF84C 800BF04C 06004010 */  beqz       $v0, .L800BF068
    /* AF850 800BF050 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AF854 800BF054 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AF858 800BF058 04006294 */  lhu        $v0, 0x4($v1)
    /* AF85C 800BF05C 00000000 */  nop
    /* AF860 800BF060 00084234 */  ori        $v0, $v0, 0x800
  .L800BF064:
    /* AF864 800BF064 040062A4 */  sh         $v0, 0x4($v1)
  .L800BF068:
    /* AF868 800BF068 2802438E */  lw         $v1, 0x228($s2)
    /* AF86C 800BF06C 1E00023C */  lui        $v0, (0x1E0000 >> 16)
    /* AF870 800BF070 2A104300 */  slt        $v0, $v0, $v1
    /* AF874 800BF074 07004010 */  beqz       $v0, .L800BF094
    /* AF878 800BF078 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AF87C 800BF07C 08F54224 */  addiu      $v0, $v0, %lo(DrawC_gOverlay)
    /* AF880 800BF080 02004394 */  lhu        $v1, 0x2($v0)
    /* AF884 800BF084 04004494 */  lhu        $a0, 0x4($v0)
    /* AF888 800BF088 00016334 */  ori        $v1, $v1, 0x100
    /* AF88C 800BF08C 2EFC0208 */  j          .L800BF0B8
    /* AF890 800BF090 00108434 */   ori       $a0, $a0, 0x1000
  .L800BF094:
    /* AF894 800BF094 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* AF898 800BF098 2A104300 */  slt        $v0, $v0, $v1
    /* AF89C 800BF09C 08004010 */  beqz       $v0, .L800BF0C0
    /* AF8A0 800BF0A0 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AF8A4 800BF0A4 08F54224 */  addiu      $v0, $v0, %lo(DrawC_gOverlay)
    /* AF8A8 800BF0A8 02004394 */  lhu        $v1, 0x2($v0)
    /* AF8AC 800BF0AC 04004494 */  lhu        $a0, 0x4($v0)
    /* AF8B0 800BF0B0 00026334 */  ori        $v1, $v1, 0x200
    /* AF8B4 800BF0B4 00208434 */  ori        $a0, $a0, 0x2000
  .L800BF0B8:
    /* AF8B8 800BF0B8 020043A4 */  sh         $v1, 0x2($v0)
    /* AF8BC 800BF0BC 040044A4 */  sh         $a0, 0x4($v0)
  .L800BF0C0:
    /* AF8C0 800BF0C0 3002438E */  lw         $v1, 0x230($s2)
    /* AF8C4 800BF0C4 1E00023C */  lui        $v0, (0x1E0000 >> 16)
    /* AF8C8 800BF0C8 2A104300 */  slt        $v0, $v0, $v1
    /* AF8CC 800BF0CC 07004010 */  beqz       $v0, .L800BF0EC
    /* AF8D0 800BF0D0 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AF8D4 800BF0D4 08F54224 */  addiu      $v0, $v0, %lo(DrawC_gOverlay)
    /* AF8D8 800BF0D8 02004394 */  lhu        $v1, 0x2($v0)
    /* AF8DC 800BF0DC 04004494 */  lhu        $a0, 0x4($v0)
    /* AF8E0 800BF0E0 01006334 */  ori        $v1, $v1, 0x1
    /* AF8E4 800BF0E4 44FC0208 */  j          .L800BF110
    /* AF8E8 800BF0E8 10008434 */   ori       $a0, $a0, 0x10
  .L800BF0EC:
    /* AF8EC 800BF0EC 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* AF8F0 800BF0F0 2A104300 */  slt        $v0, $v0, $v1
    /* AF8F4 800BF0F4 08004010 */  beqz       $v0, .L800BF118
    /* AF8F8 800BF0F8 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AF8FC 800BF0FC 08F54224 */  addiu      $v0, $v0, %lo(DrawC_gOverlay)
    /* AF900 800BF100 02004394 */  lhu        $v1, 0x2($v0)
    /* AF904 800BF104 04004494 */  lhu        $a0, 0x4($v0)
    /* AF908 800BF108 02006334 */  ori        $v1, $v1, 0x2
    /* AF90C 800BF10C 20008434 */  ori        $a0, $a0, 0x20
  .L800BF110:
    /* AF910 800BF110 020043A4 */  sh         $v1, 0x2($v0)
    /* AF914 800BF114 040044A4 */  sh         $a0, 0x4($v0)
  .L800BF118:
    /* AF918 800BF118 3402438E */  lw         $v1, 0x234($s2)
    /* AF91C 800BF11C 1E00023C */  lui        $v0, (0x1E0000 >> 16)
    /* AF920 800BF120 2A104300 */  slt        $v0, $v0, $v1
    /* AF924 800BF124 06004010 */  beqz       $v0, .L800BF140
    /* AF928 800BF128 00000000 */   nop
    /* AF92C 800BF12C 1280033C */  lui        $v1, %hi(DrawC_gOverlay)
    /* AF930 800BF130 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AF934 800BF134 04006294 */  lhu        $v0, 0x4($v1)
    /* AF938 800BF138 58FC0208 */  j          .L800BF160
    /* AF93C 800BF13C 04004234 */   ori       $v0, $v0, 0x4
  .L800BF140:
    /* AF940 800BF140 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* AF944 800BF144 2A104300 */  slt        $v0, $v0, $v1
    /* AF948 800BF148 06004010 */  beqz       $v0, .L800BF164
    /* AF94C 800BF14C 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AF950 800BF150 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AF954 800BF154 04006294 */  lhu        $v0, 0x4($v1)
    /* AF958 800BF158 00000000 */  nop
    /* AF95C 800BF15C 08004234 */  ori        $v0, $v0, 0x8
  .L800BF160:
    /* AF960 800BF160 040062A4 */  sh         $v0, 0x4($v1)
  .L800BF164:
    /* AF964 800BF164 3802438E */  lw         $v1, 0x238($s2)
    /* AF968 800BF168 0300023C */  lui        $v0, (0x30000 >> 16)
    /* AF96C 800BF16C 2A104300 */  slt        $v0, $v0, $v1
    /* AF970 800BF170 06004010 */  beqz       $v0, .L800BF18C
    /* AF974 800BF174 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AF978 800BF178 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AF97C 800BF17C 08006294 */  lhu        $v0, 0x8($v1)
    /* AF980 800BF180 00000000 */  nop
    /* AF984 800BF184 01014234 */  ori        $v0, $v0, 0x101
    /* AF988 800BF188 080062A4 */  sh         $v0, 0x8($v1)
  .L800BF18C:
    /* AF98C 800BF18C B6084296 */  lhu        $v0, 0x8B6($s2)
    /* AF990 800BF190 00000000 */  nop
    /* AF994 800BF194 01004230 */  andi       $v0, $v0, 0x1
    /* AF998 800BF198 16004010 */  beqz       $v0, .L800BF1F4
    /* AF99C 800BF19C 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AF9A0 800BF1A0 08F54524 */  addiu      $a1, $v0, %lo(DrawC_gOverlay)
    /* AF9A4 800BF1A4 0200A494 */  lhu        $a0, 0x2($a1)
    /* AF9A8 800BF1A8 00000000 */  nop
    /* AF9AC 800BF1AC 01008230 */  andi       $v0, $a0, 0x1
    /* AF9B0 800BF1B0 08004014 */  bnez       $v0, .L800BF1D4
    /* AF9B4 800BF1B4 00018230 */   andi      $v0, $a0, 0x100
    /* AF9B8 800BF1B8 3000A294 */  lhu        $v0, 0x30($a1)
    /* AF9BC 800BF1BC 3200A394 */  lhu        $v1, 0x32($a1)
    /* AF9C0 800BF1C0 81004234 */  ori        $v0, $v0, 0x81
    /* AF9C4 800BF1C4 81006334 */  ori        $v1, $v1, 0x81
    /* AF9C8 800BF1C8 3000A2A4 */  sh         $v0, 0x30($a1)
    /* AF9CC 800BF1CC 3200A3A4 */  sh         $v1, 0x32($a1)
    /* AF9D0 800BF1D0 00018230 */  andi       $v0, $a0, 0x100
  .L800BF1D4:
    /* AF9D4 800BF1D4 07004014 */  bnez       $v0, .L800BF1F4
    /* AF9D8 800BF1D8 00810224 */   addiu     $v0, $zero, -0x7F00
    /* AF9DC 800BF1DC 3000A394 */  lhu        $v1, 0x30($a1)
    /* AF9E0 800BF1E0 3200A494 */  lhu        $a0, 0x32($a1)
    /* AF9E4 800BF1E4 25186200 */  or         $v1, $v1, $v0
    /* AF9E8 800BF1E8 25208200 */  or         $a0, $a0, $v0
    /* AF9EC 800BF1EC 3000A3A4 */  sh         $v1, 0x30($a1)
    /* AF9F0 800BF1F0 3200A4A4 */  sh         $a0, 0x32($a1)
  .L800BF1F4:
    /* AF9F4 800BF1F4 42044292 */  lbu        $v0, 0x442($s2)
    /* AF9F8 800BF1F8 00000000 */  nop
    /* AF9FC 800BF1FC 12004014 */  bnez       $v0, .L800BF248
    /* AFA00 800BF200 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFA04 800BF204 08F54324 */  addiu      $v1, $v0, %lo(DrawC_gOverlay)
    /* AFA08 800BF208 02006494 */  lhu        $a0, 0x2($v1)
    /* AFA0C 800BF20C 00000000 */  nop
    /* AFA10 800BF210 01008230 */  andi       $v0, $a0, 0x1
    /* AFA14 800BF214 06004014 */  bnez       $v0, .L800BF230
    /* AFA18 800BF218 00018230 */   andi      $v0, $a0, 0x100
    /* AFA1C 800BF21C 34006294 */  lhu        $v0, 0x34($v1)
    /* AFA20 800BF220 00000000 */  nop
    /* AFA24 800BF224 80004234 */  ori        $v0, $v0, 0x80
    /* AFA28 800BF228 340062A4 */  sh         $v0, 0x34($v1)
    /* AFA2C 800BF22C 00018230 */  andi       $v0, $a0, 0x100
  .L800BF230:
    /* AFA30 800BF230 05004014 */  bnez       $v0, .L800BF248
    /* AFA34 800BF234 00000000 */   nop
    /* AFA38 800BF238 34006294 */  lhu        $v0, 0x34($v1)
    /* AFA3C 800BF23C 00000000 */  nop
    /* AFA40 800BF240 00804234 */  ori        $v0, $v0, 0x8000
    /* AFA44 800BF244 340062A4 */  sh         $v0, 0x34($v1)
  .L800BF248:
    /* AFA48 800BF248 B4084396 */  lhu        $v1, 0x8B4($s2)
    /* AFA4C 800BF24C 00000000 */  nop
    /* AFA50 800BF250 11006230 */  andi       $v0, $v1, 0x11
    /* AFA54 800BF254 1E004010 */  beqz       $v0, .L800BF2D0
    /* AFA58 800BF258 40006230 */   andi      $v0, $v1, 0x40
    /* AFA5C 800BF25C 06004014 */  bnez       $v0, .L800BF278
    /* AFA60 800BF260 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFA64 800BF264 08F54294 */  lhu        $v0, %lo(DrawC_gOverlay)($v0)
    /* AFA68 800BF268 00000000 */  nop
    /* AFA6C 800BF26C 01004230 */  andi       $v0, $v0, 0x1
    /* AFA70 800BF270 07004014 */  bnez       $v0, .L800BF290
    /* AFA74 800BF274 00000000 */   nop
  .L800BF278:
    /* AFA78 800BF278 1280033C */  lui        $v1, %hi(DrawC_gOverlay)
    /* AFA7C 800BF27C 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AFA80 800BF280 3A006294 */  lhu        $v0, 0x3A($v1)
    /* AFA84 800BF284 00000000 */  nop
    /* AFA88 800BF288 81004234 */  ori        $v0, $v0, 0x81
    /* AFA8C 800BF28C 3A0062A4 */  sh         $v0, 0x3A($v1)
  .L800BF290:
    /* AFA90 800BF290 B4084296 */  lhu        $v0, 0x8B4($s2)
    /* AFA94 800BF294 00000000 */  nop
    /* AFA98 800BF298 04004230 */  andi       $v0, $v0, 0x4
    /* AFA9C 800BF29C 07004014 */  bnez       $v0, .L800BF2BC
    /* AFAA0 800BF2A0 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AFAA4 800BF2A4 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
    /* AFAA8 800BF2A8 08F54294 */  lhu        $v0, %lo(DrawC_gOverlay)($v0)
    /* AFAAC 800BF2AC 00000000 */  nop
    /* AFAB0 800BF2B0 00014230 */  andi       $v0, $v0, 0x100
    /* AFAB4 800BF2B4 06004014 */  bnez       $v0, .L800BF2D0
    /* AFAB8 800BF2B8 00000000 */   nop
  .L800BF2BC:
    /* AFABC 800BF2BC 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AFAC0 800BF2C0 3A006294 */  lhu        $v0, 0x3A($v1)
    /* AFAC4 800BF2C4 00000000 */  nop
    /* AFAC8 800BF2C8 00814234 */  ori        $v0, $v0, 0x8100
    /* AFACC 800BF2CC 3A0062A4 */  sh         $v0, 0x3A($v1)
  .L800BF2D0:
    /* AFAD0 800BF2D0 B6084296 */  lhu        $v0, 0x8B6($s2)
    /* AFAD4 800BF2D4 00000000 */  nop
    /* AFAD8 800BF2D8 02004230 */  andi       $v0, $v0, 0x2
    /* AFADC 800BF2DC 16004010 */  beqz       $v0, .L800BF338
    /* AFAE0 800BF2E0 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFAE4 800BF2E4 08F54524 */  addiu      $a1, $v0, %lo(DrawC_gOverlay)
    /* AFAE8 800BF2E8 0200A494 */  lhu        $a0, 0x2($a1)
    /* AFAEC 800BF2EC 00000000 */  nop
    /* AFAF0 800BF2F0 01008230 */  andi       $v0, $a0, 0x1
    /* AFAF4 800BF2F4 08004014 */  bnez       $v0, .L800BF318
    /* AFAF8 800BF2F8 00018230 */   andi      $v0, $a0, 0x100
    /* AFAFC 800BF2FC 3000A294 */  lhu        $v0, 0x30($a1)
    /* AFB00 800BF300 3200A394 */  lhu        $v1, 0x32($a1)
    /* AFB04 800BF304 80004234 */  ori        $v0, $v0, 0x80
    /* AFB08 800BF308 80006334 */  ori        $v1, $v1, 0x80
    /* AFB0C 800BF30C 3000A2A4 */  sh         $v0, 0x30($a1)
    /* AFB10 800BF310 3200A3A4 */  sh         $v1, 0x32($a1)
    /* AFB14 800BF314 00018230 */  andi       $v0, $a0, 0x100
  .L800BF318:
    /* AFB18 800BF318 07004014 */  bnez       $v0, .L800BF338
    /* AFB1C 800BF31C 00800224 */   addiu     $v0, $zero, -0x8000
    /* AFB20 800BF320 3000A394 */  lhu        $v1, 0x30($a1)
    /* AFB24 800BF324 3200A494 */  lhu        $a0, 0x32($a1)
    /* AFB28 800BF328 25186200 */  or         $v1, $v1, $v0
    /* AFB2C 800BF32C 25208200 */  or         $a0, $a0, $v0
    /* AFB30 800BF330 3000A3A4 */  sh         $v1, 0x30($a1)
    /* AFB34 800BF334 3200A4A4 */  sh         $a0, 0x32($a1)
  .L800BF338:
    /* AFB38 800BF338 75008016 */  bnez       $s4, .L800BF510
    /* AFB3C 800BF33C 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFB40 800BF340 0C00648E */  lw         $a0, 0xC($s3)
    /* AFB44 800BF344 00000000 */  nop
    /* AFB48 800BF348 40100400 */  sll        $v0, $a0, 1
    /* AFB4C 800BF34C 21284202 */  addu       $a1, $s2, $v0
    /* AFB50 800BF350 B808A294 */  lhu        $v0, 0x8B8($a1)
    /* AFB54 800BF354 00000000 */  nop
    /* AFB58 800BF358 80004230 */  andi       $v0, $v0, 0x80
    /* AFB5C 800BF35C 06004010 */  beqz       $v0, .L800BF378
    /* AFB60 800BF360 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AFB64 800BF364 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AFB68 800BF368 38006294 */  lhu        $v0, 0x38($v1)
    /* AFB6C 800BF36C 00000000 */  nop
    /* AFB70 800BF370 40004234 */  ori        $v0, $v0, 0x40
    /* AFB74 800BF374 380062A4 */  sh         $v0, 0x38($v1)
  .L800BF378:
    /* AFB78 800BF378 B808A294 */  lhu        $v0, 0x8B8($a1)
    /* AFB7C 800BF37C 00000000 */  nop
    /* AFB80 800BF380 08004230 */  andi       $v0, $v0, 0x8
    /* AFB84 800BF384 13004010 */  beqz       $v0, .L800BF3D4
    /* AFB88 800BF388 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AFB8C 800BF38C 08F56294 */  lhu        $v0, %lo(DrawC_gOverlay)($v1)
    /* AFB90 800BF390 00000000 */  nop
    /* AFB94 800BF394 01004230 */  andi       $v0, $v0, 0x1
    /* AFB98 800BF398 05004014 */  bnez       $v0, .L800BF3B0
    /* AFB9C 800BF39C 08F56324 */   addiu     $v1, $v1, %lo(DrawC_gOverlay)
    /* AFBA0 800BF3A0 36006294 */  lhu        $v0, 0x36($v1)
    /* AFBA4 800BF3A4 00000000 */  nop
    /* AFBA8 800BF3A8 80004234 */  ori        $v0, $v0, 0x80
    /* AFBAC 800BF3AC 360062A4 */  sh         $v0, 0x36($v1)
  .L800BF3B0:
    /* AFBB0 800BF3B0 02006294 */  lhu        $v0, 0x2($v1)
    /* AFBB4 800BF3B4 00000000 */  nop
    /* AFBB8 800BF3B8 01004230 */  andi       $v0, $v0, 0x1
    /* AFBBC 800BF3BC 05004014 */  bnez       $v0, .L800BF3D4
    /* AFBC0 800BF3C0 00000000 */   nop
    /* AFBC4 800BF3C4 38006294 */  lhu        $v0, 0x38($v1)
    /* AFBC8 800BF3C8 00000000 */  nop
    /* AFBCC 800BF3CC 81004234 */  ori        $v0, $v0, 0x81
    /* AFBD0 800BF3D0 380062A4 */  sh         $v0, 0x38($v1)
  .L800BF3D4:
    /* AFBD4 800BF3D4 01008438 */  xori       $a0, $a0, 0x1
    /* AFBD8 800BF3D8 40100400 */  sll        $v0, $a0, 1
    /* AFBDC 800BF3DC 21204202 */  addu       $a0, $s2, $v0
    /* AFBE0 800BF3E0 B8088294 */  lhu        $v0, 0x8B8($a0)
    /* AFBE4 800BF3E4 00000000 */  nop
    /* AFBE8 800BF3E8 80004230 */  andi       $v0, $v0, 0x80
    /* AFBEC 800BF3EC 06004010 */  beqz       $v0, .L800BF408
    /* AFBF0 800BF3F0 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AFBF4 800BF3F4 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AFBF8 800BF3F8 38006294 */  lhu        $v0, 0x38($v1)
    /* AFBFC 800BF3FC 00000000 */  nop
    /* AFC00 800BF400 00404234 */  ori        $v0, $v0, 0x4000
    /* AFC04 800BF404 380062A4 */  sh         $v0, 0x38($v1)
  .L800BF408:
    /* AFC08 800BF408 B8088294 */  lhu        $v0, 0x8B8($a0)
    /* AFC0C 800BF40C 00000000 */  nop
    /* AFC10 800BF410 08004230 */  andi       $v0, $v0, 0x8
    /* AFC14 800BF414 13004010 */  beqz       $v0, .L800BF464
    /* AFC18 800BF418 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AFC1C 800BF41C 08F56294 */  lhu        $v0, %lo(DrawC_gOverlay)($v1)
    /* AFC20 800BF420 00000000 */  nop
    /* AFC24 800BF424 00014230 */  andi       $v0, $v0, 0x100
    /* AFC28 800BF428 05004014 */  bnez       $v0, .L800BF440
    /* AFC2C 800BF42C 08F56324 */   addiu     $v1, $v1, %lo(DrawC_gOverlay)
    /* AFC30 800BF430 36006294 */  lhu        $v0, 0x36($v1)
    /* AFC34 800BF434 00000000 */  nop
    /* AFC38 800BF438 00804234 */  ori        $v0, $v0, 0x8000
    /* AFC3C 800BF43C 360062A4 */  sh         $v0, 0x36($v1)
  .L800BF440:
    /* AFC40 800BF440 02006294 */  lhu        $v0, 0x2($v1)
    /* AFC44 800BF444 00000000 */  nop
    /* AFC48 800BF448 00014230 */  andi       $v0, $v0, 0x100
    /* AFC4C 800BF44C 06004014 */  bnez       $v0, .L800BF468
    /* AFC50 800BF450 1180023C */   lui       $v0, %hi(R3DCar_SignalBrakeFlare)
    /* AFC54 800BF454 38006294 */  lhu        $v0, 0x38($v1)
    /* AFC58 800BF458 00000000 */  nop
    /* AFC5C 800BF45C 00814234 */  ori        $v0, $v0, 0x8100
    /* AFC60 800BF460 380062A4 */  sh         $v0, 0x38($v1)
  .L800BF464:
    /* AFC64 800BF464 1180023C */  lui        $v0, %hi(R3DCar_SignalBrakeFlare)
  .L800BF468:
    /* AFC68 800BF468 0C684224 */  addiu      $v0, $v0, %lo(R3DCar_SignalBrakeFlare)
    /* AFC6C 800BF46C 21102202 */  addu       $v0, $s1, $v0
    /* AFC70 800BF470 00004290 */  lbu        $v0, 0x0($v0)
    /* AFC74 800BF474 00000000 */  nop
    /* AFC78 800BF478 0200422C */  sltiu      $v0, $v0, 0x2
    /* AFC7C 800BF47C 17004014 */  bnez       $v0, .L800BF4DC
    /* AFC80 800BF480 1180023C */   lui       $v0, %hi(R3DCar_SignalBrakeFlare)
    /* AFC84 800BF484 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
    /* AFC88 800BF488 08F54424 */  addiu      $a0, $v0, %lo(DrawC_gOverlay)
    /* AFC8C 800BF48C 38008394 */  lhu        $v1, 0x38($a0)
    /* AFC90 800BF490 00000000 */  nop
    /* AFC94 800BF494 40006230 */  andi       $v0, $v1, 0x40
    /* AFC98 800BF498 08004014 */  bnez       $v0, .L800BF4BC
    /* AFC9C 800BF49C 00406230 */   andi      $v0, $v1, 0x4000
    /* AFCA0 800BF4A0 30008290 */  lbu        $v0, 0x30($a0)
    /* AFCA4 800BF4A4 00000000 */  nop
    /* AFCA8 800BF4A8 25106200 */  or         $v0, $v1, $v0
    /* AFCAC 800BF4AC 380082A4 */  sh         $v0, 0x38($a0)
    /* AFCB0 800BF4B0 38008394 */  lhu        $v1, 0x38($a0)
    /* AFCB4 800BF4B4 00000000 */  nop
    /* AFCB8 800BF4B8 00406230 */  andi       $v0, $v1, 0x4000
  .L800BF4BC:
    /* AFCBC 800BF4BC 07004014 */  bnez       $v0, .L800BF4DC
    /* AFCC0 800BF4C0 1180023C */   lui       $v0, %hi(R3DCar_SignalBrakeFlare)
    /* AFCC4 800BF4C4 30008294 */  lhu        $v0, 0x30($a0)
    /* AFCC8 800BF4C8 00000000 */  nop
    /* AFCCC 800BF4CC 00FF4230 */  andi       $v0, $v0, 0xFF00
    /* AFCD0 800BF4D0 25106200 */  or         $v0, $v1, $v0
    /* AFCD4 800BF4D4 380082A4 */  sh         $v0, 0x38($a0)
    /* AFCD8 800BF4D8 1180023C */  lui        $v0, %hi(R3DCar_SignalBrakeFlare)
  .L800BF4DC:
    /* AFCDC 800BF4DC 0C684224 */  addiu      $v0, $v0, %lo(R3DCar_SignalBrakeFlare)
    /* AFCE0 800BF4E0 21102202 */  addu       $v0, $s1, $v0
    /* AFCE4 800BF4E4 00004390 */  lbu        $v1, 0x0($v0)
    /* AFCE8 800BF4E8 03000224 */  addiu      $v0, $zero, 0x3
    /* AFCEC 800BF4EC 06006214 */  bne        $v1, $v0, .L800BF508
    /* AFCF0 800BF4F0 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFCF4 800BF4F4 08F54224 */  addiu      $v0, $v0, %lo(DrawC_gOverlay)
    /* AFCF8 800BF4F8 38004394 */  lhu        $v1, 0x38($v0)
    /* AFCFC 800BF4FC 30004484 */  lh         $a0, 0x30($v0)
    /* AFD00 800BF500 300043A4 */  sh         $v1, 0x30($v0)
    /* AFD04 800BF504 380044A4 */  sh         $a0, 0x38($v0)
  .L800BF508:
    /* AFD08 800BF508 BB008012 */  beqz       $s4, .L800BF7F8
    /* AFD0C 800BF50C 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
  .L800BF510:
    /* AFD10 800BF510 08F54524 */  addiu      $a1, $v0, %lo(DrawC_gOverlay)
    /* AFD14 800BF514 3600A694 */  lhu        $a2, 0x36($a1)
    /* AFD18 800BF518 3800A494 */  lhu        $a0, 0x38($a1)
    /* AFD1C 800BF51C 0800A384 */  lh         $v1, 0x8($a1)
    /* AFD20 800BF520 0200C234 */  ori        $v0, $a2, 0x2
    /* AFD24 800BF524 3600A2A4 */  sh         $v0, 0x36($a1)
    /* AFD28 800BF528 00028234 */  ori        $v0, $a0, 0x200
    /* AFD2C 800BF52C 1D006014 */  bnez       $v1, .L800BF5A4
    /* AFD30 800BF530 3800A2A4 */   sh        $v0, 0x38($a1)
    /* AFD34 800BF534 1280023C */  lui        $v0, %hi(DrawC_SirenFlash)
    /* AFD38 800BF538 B8084396 */  lhu        $v1, 0x8B8($s2)
    /* AFD3C 800BF53C 54F44724 */  addiu      $a3, $v0, %lo(DrawC_SirenFlash)
    /* AFD40 800BF540 0F006330 */  andi       $v1, $v1, 0xF
    /* AFD44 800BF544 40180300 */  sll        $v1, $v1, 1
    /* AFD48 800BF548 21186700 */  addu       $v1, $v1, $a3
    /* AFD4C 800BF54C 00006284 */  lh         $v0, 0x0($v1)
    /* AFD50 800BF550 00000000 */  nop
    /* AFD54 800BF554 04004010 */  beqz       $v0, .L800BF568
    /* AFD58 800BF558 8300C234 */   ori       $v0, $a2, 0x83
    /* AFD5C 800BF55C 3600A2A4 */  sh         $v0, 0x36($a1)
    /* AFD60 800BF560 81028234 */  ori        $v0, $a0, 0x281
    /* AFD64 800BF564 3800A2A4 */  sh         $v0, 0x38($a1)
  .L800BF568:
    /* AFD68 800BF568 BA084296 */  lhu        $v0, 0x8BA($s2)
    /* AFD6C 800BF56C 00000000 */  nop
    /* AFD70 800BF570 0F004230 */  andi       $v0, $v0, 0xF
    /* AFD74 800BF574 40100200 */  sll        $v0, $v0, 1
    /* AFD78 800BF578 21104700 */  addu       $v0, $v0, $a3
    /* AFD7C 800BF57C 00004284 */  lh         $v0, 0x0($v0)
    /* AFD80 800BF580 00000000 */  nop
    /* AFD84 800BF584 07004010 */  beqz       $v0, .L800BF5A4
    /* AFD88 800BF588 00810224 */   addiu     $v0, $zero, -0x7F00
    /* AFD8C 800BF58C 3600A394 */  lhu        $v1, 0x36($a1)
    /* AFD90 800BF590 3800A494 */  lhu        $a0, 0x38($a1)
    /* AFD94 800BF594 25186200 */  or         $v1, $v1, $v0
    /* AFD98 800BF598 25208200 */  or         $a0, $a0, $v0
    /* AFD9C 800BF59C 3600A3A4 */  sh         $v1, 0x36($a1)
    /* AFDA0 800BF5A0 3800A4A4 */  sh         $a0, 0x38($a1)
  .L800BF5A4:
    /* AFDA4 800BF5A4 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* AFDA8 800BF5A8 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* AFDAC 800BF5AC 00000000 */  nop
    /* AFDB0 800BF5B0 06004014 */  bnez       $v0, .L800BF5CC
    /* AFDB4 800BF5B4 1280063C */   lui       $a2, %hi(DrawC_gOverlay)
    /* AFDB8 800BF5B8 7005428E */  lw         $v0, 0x570($s2)
    /* AFDBC 800BF5BC 00000000 */  nop
    /* AFDC0 800BF5C0 02004230 */  andi       $v0, $v0, 0x2
    /* AFDC4 800BF5C4 8D004010 */  beqz       $v0, .L800BF7FC
    /* AFDC8 800BF5C8 1800A427 */   addiu     $a0, $sp, 0x18
  .L800BF5CC:
    /* AFDCC 800BF5CC 08F5C424 */  addiu      $a0, $a2, %lo(DrawC_gOverlay)
    /* AFDD0 800BF5D0 3A008294 */  lhu        $v0, 0x3A($a0)
    /* AFDD4 800BF5D4 00000000 */  nop
    /* AFDD8 800BF5D8 7E7E4530 */  andi       $a1, $v0, 0x7E7E
    /* AFDDC 800BF5DC 3A0085A4 */  sh         $a1, 0x3A($a0)
    /* AFDE0 800BF5E0 B6084296 */  lhu        $v0, 0x8B6($s2)
    /* AFDE4 800BF5E4 00000000 */  nop
    /* AFDE8 800BF5E8 01004230 */  andi       $v0, $v0, 0x1
    /* AFDEC 800BF5EC 08004014 */  bnez       $v0, .L800BF610
    /* AFDF0 800BF5F0 1280023C */   lui       $v0, %hi(DrawC_HeadLightFlash)
    /* AFDF4 800BF5F4 30008294 */  lhu        $v0, 0x30($a0)
    /* AFDF8 800BF5F8 32008394 */  lhu        $v1, 0x32($a0)
    /* AFDFC 800BF5FC 7F7F4230 */  andi       $v0, $v0, 0x7F7F
    /* AFE00 800BF600 7F7F6330 */  andi       $v1, $v1, 0x7F7F
    /* AFE04 800BF604 300082A4 */  sh         $v0, 0x30($a0)
    /* AFE08 800BF608 320083A4 */  sh         $v1, 0x32($a0)
    /* AFE0C 800BF60C 1280023C */  lui        $v0, %hi(DrawC_HeadLightFlash)
  .L800BF610:
    /* AFE10 800BF610 B8084396 */  lhu        $v1, 0x8B8($s2)
    /* AFE14 800BF614 74F44224 */  addiu      $v0, $v0, %lo(DrawC_HeadLightFlash)
    /* AFE18 800BF618 0F006330 */  andi       $v1, $v1, 0xF
    /* AFE1C 800BF61C 40180300 */  sll        $v1, $v1, 1
    /* AFE20 800BF620 21186200 */  addu       $v1, $v1, $v0
    /* AFE24 800BF624 00006284 */  lh         $v0, 0x0($v1)
    /* AFE28 800BF628 00000000 */  nop
    /* AFE2C 800BF62C 0E004010 */  beqz       $v0, .L800BF668
    /* AFE30 800BF630 1280023C */   lui       $v0, %hi(DrawC_HeadLightFlash)
    /* AFE34 800BF634 B4084296 */  lhu        $v0, 0x8B4($s2)
    /* AFE38 800BF638 00000000 */  nop
    /* AFE3C 800BF63C 40004230 */  andi       $v0, $v0, 0x40
    /* AFE40 800BF640 07004014 */  bnez       $v0, .L800BF660
    /* AFE44 800BF644 8100A234 */   ori       $v0, $a1, 0x81
    /* AFE48 800BF648 08F5C294 */  lhu        $v0, %lo(DrawC_gOverlay)($a2)
    /* AFE4C 800BF64C 00000000 */  nop
    /* AFE50 800BF650 01004230 */  andi       $v0, $v0, 0x1
    /* AFE54 800BF654 04004014 */  bnez       $v0, .L800BF668
    /* AFE58 800BF658 1280023C */   lui       $v0, %hi(DrawC_HeadLightFlash)
    /* AFE5C 800BF65C 8100A234 */  ori        $v0, $a1, 0x81
  .L800BF660:
    /* AFE60 800BF660 3A0082A4 */  sh         $v0, 0x3A($a0)
    /* AFE64 800BF664 1280023C */  lui        $v0, %hi(DrawC_HeadLightFlash)
  .L800BF668:
    /* AFE68 800BF668 BA084396 */  lhu        $v1, 0x8BA($s2)
    /* AFE6C 800BF66C 74F44224 */  addiu      $v0, $v0, %lo(DrawC_HeadLightFlash)
    /* AFE70 800BF670 0F006330 */  andi       $v1, $v1, 0xF
    /* AFE74 800BF674 40180300 */  sll        $v1, $v1, 1
    /* AFE78 800BF678 21186200 */  addu       $v1, $v1, $v0
    /* AFE7C 800BF67C 00006284 */  lh         $v0, 0x0($v1)
    /* AFE80 800BF680 00000000 */  nop
    /* AFE84 800BF684 13004010 */  beqz       $v0, .L800BF6D4
    /* AFE88 800BF688 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFE8C 800BF68C B4084296 */  lhu        $v0, 0x8B4($s2)
    /* AFE90 800BF690 00000000 */  nop
    /* AFE94 800BF694 04004230 */  andi       $v0, $v0, 0x4
    /* AFE98 800BF698 08004014 */  bnez       $v0, .L800BF6BC
    /* AFE9C 800BF69C 1280033C */   lui       $v1, %hi(DrawC_gOverlay)
    /* AFEA0 800BF6A0 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
    /* AFEA4 800BF6A4 08F54294 */  lhu        $v0, %lo(DrawC_gOverlay)($v0)
    /* AFEA8 800BF6A8 00000000 */  nop
    /* AFEAC 800BF6AC 00014230 */  andi       $v0, $v0, 0x100
    /* AFEB0 800BF6B0 08004014 */  bnez       $v0, .L800BF6D4
    /* AFEB4 800BF6B4 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFEB8 800BF6B8 1280033C */  lui        $v1, %hi(DrawC_gOverlay)
  .L800BF6BC:
    /* AFEBC 800BF6BC 08F56324 */  addiu      $v1, $v1, %lo(DrawC_gOverlay)
    /* AFEC0 800BF6C0 3A006294 */  lhu        $v0, 0x3A($v1)
    /* AFEC4 800BF6C4 00000000 */  nop
    /* AFEC8 800BF6C8 00814234 */  ori        $v0, $v0, 0x8100
    /* AFECC 800BF6CC 3A0062A4 */  sh         $v0, 0x3A($v1)
    /* AFED0 800BF6D0 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
  .L800BF6D4:
    /* AFED4 800BF6D4 08F54424 */  addiu      $a0, $v0, %lo(DrawC_gOverlay)
    /* AFED8 800BF6D8 02008294 */  lhu        $v0, 0x2($a0)
    /* AFEDC 800BF6DC 00000000 */  nop
    /* AFEE0 800BF6E0 01004230 */  andi       $v0, $v0, 0x1
    /* AFEE4 800BF6E4 20004014 */  bnez       $v0, .L800BF768
    /* AFEE8 800BF6E8 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFEEC 800BF6EC 1280023C */  lui        $v0, %hi(DrawC_TailLightFlash)
    /* AFEF0 800BF6F0 B8084396 */  lhu        $v1, 0x8B8($s2)
    /* AFEF4 800BF6F4 94F44224 */  addiu      $v0, $v0, %lo(DrawC_TailLightFlash)
    /* AFEF8 800BF6F8 0F006330 */  andi       $v1, $v1, 0xF
    /* AFEFC 800BF6FC 40180300 */  sll        $v1, $v1, 1
    /* AFF00 800BF700 21186200 */  addu       $v1, $v1, $v0
    /* AFF04 800BF704 00006284 */  lh         $v0, 0x0($v1)
    /* AFF08 800BF708 00000000 */  nop
    /* AFF0C 800BF70C 08004010 */  beqz       $v0, .L800BF730
    /* AFF10 800BF710 1280023C */   lui       $v0, %hi(DrawC_HeadLightFlash)
    /* AFF14 800BF714 30008294 */  lhu        $v0, 0x30($a0)
    /* AFF18 800BF718 32008394 */  lhu        $v1, 0x32($a0)
    /* AFF1C 800BF71C 80004234 */  ori        $v0, $v0, 0x80
    /* AFF20 800BF720 80006334 */  ori        $v1, $v1, 0x80
    /* AFF24 800BF724 300082A4 */  sh         $v0, 0x30($a0)
    /* AFF28 800BF728 320083A4 */  sh         $v1, 0x32($a0)
    /* AFF2C 800BF72C 1280023C */  lui        $v0, %hi(DrawC_HeadLightFlash)
  .L800BF730:
    /* AFF30 800BF730 B8084396 */  lhu        $v1, 0x8B8($s2)
    /* AFF34 800BF734 74F44224 */  addiu      $v0, $v0, %lo(DrawC_HeadLightFlash)
    /* AFF38 800BF738 0F006330 */  andi       $v1, $v1, 0xF
    /* AFF3C 800BF73C 40180300 */  sll        $v1, $v1, 1
    /* AFF40 800BF740 21186200 */  addu       $v1, $v1, $v0
    /* AFF44 800BF744 00006284 */  lh         $v0, 0x0($v1)
    /* AFF48 800BF748 00000000 */  nop
    /* AFF4C 800BF74C 06004010 */  beqz       $v0, .L800BF768
    /* AFF50 800BF750 1280023C */   lui       $v0, %hi(DrawC_gOverlay)
    /* AFF54 800BF754 34008294 */  lhu        $v0, 0x34($a0)
    /* AFF58 800BF758 00000000 */  nop
    /* AFF5C 800BF75C 80004234 */  ori        $v0, $v0, 0x80
    /* AFF60 800BF760 340082A4 */  sh         $v0, 0x34($a0)
    /* AFF64 800BF764 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
  .L800BF768:
    /* AFF68 800BF768 08F54524 */  addiu      $a1, $v0, %lo(DrawC_gOverlay)
    /* AFF6C 800BF76C 0200A294 */  lhu        $v0, 0x2($a1)
    /* AFF70 800BF770 00000000 */  nop
    /* AFF74 800BF774 00014230 */  andi       $v0, $v0, 0x100
    /* AFF78 800BF778 20004014 */  bnez       $v0, .L800BF7FC
    /* AFF7C 800BF77C 1800A427 */   addiu     $a0, $sp, 0x18
    /* AFF80 800BF780 1280023C */  lui        $v0, %hi(DrawC_TailLightFlash)
    /* AFF84 800BF784 BA084396 */  lhu        $v1, 0x8BA($s2)
    /* AFF88 800BF788 94F44224 */  addiu      $v0, $v0, %lo(DrawC_TailLightFlash)
    /* AFF8C 800BF78C 0F006330 */  andi       $v1, $v1, 0xF
    /* AFF90 800BF790 40180300 */  sll        $v1, $v1, 1
    /* AFF94 800BF794 21186200 */  addu       $v1, $v1, $v0
    /* AFF98 800BF798 00006284 */  lh         $v0, 0x0($v1)
    /* AFF9C 800BF79C 00000000 */  nop
    /* AFFA0 800BF7A0 07004010 */  beqz       $v0, .L800BF7C0
    /* AFFA4 800BF7A4 00800224 */   addiu     $v0, $zero, -0x8000
    /* AFFA8 800BF7A8 3000A394 */  lhu        $v1, 0x30($a1)
    /* AFFAC 800BF7AC 3200A494 */  lhu        $a0, 0x32($a1)
    /* AFFB0 800BF7B0 25186200 */  or         $v1, $v1, $v0
    /* AFFB4 800BF7B4 25208200 */  or         $a0, $a0, $v0
    /* AFFB8 800BF7B8 3000A3A4 */  sh         $v1, 0x30($a1)
    /* AFFBC 800BF7BC 3200A4A4 */  sh         $a0, 0x32($a1)
  .L800BF7C0:
    /* AFFC0 800BF7C0 1280023C */  lui        $v0, %hi(DrawC_HeadLightFlash)
    /* AFFC4 800BF7C4 BA084396 */  lhu        $v1, 0x8BA($s2)
    /* AFFC8 800BF7C8 74F44224 */  addiu      $v0, $v0, %lo(DrawC_HeadLightFlash)
    /* AFFCC 800BF7CC 0F006330 */  andi       $v1, $v1, 0xF
    /* AFFD0 800BF7D0 40180300 */  sll        $v1, $v1, 1
    /* AFFD4 800BF7D4 21186200 */  addu       $v1, $v1, $v0
    /* AFFD8 800BF7D8 00006284 */  lh         $v0, 0x0($v1)
    /* AFFDC 800BF7DC 00000000 */  nop
    /* AFFE0 800BF7E0 06004010 */  beqz       $v0, .L800BF7FC
    /* AFFE4 800BF7E4 1800A427 */   addiu     $a0, $sp, 0x18
    /* AFFE8 800BF7E8 3400A294 */  lhu        $v0, 0x34($a1)
    /* AFFEC 800BF7EC 00000000 */  nop
    /* AFFF0 800BF7F0 00804234 */  ori        $v0, $v0, 0x8000
    /* AFFF4 800BF7F4 3400A2A4 */  sh         $v0, 0x34($a1)
  .L800BF7F8:
    /* AFFF8 800BF7F8 1800A427 */  addiu      $a0, $sp, 0x18
  .L800BF7FC:
    /* AFFFC 800BF7FC 1280103C */  lui        $s0, %hi(DrawC_gMatA)
    /* B0000 800BF800 E8F41026 */  addiu      $s0, $s0, %lo(DrawC_gMatA)
    /* B0004 800BF804 1480023C */  lui        $v0, %hi(R3DCar_yawCam)
    /* B0008 800BF808 A4D34294 */  lhu        $v0, %lo(R3DCar_yawCam)($v0)
    /* B000C 800BF80C 21280002 */  addu       $a1, $s0, $zero
    /* B0010 800BF810 1800A0A7 */  sh         $zero, 0x18($sp)
    /* B0014 800BF814 1C00A0A7 */  sh         $zero, 0x1C($sp)
    /* B0018 800BF818 4BC9030C */  jal        RotMatrix
    /* B001C 800BF81C 1A00A2A7 */   sh        $v0, 0x1A($sp)
    /* B0020 800BF820 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* B0024 800BF824 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* B0028 800BF828 1C0000AE */  sw         $zero, 0x1C($s0)
    /* B002C 800BF82C 180000AE */  sw         $zero, 0x18($s0)
    /* B0030 800BF830 140000AE */  sw         $zero, 0x14($s0)
    /* B0034 800BF834 C41280AF */  sw         $zero, %gp_rel(DrawC_gWetRoad)($gp)
    /* B0038 800BF838 AE004014 */  bnez       $v0, .L800BFAF4
    /* B003C 800BF83C 1180023C */   lui       $v0, %hi(gCView)
    /* B0040 800BF840 7C6F448C */  lw         $a0, %lo(gCView)($v0)
    /* B0044 800BF844 1480053C */  lui        $a1, %hi(gFlip)
    /* B0048 800BF848 B4D7A58C */  lw         $a1, %lo(gFlip)($a1)
    /* B004C 800BF84C 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* B0050 800BF850 03001624 */   addiu     $s6, $zero, 0x3
    /* B0054 800BF854 21A04000 */  addu       $s4, $v0, $zero
    /* B0058 800BF858 CA004386 */  lh         $v1, 0xCA($s2)
    /* B005C 800BF85C CC004586 */  lh         $a1, 0xCC($s2)
    /* B0060 800BF860 7C004782 */  lb         $a3, 0x7C($s2)
    /* B0064 800BF864 40200300 */  sll        $a0, $v1, 1
    /* B0068 800BF868 21208300 */  addu       $a0, $a0, $v1
    /* B006C 800BF86C A412838F */  lw         $v1, %gp_rel(DrawC_gEnvMap)($gp)
    /* B0070 800BF870 40200400 */  sll        $a0, $a0, 1
    /* B0074 800BF874 21208300 */  addu       $a0, $a0, $v1
    /* B0078 800BF878 40180500 */  sll        $v1, $a1, 1
    /* B007C 800BF87C 21186500 */  addu       $v1, $v1, $a1
    /* B0080 800BF880 40180300 */  sll        $v1, $v1, 1
    /* B0084 800BF884 02008694 */  lhu        $a2, 0x2($a0)
    /* B0088 800BF888 A812858F */  lw         $a1, %gp_rel(DrawC_gShadow)($gp)
    /* B008C 800BF88C 04008494 */  lhu        $a0, 0x4($a0)
    /* B0090 800BF890 21186500 */  addu       $v1, $v1, $a1
    /* B0094 800BF894 FF008230 */  andi       $v0, $a0, 0xFF
    /* B0098 800BF898 2A10E200 */  slt        $v0, $a3, $v0
    /* B009C 800BF89C 02006594 */  lhu        $a1, 0x2($v1)
    /* B00A0 800BF8A0 04006394 */  lhu        $v1, 0x4($v1)
    /* B00A4 800BF8A4 03004010 */  beqz       $v0, .L800BF8B4
    /* B00A8 800BF8A8 02001524 */   addiu     $s5, $zero, 0x2
    /* B00AC 800BF8AC 00140400 */  sll        $v0, $a0, 16
    /* B00B0 800BF8B0 03360200 */  sra        $a2, $v0, 24
  .L800BF8B4:
    /* B00B4 800BF8B4 FF006230 */  andi       $v0, $v1, 0xFF
    /* B00B8 800BF8B8 2A10E200 */  slt        $v0, $a3, $v0
    /* B00BC 800BF8BC 02004010 */  beqz       $v0, .L800BF8C8
    /* B00C0 800BF8C0 00140300 */   sll       $v0, $v1, 16
    /* B00C4 800BF8C4 032E0200 */  sra        $a1, $v0, 24
  .L800BF8C8:
    /* B00C8 800BF8C8 00140600 */  sll        $v0, $a2, 16
    /* B00CC 800BF8CC 03140200 */  sra        $v0, $v0, 16
    /* B00D0 800BF8D0 0B004228 */  slti       $v0, $v0, 0xB
    /* B00D4 800BF8D4 03004014 */  bnez       $v0, .L800BF8E4
    /* B00D8 800BF8D8 00140500 */   sll       $v0, $a1, 16
    /* B00DC 800BF8DC F6FFC624 */  addiu      $a2, $a2, -0xA
    /* B00E0 800BF8E0 01001724 */  addiu      $s7, $zero, 0x1
  .L800BF8E4:
    /* B00E4 800BF8E4 03004104 */  bgez       $v0, .L800BF8F4
    /* B00E8 800BF8E8 FFFFC324 */   addiu     $v1, $a2, -0x1
    /* B00EC 800BF8EC 21B00000 */  addu       $s6, $zero, $zero
    /* B00F0 800BF8F0 23280500 */  negu       $a1, $a1
  .L800BF8F4:
    /* B00F4 800BF8F4 00140500 */  sll        $v0, $a1, 16
    /* B00F8 800BF8F8 03140200 */  sra        $v0, $v0, 16
    /* B00FC 800BF8FC 0B004228 */  slti       $v0, $v0, 0xB
    /* B0100 800BF900 03004014 */  bnez       $v0, .L800BF910
    /* B0104 800BF904 00140300 */   sll       $v0, $v1, 16
    /* B0108 800BF908 F6FFA524 */  addiu      $a1, $a1, -0xA
    /* B010C 800BF90C 01001524 */  addiu      $s5, $zero, 0x1
  .L800BF910:
    /* B0110 800BF910 03140200 */  sra        $v0, $v0, 16
    /* B0114 800BF914 03004104 */  bgez       $v0, .L800BF924
    /* B0118 800BF918 FFFFA524 */   addiu     $a1, $a1, -0x1
    /* B011C 800BF91C 5DFE0208 */  j          .L800BF974
    /* B0120 800BF920 640060AE */   sw        $zero, 0x64($s3)
  .L800BF924:
    /* B0124 800BF924 1280033C */  lui        $v1, %hi(Track_gReflectionMaps)
    /* B0128 800BF928 70E16324 */  addiu      $v1, $v1, %lo(Track_gReflectionMaps)
    /* B012C 800BF92C 00110200 */  sll        $v0, $v0, 4
    /* B0130 800BF930 21104300 */  addu       $v0, $v0, $v1
    /* B0134 800BF934 03004A88 */  lwl        $t2, 0x3($v0)
    /* B0138 800BF938 00004A98 */  lwr        $t2, 0x0($v0)
    /* B013C 800BF93C 07004B88 */  lwl        $t3, 0x7($v0)
    /* B0140 800BF940 04004B98 */  lwr        $t3, 0x4($v0)
    /* B0144 800BF944 0B004888 */  lwl        $t0, 0xB($v0)
    /* B0148 800BF948 08004898 */  lwr        $t0, 0x8($v0)
    /* B014C 800BF94C 0F004988 */  lwl        $t1, 0xF($v0)
    /* B0150 800BF950 0C004998 */  lwr        $t1, 0xC($v0)
    /* B0154 800BF954 67006AAA */  swl        $t2, 0x67($s3)
    /* B0158 800BF958 64006ABA */  swr        $t2, 0x64($s3)
    /* B015C 800BF95C 6B006BAA */  swl        $t3, 0x6B($s3)
    /* B0160 800BF960 68006BBA */  swr        $t3, 0x68($s3)
    /* B0164 800BF964 6F0068AA */  swl        $t0, 0x6F($s3)
    /* B0168 800BF968 6C0068BA */  swr        $t0, 0x6C($s3)
    /* B016C 800BF96C 730069AA */  swl        $t1, 0x73($s3)
    /* B0170 800BF970 700069BA */  swr        $t1, 0x70($s3)
  .L800BF974:
    /* B0174 800BF974 00140500 */  sll        $v0, $a1, 16
    /* B0178 800BF978 03840200 */  sra        $s0, $v0, 16
    /* B017C 800BF97C 03000106 */  bgez       $s0, .L800BF98C
    /* B0180 800BF980 48006426 */   addiu     $a0, $s3, 0x48
    /* B0184 800BF984 92FE0208 */  j          .L800BFA48
    /* B0188 800BF988 740060AE */   sw        $zero, 0x74($s3)
  .L800BF98C:
    /* B018C 800BF98C 1280023C */  lui        $v0, %hi(Track_gReflectionMaps)
    /* B0190 800BF990 70E14224 */  addiu      $v0, $v0, %lo(Track_gReflectionMaps)
    /* B0194 800BF994 00811000 */  sll        $s0, $s0, 4
    /* B0198 800BF998 21800202 */  addu       $s0, $s0, $v0
    /* B019C 800BF99C 00000292 */  lbu        $v0, 0x0($s0)
    /* B01A0 800BF9A0 21300000 */  addu       $a2, $zero, $zero
    /* B01A4 800BF9A4 1800A2A7 */  sh         $v0, 0x18($sp)
    /* B01A8 800BF9A8 01000392 */  lbu        $v1, 0x1($s0)
    /* B01AC 800BF9AC 80000224 */  addiu      $v0, $zero, 0x80
    /* B01B0 800BF9B0 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* B01B4 800BF9B4 40000224 */  addiu      $v0, $zero, 0x40
    /* B01B8 800BF9B8 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* B01BC 800BF9BC 1A00A3A7 */  sh         $v1, 0x1A($sp)
    /* B01C0 800BF9C0 17008592 */  lbu        $a1, 0x17($s4)
    /* B01C4 800BF9C4 06000796 */  lhu        $a3, 0x6($s0)
    /* B01C8 800BF9C8 1800B127 */  addiu      $s1, $sp, 0x18
    /* B01CC 800BF9CC EFB8030C */  jal        SetDrawMode
    /* B01D0 800BF9D0 1000B1AF */   sw        $s1, 0x10($sp)
    /* B01D4 800BF9D4 54006426 */  addiu      $a0, $s3, 0x54
    /* B01D8 800BF9D8 1E00A0A7 */  sh         $zero, 0x1E($sp)
    /* B01DC 800BF9DC 1C00A0A7 */  sh         $zero, 0x1C($sp)
    /* B01E0 800BF9E0 1A00A0A7 */  sh         $zero, 0x1A($sp)
    /* B01E4 800BF9E4 1800A0A7 */  sh         $zero, 0x18($sp)
    /* B01E8 800BF9E8 17008592 */  lbu        $a1, 0x17($s4)
    /* B01EC 800BF9EC 14008796 */  lhu        $a3, 0x14($s4)
    /* B01F0 800BF9F0 21300000 */  addu       $a2, $zero, $zero
    /* B01F4 800BF9F4 EFB8030C */  jal        SetDrawMode
    /* B01F8 800BF9F8 1000B1AF */   sw        $s1, 0x10($sp)
    /* B01FC 800BF9FC 7A006426 */  addiu      $a0, $s3, 0x7A
    /* B0200 800BFA00 03000A8A */  lwl        $t2, 0x3($s0)
    /* B0204 800BFA04 00000A9A */  lwr        $t2, 0x0($s0)
    /* B0208 800BFA08 07000B8A */  lwl        $t3, 0x7($s0)
    /* B020C 800BFA0C 04000B9A */  lwr        $t3, 0x4($s0)
    /* B0210 800BFA10 0B00088A */  lwl        $t0, 0xB($s0)
    /* B0214 800BFA14 0800089A */  lwr        $t0, 0x8($s0)
    /* B0218 800BFA18 0F00098A */  lwl        $t1, 0xF($s0)
    /* B021C 800BFA1C 0C00099A */  lwr        $t1, 0xC($s0)
    /* B0220 800BFA20 77006AAA */  swl        $t2, 0x77($s3)
    /* B0224 800BFA24 74006ABA */  swr        $t2, 0x74($s3)
    /* B0228 800BFA28 7B006BAA */  swl        $t3, 0x7B($s3)
    /* B022C 800BFA2C 78006BBA */  swr        $t3, 0x78($s3)
    /* B0230 800BFA30 7F0068AA */  swl        $t0, 0x7F($s3)
    /* B0234 800BFA34 7C0068BA */  swr        $t0, 0x7C($s3)
    /* B0238 800BFA38 830069AA */  swl        $t1, 0x83($s3)
    /* B023C 800BFA3C 800069BA */  swr        $t1, 0x80($s3)
    /* B0240 800BFA40 B4F9020C */  jal        ChangeTPage__FPUsi
    /* B0244 800BFA44 2128A002 */   addu      $a1, $s5, $zero
  .L800BFA48:
    /* B0248 800BFA48 0300C426 */  addiu      $a0, $s6, 0x3
    /* B024C 800BFA4C C8004386 */  lh         $v1, 0xC8($s2)
    /* B0250 800BFA50 75006292 */  lbu        $v0, 0x75($s3)
    /* B0254 800BFA54 07188300 */  srav       $v1, $v1, $a0
    /* B0258 800BFA58 82110200 */  srl        $v0, $v0, 6
    /* B025C 800BFA5C 40100200 */  sll        $v0, $v0, 1
    /* B0260 800BFA60 1480043C */  lui        $a0, %hi(DrawC_gEnvMapOffset)
    /* B0264 800BFA64 C8D78424 */  addiu      $a0, $a0, %lo(DrawC_gEnvMapOffset)
    /* B0268 800BFA68 21104400 */  addu       $v0, $v0, $a0
    /* B026C 800BFA6C 00004284 */  lh         $v0, 0x0($v0)
    /* B0270 800BFA70 3F006330 */  andi       $v1, $v1, 0x3F
    /* B0274 800BFA74 21186200 */  addu       $v1, $v1, $v0
    /* B0278 800BFA78 1180023C */  lui        $v0, %hi(D_80113234)
    /* B027C 800BFA7C 840063AE */  sw         $v1, 0x84($s3)
    /* B0280 800BFA80 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* B0284 800BFA84 00000000 */  nop
    /* B0288 800BFA88 0F004010 */  beqz       $v0, .L800BFAC8
    /* B028C 800BFA8C 00000000 */   nop
    /* B0290 800BFA90 F5FF010C */  jal        BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* B0294 800BFA94 08004426 */   addiu     $a0, $s2, 0x8
    /* B0298 800BFA98 01004238 */  xori       $v0, $v0, 0x1
    /* B029C 800BFA9C 0A004010 */  beqz       $v0, .L800BFAC8
    /* B02A0 800BFAA0 1180023C */   lui       $v0, %hi(Cars_kSkidMarkSurface)
    /* B02A4 800BFAA4 C001438E */  lw         $v1, 0x1C0($s2)
    /* B02A8 800BFAA8 C0F84224 */  addiu      $v0, $v0, %lo(Cars_kSkidMarkSurface)
    /* B02AC 800BFAAC 80180300 */  sll        $v1, $v1, 2
    /* B02B0 800BFAB0 21186200 */  addu       $v1, $v1, $v0
    /* B02B4 800BFAB4 0000638C */  lw         $v1, 0x0($v1)
    /* B02B8 800BFAB8 01000224 */  addiu      $v0, $zero, 0x1
    /* B02BC 800BFABC 02006214 */  bne        $v1, $v0, .L800BFAC8
    /* B02C0 800BFAC0 00000000 */   nop
    /* B02C4 800BFAC4 C41283AF */  sw         $v1, %gp_rel(DrawC_gWetRoad)($gp)
  .L800BFAC8:
    /* B02C8 800BFAC8 3801428E */  lw         $v0, 0x138($s2)
    /* B02CC 800BFACC 00000000 */  nop
    /* B02D0 800BFAD0 40180200 */  sll        $v1, $v0, 1
    /* B02D4 800BFAD4 21186200 */  addu       $v1, $v1, $v0
    /* B02D8 800BFAD8 8801428E */  lw         $v0, 0x188($s2)
    /* B02DC 800BFADC 43180300 */  sra        $v1, $v1, 1
    /* B02E0 800BFAE0 21186200 */  addu       $v1, $v1, $v0
    /* B02E4 800BFAE4 031A0300 */  sra        $v1, $v1, 8
    /* B02E8 800BFAE8 C81283A7 */  sh         $v1, %gp_rel(DrawC_gReflectOffset)($gp)
    /* B02EC 800BFAEC E3FE0208 */  j          .L800BFB8C
    /* B02F0 800BFAF0 6A006426 */   addiu     $a0, $s3, 0x6A
  .L800BFAF4:
    /* B02F4 800BFAF4 7C6F448C */  lw         $a0, %lo(gCView)($v0)
    /* B02F8 800BFAF8 1480053C */  lui        $a1, %hi(gFlip)
    /* B02FC 800BFAFC B4D7A58C */  lw         $a1, %lo(gFlip)($a1)
    /* B0300 800BFB00 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* B0304 800BFB04 00000000 */   nop
    /* B0308 800BFB08 48006426 */  addiu      $a0, $s3, 0x48
    /* B030C 800BFB0C 21804000 */  addu       $s0, $v0, $zero
    /* B0310 800BFB10 17000592 */  lbu        $a1, 0x17($s0)
    /* B0314 800BFB14 14000796 */  lhu        $a3, 0x14($s0)
    /* B0318 800BFB18 01000624 */  addiu      $a2, $zero, 0x1
    /* B031C 800BFB1C EFB8030C */  jal        SetDrawMode
    /* B0320 800BFB20 1000A0AF */   sw        $zero, 0x10($sp)
    /* B0324 800BFB24 54006426 */  addiu      $a0, $s3, 0x54
    /* B0328 800BFB28 17000592 */  lbu        $a1, 0x17($s0)
    /* B032C 800BFB2C 14000796 */  lhu        $a3, 0x14($s0)
    /* B0330 800BFB30 21300000 */  addu       $a2, $zero, $zero
    /* B0334 800BFB34 EFB8030C */  jal        SetDrawMode
    /* B0338 800BFB38 1000A0AF */   sw        $zero, 0x10($sp)
    /* B033C 800BFB3C 1280023C */  lui        $v0, %hi(gMenuPixmap)
    /* B0340 800BFB40 D00F428C */  lw         $v0, %lo(gMenuPixmap)($v0)
    /* B0344 800BFB44 00000000 */  nop
    /* B0348 800BFB48 03004A88 */  lwl        $t2, 0x3($v0)
    /* B034C 800BFB4C 00004A98 */  lwr        $t2, 0x0($v0)
    /* B0350 800BFB50 07004B88 */  lwl        $t3, 0x7($v0)
    /* B0354 800BFB54 04004B98 */  lwr        $t3, 0x4($v0)
    /* B0358 800BFB58 0B004888 */  lwl        $t0, 0xB($v0)
    /* B035C 800BFB5C 08004898 */  lwr        $t0, 0x8($v0)
    /* B0360 800BFB60 0F004988 */  lwl        $t1, 0xF($v0)
    /* B0364 800BFB64 0C004998 */  lwr        $t1, 0xC($v0)
    /* B0368 800BFB68 67006AAA */  swl        $t2, 0x67($s3)
    /* B036C 800BFB6C 64006ABA */  swr        $t2, 0x64($s3)
    /* B0370 800BFB70 6B006BAA */  swl        $t3, 0x6B($s3)
    /* B0374 800BFB74 68006BBA */  swr        $t3, 0x68($s3)
    /* B0378 800BFB78 6F0068AA */  swl        $t0, 0x6F($s3)
    /* B037C 800BFB7C 6C0068BA */  swr        $t0, 0x6C($s3)
    /* B0380 800BFB80 730069AA */  swl        $t1, 0x73($s3)
    /* B0384 800BFB84 700069BA */  swr        $t1, 0x70($s3)
    /* B0388 800BFB88 6A006426 */  addiu      $a0, $s3, 0x6A
  .L800BFB8C:
    /* B038C 800BFB8C B4F9020C */  jal        ChangeTPage__FPUsi
    /* B0390 800BFB90 01000524 */   addiu     $a1, $zero, 0x1
    /* B0394 800BFB94 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* B0398 800BFB98 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* B039C 800BFB9C 00000000 */  nop
    /* B03A0 800BFBA0 18004014 */  bnez       $v0, .L800BFC04
    /* B03A4 800BFBA4 83301E00 */   sra       $a2, $fp, 2
    /* B03A8 800BFBA8 1480023C */  lui        $v0, %hi(R3DCar_eMapColour)
    /* B03AC 800BFBAC A0D34290 */  lbu        $v0, %lo(R3DCar_eMapColour)($v0)
    /* B03B0 800BFBB0 00000000 */  nop
    /* B03B4 800BFBB4 1800C200 */  mult       $a2, $v0
    /* B03B8 800BFBB8 12400000 */  mflo       $t0
    /* B03BC 800BFBBC 0800E012 */  beqz       $s7, .L800BFBE0
    /* B03C0 800BFBC0 C3310800 */   sra       $a2, $t0, 7
    /* B03C4 800BFBC4 5555033C */  lui        $v1, (0x55555556 >> 16)
    /* B03C8 800BFBC8 56556334 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* B03CC 800BFBCC 40100600 */  sll        $v0, $a2, 1
    /* B03D0 800BFBD0 18004300 */  mult       $v0, $v1
    /* B03D4 800BFBD4 C3170200 */  sra        $v0, $v0, 31
    /* B03D8 800BFBD8 10400000 */  mfhi       $t0
    /* B03DC 800BFBDC 23300201 */  subu       $a2, $t0, $v0
  .L800BFBE0:
    /* B03E0 800BFBE0 40100600 */  sll        $v0, $a2, 1
    /* B03E4 800BFBE4 21104600 */  addu       $v0, $v0, $a2
    /* B03E8 800BFBE8 83100200 */  sra        $v0, $v0, 2
    /* B03EC 800BFBEC 001C0200 */  sll        $v1, $v0, 16
    /* B03F0 800BFBF0 00220200 */  sll        $a0, $v0, 8
    /* B03F4 800BFBF4 21186400 */  addu       $v1, $v1, $a0
    /* B03F8 800BFBF8 21186200 */  addu       $v1, $v1, $v0
    /* B03FC 800BFBFC 02FF0208 */  j          .L800BFC08
    /* B0400 800BFC00 980063AE */   sw        $v1, 0x98($s3)
  .L800BFC04:
    /* B0404 800BFC04 43301E00 */  sra        $a2, $fp, 1
  .L800BFC08:
    /* B0408 800BFC08 00140600 */  sll        $v0, $a2, 16
    /* B040C 800BFC0C 001A0600 */  sll        $v1, $a2, 8
    /* B0410 800BFC10 21104300 */  addu       $v0, $v0, $v1
    /* B0414 800BFC14 21104600 */  addu       $v0, $v0, $a2
    /* B0418 800BFC18 900062AE */  sw         $v0, 0x90($s3)
    /* B041C 800BFC1C BC084386 */  lh         $v1, 0x8BC($s2)
    /* B0420 800BFC20 01000224 */  addiu      $v0, $zero, 0x1
    /* B0424 800BFC24 03006214 */  bne        $v1, $v0, .L800BFC34
    /* B0428 800BFC28 40100600 */   sll       $v0, $a2, 1
    /* B042C 800BFC2C 0FFF0208 */  j          .L800BFC3C
    /* B0430 800BFC30 83300600 */   sra       $a2, $a2, 2
  .L800BFC34:
    /* B0434 800BFC34 21104600 */  addu       $v0, $v0, $a2
    /* B0438 800BFC38 83300200 */  sra        $a2, $v0, 2
  .L800BFC3C:
    /* B043C 800BFC3C 00140600 */  sll        $v0, $a2, 16
    /* B0440 800BFC40 001A0600 */  sll        $v1, $a2, 8
    /* B0444 800BFC44 21104300 */  addu       $v0, $v0, $v1
    /* B0448 800BFC48 21104600 */  addu       $v0, $v0, $a2
    /* B044C 800BFC4C 940062AE */  sw         $v0, 0x94($s3)
    /* B0450 800BFC50 6408428E */  lw         $v0, 0x864($s2)
  .L800BFC54:
    /* B0454 800BFC54 4400BF8F */  lw         $ra, 0x44($sp)
    /* B0458 800BFC58 4000BE8F */  lw         $fp, 0x40($sp)
    /* B045C 800BFC5C 3C00B78F */  lw         $s7, 0x3C($sp)
    /* B0460 800BFC60 3800B68F */  lw         $s6, 0x38($sp)
    /* B0464 800BFC64 3400B58F */  lw         $s5, 0x34($sp)
    /* B0468 800BFC68 3000B48F */  lw         $s4, 0x30($sp)
    /* B046C 800BFC6C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* B0470 800BFC70 2800B28F */  lw         $s2, 0x28($sp)
    /* B0474 800BFC74 2400B18F */  lw         $s1, 0x24($sp)
    /* B0478 800BFC78 2000B08F */  lw         $s0, 0x20($sp)
    /* B047C 800BFC7C 0800E003 */  jr         $ra
    /* B0480 800BFC80 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
