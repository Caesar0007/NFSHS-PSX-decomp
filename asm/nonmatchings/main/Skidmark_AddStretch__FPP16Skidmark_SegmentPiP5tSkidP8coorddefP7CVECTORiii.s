.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii, 0x39C

glabel Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
    /* CF76C 800DEF6C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* CF770 800DEF70 2800B4AF */  sw         $s4, 0x28($sp)
    /* CF774 800DEF74 5000B48F */  lw         $s4, 0x50($sp)
    /* CF778 800DEF78 2400B3AF */  sw         $s3, 0x24($sp)
    /* CF77C 800DEF7C 5400B38F */  lw         $s3, 0x54($sp)
    /* CF780 800DEF80 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* CF784 800DEF84 5800B58F */  lw         $s5, 0x58($sp)
    /* CF788 800DEF88 3000B6AF */  sw         $s6, 0x30($sp)
    /* CF78C 800DEF8C 21B08000 */  addu       $s6, $a0, $zero
    /* CF790 800DEF90 3400B7AF */  sw         $s7, 0x34($sp)
    /* CF794 800DEF94 21B8A000 */  addu       $s7, $a1, $zero
    /* CF798 800DEF98 2000B2AF */  sw         $s2, 0x20($sp)
    /* CF79C 800DEF9C 2190C000 */  addu       $s2, $a2, $zero
    /* CF7A0 800DEFA0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* CF7A4 800DEFA4 3800BFAF */  sw         $ra, 0x38($sp)
    /* CF7A8 800DEFA8 1800B0AF */  sw         $s0, 0x18($sp)
    /* CF7AC 800DEFAC 1400428E */  lw         $v0, 0x14($s2)
    /* CF7B0 800DEFB0 5C00A68F */  lw         $a2, 0x5C($sp)
    /* CF7B4 800DEFB4 32004014 */  bnez       $v0, .L800DF080
    /* CF7B8 800DEFB8 2188E000 */   addu      $s1, $a3, $zero
    /* CF7BC 800DEFBC 21202002 */  addu       $a0, $s1, $zero
    /* CF7C0 800DEFC0 7B7A030C */  jal        Skidmark_CheckChunk__FP8coorddefii
    /* CF7C4 800DEFC4 02000524 */   addiu     $a1, $zero, 0x2
    /* CF7C8 800DEFC8 21804000 */  addu       $s0, $v0, $zero
    /* CF7CC 800DEFCC 21300002 */  addu       $a2, $s0, $zero
    /* CF7D0 800DEFD0 0C000286 */  lh         $v0, 0xC($s0)
    /* CF7D4 800DEFD4 21384002 */  addu       $a3, $s2, $zero
    /* CF7D8 800DEFD8 1000B1AF */  sw         $s1, 0x10($sp)
    /* CF7DC 800DEFDC 1400B3AF */  sw         $s3, 0x14($sp)
    /* CF7E0 800DEFE0 C0280200 */  sll        $a1, $v0, 3
    /* CF7E4 800DEFE4 2328A200 */  subu       $a1, $a1, $v0
    /* CF7E8 800DEFE8 80280500 */  sll        $a1, $a1, 2
    /* CF7EC 800DEFEC 1000A424 */  addiu      $a0, $a1, 0x10
    /* CF7F0 800DEFF0 21200402 */  addu       $a0, $s0, $a0
    /* CF7F4 800DEFF4 2C00A524 */  addiu      $a1, $a1, 0x2C
    /* CF7F8 800DEFF8 BD79030C */  jal        CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
    /* CF7FC 800DEFFC 21280502 */   addu      $a1, $s0, $a1
    /* CF800 800DF000 0C000486 */  lh         $a0, 0xC($s0)
    /* CF804 800DF004 00000000 */  nop
    /* CF808 800DF008 01008224 */  addiu      $v0, $a0, 0x1
    /* CF80C 800DF00C C0180200 */  sll        $v1, $v0, 3
    /* CF810 800DF010 23186200 */  subu       $v1, $v1, $v0
    /* CF814 800DF014 80180300 */  sll        $v1, $v1, 2
    /* CF818 800DF018 21180302 */  addu       $v1, $s0, $v1
    /* CF81C 800DF01C C0100400 */  sll        $v0, $a0, 3
    /* CF820 800DF020 23104400 */  subu       $v0, $v0, $a0
    /* CF824 800DF024 80100200 */  sll        $v0, $v0, 2
    /* CF828 800DF028 21100202 */  addu       $v0, $s0, $v0
    /* CF82C 800DF02C 0300888A */  lwl        $t0, 0x3($s4)
    /* CF830 800DF030 0000889A */  lwr        $t0, 0x0($s4)
    /* CF834 800DF034 00000000 */  nop
    /* CF838 800DF038 230068A8 */  swl        $t0, 0x23($v1)
    /* CF83C 800DF03C 200068B8 */  swr        $t0, 0x20($v1)
    /* CF840 800DF040 23006888 */  lwl        $t0, 0x23($v1)
    /* CF844 800DF044 20006898 */  lwr        $t0, 0x20($v1)
    /* CF848 800DF048 00000000 */  nop
    /* CF84C 800DF04C 230048A8 */  swl        $t0, 0x23($v0)
    /* CF850 800DF050 200048B8 */  swr        $t0, 0x20($v0)
    /* CF854 800DF054 0C000486 */  lh         $a0, 0xC($s0)
    /* CF858 800DF058 00000000 */  nop
    /* CF85C 800DF05C 01008324 */  addiu      $v1, $a0, 0x1
    /* CF860 800DF060 C0100300 */  sll        $v0, $v1, 3
    /* CF864 800DF064 23104300 */  subu       $v0, $v0, $v1
    /* CF868 800DF068 80100200 */  sll        $v0, $v0, 2
    /* CF86C 800DF06C 21100202 */  addu       $v0, $s0, $v0
    /* CF870 800DF070 240055AC */  sw         $s5, 0x24($v0)
    /* CF874 800DF074 C0100400 */  sll        $v0, $a0, 3
    /* CF878 800DF078 947C0308 */  j          .L800DF250
    /* CF87C 800DF07C 23104400 */   subu      $v0, $v0, $a0
  .L800DF080:
    /* CF880 800DF080 21202002 */  addu       $a0, $s1, $zero
    /* CF884 800DF084 7B7A030C */  jal        Skidmark_CheckChunk__FP8coorddefii
    /* CF888 800DF088 02000524 */   addiu     $a1, $zero, 0x2
    /* CF88C 800DF08C 1800448E */  lw         $a0, 0x18($s2)
    /* CF890 800DF090 8415838F */  lw         $v1, %gp_rel(gUseSm)($gp)
    /* CF894 800DF094 00000000 */  nop
    /* CF898 800DF098 3C008314 */  bne        $a0, $v1, .L800DF18C
    /* CF89C 800DF09C 21804000 */   addu      $s0, $v0, $zero
    /* CF8A0 800DF0A0 21280002 */  addu       $a1, $s0, $zero
    /* CF8A4 800DF0A4 21304002 */  addu       $a2, $s2, $zero
    /* CF8A8 800DF0A8 0C000286 */  lh         $v0, 0xC($s0)
    /* CF8AC 800DF0AC 21382002 */  addu       $a3, $s1, $zero
    /* CF8B0 800DF0B0 1000B3AF */  sw         $s3, 0x10($sp)
    /* CF8B4 800DF0B4 C0200200 */  sll        $a0, $v0, 3
    /* CF8B8 800DF0B8 23208200 */  subu       $a0, $a0, $v0
    /* CF8BC 800DF0BC 80200400 */  sll        $a0, $a0, 2
    /* CF8C0 800DF0C0 10008424 */  addiu      $a0, $a0, 0x10
    /* CF8C4 800DF0C4 317A030C */  jal        CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
    /* CF8C8 800DF0C8 21200402 */   addu      $a0, $s0, $a0
    /* CF8CC 800DF0CC 0C000386 */  lh         $v1, 0xC($s0)
    /* CF8D0 800DF0D0 00000000 */  nop
    /* CF8D4 800DF0D4 C0100300 */  sll        $v0, $v1, 3
    /* CF8D8 800DF0D8 23104300 */  subu       $v0, $v0, $v1
    /* CF8DC 800DF0DC 80100200 */  sll        $v0, $v0, 2
    /* CF8E0 800DF0E0 21100202 */  addu       $v0, $s0, $v0
    /* CF8E4 800DF0E4 0300888A */  lwl        $t0, 0x3($s4)
    /* CF8E8 800DF0E8 0000889A */  lwr        $t0, 0x0($s4)
    /* CF8EC 800DF0EC 00000000 */  nop
    /* CF8F0 800DF0F0 230048A8 */  swl        $t0, 0x23($v0)
    /* CF8F4 800DF0F4 200048B8 */  swr        $t0, 0x20($v0)
    /* CF8F8 800DF0F8 0C000386 */  lh         $v1, 0xC($s0)
    /* CF8FC 800DF0FC 00000000 */  nop
    /* CF900 800DF100 C0100300 */  sll        $v0, $v1, 3
    /* CF904 800DF104 23104300 */  subu       $v0, $v0, $v1
    /* CF908 800DF108 80100200 */  sll        $v0, $v0, 2
    /* CF90C 800DF10C 21100202 */  addu       $v0, $s0, $v0
    /* CF910 800DF110 240055AC */  sw         $s5, 0x24($v0)
    /* CF914 800DF114 0C000386 */  lh         $v1, 0xC($s0)
    /* CF918 800DF118 00000000 */  nop
    /* CF91C 800DF11C C0100300 */  sll        $v0, $v1, 3
    /* CF920 800DF120 23104300 */  subu       $v0, $v0, $v1
    /* CF924 800DF124 80100200 */  sll        $v0, $v0, 2
    /* CF928 800DF128 10004224 */  addiu      $v0, $v0, 0x10
    /* CF92C 800DF12C 1400438E */  lw         $v1, 0x14($s2)
    /* CF930 800DF130 21100202 */  addu       $v0, $s0, $v0
    /* CF934 800DF134 180062AC */  sw         $v0, 0x18($v1)
    /* CF938 800DF138 0C000386 */  lh         $v1, 0xC($s0)
    /* CF93C 800DF13C 00000000 */  nop
    /* CF940 800DF140 C0100300 */  sll        $v0, $v1, 3
    /* CF944 800DF144 23104300 */  subu       $v0, $v0, $v1
    /* CF948 800DF148 80100200 */  sll        $v0, $v0, 2
    /* CF94C 800DF14C 21100202 */  addu       $v0, $s0, $v0
    /* CF950 800DF150 280040AC */  sw         $zero, 0x28($v0)
    /* CF954 800DF154 0C000386 */  lh         $v1, 0xC($s0)
    /* CF958 800DF158 00000000 */  nop
    /* CF95C 800DF15C C0100300 */  sll        $v0, $v1, 3
    /* CF960 800DF160 23104300 */  subu       $v0, $v0, $v1
    /* CF964 800DF164 80100200 */  sll        $v0, $v0, 2
    /* CF968 800DF168 10004224 */  addiu      $v0, $v0, 0x10
    /* CF96C 800DF16C 21100202 */  addu       $v0, $s0, $v0
    /* CF970 800DF170 0000C2AE */  sw         $v0, 0x0($s6)
    /* CF974 800DF174 8415828F */  lw         $v0, %gp_rel(gUseSm)($gp)
    /* CF978 800DF178 00000000 */  nop
    /* CF97C 800DF17C 0000E2AE */  sw         $v0, 0x0($s7)
    /* CF980 800DF180 0C000296 */  lhu        $v0, 0xC($s0)
    /* CF984 800DF184 B67C0308 */  j          .L800DF2D8
    /* CF988 800DF188 01004224 */   addiu     $v0, $v0, 0x1
  .L800DF18C:
    /* CF98C 800DF18C 21300002 */  addu       $a2, $s0, $zero
    /* CF990 800DF190 0C000286 */  lh         $v0, 0xC($s0)
    /* CF994 800DF194 21384002 */  addu       $a3, $s2, $zero
    /* CF998 800DF198 1000B1AF */  sw         $s1, 0x10($sp)
    /* CF99C 800DF19C 1400B3AF */  sw         $s3, 0x14($sp)
    /* CF9A0 800DF1A0 C0280200 */  sll        $a1, $v0, 3
    /* CF9A4 800DF1A4 2328A200 */  subu       $a1, $a1, $v0
    /* CF9A8 800DF1A8 80280500 */  sll        $a1, $a1, 2
    /* CF9AC 800DF1AC 1000A424 */  addiu      $a0, $a1, 0x10
    /* CF9B0 800DF1B0 21200402 */  addu       $a0, $s0, $a0
    /* CF9B4 800DF1B4 2C00A524 */  addiu      $a1, $a1, 0x2C
    /* CF9B8 800DF1B8 BD79030C */  jal        CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
    /* CF9BC 800DF1BC 21280502 */   addu      $a1, $s0, $a1
    /* CF9C0 800DF1C0 0C000386 */  lh         $v1, 0xC($s0)
    /* CF9C4 800DF1C4 00000000 */  nop
    /* CF9C8 800DF1C8 C0100300 */  sll        $v0, $v1, 3
    /* CF9CC 800DF1CC 23104300 */  subu       $v0, $v0, $v1
    /* CF9D0 800DF1D0 80100200 */  sll        $v0, $v0, 2
    /* CF9D4 800DF1D4 21100202 */  addu       $v0, $s0, $v0
    /* CF9D8 800DF1D8 0F00488A */  lwl        $t0, 0xF($s2)
    /* CF9DC 800DF1DC 0C00489A */  lwr        $t0, 0xC($s2)
    /* CF9E0 800DF1E0 00000000 */  nop
    /* CF9E4 800DF1E4 230048A8 */  swl        $t0, 0x23($v0)
    /* CF9E8 800DF1E8 200048B8 */  swr        $t0, 0x20($v0)
    /* CF9EC 800DF1EC 0C000386 */  lh         $v1, 0xC($s0)
    /* CF9F0 800DF1F0 00000000 */  nop
    /* CF9F4 800DF1F4 C0100300 */  sll        $v0, $v1, 3
    /* CF9F8 800DF1F8 23104300 */  subu       $v0, $v0, $v1
    /* CF9FC 800DF1FC 80100200 */  sll        $v0, $v0, 2
    /* CFA00 800DF200 1000438E */  lw         $v1, 0x10($s2)
    /* CFA04 800DF204 21100202 */  addu       $v0, $s0, $v0
    /* CFA08 800DF208 240043AC */  sw         $v1, 0x24($v0)
    /* CFA0C 800DF20C 0C000386 */  lh         $v1, 0xC($s0)
    /* CFA10 800DF210 00000000 */  nop
    /* CFA14 800DF214 01006324 */  addiu      $v1, $v1, 0x1
    /* CFA18 800DF218 C0100300 */  sll        $v0, $v1, 3
    /* CFA1C 800DF21C 23104300 */  subu       $v0, $v0, $v1
    /* CFA20 800DF220 80100200 */  sll        $v0, $v0, 2
    /* CFA24 800DF224 21100202 */  addu       $v0, $s0, $v0
    /* CFA28 800DF228 0300888A */  lwl        $t0, 0x3($s4)
    /* CFA2C 800DF22C 0000889A */  lwr        $t0, 0x0($s4)
    /* CFA30 800DF230 00000000 */  nop
    /* CFA34 800DF234 230048A8 */  swl        $t0, 0x23($v0)
    /* CFA38 800DF238 200048B8 */  swr        $t0, 0x20($v0)
    /* CFA3C 800DF23C 0C000386 */  lh         $v1, 0xC($s0)
    /* CFA40 800DF240 00000000 */  nop
    /* CFA44 800DF244 01006324 */  addiu      $v1, $v1, 0x1
    /* CFA48 800DF248 C0100300 */  sll        $v0, $v1, 3
    /* CFA4C 800DF24C 23104300 */  subu       $v0, $v0, $v1
  .L800DF250:
    /* CFA50 800DF250 80100200 */  sll        $v0, $v0, 2
    /* CFA54 800DF254 21100202 */  addu       $v0, $s0, $v0
    /* CFA58 800DF258 240055AC */  sw         $s5, 0x24($v0)
    /* CFA5C 800DF25C 0C000386 */  lh         $v1, 0xC($s0)
    /* CFA60 800DF260 00000000 */  nop
    /* CFA64 800DF264 C0100300 */  sll        $v0, $v1, 3
    /* CFA68 800DF268 23104300 */  subu       $v0, $v0, $v1
    /* CFA6C 800DF26C 80100200 */  sll        $v0, $v0, 2
    /* CFA70 800DF270 21180202 */  addu       $v1, $s0, $v0
    /* CFA74 800DF274 2C004224 */  addiu      $v0, $v0, 0x2C
    /* CFA78 800DF278 21100202 */  addu       $v0, $s0, $v0
    /* CFA7C 800DF27C 280062AC */  sw         $v0, 0x28($v1)
    /* CFA80 800DF280 0C000386 */  lh         $v1, 0xC($s0)
    /* CFA84 800DF284 00000000 */  nop
    /* CFA88 800DF288 01006324 */  addiu      $v1, $v1, 0x1
    /* CFA8C 800DF28C C0100300 */  sll        $v0, $v1, 3
    /* CFA90 800DF290 23104300 */  subu       $v0, $v0, $v1
    /* CFA94 800DF294 80100200 */  sll        $v0, $v0, 2
    /* CFA98 800DF298 21100202 */  addu       $v0, $s0, $v0
    /* CFA9C 800DF29C 280040AC */  sw         $zero, 0x28($v0)
    /* CFAA0 800DF2A0 0C000386 */  lh         $v1, 0xC($s0)
    /* CFAA4 800DF2A4 00000000 */  nop
    /* CFAA8 800DF2A8 C0100300 */  sll        $v0, $v1, 3
    /* CFAAC 800DF2AC 23104300 */  subu       $v0, $v0, $v1
    /* CFAB0 800DF2B0 80100200 */  sll        $v0, $v0, 2
    /* CFAB4 800DF2B4 2C004224 */  addiu      $v0, $v0, 0x2C
    /* CFAB8 800DF2B8 21100202 */  addu       $v0, $s0, $v0
    /* CFABC 800DF2BC 0000C2AE */  sw         $v0, 0x0($s6)
    /* CFAC0 800DF2C0 8415828F */  lw         $v0, %gp_rel(gUseSm)($gp)
    /* CFAC4 800DF2C4 00000000 */  nop
    /* CFAC8 800DF2C8 0000E2AE */  sw         $v0, 0x0($s7)
    /* CFACC 800DF2CC 0C000296 */  lhu        $v0, 0xC($s0)
    /* CFAD0 800DF2D0 00000000 */  nop
    /* CFAD4 800DF2D4 02004224 */  addiu      $v0, $v0, 0x2
  .L800DF2D8:
    /* CFAD8 800DF2D8 0C0002A6 */  sh         $v0, 0xC($s0)
    /* CFADC 800DF2DC 3800BF8F */  lw         $ra, 0x38($sp)
    /* CFAE0 800DF2E0 3400B78F */  lw         $s7, 0x34($sp)
    /* CFAE4 800DF2E4 3000B68F */  lw         $s6, 0x30($sp)
    /* CFAE8 800DF2E8 2C00B58F */  lw         $s5, 0x2C($sp)
    /* CFAEC 800DF2EC 2800B48F */  lw         $s4, 0x28($sp)
    /* CFAF0 800DF2F0 2400B38F */  lw         $s3, 0x24($sp)
    /* CFAF4 800DF2F4 2000B28F */  lw         $s2, 0x20($sp)
    /* CFAF8 800DF2F8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* CFAFC 800DF2FC 1800B08F */  lw         $s0, 0x18($sp)
    /* CFB00 800DF300 0800E003 */  jr         $ra
    /* CFB04 800DF304 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
