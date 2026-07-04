.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle, 0xEA8

glabel Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
    /* CDF90 800DD790 20FFBD27 */  addiu      $sp, $sp, -0xE0
    /* CDF94 800DD794 C800B0AF */  sw         $s0, 0xC8($sp)
    /* CDF98 800DD798 21808000 */  addu       $s0, $a0, $zero
    /* CDF9C 800DD79C D000B2AF */  sw         $s2, 0xD0($sp)
    /* CDFA0 800DD7A0 2190A000 */  addu       $s2, $a1, $zero
    /* CDFA4 800DD7A4 D800BFAF */  sw         $ra, 0xD8($sp)
    /* CDFA8 800DD7A8 D400B3AF */  sw         $s3, 0xD4($sp)
    /* CDFAC 800DD7AC CC00B1AF */  sw         $s1, 0xCC($sp)
    /* CDFB0 800DD7B0 00004292 */  lbu        $v0, 0x0($s2)
    /* CDFB4 800DD7B4 00000000 */  nop
    /* CDFB8 800DD7B8 FFFF4324 */  addiu      $v1, $v0, -0x1
    /* CDFBC 800DD7BC 0E00622C */  sltiu      $v0, $v1, 0xE
    /* CDFC0 800DD7C0 96034010 */  beqz       $v0, .L800DE61C
    /* CDFC4 800DD7C4 801F133C */   lui       $s3, (0x1F800000 >> 16)
    /* CDFC8 800DD7C8 0580023C */  lui        $v0, %hi(jtbl_8005699C)
    /* CDFCC 800DD7CC 9C694224 */  addiu      $v0, $v0, %lo(jtbl_8005699C)
    /* CDFD0 800DD7D0 80180300 */  sll        $v1, $v1, 2
    /* CDFD4 800DD7D4 21186200 */  addu       $v1, $v1, $v0
    /* CDFD8 800DD7D8 0000628C */  lw         $v0, 0x0($v1)
    /* CDFDC 800DD7DC 00000000 */  nop
    /* CDFE0 800DD7E0 08004000 */  jr         $v0
    /* CDFE4 800DD7E4 00000000 */   nop
  jlabel .L800DD7E8
    /* CDFE8 800DD7E8 21204002 */  addu       $a0, $s2, $zero
    /* CDFEC 800DD7EC 1480063C */  lui        $a2, %hi(gSMokePalette)
    /* CDFF0 800DD7F0 FCD1C68C */  lw         $a2, %lo(gSMokePalette)($a2)
    /* CDFF4 800DD7F4 6974030C */  jal        Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
    /* CDFF8 800DD7F8 1800A527 */   addiu     $a1, $sp, 0x18
    /* CDFFC 800DD7FC 45780308 */  j          .L800DE114
    /* CE000 800DD800 1800A427 */   addiu     $a0, $sp, 0x18
  jlabel .L800DD804
    /* CE004 800DD804 21204002 */  addu       $a0, $s2, $zero
    /* CE008 800DD808 1480063C */  lui        $a2, %hi(gSMokePalette)
    /* CE00C 800DD80C FCD1C68C */  lw         $a2, %lo(gSMokePalette)($a2)
    /* CE010 800DD810 6974030C */  jal        Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
    /* CE014 800DD814 1800A527 */   addiu     $a1, $sp, 0x18
    /* CE018 800DD818 03004292 */  lbu        $v0, 0x3($s2)
    /* CE01C 800DD81C 00000000 */  nop
    /* CE020 800DD820 1200422C */  sltiu      $v0, $v0, 0x12
    /* CE024 800DD824 02004010 */  beqz       $v0, .L800DD830
    /* CE028 800DD828 01000224 */   addiu     $v0, $zero, 0x1
    /* CE02C 800DD82C 000042A2 */  sb         $v0, 0x0($s2)
  .L800DD830:
    /* CE030 800DD830 1000B3AF */  sw         $s3, 0x10($sp)
    /* CE034 800DD834 1800A427 */  addiu      $a0, $sp, 0x18
    /* CE038 800DD838 2800A527 */  addiu      $a1, $sp, 0x28
    /* CE03C 800DD83C 21300000 */  addu       $a2, $zero, $zero
    /* CE040 800DD840 6675030C */  jal        Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
    /* CE044 800DD844 0F000724 */   addiu     $a3, $zero, 0xF
    /* CE048 800DD848 87790308 */  j          .L800DE61C
    /* CE04C 800DD84C 00000000 */   nop
  jlabel .L800DD850
    /* CE050 800DD850 21204002 */  addu       $a0, $s2, $zero
    /* CE054 800DD854 1480063C */  lui        $a2, %hi(gSMokePalette)
    /* CE058 800DD858 FCD1C68C */  lw         $a2, %lo(gSMokePalette)($a2)
    /* CE05C 800DD85C 6974030C */  jal        Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
    /* CE060 800DD860 1800A527 */   addiu     $a1, $sp, 0x18
    /* CE064 800DD864 1800A427 */  addiu      $a0, $sp, 0x18
    /* CE068 800DD868 2800A527 */  addiu      $a1, $sp, 0x28
    /* CE06C 800DD86C 47780308 */  j          .L800DE11C
    /* CE070 800DD870 01000624 */   addiu     $a2, $zero, 0x1
  jlabel .L800DD874
    /* CE074 800DD874 18004A8E */  lw         $t2, 0x18($s2)
    /* CE078 800DD878 1C004B8E */  lw         $t3, 0x1C($s2)
    /* CE07C 800DD87C 20004C8E */  lw         $t4, 0x20($s2)
    /* CE080 800DD880 4800AAAF */  sw         $t2, 0x48($sp)
    /* CE084 800DD884 4C00ABAF */  sw         $t3, 0x4C($sp)
    /* CE088 800DD888 5000ACAF */  sw         $t4, 0x50($sp)
    /* CE08C 800DD88C 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* CE090 800DD890 4800A427 */   addiu     $a0, $sp, 0x48
    /* CE094 800DD894 4800A427 */  addiu      $a0, $sp, 0x48
    /* CE098 800DD898 4800A28F */  lw         $v0, 0x48($sp)
    /* CE09C 800DD89C 0C00438E */  lw         $v1, 0xC($s2)
    /* CE0A0 800DD8A0 80100200 */  sll        $v0, $v0, 2
    /* CE0A4 800DD8A4 23186200 */  subu       $v1, $v1, $v0
    /* CE0A8 800DD8A8 4C00A28F */  lw         $v0, 0x4C($sp)
    /* CE0AC 800DD8AC 5800A527 */  addiu      $a1, $sp, 0x58
    /* CE0B0 800DD8B0 4800A3AF */  sw         $v1, 0x48($sp)
    /* CE0B4 800DD8B4 1000438E */  lw         $v1, 0x10($s2)
    /* CE0B8 800DD8B8 80100200 */  sll        $v0, $v0, 2
    /* CE0BC 800DD8BC 23186200 */  subu       $v1, $v1, $v0
    /* CE0C0 800DD8C0 5000A28F */  lw         $v0, 0x50($sp)
    /* CE0C4 800DD8C4 08000626 */  addiu      $a2, $s0, 0x8
    /* CE0C8 800DD8C8 4C00A3AF */  sw         $v1, 0x4C($sp)
    /* CE0CC 800DD8CC 1400438E */  lw         $v1, 0x14($s2)
    /* CE0D0 800DD8D0 80100200 */  sll        $v0, $v0, 2
    /* CE0D4 800DD8D4 23186200 */  subu       $v1, $v1, $v0
    /* CE0D8 800DD8D8 1474030C */  jal        Sfx_Transform__FP8coorddefP7SVECTORT0
    /* CE0DC 800DD8DC 5000A3AF */   sw        $v1, 0x50($sp)
    /* CE0E0 800DD8E0 5C00A287 */  lh         $v0, 0x5C($sp)
    /* CE0E4 800DD8E4 00000000 */  nop
    /* CE0E8 800DD8E8 40004228 */  slti       $v0, $v0, 0x40
    /* CE0EC 800DD8EC 03004010 */  beqz       $v0, .L800DD8FC
    /* CE0F0 800DD8F0 1800B027 */   addiu     $s0, $sp, 0x18
    /* CE0F4 800DD8F4 7E760308 */  j          .L800DD9F8
    /* CE0F8 800DD8F8 01000324 */   addiu     $v1, $zero, 0x1
  .L800DD8FC:
    /* CE0FC 800DD8FC 5800A487 */  lh         $a0, 0x58($sp)
    /* CE100 800DD900 30004386 */  lh         $v1, 0x30($s2)
    /* CE104 800DD904 00000000 */  nop
    /* CE108 800DD908 23108300 */  subu       $v0, $a0, $v1
    /* CE10C 800DD90C 05004018 */  blez       $v0, .L800DD924
    /* CE110 800DD910 20004228 */   slti      $v0, $v0, 0x20
    /* CE114 800DD914 10004010 */  beqz       $v0, .L800DD958
    /* CE118 800DD918 00000000 */   nop
    /* CE11C 800DD91C 4D760308 */  j          .L800DD934
    /* CE120 800DD920 00000000 */   nop
  .L800DD924:
    /* CE124 800DD924 23106400 */  subu       $v0, $v1, $a0
    /* CE128 800DD928 20004228 */  slti       $v0, $v0, 0x20
    /* CE12C 800DD92C 0A004010 */  beqz       $v0, .L800DD958
    /* CE130 800DD930 00000000 */   nop
  .L800DD934:
    /* CE134 800DD934 5800A387 */  lh         $v1, 0x58($sp)
    /* CE138 800DD938 30004286 */  lh         $v0, 0x30($s2)
    /* CE13C 800DD93C 00000000 */  nop
    /* CE140 800DD940 2A104300 */  slt        $v0, $v0, $v1
    /* CE144 800DD944 30004396 */  lhu        $v1, 0x30($s2)
    /* CE148 800DD948 02004014 */  bnez       $v0, .L800DD954
    /* CE14C 800DD94C 20006224 */   addiu     $v0, $v1, 0x20
    /* CE150 800DD950 E0FF6224 */  addiu      $v0, $v1, -0x20
  .L800DD954:
    /* CE154 800DD954 5800A2A7 */  sh         $v0, 0x58($sp)
  .L800DD958:
    /* CE158 800DD958 30004296 */  lhu        $v0, 0x30($s2)
    /* CE15C 800DD95C 00000000 */  nop
    /* CE160 800DD960 100002A6 */  sh         $v0, 0x10($s0)
    /* CE164 800DD964 32004296 */  lhu        $v0, 0x32($s2)
    /* CE168 800DD968 00000000 */  nop
    /* CE16C 800DD96C 20004224 */  addiu      $v0, $v0, 0x20
    /* CE170 800DD970 120002A6 */  sh         $v0, 0x12($s0)
    /* CE174 800DD974 34004296 */  lhu        $v0, 0x34($s2)
    /* CE178 800DD978 00000000 */  nop
    /* CE17C 800DD97C 140002A6 */  sh         $v0, 0x14($s0)
    /* CE180 800DD980 30004296 */  lhu        $v0, 0x30($s2)
    /* CE184 800DD984 00000000 */  nop
    /* CE188 800DD988 280002A6 */  sh         $v0, 0x28($s0)
    /* CE18C 800DD98C 32004296 */  lhu        $v0, 0x32($s2)
    /* CE190 800DD990 00000000 */  nop
    /* CE194 800DD994 E0FF4224 */  addiu      $v0, $v0, -0x20
    /* CE198 800DD998 2A0002A6 */  sh         $v0, 0x2A($s0)
    /* CE19C 800DD99C 34004296 */  lhu        $v0, 0x34($s2)
    /* CE1A0 800DD9A0 00000000 */  nop
    /* CE1A4 800DD9A4 2C0002A6 */  sh         $v0, 0x2C($s0)
    /* CE1A8 800DD9A8 5800A297 */  lhu        $v0, 0x58($sp)
    /* CE1AC 800DD9AC 00000000 */  nop
    /* CE1B0 800DD9B0 180002A6 */  sh         $v0, 0x18($s0)
    /* CE1B4 800DD9B4 5A00A297 */  lhu        $v0, 0x5A($sp)
    /* CE1B8 800DD9B8 00000000 */  nop
    /* CE1BC 800DD9BC 20004224 */  addiu      $v0, $v0, 0x20
    /* CE1C0 800DD9C0 1A0002A6 */  sh         $v0, 0x1A($s0)
    /* CE1C4 800DD9C4 5C00A297 */  lhu        $v0, 0x5C($sp)
    /* CE1C8 800DD9C8 00000000 */  nop
    /* CE1CC 800DD9CC 1C0002A6 */  sh         $v0, 0x1C($s0)
    /* CE1D0 800DD9D0 5800A297 */  lhu        $v0, 0x58($sp)
    /* CE1D4 800DD9D4 00000000 */  nop
    /* CE1D8 800DD9D8 200002A6 */  sh         $v0, 0x20($s0)
    /* CE1DC 800DD9DC 5A00A297 */  lhu        $v0, 0x5A($sp)
    /* CE1E0 800DD9E0 00000000 */  nop
    /* CE1E4 800DD9E4 E0FF4224 */  addiu      $v0, $v0, -0x20
    /* CE1E8 800DD9E8 220002A6 */  sh         $v0, 0x22($s0)
    /* CE1EC 800DD9EC 5C00A297 */  lhu        $v0, 0x5C($sp)
    /* CE1F0 800DD9F0 21180000 */  addu       $v1, $zero, $zero
    /* CE1F4 800DD9F4 240002A6 */  sh         $v0, 0x24($s0)
  .L800DD9F8:
    /* CE1F8 800DD9F8 08036014 */  bnez       $v1, .L800DE61C
    /* CE1FC 800DD9FC 1800A427 */   addiu     $a0, $sp, 0x18
    /* CE200 800DDA00 2800A527 */  addiu      $a1, $sp, 0x28
    /* CE204 800DDA04 02000624 */  addiu      $a2, $zero, 0x2
    /* CE208 800DDA08 1180033C */  lui        $v1, %hi(gSparkHPixmap)
    /* CE20C 800DDA0C 542B6324 */  addiu      $v1, $v1, %lo(gSparkHPixmap)
    /* CE210 800DDA10 03004792 */  lbu        $a3, 0x3($s2)
    /* CE214 800DDA14 06000224 */  addiu      $v0, $zero, 0x6
    /* CE218 800DDA18 23104700 */  subu       $v0, $v0, $a3
    /* CE21C 800DDA1C 0410C200 */  sllv       $v0, $v0, $a2
    /* CE220 800DDA20 21104300 */  addu       $v0, $v0, $v1
    /* CE224 800DDA24 0000428C */  lw         $v0, 0x0($v0)
    /* CE228 800DDA28 00000000 */  nop
    /* CE22C 800DDA2C 03004A88 */  lwl        $t2, 0x3($v0)
    /* CE230 800DDA30 00004A98 */  lwr        $t2, 0x0($v0)
    /* CE234 800DDA34 07004B88 */  lwl        $t3, 0x7($v0)
    /* CE238 800DDA38 04004B98 */  lwr        $t3, 0x4($v0)
    /* CE23C 800DDA3C 0B004C88 */  lwl        $t4, 0xB($v0)
    /* CE240 800DDA40 08004C98 */  lwr        $t4, 0x8($v0)
    /* CE244 800DDA44 0F004D88 */  lwl        $t5, 0xF($v0)
    /* CE248 800DDA48 0C004D98 */  lwr        $t5, 0xC($v0)
    /* CE24C 800DDA4C 1B00AAAB */  swl        $t2, 0x1B($sp)
    /* CE250 800DDA50 1800AABB */  swr        $t2, 0x18($sp)
    /* CE254 800DDA54 1F00ABAB */  swl        $t3, 0x1F($sp)
    /* CE258 800DDA58 1C00ABBB */  swr        $t3, 0x1C($sp)
    /* CE25C 800DDA5C 2300ACAB */  swl        $t4, 0x23($sp)
    /* CE260 800DDA60 2000ACBB */  swr        $t4, 0x20($sp)
    /* CE264 800DDA64 2700ADAB */  swl        $t5, 0x27($sp)
    /* CE268 800DDA68 2400ADBB */  swr        $t5, 0x24($sp)
    /* CE26C 800DDA6C 48780308 */  j          .L800DE120
    /* CE270 800DDA70 28000724 */   addiu     $a3, $zero, 0x28
  jlabel .L800DDA74
    /* CE274 800DDA74 182E023C */  lui        $v0, (0x2E181010 >> 16)
    /* CE278 800DDA78 10104234 */  ori        $v0, $v0, (0x2E181010 & 0xFFFF)
    /* CE27C 800DDA7C 4800A2AF */  sw         $v0, 0x48($sp)
    /* CE280 800DDA80 4B00AA8B */  lwl        $t2, 0x4B($sp)
    /* CE284 800DDA84 4800AA9B */  lwr        $t2, 0x48($sp)
    /* CE288 800DDA88 00000000 */  nop
    /* CE28C 800DDA8C 6F00AAAB */  swl        $t2, 0x6F($sp)
    /* CE290 800DDA90 6C00AABB */  swr        $t2, 0x6C($sp)
    /* CE294 800DDA94 18004A8E */  lw         $t2, 0x18($s2)
    /* CE298 800DDA98 1C004B8E */  lw         $t3, 0x1C($s2)
    /* CE29C 800DDA9C 20004C8E */  lw         $t4, 0x20($s2)
    /* CE2A0 800DDAA0 9800AAAF */  sw         $t2, 0x98($sp)
    /* CE2A4 800DDAA4 9C00ABAF */  sw         $t3, 0x9C($sp)
    /* CE2A8 800DDAA8 A000ACAF */  sw         $t4, 0xA0($sp)
    /* CE2AC 800DDAAC 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* CE2B0 800DDAB0 9800A427 */   addiu     $a0, $sp, 0x98
    /* CE2B4 800DDAB4 0C004A8E */  lw         $t2, 0xC($s2)
    /* CE2B8 800DDAB8 10004B8E */  lw         $t3, 0x10($s2)
    /* CE2BC 800DDABC 14004C8E */  lw         $t4, 0x14($s2)
    /* CE2C0 800DDAC0 A400AAAF */  sw         $t2, 0xA4($sp)
    /* CE2C4 800DDAC4 A800ABAF */  sw         $t3, 0xA8($sp)
    /* CE2C8 800DDAC8 AC00ACAF */  sw         $t4, 0xAC($sp)
    /* CE2CC 800DDACC 3A004386 */  lh         $v1, 0x3A($s2)
    /* CE2D0 800DDAD0 9800A28F */  lw         $v0, 0x98($sp)
    /* CE2D4 800DDAD4 00000000 */  nop
    /* CE2D8 800DDAD8 18004300 */  mult       $v0, $v1
    /* CE2DC 800DDADC 12700000 */  mflo       $t6
    /* CE2E0 800DDAE0 9C00A28F */  lw         $v0, 0x9C($sp)
    /* CE2E4 800DDAE4 00000000 */  nop
    /* CE2E8 800DDAE8 18004300 */  mult       $v0, $v1
    /* CE2EC 800DDAEC 7800B127 */  addiu      $s1, $sp, 0x78
    /* CE2F0 800DDAF0 21202002 */  addu       $a0, $s1, $zero
    /* CE2F4 800DDAF4 12480000 */  mflo       $t1
    /* CE2F8 800DDAF8 A000A28F */  lw         $v0, 0xA0($sp)
    /* CE2FC 800DDAFC 9800A527 */  addiu      $a1, $sp, 0x98
    /* CE300 800DDB00 18004300 */  mult       $v0, $v1
    /* CE304 800DDB04 A400A627 */  addiu      $a2, $sp, 0xA4
    /* CE308 800DDB08 08000726 */  addiu      $a3, $s0, 0x8
    /* CE30C 800DDB0C A400A28F */  lw         $v0, 0xA4($sp)
    /* CE310 800DDB10 03190E00 */  sra        $v1, $t6, 4
    /* CE314 800DDB14 23104300 */  subu       $v0, $v0, $v1
    /* CE318 800DDB18 9800A2AF */  sw         $v0, 0x98($sp)
    /* CE31C 800DDB1C A800A28F */  lw         $v0, 0xA8($sp)
    /* CE320 800DDB20 03190900 */  sra        $v1, $t1, 4
    /* CE324 800DDB24 23104300 */  subu       $v0, $v0, $v1
    /* CE328 800DDB28 9C00A2AF */  sw         $v0, 0x9C($sp)
    /* CE32C 800DDB2C AC00A28F */  lw         $v0, 0xAC($sp)
    /* CE330 800DDB30 12400000 */  mflo       $t0
    /* CE334 800DDB34 03190800 */  sra        $v1, $t0, 4
    /* CE338 800DDB38 23104300 */  subu       $v0, $v0, $v1
    /* CE33C 800DDB3C DC74030C */  jal        Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
    /* CE340 800DDB40 A000A2AF */   sw        $v0, 0xA0($sp)
    /* CE344 800DDB44 1180043C */  lui        $a0, %hi(gWorldMat)
    /* CE348 800DDB48 40EE8424 */  addiu      $a0, $a0, %lo(gWorldMat)
    /* CE34C 800DDB4C 9786030C */  jal        TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
    /* CE350 800DDB50 21280000 */   addu      $a1, $zero, $zero
    /* CE354 800DDB54 0400628E */  lw         $v0, 0x4($s3)
    /* CE358 800DDB58 0800638E */  lw         $v1, 0x8($s3)
    /* CE35C 800DDB5C 00000000 */  nop
    /* CE360 800DDB60 2B104300 */  sltu       $v0, $v0, $v1
    /* CE364 800DDB64 AD024010 */  beqz       $v0, .L800DE61C
    /* CE368 800DDB68 8000A227 */   addiu     $v0, $sp, 0x80
    /* CE36C 800DDB6C 000040C8 */  lwc2       $0, 0x0($v0)
    /* CE370 800DDB70 040041C8 */  lwc2       $1, 0x4($v0)
    /* CE374 800DDB74 00000000 */  nop
    /* CE378 800DDB78 00000000 */  nop
    /* CE37C 800DDB7C 0100184A */  .word 0x4A180001  /* rtps */
    /* CE380 800DDB80 B000A227 */  addiu      $v0, $sp, 0xB0
    /* CE384 800DDB84 801F103C */  lui        $s0, (0x1F800004 >> 16)
    /* CE388 800DDB88 0400108E */  lw         $s0, (0x1F800004 & 0xFFFF)($s0)
    /* CE38C 800DDB8C 000059E8 */  swc2       $25, 0x0($v0)
    /* CE390 800DDB90 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* CE394 800DDB94 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* CE398 800DDB98 B800A28F */  lw         $v0, 0xB8($sp)
    /* CE39C 800DDB9C 00000000 */  nop
    /* CE3A0 800DDBA0 20004228 */  slti       $v0, $v0, 0x20
    /* CE3A4 800DDBA4 9D024014 */  bnez       $v0, .L800DE61C
    /* CE3A8 800DDBA8 10000226 */   addiu     $v0, $s0, 0x10
    /* CE3AC 800DDBAC 00004EE8 */  swc2       $14, 0x0($v0)
    /* CE3B0 800DDBB0 8800A327 */  addiu      $v1, $sp, 0x88
    /* CE3B4 800DDBB4 9000A227 */  addiu      $v0, $sp, 0x90
    /* CE3B8 800DDBB8 000020CA */  lwc2       $0, 0x0($s1)
    /* CE3BC 800DDBBC 040021CA */  lwc2       $1, 0x4($s1)
    /* CE3C0 800DDBC0 000062C8 */  lwc2       $2, 0x0($v1)
    /* CE3C4 800DDBC4 040063C8 */  lwc2       $3, 0x4($v1)
    /* CE3C8 800DDBC8 000044C8 */  lwc2       $4, 0x0($v0)
    /* CE3CC 800DDBCC 040045C8 */  lwc2       $5, 0x4($v0)
    /* CE3D0 800DDBD0 00000000 */  nop
    /* CE3D4 800DDBD4 00000000 */  nop
    /* CE3D8 800DDBD8 3000284A */  .word 0x4A280030  /* rtpt */
    /* CE3DC 800DDBDC 08000426 */  addiu      $a0, $s0, 0x8
    /* CE3E0 800DDBE0 6C00A28F */  lw         $v0, 0x6C($sp)
    /* CE3E4 800DDBE4 20000326 */  addiu      $v1, $s0, 0x20
    /* CE3E8 800DDBE8 040002AE */  sw         $v0, 0x4($s0)
    /* CE3EC 800DDBEC 18000226 */  addiu      $v0, $s0, 0x18
    /* CE3F0 800DDBF0 00008CE8 */  swc2       $12, 0x0($a0)
    /* CE3F4 800DDBF4 00006DE8 */  swc2       $13, 0x0($v1)
    /* CE3F8 800DDBF8 00004EE8 */  swc2       $14, 0x0($v0)
    /* CE3FC 800DDBFC 00000000 */  nop
    /* CE400 800DDC00 00000000 */  nop
    /* CE404 800DDC04 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* CE408 800DDC08 14006226 */  addiu      $v0, $s3, 0x14
    /* CE40C 800DDC0C 000047E8 */  swc2       $7, 0x0($v0)
    /* CE410 800DDC10 1400628E */  lw         $v0, 0x14($s3)
    /* CE414 800DDC14 00000000 */  nop
    /* CE418 800DDC18 43100200 */  sra        $v0, $v0, 1
    /* CE41C 800DDC1C 32004324 */  addiu      $v1, $v0, 0x32
    /* CE420 800DDC20 7E026004 */  bltz       $v1, .L800DE61C
    /* CE424 800DDC24 140063AE */   sw        $v1, 0x14($s3)
    /* CE428 800DDC28 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* CE42C 800DDC2C B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* CE430 800DDC30 00000000 */  nop
    /* CE434 800DDC34 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* CE438 800DDC38 2A104300 */  slt        $v0, $v0, $v1
    /* CE43C 800DDC3C 77024014 */  bnez       $v0, .L800DE61C
    /* CE440 800DDC40 09000224 */   addiu     $v0, $zero, 0x9
    /* CE444 800DDC44 1180033C */  lui        $v1, %hi(gSparkHPixmap)
    /* CE448 800DDC48 542B6324 */  addiu      $v1, $v1, %lo(gSparkHPixmap)
    /* CE44C 800DDC4C 030002A2 */  sb         $v0, 0x3($s0)
    /* CE450 800DDC50 03004492 */  lbu        $a0, 0x3($s2)
    /* CE454 800DDC54 06000224 */  addiu      $v0, $zero, 0x6
    /* CE458 800DDC58 23104400 */  subu       $v0, $v0, $a0
    /* CE45C 800DDC5C 80100200 */  sll        $v0, $v0, 2
    /* CE460 800DDC60 21104300 */  addu       $v0, $v0, $v1
    /* CE464 800DDC64 0000428C */  lw         $v0, 0x0($v0)
    /* CE468 800DDC68 00000000 */  nop
    /* CE46C 800DDC6C 0000438C */  lw         $v1, 0x0($v0)
    /* CE470 800DDC70 0400458C */  lw         $a1, 0x4($v0)
    /* CE474 800DDC74 0800468C */  lw         $a2, 0x8($v0)
    /* CE478 800DDC78 0C00478C */  lw         $a3, 0xC($v0)
    /* CE47C 800DDC7C C000A427 */  addiu      $a0, $sp, 0xC0
    /* CE480 800DDC80 0C0003AE */  sw         $v1, 0xC($s0)
    /* CE484 800DDC84 140005AE */  sw         $a1, 0x14($s0)
    /* CE488 800DDC88 1C0006AE */  sw         $a2, 0x1C($s0)
    /* CE48C 800DDC8C 240007AE */  sw         $a3, 0x24($s0)
    /* CE490 800DDC90 06004294 */  lhu        $v0, 0x6($v0)
    /* CE494 800DDC94 01000524 */  addiu      $a1, $zero, 0x1
    /* CE498 800DDC98 B4F9020C */  jal        ChangeTPage__FPUsi
    /* CE49C 800DDC9C C000A2A7 */   sh        $v0, 0xC0($sp)
    /* CE4A0 800DDCA0 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* CE4A4 800DDCA4 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* CE4A8 800DDCA8 C000A297 */  lhu        $v0, 0xC0($sp)
    /* CE4AC 800DDCAC 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* CE4B0 800DDCB0 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* CE4B4 800DDCB4 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* CE4B8 800DDCB8 160002A6 */  sh         $v0, 0x16($s0)
    /* CE4BC 800DDCBC 1400628E */  lw         $v0, 0x14($s3)
    /* CE4C0 800DDCC0 801F103C */  lui        $s0, (0x1F800004 >> 16)
    /* CE4C4 800DDCC4 0400108E */  lw         $s0, (0x1F800004 & 0xFFFF)($s0)
    /* CE4C8 800DDCC8 80100200 */  sll        $v0, $v0, 2
    /* CE4CC 800DDCCC 21104600 */  addu       $v0, $v0, $a2
    /* CE4D0 800DDCD0 0000038E */  lw         $v1, 0x0($s0)
    /* CE4D4 800DDCD4 0000428C */  lw         $v0, 0x0($v0)
    /* CE4D8 800DDCD8 24186700 */  and        $v1, $v1, $a3
    /* CE4DC 800DDCDC 24104500 */  and        $v0, $v0, $a1
    /* CE4E0 800DDCE0 25186200 */  or         $v1, $v1, $v0
    /* CE4E4 800DDCE4 000003AE */  sw         $v1, 0x0($s0)
    /* CE4E8 800DDCE8 1400648E */  lw         $a0, 0x14($s3)
    /* CE4EC 800DDCEC 28000326 */  addiu      $v1, $s0, 0x28
    /* CE4F0 800DDCF0 80200400 */  sll        $a0, $a0, 2
    /* CE4F4 800DDCF4 21208600 */  addu       $a0, $a0, $a2
    /* CE4F8 800DDCF8 0000828C */  lw         $v0, 0x0($a0)
    /* CE4FC 800DDCFC 801F013C */  lui        $at, (0x1F800004 >> 16)
    /* CE500 800DDD00 040023AC */  sw         $v1, (0x1F800004 & 0xFFFF)($at)
    /* CE504 800DDD04 84790308 */  j          .L800DE610
    /* CE508 800DDD08 24280502 */   and       $a1, $s0, $a1
  jlabel .L800DDD0C
    /* CE50C 800DDD0C 88001024 */  addiu      $s0, $zero, 0x88
    /* CE510 800DDD10 03004292 */  lbu        $v0, 0x3($s2)
    /* CE514 800DDD14 0800448E */  lw         $a0, 0x8($s2)
    /* CE518 800DDD18 39C6030C */  jal        intcos
    /* CE51C 800DDD1C 23800202 */   subu      $s0, $s0, $v0
    /* CE520 800DDD20 21204000 */  addu       $a0, $v0, $zero
    /* CE524 800DDD24 CA90030C */  jal        fixedmult
    /* CE528 800DDD28 21280002 */   addu      $a1, $s0, $zero
    /* CE52C 800DDD2C 0800448E */  lw         $a0, 0x8($s2)
    /* CE530 800DDD30 3AC6030C */  jal        intsin
    /* CE534 800DDD34 21884000 */   addu      $s1, $v0, $zero
    /* CE538 800DDD38 21204000 */  addu       $a0, $v0, $zero
    /* CE53C 800DDD3C CA90030C */  jal        fixedmult
    /* CE540 800DDD40 21280002 */   addu      $a1, $s0, $zero
    /* CE544 800DDD44 30004396 */  lhu        $v1, 0x30($s2)
    /* CE548 800DDD48 1800B027 */  addiu      $s0, $sp, 0x18
    /* CE54C 800DDD4C 23186200 */  subu       $v1, $v1, $v0
    /* CE550 800DDD50 100003A6 */  sh         $v1, 0x10($s0)
    /* CE554 800DDD54 32004396 */  lhu        $v1, 0x32($s2)
    /* CE558 800DDD58 00000000 */  nop
    /* CE55C 800DDD5C 21187100 */  addu       $v1, $v1, $s1
    /* CE560 800DDD60 120003A6 */  sh         $v1, 0x12($s0)
    /* CE564 800DDD64 34004396 */  lhu        $v1, 0x34($s2)
    /* CE568 800DDD68 00000000 */  nop
    /* CE56C 800DDD6C 140003A6 */  sh         $v1, 0x14($s0)
    /* CE570 800DDD70 30004396 */  lhu        $v1, 0x30($s2)
    /* CE574 800DDD74 00000000 */  nop
    /* CE578 800DDD78 21187100 */  addu       $v1, $v1, $s1
    /* CE57C 800DDD7C 180003A6 */  sh         $v1, 0x18($s0)
    /* CE580 800DDD80 32004396 */  lhu        $v1, 0x32($s2)
    /* CE584 800DDD84 00000000 */  nop
    /* CE588 800DDD88 21186200 */  addu       $v1, $v1, $v0
    /* CE58C 800DDD8C 1A0003A6 */  sh         $v1, 0x1A($s0)
    /* CE590 800DDD90 34004396 */  lhu        $v1, 0x34($s2)
    /* CE594 800DDD94 00000000 */  nop
    /* CE598 800DDD98 1C0003A6 */  sh         $v1, 0x1C($s0)
    /* CE59C 800DDD9C 30004396 */  lhu        $v1, 0x30($s2)
    /* CE5A0 800DDDA0 00000000 */  nop
    /* CE5A4 800DDDA4 21186200 */  addu       $v1, $v1, $v0
    /* CE5A8 800DDDA8 200003A6 */  sh         $v1, 0x20($s0)
    /* CE5AC 800DDDAC 32004396 */  lhu        $v1, 0x32($s2)
    /* CE5B0 800DDDB0 00000000 */  nop
    /* CE5B4 800DDDB4 23187100 */  subu       $v1, $v1, $s1
    /* CE5B8 800DDDB8 220003A6 */  sh         $v1, 0x22($s0)
    /* CE5BC 800DDDBC 34004396 */  lhu        $v1, 0x34($s2)
    /* CE5C0 800DDDC0 00000000 */  nop
    /* CE5C4 800DDDC4 240003A6 */  sh         $v1, 0x24($s0)
    /* CE5C8 800DDDC8 30004396 */  lhu        $v1, 0x30($s2)
    /* CE5CC 800DDDCC 00000000 */  nop
    /* CE5D0 800DDDD0 23187100 */  subu       $v1, $v1, $s1
    /* CE5D4 800DDDD4 280003A6 */  sh         $v1, 0x28($s0)
    /* CE5D8 800DDDD8 32004396 */  lhu        $v1, 0x32($s2)
    /* CE5DC 800DDDDC 1480073C */  lui        $a3, %hi(gDirtPalette)
    /* CE5E0 800DDDE0 00D2E78C */  lw         $a3, %lo(gDirtPalette)($a3)
    /* CE5E4 800DDDE4 38780308 */  j          .L800DE0E0
    /* CE5E8 800DDDE8 23186200 */   subu      $v1, $v1, $v0
  jlabel .L800DDDEC
    /* CE5EC 800DDDEC 08001024 */  addiu      $s0, $zero, 0x8
    /* CE5F0 800DDDF0 03004292 */  lbu        $v0, 0x3($s2)
    /* CE5F4 800DDDF4 0800448E */  lw         $a0, 0x8($s2)
    /* CE5F8 800DDDF8 23800202 */  subu       $s0, $s0, $v0
    /* CE5FC 800DDDFC 80801000 */  sll        $s0, $s0, 2
    /* CE600 800DDE00 39C6030C */  jal        intcos
    /* CE604 800DDE04 19001026 */   addiu     $s0, $s0, 0x19
    /* CE608 800DDE08 21204000 */  addu       $a0, $v0, $zero
    /* CE60C 800DDE0C CA90030C */  jal        fixedmult
    /* CE610 800DDE10 21280002 */   addu      $a1, $s0, $zero
    /* CE614 800DDE14 0800448E */  lw         $a0, 0x8($s2)
    /* CE618 800DDE18 3AC6030C */  jal        intsin
    /* CE61C 800DDE1C 21884000 */   addu      $s1, $v0, $zero
    /* CE620 800DDE20 21204000 */  addu       $a0, $v0, $zero
    /* CE624 800DDE24 CA90030C */  jal        fixedmult
    /* CE628 800DDE28 21280002 */   addu      $a1, $s0, $zero
    /* CE62C 800DDE2C 30004396 */  lhu        $v1, 0x30($s2)
    /* CE630 800DDE30 1800B027 */  addiu      $s0, $sp, 0x18
    /* CE634 800DDE34 23186200 */  subu       $v1, $v1, $v0
    /* CE638 800DDE38 100003A6 */  sh         $v1, 0x10($s0)
    /* CE63C 800DDE3C 32004396 */  lhu        $v1, 0x32($s2)
    /* CE640 800DDE40 00000000 */  nop
    /* CE644 800DDE44 21187100 */  addu       $v1, $v1, $s1
    /* CE648 800DDE48 120003A6 */  sh         $v1, 0x12($s0)
    /* CE64C 800DDE4C 34004396 */  lhu        $v1, 0x34($s2)
    /* CE650 800DDE50 00000000 */  nop
    /* CE654 800DDE54 140003A6 */  sh         $v1, 0x14($s0)
    /* CE658 800DDE58 30004396 */  lhu        $v1, 0x30($s2)
    /* CE65C 800DDE5C 00000000 */  nop
    /* CE660 800DDE60 21187100 */  addu       $v1, $v1, $s1
    /* CE664 800DDE64 180003A6 */  sh         $v1, 0x18($s0)
    /* CE668 800DDE68 32004396 */  lhu        $v1, 0x32($s2)
    /* CE66C 800DDE6C 00000000 */  nop
    /* CE670 800DDE70 21186200 */  addu       $v1, $v1, $v0
    /* CE674 800DDE74 1A0003A6 */  sh         $v1, 0x1A($s0)
    /* CE678 800DDE78 34004396 */  lhu        $v1, 0x34($s2)
    /* CE67C 800DDE7C 00000000 */  nop
    /* CE680 800DDE80 1C0003A6 */  sh         $v1, 0x1C($s0)
    /* CE684 800DDE84 30004396 */  lhu        $v1, 0x30($s2)
    /* CE688 800DDE88 00000000 */  nop
    /* CE68C 800DDE8C 21186200 */  addu       $v1, $v1, $v0
    /* CE690 800DDE90 200003A6 */  sh         $v1, 0x20($s0)
    /* CE694 800DDE94 32004396 */  lhu        $v1, 0x32($s2)
    /* CE698 800DDE98 00000000 */  nop
    /* CE69C 800DDE9C 23187100 */  subu       $v1, $v1, $s1
    /* CE6A0 800DDEA0 220003A6 */  sh         $v1, 0x22($s0)
    /* CE6A4 800DDEA4 34004396 */  lhu        $v1, 0x34($s2)
    /* CE6A8 800DDEA8 00000000 */  nop
    /* CE6AC 800DDEAC 240003A6 */  sh         $v1, 0x24($s0)
    /* CE6B0 800DDEB0 30004396 */  lhu        $v1, 0x30($s2)
    /* CE6B4 800DDEB4 00000000 */  nop
    /* CE6B8 800DDEB8 23187100 */  subu       $v1, $v1, $s1
    /* CE6BC 800DDEBC 280003A6 */  sh         $v1, 0x28($s0)
    /* CE6C0 800DDEC0 32004396 */  lhu        $v1, 0x32($s2)
    /* CE6C4 800DDEC4 1480073C */  lui        $a3, %hi(gGrassPalette)
    /* CE6C8 800DDEC8 10D2E78C */  lw         $a3, %lo(gGrassPalette)($a3)
    /* CE6CC 800DDECC 23186200 */  subu       $v1, $v1, $v0
    /* CE6D0 800DDED0 2A0003A6 */  sh         $v1, 0x2A($s0)
    /* CE6D4 800DDED4 34004296 */  lhu        $v0, 0x34($s2)
    /* CE6D8 800DDED8 21204002 */  addu       $a0, $s2, $zero
    /* CE6DC 800DDEDC 2C0002A6 */  sh         $v0, 0x2C($s0)
    /* CE6E0 800DDEE0 3800828C */  lw         $v0, 0x38($a0)
    /* CE6E4 800DDEE4 1480033C */  lui        $v1, %hi(gGravelPixmap)
    /* CE6E8 800DDEE8 04D26324 */  addiu      $v1, $v1, %lo(gGravelPixmap)
    /* CE6EC 800DDEEC 40780308 */  j          .L800DE100
    /* CE6F0 800DDEF0 80100200 */   sll       $v0, $v0, 2
  jlabel .L800DDEF4
    /* CE6F4 800DDEF4 08001024 */  addiu      $s0, $zero, 0x8
    /* CE6F8 800DDEF8 03004292 */  lbu        $v0, 0x3($s2)
    /* CE6FC 800DDEFC 0800448E */  lw         $a0, 0x8($s2)
    /* CE700 800DDF00 23800202 */  subu       $s0, $s0, $v0
    /* CE704 800DDF04 80801000 */  sll        $s0, $s0, 2
    /* CE708 800DDF08 39C6030C */  jal        intcos
    /* CE70C 800DDF0C 19001026 */   addiu     $s0, $s0, 0x19
    /* CE710 800DDF10 21204000 */  addu       $a0, $v0, $zero
    /* CE714 800DDF14 CA90030C */  jal        fixedmult
    /* CE718 800DDF18 21280002 */   addu      $a1, $s0, $zero
    /* CE71C 800DDF1C 0800448E */  lw         $a0, 0x8($s2)
    /* CE720 800DDF20 3AC6030C */  jal        intsin
    /* CE724 800DDF24 21884000 */   addu      $s1, $v0, $zero
    /* CE728 800DDF28 21204000 */  addu       $a0, $v0, $zero
    /* CE72C 800DDF2C CA90030C */  jal        fixedmult
    /* CE730 800DDF30 21280002 */   addu      $a1, $s0, $zero
    /* CE734 800DDF34 30004396 */  lhu        $v1, 0x30($s2)
    /* CE738 800DDF38 1800B027 */  addiu      $s0, $sp, 0x18
    /* CE73C 800DDF3C 23186200 */  subu       $v1, $v1, $v0
    /* CE740 800DDF40 100003A6 */  sh         $v1, 0x10($s0)
    /* CE744 800DDF44 32004396 */  lhu        $v1, 0x32($s2)
    /* CE748 800DDF48 00000000 */  nop
    /* CE74C 800DDF4C 21187100 */  addu       $v1, $v1, $s1
    /* CE750 800DDF50 120003A6 */  sh         $v1, 0x12($s0)
    /* CE754 800DDF54 34004396 */  lhu        $v1, 0x34($s2)
    /* CE758 800DDF58 00000000 */  nop
    /* CE75C 800DDF5C 140003A6 */  sh         $v1, 0x14($s0)
    /* CE760 800DDF60 30004396 */  lhu        $v1, 0x30($s2)
    /* CE764 800DDF64 00000000 */  nop
    /* CE768 800DDF68 21187100 */  addu       $v1, $v1, $s1
    /* CE76C 800DDF6C 180003A6 */  sh         $v1, 0x18($s0)
    /* CE770 800DDF70 32004396 */  lhu        $v1, 0x32($s2)
    /* CE774 800DDF74 00000000 */  nop
    /* CE778 800DDF78 21186200 */  addu       $v1, $v1, $v0
    /* CE77C 800DDF7C 1A0003A6 */  sh         $v1, 0x1A($s0)
    /* CE780 800DDF80 34004396 */  lhu        $v1, 0x34($s2)
    /* CE784 800DDF84 00000000 */  nop
    /* CE788 800DDF88 1C0003A6 */  sh         $v1, 0x1C($s0)
    /* CE78C 800DDF8C 30004396 */  lhu        $v1, 0x30($s2)
    /* CE790 800DDF90 00000000 */  nop
    /* CE794 800DDF94 21186200 */  addu       $v1, $v1, $v0
    /* CE798 800DDF98 200003A6 */  sh         $v1, 0x20($s0)
    /* CE79C 800DDF9C 32004396 */  lhu        $v1, 0x32($s2)
    /* CE7A0 800DDFA0 00000000 */  nop
    /* CE7A4 800DDFA4 23187100 */  subu       $v1, $v1, $s1
    /* CE7A8 800DDFA8 220003A6 */  sh         $v1, 0x22($s0)
    /* CE7AC 800DDFAC 34004396 */  lhu        $v1, 0x34($s2)
    /* CE7B0 800DDFB0 00000000 */  nop
    /* CE7B4 800DDFB4 240003A6 */  sh         $v1, 0x24($s0)
    /* CE7B8 800DDFB8 30004396 */  lhu        $v1, 0x30($s2)
    /* CE7BC 800DDFBC 00000000 */  nop
    /* CE7C0 800DDFC0 23187100 */  subu       $v1, $v1, $s1
    /* CE7C4 800DDFC4 280003A6 */  sh         $v1, 0x28($s0)
    /* CE7C8 800DDFC8 32004396 */  lhu        $v1, 0x32($s2)
    /* CE7CC 800DDFCC 1480073C */  lui        $a3, %hi(gSnowPalette)
    /* CE7D0 800DDFD0 14D2E78C */  lw         $a3, %lo(gSnowPalette)($a3)
    /* CE7D4 800DDFD4 23186200 */  subu       $v1, $v1, $v0
    /* CE7D8 800DDFD8 2A0003A6 */  sh         $v1, 0x2A($s0)
    /* CE7DC 800DDFDC 34004296 */  lhu        $v0, 0x34($s2)
    /* CE7E0 800DDFE0 21204002 */  addu       $a0, $s2, $zero
    /* CE7E4 800DDFE4 2C0002A6 */  sh         $v0, 0x2C($s0)
    /* CE7E8 800DDFE8 3800828C */  lw         $v0, 0x38($a0)
    /* CE7EC 800DDFEC 1480033C */  lui        $v1, %hi(gGravelPixmap)
    /* CE7F0 800DDFF0 04D26324 */  addiu      $v1, $v1, %lo(gGravelPixmap)
    /* CE7F4 800DDFF4 40780308 */  j          .L800DE100
    /* CE7F8 800DDFF8 80100200 */   sll       $v0, $v0, 2
  jlabel .L800DDFFC
    /* CE7FC 800DDFFC 08001024 */  addiu      $s0, $zero, 0x8
    /* CE800 800DE000 03004292 */  lbu        $v0, 0x3($s2)
    /* CE804 800DE004 0800448E */  lw         $a0, 0x8($s2)
    /* CE808 800DE008 23800202 */  subu       $s0, $s0, $v0
    /* CE80C 800DE00C 80801000 */  sll        $s0, $s0, 2
    /* CE810 800DE010 39C6030C */  jal        intcos
    /* CE814 800DE014 0C001026 */   addiu     $s0, $s0, 0xC
    /* CE818 800DE018 21204000 */  addu       $a0, $v0, $zero
    /* CE81C 800DE01C CA90030C */  jal        fixedmult
    /* CE820 800DE020 21280002 */   addu      $a1, $s0, $zero
    /* CE824 800DE024 0800448E */  lw         $a0, 0x8($s2)
    /* CE828 800DE028 3AC6030C */  jal        intsin
    /* CE82C 800DE02C 21884000 */   addu      $s1, $v0, $zero
    /* CE830 800DE030 21204000 */  addu       $a0, $v0, $zero
    /* CE834 800DE034 CA90030C */  jal        fixedmult
    /* CE838 800DE038 21280002 */   addu      $a1, $s0, $zero
    /* CE83C 800DE03C 30004396 */  lhu        $v1, 0x30($s2)
    /* CE840 800DE040 1800B027 */  addiu      $s0, $sp, 0x18
    /* CE844 800DE044 23186200 */  subu       $v1, $v1, $v0
    /* CE848 800DE048 100003A6 */  sh         $v1, 0x10($s0)
    /* CE84C 800DE04C 32004396 */  lhu        $v1, 0x32($s2)
    /* CE850 800DE050 00000000 */  nop
    /* CE854 800DE054 21187100 */  addu       $v1, $v1, $s1
    /* CE858 800DE058 120003A6 */  sh         $v1, 0x12($s0)
    /* CE85C 800DE05C 34004396 */  lhu        $v1, 0x34($s2)
    /* CE860 800DE060 00000000 */  nop
    /* CE864 800DE064 140003A6 */  sh         $v1, 0x14($s0)
    /* CE868 800DE068 30004396 */  lhu        $v1, 0x30($s2)
    /* CE86C 800DE06C 00000000 */  nop
    /* CE870 800DE070 21187100 */  addu       $v1, $v1, $s1
    /* CE874 800DE074 180003A6 */  sh         $v1, 0x18($s0)
    /* CE878 800DE078 32004396 */  lhu        $v1, 0x32($s2)
    /* CE87C 800DE07C 00000000 */  nop
    /* CE880 800DE080 21186200 */  addu       $v1, $v1, $v0
    /* CE884 800DE084 1A0003A6 */  sh         $v1, 0x1A($s0)
    /* CE888 800DE088 34004396 */  lhu        $v1, 0x34($s2)
    /* CE88C 800DE08C 00000000 */  nop
    /* CE890 800DE090 1C0003A6 */  sh         $v1, 0x1C($s0)
    /* CE894 800DE094 30004396 */  lhu        $v1, 0x30($s2)
    /* CE898 800DE098 00000000 */  nop
    /* CE89C 800DE09C 21186200 */  addu       $v1, $v1, $v0
    /* CE8A0 800DE0A0 200003A6 */  sh         $v1, 0x20($s0)
    /* CE8A4 800DE0A4 32004396 */  lhu        $v1, 0x32($s2)
    /* CE8A8 800DE0A8 00000000 */  nop
    /* CE8AC 800DE0AC 23187100 */  subu       $v1, $v1, $s1
    /* CE8B0 800DE0B0 220003A6 */  sh         $v1, 0x22($s0)
    /* CE8B4 800DE0B4 34004396 */  lhu        $v1, 0x34($s2)
    /* CE8B8 800DE0B8 00000000 */  nop
    /* CE8BC 800DE0BC 240003A6 */  sh         $v1, 0x24($s0)
    /* CE8C0 800DE0C0 30004396 */  lhu        $v1, 0x30($s2)
    /* CE8C4 800DE0C4 00000000 */  nop
    /* CE8C8 800DE0C8 23187100 */  subu       $v1, $v1, $s1
    /* CE8CC 800DE0CC 280003A6 */  sh         $v1, 0x28($s0)
    /* CE8D0 800DE0D0 32004396 */  lhu        $v1, 0x32($s2)
    /* CE8D4 800DE0D4 1480073C */  lui        $a3, %hi(gSnowPalette)
    /* CE8D8 800DE0D8 14D2E78C */  lw         $a3, %lo(gSnowPalette)($a3)
    /* CE8DC 800DE0DC 23186200 */  subu       $v1, $v1, $v0
  .L800DE0E0:
    /* CE8E0 800DE0E0 2A0003A6 */  sh         $v1, 0x2A($s0)
    /* CE8E4 800DE0E4 34004296 */  lhu        $v0, 0x34($s2)
    /* CE8E8 800DE0E8 21204002 */  addu       $a0, $s2, $zero
    /* CE8EC 800DE0EC 2C0002A6 */  sh         $v0, 0x2C($s0)
    /* CE8F0 800DE0F0 3800828C */  lw         $v0, 0x38($a0)
    /* CE8F4 800DE0F4 1480033C */  lui        $v1, %hi(gSMokePixmap)
    /* CE8F8 800DE0F8 F4D16324 */  addiu      $v1, $v1, %lo(gSMokePixmap)
    /* CE8FC 800DE0FC 80100200 */  sll        $v0, $v0, 2
  .L800DE100:
    /* CE900 800DE100 21104300 */  addu       $v0, $v0, $v1
    /* CE904 800DE104 0000468C */  lw         $a2, 0x0($v0)
    /* CE908 800DE108 4A75030C */  jal        Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
    /* CE90C 800DE10C 21280002 */   addu      $a1, $s0, $zero
    /* CE910 800DE110 21200002 */  addu       $a0, $s0, $zero
  .L800DE114:
    /* CE914 800DE114 2800A527 */  addiu      $a1, $sp, 0x28
    /* CE918 800DE118 21300000 */  addu       $a2, $zero, $zero
  .L800DE11C:
    /* CE91C 800DE11C 0F000724 */  addiu      $a3, $zero, 0xF
  .L800DE120:
    /* CE920 800DE120 6675030C */  jal        Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
    /* CE924 800DE124 1000B3AF */   sw        $s3, 0x10($sp)
    /* CE928 800DE128 87790308 */  j          .L800DE61C
    /* CE92C 800DE12C 00000000 */   nop
  jlabel .L800DE130
    /* CE930 800DE130 302E023C */  lui        $v0, (0x2E301818 >> 16)
    /* CE934 800DE134 18184234 */  ori        $v0, $v0, (0x2E301818 & 0xFFFF)
    /* CE938 800DE138 5000A2AF */  sw         $v0, 0x50($sp)
    /* CE93C 800DE13C 5300AA8B */  lwl        $t2, 0x53($sp)
    /* CE940 800DE140 5000AA9B */  lwr        $t2, 0x50($sp)
    /* CE944 800DE144 00000000 */  nop
    /* CE948 800DE148 6700AAAB */  swl        $t2, 0x67($sp)
    /* CE94C 800DE14C 6400AABB */  swr        $t2, 0x64($sp)
    /* CE950 800DE150 18004A8E */  lw         $t2, 0x18($s2)
    /* CE954 800DE154 1C004B8E */  lw         $t3, 0x1C($s2)
    /* CE958 800DE158 20004C8E */  lw         $t4, 0x20($s2)
    /* CE95C 800DE15C 9000AAAF */  sw         $t2, 0x90($sp)
    /* CE960 800DE160 9400ABAF */  sw         $t3, 0x94($sp)
    /* CE964 800DE164 9800ACAF */  sw         $t4, 0x98($sp)
    /* CE968 800DE168 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* CE96C 800DE16C 9000A427 */   addiu     $a0, $sp, 0x90
    /* CE970 800DE170 0C004A8E */  lw         $t2, 0xC($s2)
    /* CE974 800DE174 10004B8E */  lw         $t3, 0x10($s2)
    /* CE978 800DE178 14004C8E */  lw         $t4, 0x14($s2)
    /* CE97C 800DE17C 9C00AAAF */  sw         $t2, 0x9C($sp)
    /* CE980 800DE180 A000ABAF */  sw         $t3, 0xA0($sp)
    /* CE984 800DE184 A400ACAF */  sw         $t4, 0xA4($sp)
    /* CE988 800DE188 3A004386 */  lh         $v1, 0x3A($s2)
    /* CE98C 800DE18C 9000A28F */  lw         $v0, 0x90($sp)
    /* CE990 800DE190 00000000 */  nop
    /* CE994 800DE194 18004300 */  mult       $v0, $v1
    /* CE998 800DE198 12700000 */  mflo       $t6
    /* CE99C 800DE19C 9400A28F */  lw         $v0, 0x94($sp)
    /* CE9A0 800DE1A0 00000000 */  nop
    /* CE9A4 800DE1A4 18004300 */  mult       $v0, $v1
    /* CE9A8 800DE1A8 7000B127 */  addiu      $s1, $sp, 0x70
    /* CE9AC 800DE1AC 21202002 */  addu       $a0, $s1, $zero
    /* CE9B0 800DE1B0 12480000 */  mflo       $t1
    /* CE9B4 800DE1B4 9800A28F */  lw         $v0, 0x98($sp)
    /* CE9B8 800DE1B8 9000A527 */  addiu      $a1, $sp, 0x90
    /* CE9BC 800DE1BC 18004300 */  mult       $v0, $v1
    /* CE9C0 800DE1C0 9C00A627 */  addiu      $a2, $sp, 0x9C
    /* CE9C4 800DE1C4 08000726 */  addiu      $a3, $s0, 0x8
    /* CE9C8 800DE1C8 9C00A28F */  lw         $v0, 0x9C($sp)
    /* CE9CC 800DE1CC 03190E00 */  sra        $v1, $t6, 4
    /* CE9D0 800DE1D0 23104300 */  subu       $v0, $v0, $v1
    /* CE9D4 800DE1D4 9000A2AF */  sw         $v0, 0x90($sp)
    /* CE9D8 800DE1D8 A000A28F */  lw         $v0, 0xA0($sp)
    /* CE9DC 800DE1DC 03190900 */  sra        $v1, $t1, 4
    /* CE9E0 800DE1E0 23104300 */  subu       $v0, $v0, $v1
    /* CE9E4 800DE1E4 9400A2AF */  sw         $v0, 0x94($sp)
    /* CE9E8 800DE1E8 A400A28F */  lw         $v0, 0xA4($sp)
    /* CE9EC 800DE1EC 12400000 */  mflo       $t0
    /* CE9F0 800DE1F0 03190800 */  sra        $v1, $t0, 4
    /* CE9F4 800DE1F4 23104300 */  subu       $v0, $v0, $v1
    /* CE9F8 800DE1F8 DC74030C */  jal        Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
    /* CE9FC 800DE1FC 9800A2AF */   sw        $v0, 0x98($sp)
    /* CEA00 800DE200 1180043C */  lui        $a0, %hi(gWorldMat)
    /* CEA04 800DE204 40EE8424 */  addiu      $a0, $a0, %lo(gWorldMat)
    /* CEA08 800DE208 9786030C */  jal        TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
    /* CEA0C 800DE20C 21280000 */   addu      $a1, $zero, $zero
    /* CEA10 800DE210 0400628E */  lw         $v0, 0x4($s3)
    /* CEA14 800DE214 0800638E */  lw         $v1, 0x8($s3)
    /* CEA18 800DE218 00000000 */  nop
    /* CEA1C 800DE21C 2B104300 */  sltu       $v0, $v0, $v1
    /* CEA20 800DE220 FE004010 */  beqz       $v0, .L800DE61C
    /* CEA24 800DE224 7800A227 */   addiu     $v0, $sp, 0x78
    /* CEA28 800DE228 000040C8 */  lwc2       $0, 0x0($v0)
    /* CEA2C 800DE22C 040041C8 */  lwc2       $1, 0x4($v0)
    /* CEA30 800DE230 00000000 */  nop
    /* CEA34 800DE234 00000000 */  nop
    /* CEA38 800DE238 0100184A */  .word 0x4A180001  /* rtps */
    /* CEA3C 800DE23C A800A227 */  addiu      $v0, $sp, 0xA8
    /* CEA40 800DE240 801F103C */  lui        $s0, (0x1F800004 >> 16)
    /* CEA44 800DE244 0400108E */  lw         $s0, (0x1F800004 & 0xFFFF)($s0)
    /* CEA48 800DE248 000059E8 */  swc2       $25, 0x0($v0)
    /* CEA4C 800DE24C 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* CEA50 800DE250 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* CEA54 800DE254 B000A28F */  lw         $v0, 0xB0($sp)
    /* CEA58 800DE258 00000000 */  nop
    /* CEA5C 800DE25C 20004228 */  slti       $v0, $v0, 0x20
    /* CEA60 800DE260 EE004014 */  bnez       $v0, .L800DE61C
    /* CEA64 800DE264 10000226 */   addiu     $v0, $s0, 0x10
    /* CEA68 800DE268 00004EE8 */  swc2       $14, 0x0($v0)
    /* CEA6C 800DE26C 8000A327 */  addiu      $v1, $sp, 0x80
    /* CEA70 800DE270 8800A227 */  addiu      $v0, $sp, 0x88
    /* CEA74 800DE274 000020CA */  lwc2       $0, 0x0($s1)
    /* CEA78 800DE278 040021CA */  lwc2       $1, 0x4($s1)
    /* CEA7C 800DE27C 000062C8 */  lwc2       $2, 0x0($v1)
    /* CEA80 800DE280 040063C8 */  lwc2       $3, 0x4($v1)
    /* CEA84 800DE284 000044C8 */  lwc2       $4, 0x0($v0)
    /* CEA88 800DE288 040045C8 */  lwc2       $5, 0x4($v0)
    /* CEA8C 800DE28C 00000000 */  nop
    /* CEA90 800DE290 00000000 */  nop
    /* CEA94 800DE294 3000284A */  .word 0x4A280030  /* rtpt */
    /* CEA98 800DE298 08000426 */  addiu      $a0, $s0, 0x8
    /* CEA9C 800DE29C 6400A28F */  lw         $v0, 0x64($sp)
    /* CEAA0 800DE2A0 20000326 */  addiu      $v1, $s0, 0x20
    /* CEAA4 800DE2A4 040002AE */  sw         $v0, 0x4($s0)
    /* CEAA8 800DE2A8 18000226 */  addiu      $v0, $s0, 0x18
    /* CEAAC 800DE2AC 00008CE8 */  swc2       $12, 0x0($a0)
    /* CEAB0 800DE2B0 00006DE8 */  swc2       $13, 0x0($v1)
    /* CEAB4 800DE2B4 00004EE8 */  swc2       $14, 0x0($v0)
    /* CEAB8 800DE2B8 00000000 */  nop
    /* CEABC 800DE2BC 00000000 */  nop
    /* CEAC0 800DE2C0 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* CEAC4 800DE2C4 14006226 */  addiu      $v0, $s3, 0x14
    /* CEAC8 800DE2C8 000047E8 */  swc2       $7, 0x0($v0)
    /* CEACC 800DE2CC 1400628E */  lw         $v0, 0x14($s3)
    /* CEAD0 800DE2D0 00000000 */  nop
    /* CEAD4 800DE2D4 43100200 */  sra        $v0, $v0, 1
    /* CEAD8 800DE2D8 32004324 */  addiu      $v1, $v0, 0x32
    /* CEADC 800DE2DC CF006004 */  bltz       $v1, .L800DE61C
    /* CEAE0 800DE2E0 140063AE */   sw        $v1, 0x14($s3)
    /* CEAE4 800DE2E4 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* CEAE8 800DE2E8 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* CEAEC 800DE2EC 00000000 */  nop
    /* CEAF0 800DE2F0 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* CEAF4 800DE2F4 2A104300 */  slt        $v0, $v0, $v1
    /* CEAF8 800DE2F8 C8004014 */  bnez       $v0, .L800DE61C
    /* CEAFC 800DE2FC 09000224 */   addiu     $v0, $zero, 0x9
    /* CEB00 800DE300 1180033C */  lui        $v1, %hi(gSparkHPixmap)
    /* CEB04 800DE304 542B6324 */  addiu      $v1, $v1, %lo(gSparkHPixmap)
    /* CEB08 800DE308 030002A2 */  sb         $v0, 0x3($s0)
    /* CEB0C 800DE30C 03004492 */  lbu        $a0, 0x3($s2)
    /* CEB10 800DE310 06000224 */  addiu      $v0, $zero, 0x6
    /* CEB14 800DE314 23104400 */  subu       $v0, $v0, $a0
    /* CEB18 800DE318 80100200 */  sll        $v0, $v0, 2
    /* CEB1C 800DE31C 21104300 */  addu       $v0, $v0, $v1
    /* CEB20 800DE320 0000428C */  lw         $v0, 0x0($v0)
    /* CEB24 800DE324 00000000 */  nop
    /* CEB28 800DE328 0000438C */  lw         $v1, 0x0($v0)
    /* CEB2C 800DE32C 0400458C */  lw         $a1, 0x4($v0)
    /* CEB30 800DE330 0800468C */  lw         $a2, 0x8($v0)
    /* CEB34 800DE334 0C00478C */  lw         $a3, 0xC($v0)
    /* CEB38 800DE338 C200A427 */  addiu      $a0, $sp, 0xC2
    /* CEB3C 800DE33C 0C0003AE */  sw         $v1, 0xC($s0)
    /* CEB40 800DE340 140005AE */  sw         $a1, 0x14($s0)
    /* CEB44 800DE344 1C0006AE */  sw         $a2, 0x1C($s0)
    /* CEB48 800DE348 240007AE */  sw         $a3, 0x24($s0)
    /* CEB4C 800DE34C 06004294 */  lhu        $v0, 0x6($v0)
    /* CEB50 800DE350 02000524 */  addiu      $a1, $zero, 0x2
    /* CEB54 800DE354 B4F9020C */  jal        ChangeTPage__FPUsi
    /* CEB58 800DE358 C200A2A7 */   sh        $v0, 0xC2($sp)
    /* CEB5C 800DE35C FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* CEB60 800DE360 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* CEB64 800DE364 C200A297 */  lhu        $v0, 0xC2($sp)
    /* CEB68 800DE368 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* CEB6C 800DE36C 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* CEB70 800DE370 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* CEB74 800DE374 160002A6 */  sh         $v0, 0x16($s0)
    /* CEB78 800DE378 1400628E */  lw         $v0, 0x14($s3)
    /* CEB7C 800DE37C 801F103C */  lui        $s0, (0x1F800004 >> 16)
    /* CEB80 800DE380 0400108E */  lw         $s0, (0x1F800004 & 0xFFFF)($s0)
    /* CEB84 800DE384 80100200 */  sll        $v0, $v0, 2
    /* CEB88 800DE388 21104600 */  addu       $v0, $v0, $a2
    /* CEB8C 800DE38C 0000038E */  lw         $v1, 0x0($s0)
    /* CEB90 800DE390 0000428C */  lw         $v0, 0x0($v0)
    /* CEB94 800DE394 24186700 */  and        $v1, $v1, $a3
    /* CEB98 800DE398 24104500 */  and        $v0, $v0, $a1
    /* CEB9C 800DE39C 25186200 */  or         $v1, $v1, $v0
    /* CEBA0 800DE3A0 000003AE */  sw         $v1, 0x0($s0)
    /* CEBA4 800DE3A4 1400648E */  lw         $a0, 0x14($s3)
    /* CEBA8 800DE3A8 28000326 */  addiu      $v1, $s0, 0x28
    /* CEBAC 800DE3AC 80200400 */  sll        $a0, $a0, 2
    /* CEBB0 800DE3B0 21208600 */  addu       $a0, $a0, $a2
    /* CEBB4 800DE3B4 0000828C */  lw         $v0, 0x0($a0)
    /* CEBB8 800DE3B8 801F013C */  lui        $at, (0x1F800004 >> 16)
    /* CEBBC 800DE3BC 040023AC */  sw         $v1, (0x1F800004 & 0xFFFF)($at)
    /* CEBC0 800DE3C0 84790308 */  j          .L800DE610
    /* CEBC4 800DE3C4 24280502 */   and       $a1, $s0, $a1
  jlabel .L800DE3C8
    /* CEBC8 800DE3C8 0800448E */  lw         $a0, 0x8($s2)
    /* CEBCC 800DE3CC 39C6030C */  jal        intcos
    /* CEBD0 800DE3D0 00000000 */   nop
    /* CEBD4 800DE3D4 21204000 */  addu       $a0, $v0, $zero
    /* CEBD8 800DE3D8 CA90030C */  jal        fixedmult
    /* CEBDC 800DE3DC 06000524 */   addiu     $a1, $zero, 0x6
    /* CEBE0 800DE3E0 0800448E */  lw         $a0, 0x8($s2)
    /* CEBE4 800DE3E4 3AC6030C */  jal        intsin
    /* CEBE8 800DE3E8 21804000 */   addu      $s0, $v0, $zero
    /* CEBEC 800DE3EC 21204000 */  addu       $a0, $v0, $zero
    /* CEBF0 800DE3F0 CA90030C */  jal        fixedmult
    /* CEBF4 800DE3F4 06000524 */   addiu     $a1, $zero, 0x6
    /* CEBF8 800DE3F8 30004396 */  lhu        $v1, 0x30($s2)
    /* CEBFC 800DE3FC 1800A427 */  addiu      $a0, $sp, 0x18
    /* CEC00 800DE400 23186200 */  subu       $v1, $v1, $v0
    /* CEC04 800DE404 100083A4 */  sh         $v1, 0x10($a0)
    /* CEC08 800DE408 32004396 */  lhu        $v1, 0x32($s2)
    /* CEC0C 800DE40C 00000000 */  nop
    /* CEC10 800DE410 21187000 */  addu       $v1, $v1, $s0
    /* CEC14 800DE414 120083A4 */  sh         $v1, 0x12($a0)
    /* CEC18 800DE418 34004396 */  lhu        $v1, 0x34($s2)
    /* CEC1C 800DE41C 00000000 */  nop
    /* CEC20 800DE420 140083A4 */  sh         $v1, 0x14($a0)
    /* CEC24 800DE424 30004396 */  lhu        $v1, 0x30($s2)
    /* CEC28 800DE428 00000000 */  nop
    /* CEC2C 800DE42C 21187000 */  addu       $v1, $v1, $s0
    /* CEC30 800DE430 180083A4 */  sh         $v1, 0x18($a0)
    /* CEC34 800DE434 32004396 */  lhu        $v1, 0x32($s2)
    /* CEC38 800DE438 00000000 */  nop
    /* CEC3C 800DE43C 21186200 */  addu       $v1, $v1, $v0
    /* CEC40 800DE440 1A0083A4 */  sh         $v1, 0x1A($a0)
    /* CEC44 800DE444 34004396 */  lhu        $v1, 0x34($s2)
    /* CEC48 800DE448 00000000 */  nop
    /* CEC4C 800DE44C 1C0083A4 */  sh         $v1, 0x1C($a0)
    /* CEC50 800DE450 30004396 */  lhu        $v1, 0x30($s2)
    /* CEC54 800DE454 00000000 */  nop
    /* CEC58 800DE458 21186200 */  addu       $v1, $v1, $v0
    /* CEC5C 800DE45C 200083A4 */  sh         $v1, 0x20($a0)
    /* CEC60 800DE460 32004396 */  lhu        $v1, 0x32($s2)
    /* CEC64 800DE464 00000000 */  nop
    /* CEC68 800DE468 23187000 */  subu       $v1, $v1, $s0
    /* CEC6C 800DE46C 220083A4 */  sh         $v1, 0x22($a0)
    /* CEC70 800DE470 34004396 */  lhu        $v1, 0x34($s2)
    /* CEC74 800DE474 00000000 */  nop
    /* CEC78 800DE478 240083A4 */  sh         $v1, 0x24($a0)
    /* CEC7C 800DE47C 30004396 */  lhu        $v1, 0x30($s2)
    /* CEC80 800DE480 00000000 */  nop
    /* CEC84 800DE484 23187000 */  subu       $v1, $v1, $s0
    /* CEC88 800DE488 280083A4 */  sh         $v1, 0x28($a0)
    /* CEC8C 800DE48C 32004396 */  lhu        $v1, 0x32($s2)
    /* CEC90 800DE490 00000000 */  nop
    /* CEC94 800DE494 23186200 */  subu       $v1, $v1, $v0
    /* CEC98 800DE498 2A0083A4 */  sh         $v1, 0x2A($a0)
    /* CEC9C 800DE49C 34004296 */  lhu        $v0, 0x34($s2)
    /* CECA0 800DE4A0 00000000 */  nop
    /* CECA4 800DE4A4 2C0082A4 */  sh         $v0, 0x2C($a0)
    /* CECA8 800DE4A8 0400628E */  lw         $v0, 0x4($s3)
    /* CECAC 800DE4AC 0800638E */  lw         $v1, 0x8($s3)
    /* CECB0 800DE4B0 00000000 */  nop
    /* CECB4 800DE4B4 2B104300 */  sltu       $v0, $v0, $v1
    /* CECB8 800DE4B8 58004010 */  beqz       $v0, .L800DE61C
    /* CECBC 800DE4BC 2800A427 */   addiu     $a0, $sp, 0x28
    /* CECC0 800DE4C0 000080C8 */  lwc2       $0, 0x0($a0)
    /* CECC4 800DE4C4 040081C8 */  lwc2       $1, 0x4($a0)
    /* CECC8 800DE4C8 00000000 */  nop
    /* CECCC 800DE4CC 00000000 */  nop
    /* CECD0 800DE4D0 0100184A */  .word 0x4A180001  /* rtps */
    /* CECD4 800DE4D4 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* CECD8 800DE4D8 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* CECDC 800DE4DC 0000288D */  lw         $t0, 0x0($t1)
    /* CECE0 800DE4E0 00000000 */  nop
    /* CECE4 800DE4E4 08000225 */  addiu      $v0, $t0, 0x8
    /* CECE8 800DE4E8 00004EE8 */  swc2       $14, 0x0($v0)
    /* CECEC 800DE4EC 3000A427 */  addiu      $a0, $sp, 0x30
    /* CECF0 800DE4F0 3800A327 */  addiu      $v1, $sp, 0x38
    /* CECF4 800DE4F4 4000A227 */  addiu      $v0, $sp, 0x40
    /* CECF8 800DE4F8 000080C8 */  lwc2       $0, 0x0($a0)
    /* CECFC 800DE4FC 040081C8 */  lwc2       $1, 0x4($a0)
    /* CED00 800DE500 000062C8 */  lwc2       $2, 0x0($v1)
    /* CED04 800DE504 040063C8 */  lwc2       $3, 0x4($v1)
    /* CED08 800DE508 000044C8 */  lwc2       $4, 0x0($v0)
    /* CED0C 800DE50C 040045C8 */  lwc2       $5, 0x4($v0)
    /* CED10 800DE510 00000000 */  nop
    /* CED14 800DE514 00000000 */  nop
    /* CED18 800DE518 3000284A */  .word 0x4A280030  /* rtpt */
    /* CED1C 800DE51C 002C033C */  lui        $v1, (0x2C000000 >> 16)
    /* CED20 800DE520 4000428E */  lw         $v0, 0x40($s2)
    /* CED24 800DE524 10000425 */  addiu      $a0, $t0, 0x10
    /* CED28 800DE528 25104300 */  or         $v0, $v0, $v1
    /* CED2C 800DE52C 20000325 */  addiu      $v1, $t0, 0x20
    /* CED30 800DE530 040002AD */  sw         $v0, 0x4($t0)
    /* CED34 800DE534 18000225 */  addiu      $v0, $t0, 0x18
    /* CED38 800DE538 00008CE8 */  swc2       $12, 0x0($a0)
    /* CED3C 800DE53C 00006DE8 */  swc2       $13, 0x0($v1)
    /* CED40 800DE540 00004EE8 */  swc2       $14, 0x0($v0)
    /* CED44 800DE544 00000000 */  nop
    /* CED48 800DE548 00000000 */  nop
    /* CED4C 800DE54C 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* CED50 800DE550 14006226 */  addiu      $v0, $s3, 0x14
    /* CED54 800DE554 000047E8 */  swc2       $7, 0x0($v0)
    /* CED58 800DE558 1400628E */  lw         $v0, 0x14($s3)
    /* CED5C 800DE55C 00000000 */  nop
    /* CED60 800DE560 43100200 */  sra        $v0, $v0, 1
    /* CED64 800DE564 0F004324 */  addiu      $v1, $v0, 0xF
    /* CED68 800DE568 2C006004 */  bltz       $v1, .L800DE61C
    /* CED6C 800DE56C 140063AE */   sw        $v1, 0x14($s3)
    /* CED70 800DE570 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* CED74 800DE574 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* CED78 800DE578 00000000 */  nop
    /* CED7C 800DE57C FDFF4224 */  addiu      $v0, $v0, -0x3
    /* CED80 800DE580 2A104300 */  slt        $v0, $v0, $v1
    /* CED84 800DE584 25004014 */  bnez       $v0, .L800DE61C
    /* CED88 800DE588 09000224 */   addiu     $v0, $zero, 0x9
    /* CED8C 800DE58C FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* CED90 800DE590 030002A1 */  sb         $v0, 0x3($t0)
    /* CED94 800DE594 1480023C */  lui        $v0, %hi(gLeafPixmap)
    /* CED98 800DE598 18D2428C */  lw         $v0, %lo(gLeafPixmap)($v0)
    /* CED9C 800DE59C FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* CEDA0 800DE5A0 0000438C */  lw         $v1, 0x0($v0)
    /* CEDA4 800DE5A4 0400448C */  lw         $a0, 0x4($v0)
    /* CEDA8 800DE5A8 0800468C */  lw         $a2, 0x8($v0)
    /* CEDAC 800DE5AC 0C00428C */  lw         $v0, 0xC($v0)
    /* CEDB0 800DE5B0 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* CEDB4 800DE5B4 0C0003AD */  sw         $v1, 0xC($t0)
    /* CEDB8 800DE5B8 140004AD */  sw         $a0, 0x14($t0)
    /* CEDBC 800DE5BC 1C0006AD */  sw         $a2, 0x1C($t0)
    /* CEDC0 800DE5C0 240002AD */  sw         $v0, 0x24($t0)
    /* CEDC4 800DE5C4 0000288D */  lw         $t0, 0x0($t1)
    /* CEDC8 800DE5C8 1400628E */  lw         $v0, 0x14($s3)
    /* CEDCC 800DE5CC 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* CEDD0 800DE5D0 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* CEDD4 800DE5D4 80100200 */  sll        $v0, $v0, 2
    /* CEDD8 800DE5D8 21104600 */  addu       $v0, $v0, $a2
    /* CEDDC 800DE5DC 0000038D */  lw         $v1, 0x0($t0)
    /* CEDE0 800DE5E0 0000428C */  lw         $v0, 0x0($v0)
    /* CEDE4 800DE5E4 24186700 */  and        $v1, $v1, $a3
    /* CEDE8 800DE5E8 24104500 */  and        $v0, $v0, $a1
    /* CEDEC 800DE5EC 25186200 */  or         $v1, $v1, $v0
    /* CEDF0 800DE5F0 000003AD */  sw         $v1, 0x0($t0)
    /* CEDF4 800DE5F4 1400648E */  lw         $a0, 0x14($s3)
    /* CEDF8 800DE5F8 28000325 */  addiu      $v1, $t0, 0x28
    /* CEDFC 800DE5FC 80200400 */  sll        $a0, $a0, 2
    /* CEE00 800DE600 21208600 */  addu       $a0, $a0, $a2
    /* CEE04 800DE604 0000828C */  lw         $v0, 0x0($a0)
    /* CEE08 800DE608 24280501 */  and        $a1, $t0, $a1
    /* CEE0C 800DE60C 000023AD */  sw         $v1, 0x0($t1)
  .L800DE610:
    /* CEE10 800DE610 24104700 */  and        $v0, $v0, $a3
    /* CEE14 800DE614 25104500 */  or         $v0, $v0, $a1
    /* CEE18 800DE618 000082AC */  sw         $v0, 0x0($a0)
  jlabel .L800DE61C
    /* CEE1C 800DE61C D800BF8F */  lw         $ra, 0xD8($sp)
    /* CEE20 800DE620 D400B38F */  lw         $s3, 0xD4($sp)
    /* CEE24 800DE624 D000B28F */  lw         $s2, 0xD0($sp)
    /* CEE28 800DE628 CC00B18F */  lw         $s1, 0xCC($sp)
    /* CEE2C 800DE62C C800B08F */  lw         $s0, 0xC8($sp)
    /* CEE30 800DE630 0800E003 */  jr         $ra
    /* CEE34 800DE634 E000BD27 */   addiu     $sp, $sp, 0xE0
endlabel Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
