.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_AddDamageZone__FP13BO_tNewtonObjiii, 0x7D8

glabel Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 8F72C 8009EF2C A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 8F730 8009EF30 4000B2AF */  sw         $s2, 0x40($sp)
    /* 8F734 8009EF34 21908000 */  addu       $s2, $a0, $zero
    /* 8F738 8009EF38 3800B0AF */  sw         $s0, 0x38($sp)
    /* 8F73C 8009EF3C 2180A000 */  addu       $s0, $a1, $zero
    /* 8F740 8009EF40 5400B7AF */  sw         $s7, 0x54($sp)
    /* 8F744 8009EF44 21B8C000 */  addu       $s7, $a2, $zero
    /* 8F748 8009EF48 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 8F74C 8009EF4C 2188E000 */  addu       $s1, $a3, $zero
    /* 8F750 8009EF50 5800BFAF */  sw         $ra, 0x58($sp)
    /* 8F754 8009EF54 5000B6AF */  sw         $s6, 0x50($sp)
    /* 8F758 8009EF58 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 8F75C 8009EF5C 4800B4AF */  sw         $s4, 0x48($sp)
    /* 8F760 8009EF60 562C030C */  jal        Force_IsForceOn__FP8Car_tObj
    /* 8F764 8009EF64 4400B3AF */   sw        $s3, 0x44($sp)
    /* 8F768 8009EF68 05004010 */  beqz       $v0, .L8009EF80
    /* 8F76C 8009EF6C 1180023C */   lui       $v0, %hi(D_8011323C)
    /* 8F770 8009EF70 9001448E */  lw         $a0, 0x190($s2)
    /* 8F774 8009EF74 812C030C */  jal        Force_HitWall__Fi
    /* 8F778 8009EF78 00000000 */   nop
    /* 8F77C 8009EF7C 1180023C */  lui        $v0, %hi(D_8011323C)
  .L8009EF80:
    /* 8F780 8009EF80 3C32428C */  lw         $v0, %lo(D_8011323C)($v0)
    /* 8F784 8009EF84 00000000 */  nop
    /* 8F788 8009EF88 A8004010 */  beqz       $v0, .L8009F22C
    /* 8F78C 8009EF8C 6400033C */   lui       $v1, (0x640000 >> 16)
    /* 8F790 8009EF90 C2171000 */  srl        $v0, $s0, 31
    /* 8F794 8009EF94 21100202 */  addu       $v0, $s0, $v0
    /* 8F798 8009EF98 43200200 */  sra        $a0, $v0, 1
    /* 8F79C 8009EF9C 21106000 */  addu       $v0, $v1, $zero
    /* 8F7A0 8009EFA0 2A104400 */  slt        $v0, $v0, $a0
    /* 8F7A4 8009EFA4 02004014 */  bnez       $v0, .L8009EFB0
    /* 8F7A8 8009EFA8 00000000 */   nop
    /* 8F7AC 8009EFAC 21188000 */  addu       $v1, $a0, $zero
  .L8009EFB0:
    /* 8F7B0 8009EFB0 6002428E */  lw         $v0, 0x260($s2)
    /* 8F7B4 8009EFB4 00000000 */  nop
    /* 8F7B8 8009EFB8 00024230 */  andi       $v0, $v0, 0x200
    /* 8F7BC 8009EFBC 03004010 */  beqz       $v0, .L8009EFCC
    /* 8F7C0 8009EFC0 C2170300 */   srl       $v0, $v1, 31
    /* 8F7C4 8009EFC4 21106200 */  addu       $v0, $v1, $v0
    /* 8F7C8 8009EFC8 43180200 */  sra        $v1, $v0, 1
  .L8009EFCC:
    /* 8F7CC 8009EFCC 80101700 */  sll        $v0, $s7, 2
    /* 8F7D0 8009EFD0 21304202 */  addu       $a2, $s2, $v0
    /* 8F7D4 8009EFD4 1802C48C */  lw         $a0, 0x218($a2)
    /* 8F7D8 8009EFD8 00000000 */  nop
    /* 8F7DC 8009EFDC 2A106400 */  slt        $v0, $v1, $a0
    /* 8F7E0 8009EFE0 02004010 */  beqz       $v0, .L8009EFEC
    /* 8F7E4 8009EFE4 0800E22A */   slti      $v0, $s7, 0x8
    /* 8F7E8 8009EFE8 21188000 */  addu       $v1, $a0, $zero
  .L8009EFEC:
    /* 8F7EC 8009EFEC 8F004010 */  beqz       $v0, .L8009F22C
    /* 8F7F0 8009EFF0 1802C3AC */   sw        $v1, 0x218($a2)
    /* 8F7F4 8009EFF4 1200E016 */  bnez       $s7, .L8009F040
    /* 8F7F8 8009EFF8 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F7FC 8009EFFC 1802428E */  lw         $v0, 0x218($s2)
    /* 8F800 8009F000 2002438E */  lw         $v1, 0x220($s2)
    /* 8F804 8009F004 00000000 */  nop
    /* 8F808 8009F008 21104300 */  addu       $v0, $v0, $v1
    /* 8F80C 8009F00C C21F0200 */  srl        $v1, $v0, 31
    /* 8F810 8009F010 21104300 */  addu       $v0, $v0, $v1
    /* 8F814 8009F014 43100200 */  sra        $v0, $v0, 1
    /* 8F818 8009F018 1C02438E */  lw         $v1, 0x21C($s2)
    /* 8F81C 8009F01C 21204000 */  addu       $a0, $v0, $zero
    /* 8F820 8009F020 2A108300 */  slt        $v0, $a0, $v1
    /* 8F824 8009F024 02004010 */  beqz       $v0, .L8009F030
    /* 8F828 8009F028 00000000 */   nop
    /* 8F82C 8009F02C 21206000 */  addu       $a0, $v1, $zero
  .L8009F030:
    /* 8F830 8009F030 1802428E */  lw         $v0, 0x218($s2)
    /* 8F834 8009F034 3002438E */  lw         $v1, 0x230($s2)
    /* 8F838 8009F038 3F7C0208 */  j          .L8009F0FC
    /* 8F83C 8009F03C 1C0244AE */   sw        $a0, 0x21C($s2)
  .L8009F040:
    /* 8F840 8009F040 1C00E216 */  bne        $s7, $v0, .L8009F0B4
    /* 8F844 8009F044 06000224 */   addiu     $v0, $zero, 0x6
    /* 8F848 8009F048 3402428E */  lw         $v0, 0x234($s2)
    /* 8F84C 8009F04C 1C02438E */  lw         $v1, 0x21C($s2)
    /* 8F850 8009F050 00000000 */  nop
    /* 8F854 8009F054 21104300 */  addu       $v0, $v0, $v1
    /* 8F858 8009F058 C21F0200 */  srl        $v1, $v0, 31
    /* 8F85C 8009F05C 21104300 */  addu       $v0, $v0, $v1
    /* 8F860 8009F060 43100200 */  sra        $v0, $v0, 1
    /* 8F864 8009F064 1802438E */  lw         $v1, 0x218($s2)
    /* 8F868 8009F068 21204000 */  addu       $a0, $v0, $zero
    /* 8F86C 8009F06C 2A108300 */  slt        $v0, $a0, $v1
    /* 8F870 8009F070 02004010 */  beqz       $v0, .L8009F07C
    /* 8F874 8009F074 00000000 */   nop
    /* 8F878 8009F078 21206000 */  addu       $a0, $v1, $zero
  .L8009F07C:
    /* 8F87C 8009F07C 1C02428E */  lw         $v0, 0x21C($s2)
    /* 8F880 8009F080 2402438E */  lw         $v1, 0x224($s2)
    /* 8F884 8009F084 180244AE */  sw         $a0, 0x218($s2)
    /* 8F888 8009F088 2002448E */  lw         $a0, 0x220($s2)
    /* 8F88C 8009F08C 21104300 */  addu       $v0, $v0, $v1
    /* 8F890 8009F090 C21F0200 */  srl        $v1, $v0, 31
    /* 8F894 8009F094 21104300 */  addu       $v0, $v0, $v1
    /* 8F898 8009F098 43180200 */  sra        $v1, $v0, 1
    /* 8F89C 8009F09C 2A106400 */  slt        $v0, $v1, $a0
    /* 8F8A0 8009F0A0 02004010 */  beqz       $v0, .L8009F0AC
    /* 8F8A4 8009F0A4 00000000 */   nop
    /* 8F8A8 8009F0A8 21188000 */  addu       $v1, $a0, $zero
  .L8009F0AC:
    /* 8F8AC 8009F0AC 8B7C0208 */  j          .L8009F22C
    /* 8F8B0 8009F0B0 200243AE */   sw        $v1, 0x220($s2)
  .L8009F0B4:
    /* 8F8B4 8009F0B4 1C00E216 */  bne        $s7, $v0, .L8009F128
    /* 8F8B8 8009F0B8 07000224 */   addiu     $v0, $zero, 0x7
    /* 8F8BC 8009F0BC 2802428E */  lw         $v0, 0x228($s2)
    /* 8F8C0 8009F0C0 3002438E */  lw         $v1, 0x230($s2)
    /* 8F8C4 8009F0C4 00000000 */  nop
    /* 8F8C8 8009F0C8 21104300 */  addu       $v0, $v0, $v1
    /* 8F8CC 8009F0CC C21F0200 */  srl        $v1, $v0, 31
    /* 8F8D0 8009F0D0 21104300 */  addu       $v0, $v0, $v1
    /* 8F8D4 8009F0D4 43100200 */  sra        $v0, $v0, 1
    /* 8F8D8 8009F0D8 2C02438E */  lw         $v1, 0x22C($s2)
    /* 8F8DC 8009F0DC 21204000 */  addu       $a0, $v0, $zero
    /* 8F8E0 8009F0E0 2A108300 */  slt        $v0, $a0, $v1
    /* 8F8E4 8009F0E4 02004010 */  beqz       $v0, .L8009F0F0
    /* 8F8E8 8009F0E8 00000000 */   nop
    /* 8F8EC 8009F0EC 21206000 */  addu       $a0, $v1, $zero
  .L8009F0F0:
    /* 8F8F0 8009F0F0 1802428E */  lw         $v0, 0x218($s2)
    /* 8F8F4 8009F0F4 3002438E */  lw         $v1, 0x230($s2)
    /* 8F8F8 8009F0F8 2C0244AE */  sw         $a0, 0x22C($s2)
  .L8009F0FC:
    /* 8F8FC 8009F0FC 3402448E */  lw         $a0, 0x234($s2)
    /* 8F900 8009F100 21104300 */  addu       $v0, $v0, $v1
    /* 8F904 8009F104 C21F0200 */  srl        $v1, $v0, 31
    /* 8F908 8009F108 21104300 */  addu       $v0, $v0, $v1
    /* 8F90C 8009F10C 43180200 */  sra        $v1, $v0, 1
    /* 8F910 8009F110 2A106400 */  slt        $v0, $v1, $a0
    /* 8F914 8009F114 02004010 */  beqz       $v0, .L8009F120
    /* 8F918 8009F118 00000000 */   nop
    /* 8F91C 8009F11C 21188000 */  addu       $v1, $a0, $zero
  .L8009F120:
    /* 8F920 8009F120 8B7C0208 */  j          .L8009F22C
    /* 8F924 8009F124 340243AE */   sw        $v1, 0x234($s2)
  .L8009F128:
    /* 8F928 8009F128 1C00E216 */  bne        $s7, $v0, .L8009F19C
    /* 8F92C 8009F12C 0200E226 */   addiu     $v0, $s7, 0x2
    /* 8F930 8009F130 3402428E */  lw         $v0, 0x234($s2)
    /* 8F934 8009F134 1C02438E */  lw         $v1, 0x21C($s2)
    /* 8F938 8009F138 00000000 */  nop
    /* 8F93C 8009F13C 21104300 */  addu       $v0, $v0, $v1
    /* 8F940 8009F140 C21F0200 */  srl        $v1, $v0, 31
    /* 8F944 8009F144 21104300 */  addu       $v0, $v0, $v1
    /* 8F948 8009F148 43100200 */  sra        $v0, $v0, 1
    /* 8F94C 8009F14C 1802438E */  lw         $v1, 0x218($s2)
    /* 8F950 8009F150 21204000 */  addu       $a0, $v0, $zero
    /* 8F954 8009F154 2A108300 */  slt        $v0, $a0, $v1
    /* 8F958 8009F158 02004010 */  beqz       $v0, .L8009F164
    /* 8F95C 8009F15C 00000000 */   nop
    /* 8F960 8009F160 21206000 */  addu       $a0, $v1, $zero
  .L8009F164:
    /* 8F964 8009F164 2C02428E */  lw         $v0, 0x22C($s2)
    /* 8F968 8009F168 3402438E */  lw         $v1, 0x234($s2)
    /* 8F96C 8009F16C 180244AE */  sw         $a0, 0x218($s2)
    /* 8F970 8009F170 3002448E */  lw         $a0, 0x230($s2)
    /* 8F974 8009F174 21104300 */  addu       $v0, $v0, $v1
    /* 8F978 8009F178 C21F0200 */  srl        $v1, $v0, 31
    /* 8F97C 8009F17C 21104300 */  addu       $v0, $v0, $v1
    /* 8F980 8009F180 43180200 */  sra        $v1, $v0, 1
    /* 8F984 8009F184 2A106400 */  slt        $v0, $v1, $a0
    /* 8F988 8009F188 02004010 */  beqz       $v0, .L8009F194
    /* 8F98C 8009F18C 00000000 */   nop
    /* 8F990 8009F190 21188000 */  addu       $v1, $a0, $zero
  .L8009F194:
    /* 8F994 8009F194 8B7C0208 */  j          .L8009F22C
    /* 8F998 8009F198 300243AE */   sw        $v1, 0x230($s2)
  .L8009F19C:
    /* 8F99C 8009F19C 80100200 */  sll        $v0, $v0, 2
    /* 8F9A0 8009F1A0 21104202 */  addu       $v0, $s2, $v0
    /* 8F9A4 8009F1A4 1802428C */  lw         $v0, 0x218($v0)
    /* 8F9A8 8009F1A8 00000000 */  nop
    /* 8F9AC 8009F1AC 21106200 */  addu       $v0, $v1, $v0
    /* 8F9B0 8009F1B0 C21F0200 */  srl        $v1, $v0, 31
    /* 8F9B4 8009F1B4 21104300 */  addu       $v0, $v0, $v1
    /* 8F9B8 8009F1B8 43180200 */  sra        $v1, $v0, 1
    /* 8F9BC 8009F1BC 0100E226 */  addiu      $v0, $s7, 0x1
    /* 8F9C0 8009F1C0 80100200 */  sll        $v0, $v0, 2
    /* 8F9C4 8009F1C4 21284202 */  addu       $a1, $s2, $v0
    /* 8F9C8 8009F1C8 1802A48C */  lw         $a0, 0x218($a1)
    /* 8F9CC 8009F1CC 00000000 */  nop
    /* 8F9D0 8009F1D0 2A106400 */  slt        $v0, $v1, $a0
    /* 8F9D4 8009F1D4 02004010 */  beqz       $v0, .L8009F1E0
    /* 8F9D8 8009F1D8 FEFFE226 */   addiu     $v0, $s7, -0x2
    /* 8F9DC 8009F1DC 21188000 */  addu       $v1, $a0, $zero
  .L8009F1E0:
    /* 8F9E0 8009F1E0 80100200 */  sll        $v0, $v0, 2
    /* 8F9E4 8009F1E4 21104202 */  addu       $v0, $s2, $v0
    /* 8F9E8 8009F1E8 1802A3AC */  sw         $v1, 0x218($a1)
    /* 8F9EC 8009F1EC 1802C38C */  lw         $v1, 0x218($a2)
    /* 8F9F0 8009F1F0 1802428C */  lw         $v0, 0x218($v0)
    /* 8F9F4 8009F1F4 00000000 */  nop
    /* 8F9F8 8009F1F8 21186200 */  addu       $v1, $v1, $v0
    /* 8F9FC 8009F1FC C2170300 */  srl        $v0, $v1, 31
    /* 8FA00 8009F200 21186200 */  addu       $v1, $v1, $v0
    /* 8FA04 8009F204 FFFFE226 */  addiu      $v0, $s7, -0x1
    /* 8FA08 8009F208 80100200 */  sll        $v0, $v0, 2
    /* 8FA0C 8009F20C 21284202 */  addu       $a1, $s2, $v0
    /* 8FA10 8009F210 1802A48C */  lw         $a0, 0x218($a1)
    /* 8FA14 8009F214 43180300 */  sra        $v1, $v1, 1
    /* 8FA18 8009F218 2A106400 */  slt        $v0, $v1, $a0
    /* 8FA1C 8009F21C 02004010 */  beqz       $v0, .L8009F228
    /* 8FA20 8009F220 00000000 */   nop
    /* 8FA24 8009F224 21188000 */  addu       $v1, $a0, $zero
  .L8009F228:
    /* 8FA28 8009F228 1802A3AC */  sw         $v1, 0x218($a1)
  .L8009F22C:
    /* 8FA2C 8009F22C 2A012012 */  beqz       $s1, .L8009F6D8
    /* 8FA30 8009F230 0200163C */   lui       $s6, (0x20000 >> 16)
    /* 8FA34 8009F234 21A80000 */  addu       $s5, $zero, $zero
    /* 8FA38 8009F238 5A00023C */  lui        $v0, (0x5A0000 >> 16)
    /* 8FA3C 8009F23C 2A105000 */  slt        $v0, $v0, $s0
    /* 8FA40 8009F240 86004010 */  beqz       $v0, .L8009F45C
    /* 8FA44 8009F244 21A0C002 */   addu      $s4, $s6, $zero
    /* 8FA48 8009F248 02000106 */  bgez       $s0, .L8009F254
    /* 8FA4C 8009F24C 21280002 */   addu      $a1, $s0, $zero
    /* 8FA50 8009F250 03000526 */  addiu      $a1, $s0, 0x3
  .L8009F254:
    /* 8FA54 8009F254 83800500 */  sra        $s0, $a1, 2
    /* 8FA58 8009F258 0100033C */  lui        $v1, (0x1FFFF >> 16)
    /* 8FA5C 8009F25C FFFF6334 */  ori        $v1, $v1, (0x1FFFF & 0xFFFF)
    /* 8FA60 8009F260 8801448E */  lw         $a0, 0x188($s2)
    /* 8FA64 8009F264 01000224 */  addiu      $v0, $zero, 0x1
    /* 8FA68 8009F268 7C0142A6 */  sh         $v0, 0x17C($s2)
    /* 8FA6C 8009F26C 01000224 */  addiu      $v0, $zero, 0x1
    /* 8FA70 8009F270 AC0140AE */  sw         $zero, 0x1AC($s2)
    /* 8FA74 8009F274 2A186400 */  slt        $v1, $v1, $a0
    /* 8FA78 8009F278 05006014 */  bnez       $v1, .L8009F290
    /* 8FA7C 8009F27C 8C0742AE */   sw        $v0, 0x78C($s2)
    /* 8FA80 8009F280 A400428E */  lw         $v0, 0xA4($s2)
    /* 8FA84 8009F284 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 8FA88 8009F288 21104300 */  addu       $v0, $v0, $v1
    /* 8FA8C 8009F28C A40042AE */  sw         $v0, 0xA4($s2)
  .L8009F290:
    /* 8FA90 8009F290 5555023C */  lui        $v0, (0x55555556 >> 16)
    /* 8FA94 8009F294 56554234 */  ori        $v0, $v0, (0x55555556 & 0xFFFF)
    /* 8FA98 8009F298 18000202 */  mult       $s0, $v0
    /* 8FA9C 8009F29C 0C00043C */  lui        $a0, (0xC0000 >> 16)
    /* 8FAA0 8009F2A0 C3170500 */  sra        $v0, $a1, 31
    /* 8FAA4 8009F2A4 B000438E */  lw         $v1, 0xB0($s2)
    /* 8FAA8 8009F2A8 10580000 */  mfhi       $t3
    /* 8FAAC 8009F2AC 23106201 */  subu       $v0, $t3, $v0
    /* 8FAB0 8009F2B0 21186200 */  addu       $v1, $v1, $v0
    /* 8FAB4 8009F2B4 21108000 */  addu       $v0, $a0, $zero
    /* 8FAB8 8009F2B8 2A104300 */  slt        $v0, $v0, $v1
    /* 8FABC 8009F2BC 02004014 */  bnez       $v0, .L8009F2C8
    /* 8FAC0 8009F2C0 00000000 */   nop
    /* 8FAC4 8009F2C4 21206000 */  addu       $a0, $v1, $zero
  .L8009F2C8:
    /* 8FAC8 8009F2C8 B00044AE */  sw         $a0, 0xB0($s2)
    /* 8FACC 8009F2CC 02000106 */  bgez       $s0, .L8009F2D8
    /* 8FAD0 8009F2D0 21200002 */   addu      $a0, $s0, $zero
    /* 8FAD4 8009F2D4 1F000426 */  addiu      $a0, $s0, 0x1F
  .L8009F2D8:
    /* 8FAD8 8009F2D8 43990400 */  sra        $s3, $a0, 5
    /* 8FADC 8009F2DC 99990234 */  ori        $v0, $zero, 0x9999
    /* 8FAE0 8009F2E0 2A105300 */  slt        $v0, $v0, $s3
    /* 8FAE4 8009F2E4 02004010 */  beqz       $v0, .L8009F2F0
    /* 8FAE8 8009F2E8 00000000 */   nop
    /* 8FAEC 8009F2EC 99991334 */  ori        $s3, $zero, 0x9999
  .L8009F2F0:
    /* 8FAF0 8009F2F0 F5FF010C */  jal        BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* 8FAF4 8009F2F4 08004426 */   addiu     $a0, $s2, 0x8
    /* 8FAF8 8009F2F8 07004010 */  beqz       $v0, .L8009F318
    /* 8FAFC 8009F2FC 0900033C */   lui       $v1, (0x90000 >> 16)
    /* 8FB00 8009F300 B000428E */  lw         $v0, 0xB0($s2)
    /* 8FB04 8009F304 00000000 */  nop
    /* 8FB08 8009F308 2A106200 */  slt        $v0, $v1, $v0
    /* 8FB0C 8009F30C 03004010 */  beqz       $v0, .L8009F31C
    /* 8FB10 8009F310 1400023C */   lui       $v0, (0x140000 >> 16)
    /* 8FB14 8009F314 B00043AE */  sw         $v1, 0xB0($s2)
  .L8009F318:
    /* 8FB18 8009F318 1400023C */  lui        $v0, (0x140000 >> 16)
  .L8009F31C:
    /* 8FB1C 8009F31C 2A105000 */  slt        $v0, $v0, $s0
    /* 8FB20 8009F320 47004010 */  beqz       $v0, .L8009F440
    /* 8FB24 8009F324 FF00063C */   lui       $a2, (0xFFFF00 >> 16)
    /* 8FB28 8009F328 1480033C */  lui        $v1, %hi(fastRandom)
    /* 8FB2C 8009F32C FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 8FB30 8009F330 1480043C */  lui        $a0, %hi(randSeed)
    /* 8FB34 8009F334 04D1848C */  lw         $a0, %lo(randSeed)($a0)
    /* 8FB38 8009F338 00000000 */  nop
    /* 8FB3C 8009F33C 18006400 */  mult       $v1, $a0
    /* 8FB40 8009F340 12180000 */  mflo       $v1
    /* 8FB44 8009F344 FFFF6830 */  andi       $t0, $v1, 0xFFFF
    /* 8FB48 8009F348 00000000 */  nop
    /* 8FB4C 8009F34C 18000401 */  mult       $t0, $a0
    /* 8FB50 8009F350 12280000 */  mflo       $a1
    /* 8FB54 8009F354 FFFFA930 */  andi       $t1, $a1, 0xFFFF
    /* 8FB58 8009F358 00000000 */  nop
    /* 8FB5C 8009F35C 18002401 */  mult       $t1, $a0
    /* 8FB60 8009F360 00FFC634 */  ori        $a2, $a2, (0xFFFF00 & 0xFFFF)
    /* 8FB64 8009F364 24106600 */  and        $v0, $v1, $a2
    /* 8FB68 8009F368 02520200 */  srl        $t2, $v0, 8
    /* 8FB6C 8009F36C 1480013C */  lui        $at, %hi(randtemp)
    /* 8FB70 8009F370 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 8FB74 8009F374 1480013C */  lui        $at, %hi(fastRandom)
    /* 8FB78 8009F378 FCD028AC */  sw         $t0, %lo(fastRandom)($at)
    /* 8FB7C 8009F37C 12380000 */  mflo       $a3
    /* 8FB80 8009F380 2410A600 */  and        $v0, $a1, $a2
    /* 8FB84 8009F384 FFFFE830 */  andi       $t0, $a3, 0xFFFF
    /* 8FB88 8009F388 18000401 */  mult       $t0, $a0
    /* 8FB8C 8009F38C 02120200 */  srl        $v0, $v0, 8
    /* 8FB90 8009F390 40180200 */  sll        $v1, $v0, 1
    /* 8FB94 8009F394 21A86200 */  addu       $s5, $v1, $v0
    /* 8FB98 8009F398 1480013C */  lui        $at, %hi(randtemp)
    /* 8FB9C 8009F39C 00D125AC */  sw         $a1, %lo(randtemp)($at)
    /* 8FBA0 8009F3A0 1480013C */  lui        $at, %hi(fastRandom)
    /* 8FBA4 8009F3A4 FCD029AC */  sw         $t1, %lo(fastRandom)($at)
    /* 8FBA8 8009F3A8 2410E600 */  and        $v0, $a3, $a2
    /* 8FBAC 8009F3AC 02120200 */  srl        $v0, $v0, 8
    /* 8FBB0 8009F3B0 40180200 */  sll        $v1, $v0, 1
    /* 8FBB4 8009F3B4 21A06200 */  addu       $s4, $v1, $v0
    /* 8FBB8 8009F3B8 1480013C */  lui        $at, %hi(randtemp)
    /* 8FBBC 8009F3BC 00D127AC */  sw         $a3, %lo(randtemp)($at)
    /* 8FBC0 8009F3C0 1480013C */  lui        $at, %hi(fastRandom)
    /* 8FBC4 8009F3C4 FCD028AC */  sw         $t0, %lo(fastRandom)($at)
    /* 8FBC8 8009F3C8 12200000 */  mflo       $a0
    /* 8FBCC 8009F3CC FFFF8230 */  andi       $v0, $a0, 0xFFFF
    /* 8FBD0 8009F3D0 1480013C */  lui        $at, %hi(randtemp)
    /* 8FBD4 8009F3D4 00D124AC */  sw         $a0, %lo(randtemp)($at)
    /* 8FBD8 8009F3D8 24208600 */  and        $a0, $a0, $a2
    /* 8FBDC 8009F3DC 02220400 */  srl        $a0, $a0, 8
    /* 8FBE0 8009F3E0 3333842C */  sltiu      $a0, $a0, 0x3333
    /* 8FBE4 8009F3E4 1480013C */  lui        $at, %hi(fastRandom)
    /* 8FBE8 8009F3E8 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 8FBEC 8009F3EC 02008010 */  beqz       $a0, .L8009F3F8
    /* 8FBF0 8009F3F0 80B00A00 */   sll       $s6, $t2, 2
    /* 8FBF4 8009F3F4 23981300 */  negu       $s3, $s3
  .L8009F3F8:
    /* 8FBF8 8009F3F8 0300033C */  lui        $v1, (0x3FFFF >> 16)
    /* 8FBFC 8009F3FC FFFF6334 */  ori        $v1, $v1, (0x3FFFF & 0xFFFF)
    /* 8FC00 8009F400 2110D502 */  addu       $v0, $s6, $s5
    /* 8FC04 8009F404 21105400 */  addu       $v0, $v0, $s4
    /* 8FC08 8009F408 2A186200 */  slt        $v1, $v1, $v0
    /* 8FC0C 8009F40C 0D006014 */  bnez       $v1, .L8009F444
    /* 8FC10 8009F410 02000224 */   addiu     $v0, $zero, 0x2
    /* 8FC14 8009F414 FFFF0334 */  ori        $v1, $zero, 0xFFFF
    /* 8FC18 8009F418 2A107600 */  slt        $v0, $v1, $s6
    /* 8FC1C 8009F41C 02004014 */  bnez       $v0, .L8009F428
    /* 8FC20 8009F420 2A107500 */   slt       $v0, $v1, $s5
    /* 8FC24 8009F424 C0B00A00 */  sll        $s6, $t2, 3
  .L8009F428:
    /* 8FC28 8009F428 02004014 */  bnez       $v0, .L8009F434
    /* 8FC2C 8009F42C 2A107400 */   slt       $v0, $v1, $s4
    /* 8FC30 8009F430 40A81500 */  sll        $s5, $s5, 1
  .L8009F434:
    /* 8FC34 8009F434 03004014 */  bnez       $v0, .L8009F444
    /* 8FC38 8009F438 02000224 */   addiu     $v0, $zero, 0x2
    /* 8FC3C 8009F43C 40A01400 */  sll        $s4, $s4, 1
  .L8009F440:
    /* 8FC40 8009F440 02000224 */  addiu      $v0, $zero, 0x2
  .L8009F444:
    /* 8FC44 8009F444 0F002216 */  bne        $s1, $v0, .L8009F484
    /* 8FC48 8009F448 00000000 */   nop
    /* 8FC4C 8009F44C 40B01600 */  sll        $s6, $s6, 1
    /* 8FC50 8009F450 40A81500 */  sll        $s5, $s5, 1
    /* 8FC54 8009F454 217D0208 */  j          .L8009F484
    /* 8FC58 8009F458 40A01400 */   sll       $s4, $s4, 1
  .L8009F45C:
    /* 8FC5C 8009F45C 21280002 */  addu       $a1, $s0, $zero
    /* 8FC60 8009F460 0300A104 */  bgez       $a1, .L8009F470
    /* 8FC64 8009F464 83990500 */   sra       $s3, $a1, 6
    /* 8FC68 8009F468 3F00A524 */  addiu      $a1, $a1, 0x3F
    /* 8FC6C 8009F46C 83990500 */  sra        $s3, $a1, 6
  .L8009F470:
    /* 8FC70 8009F470 00800234 */  ori        $v0, $zero, 0x8000
    /* 8FC74 8009F474 2A105300 */  slt        $v0, $v0, $s3
    /* 8FC78 8009F478 02004010 */  beqz       $v0, .L8009F484
    /* 8FC7C 8009F47C 00000000 */   nop
    /* 8FC80 8009F480 00801334 */  ori        $s3, $zero, 0x8000
  .L8009F484:
    /* 8FC84 8009F484 1401448E */  lw         $a0, 0x114($s2)
    /* 8FC88 8009F488 F000458E */  lw         $a1, 0xF0($s2)
    /* 8FC8C 8009F48C CA90030C */  jal        fixedmult
    /* 8FC90 8009F490 00000000 */   nop
    /* 8FC94 8009F494 1801448E */  lw         $a0, 0x118($s2)
    /* 8FC98 8009F498 F400458E */  lw         $a1, 0xF4($s2)
    /* 8FC9C 8009F49C CA90030C */  jal        fixedmult
    /* 8FCA0 8009F4A0 21804000 */   addu      $s0, $v0, $zero
    /* 8FCA4 8009F4A4 1C01448E */  lw         $a0, 0x11C($s2)
    /* 8FCA8 8009F4A8 F800458E */  lw         $a1, 0xF8($s2)
    /* 8FCAC 8009F4AC CA90030C */  jal        fixedmult
    /* 8FCB0 8009F4B0 21884000 */   addu      $s1, $v0, $zero
    /* 8FCB4 8009F4B4 21801102 */  addu       $s0, $s0, $s1
    /* 8FCB8 8009F4B8 1401448E */  lw         $a0, 0x114($s2)
    /* 8FCBC 8009F4BC FC00458E */  lw         $a1, 0xFC($s2)
    /* 8FCC0 8009F4C0 21800202 */  addu       $s0, $s0, $v0
    /* 8FCC4 8009F4C4 CA90030C */  jal        fixedmult
    /* 8FCC8 8009F4C8 240450AE */   sw        $s0, 0x424($s2)
    /* 8FCCC 8009F4CC 1801448E */  lw         $a0, 0x118($s2)
    /* 8FCD0 8009F4D0 0001458E */  lw         $a1, 0x100($s2)
    /* 8FCD4 8009F4D4 CA90030C */  jal        fixedmult
    /* 8FCD8 8009F4D8 21804000 */   addu      $s0, $v0, $zero
    /* 8FCDC 8009F4DC 1C01448E */  lw         $a0, 0x11C($s2)
    /* 8FCE0 8009F4E0 0401458E */  lw         $a1, 0x104($s2)
    /* 8FCE4 8009F4E4 CA90030C */  jal        fixedmult
    /* 8FCE8 8009F4E8 21884000 */   addu      $s1, $v0, $zero
    /* 8FCEC 8009F4EC 21801102 */  addu       $s0, $s0, $s1
    /* 8FCF0 8009F4F0 1401448E */  lw         $a0, 0x114($s2)
    /* 8FCF4 8009F4F4 0801458E */  lw         $a1, 0x108($s2)
    /* 8FCF8 8009F4F8 21800202 */  addu       $s0, $s0, $v0
    /* 8FCFC 8009F4FC CA90030C */  jal        fixedmult
    /* 8FD00 8009F500 280450AE */   sw        $s0, 0x428($s2)
    /* 8FD04 8009F504 1801448E */  lw         $a0, 0x118($s2)
    /* 8FD08 8009F508 0C01458E */  lw         $a1, 0x10C($s2)
    /* 8FD0C 8009F50C CA90030C */  jal        fixedmult
    /* 8FD10 8009F510 21804000 */   addu      $s0, $v0, $zero
    /* 8FD14 8009F514 1C01448E */  lw         $a0, 0x11C($s2)
    /* 8FD18 8009F518 1001458E */  lw         $a1, 0x110($s2)
    /* 8FD1C 8009F51C CA90030C */  jal        fixedmult
    /* 8FD20 8009F520 21884000 */   addu      $s1, $v0, $zero
    /* 8FD24 8009F524 21801102 */  addu       $s0, $s0, $s1
    /* 8FD28 8009F528 21800202 */  addu       $s0, $s0, $v0
    /* 8FD2C 8009F52C 0300E22E */  sltiu      $v0, $s7, 0x3
    /* 8FD30 8009F530 0A004010 */  beqz       $v0, .L8009F55C
    /* 8FD34 8009F534 2C0450AE */   sw        $s0, 0x42C($s2)
    /* 8FD38 8009F538 21206002 */  addu       $a0, $s3, $zero
    /* 8FD3C 8009F53C CA90030C */  jal        fixedmult
    /* 8FD40 8009F540 2128C002 */   addu      $a1, $s6, $zero
    /* 8FD44 8009F544 C21F0200 */  srl        $v1, $v0, 31
    /* 8FD48 8009F548 21186200 */  addu       $v1, $v1, $v0
    /* 8FD4C 8009F54C 2404428E */  lw         $v0, 0x424($s2)
    /* 8FD50 8009F550 43180300 */  sra        $v1, $v1, 1
    /* 8FD54 8009F554 5F7D0208 */  j          .L8009F57C
    /* 8FD58 8009F558 23104300 */   subu      $v0, $v0, $v1
  .L8009F55C:
    /* 8FD5C 8009F55C 21206002 */  addu       $a0, $s3, $zero
    /* 8FD60 8009F560 CA90030C */  jal        fixedmult
    /* 8FD64 8009F564 2128C002 */   addu      $a1, $s6, $zero
    /* 8FD68 8009F568 C21F0200 */  srl        $v1, $v0, 31
    /* 8FD6C 8009F56C 21186200 */  addu       $v1, $v1, $v0
    /* 8FD70 8009F570 2404428E */  lw         $v0, 0x424($s2)
    /* 8FD74 8009F574 43180300 */  sra        $v1, $v1, 1
    /* 8FD78 8009F578 21104300 */  addu       $v0, $v0, $v1
  .L8009F57C:
    /* 8FD7C 8009F57C 240442AE */  sw         $v0, 0x424($s2)
    /* 8FD80 8009F580 FEFFE226 */  addiu      $v0, $s7, -0x2
    /* 8FD84 8009F584 0300422C */  sltiu      $v0, $v0, 0x3
    /* 8FD88 8009F588 12004010 */  beqz       $v0, .L8009F5D4
    /* 8FD8C 8009F58C 21206002 */   addu      $a0, $s3, $zero
    /* 8FD90 8009F590 CA90030C */  jal        fixedmult
    /* 8FD94 8009F594 2128A002 */   addu      $a1, $s5, $zero
    /* 8FD98 8009F598 21206002 */  addu       $a0, $s3, $zero
    /* 8FD9C 8009F59C 21288002 */  addu       $a1, $s4, $zero
    /* 8FDA0 8009F5A0 C21F0200 */  srl        $v1, $v0, 31
    /* 8FDA4 8009F5A4 21186200 */  addu       $v1, $v1, $v0
    /* 8FDA8 8009F5A8 2804428E */  lw         $v0, 0x428($s2)
    /* 8FDAC 8009F5AC 43180300 */  sra        $v1, $v1, 1
    /* 8FDB0 8009F5B0 21104300 */  addu       $v0, $v0, $v1
    /* 8FDB4 8009F5B4 CA90030C */  jal        fixedmult
    /* 8FDB8 8009F5B8 280442AE */   sw        $v0, 0x428($s2)
    /* 8FDBC 8009F5BC C21F0200 */  srl        $v1, $v0, 31
    /* 8FDC0 8009F5C0 21186200 */  addu       $v1, $v1, $v0
    /* 8FDC4 8009F5C4 2C04428E */  lw         $v0, 0x42C($s2)
    /* 8FDC8 8009F5C8 43180300 */  sra        $v1, $v1, 1
    /* 8FDCC 8009F5CC 857D0208 */  j          .L8009F614
    /* 8FDD0 8009F5D0 21104300 */   addu      $v0, $v0, $v1
  .L8009F5D4:
    /* 8FDD4 8009F5D4 CA90030C */  jal        fixedmult
    /* 8FDD8 8009F5D8 2128A002 */   addu      $a1, $s5, $zero
    /* 8FDDC 8009F5DC 21206002 */  addu       $a0, $s3, $zero
    /* 8FDE0 8009F5E0 21288002 */  addu       $a1, $s4, $zero
    /* 8FDE4 8009F5E4 C21F0200 */  srl        $v1, $v0, 31
    /* 8FDE8 8009F5E8 21186200 */  addu       $v1, $v1, $v0
    /* 8FDEC 8009F5EC 2804428E */  lw         $v0, 0x428($s2)
    /* 8FDF0 8009F5F0 43180300 */  sra        $v1, $v1, 1
    /* 8FDF4 8009F5F4 23104300 */  subu       $v0, $v0, $v1
    /* 8FDF8 8009F5F8 CA90030C */  jal        fixedmult
    /* 8FDFC 8009F5FC 280442AE */   sw        $v0, 0x428($s2)
    /* 8FE00 8009F600 C21F0200 */  srl        $v1, $v0, 31
    /* 8FE04 8009F604 21186200 */  addu       $v1, $v1, $v0
    /* 8FE08 8009F608 2C04428E */  lw         $v0, 0x42C($s2)
    /* 8FE0C 8009F60C 43180300 */  sra        $v1, $v1, 1
    /* 8FE10 8009F610 23104300 */  subu       $v0, $v0, $v1
  .L8009F614:
    /* 8FE14 8009F614 2C0442AE */  sw         $v0, 0x42C($s2)
    /* 8FE18 8009F618 F0004426 */  addiu      $a0, $s2, 0xF0
    /* 8FE1C 8009F61C D690030C */  jal        transpose
    /* 8FE20 8009F620 1000A527 */   addiu     $a1, $sp, 0x10
    /* 8FE24 8009F624 2404448E */  lw         $a0, 0x424($s2)
    /* 8FE28 8009F628 1000A58F */  lw         $a1, 0x10($sp)
    /* 8FE2C 8009F62C CA90030C */  jal        fixedmult
    /* 8FE30 8009F630 00000000 */   nop
    /* 8FE34 8009F634 2804448E */  lw         $a0, 0x428($s2)
    /* 8FE38 8009F638 1400A58F */  lw         $a1, 0x14($sp)
    /* 8FE3C 8009F63C CA90030C */  jal        fixedmult
    /* 8FE40 8009F640 21804000 */   addu      $s0, $v0, $zero
    /* 8FE44 8009F644 2C04448E */  lw         $a0, 0x42C($s2)
    /* 8FE48 8009F648 1800A58F */  lw         $a1, 0x18($sp)
    /* 8FE4C 8009F64C CA90030C */  jal        fixedmult
    /* 8FE50 8009F650 21884000 */   addu      $s1, $v0, $zero
    /* 8FE54 8009F654 21801102 */  addu       $s0, $s0, $s1
    /* 8FE58 8009F658 2404448E */  lw         $a0, 0x424($s2)
    /* 8FE5C 8009F65C 21800202 */  addu       $s0, $s0, $v0
    /* 8FE60 8009F660 140150AE */  sw         $s0, 0x114($s2)
    /* 8FE64 8009F664 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 8FE68 8009F668 CA90030C */  jal        fixedmult
    /* 8FE6C 8009F66C 00000000 */   nop
    /* 8FE70 8009F670 2804448E */  lw         $a0, 0x428($s2)
    /* 8FE74 8009F674 2000A58F */  lw         $a1, 0x20($sp)
    /* 8FE78 8009F678 CA90030C */  jal        fixedmult
    /* 8FE7C 8009F67C 21804000 */   addu      $s0, $v0, $zero
    /* 8FE80 8009F680 2C04448E */  lw         $a0, 0x42C($s2)
    /* 8FE84 8009F684 2400A58F */  lw         $a1, 0x24($sp)
    /* 8FE88 8009F688 CA90030C */  jal        fixedmult
    /* 8FE8C 8009F68C 21884000 */   addu      $s1, $v0, $zero
    /* 8FE90 8009F690 21801102 */  addu       $s0, $s0, $s1
    /* 8FE94 8009F694 2404448E */  lw         $a0, 0x424($s2)
    /* 8FE98 8009F698 21800202 */  addu       $s0, $s0, $v0
    /* 8FE9C 8009F69C 180150AE */  sw         $s0, 0x118($s2)
    /* 8FEA0 8009F6A0 2800A58F */  lw         $a1, 0x28($sp)
    /* 8FEA4 8009F6A4 CA90030C */  jal        fixedmult
    /* 8FEA8 8009F6A8 00000000 */   nop
    /* 8FEAC 8009F6AC 2804448E */  lw         $a0, 0x428($s2)
    /* 8FEB0 8009F6B0 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 8FEB4 8009F6B4 CA90030C */  jal        fixedmult
    /* 8FEB8 8009F6B8 21804000 */   addu      $s0, $v0, $zero
    /* 8FEBC 8009F6BC 2C04448E */  lw         $a0, 0x42C($s2)
    /* 8FEC0 8009F6C0 3000A58F */  lw         $a1, 0x30($sp)
    /* 8FEC4 8009F6C4 CA90030C */  jal        fixedmult
    /* 8FEC8 8009F6C8 21884000 */   addu      $s1, $v0, $zero
    /* 8FECC 8009F6CC 21801102 */  addu       $s0, $s0, $s1
    /* 8FED0 8009F6D0 21800202 */  addu       $s0, $s0, $v0
    /* 8FED4 8009F6D4 1C0150AE */  sw         $s0, 0x11C($s2)
  .L8009F6D8:
    /* 8FED8 8009F6D8 5800BF8F */  lw         $ra, 0x58($sp)
    /* 8FEDC 8009F6DC 5400B78F */  lw         $s7, 0x54($sp)
    /* 8FEE0 8009F6E0 5000B68F */  lw         $s6, 0x50($sp)
    /* 8FEE4 8009F6E4 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 8FEE8 8009F6E8 4800B48F */  lw         $s4, 0x48($sp)
    /* 8FEEC 8009F6EC 4400B38F */  lw         $s3, 0x44($sp)
    /* 8FEF0 8009F6F0 4000B28F */  lw         $s2, 0x40($sp)
    /* 8FEF4 8009F6F4 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 8FEF8 8009F6F8 3800B08F */  lw         $s0, 0x38($sp)
    /* 8FEFC 8009F6FC 0800E003 */  jr         $ra
    /* 8FF00 8009F700 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel Newton_AddDamageZone__FP13BO_tNewtonObjiii
