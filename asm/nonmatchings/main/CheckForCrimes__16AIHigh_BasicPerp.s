.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForCrimes__16AIHigh_BasicPerp, 0x28C

glabel CheckForCrimes__16AIHigh_BasicPerp
    /* 4BD00 8005B500 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4BD04 8005B504 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4BD08 8005B508 21888000 */  addu       $s1, $a0, $zero
    /* 4BD0C 8005B50C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4BD10 8005B510 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4BD14 8005B514 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4BD18 8005B518 0000228E */  lw         $v0, 0x0($s1)
    /* 4BD1C 8005B51C 7800308E */  lw         $s0, 0x78($s1)
    /* 4BD20 8005B520 08004484 */  lh         $a0, 0x8($v0)
    /* 4BD24 8005B524 43BB010C */  jal        AISpeeds_GetLegalSpeed__Fi
    /* 4BD28 8005B528 21900002 */   addu      $s2, $s0, $zero
    /* 4BD2C 8005B52C 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 4BD30 8005B530 B0E0648C */  lw         $a0, %lo(D_8011E0B0)($v1)
    /* 4BD34 8005B534 6800238E */  lw         $v1, 0x68($s1)
    /* 4BD38 8005B538 00000000 */  nop
    /* 4BD3C 8005B53C 23188300 */  subu       $v1, $a0, $v1
    /* 4BD40 8005B540 80026328 */  slti       $v1, $v1, 0x280
    /* 4BD44 8005B544 8B006014 */  bnez       $v1, .L8005B774
    /* 4BD48 8005B548 21284000 */   addu      $a1, $v0, $zero
    /* 4BD4C 8005B54C 0000238E */  lw         $v1, 0x0($s1)
    /* 4BD50 8005B550 00000000 */  nop
    /* 4BD54 8005B554 9003628C */  lw         $v0, 0x390($v1)
    /* 4BD58 8005B558 00000000 */  nop
    /* 4BD5C 8005B55C 02004228 */  slti       $v0, $v0, 0x2
    /* 4BD60 8005B560 84004010 */  beqz       $v0, .L8005B774
    /* 4BD64 8005B564 00000000 */   nop
    /* 4BD68 8005B568 B801628C */  lw         $v0, 0x1B8($v1)
    /* 4BD6C 8005B56C 00000000 */  nop
    /* 4BD70 8005B570 23108200 */  subu       $v0, $a0, $v0
    /* 4BD74 8005B574 0F004228 */  slti       $v0, $v0, 0xF
    /* 4BD78 8005B578 14004010 */  beqz       $v0, .L8005B5CC
    /* 4BD7C 8005B57C 00000000 */   nop
    /* 4BD80 8005B580 B001628C */  lw         $v0, 0x1B0($v1)
    /* 4BD84 8005B584 00000000 */  nop
    /* 4BD88 8005B588 10004010 */  beqz       $v0, .L8005B5CC
    /* 4BD8C 8005B58C 00000000 */   nop
    /* 4BD90 8005B590 6002428C */  lw         $v0, 0x260($v0)
    /* 4BD94 8005B594 00000000 */  nop
    /* 4BD98 8005B598 20004230 */  andi       $v0, $v0, 0x20
    /* 4BD9C 8005B59C 0B004010 */  beqz       $v0, .L8005B5CC
    /* 4BDA0 8005B5A0 1400023C */   lui       $v0, (0x140000 >> 16)
    /* 4BDA4 8005B5A4 B401638C */  lw         $v1, 0x1B4($v1)
    /* 4BDA8 8005B5A8 00000000 */  nop
    /* 4BDAC 8005B5AC 2A104300 */  slt        $v0, $v0, $v1
    /* 4BDB0 8005B5B0 03004010 */  beqz       $v0, .L8005B5C0
    /* 4BDB4 8005B5B4 00000000 */   nop
    /* 4BDB8 8005B5B8 736D0108 */  j          .L8005B5CC
    /* 4BDBC 8005B5BC 04001024 */   addiu     $s0, $zero, 0x4
  .L8005B5C0:
    /* 4BDC0 8005B5C0 02000016 */  bnez       $s0, .L8005B5CC
    /* 4BDC4 8005B5C4 00000000 */   nop
    /* 4BDC8 8005B5C8 03001024 */  addiu      $s0, $zero, 0x3
  .L8005B5CC:
    /* 4BDCC 8005B5CC 03004012 */  beqz       $s2, .L8005B5DC
    /* 4BDD0 8005B5D0 04000224 */   addiu     $v0, $zero, 0x4
    /* 4BDD4 8005B5D4 67000216 */  bne        $s0, $v0, .L8005B774
    /* 4BDD8 8005B5D8 00000000 */   nop
  .L8005B5DC:
    /* 4BDDC 8005B5DC 0000228E */  lw         $v0, 0x0($s1)
    /* 4BDE0 8005B5E0 00000000 */  nop
    /* 4BDE4 8005B5E4 6405438C */  lw         $v1, 0x564($v0)
    /* 4BDE8 8005B5E8 0200A104 */  bgez       $a1, .L8005B5F4
    /* 4BDEC 8005B5EC 2110A000 */   addu      $v0, $a1, $zero
    /* 4BDF0 8005B5F0 23100200 */  negu       $v0, $v0
  .L8005B5F4:
    /* 4BDF4 8005B5F4 02006104 */  bgez       $v1, .L8005B600
    /* 4BDF8 8005B5F8 00000000 */   nop
    /* 4BDFC 8005B5FC 23180300 */  negu       $v1, $v1
  .L8005B600:
    /* 4BE00 8005B600 2A104300 */  slt        $v0, $v0, $v1
    /* 4BE04 8005B604 04004010 */  beqz       $v0, .L8005B618
    /* 4BE08 8005B608 00000000 */   nop
    /* 4BE0C 8005B60C 02000016 */  bnez       $s0, .L8005B618
    /* 4BE10 8005B610 00000000 */   nop
    /* 4BE14 8005B614 01001024 */  addiu      $s0, $zero, 0x1
  .L8005B618:
    /* 4BE18 8005B618 1480023C */  lui        $v0, %hi(AITune_oneWay)
    /* 4BE1C 8005B61C F0C5428C */  lw         $v0, %lo(AITune_oneWay)($v0)
    /* 4BE20 8005B620 00000000 */  nop
    /* 4BE24 8005B624 14004010 */  beqz       $v0, .L8005B678
    /* 4BE28 8005B628 1180023C */   lui       $v0, %hi(D_8011321C)
    /* 4BE2C 8005B62C 0000238E */  lw         $v1, 0x0($s1)
    /* 4BE30 8005B630 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 4BE34 8005B634 6405638C */  lw         $v1, 0x564($v1)
    /* 4BE38 8005B638 03004010 */  beqz       $v0, .L8005B648
    /* 4BE3C 8005B63C 23100300 */   negu      $v0, $v1
    /* 4BE40 8005B640 936D0108 */  j          .L8005B64C
    /* 4BE44 8005B644 C2170200 */   srl       $v0, $v0, 31
  .L8005B648:
    /* 4BE48 8005B648 C2170300 */  srl        $v0, $v1, 31
  .L8005B64C:
    /* 4BE4C 8005B64C 2B004010 */  beqz       $v0, .L8005B6FC
    /* 4BE50 8005B650 00000000 */   nop
    /* 4BE54 8005B654 0000228E */  lw         $v0, 0x0($s1)
    /* 4BE58 8005B658 00000000 */  nop
    /* 4BE5C 8005B65C 6405438C */  lw         $v1, 0x564($v0)
    /* 4BE60 8005B660 00000000 */  nop
    /* 4BE64 8005B664 02006104 */  bgez       $v1, .L8005B670
    /* 4BE68 8005B668 00000000 */   nop
    /* 4BE6C 8005B66C 23180300 */  negu       $v1, $v1
  .L8005B670:
    /* 4BE70 8005B670 B96D0108 */  j          .L8005B6E4
    /* 4BE74 8005B674 0400023C */   lui       $v0, (0x40000 >> 16)
  .L8005B678:
    /* 4BE78 8005B678 0000248E */  lw         $a0, 0x0($s1)
    /* 4BE7C 8005B67C 1480023C */  lui        $v0, %hi(AITune_driveSide)
    /* 4BE80 8005B680 F4C5428C */  lw         $v0, %lo(AITune_driveSide)($v0)
    /* 4BE84 8005B684 6405838C */  lw         $v1, 0x564($a0)
    /* 4BE88 8005B688 00000000 */  nop
    /* 4BE8C 8005B68C 18006200 */  mult       $v1, $v0
    /* 4BE90 8005B690 12380000 */  mflo       $a3
    /* 4BE94 8005B694 0A00E004 */  bltz       $a3, .L8005B6C0
    /* 4BE98 8005B698 00000000 */   nop
    /* 4BE9C 8005B69C C406828C */  lw         $v0, 0x6C4($a0)
    /* 4BEA0 8005B6A0 00000000 */  nop
    /* 4BEA4 8005B6A4 07004228 */  slti       $v0, $v0, 0x7
    /* 4BEA8 8005B6A8 15004010 */  beqz       $v0, .L8005B700
    /* 4BEAC 8005B6AC 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4BEB0 8005B6B0 B56D0108 */  j          .L8005B6D4
    /* 4BEB4 8005B6B4 00000000 */   nop
  .L8005B6B8:
    /* 4BEB8 8005B6B8 DD6D0108 */  j          .L8005B774
    /* 4BEBC 8005B6BC 780030AE */   sw        $s0, 0x78($s1)
  .L8005B6C0:
    /* 4BEC0 8005B6C0 C406828C */  lw         $v0, 0x6C4($a0)
    /* 4BEC4 8005B6C4 00000000 */  nop
    /* 4BEC8 8005B6C8 07004228 */  slti       $v0, $v0, 0x7
    /* 4BECC 8005B6CC 0C004014 */  bnez       $v0, .L8005B700
    /* 4BED0 8005B6D0 1280023C */   lui       $v0, %hi(D_8011E0B0)
  .L8005B6D4:
    /* 4BED4 8005B6D4 02006104 */  bgez       $v1, .L8005B6E0
    /* 4BED8 8005B6D8 00000000 */   nop
    /* 4BEDC 8005B6DC 23180300 */  negu       $v1, $v1
  .L8005B6E0:
    /* 4BEE0 8005B6E0 0400023C */  lui        $v0, (0x40000 >> 16)
  .L8005B6E4:
    /* 4BEE4 8005B6E4 2A104300 */  slt        $v0, $v0, $v1
    /* 4BEE8 8005B6E8 05004010 */  beqz       $v0, .L8005B700
    /* 4BEEC 8005B6EC 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4BEF0 8005B6F0 03000016 */  bnez       $s0, .L8005B700
    /* 4BEF4 8005B6F4 00000000 */   nop
    /* 4BEF8 8005B6F8 02001024 */  addiu      $s0, $zero, 0x2
  .L8005B6FC:
    /* 4BEFC 8005B6FC 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L8005B700:
    /* 4BF00 8005B700 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4BF04 8005B704 00000000 */  nop
    /* 4BF08 8005B708 00024228 */  slti       $v0, $v0, 0x200
    /* 4BF0C 8005B70C 02004010 */  beqz       $v0, .L8005B718
    /* 4BF10 8005B710 00000000 */   nop
    /* 4BF14 8005B714 21800000 */  addu       $s0, $zero, $zero
  .L8005B718:
    /* 4BF18 8005B718 16000012 */  beqz       $s0, .L8005B774
    /* 4BF1C 8005B71C 21280000 */   addu      $a1, $zero, $zero
    /* 4BF20 8005B720 1480063C */  lui        $a2, %hi(Cars_gNumCars)
    /* 4BF24 8005B724 F4C7C68C */  lw         $a2, %lo(Cars_gNumCars)($a2)
    /* 4BF28 8005B728 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4BF2C 8005B72C DCF94424 */  addiu      $a0, $v0, %lo(Cars_gList)
  .L8005B730:
    /* 4BF30 8005B730 2A10A600 */  slt        $v0, $a1, $a2
    /* 4BF34 8005B734 0F004010 */  beqz       $v0, .L8005B774
    /* 4BF38 8005B738 00000000 */   nop
    /* 4BF3C 8005B73C 0000838C */  lw         $v1, 0x0($a0)
    /* 4BF40 8005B740 00000000 */  nop
    /* 4BF44 8005B744 6002628C */  lw         $v0, 0x260($v1)
    /* 4BF48 8005B748 00000000 */  nop
    /* 4BF4C 8005B74C 20024230 */  andi       $v0, $v0, 0x220
    /* 4BF50 8005B750 05004010 */  beqz       $v0, .L8005B768
    /* 4BF54 8005B754 00000000 */   nop
    /* 4BF58 8005B758 91006290 */  lbu        $v0, 0x91($v1)
    /* 4BF5C 8005B75C 00000000 */  nop
    /* 4BF60 8005B760 D5FF4014 */  bnez       $v0, .L8005B6B8
    /* 4BF64 8005B764 00000000 */   nop
  .L8005B768:
    /* 4BF68 8005B768 04008424 */  addiu      $a0, $a0, 0x4
    /* 4BF6C 8005B76C CC6D0108 */  j          .L8005B730
    /* 4BF70 8005B770 0100A524 */   addiu     $a1, $a1, 0x1
  .L8005B774:
    /* 4BF74 8005B774 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4BF78 8005B778 1800B28F */  lw         $s2, 0x18($sp)
    /* 4BF7C 8005B77C 1400B18F */  lw         $s1, 0x14($sp)
    /* 4BF80 8005B780 1000B08F */  lw         $s0, 0x10($sp)
    /* 4BF84 8005B784 0800E003 */  jr         $ra
    /* 4BF88 8005B788 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CheckForCrimes__16AIHigh_BasicPerp
