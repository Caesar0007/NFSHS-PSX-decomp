.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i, 0x1D0

glabel CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
    /* CEEF4 800DE6F4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* CEEF8 800DE6F8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CEEFC 800DE6FC 4000B38F */  lw         $s3, 0x40($sp)
    /* CEF00 800DE700 2400B5AF */  sw         $s5, 0x24($sp)
    /* CEF04 800DE704 21A88000 */  addu       $s5, $a0, $zero
    /* CEF08 800DE708 2800B6AF */  sw         $s6, 0x28($sp)
    /* CEF0C 800DE70C 21B0A000 */  addu       $s6, $a1, $zero
    /* CEF10 800DE710 1800B2AF */  sw         $s2, 0x18($sp)
    /* CEF14 800DE714 2190C000 */  addu       $s2, $a2, $zero
    /* CEF18 800DE718 1000B0AF */  sw         $s0, 0x10($sp)
    /* CEF1C 800DE71C 2180E000 */  addu       $s0, $a3, $zero
    /* CEF20 800DE720 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* CEF24 800DE724 2000B4AF */  sw         $s4, 0x20($sp)
    /* CEF28 800DE728 1400B1AF */  sw         $s1, 0x14($sp)
    /* CEF2C 800DE72C 0000048E */  lw         $a0, 0x0($s0)
    /* CEF30 800DE730 0800058E */  lw         $a1, 0x8($s0)
    /* CEF34 800DE734 4400B48F */  lw         $s4, 0x44($sp)
    /* CEF38 800DE738 0000638E */  lw         $v1, 0x0($s3)
    /* CEF3C 800DE73C 0800628E */  lw         $v0, 0x8($s3)
    /* CEF40 800DE740 23206400 */  subu       $a0, $v1, $a0
    /* CEF44 800DE744 CE96030C */  jal        intatan
    /* CEF48 800DE748 23284500 */   subu      $a1, $v0, $a1
    /* CEF4C 800DE74C 21884000 */  addu       $s1, $v0, $zero
    /* CEF50 800DE750 39C6030C */  jal        intcos
    /* CEF54 800DE754 21202002 */   addu      $a0, $s1, $zero
    /* CEF58 800DE758 21208002 */  addu       $a0, $s4, $zero
    /* CEF5C 800DE75C CA90030C */  jal        fixedmult
    /* CEF60 800DE760 23280200 */   negu      $a1, $v0
    /* CEF64 800DE764 21202002 */  addu       $a0, $s1, $zero
    /* CEF68 800DE768 3AC6030C */  jal        intsin
    /* CEF6C 800DE76C 43880200 */   sra       $s1, $v0, 1
    /* CEF70 800DE770 21208002 */  addu       $a0, $s4, $zero
    /* CEF74 800DE774 CA90030C */  jal        fixedmult
    /* CEF78 800DE778 21284000 */   addu      $a1, $v0, $zero
    /* CEF7C 800DE77C 0000038E */  lw         $v1, 0x0($s0)
    /* CEF80 800DE780 0000448E */  lw         $a0, 0x0($s2)
    /* CEF84 800DE784 21187100 */  addu       $v1, $v1, $s1
    /* CEF88 800DE788 23186400 */  subu       $v1, $v1, $a0
    /* CEF8C 800DE78C 83190300 */  sra        $v1, $v1, 6
    /* CEF90 800DE790 0000A3A6 */  sh         $v1, 0x0($s5)
    /* CEF94 800DE794 0400038E */  lw         $v1, 0x4($s0)
    /* CEF98 800DE798 0400448E */  lw         $a0, 0x4($s2)
    /* CEF9C 800DE79C 43100200 */  sra        $v0, $v0, 1
    /* CEFA0 800DE7A0 23186400 */  subu       $v1, $v1, $a0
    /* CEFA4 800DE7A4 83190300 */  sra        $v1, $v1, 6
    /* CEFA8 800DE7A8 0200A3A6 */  sh         $v1, 0x2($s5)
    /* CEFAC 800DE7AC 0800038E */  lw         $v1, 0x8($s0)
    /* CEFB0 800DE7B0 0800448E */  lw         $a0, 0x8($s2)
    /* CEFB4 800DE7B4 21186200 */  addu       $v1, $v1, $v0
    /* CEFB8 800DE7B8 23186400 */  subu       $v1, $v1, $a0
    /* CEFBC 800DE7BC 83190300 */  sra        $v1, $v1, 6
    /* CEFC0 800DE7C0 0400A3A6 */  sh         $v1, 0x4($s5)
    /* CEFC4 800DE7C4 0000038E */  lw         $v1, 0x0($s0)
    /* CEFC8 800DE7C8 0000448E */  lw         $a0, 0x0($s2)
    /* CEFCC 800DE7CC 23187100 */  subu       $v1, $v1, $s1
    /* CEFD0 800DE7D0 23186400 */  subu       $v1, $v1, $a0
    /* CEFD4 800DE7D4 83190300 */  sra        $v1, $v1, 6
    /* CEFD8 800DE7D8 0800A3A6 */  sh         $v1, 0x8($s5)
    /* CEFDC 800DE7DC 0400038E */  lw         $v1, 0x4($s0)
    /* CEFE0 800DE7E0 0400448E */  lw         $a0, 0x4($s2)
    /* CEFE4 800DE7E4 00000000 */  nop
    /* CEFE8 800DE7E8 23186400 */  subu       $v1, $v1, $a0
    /* CEFEC 800DE7EC 83190300 */  sra        $v1, $v1, 6
    /* CEFF0 800DE7F0 0A00A3A6 */  sh         $v1, 0xA($s5)
    /* CEFF4 800DE7F4 0800038E */  lw         $v1, 0x8($s0)
    /* CEFF8 800DE7F8 0800448E */  lw         $a0, 0x8($s2)
    /* CEFFC 800DE7FC 23186200 */  subu       $v1, $v1, $v0
    /* CF000 800DE800 23186400 */  subu       $v1, $v1, $a0
    /* CF004 800DE804 83190300 */  sra        $v1, $v1, 6
    /* CF008 800DE808 0C00A3A6 */  sh         $v1, 0xC($s5)
    /* CF00C 800DE80C 0000638E */  lw         $v1, 0x0($s3)
    /* CF010 800DE810 0000448E */  lw         $a0, 0x0($s2)
    /* CF014 800DE814 23187100 */  subu       $v1, $v1, $s1
    /* CF018 800DE818 23186400 */  subu       $v1, $v1, $a0
    /* CF01C 800DE81C 83190300 */  sra        $v1, $v1, 6
    /* CF020 800DE820 0800C3A6 */  sh         $v1, 0x8($s6)
    /* CF024 800DE824 0400638E */  lw         $v1, 0x4($s3)
    /* CF028 800DE828 0400448E */  lw         $a0, 0x4($s2)
    /* CF02C 800DE82C 00000000 */  nop
    /* CF030 800DE830 23186400 */  subu       $v1, $v1, $a0
    /* CF034 800DE834 83190300 */  sra        $v1, $v1, 6
    /* CF038 800DE838 0A00C3A6 */  sh         $v1, 0xA($s6)
    /* CF03C 800DE83C 0800638E */  lw         $v1, 0x8($s3)
    /* CF040 800DE840 0800448E */  lw         $a0, 0x8($s2)
    /* CF044 800DE844 23186200 */  subu       $v1, $v1, $v0
    /* CF048 800DE848 23186400 */  subu       $v1, $v1, $a0
    /* CF04C 800DE84C 83190300 */  sra        $v1, $v1, 6
    /* CF050 800DE850 0C00C3A6 */  sh         $v1, 0xC($s6)
    /* CF054 800DE854 0000638E */  lw         $v1, 0x0($s3)
    /* CF058 800DE858 0000448E */  lw         $a0, 0x0($s2)
    /* CF05C 800DE85C 21187100 */  addu       $v1, $v1, $s1
    /* CF060 800DE860 23186400 */  subu       $v1, $v1, $a0
    /* CF064 800DE864 83190300 */  sra        $v1, $v1, 6
    /* CF068 800DE868 0000C3A6 */  sh         $v1, 0x0($s6)
    /* CF06C 800DE86C 0400638E */  lw         $v1, 0x4($s3)
    /* CF070 800DE870 0400448E */  lw         $a0, 0x4($s2)
    /* CF074 800DE874 00000000 */  nop
    /* CF078 800DE878 23186400 */  subu       $v1, $v1, $a0
    /* CF07C 800DE87C 83190300 */  sra        $v1, $v1, 6
    /* CF080 800DE880 0200C3A6 */  sh         $v1, 0x2($s6)
    /* CF084 800DE884 0800638E */  lw         $v1, 0x8($s3)
    /* CF088 800DE888 0800448E */  lw         $a0, 0x8($s2)
    /* CF08C 800DE88C 21186200 */  addu       $v1, $v1, $v0
    /* CF090 800DE890 23186400 */  subu       $v1, $v1, $a0
    /* CF094 800DE894 83190300 */  sra        $v1, $v1, 6
    /* CF098 800DE898 0400C3A6 */  sh         $v1, 0x4($s6)
    /* CF09C 800DE89C 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* CF0A0 800DE8A0 2800B68F */  lw         $s6, 0x28($sp)
    /* CF0A4 800DE8A4 2400B58F */  lw         $s5, 0x24($sp)
    /* CF0A8 800DE8A8 2000B48F */  lw         $s4, 0x20($sp)
    /* CF0AC 800DE8AC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CF0B0 800DE8B0 1800B28F */  lw         $s2, 0x18($sp)
    /* CF0B4 800DE8B4 1400B18F */  lw         $s1, 0x14($sp)
    /* CF0B8 800DE8B8 1000B08F */  lw         $s0, 0x10($sp)
    /* CF0BC 800DE8BC 0800E003 */  jr         $ra
    /* CF0C0 800DE8C0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
