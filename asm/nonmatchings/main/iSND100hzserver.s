.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSND100hzserver, 0x2E0

glabel iSND100hzserver
    /* DAA54 800EA254 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DAA58 800EA258 1480023C */  lui        $v0, %hi(sndgs)
    /* DAA5C 800EA25C 1000B0AF */  sw         $s0, 0x10($sp)
    /* DAA60 800EA260 60785024 */  addiu      $s0, $v0, %lo(sndgs)
    /* DAA64 800EA264 2000BFAF */  sw         $ra, 0x20($sp)
    /* DAA68 800EA268 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DAA6C 800EA26C 1800B2AF */  sw         $s2, 0x18($sp)
    /* DAA70 800EA270 1400B1AF */  sw         $s1, 0x14($sp)
    /* DAA74 800EA274 4400028E */  lw         $v0, 0x44($s0)
    /* DAA78 800EA278 00000000 */  nop
    /* DAA7C 800EA27C 01004224 */  addiu      $v0, $v0, 0x1
    /* DAA80 800EA280 440002AE */  sw         $v0, 0x44($s0)
    /* DAA84 800EA284 BDFE030C */  jal        iSNDserve
    /* DAA88 800EA288 21880000 */   addu      $s1, $zero, $zero
    /* DAA8C 800EA28C 40000282 */  lb         $v0, 0x40($s0)
    /* DAA90 800EA290 00000000 */  nop
    /* DAA94 800EA294 0A004018 */  blez       $v0, .L800EA2C0
    /* DAA98 800EA298 21900002 */   addu      $s2, $s0, $zero
  .L800EA29C:
    /* DAA9C 800EA29C 4C00028E */  lw         $v0, 0x4C($s0)
    /* DAAA0 800EA2A0 00000000 */  nop
    /* DAAA4 800EA2A4 09F84000 */  jalr       $v0
    /* DAAA8 800EA2A8 04001026 */   addiu     $s0, $s0, 0x4
    /* DAAAC 800EA2AC 40004282 */  lb         $v0, 0x40($s2)
    /* DAAB0 800EA2B0 01003126 */  addiu      $s1, $s1, 0x1
    /* DAAB4 800EA2B4 2A102202 */  slt        $v0, $s1, $v0
    /* DAAB8 800EA2B8 F8FF4014 */  bnez       $v0, .L800EA29C
    /* DAABC 800EA2BC 00000000 */   nop
  .L800EA2C0:
    /* DAAC0 800EA2C0 1480023C */  lui        $v0, %hi(sndgs)
    /* DAAC4 800EA2C4 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* DAAC8 800EA2C8 11006290 */  lbu        $v0, 0x11($v1)
    /* DAACC 800EA2CC 00000000 */  nop
    /* DAAD0 800EA2D0 91004010 */  beqz       $v0, .L800EA518
    /* DAAD4 800EA2D4 21880000 */   addu      $s1, $zero, $zero
    /* DAAD8 800EA2D8 21986000 */  addu       $s3, $v1, $zero
    /* DAADC 800EA2DC 21902002 */  addu       $s2, $s1, $zero
  .L800EA2E0:
    /* DAAE0 800EA2E0 9400628E */  lw         $v0, 0x94($s3)
    /* DAAE4 800EA2E4 00000000 */  nop
    /* DAAE8 800EA2E8 21805200 */  addu       $s0, $v0, $s2
    /* DAAEC 800EA2EC 0B000382 */  lb         $v1, 0xB($s0)
    /* DAAF0 800EA2F0 01000224 */  addiu      $v0, $zero, 0x1
    /* DAAF4 800EA2F4 82006214 */  bne        $v1, $v0, .L800EA500
    /* DAAF8 800EA2F8 00000000 */   nop
    /* DAAFC 800EA2FC 0000028E */  lw         $v0, 0x0($s0)
    /* DAB00 800EA300 00000000 */  nop
    /* DAB04 800EA304 7E004004 */  bltz       $v0, .L800EA500
    /* DAB08 800EA308 00000000 */   nop
    /* DAB0C 800EA30C 5400028E */  lw         $v0, 0x54($s0)
    /* DAB10 800EA310 00000000 */  nop
    /* DAB14 800EA314 10004010 */  beqz       $v0, .L800EA358
    /* DAB18 800EA318 00000000 */   nop
    /* DAB1C 800EA31C 3B000292 */  lbu        $v0, 0x3B($s0)
    /* DAB20 800EA320 39000392 */  lbu        $v1, 0x39($s0)
    /* DAB24 800EA324 01004224 */  addiu      $v0, $v0, 0x1
    /* DAB28 800EA328 3B0002A2 */  sb         $v0, 0x3B($s0)
    /* DAB2C 800EA32C FF004230 */  andi       $v0, $v0, 0xFF
    /* DAB30 800EA330 2B104300 */  sltu       $v0, $v0, $v1
    /* DAB34 800EA334 02004014 */  bnez       $v0, .L800EA340
    /* DAB38 800EA338 00000000 */   nop
    /* DAB3C 800EA33C 3B0000A2 */  sb         $zero, 0x3B($s0)
  .L800EA340:
    /* DAB40 800EA340 21202002 */  addu       $a0, $s1, $zero
    /* DAB44 800EA344 6F06040C */  jal        iSNDcalcpitch
    /* DAB48 800EA348 5E0000A6 */   sh        $zero, 0x5E($s0)
    /* DAB4C 800EA34C 62000596 */  lhu        $a1, 0x62($s0)
    /* DAB50 800EA350 E5FF030C */  jal        iSNDplatformpitch
    /* DAB54 800EA354 21202002 */   addu      $a0, $s1, $zero
  .L800EA358:
    /* DAB58 800EA358 5000028E */  lw         $v0, 0x50($s0)
    /* DAB5C 800EA35C 00000000 */  nop
    /* DAB60 800EA360 0B004010 */  beqz       $v0, .L800EA390
    /* DAB64 800EA364 21280000 */   addu      $a1, $zero, $zero
    /* DAB68 800EA368 01000524 */  addiu      $a1, $zero, 0x1
    /* DAB6C 800EA36C 3A000292 */  lbu        $v0, 0x3A($s0)
    /* DAB70 800EA370 38000392 */  lbu        $v1, 0x38($s0)
    /* DAB74 800EA374 21104500 */  addu       $v0, $v0, $a1
    /* DAB78 800EA378 3A0002A2 */  sb         $v0, 0x3A($s0)
    /* DAB7C 800EA37C FF004230 */  andi       $v0, $v0, 0xFF
    /* DAB80 800EA380 2B104300 */  sltu       $v0, $v0, $v1
    /* DAB84 800EA384 02004014 */  bnez       $v0, .L800EA390
    /* DAB88 800EA388 00000000 */   nop
    /* DAB8C 800EA38C 3A0000A2 */  sb         $zero, 0x3A($s0)
  .L800EA390:
    /* DAB90 800EA390 1400048E */  lw         $a0, 0x14($s0)
    /* DAB94 800EA394 00000000 */  nop
    /* DAB98 800EA398 15008010 */  beqz       $a0, .L800EA3F0
    /* DAB9C 800EA39C 21188000 */   addu      $v1, $a0, $zero
    /* DABA0 800EA3A0 01000524 */  addiu      $a1, $zero, 0x1
    /* DABA4 800EA3A4 1C00028E */  lw         $v0, 0x1C($s0)
    /* DABA8 800EA3A8 00000000 */  nop
    /* DABAC 800EA3AC 21104400 */  addu       $v0, $v0, $a0
    /* DABB0 800EA3B0 04006104 */  bgez       $v1, .L800EA3C4
    /* DABB4 800EA3B4 1C0002AE */   sw        $v0, 0x1C($s0)
    /* DABB8 800EA3B8 1800038E */  lw         $v1, 0x18($s0)
    /* DABBC 800EA3BC F4A80308 */  j          .L800EA3D0
    /* DABC0 800EA3C0 2A106200 */   slt       $v0, $v1, $v0
  .L800EA3C4:
    /* DABC4 800EA3C4 1800038E */  lw         $v1, 0x18($s0)
    /* DABC8 800EA3C8 00000000 */  nop
    /* DABCC 800EA3CC 2A104300 */  slt        $v0, $v0, $v1
  .L800EA3D0:
    /* DABD0 800EA3D0 03004014 */  bnez       $v0, .L800EA3E0
    /* DABD4 800EA3D4 00000000 */   nop
    /* DABD8 800EA3D8 1C0003AE */  sw         $v1, 0x1C($s0)
    /* DABDC 800EA3DC 140000AE */  sw         $zero, 0x14($s0)
  .L800EA3E0:
    /* DABE0 800EA3E0 1C00028E */  lw         $v0, 0x1C($s0)
    /* DABE4 800EA3E4 00000000 */  nop
    /* DABE8 800EA3E8 16004004 */  bltz       $v0, .L800EA444
    /* DABEC 800EA3EC 00000000 */   nop
  .L800EA3F0:
    /* DABF0 800EA3F0 2000038E */  lw         $v1, 0x20($s0)
    /* DABF4 800EA3F4 00000000 */  nop
    /* DABF8 800EA3F8 05006010 */  beqz       $v1, .L800EA410
    /* DABFC 800EA3FC 00000000 */   nop
    /* DAC00 800EA400 2400028E */  lw         $v0, 0x24($s0)
    /* DAC04 800EA404 01000524 */  addiu      $a1, $zero, 0x1
    /* DAC08 800EA408 21104300 */  addu       $v0, $v0, $v1
    /* DAC0C 800EA40C 240002AE */  sw         $v0, 0x24($s0)
  .L800EA410:
    /* DAC10 800EA410 2800028E */  lw         $v0, 0x28($s0)
    /* DAC14 800EA414 00000000 */  nop
    /* DAC18 800EA418 2E004014 */  bnez       $v0, .L800EA4D4
    /* DAC1C 800EA41C FFFF4224 */   addiu     $v0, $v0, -0x1
    /* DAC20 800EA420 31000292 */  lbu        $v0, 0x31($s0)
    /* DAC24 800EA424 30000382 */  lb         $v1, 0x30($s0)
    /* DAC28 800EA428 01004224 */  addiu      $v0, $v0, 0x1
    /* DAC2C 800EA42C 310002A2 */  sb         $v0, 0x31($s0)
    /* DAC30 800EA430 00160200 */  sll        $v0, $v0, 24
    /* DAC34 800EA434 03260200 */  sra        $a0, $v0, 24
    /* DAC38 800EA438 2A188300 */  slt        $v1, $a0, $v1
    /* DAC3C 800EA43C 06006014 */  bnez       $v1, .L800EA458
    /* DAC40 800EA440 C0180400 */   sll       $v1, $a0, 3
  .L800EA444:
    /* DAC44 800EA444 0000048E */  lw         $a0, 0x0($s0)
    /* DAC48 800EA448 A09F030C */  jal        SNDstop
    /* DAC4C 800EA44C 64005226 */   addiu     $s2, $s2, 0x64
    /* DAC50 800EA450 41A90308 */  j          .L800EA504
    /* DAC54 800EA454 00000000 */   nop
  .L800EA458:
    /* DAC58 800EA458 4000028E */  lw         $v0, 0x40($s0)
    /* DAC5C 800EA45C 00000000 */  nop
    /* DAC60 800EA460 21184300 */  addu       $v1, $v0, $v1
    /* DAC64 800EA464 0000628C */  lw         $v0, 0x0($v1)
    /* DAC68 800EA468 00000000 */  nop
    /* DAC6C 800EA46C 04004104 */  bgez       $v0, .L800EA480
    /* DAC70 800EA470 280002AE */   sw        $v0, 0x28($s0)
    /* DAC74 800EA474 FF7F023C */  lui        $v0, (0x7FFFFFFF >> 16)
    /* DAC78 800EA478 FFFF4234 */  ori        $v0, $v0, (0x7FFFFFFF & 0xFFFF)
    /* DAC7C 800EA47C 280002AE */  sw         $v0, 0x28($s0)
  .L800EA480:
    /* DAC80 800EA480 0400628C */  lw         $v0, 0x4($v1)
    /* DAC84 800EA484 2400048E */  lw         $a0, 0x24($s0)
    /* DAC88 800EA488 2800038E */  lw         $v1, 0x28($s0)
    /* DAC8C 800EA48C 00140200 */  sll        $v0, $v0, 16
    /* DAC90 800EA490 23104400 */  subu       $v0, $v0, $a0
    /* DAC94 800EA494 1A004300 */  div        $zero, $v0, $v1
    /* DAC98 800EA498 02006014 */  bnez       $v1, .L800EA4A4
    /* DAC9C 800EA49C 00000000 */   nop
    /* DACA0 800EA4A0 0D000700 */  break      7
  .L800EA4A4:
    /* DACA4 800EA4A4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* DACA8 800EA4A8 04006114 */  bne        $v1, $at, .L800EA4BC
    /* DACAC 800EA4AC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* DACB0 800EA4B0 02004114 */  bne        $v0, $at, .L800EA4BC
    /* DACB4 800EA4B4 00000000 */   nop
    /* DACB8 800EA4B8 0D000600 */  break      6
  .L800EA4BC:
    /* DACBC 800EA4BC 12100000 */  mflo       $v0
    /* DACC0 800EA4C0 00000000 */  nop
    /* DACC4 800EA4C4 200002AE */  sw         $v0, 0x20($s0)
    /* DACC8 800EA4C8 2800028E */  lw         $v0, 0x28($s0)
    /* DACCC 800EA4CC 00000000 */  nop
    /* DACD0 800EA4D0 FFFF4224 */  addiu      $v0, $v0, -0x1
  .L800EA4D4:
    /* DACD4 800EA4D4 0A00A010 */  beqz       $a1, .L800EA500
    /* DACD8 800EA4D8 280002AE */   sw        $v0, 0x28($s0)
    /* DACDC 800EA4DC 14FC030C */  jal        iSNDcalcvol
    /* DACE0 800EA4E0 21202002 */   addu      $a0, $s1, $zero
    /* DACE4 800EA4E4 0000028E */  lw         $v0, 0x0($s0)
    /* DACE8 800EA4E8 00000000 */  nop
    /* DACEC 800EA4EC 04004004 */  bltz       $v0, .L800EA500
    /* DACF0 800EA4F0 00000000 */   nop
    /* DACF4 800EA4F4 2D000582 */  lb         $a1, 0x2D($s0)
    /* DACF8 800EA4F8 3E00040C */  jal        iSNDvol
    /* DACFC 800EA4FC 21202002 */   addu      $a0, $s1, $zero
  .L800EA500:
    /* DAD00 800EA500 64005226 */  addiu      $s2, $s2, 0x64
  .L800EA504:
    /* DAD04 800EA504 11006292 */  lbu        $v0, 0x11($s3)
    /* DAD08 800EA508 01003126 */  addiu      $s1, $s1, 0x1
    /* DAD0C 800EA50C 2A102202 */  slt        $v0, $s1, $v0
    /* DAD10 800EA510 73FF4014 */  bnez       $v0, .L800EA2E0
    /* DAD14 800EA514 00000000 */   nop
  .L800EA518:
    /* DAD18 800EA518 2000BF8F */  lw         $ra, 0x20($sp)
    /* DAD1C 800EA51C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DAD20 800EA520 1800B28F */  lw         $s2, 0x18($sp)
    /* DAD24 800EA524 1400B18F */  lw         $s1, 0x14($sp)
    /* DAD28 800EA528 1000B08F */  lw         $s0, 0x10($sp)
    /* DAD2C 800EA52C 0800E003 */  jr         $ra
    /* DAD30 800EA530 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSND100hzserver
