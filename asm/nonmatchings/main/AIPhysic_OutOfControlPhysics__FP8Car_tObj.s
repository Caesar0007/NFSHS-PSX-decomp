.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_OutOfControlPhysics__FP8Car_tObj, 0x670

glabel AIPhysic_OutOfControlPhysics__FP8Car_tObj
    /* 5BC00 8006B400 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5BC04 8006B404 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5BC08 8006B408 21888000 */  addu       $s1, $a0, $zero
    /* 5BC0C 8006B40C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 5BC10 8006B410 2400B5AF */  sw         $s5, 0x24($sp)
    /* 5BC14 8006B414 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5BC18 8006B418 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5BC1C 8006B41C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5BC20 8006B420 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5BC24 8006B424 5405228E */  lw         $v0, 0x554($s1)
    /* 5BC28 8006B428 1180103C */  lui        $s0, %hi(AIPhysicConfig)
    /* 5BC2C 8006B42C 340720AE */  sw         $zero, 0x734($s1)
    /* 5BC30 8006B430 74DC058E */  lw         $a1, %lo(AIPhysicConfig)($s0)
    /* 5BC34 8006B434 00000000 */  nop
    /* 5BC38 8006B438 18004500 */  mult       $v0, $a1
    /* 5BC3C 8006B43C 12280000 */  mflo       $a1
    /* 5BC40 8006B440 EFCD010C */  jal        AIWorld_CalcFutureLateralVel__FP8Car_tObji
    /* 5BC44 8006B444 21A00000 */   addu      $s4, $zero, $zero
    /* 5BC48 8006B448 5405248E */  lw         $a0, 0x554($s1)
    /* 5BC4C 8006B44C 6405238E */  lw         $v1, 0x564($s1)
    /* 5BC50 8006B450 00000000 */  nop
    /* 5BC54 8006B454 18008300 */  mult       $a0, $v1
    /* 5BC58 8006B458 12180000 */  mflo       $v1
    /* 5BC5C 8006B45C 05006104 */  bgez       $v1, .L8006B474
    /* 5BC60 8006B460 21A84000 */   addu      $s5, $v0, $zero
    /* 5BC64 8006B464 F006228E */  lw         $v0, 0x6F0($s1)
    /* 5BC68 8006B468 00000000 */  nop
    /* 5BC6C 8006B46C 27100200 */  nor        $v0, $zero, $v0
    /* 5BC70 8006B470 2BA08202 */  sltu       $s4, $s4, $v0
  .L8006B474:
    /* 5BC74 8006B474 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 5BC78 8006B478 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 5BC7C 8006B47C 74DC1026 */  addiu      $s0, $s0, %lo(AIPhysicConfig)
    /* 5BC80 8006B480 480722AE */  sw         $v0, 0x748($s1)
    /* 5BC84 8006B484 5000058E */  lw         $a1, 0x50($s0)
    /* 5BC88 8006B488 CA90030C */  jal        fixedmult
    /* 5BC8C 8006B48C 80000424 */   addiu     $a0, $zero, 0x80
    /* 5BC90 8006B490 DC06238E */  lw         $v1, 0x6DC($s1)
    /* 5BC94 8006B494 00000000 */  nop
    /* 5BC98 8006B498 23180300 */  negu       $v1, $v1
    /* 5BC9C 8006B49C 18006200 */  mult       $v1, $v0
    /* 5BCA0 8006B4A0 5400038E */  lw         $v1, 0x54($s0)
    /* 5BCA4 8006B4A4 12280000 */  mflo       $a1
    /* 5BCA8 8006B4A8 2A10A300 */  slt        $v0, $a1, $v1
    /* 5BCAC 8006B4AC 02004010 */  beqz       $v0, .L8006B4B8
    /* 5BCB0 8006B4B0 00000000 */   nop
    /* 5BCB4 8006B4B4 2118A000 */  addu       $v1, $a1, $zero
  .L8006B4B8:
    /* 5BCB8 8006B4B8 5400028E */  lw         $v0, 0x54($s0)
    /* 5BCBC 8006B4BC 21286000 */  addu       $a1, $v1, $zero
    /* 5BCC0 8006B4C0 23180200 */  negu       $v1, $v0
    /* 5BCC4 8006B4C4 2A106500 */  slt        $v0, $v1, $a1
    /* 5BCC8 8006B4C8 02004010 */  beqz       $v0, .L8006B4D4
    /* 5BCCC 8006B4CC 00000000 */   nop
    /* 5BCD0 8006B4D0 2118A000 */  addu       $v1, $a1, $zero
  .L8006B4D4:
    /* 5BCD4 8006B4D4 21286000 */  addu       $a1, $v1, $zero
    /* 5BCD8 8006B4D8 0200A104 */  bgez       $a1, .L8006B4E4
    /* 5BCDC 8006B4DC 2110A000 */   addu      $v0, $a1, $zero
    /* 5BCE0 8006B4E0 FF00A224 */  addiu      $v0, $a1, 0xFF
  .L8006B4E4:
    /* 5BCE4 8006B4E4 4400048E */  lw         $a0, 0x44($s0)
    /* 5BCE8 8006B4E8 03120200 */  sra        $v0, $v0, 8
    /* 5BCEC 8006B4EC 80180200 */  sll        $v1, $v0, 2
    /* 5BCF0 8006B4F0 21186200 */  addu       $v1, $v1, $v0
    /* 5BCF4 8006B4F4 40320300 */  sll        $a2, $v1, 9
    /* 5BCF8 8006B4F8 2A10C400 */  slt        $v0, $a2, $a0
    /* 5BCFC 8006B4FC 02004010 */  beqz       $v0, .L8006B508
    /* 5BD00 8006B500 00000000 */   nop
    /* 5BD04 8006B504 2120C000 */  addu       $a0, $a2, $zero
  .L8006B508:
    /* 5BD08 8006B508 4400028E */  lw         $v0, 0x44($s0)
    /* 5BD0C 8006B50C 21308000 */  addu       $a2, $a0, $zero
    /* 5BD10 8006B510 23180200 */  negu       $v1, $v0
    /* 5BD14 8006B514 2A106600 */  slt        $v0, $v1, $a2
    /* 5BD18 8006B518 02004010 */  beqz       $v0, .L8006B524
    /* 5BD1C 8006B51C 00000000 */   nop
    /* 5BD20 8006B520 2118C000 */  addu       $v1, $a2, $zero
  .L8006B524:
    /* 5BD24 8006B524 6805248E */  lw         $a0, 0x568($s1)
    /* 5BD28 8006B528 21306000 */  addu       $a2, $v1, $zero
    /* 5BD2C 8006B52C 2A10C400 */  slt        $v0, $a2, $a0
    /* 5BD30 8006B530 02004010 */  beqz       $v0, .L8006B53C
    /* 5BD34 8006B534 00000000 */   nop
    /* 5BD38 8006B538 2120C000 */  addu       $a0, $a2, $zero
  .L8006B53C:
    /* 5BD3C 8006B53C 6805278E */  lw         $a3, 0x568($s1)
    /* 5BD40 8006B540 21308000 */  addu       $a2, $a0, $zero
    /* 5BD44 8006B544 23180700 */  negu       $v1, $a3
    /* 5BD48 8006B548 2A106600 */  slt        $v0, $v1, $a2
    /* 5BD4C 8006B54C 02004010 */  beqz       $v0, .L8006B558
    /* 5BD50 8006B550 00000000 */   nop
    /* 5BD54 8006B554 2118C000 */  addu       $v1, $a2, $zero
  .L8006B558:
    /* 5BD58 8006B558 21306000 */  addu       $a2, $v1, $zero
    /* 5BD5C 8006B55C 6000048E */  lw         $a0, 0x60($s0)
    /* 5BD60 8006B560 6405238E */  lw         $v1, 0x564($s1)
    /* 5BD64 8006B564 23100400 */  negu       $v0, $a0
    /* 5BD68 8006B568 2A104300 */  slt        $v0, $v0, $v1
    /* 5BD6C 8006B56C 31004010 */  beqz       $v0, .L8006B634
    /* 5BD70 8006B570 2A106400 */   slt       $v0, $v1, $a0
    /* 5BD74 8006B574 2F004010 */  beqz       $v0, .L8006B634
    /* 5BD78 8006B578 00000000 */   nop
    /* 5BD7C 8006B57C 0200E104 */  bgez       $a3, .L8006B588
    /* 5BD80 8006B580 2118E000 */   addu      $v1, $a3, $zero
    /* 5BD84 8006B584 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L8006B588:
    /* 5BD88 8006B588 6400028E */  lw         $v0, 0x64($s0)
    /* 5BD8C 8006B58C 00000000 */  nop
    /* 5BD90 8006B590 02004104 */  bgez       $v0, .L8006B59C
    /* 5BD94 8006B594 03420300 */   sra       $t0, $v1, 8
    /* 5BD98 8006B598 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006B59C:
    /* 5BD9C 8006B59C 03120200 */  sra        $v0, $v0, 8
    /* 5BDA0 8006B5A0 18000201 */  mult       $t0, $v0
    /* 5BDA4 8006B5A4 12180000 */  mflo       $v1
    /* 5BDA8 8006B5A8 02006104 */  bgez       $v1, .L8006B5B4
    /* 5BDAC 8006B5AC 00000000 */   nop
    /* 5BDB0 8006B5B0 23180300 */  negu       $v1, $v1
  .L8006B5B4:
    /* 5BDB4 8006B5B4 2A10C300 */  slt        $v0, $a2, $v1
    /* 5BDB8 8006B5B8 02004010 */  beqz       $v0, .L8006B5C4
    /* 5BDBC 8006B5BC 21206000 */   addu      $a0, $v1, $zero
    /* 5BDC0 8006B5C0 2120C000 */  addu       $a0, $a2, $zero
  .L8006B5C4:
    /* 5BDC4 8006B5C4 21308000 */  addu       $a2, $a0, $zero
    /* 5BDC8 8006B5C8 23180300 */  negu       $v1, $v1
    /* 5BDCC 8006B5CC 2A106600 */  slt        $v0, $v1, $a2
    /* 5BDD0 8006B5D0 02004010 */  beqz       $v0, .L8006B5DC
    /* 5BDD4 8006B5D4 00000000 */   nop
    /* 5BDD8 8006B5D8 2118C000 */  addu       $v1, $a2, $zero
  .L8006B5DC:
    /* 5BDDC 8006B5DC 6800028E */  lw         $v0, 0x68($s0)
    /* 5BDE0 8006B5E0 00000000 */  nop
    /* 5BDE4 8006B5E4 02004104 */  bgez       $v0, .L8006B5F0
    /* 5BDE8 8006B5E8 21306000 */   addu      $a2, $v1, $zero
    /* 5BDEC 8006B5EC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006B5F0:
    /* 5BDF0 8006B5F0 03120200 */  sra        $v0, $v0, 8
    /* 5BDF4 8006B5F4 18000201 */  mult       $t0, $v0
    /* 5BDF8 8006B5F8 12180000 */  mflo       $v1
    /* 5BDFC 8006B5FC 02006104 */  bgez       $v1, .L8006B608
    /* 5BE00 8006B600 00000000 */   nop
    /* 5BE04 8006B604 23180300 */  negu       $v1, $v1
  .L8006B608:
    /* 5BE08 8006B608 2A10A300 */  slt        $v0, $a1, $v1
    /* 5BE0C 8006B60C 02004010 */  beqz       $v0, .L8006B618
    /* 5BE10 8006B610 21206000 */   addu      $a0, $v1, $zero
    /* 5BE14 8006B614 2120A000 */  addu       $a0, $a1, $zero
  .L8006B618:
    /* 5BE18 8006B618 21288000 */  addu       $a1, $a0, $zero
    /* 5BE1C 8006B61C 23180300 */  negu       $v1, $v1
    /* 5BE20 8006B620 2A106500 */  slt        $v0, $v1, $a1
    /* 5BE24 8006B624 02004010 */  beqz       $v0, .L8006B630
    /* 5BE28 8006B628 00000000 */   nop
    /* 5BE2C 8006B62C 2118A000 */  addu       $v1, $a1, $zero
  .L8006B630:
    /* 5BE30 8006B630 21286000 */  addu       $a1, $v1, $zero
  .L8006B634:
    /* 5BE34 8006B634 5007238E */  lw         $v1, 0x750($s1)
    /* 5BE38 8006B638 02000224 */  addiu      $v0, $zero, 0x2
    /* 5BE3C 8006B63C 02006214 */  bne        $v1, $v0, .L8006B648
    /* 5BE40 8006B640 04104500 */   sllv      $v0, $a1, $v0
    /* 5BE44 8006B644 2128A200 */  addu       $a1, $a1, $v0
  .L8006B648:
    /* 5BE48 8006B648 2804228E */  lw         $v0, 0x428($s1)
    /* 5BE4C 8006B64C 00000000 */  nop
    /* 5BE50 8006B650 23184500 */  subu       $v1, $v0, $a1
    /* 5BE54 8006B654 02006104 */  bgez       $v1, .L8006B660
    /* 5BE58 8006B658 1180023C */   lui       $v0, %hi(AIPhysicConfig)
    /* 5BE5C 8006B65C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006B660:
    /* 5BE60 8006B660 74DC4524 */  addiu      $a1, $v0, %lo(AIPhysicConfig)
    /* 5BE64 8006B664 5800A28C */  lw         $v0, 0x58($a1)
    /* 5BE68 8006B668 00000000 */  nop
    /* 5BE6C 8006B66C 02004104 */  bgez       $v0, .L8006B678
    /* 5BE70 8006B670 031A0300 */   sra       $v1, $v1, 8
    /* 5BE74 8006B674 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006B678:
    /* 5BE78 8006B678 03120200 */  sra        $v0, $v0, 8
    /* 5BE7C 8006B67C 18006200 */  mult       $v1, $v0
    /* 5BE80 8006B680 6405238E */  lw         $v1, 0x564($s1)
    /* 5BE84 8006B684 1200023C */  lui        $v0, (0x120000 >> 16)
    /* 5BE88 8006B688 02006104 */  bgez       $v1, .L8006B694
    /* 5BE8C 8006B68C 00000000 */   nop
    /* 5BE90 8006B690 23180300 */  negu       $v1, $v1
  .L8006B694:
    /* 5BE94 8006B694 2A104300 */  slt        $v0, $v0, $v1
    /* 5BE98 8006B698 12480000 */  mflo       $t1
    /* 5BE9C 8006B69C 04004010 */  beqz       $v0, .L8006B6B0
    /* 5BEA0 8006B6A0 23900900 */   negu      $s2, $t1
    /* 5BEA4 8006B6A4 C2171200 */  srl        $v0, $s2, 31
    /* 5BEA8 8006B6A8 21104202 */  addu       $v0, $s2, $v0
    /* 5BEAC 8006B6AC 43900200 */  sra        $s2, $v0, 1
  .L8006B6B0:
    /* 5BEB0 8006B6B0 2C07238E */  lw         $v1, 0x72C($s1)
    /* 5BEB4 8006B6B4 00000000 */  nop
    /* 5BEB8 8006B6B8 2A104302 */  slt        $v0, $s2, $v1
    /* 5BEBC 8006B6BC 02004010 */  beqz       $v0, .L8006B6C8
    /* 5BEC0 8006B6C0 00000000 */   nop
    /* 5BEC4 8006B6C4 21184002 */  addu       $v1, $s2, $zero
  .L8006B6C8:
    /* 5BEC8 8006B6C8 2C07228E */  lw         $v0, 0x72C($s1)
    /* 5BECC 8006B6CC 21906000 */  addu       $s2, $v1, $zero
    /* 5BED0 8006B6D0 23180200 */  negu       $v1, $v0
    /* 5BED4 8006B6D4 2A107200 */  slt        $v0, $v1, $s2
    /* 5BED8 8006B6D8 02004010 */  beqz       $v0, .L8006B6E4
    /* 5BEDC 8006B6DC 00000000 */   nop
    /* 5BEE0 8006B6E0 21184002 */  addu       $v1, $s2, $zero
  .L8006B6E4:
    /* 5BEE4 8006B6E4 1804228E */  lw         $v0, 0x418($s1)
    /* 5BEE8 8006B6E8 00000000 */  nop
    /* 5BEEC 8006B6EC 23104600 */  subu       $v0, $v0, $a2
    /* 5BEF0 8006B6F0 02004104 */  bgez       $v0, .L8006B6FC
    /* 5BEF4 8006B6F4 21906000 */   addu      $s2, $v1, $zero
    /* 5BEF8 8006B6F8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006B6FC:
    /* 5BEFC 8006B6FC 4800A48C */  lw         $a0, 0x48($a1)
    /* 5BF00 8006B700 00000000 */  nop
    /* 5BF04 8006B704 02008104 */  bgez       $a0, .L8006B710
    /* 5BF08 8006B708 031A0200 */   sra       $v1, $v0, 8
    /* 5BF0C 8006B70C FF008424 */  addiu      $a0, $a0, 0xFF
  .L8006B710:
    /* 5BF10 8006B710 03120400 */  sra        $v0, $a0, 8
    /* 5BF14 8006B714 18006200 */  mult       $v1, $v0
    /* 5BF18 8006B718 2807238E */  lw         $v1, 0x728($s1)
    /* 5BF1C 8006B71C 12480000 */  mflo       $t1
    /* 5BF20 8006B720 23980900 */  negu       $s3, $t1
    /* 5BF24 8006B724 2A106302 */  slt        $v0, $s3, $v1
    /* 5BF28 8006B728 02004010 */  beqz       $v0, .L8006B734
    /* 5BF2C 8006B72C 00000000 */   nop
    /* 5BF30 8006B730 21186002 */  addu       $v1, $s3, $zero
  .L8006B734:
    /* 5BF34 8006B734 2807228E */  lw         $v0, 0x728($s1)
    /* 5BF38 8006B738 21986000 */  addu       $s3, $v1, $zero
    /* 5BF3C 8006B73C 23180200 */  negu       $v1, $v0
    /* 5BF40 8006B740 2A107300 */  slt        $v0, $v1, $s3
    /* 5BF44 8006B744 02004010 */  beqz       $v0, .L8006B750
    /* 5BF48 8006B748 00000000 */   nop
    /* 5BF4C 8006B74C 21186002 */  addu       $v1, $s3, $zero
  .L8006B750:
    /* 5BF50 8006B750 21986000 */  addu       $s3, $v1, $zero
    /* 5BF54 8006B754 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 5BF58 8006B758 F006228E */  lw         $v0, 0x6F0($s1)
    /* 5BF5C 8006B75C 2004248E */  lw         $a0, 0x420($s1)
    /* 5BF60 8006B760 10004314 */  bne        $v0, $v1, .L8006B7A4
    /* 5BF64 8006B764 00000000 */   nop
    /* 5BF68 8006B768 0807228E */  lw         $v0, 0x708($s1)
    /* 5BF6C 8006B76C 00000000 */  nop
    /* 5BF70 8006B770 0C004014 */  bnez       $v0, .L8006B7A4
    /* 5BF74 8006B774 00000000 */   nop
    /* 5BF78 8006B778 0C07228E */  lw         $v0, 0x70C($s1)
    /* 5BF7C 8006B77C 00000000 */  nop
    /* 5BF80 8006B780 08004014 */  bnez       $v0, .L8006B7A4
    /* 5BF84 8006B784 00000000 */   nop
    /* 5BF88 8006B788 1007228E */  lw         $v0, 0x710($s1)
    /* 5BF8C 8006B78C 00000000 */  nop
    /* 5BF90 8006B790 04004014 */  bnez       $v0, .L8006B7A4
    /* 5BF94 8006B794 00000000 */   nop
    /* 5BF98 8006B798 6000A28C */  lw         $v0, 0x60($a1)
    /* 5BF9C 8006B79C F2AD0108 */  j          .L8006B7C8
    /* 5BFA0 8006B7A0 23180200 */   negu      $v1, $v0
  .L8006B7A4:
    /* 5BFA4 8006B7A4 5C05238E */  lw         $v1, 0x55C($s1)
    /* 5BFA8 8006B7A8 5405228E */  lw         $v0, 0x554($s1)
    /* 5BFAC 8006B7AC 00000000 */  nop
    /* 5BFB0 8006B7B0 18006200 */  mult       $v1, $v0
    /* 5BFB4 8006B7B4 12180000 */  mflo       $v1
    /* 5BFB8 8006B7B8 F006228E */  lw         $v0, 0x6F0($s1)
    /* 5BFBC 8006B7BC 00000000 */  nop
    /* 5BFC0 8006B7C0 18006200 */  mult       $v1, $v0
    /* 5BFC4 8006B7C4 12180000 */  mflo       $v1
  .L8006B7C8:
    /* 5BFC8 8006B7C8 7802228E */  lw         $v0, 0x278($s1)
    /* 5BFCC 8006B7CC 00000000 */  nop
    /* 5BFD0 8006B7D0 2E004014 */  bnez       $v0, .L8006B88C
    /* 5BFD4 8006B7D4 00000000 */   nop
    /* 5BFD8 8006B7D8 08006004 */  bltz       $v1, .L8006B7FC
    /* 5BFDC 8006B7DC FEFF023C */   lui       $v0, (0xFFFE0000 >> 16)
    /* 5BFE0 8006B7E0 2A108200 */  slt        $v0, $a0, $v0
    /* 5BFE4 8006B7E4 29004014 */  bnez       $v0, .L8006B88C
    /* 5BFE8 8006B7E8 2A106400 */   slt       $v0, $v1, $a0
    /* 5BFEC 8006B7EC 09004010 */  beqz       $v0, .L8006B814
    /* 5BFF0 8006B7F0 00000000 */   nop
    /* 5BFF4 8006B7F4 23AE0108 */  j          .L8006B88C
    /* 5BFF8 8006B7F8 00000000 */   nop
  .L8006B7FC:
    /* 5BFFC 8006B7FC 2A108300 */  slt        $v0, $a0, $v1
    /* 5C000 8006B800 22004014 */  bnez       $v0, .L8006B88C
    /* 5C004 8006B804 0200023C */   lui       $v0, (0x20000 >> 16)
    /* 5C008 8006B808 2A104400 */  slt        $v0, $v0, $a0
    /* 5C00C 8006B80C 1F004014 */  bnez       $v0, .L8006B88C
    /* 5C010 8006B810 00000000 */   nop
  .L8006B814:
    /* 5C014 8006B814 5005238E */  lw         $v1, 0x550($s1)
    /* 5C018 8006B818 5405228E */  lw         $v0, 0x554($s1)
    /* 5C01C 8006B81C 00000000 */  nop
    /* 5C020 8006B820 1A006214 */  bne        $v1, $v0, .L8006B88C
    /* 5C024 8006B824 00000000 */   nop
    /* 5C028 8006B828 2004258E */  lw         $a1, 0x420($s1)
    /* 5C02C 8006B82C ACA5010C */  jal        AIPhysic_CalcAcceleration__FP8Car_tObji
    /* 5C030 8006B830 21202002 */   addu      $a0, $s1, $zero
    /* 5C034 8006B834 F006248E */  lw         $a0, 0x6F0($s1)
    /* 5C038 8006B838 00000000 */  nop
    /* 5C03C 8006B83C 18004400 */  mult       $v0, $a0
    /* 5C040 8006B840 40042592 */  lbu        $a1, 0x440($s1)
    /* 5C044 8006B844 5000838F */  lw         $v1, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5C048 8006B848 00000000 */  nop
    /* 5C04C 8006B84C 2A186500 */  slt        $v1, $v1, $a1
    /* 5C050 8006B850 12800000 */  mflo       $s0
    /* 5C054 8006B854 06006010 */  beqz       $v1, .L8006B870
    /* 5C058 8006B858 00000000 */   nop
    /* 5C05C 8006B85C 50008293 */  lbu        $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5C060 8006B860 00000000 */  nop
    /* 5C064 8006B864 2310A200 */  subu       $v0, $a1, $v0
    /* 5C068 8006B868 1DAE0108 */  j          .L8006B874
    /* 5C06C 8006B86C 400422A2 */   sb        $v0, 0x440($s1)
  .L8006B870:
    /* 5C070 8006B870 400420A2 */  sb         $zero, 0x440($s1)
  .L8006B874:
    /* 5C074 8006B874 40042292 */  lbu        $v0, 0x440($s1)
    /* 5C078 8006B878 00000000 */  nop
    /* 5C07C 8006B87C 22004014 */  bnez       $v0, .L8006B908
    /* 5C080 8006B880 00000000 */   nop
    /* 5C084 8006B884 42AE0108 */  j          .L8006B908
    /* 5C088 8006B888 3D0420A2 */   sb        $zero, 0x43D($s1)
  .L8006B88C:
    /* 5C08C 8006B88C 2004228E */  lw         $v0, 0x420($s1)
    /* 5C090 8006B890 00000000 */  nop
    /* 5C094 8006B894 02004104 */  bgez       $v0, .L8006B8A0
    /* 5C098 8006B898 00000000 */   nop
    /* 5C09C 8006B89C 23100200 */  negu       $v0, $v0
  .L8006B8A0:
    /* 5C0A0 8006B8A0 19004018 */  blez       $v0, .L8006B908
    /* 5C0A4 8006B8A4 21800000 */   addu      $s0, $zero, $zero
    /* 5C0A8 8006B8A8 7AA6010C */  jal        AIPhysic_CalcDeceleration__FP8Car_tObj
    /* 5C0AC 8006B8AC 21202002 */   addu      $a0, $s1, $zero
    /* 5C0B0 8006B8B0 23800200 */  negu       $s0, $v0
    /* 5C0B4 8006B8B4 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5C0B8 8006B8B8 40042392 */  lbu        $v1, 0x440($s1)
    /* 5C0BC 8006B8BC 80100200 */  sll        $v0, $v0, 2
    /* 5C0C0 8006B8C0 21186200 */  addu       $v1, $v1, $v0
    /* 5C0C4 8006B8C4 FF006228 */  slti       $v0, $v1, 0xFF
    /* 5C0C8 8006B8C8 03004010 */  beqz       $v0, .L8006B8D8
    /* 5C0CC 8006B8CC FF000224 */   addiu     $v0, $zero, 0xFF
    /* 5C0D0 8006B8D0 37AE0108 */  j          .L8006B8DC
    /* 5C0D4 8006B8D4 400423A2 */   sb        $v1, 0x440($s1)
  .L8006B8D8:
    /* 5C0D8 8006B8D8 400422A2 */  sb         $v0, 0x440($s1)
  .L8006B8DC:
    /* 5C0DC 8006B8DC 40042292 */  lbu        $v0, 0x440($s1)
    /* 5C0E0 8006B8E0 00000000 */  nop
    /* 5C0E4 8006B8E4 0400422C */  sltiu      $v0, $v0, 0x4
    /* 5C0E8 8006B8E8 02004014 */  bnez       $v0, .L8006B8F4
    /* 5C0EC 8006B8EC 01000224 */   addiu     $v0, $zero, 0x1
    /* 5C0F0 8006B8F0 3D0422A2 */  sb         $v0, 0x43D($s1)
  .L8006B8F4:
    /* 5C0F4 8006B8F4 2004228E */  lw         $v0, 0x420($s1)
    /* 5C0F8 8006B8F8 00000000 */  nop
    /* 5C0FC 8006B8FC 02004104 */  bgez       $v0, .L8006B908
    /* 5C100 8006B900 00000000 */   nop
    /* 5C104 8006B904 23801000 */  negu       $s0, $s0
  .L8006B908:
    /* 5C108 8006B908 27008012 */  beqz       $s4, .L8006B9A8
    /* 5C10C 8006B90C EBFF043C */   lui       $a0, (0xFFEBFFFF >> 16)
    /* 5C110 8006B910 FFFF8434 */  ori        $a0, $a0, (0xFFEBFFFF & 0xFFFF)
    /* 5C114 8006B914 1D00033C */  lui        $v1, (0x1DFFFE >> 16)
    /* 5C118 8006B918 6805228E */  lw         $v0, 0x568($s1)
    /* 5C11C 8006B91C FEFF6334 */  ori        $v1, $v1, (0x1DFFFE & 0xFFFF)
    /* 5C120 8006B920 21104400 */  addu       $v0, $v0, $a0
    /* 5C124 8006B924 2B186200 */  sltu       $v1, $v1, $v0
    /* 5C128 8006B928 0A006014 */  bnez       $v1, .L8006B954
    /* 5C12C 8006B92C 00000000 */   nop
    /* 5C130 8006B930 02004106 */  bgez       $s2, .L8006B93C
    /* 5C134 8006B934 21104002 */   addu      $v0, $s2, $zero
    /* 5C138 8006B938 03004226 */  addiu      $v0, $s2, 0x3
  .L8006B93C:
    /* 5C13C 8006B93C 83900200 */  sra        $s2, $v0, 2
    /* 5C140 8006B940 02000106 */  bgez       $s0, .L8006B94C
    /* 5C144 8006B944 21100002 */   addu      $v0, $s0, $zero
    /* 5C148 8006B948 03000226 */  addiu      $v0, $s0, 0x3
  .L8006B94C:
    /* 5C14C 8006B94C 61AE0108 */  j          .L8006B984
    /* 5C150 8006B950 83800200 */   sra       $s0, $v0, 2
  .L8006B954:
    /* 5C154 8006B954 21204002 */  addu       $a0, $s2, $zero
    /* 5C158 8006B958 CA90030C */  jal        fixedmult
    /* 5C15C 8006B95C 00C00534 */   ori       $a1, $zero, 0xC000
    /* 5C160 8006B960 21904000 */  addu       $s2, $v0, $zero
    /* 5C164 8006B964 21180002 */  addu       $v1, $s0, $zero
    /* 5C168 8006B968 C2171000 */  srl        $v0, $s0, 31
    /* 5C16C 8006B96C 21100202 */  addu       $v0, $s0, $v0
    /* 5C170 8006B970 02000106 */  bgez       $s0, .L8006B97C
    /* 5C174 8006B974 43200200 */   sra       $a0, $v0, 1
    /* 5C178 8006B978 03000326 */  addiu      $v1, $s0, 0x3
  .L8006B97C:
    /* 5C17C 8006B97C 83100300 */  sra        $v0, $v1, 2
    /* 5C180 8006B980 21808200 */  addu       $s0, $a0, $v0
  .L8006B984:
    /* 5C184 8006B984 02006106 */  bgez       $s3, .L8006B990
    /* 5C188 8006B988 21186002 */   addu      $v1, $s3, $zero
    /* 5C18C 8006B98C 03006326 */  addiu      $v1, $s3, 0x3
  .L8006B990:
    /* 5C190 8006B990 21106002 */  addu       $v0, $s3, $zero
    /* 5C194 8006B994 02006106 */  bgez       $s3, .L8006B9A0
    /* 5C198 8006B998 83180300 */   sra       $v1, $v1, 2
    /* 5C19C 8006B99C 07006226 */  addiu      $v0, $s3, 0x7
  .L8006B9A0:
    /* 5C1A0 8006B9A0 C3100200 */  sra        $v0, $v0, 3
    /* 5C1A4 8006B9A4 21986200 */  addu       $s3, $v1, $v0
  .L8006B9A8:
    /* 5C1A8 8006B9A8 5405238E */  lw         $v1, 0x554($s1)
    /* 5C1AC 8006B9AC 6405228E */  lw         $v0, 0x564($s1)
    /* 5C1B0 8006B9B0 00000000 */  nop
    /* 5C1B4 8006B9B4 18006200 */  mult       $v1, $v0
    /* 5C1B8 8006B9B8 1180023C */  lui        $v0, %hi(D_8010DC84)
    /* 5C1BC 8006B9BC 84DC438C */  lw         $v1, %lo(D_8010DC84)($v0)
    /* 5C1C0 8006B9C0 0200A106 */  bgez       $s5, .L8006B9CC
    /* 5C1C4 8006B9C4 2110A002 */   addu      $v0, $s5, $zero
    /* 5C1C8 8006B9C8 23100200 */  negu       $v0, $v0
  .L8006B9CC:
    /* 5C1CC 8006B9CC 12480000 */  mflo       $t1
    /* 5C1D0 8006B9D0 07002105 */  bgez       $t1, .L8006B9F0
    /* 5C1D4 8006B9D4 23204300 */   subu      $a0, $v0, $v1
    /* 5C1D8 8006B9D8 0300023C */  lui        $v0, (0x38E38 >> 16)
    /* 5C1DC 8006B9DC 6805238E */  lw         $v1, 0x568($s1)
    /* 5C1E0 8006B9E0 388E4234 */  ori        $v0, $v0, (0x38E38 & 0xFFFF)
    /* 5C1E4 8006B9E4 2A104300 */  slt        $v0, $v0, $v1
    /* 5C1E8 8006B9E8 05004014 */  bnez       $v0, .L8006BA00
    /* 5C1EC 8006B9EC 0A00023C */   lui       $v0, (0xA0000 >> 16)
  .L8006B9F0:
    /* 5C1F0 8006B9F0 5007228E */  lw         $v0, 0x750($s1)
    /* 5C1F4 8006B9F4 00000000 */  nop
    /* 5C1F8 8006B9F8 04004010 */  beqz       $v0, .L8006BA0C
    /* 5C1FC 8006B9FC 0A00023C */   lui       $v0, (0xA0000 >> 16)
  .L8006BA00:
    /* 5C200 8006BA00 840422AE */  sw         $v0, 0x484($s1)
    /* 5C204 8006BA04 8AAE0108 */  j          .L8006BA28
    /* 5C208 8006BA08 880422AE */   sw        $v0, 0x488($s1)
  .L8006BA0C:
    /* 5C20C 8006BA0C 04008018 */  blez       $a0, .L8006BA20
    /* 5C210 8006BA10 00000000 */   nop
    /* 5C214 8006BA14 840424AE */  sw         $a0, 0x484($s1)
    /* 5C218 8006BA18 8AAE0108 */  j          .L8006BA28
    /* 5C21C 8006BA1C 880424AE */   sw        $a0, 0x488($s1)
  .L8006BA20:
    /* 5C220 8006BA20 880420AE */  sw         $zero, 0x488($s1)
    /* 5C224 8006BA24 840420AE */  sw         $zero, 0x484($s1)
  .L8006BA28:
    /* 5C228 8006BA28 0C0433AE */  sw         $s3, 0x40C($s1)
    /* 5C22C 8006BA2C 100420AE */  sw         $zero, 0x410($s1)
    /* 5C230 8006BA30 140430AE */  sw         $s0, 0x414($s1)
    /* 5C234 8006BA34 300420AE */  sw         $zero, 0x430($s1)
    /* 5C238 8006BA38 340420AE */  sw         $zero, 0x434($s1)
    /* 5C23C 8006BA3C 380420AE */  sw         $zero, 0x438($s1)
    /* 5C240 8006BA40 F40320AE */  sw         $zero, 0x3F4($s1)
    /* 5C244 8006BA44 F80332AE */  sw         $s2, 0x3F8($s1)
    /* 5C248 8006BA48 FC0320AE */  sw         $zero, 0x3FC($s1)
    /* 5C24C 8006BA4C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 5C250 8006BA50 2400B58F */  lw         $s5, 0x24($sp)
    /* 5C254 8006BA54 2000B48F */  lw         $s4, 0x20($sp)
    /* 5C258 8006BA58 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5C25C 8006BA5C 1800B28F */  lw         $s2, 0x18($sp)
    /* 5C260 8006BA60 1400B18F */  lw         $s1, 0x14($sp)
    /* 5C264 8006BA64 1000B08F */  lw         $s0, 0x10($sp)
    /* 5C268 8006BA68 0800E003 */  jr         $ra
    /* 5C26C 8006BA6C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIPhysic_OutOfControlPhysics__FP8Car_tObj
