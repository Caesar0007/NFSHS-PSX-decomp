.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformplay, 0x2AC

glabel iSNDplatformplay
    /* FC248 8010BA48 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* FC24C 8010BA4C 3000B4AF */  sw         $s4, 0x30($sp)
    /* FC250 8010BA50 21A0A000 */  addu       $s4, $a1, $zero
    /* FC254 8010BA54 3400B5AF */  sw         $s5, 0x34($sp)
    /* FC258 8010BA58 21A8C000 */  addu       $s5, $a2, $zero
    /* FC25C 8010BA5C 3800B6AF */  sw         $s6, 0x38($sp)
    /* FC260 8010BA60 21B0E000 */  addu       $s6, $a3, $zero
    /* FC264 8010BA64 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* FC268 8010BA68 21980000 */  addu       $s3, $zero, $zero
    /* FC26C 8010BA6C 2400B1AF */  sw         $s1, 0x24($sp)
    /* FC270 8010BA70 22561124 */  addiu      $s1, $zero, 0x5622
    /* FC274 8010BA74 2800B2AF */  sw         $s2, 0x28($sp)
    /* FC278 8010BA78 21906002 */  addu       $s2, $s3, $zero
    /* FC27C 8010BA7C 40101400 */  sll        $v0, $s4, 1
    /* FC280 8010BA80 21105400 */  addu       $v0, $v0, $s4
    /* FC284 8010BA84 80100200 */  sll        $v0, $v0, 2
    /* FC288 8010BA88 23105400 */  subu       $v0, $v0, $s4
    /* FC28C 8010BA8C 80100200 */  sll        $v0, $v0, 2
    /* FC290 8010BA90 1480033C */  lui        $v1, %hi(D_801479F0)
    /* FC294 8010BA94 F0796324 */  addiu      $v1, $v1, %lo(D_801479F0)
    /* FC298 8010BA98 2000B0AF */  sw         $s0, 0x20($sp)
    /* FC29C 8010BA9C 21804300 */  addu       $s0, $v0, $v1
    /* FC2A0 8010BAA0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* FC2A4 8010BAA4 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* FC2A8 8010BAA8 4000A4AF */  sw         $a0, 0x40($sp)
    /* FC2AC 8010BAAC 210000A2 */  sb         $zero, 0x21($s0)
    /* FC2B0 8010BAB0 200002A2 */  sb         $v0, 0x20($s0)
    /* FC2B4 8010BAB4 01000224 */  addiu      $v0, $zero, 0x1
    /* FC2B8 8010BAB8 1E0000A2 */  sb         $zero, 0x1E($s0)
  .L8010BABC:
    /* FC2BC 8010BABC 1F0002A2 */  sb         $v0, 0x1F($s0)
    /* FC2C0 8010BAC0 4000A427 */  addiu      $a0, $sp, 0x40
  .L8010BAC4:
    /* FC2C4 8010BAC4 1000A527 */  addiu      $a1, $sp, 0x10
    /* FC2C8 8010BAC8 1400A627 */  addiu      $a2, $sp, 0x14
    /* FC2CC 8010BACC 542F040C */  jal        iSNDgettag
    /* FC2D0 8010BAD0 1800A727 */   addiu     $a3, $sp, 0x18
    /* FC2D4 8010BAD4 20004010 */  beqz       $v0, .L8010BB58
    /* FC2D8 8010BAD8 FE000224 */   addiu     $v0, $zero, 0xFE
    /* FC2DC 8010BADC 1000A38F */  lw         $v1, 0x10($sp)
    /* FC2E0 8010BAE0 00000000 */  nop
    /* FC2E4 8010BAE4 1C006210 */  beq        $v1, $v0, .L8010BB58
    /* FC2E8 8010BAE8 8A000224 */   addiu     $v0, $zero, 0x8A
    /* FC2EC 8010BAEC 04006214 */  bne        $v1, $v0, .L8010BB00
    /* FC2F0 8010BAF0 85000224 */   addiu     $v0, $zero, 0x85
    /* FC2F4 8010BAF4 1800B38F */  lw         $s3, 0x18($sp)
    /* FC2F8 8010BAF8 B12E0408 */  j          .L8010BAC4
    /* FC2FC 8010BAFC 4000A427 */   addiu     $a0, $sp, 0x40
  .L8010BB00:
    /* FC300 8010BB00 04006214 */  bne        $v1, $v0, .L8010BB14
    /* FC304 8010BB04 82000224 */   addiu     $v0, $zero, 0x82
    /* FC308 8010BB08 1400B28F */  lw         $s2, 0x14($sp)
    /* FC30C 8010BB0C B12E0408 */  j          .L8010BAC4
    /* FC310 8010BB10 4000A427 */   addiu     $a0, $sp, 0x40
  .L8010BB14:
    /* FC314 8010BB14 04006214 */  bne        $v1, $v0, .L8010BB28
    /* FC318 8010BB18 84000224 */   addiu     $v0, $zero, 0x84
    /* FC31C 8010BB1C 1400A293 */  lbu        $v0, 0x14($sp)
    /* FC320 8010BB20 AF2E0408 */  j          .L8010BABC
    /* FC324 8010BB24 00000000 */   nop
  .L8010BB28:
    /* FC328 8010BB28 04006214 */  bne        $v1, $v0, .L8010BB3C
    /* FC32C 8010BB2C 92000224 */   addiu     $v0, $zero, 0x92
    /* FC330 8010BB30 1400B18F */  lw         $s1, 0x14($sp)
    /* FC334 8010BB34 B12E0408 */  j          .L8010BAC4
    /* FC338 8010BB38 4000A427 */   addiu     $a0, $sp, 0x40
  .L8010BB3C:
    /* FC33C 8010BB3C E1FF6214 */  bne        $v1, $v0, .L8010BAC4
    /* FC340 8010BB40 4000A427 */   addiu     $a0, $sp, 0x40
    /* FC344 8010BB44 1400A293 */  lbu        $v0, 0x14($sp)
    /* FC348 8010BB48 00000000 */  nop
    /* FC34C 8010BB4C 1E0002A2 */  sb         $v0, 0x1E($s0)
    /* FC350 8010BB50 B12E0408 */  j          .L8010BAC4
    /* FC354 8010BB54 4000A427 */   addiu     $a0, $sp, 0x40
  .L8010BB58:
    /* FC358 8010BB58 040012AE */  sw         $s2, 0x4($s0)
    /* FC35C 8010BB5C 220015A2 */  sb         $s5, 0x22($s0)
    /* FC360 8010BB60 5800A28F */  lw         $v0, 0x58($sp)
    /* FC364 8010BB64 00000000 */  nop
    /* FC368 8010BB68 180002A6 */  sh         $v0, 0x18($s0)
    /* FC36C 8010BB6C 5400A28F */  lw         $v0, 0x54($sp)
    /* FC370 8010BB70 00000000 */  nop
    /* FC374 8010BB74 230002A2 */  sb         $v0, 0x23($s0)
    /* FC378 8010BB78 0000628E */  lw         $v0, 0x0($s3)
    /* FC37C 8010BB7C 00000000 */  nop
    /* FC380 8010BB80 000002AE */  sw         $v0, 0x0($s0)
    /* FC384 8010BB84 00131200 */  sll        $v0, $s2, 12
    /* FC388 8010BB88 0C0000AE */  sw         $zero, 0xC($s0)
    /* FC38C 8010BB8C 100000AE */  sw         $zero, 0x10($s0)
    /* FC390 8010BB90 140002AE */  sw         $v0, 0x14($s0)
    /* FC394 8010BB94 40101100 */  sll        $v0, $s1, 1
    /* FC398 8010BB98 21105100 */  addu       $v0, $v0, $s1
    /* FC39C 8010BB9C 40110200 */  sll        $v0, $v0, 5
    /* FC3A0 8010BBA0 23105100 */  subu       $v0, $v0, $s1
    /* FC3A4 8010BBA4 C0100200 */  sll        $v0, $v0, 3
    /* FC3A8 8010BBA8 21105100 */  addu       $v0, $v0, $s1
    /* FC3AC 8010BBAC C0100200 */  sll        $v0, $v0, 3
    /* FC3B0 8010BBB0 23105100 */  subu       $v0, $v0, $s1
    /* FC3B4 8010BBB4 03140200 */  sra        $v0, $v0, 16
    /* FC3B8 8010BBB8 1A0002A6 */  sh         $v0, 0x1A($s0)
    /* FC3BC 8010BBBC 1F000292 */  lbu        $v0, 0x1F($s0)
    /* FC3C0 8010BBC0 00000000 */  nop
    /* FC3C4 8010BBC4 0200422C */  sltiu      $v0, $v0, 0x2
    /* FC3C8 8010BBC8 3B004014 */  bnez       $v0, .L8010BCB8
    /* FC3CC 8010BBCC 21208002 */   addu      $a0, $s4, $zero
    /* FC3D0 8010BBD0 1480033C */  lui        $v1, %hi(D_801478F4)
    /* FC3D4 8010BBD4 40101400 */  sll        $v0, $s4, 1
    /* FC3D8 8010BBD8 21105400 */  addu       $v0, $v0, $s4
    /* FC3DC 8010BBDC C0100200 */  sll        $v0, $v0, 3
    /* FC3E0 8010BBE0 21105400 */  addu       $v0, $v0, $s4
    /* FC3E4 8010BBE4 F478638C */  lw         $v1, %lo(D_801478F4)($v1)
    /* FC3E8 8010BBE8 80100200 */  sll        $v0, $v0, 2
    /* FC3EC 8010BBEC 21104300 */  addu       $v0, $v0, $v1
    /* FC3F0 8010BBF0 04004290 */  lbu        $v0, 0x4($v0)
    /* FC3F4 8010BBF4 1480043C */  lui        $a0, %hi(sndpd)
    /* FC3F8 8010BBF8 200002A2 */  sb         $v0, 0x20($s0)
    /* FC3FC 8010BBFC 20000392 */  lbu        $v1, 0x20($s0)
    /* FC400 8010BC00 18798424 */  addiu      $a0, $a0, %lo(sndpd)
    /* FC404 8010BC04 001E0300 */  sll        $v1, $v1, 24
    /* FC408 8010BC08 031E0300 */  sra        $v1, $v1, 24
    /* FC40C 8010BC0C 40100300 */  sll        $v0, $v1, 1
    /* FC410 8010BC10 21104300 */  addu       $v0, $v0, $v1
    /* FC414 8010BC14 80100200 */  sll        $v0, $v0, 2
    /* FC418 8010BC18 23104300 */  subu       $v0, $v0, $v1
    /* FC41C 8010BC1C 80100200 */  sll        $v0, $v0, 2
    /* FC420 8010BC20 21104400 */  addu       $v0, $v0, $a0
    /* FC424 8010BC24 01000324 */  addiu      $v1, $zero, 0x1
    /* FC428 8010BC28 F90043A0 */  sb         $v1, 0xF9($v0)
    /* FC42C 8010BC2C 20000392 */  lbu        $v1, 0x20($s0)
    /* FC430 8010BC30 00000000 */  nop
    /* FC434 8010BC34 001E0300 */  sll        $v1, $v1, 24
    /* FC438 8010BC38 031E0300 */  sra        $v1, $v1, 24
    /* FC43C 8010BC3C 40100300 */  sll        $v0, $v1, 1
    /* FC440 8010BC40 21104300 */  addu       $v0, $v0, $v1
    /* FC444 8010BC44 80100200 */  sll        $v0, $v0, 2
    /* FC448 8010BC48 23104300 */  subu       $v0, $v0, $v1
    /* FC44C 8010BC4C 80100200 */  sll        $v0, $v0, 2
    /* FC450 8010BC50 21104400 */  addu       $v0, $v0, $a0
    /* FC454 8010BC54 E40040AC */  sw         $zero, 0xE4($v0)
    /* FC458 8010BC58 20000392 */  lbu        $v1, 0x20($s0)
    /* FC45C 8010BC5C 00000000 */  nop
    /* FC460 8010BC60 001E0300 */  sll        $v1, $v1, 24
    /* FC464 8010BC64 031E0300 */  sra        $v1, $v1, 24
    /* FC468 8010BC68 40100300 */  sll        $v0, $v1, 1
    /* FC46C 8010BC6C 21104300 */  addu       $v0, $v0, $v1
    /* FC470 8010BC70 80100200 */  sll        $v0, $v0, 2
    /* FC474 8010BC74 23104300 */  subu       $v0, $v0, $v1
    /* FC478 8010BC78 80100200 */  sll        $v0, $v0, 2
    /* FC47C 8010BC7C 21104400 */  addu       $v0, $v0, $a0
    /* FC480 8010BC80 E80040AC */  sw         $zero, 0xE8($v0)
    /* FC484 8010BC84 20000392 */  lbu        $v1, 0x20($s0)
    /* FC488 8010BC88 00000000 */  nop
    /* FC48C 8010BC8C 001E0300 */  sll        $v1, $v1, 24
    /* FC490 8010BC90 031E0300 */  sra        $v1, $v1, 24
    /* FC494 8010BC94 40100300 */  sll        $v0, $v1, 1
    /* FC498 8010BC98 21104300 */  addu       $v0, $v0, $v1
    /* FC49C 8010BC9C 80100200 */  sll        $v0, $v0, 2
    /* FC4A0 8010BCA0 23104300 */  subu       $v0, $v0, $v1
    /* FC4A4 8010BCA4 80100200 */  sll        $v0, $v0, 2
    /* FC4A8 8010BCA8 1400038E */  lw         $v1, 0x14($s0)
    /* FC4AC 8010BCAC 21104400 */  addu       $v0, $v0, $a0
    /* FC4B0 8010BCB0 EC0043AC */  sw         $v1, 0xEC($v0)
    /* FC4B4 8010BCB4 21208002 */  addu       $a0, $s4, $zero
  .L8010BCB8:
    /* FC4B8 8010BCB8 E5FF030C */  jal        iSNDplatformpitch
    /* FC4BC 8010BCBC 2128C002 */   addu      $a1, $s6, $zero
    /* FC4C0 8010BCC0 01000224 */  addiu      $v0, $zero, 0x1
    /* FC4C4 8010BCC4 1C0002A2 */  sb         $v0, 0x1C($s0)
    /* FC4C8 8010BCC8 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* FC4CC 8010BCCC 3800B68F */  lw         $s6, 0x38($sp)
    /* FC4D0 8010BCD0 3400B58F */  lw         $s5, 0x34($sp)
    /* FC4D4 8010BCD4 3000B48F */  lw         $s4, 0x30($sp)
    /* FC4D8 8010BCD8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* FC4DC 8010BCDC 2800B28F */  lw         $s2, 0x28($sp)
    /* FC4E0 8010BCE0 2400B18F */  lw         $s1, 0x24($sp)
    /* FC4E4 8010BCE4 2000B08F */  lw         $s0, 0x20($sp)
    /* FC4E8 8010BCE8 21100000 */  addu       $v0, $zero, $zero
    /* FC4EC 8010BCEC 0800E003 */  jr         $ra
    /* FC4F0 8010BCF0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel iSNDplatformplay
