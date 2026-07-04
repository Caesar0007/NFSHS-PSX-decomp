.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache, 0x15B4

glabel DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
    /* B0544 800BFD44 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* B0548 800BFD48 1400B1AF */  sw         $s1, 0x14($sp)
    /* B054C 800BFD4C 4C00B18F */  lw         $s1, 0x4C($sp)
    /* B0550 800BFD50 1800B2AF */  sw         $s2, 0x18($sp)
    /* B0554 800BFD54 4800B28F */  lw         $s2, 0x48($sp)
    /* B0558 800BFD58 1000B0AF */  sw         $s0, 0x10($sp)
    /* B055C 800BFD5C 21808000 */  addu       $s0, $a0, $zero
    /* B0560 800BFD60 2000B4AF */  sw         $s4, 0x20($sp)
    /* B0564 800BFD64 21A0A000 */  addu       $s4, $a1, $zero
    /* B0568 800BFD68 2400B5AF */  sw         $s5, 0x24($sp)
    /* B056C 800BFD6C 21A8C000 */  addu       $s5, $a2, $zero
    /* B0570 800BFD70 2800B6AF */  sw         $s6, 0x28($sp)
    /* B0574 800BFD74 3000BFAF */  sw         $ra, 0x30($sp)
    /* B0578 800BFD78 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* B057C 800BFD7C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* B0580 800BFD80 6400228E */  lw         $v0, 0x64($s1)
    /* B0584 800BFD84 1400B38E */  lw         $s3, 0x14($s5)
    /* B0588 800BFD88 06004014 */  bnez       $v0, .L800BFDA4
    /* B058C 800BFD8C 21B0E000 */   addu      $s6, $a3, $zero
    /* B0590 800BFD90 7400228E */  lw         $v0, 0x74($s1)
    /* B0594 800BFD94 00000000 */  nop
    /* B0598 800BFD98 03004014 */  bnez       $v0, .L800BFDA8
    /* B059C 800BFD9C 01004232 */   andi      $v0, $s2, 0x1
    /* B05A0 800BFDA0 BE005232 */  andi       $s2, $s2, 0xBE
  .L800BFDA4:
    /* B05A4 800BFDA4 01004232 */  andi       $v0, $s2, 0x1
  .L800BFDA8:
    /* B05A8 800BFDA8 37004010 */  beqz       $v0, .L800BFE88
    /* B05AC 800BFDAC 21386002 */   addu      $a3, $s3, $zero
    /* B05B0 800BFDB0 1280173C */  lui        $s7, %hi(DrawC_gMatA)
    /* B05B4 800BFDB4 E8F4F726 */  addiu      $s7, $s7, %lo(DrawC_gMatA)
    /* B05B8 800BFDB8 0000EC8E */  lw         $t4, 0x0($s7)
    /* B05BC 800BFDBC 0400ED8E */  lw         $t5, 0x4($s7)
    /* B05C0 800BFDC0 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B05C4 800BFDC4 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B05C8 800BFDC8 0800EC8E */  lw         $t4, 0x8($s7)
    /* B05CC 800BFDCC 0C00ED8E */  lw         $t5, 0xC($s7)
    /* B05D0 800BFDD0 1000EE8E */  lw         $t6, 0x10($s7)
    /* B05D4 800BFDD4 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B05D8 800BFDD8 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B05DC 800BFDDC 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B05E0 800BFDE0 1280173C */  lui        $s7, %hi(DrawC_gMatA)
    /* B05E4 800BFDE4 E8F4F726 */  addiu      $s7, $s7, %lo(DrawC_gMatA)
    /* B05E8 800BFDE8 1400EC8E */  lw         $t4, 0x14($s7)
    /* B05EC 800BFDEC 1800ED8E */  lw         $t5, 0x18($s7)
    /* B05F0 800BFDF0 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B05F4 800BFDF4 1C00EE8E */  lw         $t6, 0x1C($s7)
    /* B05F8 800BFDF8 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B05FC 800BFDFC 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B0600 800BFE00 0000AA96 */  lhu        $t2, 0x0($s5)
    /* B0604 800BFE04 FFFF0B24 */  addiu      $t3, $zero, -0x1
    /* B0608 800BFE08 AC002926 */  addiu      $t1, $s1, 0xAC
    /* B060C 800BFE0C 9C002826 */  addiu      $t0, $s1, 0x9C
    /* B0610 800BFE10 D7002626 */  addiu      $a2, $s1, 0xD7
    /* B0614 800BFE14 04006526 */  addiu      $a1, $s3, 0x4
  .L800BFE18:
    /* B0618 800BFE18 FFFF4A25 */  addiu      $t2, $t2, -0x1
    /* B061C 800BFE1C 1A004B11 */  beq        $t2, $t3, .L800BFE88
    /* B0620 800BFE20 00000000 */   nop
    /* B0624 800BFE24 0000E294 */  lhu        $v0, 0x0($a3)
    /* B0628 800BFE28 FEFFA394 */  lhu        $v1, -0x2($a1)
    /* B062C 800BFE2C 0000A494 */  lhu        $a0, 0x0($a1)
    /* B0630 800BFE30 AC0022A6 */  sh         $v0, 0xAC($s1)
    /* B0634 800BFE34 AE0023A6 */  sh         $v1, 0xAE($s1)
    /* B0638 800BFE38 B00024A6 */  sh         $a0, 0xB0($s1)
    /* B063C 800BFE3C 000020C9 */  lwc2       $0, 0x0($t1)
    /* B0640 800BFE40 040021C9 */  lwc2       $1, 0x4($t1)
    /* B0644 800BFE44 00000000 */  nop
    /* B0648 800BFE48 00000000 */  nop
    /* B064C 800BFE4C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B0650 800BFE50 000019E9 */  swc2       $25, 0x0($t0)
    /* B0654 800BFE54 04001AE9 */  swc2       $26, 0x4($t0) /* handwritten instruction */
    /* B0658 800BFE58 08001BE9 */  swc2       $27, 0x8($t0) /* handwritten instruction */
    /* B065C 800BFE5C A400228E */  lw         $v0, 0xA4($s1)
    /* B0660 800BFE60 9C00238E */  lw         $v1, 0x9C($s1)
    /* B0664 800BFE64 02004104 */  bgez       $v0, .L800BFE70
    /* B0668 800BFE68 00000000 */   nop
    /* B066C 800BFE6C 23100200 */  negu       $v0, $v0
  .L800BFE70:
    /* B0670 800BFE70 0600A524 */  addiu      $a1, $a1, 0x6
    /* B0674 800BFE74 0600E724 */  addiu      $a3, $a3, 0x6
    /* B0678 800BFE78 FFFFC3A0 */  sb         $v1, -0x1($a2)
    /* B067C 800BFE7C 0000C2A0 */  sb         $v0, 0x0($a2)
    /* B0680 800BFE80 86FF0208 */  j          .L800BFE18
    /* B0684 800BFE84 0800C624 */   addiu     $a2, $a2, 0x8
  .L800BFE88:
    /* B0688 800BFE88 4B86030C */  jal        TrsProj_SetTransPrecision__Fi
    /* B068C 800BFE8C 08000424 */   addiu     $a0, $zero, 0x8
    /* B0690 800BFE90 0000028E */  lw         $v0, 0x0($s0)
    /* B0694 800BFE94 0C00038E */  lw         $v1, 0xC($s0)
    /* B0698 800BFE98 1800048E */  lw         $a0, 0x18($s0)
    /* B069C 800BFE9C 03110200 */  sra        $v0, $v0, 4
    /* B06A0 800BFEA0 03190300 */  sra        $v1, $v1, 4
    /* B06A4 800BFEA4 03210400 */  sra        $a0, $a0, 4
    /* B06A8 800BFEA8 140022A6 */  sh         $v0, 0x14($s1)
    /* B06AC 800BFEAC 160023A6 */  sh         $v1, 0x16($s1)
    /* B06B0 800BFEB0 180024A6 */  sh         $a0, 0x18($s1)
    /* B06B4 800BFEB4 0400028E */  lw         $v0, 0x4($s0)
    /* B06B8 800BFEB8 1000038E */  lw         $v1, 0x10($s0)
    /* B06BC 800BFEBC 1C00048E */  lw         $a0, 0x1C($s0)
    /* B06C0 800BFEC0 03110200 */  sra        $v0, $v0, 4
    /* B06C4 800BFEC4 03190300 */  sra        $v1, $v1, 4
    /* B06C8 800BFEC8 03210400 */  sra        $a0, $a0, 4
    /* B06CC 800BFECC 1A0022A6 */  sh         $v0, 0x1A($s1)
    /* B06D0 800BFED0 1C0023A6 */  sh         $v1, 0x1C($s1)
    /* B06D4 800BFED4 1E0024A6 */  sh         $a0, 0x1E($s1)
    /* B06D8 800BFED8 0800038E */  lw         $v1, 0x8($s0)
    /* B06DC 800BFEDC 1400048E */  lw         $a0, 0x14($s0)
    /* B06E0 800BFEE0 2000058E */  lw         $a1, 0x20($s0)
    /* B06E4 800BFEE4 23100200 */  negu       $v0, $v0
    /* B06E8 800BFEE8 1A0022A6 */  sh         $v0, 0x1A($s1)
    /* B06EC 800BFEEC 1C002296 */  lhu        $v0, 0x1C($s1)
    /* B06F0 800BFEF0 03190300 */  sra        $v1, $v1, 4
    /* B06F4 800BFEF4 03210400 */  sra        $a0, $a0, 4
    /* B06F8 800BFEF8 03290500 */  sra        $a1, $a1, 4
    /* B06FC 800BFEFC 200023A6 */  sh         $v1, 0x20($s1)
    /* B0700 800BFF00 1E002396 */  lhu        $v1, 0x1E($s1)
    /* B0704 800BFF04 23100200 */  negu       $v0, $v0
    /* B0708 800BFF08 220024A6 */  sh         $a0, 0x22($s1)
    /* B070C 800BFF0C 240025A6 */  sh         $a1, 0x24($s1)
    /* B0710 800BFF10 1C0022A6 */  sh         $v0, 0x1C($s1)
    /* B0714 800BFF14 23180300 */  negu       $v1, $v1
    /* B0718 800BFF18 1E0023A6 */  sh         $v1, 0x1E($s1)
    /* B071C 800BFF1C 0000828E */  lw         $v0, 0x0($s4)
    /* B0720 800BFF20 1480033C */  lui        $v1, %hi(TrsProj_precision)
    /* B0724 800BFF24 9CDB638C */  lw         $v1, %lo(TrsProj_precision)($v1)
    /* B0728 800BFF28 00000000 */  nop
    /* B072C 800BFF2C 07106200 */  srav       $v0, $v0, $v1
    /* B0730 800BFF30 280022AE */  sw         $v0, 0x28($s1)
    /* B0734 800BFF34 0400828E */  lw         $v0, 0x4($s4)
    /* B0738 800BFF38 00000000 */  nop
    /* B073C 800BFF3C 07106200 */  srav       $v0, $v0, $v1
    /* B0740 800BFF40 23100200 */  negu       $v0, $v0
    /* B0744 800BFF44 2C0022AE */  sw         $v0, 0x2C($s1)
    /* B0748 800BFF48 0800828E */  lw         $v0, 0x8($s4)
    /* B074C 800BFF4C 00000000 */  nop
    /* B0750 800BFF50 07106200 */  srav       $v0, $v0, $v1
    /* B0754 800BFF54 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* B0758 800BFF58 300022AE */   sw        $v0, 0x30($s1)
    /* B075C 800BFF5C 14002226 */  addiu      $v0, $s1, 0x14
    /* B0760 800BFF60 00004C8C */  lw         $t4, 0x0($v0)
    /* B0764 800BFF64 04004D8C */  lw         $t5, 0x4($v0)
    /* B0768 800BFF68 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B076C 800BFF6C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B0770 800BFF70 08004C8C */  lw         $t4, 0x8($v0)
    /* B0774 800BFF74 0C004D8C */  lw         $t5, 0xC($v0)
    /* B0778 800BFF78 10004E8C */  lw         $t6, 0x10($v0)
    /* B077C 800BFF7C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B0780 800BFF80 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B0784 800BFF84 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B0788 800BFF88 14004C8C */  lw         $t4, 0x14($v0)
    /* B078C 800BFF8C 18004D8C */  lw         $t5, 0x18($v0)
    /* B0790 800BFF90 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B0794 800BFF94 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B0798 800BFF98 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B079C 800BFF9C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B07A0 800BFFA0 D0002826 */  addiu      $t0, $s1, 0xD0
    /* B07A4 800BFFA4 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* B07A8 800BFFA8 D4002626 */  addiu      $a2, $s1, 0xD4
    /* B07AC 800BFFAC 1000A78E */  lw         $a3, 0x10($s5)
    /* B07B0 800BFFB0 0000AA96 */  lhu        $t2, 0x0($s5)
    /* B07B4 800BFFB4 0400E524 */  addiu      $a1, $a3, 0x4
  .L800BFFB8:
    /* B07B8 800BFFB8 FFFF4A25 */  addiu      $t2, $t2, -0x1
    /* B07BC 800BFFBC 0C004911 */  beq        $t2, $t1, .L800BFFF0
    /* B07C0 800BFFC0 09004332 */   andi      $v1, $s2, 0x9
    /* B07C4 800BFFC4 FEFFA294 */  lhu        $v0, -0x2($a1)
    /* B07C8 800BFFC8 0000A494 */  lhu        $a0, 0x0($a1)
    /* B07CC 800BFFCC 0600A524 */  addiu      $a1, $a1, 0x6
    /* B07D0 800BFFD0 0000E394 */  lhu        $v1, 0x0($a3)
    /* B07D4 800BFFD4 0600E724 */  addiu      $a3, $a3, 0x6
    /* B07D8 800BFFD8 000003A5 */  sh         $v1, 0x0($t0)
    /* B07DC 800BFFDC FEFFC2A4 */  sh         $v0, -0x2($a2)
    /* B07E0 800BFFE0 0000C4A4 */  sh         $a0, 0x0($a2)
    /* B07E4 800BFFE4 0800C624 */  addiu      $a2, $a2, 0x8
    /* B07E8 800BFFE8 EEFF0208 */  j          .L800BFFB8
    /* B07EC 800BFFEC 08000825 */   addiu     $t0, $t0, 0x8
  .L800BFFF0:
    /* B07F0 800BFFF0 0200AA96 */  lhu        $t2, 0x2($s5)
    /* B07F4 800BFFF4 01000224 */  addiu      $v0, $zero, 0x1
    /* B07F8 800BFFF8 19016210 */  beq        $v1, $v0, .L800C0460
    /* B07FC 800BFFFC 02006228 */   slti      $v0, $v1, 0x2
    /* B0800 800C0000 05004010 */  beqz       $v0, .L800C0018
    /* B0804 800C0004 00000000 */   nop
    /* B0808 800C0008 0A006010 */  beqz       $v1, .L800C0034
    /* B080C 800C000C 02004232 */   andi      $v0, $s2, 0x2
    /* B0810 800C0010 B3040308 */  j          .L800C12CC
    /* B0814 800C0014 00000000 */   nop
  .L800C0018:
    /* B0818 800C0018 08000224 */  addiu      $v0, $zero, 0x8
    /* B081C 800C001C 2F026210 */  beq        $v1, $v0, .L800C08DC
    /* B0820 800C0020 09000224 */   addiu     $v0, $zero, 0x9
    /* B0824 800C0024 0D036210 */  beq        $v1, $v0, .L800C0C5C
    /* B0828 800C0028 26001424 */   addiu     $s4, $zero, 0x26
    /* B082C 800C002C B3040308 */  j          .L800C12CC
    /* B0830 800C0030 00000000 */   nop
  .L800C0034:
    /* B0834 800C0034 84004014 */  bnez       $v0, .L800C0248
    /* B0838 800C0038 40100A00 */   sll       $v0, $t2, 1
    /* B083C 800C003C 24000B24 */  addiu      $t3, $zero, 0x24
    /* B0840 800C0040 21104A00 */  addu       $v0, $v0, $t2
    /* B0844 800C0044 80480200 */  sll        $t1, $v0, 2
  .L800C0048:
    /* B0848 800C0048 FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800C004C:
    /* B084C 800C004C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B0850 800C0050 9E044211 */  beq        $t2, $v0, .L800C12CC
    /* B0854 800C0054 F4FF2925 */   addiu     $t1, $t1, -0xC
    /* B0858 800C0058 1800A28E */  lw         $v0, 0x18($s5)
    /* B085C 800C005C 0800238E */  lw         $v1, 0x8($s1)
    /* B0860 800C0060 21384900 */  addu       $a3, $v0, $t1
    /* B0864 800C0064 0300E690 */  lbu        $a2, 0x3($a3)
    /* B0868 800C0068 0400E590 */  lbu        $a1, 0x4($a3)
    /* B086C 800C006C 0400228E */  lw         $v0, 0x4($s1)
    /* B0870 800C0070 0500E490 */  lbu        $a0, 0x5($a3)
    /* B0874 800C0074 2B104300 */  sltu       $v0, $v0, $v1
    /* B0878 800C0078 F4FF4010 */  beqz       $v0, .L800C004C
    /* B087C 800C007C FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0880 800C0080 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0884 800C0084 C0300600 */  sll        $a2, $a2, 3
    /* B0888 800C0088 2130D100 */  addu       $a2, $a2, $s1
    /* B088C 800C008C C0280500 */  sll        $a1, $a1, 3
    /* B0890 800C0090 2128B100 */  addu       $a1, $a1, $s1
    /* B0894 800C0094 C0200400 */  sll        $a0, $a0, 3
    /* B0898 800C0098 21209100 */  addu       $a0, $a0, $s1
    /* B089C 800C009C D000C0C8 */  lwc2       $0, 0xD0($a2)
    /* B08A0 800C00A0 D400C1C8 */  lwc2       $1, 0xD4($a2)
    /* B08A4 800C00A4 D000A2C8 */  lwc2       $2, 0xD0($a1)
    /* B08A8 800C00A8 D400A3C8 */  lwc2       $3, 0xD4($a1)
    /* B08AC 800C00AC D00084C8 */  lwc2       $4, 0xD0($a0)
    /* B08B0 800C00B0 D40085C8 */  lwc2       $5, 0xD4($a0)
    /* B08B4 800C00B4 00000000 */  nop
    /* B08B8 800C00B8 00000000 */  nop
    /* B08BC 800C00BC 3000284A */  .word 0x4A280030  /* rtpt */
    /* B08C0 800C00C0 00000000 */  nop
    /* B08C4 800C00C4 00000000 */  nop
    /* B08C8 800C00C8 0600404B */  .word 0x4B400006  /* nclip */
    /* B08CC 800C00CC 440038EA */  swc2       $24, 0x44($s1)
    /* B08D0 800C00D0 0C00228E */  lw         $v0, 0xC($s1)
    /* B08D4 800C00D4 4400238E */  lw         $v1, 0x44($s1)
    /* B08D8 800C00D8 02004010 */  beqz       $v0, .L800C00E4
    /* B08DC 800C00DC 00000000 */   nop
    /* B08E0 800C00E0 23180300 */  negu       $v1, $v1
  .L800C00E4:
    /* B08E4 800C00E4 D9FF6018 */  blez       $v1, .L800C004C
    /* B08E8 800C00E8 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B08EC 800C00EC 01004A25 */  addiu      $t2, $t2, 0x1
    /* B08F0 800C00F0 00000000 */  nop
    /* B08F4 800C00F4 00000000 */  nop
    /* B08F8 800C00F8 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B08FC 800C00FC 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B0900 800C0100 3C00238E */  lw         $v1, 0x3C($s1)
    /* B0904 800C0104 4000228E */  lw         $v0, 0x40($s1)
    /* B0908 800C0108 00000000 */  nop
    /* B090C 800C010C 21186200 */  addu       $v1, $v1, $v0
    /* B0910 800C0110 CDFF6004 */  bltz       $v1, .L800C0048
    /* B0914 800C0114 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B0918 800C0118 8800228E */  lw         $v0, 0x88($s1)
    /* B091C 800C011C 00000000 */  nop
    /* B0920 800C0120 2A104300 */  slt        $v0, $v0, $v1
    /* B0924 800C0124 C9FF4014 */  bnez       $v0, .L800C004C
    /* B0928 800C0128 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B092C 800C012C 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0930 800C0130 0400258E */  lw         $a1, 0x4($s1)
    /* B0934 800C0134 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B0938 800C0138 38002D8E */  lw         $t5, 0x38($s1)
    /* B093C 800C013C 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B0940 800C0140 80600C00 */  sll        $t4, $t4, 2
    /* B0944 800C0144 2168AC01 */  addu       $t5, $t5, $t4
    /* B0948 800C0148 04002EAE */  sw         $t6, 0x4($s1)
    /* B094C 800C014C 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B0950 800C0150 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B0954 800C0154 02720E00 */  srl        $t6, $t6, 8
    /* B0958 800C0158 2570CC01 */  or         $t6, $t6, $t4
    /* B095C 800C015C 00620500 */  sll        $t4, $a1, 8
    /* B0960 800C0160 0000AEAC */  sw         $t6, 0x0($a1)
    /* B0964 800C0164 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B0968 800C0168 0800ACE8 */  swc2       $12, 0x8($a1)
    /* B096C 800C016C 1000ADE8 */  swc2       $13, 0x10($a1)
    /* B0970 800C0170 1800AEE8 */  swc2       $14, 0x18($a1)
    /* B0974 800C0174 8C00228E */  lw         $v0, 0x8C($s1)
    /* B0978 800C0178 00000000 */  nop
    /* B097C 800C017C 0400A2AC */  sw         $v0, 0x4($a1)
    /* B0980 800C0180 0700ABA0 */  sb         $t3, 0x7($a1)
    /* B0984 800C0184 0200E290 */  lbu        $v0, 0x2($a3)
    /* B0988 800C0188 6000238E */  lw         $v1, 0x60($s1)
    /* B098C 800C018C 00110200 */  sll        $v0, $v0, 4
    /* B0990 800C0190 21186200 */  addu       $v1, $v1, $v0
    /* B0994 800C0194 0E006494 */  lhu        $a0, 0xE($v1)
    /* B0998 800C0198 00000000 */  nop
    /* B099C 800C019C 7F008230 */  andi       $v0, $a0, 0x7F
    /* B09A0 800C01A0 1E004010 */  beqz       $v0, .L800C021C
    /* B09A4 800C01A4 02008230 */   andi      $v0, $a0, 0x2
    /* B09A8 800C01A8 F6032692 */  lbu        $a2, 0x3F6($s1)
    /* B09AC 800C01AC F7032892 */  lbu        $t0, 0x3F7($s1)
    /* B09B0 800C01B0 03004010 */  beqz       $v0, .L800C01C0
    /* B09B4 800C01B4 00000000 */   nop
    /* B09B8 800C01B8 FE032692 */  lbu        $a2, 0x3FE($s1)
    /* B09BC 800C01BC FF032892 */  lbu        $t0, 0x3FF($s1)
  .L800C01C0:
    /* B09C0 800C01C0 02006294 */  lhu        $v0, 0x2($v1)
    /* B09C4 800C01C4 06006394 */  lhu        $v1, 0x6($v1)
    /* B09C8 800C01C8 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B09CC 800C01CC 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B09D0 800C01D0 0600E290 */  lbu        $v0, 0x6($a3)
    /* B09D4 800C01D4 0800E390 */  lbu        $v1, 0x8($a3)
    /* B09D8 800C01D8 0A00E490 */  lbu        $a0, 0xA($a3)
    /* B09DC 800C01DC 21104600 */  addu       $v0, $v0, $a2
    /* B09E0 800C01E0 21186600 */  addu       $v1, $v1, $a2
    /* B09E4 800C01E4 21208600 */  addu       $a0, $a0, $a2
    /* B09E8 800C01E8 0C00A2A0 */  sb         $v0, 0xC($a1)
    /* B09EC 800C01EC 1400A3A0 */  sb         $v1, 0x14($a1)
    /* B09F0 800C01F0 1C00A4A0 */  sb         $a0, 0x1C($a1)
    /* B09F4 800C01F4 0700E290 */  lbu        $v0, 0x7($a3)
    /* B09F8 800C01F8 0900E390 */  lbu        $v1, 0x9($a3)
    /* B09FC 800C01FC 0B00E490 */  lbu        $a0, 0xB($a3)
    /* B0A00 800C0200 21104800 */  addu       $v0, $v0, $t0
    /* B0A04 800C0204 21186800 */  addu       $v1, $v1, $t0
    /* B0A08 800C0208 21208800 */  addu       $a0, $a0, $t0
    /* B0A0C 800C020C 0D00A2A0 */  sb         $v0, 0xD($a1)
    /* B0A10 800C0210 1500A3A0 */  sb         $v1, 0x15($a1)
    /* B0A14 800C0214 12000308 */  j          .L800C0048
    /* B0A18 800C0218 1D00A4A0 */   sb        $a0, 0x1D($a1)
  .L800C021C:
    /* B0A1C 800C021C 02006294 */  lhu        $v0, 0x2($v1)
    /* B0A20 800C0220 06006394 */  lhu        $v1, 0x6($v1)
    /* B0A24 800C0224 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B0A28 800C0228 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B0A2C 800C022C 0600E294 */  lhu        $v0, 0x6($a3)
    /* B0A30 800C0230 0800E394 */  lhu        $v1, 0x8($a3)
    /* B0A34 800C0234 0A00E494 */  lhu        $a0, 0xA($a3)
    /* B0A38 800C0238 0C00A2A4 */  sh         $v0, 0xC($a1)
    /* B0A3C 800C023C 1400A3A4 */  sh         $v1, 0x14($a1)
    /* B0A40 800C0240 12000308 */  j          .L800C0048
    /* B0A44 800C0244 1C00A4A4 */   sh        $a0, 0x1C($a1)
  .L800C0248:
    /* B0A48 800C0248 21104A00 */  addu       $v0, $v0, $t2
    /* B0A4C 800C024C 80480200 */  sll        $t1, $v0, 2
  .L800C0250:
    /* B0A50 800C0250 FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800C0254:
    /* B0A54 800C0254 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B0A58 800C0258 1C044211 */  beq        $t2, $v0, .L800C12CC
    /* B0A5C 800C025C F4FF2925 */   addiu     $t1, $t1, -0xC
    /* B0A60 800C0260 1800A28E */  lw         $v0, 0x18($s5)
    /* B0A64 800C0264 0800238E */  lw         $v1, 0x8($s1)
    /* B0A68 800C0268 21404900 */  addu       $t0, $v0, $t1
    /* B0A6C 800C026C 03000691 */  lbu        $a2, 0x3($t0)
    /* B0A70 800C0270 04000591 */  lbu        $a1, 0x4($t0)
    /* B0A74 800C0274 0400228E */  lw         $v0, 0x4($s1)
    /* B0A78 800C0278 05000491 */  lbu        $a0, 0x5($t0)
    /* B0A7C 800C027C 2B104300 */  sltu       $v0, $v0, $v1
    /* B0A80 800C0280 F4FF4010 */  beqz       $v0, .L800C0254
    /* B0A84 800C0284 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0A88 800C0288 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0A8C 800C028C C0300600 */  sll        $a2, $a2, 3
    /* B0A90 800C0290 2130D100 */  addu       $a2, $a2, $s1
    /* B0A94 800C0294 C0280500 */  sll        $a1, $a1, 3
    /* B0A98 800C0298 2128B100 */  addu       $a1, $a1, $s1
    /* B0A9C 800C029C C0200400 */  sll        $a0, $a0, 3
    /* B0AA0 800C02A0 21209100 */  addu       $a0, $a0, $s1
    /* B0AA4 800C02A4 D000C0C8 */  lwc2       $0, 0xD0($a2)
    /* B0AA8 800C02A8 D400C1C8 */  lwc2       $1, 0xD4($a2)
    /* B0AAC 800C02AC D000A2C8 */  lwc2       $2, 0xD0($a1)
    /* B0AB0 800C02B0 D400A3C8 */  lwc2       $3, 0xD4($a1)
    /* B0AB4 800C02B4 D00084C8 */  lwc2       $4, 0xD0($a0)
    /* B0AB8 800C02B8 D40085C8 */  lwc2       $5, 0xD4($a0)
    /* B0ABC 800C02BC 00000000 */  nop
    /* B0AC0 800C02C0 00000000 */  nop
    /* B0AC4 800C02C4 3000284A */  .word 0x4A280030  /* rtpt */
    /* B0AC8 800C02C8 00000000 */  nop
    /* B0ACC 800C02CC 00000000 */  nop
    /* B0AD0 800C02D0 0600404B */  .word 0x4B400006  /* nclip */
    /* B0AD4 800C02D4 440038EA */  swc2       $24, 0x44($s1)
    /* B0AD8 800C02D8 0C00228E */  lw         $v0, 0xC($s1)
    /* B0ADC 800C02DC 4400238E */  lw         $v1, 0x44($s1)
    /* B0AE0 800C02E0 02004010 */  beqz       $v0, .L800C02EC
    /* B0AE4 800C02E4 00000000 */   nop
    /* B0AE8 800C02E8 23180300 */  negu       $v1, $v1
  .L800C02EC:
    /* B0AEC 800C02EC D9FF6018 */  blez       $v1, .L800C0254
    /* B0AF0 800C02F0 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0AF4 800C02F4 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0AF8 800C02F8 00000000 */  nop
    /* B0AFC 800C02FC 00000000 */  nop
    /* B0B00 800C0300 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B0B04 800C0304 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B0B08 800C0308 3C00238E */  lw         $v1, 0x3C($s1)
    /* B0B0C 800C030C 4000228E */  lw         $v0, 0x40($s1)
    /* B0B10 800C0310 00000000 */  nop
    /* B0B14 800C0314 21186200 */  addu       $v1, $v1, $v0
    /* B0B18 800C0318 CDFF6004 */  bltz       $v1, .L800C0250
    /* B0B1C 800C031C 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B0B20 800C0320 8800228E */  lw         $v0, 0x88($s1)
    /* B0B24 800C0324 00000000 */  nop
    /* B0B28 800C0328 2A104300 */  slt        $v0, $v0, $v1
    /* B0B2C 800C032C C9FF4014 */  bnez       $v0, .L800C0254
    /* B0B30 800C0330 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0B34 800C0334 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0B38 800C0338 0400278E */  lw         $a3, 0x4($s1)
    /* B0B3C 800C033C 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B0B40 800C0340 38002D8E */  lw         $t5, 0x38($s1)
    /* B0B44 800C0344 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B0B48 800C0348 80600C00 */  sll        $t4, $t4, 2
    /* B0B4C 800C034C 2168AC01 */  addu       $t5, $t5, $t4
    /* B0B50 800C0350 04002EAE */  sw         $t6, 0x4($s1)
    /* B0B54 800C0354 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B0B58 800C0358 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B0B5C 800C035C 02720E00 */  srl        $t6, $t6, 8
    /* B0B60 800C0360 2570CC01 */  or         $t6, $t6, $t4
    /* B0B64 800C0364 00620700 */  sll        $t4, $a3, 8
    /* B0B68 800C0368 0000EEAC */  sw         $t6, 0x0($a3)
    /* B0B6C 800C036C 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B0B70 800C0370 0800ECE8 */  swc2       $12, 0x8($a3)
    /* B0B74 800C0374 1000EDE8 */  swc2       $13, 0x10($a3)
    /* B0B78 800C0378 1800EEE8 */  swc2       $14, 0x18($a3)
    /* B0B7C 800C037C 00000295 */  lhu        $v0, 0x0($t0)
    /* B0B80 800C0380 8C00238E */  lw         $v1, 0x8C($s1)
    /* B0B84 800C0384 01004230 */  andi       $v0, $v0, 0x1
    /* B0B88 800C0388 02004010 */  beqz       $v0, .L800C0394
    /* B0B8C 800C038C 24000424 */   addiu     $a0, $zero, 0x24
    /* B0B90 800C0390 26000424 */  addiu      $a0, $zero, 0x26
  .L800C0394:
    /* B0B94 800C0394 0400E3AC */  sw         $v1, 0x4($a3)
    /* B0B98 800C0398 0700E4A0 */  sb         $a0, 0x7($a3)
    /* B0B9C 800C039C 00000295 */  lhu        $v0, 0x0($t0)
    /* B0BA0 800C03A0 00000000 */  nop
    /* B0BA4 800C03A4 01004230 */  andi       $v0, $v0, 0x1
    /* B0BA8 800C03A8 1E004014 */  bnez       $v0, .L800C0424
    /* B0BAC 800C03AC 00000000 */   nop
    /* B0BB0 800C03B0 02000291 */  lbu        $v0, 0x2($t0)
    /* B0BB4 800C03B4 6000238E */  lw         $v1, 0x60($s1)
    /* B0BB8 800C03B8 EE032592 */  lbu        $a1, 0x3EE($s1)
    /* B0BBC 800C03BC EF032692 */  lbu        $a2, 0x3EF($s1)
    /* B0BC0 800C03C0 00110200 */  sll        $v0, $v0, 4
    /* B0BC4 800C03C4 21186200 */  addu       $v1, $v1, $v0
    /* B0BC8 800C03C8 02006494 */  lhu        $a0, 0x2($v1)
    /* B0BCC 800C03CC 06006294 */  lhu        $v0, 0x6($v1)
    /* B0BD0 800C03D0 0E00E4A4 */  sh         $a0, 0xE($a3)
    /* B0BD4 800C03D4 1600E2A4 */  sh         $v0, 0x16($a3)
    /* B0BD8 800C03D8 06000291 */  lbu        $v0, 0x6($t0)
    /* B0BDC 800C03DC 08000391 */  lbu        $v1, 0x8($t0)
    /* B0BE0 800C03E0 0A000491 */  lbu        $a0, 0xA($t0)
    /* B0BE4 800C03E4 21104500 */  addu       $v0, $v0, $a1
    /* B0BE8 800C03E8 21186500 */  addu       $v1, $v1, $a1
    /* B0BEC 800C03EC 21208500 */  addu       $a0, $a0, $a1
    /* B0BF0 800C03F0 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B0BF4 800C03F4 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B0BF8 800C03F8 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B0BFC 800C03FC 07000291 */  lbu        $v0, 0x7($t0)
    /* B0C00 800C0400 09000391 */  lbu        $v1, 0x9($t0)
    /* B0C04 800C0404 0B000491 */  lbu        $a0, 0xB($t0)
    /* B0C08 800C0408 21104600 */  addu       $v0, $v0, $a2
    /* B0C0C 800C040C 21186600 */  addu       $v1, $v1, $a2
    /* B0C10 800C0410 21208600 */  addu       $a0, $a0, $a2
    /* B0C14 800C0414 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B0C18 800C0418 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B0C1C 800C041C 94000308 */  j          .L800C0250
    /* B0C20 800C0420 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C0424:
    /* B0C24 800C0424 02000291 */  lbu        $v0, 0x2($t0)
    /* B0C28 800C0428 6000238E */  lw         $v1, 0x60($s1)
    /* B0C2C 800C042C 00110200 */  sll        $v0, $v0, 4
    /* B0C30 800C0430 21186200 */  addu       $v1, $v1, $v0
    /* B0C34 800C0434 02006294 */  lhu        $v0, 0x2($v1)
    /* B0C38 800C0438 06006394 */  lhu        $v1, 0x6($v1)
    /* B0C3C 800C043C 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B0C40 800C0440 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B0C44 800C0444 06000295 */  lhu        $v0, 0x6($t0)
    /* B0C48 800C0448 08000395 */  lhu        $v1, 0x8($t0)
    /* B0C4C 800C044C 0A000495 */  lhu        $a0, 0xA($t0)
    /* B0C50 800C0450 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B0C54 800C0454 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B0C58 800C0458 94000308 */  j          .L800C0250
    /* B0C5C 800C045C 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C0460:
    /* B0C60 800C0460 26001224 */  addiu      $s2, $zero, 0x26
    /* B0C64 800C0464 24001424 */  addiu      $s4, $zero, 0x24
    /* B0C68 800C0468 40100A00 */  sll        $v0, $t2, 1
    /* B0C6C 800C046C 21104A00 */  addu       $v0, $v0, $t2
    /* B0C70 800C0470 80580200 */  sll        $t3, $v0, 2
  .L800C0474:
    /* B0C74 800C0474 FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800C0478:
    /* B0C78 800C0478 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B0C7C 800C047C 93034211 */  beq        $t2, $v0, .L800C12CC
    /* B0C80 800C0480 F4FF6B25 */   addiu     $t3, $t3, -0xC
    /* B0C84 800C0484 1800A28E */  lw         $v0, 0x18($s5)
    /* B0C88 800C0488 0800238E */  lw         $v1, 0x8($s1)
    /* B0C8C 800C048C 21304B00 */  addu       $a2, $v0, $t3
    /* B0C90 800C0490 0300C990 */  lbu        $t1, 0x3($a2)
    /* B0C94 800C0494 0400C890 */  lbu        $t0, 0x4($a2)
    /* B0C98 800C0498 0400228E */  lw         $v0, 0x4($s1)
    /* B0C9C 800C049C 0500C790 */  lbu        $a3, 0x5($a2)
    /* B0CA0 800C04A0 2B104300 */  sltu       $v0, $v0, $v1
    /* B0CA4 800C04A4 F4FF4010 */  beqz       $v0, .L800C0478
    /* B0CA8 800C04A8 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0CAC 800C04AC 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0CB0 800C04B0 C0480900 */  sll        $t1, $t1, 3
    /* B0CB4 800C04B4 21483101 */  addu       $t1, $t1, $s1
    /* B0CB8 800C04B8 C0400800 */  sll        $t0, $t0, 3
    /* B0CBC 800C04BC 21401101 */  addu       $t0, $t0, $s1
    /* B0CC0 800C04C0 C0380700 */  sll        $a3, $a3, 3
    /* B0CC4 800C04C4 2138F100 */  addu       $a3, $a3, $s1
    /* B0CC8 800C04C8 D00020C9 */  lwc2       $0, 0xD0($t1)
    /* B0CCC 800C04CC D40021C9 */  lwc2       $1, 0xD4($t1)
    /* B0CD0 800C04D0 D00002C9 */  lwc2       $2, 0xD0($t0)
    /* B0CD4 800C04D4 D40003C9 */  lwc2       $3, 0xD4($t0)
    /* B0CD8 800C04D8 D000E4C8 */  lwc2       $4, 0xD0($a3)
    /* B0CDC 800C04DC D400E5C8 */  lwc2       $5, 0xD4($a3)
    /* B0CE0 800C04E0 00000000 */  nop
    /* B0CE4 800C04E4 00000000 */  nop
    /* B0CE8 800C04E8 3000284A */  .word 0x4A280030  /* rtpt */
    /* B0CEC 800C04EC 00000000 */  nop
    /* B0CF0 800C04F0 00000000 */  nop
    /* B0CF4 800C04F4 0600404B */  .word 0x4B400006  /* nclip */
    /* B0CF8 800C04F8 440038EA */  swc2       $24, 0x44($s1)
    /* B0CFC 800C04FC 0C00228E */  lw         $v0, 0xC($s1)
    /* B0D00 800C0500 4400238E */  lw         $v1, 0x44($s1)
    /* B0D04 800C0504 02004010 */  beqz       $v0, .L800C0510
    /* B0D08 800C0508 00000000 */   nop
    /* B0D0C 800C050C 23180300 */  negu       $v1, $v1
  .L800C0510:
    /* B0D10 800C0510 D9FF6018 */  blez       $v1, .L800C0478
    /* B0D14 800C0514 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0D18 800C0518 01004A25 */  addiu      $t2, $t2, 0x1
    /* B0D1C 800C051C C4002CEA */  swc2       $12, 0xC4($s1)
    /* B0D20 800C0520 C8002DEA */  swc2       $13, 0xC8($s1)
    /* B0D24 800C0524 CC002EEA */  swc2       $14, 0xCC($s1)
    /* B0D28 800C0528 00000000 */  nop
    /* B0D2C 800C052C 00000000 */  nop
    /* B0D30 800C0530 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B0D34 800C0534 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B0D38 800C0538 3C00238E */  lw         $v1, 0x3C($s1)
    /* B0D3C 800C053C 4000228E */  lw         $v0, 0x40($s1)
    /* B0D40 800C0540 00000000 */  nop
    /* B0D44 800C0544 21186200 */  addu       $v1, $v1, $v0
    /* B0D48 800C0548 CAFF6004 */  bltz       $v1, .L800C0474
    /* B0D4C 800C054C 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B0D50 800C0550 8800228E */  lw         $v0, 0x88($s1)
    /* B0D54 800C0554 00000000 */  nop
    /* B0D58 800C0558 2A104300 */  slt        $v0, $v0, $v1
    /* B0D5C 800C055C C6FF4014 */  bnez       $v0, .L800C0478
    /* B0D60 800C0560 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B0D64 800C0564 0000C294 */  lhu        $v0, 0x0($a2)
    /* B0D68 800C0568 00000000 */  nop
    /* B0D6C 800C056C F3034230 */  andi       $v0, $v0, 0x3F3
    /* B0D70 800C0570 7E004010 */  beqz       $v0, .L800C076C
    /* B0D74 800C0574 01004A25 */   addiu     $t2, $t2, 0x1
    /* B0D78 800C0578 7400228E */  lw         $v0, 0x74($s1)
    /* B0D7C 800C057C 00000000 */  nop
    /* B0D80 800C0580 7A004010 */  beqz       $v0, .L800C076C
    /* B0D84 800C0584 00000000 */   nop
    /* B0D88 800C0588 0300C390 */  lbu        $v1, 0x3($a2)
    /* B0D8C 800C058C 00000000 */  nop
    /* B0D90 800C0590 40100300 */  sll        $v0, $v1, 1
    /* B0D94 800C0594 21104300 */  addu       $v0, $v0, $v1
    /* B0D98 800C0598 40100200 */  sll        $v0, $v0, 1
    /* B0D9C 800C059C 21106202 */  addu       $v0, $s3, $v0
    /* B0DA0 800C05A0 00004394 */  lhu        $v1, 0x0($v0)
    /* B0DA4 800C05A4 02004494 */  lhu        $a0, 0x2($v0)
    /* B0DA8 800C05A8 04004294 */  lhu        $v0, 0x4($v0)
    /* B0DAC 800C05AC AC0023A6 */  sh         $v1, 0xAC($s1)
    /* B0DB0 800C05B0 AE0024A6 */  sh         $a0, 0xAE($s1)
    /* B0DB4 800C05B4 B00022A6 */  sh         $v0, 0xB0($s1)
    /* B0DB8 800C05B8 0400C390 */  lbu        $v1, 0x4($a2)
    /* B0DBC 800C05BC 00000000 */  nop
    /* B0DC0 800C05C0 40100300 */  sll        $v0, $v1, 1
    /* B0DC4 800C05C4 21104300 */  addu       $v0, $v0, $v1
    /* B0DC8 800C05C8 40100200 */  sll        $v0, $v0, 1
    /* B0DCC 800C05CC 21106202 */  addu       $v0, $s3, $v0
    /* B0DD0 800C05D0 00004394 */  lhu        $v1, 0x0($v0)
    /* B0DD4 800C05D4 02004494 */  lhu        $a0, 0x2($v0)
    /* B0DD8 800C05D8 04004294 */  lhu        $v0, 0x4($v0)
    /* B0DDC 800C05DC B40023A6 */  sh         $v1, 0xB4($s1)
    /* B0DE0 800C05E0 B60024A6 */  sh         $a0, 0xB6($s1)
    /* B0DE4 800C05E4 B80022A6 */  sh         $v0, 0xB8($s1)
    /* B0DE8 800C05E8 0500C390 */  lbu        $v1, 0x5($a2)
    /* B0DEC 800C05EC 00000000 */  nop
    /* B0DF0 800C05F0 40100300 */  sll        $v0, $v1, 1
    /* B0DF4 800C05F4 21104300 */  addu       $v0, $v0, $v1
    /* B0DF8 800C05F8 40100200 */  sll        $v0, $v0, 1
    /* B0DFC 800C05FC 21106202 */  addu       $v0, $s3, $v0
    /* B0E00 800C0600 00004394 */  lhu        $v1, 0x0($v0)
    /* B0E04 800C0604 02004494 */  lhu        $a0, 0x2($v0)
    /* B0E08 800C0608 04004294 */  lhu        $v0, 0x4($v0)
    /* B0E0C 800C060C BC0023A6 */  sh         $v1, 0xBC($s1)
    /* B0E10 800C0610 BE0024A6 */  sh         $a0, 0xBE($s1)
    /* B0E14 800C0614 C00022A6 */  sh         $v0, 0xC0($s1)
    /* B0E18 800C0618 04002C8E */  lw         $t4, 0x4($s1)
    /* B0E1C 800C061C 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B0E20 800C0620 38002E8E */  lw         $t6, 0x38($s1)
    /* B0E24 800C0624 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B0E28 800C0628 80680D00 */  sll        $t5, $t5, 2
    /* B0E2C 800C062C 2170CD01 */  addu       $t6, $t6, $t5
    /* B0E30 800C0630 04002FAE */  sw         $t7, 0x4($s1)
    /* B0E34 800C0634 54002D8E */  lw         $t5, 0x54($s1)
    /* B0E38 800C0638 58002F8E */  lw         $t7, 0x58($s1)
    /* B0E3C 800C063C 5C00308E */  lw         $s0, 0x5C($s1)
    /* B0E40 800C0640 00008DAD */  sw         $t5, 0x0($t4)
    /* B0E44 800C0644 04008FAD */  sw         $t7, 0x4($t4)
    /* B0E48 800C0648 080090AD */  sw         $s0, 0x8($t4)
    /* B0E4C 800C064C 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B0E50 800C0650 007A0C00 */  sll        $t7, $t4, 8
    /* B0E54 800C0654 02008DA9 */  swl        $t5, 0x2($t4)
    /* B0E58 800C0658 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B0E5C 800C065C 0400258E */  lw         $a1, 0x4($s1)
    /* B0E60 800C0660 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B0E64 800C0664 38002D8E */  lw         $t5, 0x38($s1)
    /* B0E68 800C0668 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B0E6C 800C066C 80600C00 */  sll        $t4, $t4, 2
    /* B0E70 800C0670 2168AC01 */  addu       $t5, $t5, $t4
    /* B0E74 800C0674 04002EAE */  sw         $t6, 0x4($s1)
    /* B0E78 800C0678 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B0E7C 800C067C 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B0E80 800C0680 02720E00 */  srl        $t6, $t6, 8
    /* B0E84 800C0684 2570CC01 */  or         $t6, $t6, $t4
    /* B0E88 800C0688 00620500 */  sll        $t4, $a1, 8
    /* B0E8C 800C068C 0000AEAC */  sw         $t6, 0x0($a1)
    /* B0E90 800C0690 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B0E94 800C0694 04002C8E */  lw         $t4, 0x4($s1)
    /* B0E98 800C0698 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B0E9C 800C069C 38002E8E */  lw         $t6, 0x38($s1)
    /* B0EA0 800C06A0 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B0EA4 800C06A4 80680D00 */  sll        $t5, $t5, 2
    /* B0EA8 800C06A8 2170CD01 */  addu       $t6, $t6, $t5
    /* B0EAC 800C06AC 04002FAE */  sw         $t7, 0x4($s1)
    /* B0EB0 800C06B0 48002D8E */  lw         $t5, 0x48($s1)
    /* B0EB4 800C06B4 4C002F8E */  lw         $t7, 0x4C($s1)
    /* B0EB8 800C06B8 5000308E */  lw         $s0, 0x50($s1)
    /* B0EBC 800C06BC 00008DAD */  sw         $t5, 0x0($t4)
    /* B0EC0 800C06C0 04008FAD */  sw         $t7, 0x4($t4)
    /* B0EC4 800C06C4 080090AD */  sw         $s0, 0x8($t4)
    /* B0EC8 800C06C8 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B0ECC 800C06CC 007A0C00 */  sll        $t7, $t4, 8
    /* B0ED0 800C06D0 02008DA9 */  swl        $t5, 0x2($t4)
    /* B0ED4 800C06D4 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B0ED8 800C06D8 C400228E */  lw         $v0, 0xC4($s1)
    /* B0EDC 800C06DC C800238E */  lw         $v1, 0xC8($s1)
    /* B0EE0 800C06E0 CC00248E */  lw         $a0, 0xCC($s1)
    /* B0EE4 800C06E4 0800A2AC */  sw         $v0, 0x8($a1)
    /* B0EE8 800C06E8 1000A3AC */  sw         $v1, 0x10($a1)
    /* B0EEC 800C06EC 1800A4AC */  sw         $a0, 0x18($a1)
    /* B0EF0 800C06F0 9000228E */  lw         $v0, 0x90($s1)
    /* B0EF4 800C06F4 00000000 */  nop
    /* B0EF8 800C06F8 0400A2AC */  sw         $v0, 0x4($a1)
    /* B0EFC 800C06FC 0700B2A0 */  sb         $s2, 0x7($a1)
    /* B0F00 800C0700 76002296 */  lhu        $v0, 0x76($s1)
    /* B0F04 800C0704 7A002396 */  lhu        $v1, 0x7A($s1)
    /* B0F08 800C0708 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B0F0C 800C070C 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B0F10 800C0710 74002E92 */  lbu        $t6, 0x74($s1)
    /* B0F14 800C0714 75002F92 */  lbu        $t7, 0x75($s1)
    /* B0F18 800C0718 84002D92 */  lbu        $t5, 0x84($s1)
    /* B0F1C 800C071C 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B0F20 800C0720 2178ED01 */  addu       $t7, $t7, $t5
    /* B0F24 800C0724 AE002C92 */  lbu        $t4, 0xAE($s1)
    /* B0F28 800C0728 B0002D92 */  lbu        $t5, 0xB0($s1)
    /* B0F2C 800C072C 21608E01 */  addu       $t4, $t4, $t6
    /* B0F30 800C0730 0C00ACA0 */  sb         $t4, 0xC($a1)
    /* B0F34 800C0734 2168AF01 */  addu       $t5, $t5, $t7
    /* B0F38 800C0738 0D00ADA0 */  sb         $t5, 0xD($a1)
    /* B0F3C 800C073C B6002C92 */  lbu        $t4, 0xB6($s1)
    /* B0F40 800C0740 B8002D92 */  lbu        $t5, 0xB8($s1)
    /* B0F44 800C0744 21608E01 */  addu       $t4, $t4, $t6
    /* B0F48 800C0748 1400ACA0 */  sb         $t4, 0x14($a1)
    /* B0F4C 800C074C 2168AF01 */  addu       $t5, $t5, $t7
    /* B0F50 800C0750 1500ADA0 */  sb         $t5, 0x15($a1)
    /* B0F54 800C0754 BE002C92 */  lbu        $t4, 0xBE($s1)
    /* B0F58 800C0758 C0002D92 */  lbu        $t5, 0xC0($s1)
    /* B0F5C 800C075C 21608E01 */  addu       $t4, $t4, $t6
    /* B0F60 800C0760 1C00ACA0 */  sb         $t4, 0x1C($a1)
    /* B0F64 800C0764 2168AF01 */  addu       $t5, $t5, $t7
    /* B0F68 800C0768 1D00ADA0 */  sb         $t5, 0x1D($a1)
  .L800C076C:
    /* B0F6C 800C076C 6400228E */  lw         $v0, 0x64($s1)
    /* B0F70 800C0770 00000000 */  nop
    /* B0F74 800C0774 32004010 */  beqz       $v0, .L800C0840
    /* B0F78 800C0778 00000000 */   nop
    /* B0F7C 800C077C 0400258E */  lw         $a1, 0x4($s1)
    /* B0F80 800C0780 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B0F84 800C0784 38002D8E */  lw         $t5, 0x38($s1)
    /* B0F88 800C0788 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B0F8C 800C078C 80600C00 */  sll        $t4, $t4, 2
    /* B0F90 800C0790 2168AC01 */  addu       $t5, $t5, $t4
    /* B0F94 800C0794 04002EAE */  sw         $t6, 0x4($s1)
    /* B0F98 800C0798 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B0F9C 800C079C 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B0FA0 800C07A0 02720E00 */  srl        $t6, $t6, 8
    /* B0FA4 800C07A4 2570CC01 */  or         $t6, $t6, $t4
    /* B0FA8 800C07A8 00620500 */  sll        $t4, $a1, 8
    /* B0FAC 800C07AC 0000AEAC */  sw         $t6, 0x0($a1)
    /* B0FB0 800C07B0 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B0FB4 800C07B4 C400228E */  lw         $v0, 0xC4($s1)
    /* B0FB8 800C07B8 C800238E */  lw         $v1, 0xC8($s1)
    /* B0FBC 800C07BC CC00248E */  lw         $a0, 0xCC($s1)
    /* B0FC0 800C07C0 0800A2AC */  sw         $v0, 0x8($a1)
    /* B0FC4 800C07C4 1000A3AC */  sw         $v1, 0x10($a1)
    /* B0FC8 800C07C8 1800A4AC */  sw         $a0, 0x18($a1)
    /* B0FCC 800C07CC 9000228E */  lw         $v0, 0x90($s1)
    /* B0FD0 800C07D0 00000000 */  nop
    /* B0FD4 800C07D4 0400A2AC */  sw         $v0, 0x4($a1)
    /* B0FD8 800C07D8 0700B2A0 */  sb         $s2, 0x7($a1)
    /* B0FDC 800C07DC 66002296 */  lhu        $v0, 0x66($s1)
    /* B0FE0 800C07E0 6A002396 */  lhu        $v1, 0x6A($s1)
    /* B0FE4 800C07E4 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B0FE8 800C07E8 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B0FEC 800C07EC 64002E92 */  lbu        $t6, 0x64($s1)
    /* B0FF0 800C07F0 65002F92 */  lbu        $t7, 0x65($s1)
    /* B0FF4 800C07F4 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B0FF8 800C07F8 D6002C91 */  lbu        $t4, 0xD6($t1)
    /* B0FFC 800C07FC D7002D91 */  lbu        $t5, 0xD7($t1)
    /* B1000 800C0800 21608E01 */  addu       $t4, $t4, $t6
    /* B1004 800C0804 0C00ACA0 */  sb         $t4, 0xC($a1)
    /* B1008 800C0808 2168AF01 */  addu       $t5, $t5, $t7
    /* B100C 800C080C 0D00ADA0 */  sb         $t5, 0xD($a1)
    /* B1010 800C0810 D6000C91 */  lbu        $t4, 0xD6($t0)
    /* B1014 800C0814 D7000D91 */  lbu        $t5, 0xD7($t0)
    /* B1018 800C0818 21608E01 */  addu       $t4, $t4, $t6
    /* B101C 800C081C 1400ACA0 */  sb         $t4, 0x14($a1)
    /* B1020 800C0820 2168AF01 */  addu       $t5, $t5, $t7
    /* B1024 800C0824 1500ADA0 */  sb         $t5, 0x15($a1)
    /* B1028 800C0828 D600EC90 */  lbu        $t4, 0xD6($a3)
    /* B102C 800C082C D700ED90 */  lbu        $t5, 0xD7($a3)
    /* B1030 800C0830 21608E01 */  addu       $t4, $t4, $t6
    /* B1034 800C0834 1C00ACA0 */  sb         $t4, 0x1C($a1)
    /* B1038 800C0838 2168AF01 */  addu       $t5, $t5, $t7
    /* B103C 800C083C 1D00ADA0 */  sb         $t5, 0x1D($a1)
  .L800C0840:
    /* B1040 800C0840 0400258E */  lw         $a1, 0x4($s1)
    /* B1044 800C0844 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B1048 800C0848 38002D8E */  lw         $t5, 0x38($s1)
    /* B104C 800C084C 2000AE24 */  addiu      $t6, $a1, 0x20
    /* B1050 800C0850 80600C00 */  sll        $t4, $t4, 2
    /* B1054 800C0854 2168AC01 */  addu       $t5, $t5, $t4
    /* B1058 800C0858 04002EAE */  sw         $t6, 0x4($s1)
    /* B105C 800C085C 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B1060 800C0860 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B1064 800C0864 02720E00 */  srl        $t6, $t6, 8
    /* B1068 800C0868 2570CC01 */  or         $t6, $t6, $t4
    /* B106C 800C086C 00620500 */  sll        $t4, $a1, 8
    /* B1070 800C0870 0000AEAC */  sw         $t6, 0x0($a1)
    /* B1074 800C0874 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B1078 800C0878 C400228E */  lw         $v0, 0xC4($s1)
    /* B107C 800C087C C800238E */  lw         $v1, 0xC8($s1)
    /* B1080 800C0880 CC00248E */  lw         $a0, 0xCC($s1)
    /* B1084 800C0884 0800A2AC */  sw         $v0, 0x8($a1)
    /* B1088 800C0888 1000A3AC */  sw         $v1, 0x10($a1)
    /* B108C 800C088C 1800A4AC */  sw         $a0, 0x18($a1)
    /* B1090 800C0890 8C00228E */  lw         $v0, 0x8C($s1)
    /* B1094 800C0894 00000000 */  nop
    /* B1098 800C0898 0400A2AC */  sw         $v0, 0x4($a1)
    /* B109C 800C089C 0700B4A0 */  sb         $s4, 0x7($a1)
    /* B10A0 800C08A0 0200C290 */  lbu        $v0, 0x2($a2)
    /* B10A4 800C08A4 6000238E */  lw         $v1, 0x60($s1)
    /* B10A8 800C08A8 00110200 */  sll        $v0, $v0, 4
    /* B10AC 800C08AC 21186200 */  addu       $v1, $v1, $v0
    /* B10B0 800C08B0 02006294 */  lhu        $v0, 0x2($v1)
    /* B10B4 800C08B4 06006394 */  lhu        $v1, 0x6($v1)
    /* B10B8 800C08B8 0E00A2A4 */  sh         $v0, 0xE($a1)
    /* B10BC 800C08BC 1600A3A4 */  sh         $v1, 0x16($a1)
    /* B10C0 800C08C0 0600C294 */  lhu        $v0, 0x6($a2)
    /* B10C4 800C08C4 0800C394 */  lhu        $v1, 0x8($a2)
    /* B10C8 800C08C8 0A00C494 */  lhu        $a0, 0xA($a2)
    /* B10CC 800C08CC 0C00A2A4 */  sh         $v0, 0xC($a1)
    /* B10D0 800C08D0 1400A3A4 */  sh         $v1, 0x14($a1)
    /* B10D4 800C08D4 1D010308 */  j          .L800C0474
    /* B10D8 800C08D8 1C00A4A4 */   sh        $a0, 0x1C($a1)
  .L800C08DC:
    /* B10DC 800C08DC 1280023C */  lui        $v0, %hi(DrawC_gOverlay)
    /* B10E0 800C08E0 08F54F24 */  addiu      $t7, $v0, %lo(DrawC_gOverlay)
    /* B10E4 800C08E4 40100A00 */  sll        $v0, $t2, 1
    /* B10E8 800C08E8 21104A00 */  addu       $v0, $v0, $t2
    /* B10EC 800C08EC 80580200 */  sll        $t3, $v0, 2
  .L800C08F0:
    /* B10F0 800C08F0 FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800C08F4:
    /* B10F4 800C08F4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B10F8 800C08F8 74024211 */  beq        $t2, $v0, .L800C12CC
    /* B10FC 800C08FC F4FF6B25 */   addiu     $t3, $t3, -0xC
    /* B1100 800C0900 1800A28E */  lw         $v0, 0x18($s5)
    /* B1104 800C0904 0800238E */  lw         $v1, 0x8($s1)
    /* B1108 800C0908 21404B00 */  addu       $t0, $v0, $t3
    /* B110C 800C090C 03000691 */  lbu        $a2, 0x3($t0)
    /* B1110 800C0910 04000591 */  lbu        $a1, 0x4($t0)
    /* B1114 800C0914 0400228E */  lw         $v0, 0x4($s1)
    /* B1118 800C0918 05000491 */  lbu        $a0, 0x5($t0)
    /* B111C 800C091C 2B104300 */  sltu       $v0, $v0, $v1
    /* B1120 800C0920 F4FF4010 */  beqz       $v0, .L800C08F4
    /* B1124 800C0924 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1128 800C0928 01004A25 */  addiu      $t2, $t2, 0x1
    /* B112C 800C092C C0300600 */  sll        $a2, $a2, 3
    /* B1130 800C0930 2130D100 */  addu       $a2, $a2, $s1
    /* B1134 800C0934 C0280500 */  sll        $a1, $a1, 3
    /* B1138 800C0938 2128B100 */  addu       $a1, $a1, $s1
    /* B113C 800C093C C0200400 */  sll        $a0, $a0, 3
    /* B1140 800C0940 21209100 */  addu       $a0, $a0, $s1
    /* B1144 800C0944 D000C0C8 */  lwc2       $0, 0xD0($a2)
    /* B1148 800C0948 D400C1C8 */  lwc2       $1, 0xD4($a2)
    /* B114C 800C094C D000A2C8 */  lwc2       $2, 0xD0($a1)
    /* B1150 800C0950 D400A3C8 */  lwc2       $3, 0xD4($a1)
    /* B1154 800C0954 D00084C8 */  lwc2       $4, 0xD0($a0)
    /* B1158 800C0958 D40085C8 */  lwc2       $5, 0xD4($a0)
    /* B115C 800C095C 00000000 */  nop
    /* B1160 800C0960 00000000 */  nop
    /* B1164 800C0964 3000284A */  .word 0x4A280030  /* rtpt */
    /* B1168 800C0968 00000000 */  nop
    /* B116C 800C096C 00000000 */  nop
    /* B1170 800C0970 0600404B */  .word 0x4B400006  /* nclip */
    /* B1174 800C0974 440038EA */  swc2       $24, 0x44($s1)
    /* B1178 800C0978 0C00228E */  lw         $v0, 0xC($s1)
    /* B117C 800C097C 4400238E */  lw         $v1, 0x44($s1)
    /* B1180 800C0980 02004010 */  beqz       $v0, .L800C098C
    /* B1184 800C0984 00000000 */   nop
    /* B1188 800C0988 23180300 */  negu       $v1, $v1
  .L800C098C:
    /* B118C 800C098C D9FF6018 */  blez       $v1, .L800C08F4
    /* B1190 800C0990 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1194 800C0994 01004A25 */  addiu      $t2, $t2, 0x1
    /* B1198 800C0998 00000000 */  nop
    /* B119C 800C099C 00000000 */  nop
    /* B11A0 800C09A0 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B11A4 800C09A4 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B11A8 800C09A8 02000291 */  lbu        $v0, 0x2($t0)
    /* B11AC 800C09AC 00000000 */  nop
    /* B11B0 800C09B0 40100200 */  sll        $v0, $v0, 1
    /* B11B4 800C09B4 21104F00 */  addu       $v0, $v0, $t7
    /* B11B8 800C09B8 00004294 */  lhu        $v0, 0x0($v0)
    /* B11BC 800C09BC 00000000 */  nop
    /* B11C0 800C09C0 00140200 */  sll        $v0, $v0, 16
    /* B11C4 800C09C4 032C0200 */  sra        $a1, $v0, 16
    /* B11C8 800C09C8 2600A010 */  beqz       $a1, .L800C0A64
    /* B11CC 800C09CC 00000000 */   nop
    /* B11D0 800C09D0 00000685 */  lh         $a2, 0x0($t0)
    /* B11D4 800C09D4 3C00248E */  lw         $a0, 0x3C($s1)
    /* B11D8 800C09D8 0200C104 */  bgez       $a2, .L800C09E4
    /* B11DC 800C09DC FF00A530 */   andi      $a1, $a1, 0xFF
    /* B11E0 800C09E0 032E0200 */  sra        $a1, $v0, 24
  .L800C09E4:
    /* B11E4 800C09E4 4000228E */  lw         $v0, 0x40($s1)
    /* B11E8 800C09E8 00000000 */  nop
    /* B11EC 800C09EC 21208200 */  addu       $a0, $a0, $v0
    /* B11F0 800C09F0 4000A230 */  andi       $v0, $a1, 0x40
    /* B11F4 800C09F4 02004010 */  beqz       $v0, .L800C0A00
    /* B11F8 800C09F8 00000000 */   nop
    /* B11FC 800C09FC FEFF8424 */  addiu      $a0, $a0, -0x2
  .L800C0A00:
    /* B1200 800C0A00 BCFF8004 */  bltz       $a0, .L800C08F4
    /* B1204 800C0A04 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1208 800C0A08 01004A25 */  addiu      $t2, $t2, 0x1
    /* B120C 800C0A0C 8800228E */  lw         $v0, 0x88($s1)
    /* B1210 800C0A10 00000000 */  nop
    /* B1214 800C0A14 2A104400 */  slt        $v0, $v0, $a0
    /* B1218 800C0A18 B6FF4014 */  bnez       $v0, .L800C08F4
    /* B121C 800C0A1C FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1220 800C0A20 01004A25 */  addiu      $t2, $t2, 0x1
    /* B1224 800C0A24 FF0FC330 */  andi       $v1, $a2, 0xFFF
    /* B1228 800C0A28 F003C230 */  andi       $v0, $a2, 0x3F0
    /* B122C 800C0A2C 0B004010 */  beqz       $v0, .L800C0A5C
    /* B1230 800C0A30 21486000 */   addu      $t1, $v1, $zero
    /* B1234 800C0A34 02110300 */  srl        $v0, $v1, 4
    /* B1238 800C0A38 2428A200 */  and        $a1, $a1, $v0
    /* B123C 800C0A3C 0700A010 */  beqz       $a1, .L800C0A5C
    /* B1240 800C0A40 0300A230 */   andi      $v0, $a1, 0x3
    /* B1244 800C0A44 05004014 */  bnez       $v0, .L800C0A5C
    /* B1248 800C0A48 00000000 */   nop
  .L800C0A4C:
    /* B124C 800C0A4C 83280500 */  sra        $a1, $a1, 2
    /* B1250 800C0A50 0300A230 */  andi       $v0, $a1, 0x3
    /* B1254 800C0A54 FDFF4010 */  beqz       $v0, .L800C0A4C
    /* B1258 800C0A58 00000000 */   nop
  .L800C0A5C:
    /* B125C 800C0A5C A8020308 */  j          .L800C0AA0
    /* B1260 800C0A60 3C0024AE */   sw        $a0, 0x3C($s1)
  .L800C0A64:
    /* B1264 800C0A64 3C00238E */  lw         $v1, 0x3C($s1)
    /* B1268 800C0A68 4000228E */  lw         $v0, 0x40($s1)
    /* B126C 800C0A6C 00000000 */  nop
    /* B1270 800C0A70 21186200 */  addu       $v1, $v1, $v0
    /* B1274 800C0A74 9EFF6004 */  bltz       $v1, .L800C08F0
    /* B1278 800C0A78 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B127C 800C0A7C 8800228E */  lw         $v0, 0x88($s1)
    /* B1280 800C0A80 00000000 */  nop
    /* B1284 800C0A84 2A104300 */  slt        $v0, $v0, $v1
    /* B1288 800C0A88 9AFF4014 */  bnez       $v0, .L800C08F4
    /* B128C 800C0A8C FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1290 800C0A90 01004A25 */  addiu      $t2, $t2, 0x1
    /* B1294 800C0A94 00000295 */  lhu        $v0, 0x0($t0)
    /* B1298 800C0A98 00000000 */  nop
    /* B129C 800C0A9C FF0F4930 */  andi       $t1, $v0, 0xFFF
  .L800C0AA0:
    /* B12A0 800C0AA0 0300A430 */  andi       $a0, $a1, 0x3
    /* B12A4 800C0AA4 42008010 */  beqz       $a0, .L800C0BB0
    /* B12A8 800C0AA8 FFFF8424 */   addiu     $a0, $a0, -0x1
    /* B12AC 800C0AAC 02000391 */  lbu        $v1, 0x2($t0)
    /* B12B0 800C0AB0 0400278E */  lw         $a3, 0x4($s1)
    /* B12B4 800C0AB4 40100300 */  sll        $v0, $v1, 1
    /* B12B8 800C0AB8 21104300 */  addu       $v0, $v0, $v1
    /* B12BC 800C0ABC 21104400 */  addu       $v0, $v0, $a0
    /* B12C0 800C0AC0 80100200 */  sll        $v0, $v0, 2
    /* B12C4 800C0AC4 2130C202 */  addu       $a2, $s6, $v0
    /* B12C8 800C0AC8 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B12CC 800C0ACC 38002D8E */  lw         $t5, 0x38($s1)
    /* B12D0 800C0AD0 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B12D4 800C0AD4 80600C00 */  sll        $t4, $t4, 2
    /* B12D8 800C0AD8 2168AC01 */  addu       $t5, $t5, $t4
    /* B12DC 800C0ADC 04002EAE */  sw         $t6, 0x4($s1)
    /* B12E0 800C0AE0 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B12E4 800C0AE4 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B12E8 800C0AE8 02720E00 */  srl        $t6, $t6, 8
    /* B12EC 800C0AEC 2570CC01 */  or         $t6, $t6, $t4
    /* B12F0 800C0AF0 00620700 */  sll        $t4, $a3, 8
    /* B12F4 800C0AF4 0000EEAC */  sw         $t6, 0x0($a3)
    /* B12F8 800C0AF8 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B12FC 800C0AFC 0800ECE8 */  swc2       $12, 0x8($a3)
    /* B1300 800C0B00 1000EDE8 */  swc2       $13, 0x10($a3)
    /* B1304 800C0B04 1800EEE8 */  swc2       $14, 0x18($a3)
    /* B1308 800C0B08 8000043C */  lui        $a0, (0x808080 >> 16)
    /* B130C 800C0B0C 8000A230 */  andi       $v0, $a1, 0x80
    /* B1310 800C0B10 02004014 */  bnez       $v0, .L800C0B1C
    /* B1314 800C0B14 80808434 */   ori       $a0, $a0, (0x808080 & 0xFFFF)
    /* B1318 800C0B18 8C00248E */  lw         $a0, 0x8C($s1)
  .L800C0B1C:
    /* B131C 800C0B1C 01002231 */  andi       $v0, $t1, 0x1
    /* B1320 800C0B20 02004010 */  beqz       $v0, .L800C0B2C
    /* B1324 800C0B24 24000324 */   addiu     $v1, $zero, 0x24
    /* B1328 800C0B28 26000324 */  addiu      $v1, $zero, 0x26
  .L800C0B2C:
    /* B132C 800C0B2C 0400E4AC */  sw         $a0, 0x4($a3)
    /* B1330 800C0B30 0700E3A0 */  sb         $v1, 0x7($a3)
    /* B1334 800C0B34 02000391 */  lbu        $v1, 0x2($t0)
    /* B1338 800C0B38 0000C284 */  lh         $v0, 0x0($a2)
    /* B133C 800C0B3C 0200C590 */  lbu        $a1, 0x2($a2)
    /* B1340 800C0B40 0300C690 */  lbu        $a2, 0x3($a2)
    /* B1344 800C0B44 21186200 */  addu       $v1, $v1, $v0
    /* B1348 800C0B48 6000228E */  lw         $v0, 0x60($s1)
    /* B134C 800C0B4C 00190300 */  sll        $v1, $v1, 4
    /* B1350 800C0B50 21104300 */  addu       $v0, $v0, $v1
    /* B1354 800C0B54 02004394 */  lhu        $v1, 0x2($v0)
    /* B1358 800C0B58 06004294 */  lhu        $v0, 0x6($v0)
    /* B135C 800C0B5C 0E00E3A4 */  sh         $v1, 0xE($a3)
    /* B1360 800C0B60 1600E2A4 */  sh         $v0, 0x16($a3)
    /* B1364 800C0B64 06000291 */  lbu        $v0, 0x6($t0)
    /* B1368 800C0B68 08000391 */  lbu        $v1, 0x8($t0)
    /* B136C 800C0B6C 0A000491 */  lbu        $a0, 0xA($t0)
    /* B1370 800C0B70 21104500 */  addu       $v0, $v0, $a1
    /* B1374 800C0B74 21186500 */  addu       $v1, $v1, $a1
    /* B1378 800C0B78 21208500 */  addu       $a0, $a0, $a1
    /* B137C 800C0B7C 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B1380 800C0B80 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B1384 800C0B84 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B1388 800C0B88 07000291 */  lbu        $v0, 0x7($t0)
    /* B138C 800C0B8C 09000391 */  lbu        $v1, 0x9($t0)
    /* B1390 800C0B90 0B000491 */  lbu        $a0, 0xB($t0)
    /* B1394 800C0B94 21104600 */  addu       $v0, $v0, $a2
    /* B1398 800C0B98 21186600 */  addu       $v1, $v1, $a2
    /* B139C 800C0B9C 21208600 */  addu       $a0, $a0, $a2
    /* B13A0 800C0BA0 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B13A4 800C0BA4 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B13A8 800C0BA8 3C020308 */  j          .L800C08F0
    /* B13AC 800C0BAC 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C0BB0:
    /* B13B0 800C0BB0 0400278E */  lw         $a3, 0x4($s1)
    /* B13B4 800C0BB4 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B13B8 800C0BB8 38002D8E */  lw         $t5, 0x38($s1)
    /* B13BC 800C0BBC 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B13C0 800C0BC0 80600C00 */  sll        $t4, $t4, 2
    /* B13C4 800C0BC4 2168AC01 */  addu       $t5, $t5, $t4
    /* B13C8 800C0BC8 04002EAE */  sw         $t6, 0x4($s1)
    /* B13CC 800C0BCC 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B13D0 800C0BD0 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B13D4 800C0BD4 02720E00 */  srl        $t6, $t6, 8
    /* B13D8 800C0BD8 2570CC01 */  or         $t6, $t6, $t4
    /* B13DC 800C0BDC 00620700 */  sll        $t4, $a3, 8
    /* B13E0 800C0BE0 0000EEAC */  sw         $t6, 0x0($a3)
    /* B13E4 800C0BE4 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B13E8 800C0BE8 0800ECE8 */  swc2       $12, 0x8($a3)
    /* B13EC 800C0BEC 1000EDE8 */  swc2       $13, 0x10($a3)
    /* B13F0 800C0BF0 1800EEE8 */  swc2       $14, 0x18($a3)
    /* B13F4 800C0BF4 8000043C */  lui        $a0, (0x808080 >> 16)
    /* B13F8 800C0BF8 8000A230 */  andi       $v0, $a1, 0x80
    /* B13FC 800C0BFC 02004014 */  bnez       $v0, .L800C0C08
    /* B1400 800C0C00 80808434 */   ori       $a0, $a0, (0x808080 & 0xFFFF)
    /* B1404 800C0C04 8C00248E */  lw         $a0, 0x8C($s1)
  .L800C0C08:
    /* B1408 800C0C08 01002231 */  andi       $v0, $t1, 0x1
    /* B140C 800C0C0C 02004010 */  beqz       $v0, .L800C0C18
    /* B1410 800C0C10 24000324 */   addiu     $v1, $zero, 0x24
    /* B1414 800C0C14 26000324 */  addiu      $v1, $zero, 0x26
  .L800C0C18:
    /* B1418 800C0C18 0400E4AC */  sw         $a0, 0x4($a3)
    /* B141C 800C0C1C 0700E3A0 */  sb         $v1, 0x7($a3)
    /* B1420 800C0C20 02000291 */  lbu        $v0, 0x2($t0)
    /* B1424 800C0C24 6000238E */  lw         $v1, 0x60($s1)
    /* B1428 800C0C28 00110200 */  sll        $v0, $v0, 4
    /* B142C 800C0C2C 21186200 */  addu       $v1, $v1, $v0
    /* B1430 800C0C30 02006294 */  lhu        $v0, 0x2($v1)
    /* B1434 800C0C34 06006394 */  lhu        $v1, 0x6($v1)
    /* B1438 800C0C38 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B143C 800C0C3C 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B1440 800C0C40 06000295 */  lhu        $v0, 0x6($t0)
    /* B1444 800C0C44 08000395 */  lhu        $v1, 0x8($t0)
    /* B1448 800C0C48 0A000495 */  lhu        $a0, 0xA($t0)
    /* B144C 800C0C4C 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B1450 800C0C50 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B1454 800C0C54 3C020308 */  j          .L800C08F0
    /* B1458 800C0C58 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C0C5C:
    /* B145C 800C0C5C 40100A00 */  sll        $v0, $t2, 1
    /* B1460 800C0C60 21104A00 */  addu       $v0, $v0, $t2
    /* B1464 800C0C64 80900200 */  sll        $s2, $v0, 2
  .L800C0C68:
    /* B1468 800C0C68 FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800C0C6C:
    /* B146C 800C0C6C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B1470 800C0C70 96014211 */  beq        $t2, $v0, .L800C12CC
    /* B1474 800C0C74 F4FF5226 */   addiu     $s2, $s2, -0xC
    /* B1478 800C0C78 1800A28E */  lw         $v0, 0x18($s5)
    /* B147C 800C0C7C 0800238E */  lw         $v1, 0x8($s1)
    /* B1480 800C0C80 21405200 */  addu       $t0, $v0, $s2
    /* B1484 800C0C84 03001991 */  lbu        $t9, 0x3($t0)
    /* B1488 800C0C88 04001891 */  lbu        $t8, 0x4($t0)
    /* B148C 800C0C8C 0400228E */  lw         $v0, 0x4($s1)
    /* B1490 800C0C90 05000B91 */  lbu        $t3, 0x5($t0)
    /* B1494 800C0C94 2B104300 */  sltu       $v0, $v0, $v1
    /* B1498 800C0C98 F4FF4010 */  beqz       $v0, .L800C0C6C
    /* B149C 800C0C9C FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B14A0 800C0CA0 01004A25 */  addiu      $t2, $t2, 0x1
    /* B14A4 800C0CA4 C0C81900 */  sll        $t9, $t9, 3
    /* B14A8 800C0CA8 21C83103 */  addu       $t9, $t9, $s1
    /* B14AC 800C0CAC C0C01800 */  sll        $t8, $t8, 3
    /* B14B0 800C0CB0 21C01103 */  addu       $t8, $t8, $s1
    /* B14B4 800C0CB4 C0580B00 */  sll        $t3, $t3, 3
    /* B14B8 800C0CB8 21587101 */  addu       $t3, $t3, $s1
    /* B14BC 800C0CBC D00020CB */  lwc2       $0, 0xD0($t9)
    /* B14C0 800C0CC0 D40021CB */  lwc2       $1, 0xD4($t9)
    /* B14C4 800C0CC4 D00002CB */  lwc2       $2, 0xD0($t8)
    /* B14C8 800C0CC8 D40003CB */  lwc2       $3, 0xD4($t8)
    /* B14CC 800C0CCC D00064C9 */  lwc2       $4, 0xD0($t3)
    /* B14D0 800C0CD0 D40065C9 */  lwc2       $5, 0xD4($t3)
    /* B14D4 800C0CD4 00000000 */  nop
    /* B14D8 800C0CD8 00000000 */  nop
    /* B14DC 800C0CDC 3000284A */  .word 0x4A280030  /* rtpt */
    /* B14E0 800C0CE0 00000000 */  nop
    /* B14E4 800C0CE4 00000000 */  nop
    /* B14E8 800C0CE8 0600404B */  .word 0x4B400006  /* nclip */
    /* B14EC 800C0CEC 440038EA */  swc2       $24, 0x44($s1)
    /* B14F0 800C0CF0 0C00228E */  lw         $v0, 0xC($s1)
    /* B14F4 800C0CF4 4400238E */  lw         $v1, 0x44($s1)
    /* B14F8 800C0CF8 02004010 */  beqz       $v0, .L800C0D04
    /* B14FC 800C0CFC 00000000 */   nop
    /* B1500 800C0D00 23180300 */  negu       $v1, $v1
  .L800C0D04:
    /* B1504 800C0D04 D9FF6018 */  blez       $v1, .L800C0C6C
    /* B1508 800C0D08 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B150C 800C0D0C 01004A25 */  addiu      $t2, $t2, 0x1
    /* B1510 800C0D10 C4002CEA */  swc2       $12, 0xC4($s1)
    /* B1514 800C0D14 C8002DEA */  swc2       $13, 0xC8($s1)
    /* B1518 800C0D18 CC002EEA */  swc2       $14, 0xCC($s1)
    /* B151C 800C0D1C 00000000 */  nop
    /* B1520 800C0D20 00000000 */  nop
    /* B1524 800C0D24 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B1528 800C0D28 3C0027EA */  swc2       $7, 0x3C($s1)
    /* B152C 800C0D2C 1280173C */  lui        $s7, %hi(DrawC_gOverlay)
    /* B1530 800C0D30 02000291 */  lbu        $v0, 0x2($t0)
    /* B1534 800C0D34 08F5F726 */  addiu      $s7, $s7, %lo(DrawC_gOverlay)
    /* B1538 800C0D38 40100200 */  sll        $v0, $v0, 1
    /* B153C 800C0D3C 21105700 */  addu       $v0, $v0, $s7
    /* B1540 800C0D40 00004294 */  lhu        $v0, 0x0($v0)
    /* B1544 800C0D44 00000000 */  nop
    /* B1548 800C0D48 00140200 */  sll        $v0, $v0, 16
    /* B154C 800C0D4C 03340200 */  sra        $a2, $v0, 16
    /* B1550 800C0D50 2200C010 */  beqz       $a2, .L800C0DDC
    /* B1554 800C0D54 00000000 */   nop
    /* B1558 800C0D58 00000485 */  lh         $a0, 0x0($t0)
    /* B155C 800C0D5C 3C00258E */  lw         $a1, 0x3C($s1)
    /* B1560 800C0D60 02008104 */  bgez       $a0, .L800C0D6C
    /* B1564 800C0D64 FF00C630 */   andi      $a2, $a2, 0xFF
    /* B1568 800C0D68 03360200 */  sra        $a2, $v0, 24
  .L800C0D6C:
    /* B156C 800C0D6C 4000228E */  lw         $v0, 0x40($s1)
    /* B1570 800C0D70 00000000 */  nop
    /* B1574 800C0D74 2128A200 */  addu       $a1, $a1, $v0
    /* B1578 800C0D78 BCFFA004 */  bltz       $a1, .L800C0C6C
    /* B157C 800C0D7C FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1580 800C0D80 01004A25 */  addiu      $t2, $t2, 0x1
    /* B1584 800C0D84 8800228E */  lw         $v0, 0x88($s1)
    /* B1588 800C0D88 00000000 */  nop
    /* B158C 800C0D8C 2A104500 */  slt        $v0, $v0, $a1
    /* B1590 800C0D90 B6FF4014 */  bnez       $v0, .L800C0C6C
    /* B1594 800C0D94 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1598 800C0D98 01004A25 */  addiu      $t2, $t2, 0x1
    /* B159C 800C0D9C FF0F8330 */  andi       $v1, $a0, 0xFFF
    /* B15A0 800C0DA0 F0038230 */  andi       $v0, $a0, 0x3F0
    /* B15A4 800C0DA4 0B004010 */  beqz       $v0, .L800C0DD4
    /* B15A8 800C0DA8 21486000 */   addu      $t1, $v1, $zero
    /* B15AC 800C0DAC 02110300 */  srl        $v0, $v1, 4
    /* B15B0 800C0DB0 2430C200 */  and        $a2, $a2, $v0
    /* B15B4 800C0DB4 0700C010 */  beqz       $a2, .L800C0DD4
    /* B15B8 800C0DB8 0300C230 */   andi      $v0, $a2, 0x3
    /* B15BC 800C0DBC 05004014 */  bnez       $v0, .L800C0DD4
    /* B15C0 800C0DC0 00000000 */   nop
  .L800C0DC4:
    /* B15C4 800C0DC4 83300600 */  sra        $a2, $a2, 2
    /* B15C8 800C0DC8 0300C230 */  andi       $v0, $a2, 0x3
    /* B15CC 800C0DCC FDFF4010 */  beqz       $v0, .L800C0DC4
    /* B15D0 800C0DD0 00000000 */   nop
  .L800C0DD4:
    /* B15D4 800C0DD4 86030308 */  j          .L800C0E18
    /* B15D8 800C0DD8 3C0025AE */   sw        $a1, 0x3C($s1)
  .L800C0DDC:
    /* B15DC 800C0DDC 3C00238E */  lw         $v1, 0x3C($s1)
    /* B15E0 800C0DE0 4000228E */  lw         $v0, 0x40($s1)
    /* B15E4 800C0DE4 00000000 */  nop
    /* B15E8 800C0DE8 21186200 */  addu       $v1, $v1, $v0
    /* B15EC 800C0DEC 9EFF6004 */  bltz       $v1, .L800C0C68
    /* B15F0 800C0DF0 3C0023AE */   sw        $v1, 0x3C($s1)
    /* B15F4 800C0DF4 8800228E */  lw         $v0, 0x88($s1)
    /* B15F8 800C0DF8 00000000 */  nop
    /* B15FC 800C0DFC 2A104300 */  slt        $v0, $v0, $v1
    /* B1600 800C0E00 9AFF4014 */  bnez       $v0, .L800C0C6C
    /* B1604 800C0E04 FFFF4A25 */   addiu     $t2, $t2, -0x1
    /* B1608 800C0E08 01004A25 */  addiu      $t2, $t2, 0x1
    /* B160C 800C0E0C 00000295 */  lhu        $v0, 0x0($t0)
    /* B1610 800C0E10 00000000 */  nop
    /* B1614 800C0E14 FF0F4930 */  andi       $t1, $v0, 0xFFF
  .L800C0E18:
    /* B1618 800C0E18 F3032231 */  andi       $v0, $t1, 0x3F3
    /* B161C 800C0E1C 7E004010 */  beqz       $v0, .L800C1018
    /* B1620 800C0E20 00000000 */   nop
    /* B1624 800C0E24 7400228E */  lw         $v0, 0x74($s1)
    /* B1628 800C0E28 00000000 */  nop
    /* B162C 800C0E2C 7A004010 */  beqz       $v0, .L800C1018
    /* B1630 800C0E30 00000000 */   nop
    /* B1634 800C0E34 03000391 */  lbu        $v1, 0x3($t0)
    /* B1638 800C0E38 00000000 */  nop
    /* B163C 800C0E3C 40100300 */  sll        $v0, $v1, 1
    /* B1640 800C0E40 21104300 */  addu       $v0, $v0, $v1
    /* B1644 800C0E44 40100200 */  sll        $v0, $v0, 1
    /* B1648 800C0E48 21106202 */  addu       $v0, $s3, $v0
    /* B164C 800C0E4C 00004394 */  lhu        $v1, 0x0($v0)
    /* B1650 800C0E50 02004494 */  lhu        $a0, 0x2($v0)
    /* B1654 800C0E54 04004294 */  lhu        $v0, 0x4($v0)
    /* B1658 800C0E58 AC0023A6 */  sh         $v1, 0xAC($s1)
    /* B165C 800C0E5C AE0024A6 */  sh         $a0, 0xAE($s1)
    /* B1660 800C0E60 B00022A6 */  sh         $v0, 0xB0($s1)
    /* B1664 800C0E64 04000391 */  lbu        $v1, 0x4($t0)
    /* B1668 800C0E68 00000000 */  nop
    /* B166C 800C0E6C 40100300 */  sll        $v0, $v1, 1
    /* B1670 800C0E70 21104300 */  addu       $v0, $v0, $v1
    /* B1674 800C0E74 40100200 */  sll        $v0, $v0, 1
    /* B1678 800C0E78 21106202 */  addu       $v0, $s3, $v0
    /* B167C 800C0E7C 00004394 */  lhu        $v1, 0x0($v0)
    /* B1680 800C0E80 02004494 */  lhu        $a0, 0x2($v0)
    /* B1684 800C0E84 04004294 */  lhu        $v0, 0x4($v0)
    /* B1688 800C0E88 B40023A6 */  sh         $v1, 0xB4($s1)
    /* B168C 800C0E8C B60024A6 */  sh         $a0, 0xB6($s1)
    /* B1690 800C0E90 B80022A6 */  sh         $v0, 0xB8($s1)
    /* B1694 800C0E94 05000391 */  lbu        $v1, 0x5($t0)
    /* B1698 800C0E98 00000000 */  nop
    /* B169C 800C0E9C 40100300 */  sll        $v0, $v1, 1
    /* B16A0 800C0EA0 21104300 */  addu       $v0, $v0, $v1
    /* B16A4 800C0EA4 40100200 */  sll        $v0, $v0, 1
    /* B16A8 800C0EA8 21106202 */  addu       $v0, $s3, $v0
    /* B16AC 800C0EAC 00004394 */  lhu        $v1, 0x0($v0)
    /* B16B0 800C0EB0 02004494 */  lhu        $a0, 0x2($v0)
    /* B16B4 800C0EB4 04004294 */  lhu        $v0, 0x4($v0)
    /* B16B8 800C0EB8 BC0023A6 */  sh         $v1, 0xBC($s1)
    /* B16BC 800C0EBC BE0024A6 */  sh         $a0, 0xBE($s1)
    /* B16C0 800C0EC0 C00022A6 */  sh         $v0, 0xC0($s1)
    /* B16C4 800C0EC4 04002C8E */  lw         $t4, 0x4($s1)
    /* B16C8 800C0EC8 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B16CC 800C0ECC 38002E8E */  lw         $t6, 0x38($s1)
    /* B16D0 800C0ED0 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B16D4 800C0ED4 80680D00 */  sll        $t5, $t5, 2
    /* B16D8 800C0ED8 2170CD01 */  addu       $t6, $t6, $t5
    /* B16DC 800C0EDC 04002FAE */  sw         $t7, 0x4($s1)
    /* B16E0 800C0EE0 54002D8E */  lw         $t5, 0x54($s1)
    /* B16E4 800C0EE4 58002F8E */  lw         $t7, 0x58($s1)
    /* B16E8 800C0EE8 5C00308E */  lw         $s0, 0x5C($s1)
    /* B16EC 800C0EEC 00008DAD */  sw         $t5, 0x0($t4)
    /* B16F0 800C0EF0 04008FAD */  sw         $t7, 0x4($t4)
    /* B16F4 800C0EF4 080090AD */  sw         $s0, 0x8($t4)
    /* B16F8 800C0EF8 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B16FC 800C0EFC 007A0C00 */  sll        $t7, $t4, 8
    /* B1700 800C0F00 02008DA9 */  swl        $t5, 0x2($t4)
    /* B1704 800C0F04 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B1708 800C0F08 0400278E */  lw         $a3, 0x4($s1)
    /* B170C 800C0F0C 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B1710 800C0F10 38002D8E */  lw         $t5, 0x38($s1)
    /* B1714 800C0F14 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B1718 800C0F18 80600C00 */  sll        $t4, $t4, 2
    /* B171C 800C0F1C 2168AC01 */  addu       $t5, $t5, $t4
    /* B1720 800C0F20 04002EAE */  sw         $t6, 0x4($s1)
    /* B1724 800C0F24 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B1728 800C0F28 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B172C 800C0F2C 02720E00 */  srl        $t6, $t6, 8
    /* B1730 800C0F30 2570CC01 */  or         $t6, $t6, $t4
    /* B1734 800C0F34 00620700 */  sll        $t4, $a3, 8
    /* B1738 800C0F38 0000EEAC */  sw         $t6, 0x0($a3)
    /* B173C 800C0F3C 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B1740 800C0F40 04002C8E */  lw         $t4, 0x4($s1)
    /* B1744 800C0F44 3C002D8E */  lw         $t5, 0x3C($s1)
    /* B1748 800C0F48 38002E8E */  lw         $t6, 0x38($s1)
    /* B174C 800C0F4C 0C008F25 */  addiu      $t7, $t4, 0xC
    /* B1750 800C0F50 80680D00 */  sll        $t5, $t5, 2
    /* B1754 800C0F54 2170CD01 */  addu       $t6, $t6, $t5
    /* B1758 800C0F58 04002FAE */  sw         $t7, 0x4($s1)
    /* B175C 800C0F5C 48002D8E */  lw         $t5, 0x48($s1)
    /* B1760 800C0F60 4C002F8E */  lw         $t7, 0x4C($s1)
    /* B1764 800C0F64 5000308E */  lw         $s0, 0x50($s1)
    /* B1768 800C0F68 00008DAD */  sw         $t5, 0x0($t4)
    /* B176C 800C0F6C 04008FAD */  sw         $t7, 0x4($t4)
    /* B1770 800C0F70 080090AD */  sw         $s0, 0x8($t4)
    /* B1774 800C0F74 0200CD89 */  lwl        $t5, 0x2($t6)
    /* B1778 800C0F78 007A0C00 */  sll        $t7, $t4, 8
    /* B177C 800C0F7C 02008DA9 */  swl        $t5, 0x2($t4)
    /* B1780 800C0F80 0200CFA9 */  swl        $t7, 0x2($t6)
    /* B1784 800C0F84 C400228E */  lw         $v0, 0xC4($s1)
    /* B1788 800C0F88 C800238E */  lw         $v1, 0xC8($s1)
    /* B178C 800C0F8C CC00248E */  lw         $a0, 0xCC($s1)
    /* B1790 800C0F90 0800E2AC */  sw         $v0, 0x8($a3)
    /* B1794 800C0F94 1000E3AC */  sw         $v1, 0x10($a3)
    /* B1798 800C0F98 1800E4AC */  sw         $a0, 0x18($a3)
    /* B179C 800C0F9C 9000228E */  lw         $v0, 0x90($s1)
    /* B17A0 800C0FA0 00000000 */  nop
    /* B17A4 800C0FA4 0400E2AC */  sw         $v0, 0x4($a3)
    /* B17A8 800C0FA8 0700F4A0 */  sb         $s4, 0x7($a3)
    /* B17AC 800C0FAC 76002296 */  lhu        $v0, 0x76($s1)
    /* B17B0 800C0FB0 7A002396 */  lhu        $v1, 0x7A($s1)
    /* B17B4 800C0FB4 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B17B8 800C0FB8 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B17BC 800C0FBC 74002E92 */  lbu        $t6, 0x74($s1)
    /* B17C0 800C0FC0 75002F92 */  lbu        $t7, 0x75($s1)
    /* B17C4 800C0FC4 84002D92 */  lbu        $t5, 0x84($s1)
    /* B17C8 800C0FC8 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B17CC 800C0FCC 2178ED01 */  addu       $t7, $t7, $t5
    /* B17D0 800C0FD0 AE002C92 */  lbu        $t4, 0xAE($s1)
    /* B17D4 800C0FD4 B0002D92 */  lbu        $t5, 0xB0($s1)
    /* B17D8 800C0FD8 21608E01 */  addu       $t4, $t4, $t6
    /* B17DC 800C0FDC 0C00ECA0 */  sb         $t4, 0xC($a3)
    /* B17E0 800C0FE0 2168AF01 */  addu       $t5, $t5, $t7
    /* B17E4 800C0FE4 0D00EDA0 */  sb         $t5, 0xD($a3)
    /* B17E8 800C0FE8 B6002C92 */  lbu        $t4, 0xB6($s1)
    /* B17EC 800C0FEC B8002D92 */  lbu        $t5, 0xB8($s1)
    /* B17F0 800C0FF0 21608E01 */  addu       $t4, $t4, $t6
    /* B17F4 800C0FF4 1400ECA0 */  sb         $t4, 0x14($a3)
    /* B17F8 800C0FF8 2168AF01 */  addu       $t5, $t5, $t7
    /* B17FC 800C0FFC 1500EDA0 */  sb         $t5, 0x15($a3)
    /* B1800 800C1000 BE002C92 */  lbu        $t4, 0xBE($s1)
    /* B1804 800C1004 C0002D92 */  lbu        $t5, 0xC0($s1)
    /* B1808 800C1008 21608E01 */  addu       $t4, $t4, $t6
    /* B180C 800C100C 1C00ECA0 */  sb         $t4, 0x1C($a3)
    /* B1810 800C1010 2168AF01 */  addu       $t5, $t5, $t7
    /* B1814 800C1014 1D00EDA0 */  sb         $t5, 0x1D($a3)
  .L800C1018:
    /* B1818 800C1018 6400228E */  lw         $v0, 0x64($s1)
    /* B181C 800C101C 00000000 */  nop
    /* B1820 800C1020 3E004010 */  beqz       $v0, .L800C111C
    /* B1824 800C1024 0300C230 */   andi      $v0, $a2, 0x3
    /* B1828 800C1028 0400278E */  lw         $a3, 0x4($s1)
    /* B182C 800C102C 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B1830 800C1030 38002D8E */  lw         $t5, 0x38($s1)
    /* B1834 800C1034 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B1838 800C1038 80600C00 */  sll        $t4, $t4, 2
    /* B183C 800C103C 2168AC01 */  addu       $t5, $t5, $t4
    /* B1840 800C1040 04002EAE */  sw         $t6, 0x4($s1)
    /* B1844 800C1044 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B1848 800C1048 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B184C 800C104C 02720E00 */  srl        $t6, $t6, 8
    /* B1850 800C1050 2570CC01 */  or         $t6, $t6, $t4
    /* B1854 800C1054 00620700 */  sll        $t4, $a3, 8
    /* B1858 800C1058 0000EEAC */  sw         $t6, 0x0($a3)
    /* B185C 800C105C 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B1860 800C1060 C400228E */  lw         $v0, 0xC4($s1)
    /* B1864 800C1064 C800238E */  lw         $v1, 0xC8($s1)
    /* B1868 800C1068 CC00248E */  lw         $a0, 0xCC($s1)
    /* B186C 800C106C 0800E2AC */  sw         $v0, 0x8($a3)
    /* B1870 800C1070 0100C230 */  andi       $v0, $a2, 0x1
    /* B1874 800C1074 1000E3AC */  sw         $v1, 0x10($a3)
    /* B1878 800C1078 04004010 */  beqz       $v0, .L800C108C
    /* B187C 800C107C 1800E4AC */   sw        $a0, 0x18($a3)
    /* B1880 800C1080 9800228E */  lw         $v0, 0x98($s1)
    /* B1884 800C1084 2C040308 */  j          .L800C10B0
    /* B1888 800C1088 0400E2AC */   sw        $v0, 0x4($a3)
  .L800C108C:
    /* B188C 800C108C 04002231 */  andi       $v0, $t1, 0x4
    /* B1890 800C1090 04004010 */  beqz       $v0, .L800C10A4
    /* B1894 800C1094 00000000 */   nop
    /* B1898 800C1098 9400228E */  lw         $v0, 0x94($s1)
    /* B189C 800C109C 2C040308 */  j          .L800C10B0
    /* B18A0 800C10A0 0400E2AC */   sw        $v0, 0x4($a3)
  .L800C10A4:
    /* B18A4 800C10A4 9000228E */  lw         $v0, 0x90($s1)
    /* B18A8 800C10A8 00000000 */  nop
    /* B18AC 800C10AC 0400E2AC */  sw         $v0, 0x4($a3)
  .L800C10B0:
    /* B18B0 800C10B0 0700F4A0 */  sb         $s4, 0x7($a3)
    /* B18B4 800C10B4 66002296 */  lhu        $v0, 0x66($s1)
    /* B18B8 800C10B8 6A002396 */  lhu        $v1, 0x6A($s1)
    /* B18BC 800C10BC 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B18C0 800C10C0 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B18C4 800C10C4 64002E92 */  lbu        $t6, 0x64($s1)
    /* B18C8 800C10C8 65002F92 */  lbu        $t7, 0x65($s1)
    /* B18CC 800C10CC 4000CE25 */  addiu      $t6, $t6, 0x40
    /* B18D0 800C10D0 D6002C93 */  lbu        $t4, 0xD6($t9)
    /* B18D4 800C10D4 D7002D93 */  lbu        $t5, 0xD7($t9)
    /* B18D8 800C10D8 21608E01 */  addu       $t4, $t4, $t6
    /* B18DC 800C10DC 0C00ECA0 */  sb         $t4, 0xC($a3)
    /* B18E0 800C10E0 2168AF01 */  addu       $t5, $t5, $t7
    /* B18E4 800C10E4 0D00EDA0 */  sb         $t5, 0xD($a3)
    /* B18E8 800C10E8 D6000C93 */  lbu        $t4, 0xD6($t8)
    /* B18EC 800C10EC D7000D93 */  lbu        $t5, 0xD7($t8)
    /* B18F0 800C10F0 21608E01 */  addu       $t4, $t4, $t6
    /* B18F4 800C10F4 1400ECA0 */  sb         $t4, 0x14($a3)
    /* B18F8 800C10F8 2168AF01 */  addu       $t5, $t5, $t7
    /* B18FC 800C10FC 1500EDA0 */  sb         $t5, 0x15($a3)
    /* B1900 800C1100 D6006C91 */  lbu        $t4, 0xD6($t3)
    /* B1904 800C1104 D7006D91 */  lbu        $t5, 0xD7($t3)
    /* B1908 800C1108 21608E01 */  addu       $t4, $t4, $t6
    /* B190C 800C110C 1C00ECA0 */  sb         $t4, 0x1C($a3)
    /* B1910 800C1110 2168AF01 */  addu       $t5, $t5, $t7
    /* B1914 800C1114 1D00EDA0 */  sb         $t5, 0x1D($a3)
    /* B1918 800C1118 0300C230 */  andi       $v0, $a2, 0x3
  .L800C111C:
    /* B191C 800C111C 41004010 */  beqz       $v0, .L800C1224
    /* B1920 800C1120 FFFF4424 */   addiu     $a0, $v0, -0x1
    /* B1924 800C1124 02000391 */  lbu        $v1, 0x2($t0)
    /* B1928 800C1128 0400278E */  lw         $a3, 0x4($s1)
    /* B192C 800C112C 40100300 */  sll        $v0, $v1, 1
    /* B1930 800C1130 21104300 */  addu       $v0, $v0, $v1
    /* B1934 800C1134 21104400 */  addu       $v0, $v0, $a0
    /* B1938 800C1138 80100200 */  sll        $v0, $v0, 2
    /* B193C 800C113C 2130C202 */  addu       $a2, $s6, $v0
    /* B1940 800C1140 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B1944 800C1144 38002D8E */  lw         $t5, 0x38($s1)
    /* B1948 800C1148 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B194C 800C114C 80600C00 */  sll        $t4, $t4, 2
    /* B1950 800C1150 2168AC01 */  addu       $t5, $t5, $t4
    /* B1954 800C1154 04002EAE */  sw         $t6, 0x4($s1)
    /* B1958 800C1158 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B195C 800C115C 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B1960 800C1160 02720E00 */  srl        $t6, $t6, 8
    /* B1964 800C1164 2570CC01 */  or         $t6, $t6, $t4
    /* B1968 800C1168 00620700 */  sll        $t4, $a3, 8
    /* B196C 800C116C 0000EEAC */  sw         $t6, 0x0($a3)
    /* B1970 800C1170 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B1974 800C1174 C400228E */  lw         $v0, 0xC4($s1)
    /* B1978 800C1178 C800238E */  lw         $v1, 0xC8($s1)
    /* B197C 800C117C CC00248E */  lw         $a0, 0xCC($s1)
    /* B1980 800C1180 0800E2AC */  sw         $v0, 0x8($a3)
    /* B1984 800C1184 01002231 */  andi       $v0, $t1, 0x1
    /* B1988 800C1188 1000E3AC */  sw         $v1, 0x10($a3)
    /* B198C 800C118C 1800E4AC */  sw         $a0, 0x18($a3)
    /* B1990 800C1190 8C00238E */  lw         $v1, 0x8C($s1)
    /* B1994 800C1194 02004010 */  beqz       $v0, .L800C11A0
    /* B1998 800C1198 24000524 */   addiu     $a1, $zero, 0x24
    /* B199C 800C119C 26000524 */  addiu      $a1, $zero, 0x26
  .L800C11A0:
    /* B19A0 800C11A0 0400E3AC */  sw         $v1, 0x4($a3)
    /* B19A4 800C11A4 0700E5A0 */  sb         $a1, 0x7($a3)
    /* B19A8 800C11A8 02000391 */  lbu        $v1, 0x2($t0)
    /* B19AC 800C11AC 0000C284 */  lh         $v0, 0x0($a2)
    /* B19B0 800C11B0 0200C590 */  lbu        $a1, 0x2($a2)
    /* B19B4 800C11B4 0300C690 */  lbu        $a2, 0x3($a2)
    /* B19B8 800C11B8 21186200 */  addu       $v1, $v1, $v0
    /* B19BC 800C11BC 6000228E */  lw         $v0, 0x60($s1)
    /* B19C0 800C11C0 00190300 */  sll        $v1, $v1, 4
    /* B19C4 800C11C4 21104300 */  addu       $v0, $v0, $v1
    /* B19C8 800C11C8 02004394 */  lhu        $v1, 0x2($v0)
    /* B19CC 800C11CC 06004294 */  lhu        $v0, 0x6($v0)
    /* B19D0 800C11D0 0E00E3A4 */  sh         $v1, 0xE($a3)
    /* B19D4 800C11D4 1600E2A4 */  sh         $v0, 0x16($a3)
    /* B19D8 800C11D8 06000291 */  lbu        $v0, 0x6($t0)
    /* B19DC 800C11DC 08000391 */  lbu        $v1, 0x8($t0)
    /* B19E0 800C11E0 0A000491 */  lbu        $a0, 0xA($t0)
    /* B19E4 800C11E4 21104500 */  addu       $v0, $v0, $a1
    /* B19E8 800C11E8 21186500 */  addu       $v1, $v1, $a1
    /* B19EC 800C11EC 21208500 */  addu       $a0, $a0, $a1
    /* B19F0 800C11F0 0C00E2A0 */  sb         $v0, 0xC($a3)
    /* B19F4 800C11F4 1400E3A0 */  sb         $v1, 0x14($a3)
    /* B19F8 800C11F8 1C00E4A0 */  sb         $a0, 0x1C($a3)
    /* B19FC 800C11FC 07000291 */  lbu        $v0, 0x7($t0)
    /* B1A00 800C1200 09000391 */  lbu        $v1, 0x9($t0)
    /* B1A04 800C1204 0B000491 */  lbu        $a0, 0xB($t0)
    /* B1A08 800C1208 21104600 */  addu       $v0, $v0, $a2
    /* B1A0C 800C120C 21186600 */  addu       $v1, $v1, $a2
    /* B1A10 800C1210 21208600 */  addu       $a0, $a0, $a2
    /* B1A14 800C1214 0D00E2A0 */  sb         $v0, 0xD($a3)
    /* B1A18 800C1218 1500E3A0 */  sb         $v1, 0x15($a3)
    /* B1A1C 800C121C 1A030308 */  j          .L800C0C68
    /* B1A20 800C1220 1D00E4A0 */   sb        $a0, 0x1D($a3)
  .L800C1224:
    /* B1A24 800C1224 0400278E */  lw         $a3, 0x4($s1)
    /* B1A28 800C1228 3C002C8E */  lw         $t4, 0x3C($s1)
    /* B1A2C 800C122C 38002D8E */  lw         $t5, 0x38($s1)
    /* B1A30 800C1230 2000EE24 */  addiu      $t6, $a3, 0x20
    /* B1A34 800C1234 80600C00 */  sll        $t4, $t4, 2
    /* B1A38 800C1238 2168AC01 */  addu       $t5, $t5, $t4
    /* B1A3C 800C123C 04002EAE */  sw         $t6, 0x4($s1)
    /* B1A40 800C1240 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B1A44 800C1244 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B1A48 800C1248 02720E00 */  srl        $t6, $t6, 8
    /* B1A4C 800C124C 2570CC01 */  or         $t6, $t6, $t4
    /* B1A50 800C1250 00620700 */  sll        $t4, $a3, 8
    /* B1A54 800C1254 0000EEAC */  sw         $t6, 0x0($a3)
    /* B1A58 800C1258 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B1A5C 800C125C C400228E */  lw         $v0, 0xC4($s1)
    /* B1A60 800C1260 C800238E */  lw         $v1, 0xC8($s1)
    /* B1A64 800C1264 CC00248E */  lw         $a0, 0xCC($s1)
    /* B1A68 800C1268 0800E2AC */  sw         $v0, 0x8($a3)
    /* B1A6C 800C126C 01002231 */  andi       $v0, $t1, 0x1
    /* B1A70 800C1270 1000E3AC */  sw         $v1, 0x10($a3)
    /* B1A74 800C1274 1800E4AC */  sw         $a0, 0x18($a3)
    /* B1A78 800C1278 8C00238E */  lw         $v1, 0x8C($s1)
    /* B1A7C 800C127C 02004010 */  beqz       $v0, .L800C1288
    /* B1A80 800C1280 24000524 */   addiu     $a1, $zero, 0x24
    /* B1A84 800C1284 26000524 */  addiu      $a1, $zero, 0x26
  .L800C1288:
    /* B1A88 800C1288 0400E3AC */  sw         $v1, 0x4($a3)
    /* B1A8C 800C128C 0700E5A0 */  sb         $a1, 0x7($a3)
    /* B1A90 800C1290 02000291 */  lbu        $v0, 0x2($t0)
    /* B1A94 800C1294 6000238E */  lw         $v1, 0x60($s1)
    /* B1A98 800C1298 00110200 */  sll        $v0, $v0, 4
    /* B1A9C 800C129C 21186200 */  addu       $v1, $v1, $v0
    /* B1AA0 800C12A0 02006294 */  lhu        $v0, 0x2($v1)
    /* B1AA4 800C12A4 06006394 */  lhu        $v1, 0x6($v1)
    /* B1AA8 800C12A8 0E00E2A4 */  sh         $v0, 0xE($a3)
    /* B1AAC 800C12AC 1600E3A4 */  sh         $v1, 0x16($a3)
    /* B1AB0 800C12B0 06000295 */  lhu        $v0, 0x6($t0)
    /* B1AB4 800C12B4 08000395 */  lhu        $v1, 0x8($t0)
    /* B1AB8 800C12B8 0A000495 */  lhu        $a0, 0xA($t0)
    /* B1ABC 800C12BC 0C00E2A4 */  sh         $v0, 0xC($a3)
    /* B1AC0 800C12C0 1400E3A4 */  sh         $v1, 0x14($a3)
    /* B1AC4 800C12C4 1A030308 */  j          .L800C0C68
    /* B1AC8 800C12C8 1C00E4A4 */   sh        $a0, 0x1C($a3)
  .L800C12CC:
    /* B1ACC 800C12CC 3000BF8F */  lw         $ra, 0x30($sp)
    /* B1AD0 800C12D0 2C00B78F */  lw         $s7, 0x2C($sp)
    /* B1AD4 800C12D4 2800B68F */  lw         $s6, 0x28($sp)
    /* B1AD8 800C12D8 2400B58F */  lw         $s5, 0x24($sp)
    /* B1ADC 800C12DC 2000B48F */  lw         $s4, 0x20($sp)
    /* B1AE0 800C12E0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* B1AE4 800C12E4 1800B28F */  lw         $s2, 0x18($sp)
    /* B1AE8 800C12E8 1400B18F */  lw         $s1, 0x14($sp)
    /* B1AEC 800C12EC 1000B08F */  lw         $s0, 0x10($sp)
    /* B1AF0 800C12F0 0800E003 */  jr         $ra
    /* B1AF4 800C12F4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
