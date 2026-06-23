.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii, 0x3D4

glabel DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii
    /* 3EA64 8004E264 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 3EA68 8004E268 5000B4AF */  sw         $s4, 0x50($sp)
    /* 3EA6C 8004E26C 21A08000 */  addu       $s4, $a0, $zero
    /* 3EA70 8004E270 2170A000 */  addu       $t6, $a1, $zero
    /* 3EA74 8004E274 2150C000 */  addu       $t2, $a2, $zero
    /* 3EA78 8004E278 5C00B7AF */  sw         $s7, 0x5C($sp)
    /* 3EA7C 8004E27C 6400BFAF */  sw         $ra, 0x64($sp)
    /* 3EA80 8004E280 6000BEAF */  sw         $fp, 0x60($sp)
    /* 3EA84 8004E284 5800B6AF */  sw         $s6, 0x58($sp)
    /* 3EA88 8004E288 5400B5AF */  sw         $s5, 0x54($sp)
    /* 3EA8C 8004E28C 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* 3EA90 8004E290 4800B2AF */  sw         $s2, 0x48($sp)
    /* 3EA94 8004E294 4400B1AF */  sw         $s1, 0x44($sp)
    /* 3EA98 8004E298 4000B0AF */  sw         $s0, 0x40($sp)
    /* 3EA9C 8004E29C 12008396 */  lhu        $v1, 0x12($s4)
    /* 3EAA0 8004E2A0 7800AD8F */  lw         $t5, 0x78($sp)
    /* 3EAA4 8004E2A4 10008F96 */  lhu        $t7, 0x10($s4)
    /* 3EAA8 8004E2A8 0200C431 */  andi       $a0, $t6, 0x2
    /* 3EAAC 8004E2AC 1000AFA7 */  sh         $t7, 0x10($sp)
    /* 3EAB0 8004E2B0 08008592 */  lbu        $a1, 0x8($s4)
    /* 3EAB4 8004E2B4 05008010 */  beqz       $a0, .L8004E2CC
    /* 3EAB8 8004E2B8 21B8E000 */   addu      $s7, $a3, $zero
    /* 3EABC 8004E2BC 00140300 */  sll        $v0, $v1, 16
    /* 3EAC0 8004E2C0 03140200 */  sra        $v0, $v0, 16
    /* 3EAC4 8004E2C4 21B8E202 */  addu       $s7, $s7, $v0
    /* 3EAC8 8004E2C8 23180300 */  negu       $v1, $v1
  .L8004E2CC:
    /* 3EACC 8004E2CC 1A008292 */  lbu        $v0, 0x1A($s4)
    /* 3EAD0 8004E2D0 12009896 */  lhu        $t8, 0x12($s4)
    /* 3EAD4 8004E2D4 21604000 */  addu       $t4, $v0, $zero
    /* 3EAD8 8004E2D8 02008010 */  beqz       $a0, .L8004E2E4
    /* 3EADC 8004E2DC 1800B8A7 */   sh        $t8, 0x18($sp)
    /* 3EAE0 8004E2E0 FFFF4C24 */  addiu      $t4, $v0, -0x1
  .L8004E2E4:
    /* 3EAE4 8004E2E4 21880000 */  addu       $s1, $zero, $zero
    /* 3EAE8 8004E2E8 21B0A000 */  addu       $s6, $a1, $zero
    /* 3EAEC 8004E2EC FF000B3C */  lui        $t3, (0xFFFFFF >> 16)
    /* 3EAF0 8004E2F0 FFFF6B35 */  ori        $t3, $t3, (0xFFFFFF & 0xFFFF)
    /* 3EAF4 8004E2F4 2000ACA3 */  sb         $t4, 0x20($sp)
    /* 3EAF8 8004E2F8 21F07700 */  addu       $fp, $v1, $s7
  .L8004E2FC:
    /* 3EAFC 8004E2FC 00141100 */  sll        $v0, $s1, 16
    /* 3EB00 8004E300 10008886 */  lh         $t0, 0x10($s4)
    /* 3EB04 8004E304 03340200 */  sra        $a2, $v0, 16
    /* 3EB08 8004E308 2A10C800 */  slt        $v0, $a2, $t0
    /* 3EB0C 8004E30C BE004010 */  beqz       $v0, .L8004E608
    /* 3EB10 8004E310 1800D600 */   mult      $a2, $s6
    /* 3EB14 8004E314 12280000 */  mflo       $a1
    /* 3EB18 8004E318 0200A104 */  bgez       $a1, .L8004E324
    /* 3EB1C 8004E31C 00000000 */   nop
    /* 3EB20 8004E320 0F00A524 */  addiu      $a1, $a1, 0xF
  .L8004E324:
    /* 3EB24 8004E324 18008496 */  lhu        $a0, 0x18($s4)
    /* 3EB28 8004E328 00000000 */  nop
    /* 3EB2C 8004E32C 001C0400 */  sll        $v1, $a0, 16
    /* 3EB30 8004E330 031B0300 */  sra        $v1, $v1, 12
    /* 3EB34 8004E334 1A007600 */  div        $zero, $v1, $s6
    /* 3EB38 8004E338 0200C016 */  bnez       $s6, .L8004E344
    /* 3EB3C 8004E33C 00000000 */   nop
    /* 3EB40 8004E340 0D000700 */  break      7
  .L8004E344:
    /* 3EB44 8004E344 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3EB48 8004E348 0400C116 */  bne        $s6, $at, .L8004E35C
    /* 3EB4C 8004E34C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3EB50 8004E350 02006114 */  bne        $v1, $at, .L8004E35C
    /* 3EB54 8004E354 00000000 */   nop
    /* 3EB58 8004E358 0D000600 */  break      6
  .L8004E35C:
    /* 3EB5C 8004E35C 12180000 */  mflo       $v1
    /* 3EB60 8004E360 03110500 */  sra        $v0, $a1, 4
    /* 3EB64 8004E364 21488200 */  addu       $t1, $a0, $v0
    /* 3EB68 8004E368 C0FF0224 */  addiu      $v0, $zero, -0x40
    /* 3EB6C 8004E36C 24102201 */  and        $v0, $t1, $v0
    /* 3EB70 8004E370 00140200 */  sll        $v0, $v0, 16
    /* 3EB74 8004E374 03130200 */  sra        $v0, $v0, 12
    /* 3EB78 8004E378 1A005600 */  div        $zero, $v0, $s6
    /* 3EB7C 8004E37C 0200C016 */  bnez       $s6, .L8004E388
    /* 3EB80 8004E380 00000000 */   nop
    /* 3EB84 8004E384 0D000700 */  break      7
  .L8004E388:
    /* 3EB88 8004E388 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3EB8C 8004E38C 0400C116 */  bne        $s6, $at, .L8004E3A0
    /* 3EB90 8004E390 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3EB94 8004E394 02004114 */  bne        $v0, $at, .L8004E3A0
    /* 3EB98 8004E398 00000000 */   nop
    /* 3EB9C 8004E39C 0D000600 */  break      6
  .L8004E3A0:
    /* 3EBA0 8004E3A0 12100000 */  mflo       $v0
    /* 3EBA4 8004E3A4 21182302 */  addu       $v1, $s1, $v1
    /* 3EBA8 8004E3A8 23986200 */  subu       $s3, $v1, $v0
    /* 3EBAC 8004E3AC 00141300 */  sll        $v0, $s3, 16
    /* 3EBB0 8004E3B0 03140200 */  sra        $v0, $v0, 16
    /* 3EBB4 8004E3B4 FF000324 */  addiu      $v1, $zero, 0xFF
    /* 3EBB8 8004E3B8 23386200 */  subu       $a3, $v1, $v0
    /* 3EBBC 8004E3BC 23180601 */  subu       $v1, $t0, $a2
    /* 3EBC0 8004E3C0 2A106700 */  slt        $v0, $v1, $a3
    /* 3EBC4 8004E3C4 02004010 */  beqz       $v0, .L8004E3D0
    /* 3EBC8 8004E3C8 21906002 */   addu      $s2, $s3, $zero
    /* 3EBCC 8004E3CC 21386000 */  addu       $a3, $v1, $zero
  .L8004E3D0:
    /* 3EBD0 8004E3D0 801F063C */  lui        $a2, (0x1F800004 >> 16)
    /* 3EBD4 8004E3D4 0400C634 */  ori        $a2, $a2, (0x1F800004 & 0xFFFF)
    /* 3EBD8 8004E3D8 00FF053C */  lui        $a1, (0xFF000000 >> 16)
    /* 3EBDC 8004E3DC 0000D08C */  lw         $s0, 0x0($a2)
    /* 3EBE0 8004E3E0 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* 3EBE4 8004E3E4 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* 3EBE8 8004E3E8 0000038E */  lw         $v1, 0x0($s0)
    /* 3EBEC 8004E3EC 0000828C */  lw         $v0, 0x0($a0)
    /* 3EBF0 8004E3F0 24186500 */  and        $v1, $v1, $a1
    /* 3EBF4 8004E3F4 24104B00 */  and        $v0, $v0, $t3
    /* 3EBF8 8004E3F8 25186200 */  or         $v1, $v1, $v0
    /* 3EBFC 8004E3FC 000003AE */  sw         $v1, 0x0($s0)
    /* 3EC00 8004E400 0000838C */  lw         $v1, 0x0($a0)
    /* 3EC04 8004E404 34000226 */  addiu      $v0, $s0, 0x34
    /* 3EC08 8004E408 0000C2AC */  sw         $v0, 0x0($a2)
    /* 3EC0C 8004E40C 24100B02 */  and        $v0, $s0, $t3
    /* 3EC10 8004E410 24186500 */  and        $v1, $v1, $a1
    /* 3EC14 8004E414 25186200 */  or         $v1, $v1, $v0
    /* 3EC18 8004E418 000083AC */  sw         $v1, 0x0($a0)
    /* 3EC1C 8004E41C 0000A28D */  lw         $v0, 0x0($t5)
    /* 3EC20 8004E420 00000000 */  nop
    /* 3EC24 8004E424 040002AE */  sw         $v0, 0x4($s0)
    /* 3EC28 8004E428 0400A28D */  lw         $v0, 0x4($t5)
    /* 3EC2C 8004E42C 00000000 */  nop
    /* 3EC30 8004E430 100002AE */  sw         $v0, 0x10($s0)
    /* 3EC34 8004E434 0800A28D */  lw         $v0, 0x8($t5)
    /* 3EC38 8004E438 00000000 */  nop
    /* 3EC3C 8004E43C 1C0002AE */  sw         $v0, 0x1C($s0)
    /* 3EC40 8004E440 0100C231 */  andi       $v0, $t6, 0x1
    /* 3EC44 8004E444 40100200 */  sll        $v0, $v0, 1
    /* 3EC48 8004E448 0C00A38D */  lw         $v1, 0xC($t5)
    /* 3EC4C 8004E44C 3C004224 */  addiu      $v0, $v0, 0x3C
    /* 3EC50 8004E450 070002A2 */  sb         $v0, 0x7($s0)
    /* 3EC54 8004E454 0C000224 */  addiu      $v0, $zero, 0xC
    /* 3EC58 8004E458 030002A2 */  sb         $v0, 0x3($s0)
    /* 3EC5C 8004E45C 280003AE */  sw         $v1, 0x28($s0)
    /* 3EC60 8004E460 0400858E */  lw         $a1, 0x4($s4)
    /* 3EC64 8004E464 21A8E000 */  addu       $s5, $a3, $zero
    /* 3EC68 8004E468 2800A9AF */  sw         $t1, 0x28($sp)
    /* 3EC6C 8004E46C 2C00AAAF */  sw         $t2, 0x2C($sp)
    /* 3EC70 8004E470 3000ABAF */  sw         $t3, 0x30($sp)
    /* 3EC74 8004E474 3400ACAF */  sw         $t4, 0x34($sp)
    /* 3EC78 8004E478 3800ADAF */  sw         $t5, 0x38($sp)
    /* 3EC7C 8004E47C 3C00AEAF */  sw         $t6, 0x3C($sp)
    /* 3EC80 8004E480 3F00A430 */  andi       $a0, $a1, 0x3F
    /* 3EC84 8004E484 00210400 */  sll        $a0, $a0, 4
    /* 3EC88 8004E488 14D1030C */  jal        GetClut
    /* 3EC8C 8004E48C 83290500 */   sra       $a1, $a1, 6
    /* 3EC90 8004E490 0E0002A6 */  sh         $v0, 0xE($s0)
    /* 3EC94 8004E494 09008392 */  lbu        $v1, 0x9($s4)
    /* 3EC98 8004E498 7C00AF8F */  lw         $t7, 0x7C($sp)
    /* 3EC9C 8004E49C 1A008496 */  lhu        $a0, 0x1A($s4)
    /* 3ECA0 8004E4A0 2800A98F */  lw         $t1, 0x28($sp)
    /* 3ECA4 8004E4A4 03006330 */  andi       $v1, $v1, 0x3
    /* 3ECA8 8004E4A8 C0190300 */  sll        $v1, $v1, 7
    /* 3ECAC 8004E4AC 0300E231 */  andi       $v0, $t7, 0x3
    /* 3ECB0 8004E4B0 40110200 */  sll        $v0, $v0, 5
    /* 3ECB4 8004E4B4 25186200 */  or         $v1, $v1, $v0
    /* 3ECB8 8004E4B8 00018230 */  andi       $v0, $a0, 0x100
    /* 3ECBC 8004E4BC 00140200 */  sll        $v0, $v0, 16
    /* 3ECC0 8004E4C0 03150200 */  sra        $v0, $v0, 20
    /* 3ECC4 8004E4C4 25186200 */  or         $v1, $v1, $v0
    /* 3ECC8 8004E4C8 C0032231 */  andi       $v0, $t1, 0x3C0
    /* 3ECCC 8004E4CC 82110200 */  srl        $v0, $v0, 6
    /* 3ECD0 8004E4D0 25186200 */  or         $v1, $v1, $v0
    /* 3ECD4 8004E4D4 00028430 */  andi       $a0, $a0, 0x200
    /* 3ECD8 8004E4D8 80200400 */  sll        $a0, $a0, 2
    /* 3ECDC 8004E4DC 25186400 */  or         $v1, $v1, $a0
    /* 3ECE0 8004E4E0 1A0003A6 */  sh         $v1, 0x1A($s0)
    /* 3ECE4 8004E4E4 3C00AE8F */  lw         $t6, 0x3C($sp)
    /* 3ECE8 8004E4E8 2C00AA8F */  lw         $t2, 0x2C($sp)
    /* 3ECEC 8004E4EC 3000AB8F */  lw         $t3, 0x30($sp)
    /* 3ECF0 8004E4F0 3400AC8F */  lw         $t4, 0x34($sp)
    /* 3ECF4 8004E4F4 3800AD8F */  lw         $t5, 0x38($sp)
    /* 3ECF8 8004E4F8 0400C231 */  andi       $v0, $t6, 0x4
    /* 3ECFC 8004E4FC 08004010 */  beqz       $v0, .L8004E520
    /* 3ED00 8004E500 21300000 */   addu      $a2, $zero, $zero
    /* 3ED04 8004E504 10008286 */  lh         $v0, 0x10($s4)
    /* 3ED08 8004E508 00000000 */  nop
    /* 3ED0C 8004E50C FF004228 */  slti       $v0, $v0, 0xFF
    /* 3ED10 8004E510 04004010 */  beqz       $v0, .L8004E524
    /* 3ED14 8004E514 2128A002 */   addu      $a1, $s5, $zero
    /* 3ED18 8004E518 FFFF7226 */  addiu      $s2, $s3, -0x1
    /* 3ED1C 8004E51C 01000624 */  addiu      $a2, $zero, 0x1
  .L8004E520:
    /* 3ED20 8004E520 2128A002 */  addu       $a1, $s5, $zero
  .L8004E524:
    /* 3ED24 8004E524 21184502 */  addu       $v1, $s2, $a1
    /* 3ED28 8004E528 0C0012A2 */  sb         $s2, 0xC($s0)
    /* 3ED2C 8004E52C 0D000CA2 */  sb         $t4, 0xD($s0)
    /* 3ED30 8004E530 180003A2 */  sb         $v1, 0x18($s0)
    /* 3ED34 8004E534 19000CA2 */  sb         $t4, 0x19($s0)
    /* 3ED38 8004E538 240012A2 */  sb         $s2, 0x24($s0)
    /* 3ED3C 8004E53C 1800B897 */  lhu        $t8, 0x18($sp)
    /* 3ED40 8004E540 2000AF93 */  lbu        $t7, 0x20($sp)
    /* 3ED44 8004E544 300003A2 */  sb         $v1, 0x30($s0)
    /* 3ED48 8004E548 21100F03 */  addu       $v0, $t8, $t7
    /* 3ED4C 8004E54C 250002A2 */  sb         $v0, 0x25($s0)
    /* 3ED50 8004E550 310002A2 */  sb         $v0, 0x31($s0)
    /* 3ED54 8004E554 00140500 */  sll        $v0, $a1, 16
    /* 3ED58 8004E558 0200401C */  bgtz       $v0, .L8004E564
    /* 3ED5C 8004E55C 0400C231 */   andi      $v0, $t6, 0x4
    /* 3ED60 8004E560 01000524 */  addiu      $a1, $zero, 0x1
  .L8004E564:
    /* 3ED64 8004E564 1C004010 */  beqz       $v0, .L8004E5D8
    /* 3ED68 8004E568 FFFFC324 */   addiu     $v1, $a2, -0x1
    /* 3ED6C 8004E56C 1000B897 */  lhu        $t8, 0x10($sp)
    /* 3ED70 8004E570 00000000 */  nop
    /* 3ED74 8004E574 21100A03 */  addu       $v0, $t8, $t2
    /* 3ED78 8004E578 23105100 */  subu       $v0, $v0, $s1
    /* 3ED7C 8004E57C 21104300 */  addu       $v0, $v0, $v1
    /* 3ED80 8004E580 080002A6 */  sh         $v0, 0x8($s0)
    /* 3ED84 8004E584 0A0017A6 */  sh         $s7, 0xA($s0)
    /* 3ED88 8004E588 10008296 */  lhu        $v0, 0x10($s4)
    /* 3ED8C 8004E58C 21202502 */  addu       $a0, $s1, $a1
    /* 3ED90 8004E590 160017A6 */  sh         $s7, 0x16($s0)
    /* 3ED94 8004E594 21104A00 */  addu       $v0, $v0, $t2
    /* 3ED98 8004E598 23104400 */  subu       $v0, $v0, $a0
    /* 3ED9C 8004E59C 21104300 */  addu       $v0, $v0, $v1
    /* 3EDA0 8004E5A0 140002A6 */  sh         $v0, 0x14($s0)
    /* 3EDA4 8004E5A4 10008296 */  lhu        $v0, 0x10($s4)
    /* 3EDA8 8004E5A8 22001EA6 */  sh         $fp, 0x22($s0)
    /* 3EDAC 8004E5AC 21104A00 */  addu       $v0, $v0, $t2
    /* 3EDB0 8004E5B0 23105100 */  subu       $v0, $v0, $s1
    /* 3EDB4 8004E5B4 21104300 */  addu       $v0, $v0, $v1
    /* 3EDB8 8004E5B8 200002A6 */  sh         $v0, 0x20($s0)
    /* 3EDBC 8004E5BC 10008296 */  lhu        $v0, 0x10($s4)
    /* 3EDC0 8004E5C0 2E001EA6 */  sh         $fp, 0x2E($s0)
    /* 3EDC4 8004E5C4 21104A00 */  addu       $v0, $v0, $t2
    /* 3EDC8 8004E5C8 23104400 */  subu       $v0, $v0, $a0
    /* 3EDCC 8004E5CC 21104300 */  addu       $v0, $v0, $v1
    /* 3EDD0 8004E5D0 80390108 */  j          .L8004E600
    /* 3EDD4 8004E5D4 2C0002A6 */   sh        $v0, 0x2C($s0)
  .L8004E5D8:
    /* 3EDD8 8004E5D8 21102A02 */  addu       $v0, $s1, $t2
    /* 3EDDC 8004E5DC 2118A200 */  addu       $v1, $a1, $v0
    /* 3EDE0 8004E5E0 080002A6 */  sh         $v0, 0x8($s0)
    /* 3EDE4 8004E5E4 0A0017A6 */  sh         $s7, 0xA($s0)
    /* 3EDE8 8004E5E8 140003A6 */  sh         $v1, 0x14($s0)
    /* 3EDEC 8004E5EC 160017A6 */  sh         $s7, 0x16($s0)
    /* 3EDF0 8004E5F0 200002A6 */  sh         $v0, 0x20($s0)
    /* 3EDF4 8004E5F4 22001EA6 */  sh         $fp, 0x22($s0)
    /* 3EDF8 8004E5F8 2C0003A6 */  sh         $v1, 0x2C($s0)
    /* 3EDFC 8004E5FC 2E001EA6 */  sh         $fp, 0x2E($s0)
  .L8004E600:
    /* 3EE00 8004E600 BF380108 */  j          .L8004E2FC
    /* 3EE04 8004E604 21882502 */   addu      $s1, $s1, $a1
  .L8004E608:
    /* 3EE08 8004E608 6400BF8F */  lw         $ra, 0x64($sp)
    /* 3EE0C 8004E60C 6000BE8F */  lw         $fp, 0x60($sp)
    /* 3EE10 8004E610 5C00B78F */  lw         $s7, 0x5C($sp)
    /* 3EE14 8004E614 5800B68F */  lw         $s6, 0x58($sp)
    /* 3EE18 8004E618 5400B58F */  lw         $s5, 0x54($sp)
    /* 3EE1C 8004E61C 5000B48F */  lw         $s4, 0x50($sp)
    /* 3EE20 8004E620 4C00B38F */  lw         $s3, 0x4C($sp)
    /* 3EE24 8004E624 4800B28F */  lw         $s2, 0x48($sp)
    /* 3EE28 8004E628 4400B18F */  lw         $s1, 0x44($sp)
    /* 3EE2C 8004E62C 4000B08F */  lw         $s0, 0x40($sp)
    /* 3EE30 8004E630 0800E003 */  jr         $ra
    /* 3EE34 8004E634 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii
