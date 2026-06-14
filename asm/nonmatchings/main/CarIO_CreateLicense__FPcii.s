.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_CreateLicense__FPcii, 0x394

glabel CarIO_CreateLicense__FPcii
    /* ACA5C 800BC25C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* ACA60 800BC260 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* ACA64 800BC264 21B88000 */  addu       $s7, $a0, $zero
    /* ACA68 800BC268 3800B6AF */  sw         $s6, 0x38($sp)
    /* ACA6C 800BC26C 21B0C000 */  addu       $s6, $a2, $zero
    /* ACA70 800BC270 1600A528 */  slti       $a1, $a1, 0x16
    /* ACA74 800BC274 4000BFAF */  sw         $ra, 0x40($sp)
    /* ACA78 800BC278 3400B5AF */  sw         $s5, 0x34($sp)
    /* ACA7C 800BC27C 3000B4AF */  sw         $s4, 0x30($sp)
    /* ACA80 800BC280 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* ACA84 800BC284 2800B2AF */  sw         $s2, 0x28($sp)
    /* ACA88 800BC288 2400B1AF */  sw         $s1, 0x24($sp)
    /* ACA8C 800BC28C 0B00A014 */  bnez       $a1, .L800BC2BC
    /* ACA90 800BC290 2000B0AF */   sw        $s0, 0x20($sp)
    /* ACA94 800BC294 80101600 */  sll        $v0, $s6, 2
    /* ACA98 800BC298 1480033C */  lui        $v1, %hi(CarIO_Plate2)
    /* ACA9C 800BC29C 50D76324 */  addiu      $v1, $v1, %lo(CarIO_Plate2)
    /* ACAA0 800BC2A0 21184300 */  addu       $v1, $v0, $v1
    /* ACAA4 800BC2A4 000060AC */  sw         $zero, 0x0($v1)
    /* ACAA8 800BC2A8 1480033C */  lui        $v1, %hi(CarIO_Plate1)
    /* ACAAC 800BC2AC 48D76324 */  addiu      $v1, $v1, %lo(CarIO_Plate1)
    /* ACAB0 800BC2B0 21104300 */  addu       $v0, $v0, $v1
    /* ACAB4 800BC2B4 71F10208 */  j          .L800BC5C4
    /* ACAB8 800BC2B8 000040AC */   sw        $zero, 0x0($v0)
  .L800BC2BC:
    /* ACABC 800BC2BC 1480043C */  lui        $a0, %hi(D_8013D720)
    /* ACAC0 800BC2C0 20D78424 */  addiu      $a0, $a0, %lo(D_8013D720)
    /* ACAC4 800BC2C4 48010524 */  addiu      $a1, $zero, 0x148
    /* ACAC8 800BC2C8 CF94030C */  jal        reservememadr
    /* ACACC 800BC2CC 21300000 */   addu      $a2, $zero, $zero
    /* ACAD0 800BC2D0 1480043C */  lui        $a0, %hi(D_8013D728)
    /* ACAD4 800BC2D4 28D78424 */  addiu      $a0, $a0, %lo(D_8013D728)
    /* ACAD8 800BC2D8 48010524 */  addiu      $a1, $zero, 0x148
    /* ACADC 800BC2DC 21300000 */  addu       $a2, $zero, $zero
    /* ACAE0 800BC2E0 80881600 */  sll        $s1, $s6, 2
    /* ACAE4 800BC2E4 1480103C */  lui        $s0, %hi(CarIO_Plate1)
    /* ACAE8 800BC2E8 48D71026 */  addiu      $s0, $s0, %lo(CarIO_Plate1)
    /* ACAEC 800BC2EC 21803002 */  addu       $s0, $s1, $s0
    /* ACAF0 800BC2F0 CF94030C */  jal        reservememadr
    /* ACAF4 800BC2F4 000002AE */   sw        $v0, 0x0($s0)
    /* ACAF8 800BC2F8 0580043C */  lui        $a0, %hi(D_80056778)
    /* ACAFC 800BC2FC 78678424 */  addiu      $a0, $a0, %lo(D_80056778)
    /* ACB00 800BC300 10020524 */  addiu      $a1, $zero, 0x210
    /* ACB04 800BC304 10000624 */  addiu      $a2, $zero, 0x10
    /* ACB08 800BC308 1480033C */  lui        $v1, %hi(CarIO_Plate2)
    /* ACB0C 800BC30C 50D76324 */  addiu      $v1, $v1, %lo(CarIO_Plate2)
    /* ACB10 800BC310 21882302 */  addu       $s1, $s1, $v1
    /* ACB14 800BC314 21900000 */  addu       $s2, $zero, $zero
    /* ACB18 800BC318 000022AE */  sw         $v0, 0x0($s1)
    /* ACB1C 800BC31C 0000038E */  lw         $v1, 0x0($s0)
    /* ACB20 800BC320 18015524 */  addiu      $s5, $v0, 0x118
    /* ACB24 800BC324 CF94030C */  jal        reservememadr
    /* ACB28 800BC328 18017424 */   addiu     $s4, $v1, 0x118
    /* ACB2C 800BC32C 1480053C */  lui        $a1, %hi(D_8013D730)
    /* ACB30 800BC330 30D7A524 */  addiu      $a1, $a1, %lo(D_8013D730)
    /* ACB34 800BC334 1480043C */  lui        $a0, %hi(R3DCar_LicenseShapeFile)
    /* ACB38 800BC338 B4D3848C */  lw         $a0, %lo(R3DCar_LicenseShapeFile)($a0)
    /* ACB3C 800BC33C 5CAC030C */  jal        locateshapez
    /* ACB40 800BC340 21984000 */   addu      $s3, $v0, $zero
    /* ACB44 800BC344 21384000 */  addu       $a3, $v0, $zero
    /* ACB48 800BC348 0000E28C */  lw         $v0, 0x0($a3)
    /* ACB4C 800BC34C 2130E000 */  addu       $a2, $a3, $zero
    /* ACB50 800BC350 03120200 */  sra        $v0, $v0, 8
    /* ACB54 800BC354 2140E200 */  addu       $t0, $a3, $v0
  .L800BC358:
    /* ACB58 800BC358 0000C58C */  lw         $a1, 0x0($a2)
    /* ACB5C 800BC35C 0400C624 */  addiu      $a2, $a2, 0x4
    /* ACB60 800BC360 80181200 */  sll        $v1, $s2, 2
    /* ACB64 800BC364 01005226 */  addiu      $s2, $s2, 0x1
    /* ACB68 800BC368 0000228E */  lw         $v0, 0x0($s1)
    /* ACB6C 800BC36C 0000048E */  lw         $a0, 0x0($s0)
    /* ACB70 800BC370 21106200 */  addu       $v0, $v1, $v0
    /* ACB74 800BC374 21186400 */  addu       $v1, $v1, $a0
    /* ACB78 800BC378 000045AC */  sw         $a1, 0x0($v0)
    /* ACB7C 800BC37C 0400422A */  slti       $v0, $s2, 0x4
    /* ACB80 800BC380 F5FF4014 */  bnez       $v0, .L800BC358
    /* ACB84 800BC384 000065AC */   sw        $a1, 0x0($v1)
    /* ACB88 800BC388 21900000 */  addu       $s2, $zero, $zero
    /* ACB8C 800BC38C 21188002 */  addu       $v1, $s4, $zero
    /* ACB90 800BC390 2128A002 */  addu       $a1, $s5, $zero
    /* ACB94 800BC394 21200001 */  addu       $a0, $t0, $zero
  .L800BC398:
    /* ACB98 800BC398 0000828C */  lw         $v0, 0x0($a0)
    /* ACB9C 800BC39C 04008424 */  addiu      $a0, $a0, 0x4
    /* ACBA0 800BC3A0 01005226 */  addiu      $s2, $s2, 0x1
    /* ACBA4 800BC3A4 0000A2AC */  sw         $v0, 0x0($a1)
    /* ACBA8 800BC3A8 000062AC */  sw         $v0, 0x0($v1)
    /* ACBAC 800BC3AC 04006324 */  addiu      $v1, $v1, 0x4
    /* ACBB0 800BC3B0 0C00422A */  slti       $v0, $s2, 0xC
    /* ACBB4 800BC3B4 F8FF4014 */  bnez       $v0, .L800BC398
    /* ACBB8 800BC3B8 0400A524 */   addiu     $a1, $a1, 0x4
    /* ACBBC 800BC3BC 01000C3C */  lui        $t4, (0x11800 >> 16)
    /* ACBC0 800BC3C0 00188C35 */  ori        $t4, $t4, (0x11800 & 0xFFFF)
    /* ACBC4 800BC3C4 1000E424 */  addiu      $a0, $a3, 0x10
    /* ACBC8 800BC3C8 21286002 */  addu       $a1, $s3, $zero
    /* ACBCC 800BC3CC 30000624 */  addiu      $a2, $zero, 0x30
    /* ACBD0 800BC3D0 80401600 */  sll        $t0, $s6, 2
    /* ACBD4 800BC3D4 1480093C */  lui        $t1, %hi(CarIO_Plate2)
    /* ACBD8 800BC3D8 50D72925 */  addiu      $t1, $t1, %lo(CarIO_Plate2)
    /* ACBDC 800BC3DC 21480901 */  addu       $t1, $t0, $t1
    /* ACBE0 800BC3E0 16000724 */  addiu      $a3, $zero, 0x16
    /* ACBE4 800BC3E4 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* ACBE8 800BC3E8 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* ACBEC 800BC3EC 00002B8D */  lw         $t3, 0x0($t1)
    /* ACBF0 800BC3F0 21400201 */  addu       $t0, $t0, $v0
    /* ACBF4 800BC3F4 00006391 */  lbu        $v1, 0x0($t3)
    /* ACBF8 800BC3F8 00000A8D */  lw         $t2, 0x0($t0)
    /* ACBFC 800BC3FC 25186C00 */  or         $v1, $v1, $t4
    /* ACC00 800BC400 000063AD */  sw         $v1, 0x0($t3)
    /* ACC04 800BC404 00004291 */  lbu        $v0, 0x0($t2)
    /* ACC08 800BC408 21900000 */  addu       $s2, $zero, $zero
    /* ACC0C 800BC40C 25104C00 */  or         $v0, $v0, $t4
    /* ACC10 800BC410 000042AD */  sw         $v0, 0x0($t2)
    /* ACC14 800BC414 0000088D */  lw         $t0, 0x0($t0)
    /* ACC18 800BC418 0000238D */  lw         $v1, 0x0($t1)
    /* ACC1C 800BC41C 18000224 */  addiu      $v0, $zero, 0x18
    /* ACC20 800BC420 040062A4 */  sh         $v0, 0x4($v1)
    /* ACC24 800BC424 040002A5 */  sh         $v0, 0x4($t0)
    /* ACC28 800BC428 1000A0AF */  sw         $zero, 0x10($sp)
    /* ACC2C 800BC42C FCEF020C */  jal        CarIO_CopyFromShape__FPsT0iiii
    /* ACC30 800BC430 1400A0AF */   sw        $zero, 0x14($sp)
    /* ACC34 800BC434 DDA7030C */  jal        strlen
    /* ACC38 800BC438 2120E002 */   addu      $a0, $s7, $zero
    /* ACC3C 800BC43C 21884000 */  addu       $s1, $v0, $zero
    /* ACC40 800BC440 40101100 */  sll        $v0, $s1, 1
    /* ACC44 800BC444 21105100 */  addu       $v0, $v0, $s1
    /* ACC48 800BC448 18000324 */  addiu      $v1, $zero, 0x18
    /* ACC4C 800BC44C 23806200 */  subu       $s0, $v1, $v0
    /* ACC50 800BC450 0580023C */  lui        $v0, %hi(jtbl_80056788)
    /* ACC54 800BC454 88675424 */  addiu      $s4, $v0, %lo(jtbl_80056788)
  .L800BC458:
    /* ACC58 800BC458 2A105102 */  slt        $v0, $s2, $s1
    /* ACC5C 800BC45C 2E004010 */  beqz       $v0, .L800BC518
    /* ACC60 800BC460 2110F202 */   addu      $v0, $s7, $s2
    /* ACC64 800BC464 00004390 */  lbu        $v1, 0x0($v0)
    /* ACC68 800BC468 20000224 */  addiu      $v0, $zero, 0x20
    /* ACC6C 800BC46C FF006430 */  andi       $a0, $v1, 0xFF
    /* ACC70 800BC470 26008210 */  beq        $a0, $v0, .L800BC50C
    /* ACC74 800BC474 40FF8424 */   addiu     $a0, $a0, -0xC0
    /* ACC78 800BC478 1D00822C */  sltiu      $v0, $a0, 0x1D
    /* ACC7C 800BC47C 11004010 */  beqz       $v0, .L800BC4C4
    /* ACC80 800BC480 80100400 */   sll       $v0, $a0, 2
    /* ACC84 800BC484 21105400 */  addu       $v0, $v0, $s4
    /* ACC88 800BC488 0000428C */  lw         $v0, 0x0($v0)
    /* ACC8C 800BC48C 00000000 */  nop
    /* ACC90 800BC490 08004000 */  jr         $v0
    /* ACC94 800BC494 00000000 */   nop
  jlabel .L800BC498
    /* ACC98 800BC498 31F10208 */  j          .L800BC4C4
    /* ACC9C 800BC49C 6E000324 */   addiu     $v1, $zero, 0x6E
  jlabel .L800BC4A0
    /* ACCA0 800BC4A0 31F10208 */  j          .L800BC4C4
    /* ACCA4 800BC4A4 61000324 */   addiu     $v1, $zero, 0x61
  jlabel .L800BC4A8
    /* ACCA8 800BC4A8 31F10208 */  j          .L800BC4C4
    /* ACCAC 800BC4AC 65000324 */   addiu     $v1, $zero, 0x65
  jlabel .L800BC4B0
    /* ACCB0 800BC4B0 31F10208 */  j          .L800BC4C4
    /* ACCB4 800BC4B4 69000324 */   addiu     $v1, $zero, 0x69
  jlabel .L800BC4B8
    /* ACCB8 800BC4B8 31F10208 */  j          .L800BC4C4
    /* ACCBC 800BC4BC 6F000324 */   addiu     $v1, $zero, 0x6F
  jlabel .L800BC4C0
    /* ACCC0 800BC4C0 75000324 */  addiu      $v1, $zero, 0x75
  jlabel .L800BC4C4
    /* ACCC4 800BC4C4 1800A427 */  addiu      $a0, $sp, 0x18
    /* ACCC8 800BC4C8 1480053C */  lui        $a1, %hi(D_8013D738)
    /* ACCCC 800BC4CC 38D7A524 */  addiu      $a1, $a1, %lo(D_8013D738)
    /* ACCD0 800BC4D0 1800A3A3 */  sb         $v1, 0x18($sp)
    /* ACCD4 800BC4D4 3A9E030C */  jal        strcat
    /* ACCD8 800BC4D8 1900A0A3 */   sb        $zero, 0x19($sp)
    /* ACCDC 800BC4DC 1480043C */  lui        $a0, %hi(R3DCar_LicenseShapeFile)
    /* ACCE0 800BC4E0 B4D3848C */  lw         $a0, %lo(R3DCar_LicenseShapeFile)($a0)
    /* ACCE4 800BC4E4 5CAC030C */  jal        locateshapez
    /* ACCE8 800BC4E8 1800A527 */   addiu     $a1, $sp, 0x18
    /* ACCEC 800BC4EC 10004424 */  addiu      $a0, $v0, 0x10
    /* ACCF0 800BC4F0 21286002 */  addu       $a1, $s3, $zero
    /* ACCF4 800BC4F4 07000624 */  addiu      $a2, $zero, 0x7
    /* ACCF8 800BC4F8 0C000724 */  addiu      $a3, $zero, 0xC
    /* ACCFC 800BC4FC 05000224 */  addiu      $v0, $zero, 0x5
    /* ACD00 800BC500 1000B0AF */  sw         $s0, 0x10($sp)
    /* ACD04 800BC504 FCEF020C */  jal        CarIO_CopyFromShape__FPsT0iiii
    /* ACD08 800BC508 1400A2AF */   sw        $v0, 0x14($sp)
  .L800BC50C:
    /* ACD0C 800BC50C 06001026 */  addiu      $s0, $s0, 0x6
    /* ACD10 800BC510 16F10208 */  j          .L800BC458
    /* ACD14 800BC514 01005226 */   addiu     $s2, $s2, 0x1
  .L800BC518:
    /* ACD18 800BC518 1480023C */  lui        $v0, %hi(R3DCar_InMenu)
    /* ACD1C 800BC51C 24D3428C */  lw         $v0, %lo(R3DCar_InMenu)($v0)
    /* ACD20 800BC520 00000000 */  nop
    /* ACD24 800BC524 15004014 */  bnez       $v0, .L800BC57C
    /* ACD28 800BC528 21206002 */   addu      $a0, $s3, $zero
    /* ACD2C 800BC52C 1180023C */  lui        $v0, %hi(D_80113218)
    /* ACD30 800BC530 1832428C */  lw         $v0, %lo(D_80113218)($v0)
    /* ACD34 800BC534 00000000 */  nop
    /* ACD38 800BC538 10004010 */  beqz       $v0, .L800BC57C
    /* ACD3C 800BC53C 80801600 */   sll       $s0, $s6, 2
    /* ACD40 800BC540 0C006426 */  addiu      $a0, $s3, 0xC
    /* ACD44 800BC544 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* ACD48 800BC548 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* ACD4C 800BC54C 21100202 */  addu       $v0, $s0, $v0
    /* ACD50 800BC550 0000458C */  lw         $a1, 0x0($v0)
    /* ACD54 800BC554 01000624 */  addiu      $a2, $zero, 0x1
    /* ACD58 800BC558 6DF0020C */  jal        CarIO_CopyToShape__FPsT0i
    /* ACD5C 800BC55C 1000A524 */   addiu     $a1, $a1, 0x10
    /* ACD60 800BC560 21206002 */  addu       $a0, $s3, $zero
    /* ACD64 800BC564 1480023C */  lui        $v0, %hi(CarIO_Plate2)
    /* ACD68 800BC568 50D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate2)
    /* ACD6C 800BC56C 21800202 */  addu       $s0, $s0, $v0
    /* ACD70 800BC570 0000058E */  lw         $a1, 0x0($s0)
    /* ACD74 800BC574 6DF10208 */  j          .L800BC5B4
    /* ACD78 800BC578 01000624 */   addiu     $a2, $zero, 0x1
  .L800BC57C:
    /* ACD7C 800BC57C 80801600 */  sll        $s0, $s6, 2
    /* ACD80 800BC580 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* ACD84 800BC584 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* ACD88 800BC588 21100202 */  addu       $v0, $s0, $v0
    /* ACD8C 800BC58C 0000458C */  lw         $a1, 0x0($v0)
    /* ACD90 800BC590 21300000 */  addu       $a2, $zero, $zero
    /* ACD94 800BC594 6DF0020C */  jal        CarIO_CopyToShape__FPsT0i
    /* ACD98 800BC598 1000A524 */   addiu     $a1, $a1, 0x10
    /* ACD9C 800BC59C 0C006426 */  addiu      $a0, $s3, 0xC
    /* ACDA0 800BC5A0 1480023C */  lui        $v0, %hi(CarIO_Plate2)
    /* ACDA4 800BC5A4 50D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate2)
    /* ACDA8 800BC5A8 21800202 */  addu       $s0, $s0, $v0
    /* ACDAC 800BC5AC 0000058E */  lw         $a1, 0x0($s0)
    /* ACDB0 800BC5B0 21300000 */  addu       $a2, $zero, $zero
  .L800BC5B4:
    /* ACDB4 800BC5B4 6DF0020C */  jal        CarIO_CopyToShape__FPsT0i
    /* ACDB8 800BC5B8 1000A524 */   addiu     $a1, $a1, 0x10
    /* ACDBC 800BC5BC 5095030C */  jal        purgememadr
    /* ACDC0 800BC5C0 21206002 */   addu      $a0, $s3, $zero
  .L800BC5C4:
    /* ACDC4 800BC5C4 4000BF8F */  lw         $ra, 0x40($sp)
    /* ACDC8 800BC5C8 3C00B78F */  lw         $s7, 0x3C($sp)
    /* ACDCC 800BC5CC 3800B68F */  lw         $s6, 0x38($sp)
    /* ACDD0 800BC5D0 3400B58F */  lw         $s5, 0x34($sp)
    /* ACDD4 800BC5D4 3000B48F */  lw         $s4, 0x30($sp)
    /* ACDD8 800BC5D8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* ACDDC 800BC5DC 2800B28F */  lw         $s2, 0x28($sp)
    /* ACDE0 800BC5E0 2400B18F */  lw         $s1, 0x24($sp)
    /* ACDE4 800BC5E4 2000B08F */  lw         $s0, 0x20($sp)
    /* ACDE8 800BC5E8 0800E003 */  jr         $ra
    /* ACDEC 800BC5EC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel CarIO_CreateLicense__FPcii
