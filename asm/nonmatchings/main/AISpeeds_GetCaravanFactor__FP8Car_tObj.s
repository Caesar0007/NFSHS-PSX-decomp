.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetCaravanFactor__FP8Car_tObj, 0x3BC

glabel AISpeeds_GetCaravanFactor__FP8Car_tObj
    /* 5EAD0 8006E2D0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5EAD4 8006E2D4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5EAD8 8006E2D8 21908000 */  addu       $s2, $a0, $zero
    /* 5EADC 8006E2DC 2400BFAF */  sw         $ra, 0x24($sp)
    /* 5EAE0 8006E2E0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5EAE4 8006E2E4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5EAE8 8006E2E8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5EAEC 8006E2EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5EAF0 8006E2F0 7407548E */  lw         $s4, 0x774($s2)
    /* 5EAF4 8006E2F4 96B8010C */  jal        AISpeeds_GetNextAICar__FP8Car_tObj
    /* 5EAF8 8006E2F8 00000000 */   nop
    /* 5EAFC 8006E2FC 6407438E */  lw         $v1, 0x764($s2)
    /* 5EB00 8006E300 00000000 */  nop
    /* 5EB04 8006E304 08006010 */  beqz       $v1, .L8006E328
    /* 5EB08 8006E308 21884000 */   addu      $s1, $v0, $zero
    /* 5EB0C 8006E30C 7407628C */  lw         $v0, 0x774($v1)
    /* 5EB10 8006E310 00000000 */  nop
    /* 5EB14 8006E314 2A105400 */  slt        $v0, $v0, $s4
    /* 5EB18 8006E318 4A004010 */  beqz       $v0, .L8006E444
    /* 5EB1C 8006E31C 66E61334 */   ori       $s3, $zero, 0xE666
    /* 5EB20 8006E320 11B90108 */  j          .L8006E444
    /* 5EB24 8006E324 640740AE */   sw        $zero, 0x764($s2)
  .L8006E328:
    /* 5EB28 8006E328 21002012 */  beqz       $s1, .L8006E3B0
    /* 5EB2C 8006E32C 00000000 */   nop
    /* 5EB30 8006E330 6407228E */  lw         $v0, 0x764($s1)
    /* 5EB34 8006E334 00000000 */  nop
    /* 5EB38 8006E338 1E004014 */  bnez       $v0, .L8006E3B4
    /* 5EB3C 8006E33C 00000000 */   nop
    /* 5EB40 8006E340 0D00023C */  lui        $v0, (0xD6491 >> 16)
    /* 5EB44 8006E344 6805238E */  lw         $v1, 0x568($s1)
    /* 5EB48 8006E348 91644234 */  ori        $v0, $v0, (0xD6491 & 0xFFFF)
    /* 5EB4C 8006E34C 2A104300 */  slt        $v0, $v0, $v1
    /* 5EB50 8006E350 17004010 */  beqz       $v0, .L8006E3B0
    /* 5EB54 8006E354 00000000 */   nop
    /* 5EB58 8006E358 5405438E */  lw         $v1, 0x554($s2)
    /* 5EB5C 8006E35C 6005228E */  lw         $v0, 0x560($s1)
    /* 5EB60 8006E360 00000000 */  nop
    /* 5EB64 8006E364 18004300 */  mult       $v0, $v1
    /* 5EB68 8006E368 12200000 */  mflo       $a0
    /* 5EB6C 8006E36C 5C05228E */  lw         $v0, 0x55C($s1)
    /* 5EB70 8006E370 00000000 */  nop
    /* 5EB74 8006E374 18004300 */  mult       $v0, $v1
    /* 5EB78 8006E378 12280000 */  mflo       $a1
    /* 5EB7C 8006E37C 02008104 */  bgez       $a0, .L8006E388
    /* 5EB80 8006E380 00000000 */   nop
    /* 5EB84 8006E384 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8006E388:
    /* 5EB88 8006E388 03220400 */  sra        $a0, $a0, 8
    /* 5EB8C 8006E38C 40180400 */  sll        $v1, $a0, 1
    /* 5EB90 8006E390 21186400 */  addu       $v1, $v1, $a0
    /* 5EB94 8006E394 00110300 */  sll        $v0, $v1, 4
    /* 5EB98 8006E398 23104300 */  subu       $v0, $v0, $v1
    /* 5EB9C 8006E39C 80100200 */  sll        $v0, $v0, 2
    /* 5EBA0 8006E3A0 23104400 */  subu       $v0, $v0, $a0
    /* 5EBA4 8006E3A4 2A10A200 */  slt        $v0, $a1, $v0
    /* 5EBA8 8006E3A8 07004010 */  beqz       $v0, .L8006E3C8
    /* 5EBAC 8006E3AC 00000000 */   nop
  .L8006E3B0:
    /* 5EBB0 8006E3B0 6407228E */  lw         $v0, 0x764($s1)
  .L8006E3B4:
    /* 5EBB4 8006E3B4 00000000 */  nop
    /* 5EBB8 8006E3B8 22005214 */  bne        $v0, $s2, .L8006E444
    /* 5EBBC 8006E3BC 0100133C */   lui       $s3, (0x11999 >> 16)
    /* 5EBC0 8006E3C0 11B90108 */  j          .L8006E444
    /* 5EBC4 8006E3C4 99197336 */   ori       $s3, $s3, (0x11999 & 0xFFFF)
  .L8006E3C8:
    /* 5EBC8 8006E3C8 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 5EBCC 8006E3CC 21202002 */   addu      $a0, $s1, $zero
    /* 5EBD0 8006E3D0 21204002 */  addu       $a0, $s2, $zero
    /* 5EBD4 8006E3D4 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 5EBD8 8006E3D8 21804000 */   addu      $s0, $v0, $zero
    /* 5EBDC 8006E3DC 23800202 */  subu       $s0, $s0, $v0
    /* 5EBE0 8006E3E0 6C07438E */  lw         $v1, 0x76C($s2)
    /* 5EBE4 8006E3E4 0A00043C */  lui        $a0, (0xA0000 >> 16)
    /* 5EBE8 8006E3E8 21106400 */  addu       $v0, $v1, $a0
    /* 5EBEC 8006E3EC 2A105000 */  slt        $v0, $v0, $s0
    /* 5EBF0 8006E3F0 09004010 */  beqz       $v0, .L8006E418
    /* 5EBF4 8006E3F4 0100133C */   lui       $s3, (0x13333 >> 16)
    /* 5EBF8 8006E3F8 E803023C */  lui        $v0, (0x3E80000 >> 16)
    /* 5EBFC 8006E3FC 21106200 */  addu       $v0, $v1, $v0
    /* 5EC00 8006E400 2A105000 */  slt        $v0, $v0, $s0
    /* 5EC04 8006E404 0F004010 */  beqz       $v0, .L8006E444
    /* 5EC08 8006E408 33337336 */   ori       $s3, $s3, (0x13333 & 0xFFFF)
    /* 5EC0C 8006E40C 0100133C */  lui        $s3, (0x18000 >> 16)
    /* 5EC10 8006E410 11B90108 */  j          .L8006E444
    /* 5EC14 8006E414 00807336 */   ori       $s3, $s3, (0x18000 & 0xFFFF)
  .L8006E418:
    /* 5EC18 8006E418 23106400 */  subu       $v0, $v1, $a0
    /* 5EC1C 8006E41C 2A100202 */  slt        $v0, $s0, $v0
    /* 5EC20 8006E420 07004010 */  beqz       $v0, .L8006E440
    /* 5EC24 8006E424 18FC023C */   lui       $v0, (0xFC180000 >> 16)
    /* 5EC28 8006E428 21106200 */  addu       $v0, $v1, $v0
    /* 5EC2C 8006E42C 2A100202 */  slt        $v0, $s0, $v0
    /* 5EC30 8006E430 04004010 */  beqz       $v0, .L8006E444
    /* 5EC34 8006E434 CCCC1334 */   ori       $s3, $zero, 0xCCCC
    /* 5EC38 8006E438 11B90108 */  j          .L8006E444
    /* 5EC3C 8006E43C 99991334 */   ori       $s3, $zero, 0x9999
  .L8006E440:
    /* 5EC40 8006E440 0100133C */  lui        $s3, (0x10000 >> 16)
  .L8006E444:
    /* 5EC44 8006E444 1180023C */  lui        $v0, %hi(CaravanInfo)
    /* 5EC48 8006E448 B4DD4224 */  addiu      $v0, $v0, %lo(CaravanInfo)
    /* 5EC4C 8006E44C 00191400 */  sll        $v1, $s4, 4
    /* 5EC50 8006E450 21406200 */  addu       $t0, $v1, $v0
    /* 5EC54 8006E454 0000028D */  lw         $v0, 0x0($t0)
    /* 5EC58 8006E458 00000000 */  nop
    /* 5EC5C 8006E45C 07004010 */  beqz       $v0, .L8006E47C
    /* 5EC60 8006E460 00000000 */   nop
    /* 5EC64 8006E464 7007428E */  lw         $v0, 0x770($s2)
    /* 5EC68 8006E468 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 5EC6C 8006E46C 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 5EC70 8006E470 00000000 */  nop
    /* 5EC74 8006E474 23104300 */  subu       $v0, $v0, $v1
    /* 5EC78 8006E478 700742AE */  sw         $v0, 0x770($s2)
  .L8006E47C:
    /* 5EC7C 8006E47C 7007428E */  lw         $v0, 0x770($s2)
    /* 5EC80 8006E480 00000000 */  nop
    /* 5EC84 8006E484 2D004104 */  bgez       $v0, .L8006E53C
    /* 5EC88 8006E488 FF00053C */   lui       $a1, (0xFFFF00 >> 16)
    /* 5EC8C 8006E48C 1480063C */  lui        $a2, %hi(fastRandom)
    /* 5EC90 8006E490 FCD0C68C */  lw         $a2, %lo(fastRandom)($a2)
    /* 5EC94 8006E494 1480043C */  lui        $a0, %hi(randSeed)
    /* 5EC98 8006E498 04D1848C */  lw         $a0, %lo(randSeed)($a0)
    /* 5EC9C 8006E49C 00000000 */  nop
    /* 5ECA0 8006E4A0 1800C400 */  mult       $a2, $a0
    /* 5ECA4 8006E4A4 0000038D */  lw         $v1, 0x0($t0)
    /* 5ECA8 8006E4A8 00FFA534 */  ori        $a1, $a1, (0xFFFF00 & 0xFFFF)
    /* 5ECAC 8006E4AC C2170300 */  srl        $v0, $v1, 31
    /* 5ECB0 8006E4B0 21186200 */  addu       $v1, $v1, $v0
    /* 5ECB4 8006E4B4 43180300 */  sra        $v1, $v1, 1
    /* 5ECB8 8006E4B8 12300000 */  mflo       $a2
    /* 5ECBC 8006E4BC 2410C500 */  and        $v0, $a2, $a1
    /* 5ECC0 8006E4C0 02120200 */  srl        $v0, $v0, 8
    /* 5ECC4 8006E4C4 18006200 */  mult       $v1, $v0
    /* 5ECC8 8006E4C8 12500000 */  mflo       $t2
    /* 5ECCC 8006E4CC FFFFC730 */  andi       $a3, $a2, 0xFFFF
    /* 5ECD0 8006E4D0 00000000 */  nop
    /* 5ECD4 8006E4D4 1800E400 */  mult       $a3, $a0
    /* 5ECD8 8006E4D8 02140A00 */  srl        $v0, $t2, 16
    /* 5ECDC 8006E4DC 21186200 */  addu       $v1, $v1, $v0
    /* 5ECE0 8006E4E0 700743AE */  sw         $v1, 0x770($s2)
    /* 5ECE4 8006E4E4 0800028D */  lw         $v0, 0x8($t0)
    /* 5ECE8 8006E4E8 0400038D */  lw         $v1, 0x4($t0)
    /* 5ECEC 8006E4EC 00000000 */  nop
    /* 5ECF0 8006E4F0 23104300 */  subu       $v0, $v0, $v1
    /* 5ECF4 8006E4F4 12200000 */  mflo       $a0
    /* 5ECF8 8006E4F8 24288500 */  and        $a1, $a0, $a1
    /* 5ECFC 8006E4FC 022A0500 */  srl        $a1, $a1, 8
    /* 5ED00 8006E500 18004500 */  mult       $v0, $a1
    /* 5ED04 8006E504 1480013C */  lui        $at, %hi(randtemp)
    /* 5ED08 8006E508 00D126AC */  sw         $a2, %lo(randtemp)($at)
    /* 5ED0C 8006E50C 1480013C */  lui        $at, %hi(fastRandom)
    /* 5ED10 8006E510 FCD027AC */  sw         $a3, %lo(fastRandom)($at)
    /* 5ED14 8006E514 1480013C */  lui        $at, %hi(randtemp)
    /* 5ED18 8006E518 00D124AC */  sw         $a0, %lo(randtemp)($at)
    /* 5ED1C 8006E51C FFFF8430 */  andi       $a0, $a0, 0xFFFF
    /* 5ED20 8006E520 1480013C */  lui        $at, %hi(fastRandom)
    /* 5ED24 8006E524 FCD024AC */  sw         $a0, %lo(fastRandom)($at)
    /* 5ED28 8006E528 12280000 */  mflo       $a1
    /* 5ED2C 8006E52C 02140500 */  srl        $v0, $a1, 16
    /* 5ED30 8006E530 21186200 */  addu       $v1, $v1, $v0
    /* 5ED34 8006E534 001C0300 */  sll        $v1, $v1, 16
    /* 5ED38 8006E538 6C0743AE */  sw         $v1, 0x76C($s2)
  .L8006E53C:
    /* 5ED3C 8006E53C 1480023C */  lui        $v0, %hi(Cars_gNumAIRaceCars)
    /* 5ED40 8006E540 04C8428C */  lw         $v0, %lo(Cars_gNumAIRaceCars)($v0)
    /* 5ED44 8006E544 00000000 */  nop
    /* 5ED48 8006E548 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 5ED4C 8006E54C 2A108202 */  slt        $v0, $s4, $v0
    /* 5ED50 8006E550 39004010 */  beqz       $v0, .L8006E638
    /* 5ED54 8006E554 00000000 */   nop
    /* 5ED58 8006E558 6407428E */  lw         $v0, 0x764($s2)
    /* 5ED5C 8006E55C 00000000 */  nop
    /* 5ED60 8006E560 35004014 */  bnez       $v0, .L8006E638
    /* 5ED64 8006E564 1180023C */   lui       $v0, %hi(D_801131F0)
    /* 5ED68 8006E568 F031438C */  lw         $v1, %lo(D_801131F0)($v0)
    /* 5ED6C 8006E56C 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5ED70 8006E570 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5ED74 8006E574 00000000 */  nop
    /* 5ED78 8006E578 18006200 */  mult       $v1, $v0
    /* 5ED7C 8006E57C 06004296 */  lhu        $v0, 0x6($s2)
    /* 5ED80 8006E580 12480000 */  mflo       $t1
    /* 5ED84 8006E584 B3FE2325 */  addiu      $v1, $t1, -0x14D
    /* 5ED88 8006E588 2A104300 */  slt        $v0, $v0, $v1
    /* 5ED8C 8006E58C 2A004010 */  beqz       $v0, .L8006E638
    /* 5ED90 8006E590 0200822E */   sltiu     $v0, $s4, 0x2
    /* 5ED94 8006E594 07004010 */  beqz       $v0, .L8006E5B4
    /* 5ED98 8006E598 1180023C */   lui       $v0, %hi(leaderBoard)
    /* 5ED9C 8006E59C 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 5EDA0 8006E5A0 A4DD448C */  lw         $a0, %lo(leaderBoard)($v0)
    /* 5EDA4 8006E5A4 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5EDA8 8006E5A8 00000000 */  nop
    /* 5EDAC 8006E5AC 22008210 */  beq        $a0, $v0, .L8006E638
    /* 5EDB0 8006E5B0 00000000 */   nop
  .L8006E5B4:
    /* 5EDB4 8006E5B4 1480023C */  lui        $v0, %hi(fastRandom)
    /* 5EDB8 8006E5B8 FCD0428C */  lw         $v0, %lo(fastRandom)($v0)
    /* 5EDBC 8006E5BC 1480033C */  lui        $v1, %hi(randSeed)
    /* 5EDC0 8006E5C0 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 5EDC4 8006E5C4 00000000 */  nop
    /* 5EDC8 8006E5C8 18004300 */  mult       $v0, $v1
    /* 5EDCC 8006E5CC 12100000 */  mflo       $v0
    /* 5EDD0 8006E5D0 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* 5EDD4 8006E5D4 1480013C */  lui        $at, %hi(randtemp)
    /* 5EDD8 8006E5D8 00D122AC */  sw         $v0, %lo(randtemp)($at)
    /* 5EDDC 8006E5DC 02120200 */  srl        $v0, $v0, 8
    /* 5EDE0 8006E5E0 1480013C */  lui        $at, %hi(fastRandom)
    /* 5EDE4 8006E5E4 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 5EDE8 8006E5E8 05002012 */  beqz       $s1, .L8006E600
    /* 5EDEC 8006E5EC FFFF4430 */   andi      $a0, $v0, 0xFFFF
    /* 5EDF0 8006E5F0 6407228E */  lw         $v0, 0x764($s1)
    /* 5EDF4 8006E5F4 00000000 */  nop
    /* 5EDF8 8006E5F8 0F004014 */  bnez       $v0, .L8006E638
    /* 5EDFC 8006E5FC 00000000 */   nop
  .L8006E600:
    /* 5EE00 8006E600 0C00038D */  lw         $v1, 0xC($t0)
    /* 5EE04 8006E604 1480023C */  lui        $v0, %hi(AI_elapsedTime)
    /* 5EE08 8006E608 54C5428C */  lw         $v0, %lo(AI_elapsedTime)($v0)
    /* 5EE0C 8006E60C 00000000 */  nop
    /* 5EE10 8006E610 18006200 */  mult       $v1, $v0
    /* 5EE14 8006E614 12480000 */  mflo       $t1
    /* 5EE18 8006E618 2B108900 */  sltu       $v0, $a0, $t1
    /* 5EE1C 8006E61C 06004010 */  beqz       $v0, .L8006E638
    /* 5EE20 8006E620 00000000 */   nop
    /* 5EE24 8006E624 99B8010C */  jal        AISpeeds_GetPrevAICar__FP8Car_tObj
    /* 5EE28 8006E628 21204002 */   addu      $a0, $s2, $zero
    /* 5EE2C 8006E62C 02004010 */  beqz       $v0, .L8006E638
    /* 5EE30 8006E630 00000000 */   nop
    /* 5EE34 8006E634 640742AE */  sw         $v0, 0x764($s2)
  .L8006E638:
    /* 5EE38 8006E638 0C002012 */  beqz       $s1, .L8006E66C
    /* 5EE3C 8006E63C 21106002 */   addu      $v0, $s3, $zero
    /* 5EE40 8006E640 7807428E */  lw         $v0, 0x778($s2)
    /* 5EE44 8006E644 7807238E */  lw         $v1, 0x778($s1)
    /* 5EE48 8006E648 67E64224 */  addiu      $v0, $v0, -0x1999
    /* 5EE4C 8006E64C 2A186200 */  slt        $v1, $v1, $v0
    /* 5EE50 8006E650 06006010 */  beqz       $v1, .L8006E66C
    /* 5EE54 8006E654 21106002 */   addu      $v0, $s3, $zero
    /* 5EE58 8006E658 6407228E */  lw         $v0, 0x764($s1)
    /* 5EE5C 8006E65C 00000000 */  nop
    /* 5EE60 8006E660 02004014 */  bnez       $v0, .L8006E66C
    /* 5EE64 8006E664 21106002 */   addu      $v0, $s3, $zero
    /* 5EE68 8006E668 640732AE */  sw         $s2, 0x764($s1)
  .L8006E66C:
    /* 5EE6C 8006E66C 2400BF8F */  lw         $ra, 0x24($sp)
    /* 5EE70 8006E670 2000B48F */  lw         $s4, 0x20($sp)
    /* 5EE74 8006E674 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5EE78 8006E678 1800B28F */  lw         $s2, 0x18($sp)
    /* 5EE7C 8006E67C 1400B18F */  lw         $s1, 0x14($sp)
    /* 5EE80 8006E680 1000B08F */  lw         $s0, 0x10($sp)
    /* 5EE84 8006E684 0800E003 */  jr         $ra
    /* 5EE88 8006E688 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AISpeeds_GetCaravanFactor__FP8Car_tObj
