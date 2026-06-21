.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__16tScreenCarSelect, 0x8B4

glabel DrawForeground__16tScreenCarSelect
    /* 2CFD8 8003C7D8 B0FEBD27 */  addiu      $sp, $sp, -0x150
    /* 2CFDC 8003C7DC 3C01B3AF */  sw         $s3, 0x13C($sp)
    /* 2CFE0 8003C7E0 21988000 */  addu       $s3, $a0, $zero
    /* 2CFE4 8003C7E4 0580023C */  lui        $v0, %hi(FEApp)
    /* 2CFE8 8003C7E8 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2CFEC 8003C7EC 3000A527 */  addiu      $a1, $sp, 0x30
    /* 2CFF0 8003C7F0 4801BFAF */  sw         $ra, 0x148($sp)
    /* 2CFF4 8003C7F4 4401B5AF */  sw         $s5, 0x144($sp)
    /* 2CFF8 8003C7F8 4001B4AF */  sw         $s4, 0x140($sp)
    /* 2CFFC 8003C7FC 3801B2AF */  sw         $s2, 0x138($sp)
    /* 2D000 8003C800 3401B1AF */  sw         $s1, 0x134($sp)
    /* 2D004 8003C804 3001B0AF */  sw         $s0, 0x130($sp)
    /* 2D008 8003C808 6000668E */  lw         $a2, 0x60($s3)
    /* 2D00C 8003C80C 0400438C */  lw         $v1, 0x4($v0)
    /* 2D010 8003C810 6800C484 */  lh         $a0, 0x68($a2)
    /* 2D014 8003C814 0800628C */  lw         $v0, 0x8($v1)
    /* 2D018 8003C818 00000000 */  nop
    /* 2D01C 8003C81C 80100200 */  sll        $v0, $v0, 2
    /* 2D020 8003C820 21186200 */  addu       $v1, $v1, $v0
    /* 2D024 8003C824 6C00C28C */  lw         $v0, 0x6C($a2)
    /* 2D028 8003C828 1000708C */  lw         $s0, 0x10($v1)
    /* 2D02C 8003C82C 09F84000 */  jalr       $v0
    /* 2D030 8003C830 21206402 */   addu      $a0, $s3, $a0
    /* 2D034 8003C834 0580143C */  lui        $s4, %hi(menuDefs)
    /* 2D038 8003C838 21880000 */  addu       $s1, $zero, $zero
    /* 2D03C 8003C83C 581A858E */  lw         $a1, %lo(menuDefs)($s4)
    /* 2D040 8003C840 21900002 */  addu       $s2, $s0, $zero
    /* 2D044 8003C844 B820A38C */  lw         $v1, 0x20B8($a1)
    /* 2D048 8003C848 00000000 */  nop
    /* 2D04C 8003C84C 01006334 */  ori        $v1, $v1, 0x1
    /* 2D050 8003C850 B820A3AC */  sw         $v1, 0x20B8($a1)
    /* 2D054 8003C854 1C016386 */  lh         $v1, 0x11C($s3)
    /* 2D058 8003C858 01000424 */  addiu      $a0, $zero, 0x1
    /* 2D05C 8003C85C 30006414 */  bne        $v1, $a0, .L8003C920
    /* 2D060 8003C860 21A84000 */   addu      $s5, $v0, $zero
    /* 2D064 8003C864 E812A224 */  addiu      $v0, $a1, 0x12E8
    /* 2D068 8003C868 26100202 */  xor        $v0, $s0, $v0
    /* 2D06C 8003C86C 2B104400 */  sltu       $v0, $v0, $a0
    /* 2D070 8003C870 21884000 */  addu       $s1, $v0, $zero
    /* 2D074 8003C874 3C13A28C */  lw         $v0, 0x133C($a1)
    /* 2D078 8003C878 FEFF1024 */  addiu      $s0, $zero, -0x2
    /* 2D07C 8003C87C 24105000 */  and        $v0, $v0, $s0
    /* 2D080 8003C880 3C13A2AC */  sw         $v0, 0x133C($a1)
    /* 2D084 8003C884 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2D088 8003C888 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 2D08C 8003C88C 04008390 */  lbu        $v1, 0x4($a0)
    /* 2D090 8003C890 02000224 */  addiu      $v0, $zero, 0x2
    /* 2D094 8003C894 0F006214 */  bne        $v1, $v0, .L8003C8D4
    /* 2D098 8003C898 00000000 */   nop
    /* 2D09C 8003C89C 22018290 */  lbu        $v0, 0x122($a0)
    /* 2D0A0 8003C8A0 00000000 */  nop
    /* 2D0A4 8003C8A4 0B004014 */  bnez       $v0, .L8003C8D4
    /* 2D0A8 8003C8A8 00000000 */   nop
    /* 2D0AC 8003C8AC C78D000C */  jal        FECheat_IsCheatEnabled__F10tCheatCode
    /* 2D0B0 8003C8B0 19000424 */   addiu     $a0, $zero, 0x19
    /* 2D0B4 8003C8B4 07004010 */  beqz       $v0, .L8003C8D4
    /* 2D0B8 8003C8B8 00000000 */   nop
    /* 2D0BC 8003C8BC 581A838E */  lw         $v1, %lo(menuDefs)($s4)
    /* 2D0C0 8003C8C0 00000000 */  nop
    /* 2D0C4 8003C8C4 B820628C */  lw         $v0, 0x20B8($v1)
    /* 2D0C8 8003C8C8 00000000 */  nop
    /* 2D0CC 8003C8CC 24105000 */  and        $v0, $v0, $s0
    /* 2D0D0 8003C8D0 B82062AC */  sw         $v0, 0x20B8($v1)
  .L8003C8D4:
    /* 2D0D4 8003C8D4 0900A012 */  beqz       $s5, .L8003C8FC
    /* 2D0D8 8003C8D8 0580023C */   lui       $v0, %hi(menuDefs)
    /* 2D0DC 8003C8DC 3200A293 */  lbu        $v0, 0x32($sp)
    /* 2D0E0 8003C8E0 00000000 */  nop
    /* 2D0E4 8003C8E4 0500422C */  sltiu      $v0, $v0, 0x5
    /* 2D0E8 8003C8E8 03004010 */  beqz       $v0, .L8003C8F8
    /* 2D0EC 8003C8EC 01000224 */   addiu     $v0, $zero, 0x1
    /* 2D0F0 8003C8F0 7DF20008 */  j          .L8003C9F4
    /* 2D0F4 8003C8F4 D80062A6 */   sh        $v0, 0xD8($s3)
  .L8003C8F8:
    /* 2D0F8 8003C8F8 0580023C */  lui        $v0, %hi(menuDefs)
  .L8003C8FC:
    /* 2D0FC 8003C8FC 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 2D100 8003C900 00000000 */  nop
    /* 2D104 8003C904 3C13628C */  lw         $v0, 0x133C($v1)
    /* 2D108 8003C908 00000000 */  nop
    /* 2D10C 8003C90C 01004234 */  ori        $v0, $v0, 0x1
    /* 2D110 8003C910 3C1362AC */  sw         $v0, 0x133C($v1)
    /* 2D114 8003C914 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2D118 8003C918 7DF20008 */  j          .L8003C9F4
    /* 2D11C 8003C91C D80062A6 */   sh        $v0, 0xD8($s3)
  .L8003C920:
    /* 2D120 8003C920 16006014 */  bnez       $v1, .L8003C97C
    /* 2D124 8003C924 02000224 */   addiu     $v0, $zero, 0x2
    /* 2D128 8003C928 D411A224 */  addiu      $v0, $a1, 0x11D4
    /* 2D12C 8003C92C 02000216 */  bne        $s0, $v0, .L8003C938
    /* 2D130 8003C930 FEFF0424 */   addiu     $a0, $zero, -0x2
    /* 2D134 8003C934 01001124 */  addiu      $s1, $zero, 0x1
  .L8003C938:
    /* 2D138 8003C938 FC11A28C */  lw         $v0, 0x11FC($a1)
    /* 2D13C 8003C93C 2412A38C */  lw         $v1, 0x1224($a1)
    /* 2D140 8003C940 24104400 */  and        $v0, $v0, $a0
    /* 2D144 8003C944 24186400 */  and        $v1, $v1, $a0
    /* 2D148 8003C948 FC11A2AC */  sw         $v0, 0x11FC($a1)
    /* 2D14C 8003C94C 2412A3AC */  sw         $v1, 0x1224($a1)
    /* 2D150 8003C950 3200A393 */  lbu        $v1, 0x32($sp)
    /* 2D154 8003C954 07000224 */  addiu      $v0, $zero, 0x7
    /* 2D158 8003C958 26006214 */  bne        $v1, $v0, .L8003C9F4
    /* 2D15C 8003C95C 00000000 */   nop
    /* 2D160 8003C960 FC11A28C */  lw         $v0, 0x11FC($a1)
    /* 2D164 8003C964 2412A38C */  lw         $v1, 0x1224($a1)
    /* 2D168 8003C968 01004234 */  ori        $v0, $v0, 0x1
    /* 2D16C 8003C96C 01006334 */  ori        $v1, $v1, 0x1
    /* 2D170 8003C970 FC11A2AC */  sw         $v0, 0x11FC($a1)
    /* 2D174 8003C974 7DF20008 */  j          .L8003C9F4
    /* 2D178 8003C978 2412A3AC */   sw        $v1, 0x1224($a1)
  .L8003C97C:
    /* 2D17C 8003C97C 06006214 */  bne        $v1, $v0, .L8003C998
    /* 2D180 8003C980 03000224 */   addiu     $v0, $zero, 0x3
    /* 2D184 8003C984 A01CA224 */  addiu      $v0, $a1, 0x1CA0
    /* 2D188 8003C988 1A000216 */  bne        $s0, $v0, .L8003C9F4
    /* 2D18C 8003C98C 00000000 */   nop
    /* 2D190 8003C990 7DF20008 */  j          .L8003C9F4
    /* 2D194 8003C994 01001124 */   addiu     $s1, $zero, 0x1
  .L8003C998:
    /* 2D198 8003C998 13006214 */  bne        $v1, $v0, .L8003C9E8
    /* 2D19C 8003C99C 04000224 */   addiu     $v0, $zero, 0x4
    /* 2D1A0 8003C9A0 E01DA224 */  addiu      $v0, $a1, 0x1DE0
    /* 2D1A4 8003C9A4 02004216 */  bne        $s2, $v0, .L8003C9B0
    /* 2D1A8 8003C9A8 00000000 */   nop
    /* 2D1AC 8003C9AC 01001124 */  addiu      $s1, $zero, 0x1
  .L8003C9B0:
    /* 2D1B0 8003C9B0 081EA28C */  lw         $v0, 0x1E08($a1)
    /* 2D1B4 8003C9B4 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 2D1B8 8003C9B8 24104300 */  and        $v0, $v0, $v1
    /* 2D1BC 8003C9BC 0300A012 */  beqz       $s5, .L8003C9CC
    /* 2D1C0 8003C9C0 081EA2AC */   sw        $v0, 0x1E08($a1)
    /* 2D1C4 8003C9C4 7DF20008 */  j          .L8003C9F4
    /* 2D1C8 8003C9C8 D80064A6 */   sh        $a0, 0xD8($s3)
  .L8003C9CC:
    /* 2D1CC 8003C9CC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2D1D0 8003C9D0 D80062A6 */  sh         $v0, 0xD8($s3)
    /* 2D1D4 8003C9D4 081EA28C */  lw         $v0, 0x1E08($a1)
    /* 2D1D8 8003C9D8 00000000 */  nop
    /* 2D1DC 8003C9DC 01004234 */  ori        $v0, $v0, 0x1
    /* 2D1E0 8003C9E0 7DF20008 */  j          .L8003C9F4
    /* 2D1E4 8003C9E4 081EA2AC */   sw        $v0, 0x1E08($a1)
  .L8003C9E8:
    /* 2D1E8 8003C9E8 02006214 */  bne        $v1, $v0, .L8003C9F4
    /* 2D1EC 8003C9EC 00000000 */   nop
    /* 2D1F0 8003C9F0 01001124 */  addiu      $s1, $zero, 0x1
  .L8003C9F4:
    /* 2D1F4 8003C9F4 0300A016 */  bnez       $s5, .L8003CA04
    /* 2D1F8 8003C9F8 21102002 */   addu      $v0, $s1, $zero
    /* 2D1FC 8003C9FC 21880000 */  addu       $s1, $zero, $zero
    /* 2D200 8003CA00 21102002 */  addu       $v0, $s1, $zero
  .L8003CA04:
    /* 2D204 8003CA04 02004014 */  bnez       $v0, .L8003CA10
    /* 2D208 8003CA08 01000224 */   addiu     $v0, $zero, 0x1
    /* 2D20C 8003CA0C FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8003CA10:
    /* 2D210 8003CA10 080162A6 */  sh         $v0, 0x108($s3)
    /* 2D214 8003CA14 21800000 */  addu       $s0, $zero, $zero
    /* 2D218 8003CA18 0580023C */  lui        $v0, %hi(D_80051FA4)
    /* 2D21C 8003CA1C A41F4724 */  addiu      $a3, $v0, %lo(D_80051FA4)
    /* 2D220 8003CA20 01000824 */  addiu      $t0, $zero, 0x1
    /* 2D224 8003CA24 00141000 */  sll        $v0, $s0, 16
  .L8003CA28:
    /* 2D228 8003CA28 03340200 */  sra        $a2, $v0, 16
    /* 2D22C 8003CA2C 80100600 */  sll        $v0, $a2, 2
    /* 2D230 8003CA30 21286202 */  addu       $a1, $s3, $v0
    /* 2D234 8003CA34 0C01A48C */  lw         $a0, 0x10C($a1)
    /* 2D238 8003CA38 00000000 */  nop
    /* 2D23C 8003CA3C 12008010 */  beqz       $a0, .L8003CA88
    /* 2D240 8003CA40 00000000 */   nop
    /* 2D244 8003CA44 1C016286 */  lh         $v0, 0x11C($s3)
    /* 2D248 8003CA48 16008384 */  lh         $v1, 0x16($a0)
    /* 2D24C 8003CA4C 80100200 */  sll        $v0, $v0, 2
    /* 2D250 8003CA50 2110C200 */  addu       $v0, $a2, $v0
    /* 2D254 8003CA54 21104700 */  addu       $v0, $v0, $a3
    /* 2D258 8003CA58 00004280 */  lb         $v0, 0x0($v0)
    /* 2D25C 8003CA5C 00000000 */  nop
    /* 2D260 8003CA60 1B006210 */  beq        $v1, $v0, .L8003CAD0
    /* 2D264 8003CA64 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 2D268 8003CA68 140082A4 */  sh         $v0, 0x14($a0)
    /* 2D26C 8003CA6C 0C01A28C */  lw         $v0, 0x10C($a1)
    /* 2D270 8003CA70 00000000 */  nop
    /* 2D274 8003CA74 10004284 */  lh         $v0, 0x10($v0)
    /* 2D278 8003CA78 00000000 */  nop
    /* 2D27C 8003CA7C 1500401C */  bgtz       $v0, .L8003CAD4
    /* 2D280 8003CA80 01000226 */   addiu     $v0, $s0, 0x1
    /* 2D284 8003CA84 0C01A0AC */  sw         $zero, 0x10C($a1)
  .L8003CA88:
    /* 2D288 8003CA88 1C016286 */  lh         $v0, 0x11C($s3)
    /* 2D28C 8003CA8C 00000000 */  nop
    /* 2D290 8003CA90 80100200 */  sll        $v0, $v0, 2
    /* 2D294 8003CA94 2110C200 */  addu       $v0, $a2, $v0
    /* 2D298 8003CA98 21104700 */  addu       $v0, $v0, $a3
    /* 2D29C 8003CA9C 00004380 */  lb         $v1, 0x0($v0)
    /* 2D2A0 8003CAA0 00000000 */  nop
    /* 2D2A4 8003CAA4 0A006004 */  bltz       $v1, .L8003CAD0
    /* 2D2A8 8003CAA8 40100300 */   sll       $v0, $v1, 1
    /* 2D2AC 8003CAAC 21104300 */  addu       $v0, $v0, $v1
    /* 2D2B0 8003CAB0 C0100200 */  sll        $v0, $v0, 3
    /* 2D2B4 8003CAB4 64004224 */  addiu      $v0, $v0, 0x64
    /* 2D2B8 8003CAB8 21106202 */  addu       $v0, $s3, $v0
    /* 2D2BC 8003CABC 0C01A2AC */  sw         $v0, 0x10C($a1)
    /* 2D2C0 8003CAC0 100040A4 */  sh         $zero, 0x10($v0)
    /* 2D2C4 8003CAC4 0C01A28C */  lw         $v0, 0x10C($a1)
    /* 2D2C8 8003CAC8 00000000 */  nop
    /* 2D2CC 8003CACC 140048A4 */  sh         $t0, 0x14($v0)
  .L8003CAD0:
    /* 2D2D0 8003CAD0 01000226 */  addiu      $v0, $s0, 0x1
  .L8003CAD4:
    /* 2D2D4 8003CAD4 21804000 */  addu       $s0, $v0, $zero
    /* 2D2D8 8003CAD8 00140200 */  sll        $v0, $v0, 16
    /* 2D2DC 8003CADC 03140200 */  sra        $v0, $v0, 16
    /* 2D2E0 8003CAE0 04004228 */  slti       $v0, $v0, 0x4
    /* 2D2E4 8003CAE4 D0FF4014 */  bnez       $v0, .L8003CA28
    /* 2D2E8 8003CAE8 00141000 */   sll       $v0, $s0, 16
    /* 2D2EC 8003CAEC 01001024 */  addiu      $s0, $zero, 0x1
    /* 2D2F0 8003CAF0 00141000 */  sll        $v0, $s0, 16
  .L8003CAF4:
    /* 2D2F4 8003CAF4 83130200 */  sra        $v0, $v0, 14
    /* 2D2F8 8003CAF8 21106202 */  addu       $v0, $s3, $v0
    /* 2D2FC 8003CAFC 0C01458C */  lw         $a1, 0x10C($v0)
    /* 2D300 8003CB00 40EB000C */  jal        DrawOverlay__16tScreenCarSelectP8tOverlay
    /* 2D304 8003CB04 21206002 */   addu      $a0, $s3, $zero
    /* 2D308 8003CB08 01000226 */  addiu      $v0, $s0, 0x1
    /* 2D30C 8003CB0C 21804000 */  addu       $s0, $v0, $zero
    /* 2D310 8003CB10 00140200 */  sll        $v0, $v0, 16
    /* 2D314 8003CB14 03140200 */  sra        $v0, $v0, 16
    /* 2D318 8003CB18 04004228 */  slti       $v0, $v0, 0x4
    /* 2D31C 8003CB1C F5FF4014 */  bnez       $v0, .L8003CAF4
    /* 2D320 8003CB20 00141000 */   sll       $v0, $s0, 16
    /* 2D324 8003CB24 0200A016 */  bnez       $s5, .L8003CB30
    /* 2D328 8003CB28 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 2D32C 8003CB2C 3000A2A3 */  sb         $v0, 0x30($sp)
  .L8003CB30:
    /* 2D330 8003CB30 6000628E */  lw         $v0, 0x60($s3)
    /* 2D334 8003CB34 3000A527 */  addiu      $a1, $sp, 0x30
    /* 2D338 8003CB38 60004484 */  lh         $a0, 0x60($v0)
    /* 2D33C 8003CB3C 6400428C */  lw         $v0, 0x64($v0)
    /* 2D340 8003CB40 00000000 */  nop
    /* 2D344 8003CB44 09F84000 */  jalr       $v0
    /* 2D348 8003CB48 21206402 */   addu      $a0, $s3, $a0
    /* 2D34C 8003CB4C 0580023C */  lui        $v0, %hi(FEApp)
    /* 2D350 8003CB50 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2D354 8003CB54 0580033C */  lui        $v1, %hi(gCarObj)
    /* 2D358 8003CB58 2C024290 */  lbu        $v0, 0x22C($v0)
    /* 2D35C 8003CB5C 682A6324 */  addiu      $v1, $v1, %lo(gCarObj)
    /* 2D360 8003CB60 80100200 */  sll        $v0, $v0, 2
    /* 2D364 8003CB64 21104300 */  addu       $v0, $v0, $v1
    /* 2D368 8003CB68 0000428C */  lw         $v0, 0x0($v0)
    /* 2D36C 8003CB6C 00000000 */  nop
    /* 2D370 8003CB70 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2D374 8003CB74 00000000 */  nop
    /* 2D378 8003CB78 0A004010 */  beqz       $v0, .L8003CBA4
    /* 2D37C 8003CB7C 21206002 */   addu      $a0, $s3, $zero
    /* 2D380 8003CB80 21280000 */  addu       $a1, $zero, $zero
    /* 2D384 8003CB84 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2D388 8003CB88 2130A000 */   addu      $a2, $a1, $zero
    /* 2D38C 8003CB8C 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2D390 8003CB90 04036426 */   addiu     $a0, $s3, 0x304
    /* 2D394 8003CB94 1480023C */  lui        $v0, %hi(ticks)
    /* 2D398 8003CB98 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2D39C 8003CB9C 00000000 */  nop
    /* 2D3A0 8003CBA0 7C0362AE */  sw         $v0, 0x37C($s3)
  .L8003CBA4:
    /* 2D3A4 8003CBA4 21206002 */  addu       $a0, $s3, $zero
    /* 2D3A8 8003CBA8 2EF1000C */  jal        UpdateBrightness__16tScreenCarSelects
    /* 2D3AC 8003CBAC 21280000 */   addu      $a1, $zero, $zero
    /* 2D3B0 8003CBB0 1C016296 */  lhu        $v0, 0x11C($s3)
    /* 2D3B4 8003CBB4 00000000 */  nop
    /* 2D3B8 8003CBB8 FBFF4224 */  addiu      $v0, $v0, -0x5
    /* 2D3BC 8003CBBC 0200422C */  sltiu      $v0, $v0, 0x2
    /* 2D3C0 8003CBC0 16004014 */  bnez       $v0, .L8003CC1C
    /* 2D3C4 8003CBC4 1480023C */   lui       $v0, %hi(ticks)
    /* 2D3C8 8003CBC8 3000A427 */  addiu      $a0, $sp, 0x30
    /* 2D3CC 8003CBCC 3A010524 */  addiu      $a1, $zero, 0x13A
    /* 2D3D0 8003CBD0 8040073C */  lui        $a3, (0x40800000 >> 16)
    /* 2D3D4 8003CBD4 0580023C */  lui        $v0, %hi(_front_data_org)
    /* 2D3D8 8003CBD8 601240AC */  sw         $zero, %lo(_front_data_org)($v0)
    /* 2D3DC 8003CBDC 9C03628E */  lw         $v0, 0x39C($s3)
    /* 2D3E0 8003CBE0 F0C0033C */  lui        $v1, (0xC0F00000 >> 16)
    /* 2D3E4 8003CBE4 03004224 */  addiu      $v0, $v0, 0x3
    /* 2D3E8 8003CBE8 9C0362AE */  sw         $v0, 0x39C($s3)
    /* 2D3EC 8003CBEC 1000A3AF */  sw         $v1, 0x10($sp)
    /* 2D3F0 8003CBF0 74036392 */  lbu        $v1, 0x374($s3)
    /* 2D3F4 8003CBF4 01000224 */  addiu      $v0, $zero, 0x1
    /* 2D3F8 8003CBF8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2D3FC 8003CBFC 1400A3AF */  sw         $v1, 0x14($sp)
    /* 2D400 8003CC00 9C03628E */  lw         $v0, 0x39C($s3)
    /* 2D404 8003CC04 54000624 */  addiu      $a2, $zero, 0x54
    /* 2D408 8003CC08 2000A0AF */  sw         $zero, 0x20($sp)
    /* 2D40C 8003CC0C 75EA000C */  jal        DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2D410 8003CC10 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 2D414 8003CC14 FCF30008 */  j          .L8003CFF0
    /* 2D418 8003CC18 0580023C */   lui       $v0, %hi(gCarObj)
  .L8003CC1C:
    /* 2D41C 8003CC1C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2D420 8003CC20 9003638E */  lw         $v1, 0x390($s3)
    /* 2D424 8003CC24 2001A0AF */  sw         $zero, 0x120($sp)
    /* 2D428 8003CC28 2401A0AF */  sw         $zero, 0x124($sp)
    /* 2D42C 8003CC2C 2801A0AF */  sw         $zero, 0x128($sp)
    /* 2D430 8003CC30 1801A0AF */  sw         $zero, 0x118($sp)
    /* 2D434 8003CC34 23104300 */  subu       $v0, $v0, $v1
    /* 2D438 8003CC38 00FF4824 */  addiu      $t0, $v0, -0x100
    /* 2D43C 8003CC3C 48000005 */  bltz       $t0, .L8003CD60
    /* 2D440 8003CC40 1C01A0AF */   sw        $zero, 0x11C($sp)
    /* 2D444 8003CC44 F100A483 */  lb         $a0, 0xF1($sp)
    /* 2D448 8003CC48 00000000 */  nop
    /* 2D44C 8003CC4C 44008004 */  bltz       $a0, .L8003CD60
    /* 2D450 8003CC50 CA6B023C */   lui       $v0, (0x6BCA1AF3 >> 16)
    /* 2D454 8003CC54 F31A4234 */  ori        $v0, $v0, (0x6BCA1AF3 & 0xFFFF)
    /* 2D458 8003CC58 432A0800 */  sra        $a1, $t0, 9
    /* 2D45C 8003CC5C 1800A200 */  mult       $a1, $v0
    /* 2D460 8003CC60 C31F0800 */  sra        $v1, $t0, 31
    /* 2D464 8003CC64 0580103C */  lui        $s0, %hi(kRGBVals)
    /* 2D468 8003CC68 C8161026 */  addiu      $s0, $s0, %lo(kRGBVals)
    /* 2D46C 8003CC6C 10500000 */  mfhi       $t2
    /* 2D470 8003CC70 C3100A00 */  sra        $v0, $t2, 3
    /* 2D474 8003CC74 23104300 */  subu       $v0, $v0, $v1
    /* 2D478 8003CC78 80180200 */  sll        $v1, $v0, 2
    /* 2D47C 8003CC7C 21186200 */  addu       $v1, $v1, $v0
    /* 2D480 8003CC80 80180300 */  sll        $v1, $v1, 2
    /* 2D484 8003CC84 23186200 */  subu       $v1, $v1, $v0
    /* 2D488 8003CC88 2318A300 */  subu       $v1, $a1, $v1
    /* 2D48C 8003CC8C E4036324 */  addiu      $v1, $v1, 0x3E4
    /* 2D490 8003CC90 80100400 */  sll        $v0, $a0, 2
    /* 2D494 8003CC94 21104400 */  addu       $v0, $v0, $a0
    /* 2D498 8003CC98 80100200 */  sll        $v0, $v0, 2
    /* 2D49C 8003CC9C 23104400 */  subu       $v0, $v0, $a0
    /* 2D4A0 8003CCA0 21A06200 */  addu       $s4, $v1, $v0
    /* 2D4A4 8003CCA4 00241400 */  sll        $a0, $s4, 16
    /* 2D4A8 8003CCA8 03240400 */  sra        $a0, $a0, 16
    /* 2D4AC 8003CCAC 402A0500 */  sll        $a1, $a1, 9
    /* 2D4B0 8003CCB0 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* 2D4B4 8003CCB4 23880501 */   subu      $s1, $t0, $a1
    /* 2D4B8 8003CCB8 0580043C */  lui        $a0, %hi(textDefinitions)
    /* 2D4BC 8003CCBC B8158424 */  addiu      $a0, $a0, %lo(textDefinitions)
    /* 2D4C0 8003CCC0 40180200 */  sll        $v1, $v0, 1
    /* 2D4C4 8003CCC4 21186200 */  addu       $v1, $v1, $v0
    /* 2D4C8 8003CCC8 40180300 */  sll        $v1, $v1, 1
    /* 2D4CC 8003CCCC 21186400 */  addu       $v1, $v1, $a0
    /* 2D4D0 8003CCD0 04006290 */  lbu        $v0, 0x4($v1)
    /* 2D4D4 8003CCD4 00000000 */  nop
    /* 2D4D8 8003CCD8 80100200 */  sll        $v0, $v0, 2
    /* 2D4DC 8003CCDC 21105000 */  addu       $v0, $v0, $s0
    /* 2D4E0 8003CCE0 0000528C */  lw         $s2, 0x0($v0)
    /* 2D4E4 8003CCE4 8000222E */  sltiu      $v0, $s1, 0x80
    /* 2D4E8 8003CCE8 04004010 */  beqz       $v0, .L8003CCFC
    /* 2D4EC 8003CCEC 21204002 */   addu      $a0, $s2, $zero
    /* 2D4F0 8003CCF0 80000524 */  addiu      $a1, $zero, 0x80
    /* 2D4F4 8003CCF4 44F30008 */  j          .L8003CD10
    /* 2D4F8 8003CCF8 2328B100 */   subu      $a1, $a1, $s1
  .L8003CCFC:
    /* 2D4FC 8003CCFC 00020224 */  addiu      $v0, $zero, 0x200
    /* 2D500 8003CD00 23105100 */  subu       $v0, $v0, $s1
    /* 2D504 8003CD04 8000422C */  sltiu      $v0, $v0, 0x80
    /* 2D508 8003CD08 04004010 */  beqz       $v0, .L8003CD1C
    /* 2D50C 8003CD0C 80FE2526 */   addiu     $a1, $s1, -0x180
  .L8003CD10:
    /* 2D510 8003CD10 222E010C */  jal        CalcFadeVal__Fii
    /* 2D514 8003CD14 00000000 */   nop
    /* 2D518 8003CD18 21904000 */  addu       $s2, $v0, $zero
  .L8003CD1C:
    /* 2D51C 8003CD1C 94E4020C */  jal        TextSys_Word__Fi
    /* 2D520 8003CD20 21208002 */   addu      $a0, $s4, $zero
    /* 2D524 8003CD24 21208002 */  addu       $a0, $s4, $zero
    /* 2D528 8003CD28 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2D52C 8003CD2C 21804000 */   addu      $s0, $v0, $zero
    /* 2D530 8003CD30 21208002 */  addu       $a0, $s4, $zero
    /* 2D534 8003CD34 008C0200 */  sll        $s1, $v0, 16
    /* 2D538 8003CD38 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2D53C 8003CD3C 038C1100 */   sra       $s1, $s1, 16
    /* 2D540 8003CD40 21200002 */  addu       $a0, $s0, $zero
    /* 2D544 8003CD44 21282002 */  addu       $a1, $s1, $zero
    /* 2D548 8003CD48 00140200 */  sll        $v0, $v0, 16
    /* 2D54C 8003CD4C 03340200 */  sra        $a2, $v0, 16
    /* 2D550 8003CD50 21384002 */  addu       $a3, $s2, $zero
    /* 2D554 8003CD54 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2D558 8003CD58 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 2D55C 8003CD5C 1400A0AF */   sw        $zero, 0x14($sp)
  .L8003CD60:
    /* 2D560 8003CD60 5500023C */  lui        $v0, (0x551E00 >> 16)
    /* 2D564 8003CD64 001E4234 */  ori        $v0, $v0, (0x551E00 & 0xFFFF)
    /* 2D568 8003CD68 0401A2AF */  sw         $v0, 0x104($sp)
    /* 2D56C 8003CD6C 2800628E */  lw         $v0, 0x28($s3)
    /* 2D570 8003CD70 00000000 */  nop
    /* 2D574 8003CD74 1401A2AF */  sw         $v0, 0x114($sp)
    /* 2D578 8003CD78 9003638E */  lw         $v1, 0x390($s3)
    /* 2D57C 8003CD7C 00000000 */  nop
    /* 2D580 8003CD80 0101622C */  sltiu      $v0, $v1, 0x101
    /* 2D584 8003CD84 07004014 */  bnez       $v0, .L8003CDA4
    /* 2D588 8003CD88 80000824 */   addiu     $t0, $zero, 0x80
    /* 2D58C 8003CD8C 8101622C */  sltiu      $v0, $v1, 0x181
    /* 2D590 8003CD90 03004014 */  bnez       $v0, .L8003CDA0
    /* 2D594 8003CD94 80010224 */   addiu     $v0, $zero, 0x180
    /* 2D598 8003CD98 69F30008 */  j          .L8003CDA4
    /* 2D59C 8003CD9C 21400000 */   addu      $t0, $zero, $zero
  .L8003CDA0:
    /* 2D5A0 8003CDA0 23404300 */  subu       $t0, $v0, $v1
  .L8003CDA4:
    /* 2D5A4 8003CDA4 0A000424 */  addiu      $a0, $zero, 0xA
    /* 2D5A8 8003CDA8 00020524 */  addiu      $a1, $zero, 0x200
    /* 2D5AC 8003CDAC 21300000 */  addu       $a2, $zero, $zero
    /* 2D5B0 8003CDB0 2138C000 */  addu       $a3, $a2, $zero
    /* 2D5B4 8003CDB4 0001A227 */  addiu      $v0, $sp, 0x100
    /* 2D5B8 8003CDB8 1000A8AF */  sw         $t0, 0x10($sp)
    /* 2D5BC 8003CDBC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2D5C0 8003CDC0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2D5C4 8003CDC4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 2D5C8 8003CDC8 1480023C */  lui        $v0, %hi(ticks)
    /* 2D5CC 8003CDCC ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 2D5D0 8003CDD0 8C03628E */  lw         $v0, 0x38C($s3)
    /* 2D5D4 8003CDD4 00000000 */  nop
    /* 2D5D8 8003CDD8 23406200 */  subu       $t0, $v1, $v0
  .L8003CDDC:
    /* 2D5DC 8003CDDC 59020229 */  slti       $v0, $t0, 0x259
    /* 2D5E0 8003CDE0 0D004014 */  bnez       $v0, .L8003CE18
    /* 2D5E4 8003CDE4 0580033C */   lui       $v1, %hi(D_80052C18)
    /* 2D5E8 8003CDE8 8C03628E */  lw         $v0, 0x38C($s3)
    /* 2D5EC 8003CDEC 9803638E */  lw         $v1, 0x398($s3)
    /* 2D5F0 8003CDF0 58024224 */  addiu      $v0, $v0, 0x258
    /* 2D5F4 8003CDF4 8C0362AE */  sw         $v0, 0x38C($s3)
    /* 2D5F8 8003CDF8 01006224 */  addiu      $v0, $v1, 0x1
    /* 2D5FC 8003CDFC 980362AE */  sw         $v0, 0x398($s3)
    /* 2D600 8003CE00 07004228 */  slti       $v0, $v0, 0x7
    /* 2D604 8003CE04 F5FF4014 */  bnez       $v0, .L8003CDDC
    /* 2D608 8003CE08 A8FD0825 */   addiu     $t0, $t0, -0x258
    /* 2D60C 8003CE0C FCFF6224 */  addiu      $v0, $v1, -0x4
    /* 2D610 8003CE10 77F30008 */  j          .L8003CDDC
    /* 2D614 8003CE14 980362AE */   sw        $v0, 0x398($s3)
  .L8003CE18:
    /* 2D618 8003CE18 98036596 */  lhu        $a1, 0x398($s3)
    /* 2D61C 8003CE1C 182C6424 */  addiu      $a0, $v1, %lo(D_80052C18)
    /* 2D620 8003CE20 00140500 */  sll        $v0, $a1, 16
    /* 2D624 8003CE24 03140200 */  sra        $v0, $v0, 16
    /* 2D628 8003CE28 07004228 */  slti       $v0, $v0, 0x7
    /* 2D62C 8003CE2C 04004014 */  bnez       $v0, .L8003CE40
    /* 2D630 8003CE30 182C60AC */   sw        $zero, %lo(D_80052C18)($v1)
    /* 2D634 8003CE34 FBFFA524 */  addiu      $a1, $a1, -0x5
    /* 2D638 8003CE38 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* 2D63C 8003CE3C 182C62AC */  sw         $v0, %lo(D_80052C18)($v1)
  .L8003CE40:
    /* 2D640 8003CE40 0100A224 */  addiu      $v0, $a1, 0x1
    /* 2D644 8003CE44 21304000 */  addu       $a2, $v0, $zero
    /* 2D648 8003CE48 00140200 */  sll        $v0, $v0, 16
    /* 2D64C 8003CE4C 03140200 */  sra        $v0, $v0, 16
    /* 2D650 8003CE50 182C638C */  lw         $v1, %lo(D_80052C18)($v1)
    /* 2D654 8003CE54 07004228 */  slti       $v0, $v0, 0x7
    /* 2D658 8003CE58 05004014 */  bnez       $v0, .L8003CE70
    /* 2D65C 8003CE5C 040083AC */   sw        $v1, 0x4($a0)
    /* 2D660 8003CE60 FCFFA624 */  addiu      $a2, $a1, -0x4
    /* 2D664 8003CE64 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* 2D668 8003CE68 21106200 */  addu       $v0, $v1, $v0
    /* 2D66C 8003CE6C 040082AC */  sw         $v0, 0x4($a0)
  .L8003CE70:
    /* 2D670 8003CE70 0100C224 */  addiu      $v0, $a2, 0x1
    /* 2D674 8003CE74 21384000 */  addu       $a3, $v0, $zero
    /* 2D678 8003CE78 00140200 */  sll        $v0, $v0, 16
    /* 2D67C 8003CE7C 03140200 */  sra        $v0, $v0, 16
    /* 2D680 8003CE80 0400838C */  lw         $v1, 0x4($a0)
    /* 2D684 8003CE84 07004228 */  slti       $v0, $v0, 0x7
    /* 2D688 8003CE88 05004014 */  bnez       $v0, .L8003CEA0
    /* 2D68C 8003CE8C 080083AC */   sw        $v1, 0x8($a0)
    /* 2D690 8003CE90 FCFFC724 */  addiu      $a3, $a2, -0x4
    /* 2D694 8003CE94 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* 2D698 8003CE98 21106200 */  addu       $v0, $v1, $v0
    /* 2D69C 8003CE9C 080082AC */  sw         $v0, 0x8($a0)
  .L8003CEA0:
    /* 2D6A0 8003CEA0 0100E224 */  addiu      $v0, $a3, 0x1
    /* 2D6A4 8003CEA4 21484000 */  addu       $t1, $v0, $zero
    /* 2D6A8 8003CEA8 00140200 */  sll        $v0, $v0, 16
    /* 2D6AC 8003CEAC 03140200 */  sra        $v0, $v0, 16
    /* 2D6B0 8003CEB0 0800838C */  lw         $v1, 0x8($a0)
    /* 2D6B4 8003CEB4 07004228 */  slti       $v0, $v0, 0x7
    /* 2D6B8 8003CEB8 05004014 */  bnez       $v0, .L8003CED0
    /* 2D6BC 8003CEBC 0C0083AC */   sw        $v1, 0xC($a0)
    /* 2D6C0 8003CEC0 FCFFE924 */  addiu      $t1, $a3, -0x4
    /* 2D6C4 8003CEC4 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* 2D6C8 8003CEC8 21106200 */  addu       $v0, $v1, $v0
    /* 2D6CC 8003CECC 0C0082AC */  sw         $v0, 0xC($a0)
  .L8003CED0:
    /* 2D6D0 8003CED0 21206002 */  addu       $a0, $s3, $zero
    /* 2D6D4 8003CED4 002C0500 */  sll        $a1, $a1, 16
    /* 2D6D8 8003CED8 032C0500 */  sra        $a1, $a1, 16
    /* 2D6DC 8003CEDC 00340600 */  sll        $a2, $a2, 16
    /* 2D6E0 8003CEE0 03340600 */  sra        $a2, $a2, 16
    /* 2D6E4 8003CEE4 003C0700 */  sll        $a3, $a3, 16
    /* 2D6E8 8003CEE8 033C0700 */  sra        $a3, $a3, 16
    /* 2D6EC 8003CEEC 00140900 */  sll        $v0, $t1, 16
    /* 2D6F0 8003CEF0 03140200 */  sra        $v0, $v0, 16
    /* 2D6F4 8003CEF4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2D6F8 8003CEF8 1801A227 */  addiu      $v0, $sp, 0x118
    /* 2D6FC 8003CEFC 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2D700 8003CF00 1C01A227 */  addiu      $v0, $sp, 0x11C
    /* 2D704 8003CF04 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 2D708 8003CF08 2001A227 */  addiu      $v0, $sp, 0x120
    /* 2D70C 8003CF0C 2000A2AF */  sw         $v0, 0x20($sp)
    /* 2D710 8003CF10 2401A227 */  addiu      $v0, $sp, 0x124
    /* 2D714 8003CF14 2400A2AF */  sw         $v0, 0x24($sp)
    /* 2D718 8003CF18 2801A227 */  addiu      $v0, $sp, 0x128
    /* 2D71C 8003CF1C 1400A8AF */  sw         $t0, 0x14($sp)
    /* 2D720 8003CF20 08EE000C */  jal        CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
    /* 2D724 8003CF24 2800A2AF */   sw        $v0, 0x28($sp)
    /* 2D728 8003CF28 0580023C */  lui        $v0, %hi(_front_data_org)
    /* 2D72C 8003CF2C 1801A48F */  lw         $a0, 0x118($sp)
    /* 2D730 8003CF30 01001224 */  addiu      $s2, $zero, 0x1
    /* 2D734 8003CF34 89D8030C */  jal        __floatsisf
    /* 2D738 8003CF38 601252AC */   sw        $s2, %lo(_front_data_org)($v0)
    /* 2D73C 8003CF3C 8037103C */  lui        $s0, (0x37800000 >> 16)
    /* 2D740 8003CF40 21204000 */  addu       $a0, $v0, $zero
    /* 2D744 8003CF44 2CCD030C */  jal        __mulsf3
    /* 2D748 8003CF48 21280002 */   addu      $a1, $s0, $zero
    /* 2D74C 8003CF4C 1C01A48F */  lw         $a0, 0x11C($sp)
    /* 2D750 8003CF50 89D8030C */  jal        __floatsisf
    /* 2D754 8003CF54 21884000 */   addu      $s1, $v0, $zero
    /* 2D758 8003CF58 21204000 */  addu       $a0, $v0, $zero
    /* 2D75C 8003CF5C 2CCD030C */  jal        __mulsf3
    /* 2D760 8003CF60 21280002 */   addu      $a1, $s0, $zero
    /* 2D764 8003CF64 2001A587 */  lh         $a1, 0x120($sp)
    /* 2D768 8003CF68 2401A687 */  lh         $a2, 0x124($sp)
    /* 2D76C 8003CF6C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2D770 8003CF70 74036292 */  lbu        $v0, 0x374($s3)
    /* 2D774 8003CF74 3000A427 */  addiu      $a0, $sp, 0x30
    /* 2D778 8003CF78 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2D77C 8003CF7C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2D780 8003CF80 2801A28F */  lw         $v0, 0x128($sp)
    /* 2D784 8003CF84 21382002 */  addu       $a3, $s1, $zero
    /* 2D788 8003CF88 2000A0AF */  sw         $zero, 0x20($sp)
    /* 2D78C 8003CF8C 75EA000C */  jal        DrawCar__FR8tCarInfossffcbUl7tPlayer
    /* 2D790 8003CF90 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 2D794 8003CF94 1600A012 */  beqz       $s5, .L8003CFF0
    /* 2D798 8003CF98 0580023C */   lui       $v0, %hi(gCarObj)
    /* 2D79C 8003CF9C 88A0030C */  jal        gettick
    /* 2D7A0 8003CFA0 00000000 */   nop
    /* 2D7A4 8003CFA4 9003638E */  lw         $v1, 0x390($s3)
    /* 2D7A8 8003CFA8 00000000 */  nop
    /* 2D7AC 8003CFAC 23104300 */  subu       $v0, $v0, $v1
    /* 2D7B0 8003CFB0 8102422C */  sltiu      $v0, $v0, 0x281
    /* 2D7B4 8003CFB4 0E004014 */  bnez       $v0, .L8003CFF0
    /* 2D7B8 8003CFB8 0580023C */   lui       $v0, %hi(gCarObj)
    /* 2D7BC 8003CFBC 9403628E */  lw         $v0, 0x394($s3)
    /* 2D7C0 8003CFC0 00000000 */  nop
    /* 2D7C4 8003CFC4 0A004014 */  bnez       $v0, .L8003CFF0
    /* 2D7C8 8003CFC8 0580023C */   lui       $v0, %hi(gCarObj)
    /* 2D7CC 8003CFCC F100A283 */  lb         $v0, 0xF1($sp)
    /* 2D7D0 8003CFD0 00000000 */  nop
    /* 2D7D4 8003CFD4 06004004 */  bltz       $v0, .L8003CFF0
    /* 2D7D8 8003CFD8 0580023C */   lui       $v0, %hi(gCarObj)
    /* 2D7DC 8003CFDC 940372AE */  sw         $s2, 0x394($s3)
    /* 2D7E0 8003CFE0 F100A583 */  lb         $a1, 0xF1($sp)
    /* 2D7E4 8003CFE4 2E57000C */  jal        FeAudio_AsyncPlaySpeech__Fii
    /* 2D7E8 8003CFE8 21200000 */   addu      $a0, $zero, $zero
    /* 2D7EC 8003CFEC 0580023C */  lui        $v0, %hi(gCarObj)
  .L8003CFF0:
    /* 2D7F0 8003CFF0 682A428C */  lw         $v0, %lo(gCarObj)($v0)
    /* 2D7F4 8003CFF4 00000000 */  nop
    /* 2D7F8 8003CFF8 D808428C */  lw         $v0, 0x8D8($v0)
    /* 2D7FC 8003CFFC 00000000 */  nop
    /* 2D800 8003D000 19004014 */  bnez       $v0, .L8003D068
    /* 2D804 8003D004 00000000 */   nop
    /* 2D808 8003D008 74036386 */  lh         $v1, 0x374($s3)
    /* 2D80C 8003D00C 78036286 */  lh         $v0, 0x378($s3)
    /* 2D810 8003D010 00000000 */  nop
    /* 2D814 8003D014 14006214 */  bne        $v1, $v0, .L8003D068
    /* 2D818 8003D018 00000000 */   nop
    /* 2D81C 8003D01C 12006014 */  bnez       $v1, .L8003D068
    /* 2D820 8003D020 1480023C */   lui       $v0, %hi(ticks)
    /* 2D824 8003D024 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2D828 8003D028 7C03638E */  lw         $v1, 0x37C($s3)
    /* 2D82C 8003D02C 00000000 */  nop
    /* 2D830 8003D030 23104300 */  subu       $v0, $v0, $v1
    /* 2D834 8003D034 81004228 */  slti       $v0, $v0, 0x81
    /* 2D838 8003D038 0B004014 */  bnez       $v0, .L8003D068
    /* 2D83C 8003D03C 00000000 */   nop
    /* 2D840 8003D040 3700A293 */  lbu        $v0, 0x37($sp)
    /* 2D844 8003D044 00000000 */  nop
    /* 2D848 8003D048 02004010 */  beqz       $v0, .L8003D054
    /* 2D84C 8003D04C 20000524 */   addiu     $a1, $zero, 0x20
    /* 2D850 8003D050 80000524 */  addiu      $a1, $zero, 0x80
  .L8003D054:
    /* 2D854 8003D054 21206002 */  addu       $a0, $s3, $zero
    /* 2D858 8003D058 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2D85C 8003D05C 21300000 */   addu      $a2, $zero, $zero
    /* 2D860 8003D060 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2D864 8003D064 04036426 */   addiu     $a0, $s3, 0x304
  .L8003D068:
    /* 2D868 8003D068 4801BF8F */  lw         $ra, 0x148($sp)
    /* 2D86C 8003D06C 4401B58F */  lw         $s5, 0x144($sp)
    /* 2D870 8003D070 4001B48F */  lw         $s4, 0x140($sp)
    /* 2D874 8003D074 3C01B38F */  lw         $s3, 0x13C($sp)
    /* 2D878 8003D078 3801B28F */  lw         $s2, 0x138($sp)
    /* 2D87C 8003D07C 3401B18F */  lw         $s1, 0x134($sp)
    /* 2D880 8003D080 3001B08F */  lw         $s0, 0x130($sp)
    /* 2D884 8003D084 0800E003 */  jr         $ra
    /* 2D888 8003D088 5001BD27 */   addiu     $sp, $sp, 0x150
endlabel DrawForeground__16tScreenCarSelect
