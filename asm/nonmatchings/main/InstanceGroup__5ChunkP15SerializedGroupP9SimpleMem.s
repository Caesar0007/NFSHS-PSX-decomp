.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem, 0x524

glabel InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
    /* 7BBFC 8008B3FC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 7BC00 8008B400 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7BC04 8008B404 21908000 */  addu       $s2, $a0, $zero
    /* 7BC08 8008B408 2400B5AF */  sw         $s5, 0x24($sp)
    /* 7BC0C 8008B40C 21A8A000 */  addu       $s5, $a1, $zero
    /* 7BC10 8008B410 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 7BC14 8008B414 2198C000 */  addu       $s3, $a2, $zero
    /* 7BC18 8008B418 2120A002 */  addu       $a0, $s5, $zero
    /* 7BC1C 8008B41C 1C000524 */  addiu      $a1, $zero, 0x1C
    /* 7BC20 8008B420 21300000 */  addu       $a2, $zero, $zero
    /* 7BC24 8008B424 2800BFAF */  sw         $ra, 0x28($sp)
    /* 7BC28 8008B428 2000B4AF */  sw         $s4, 0x20($sp)
    /* 7BC2C 8008B42C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7BC30 8008B430 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 7BC34 8008B434 1000B0AF */   sw        $s0, 0x10($sp)
    /* 7BC38 8008B438 10004424 */  addiu      $a0, $v0, 0x10
    /* 7BC3C 8008B43C 0A008394 */  lhu        $v1, 0xA($a0)
    /* 7BC40 8008B440 00000000 */  nop
    /* 7BC44 8008B444 680043A6 */  sh         $v1, 0x68($s2)
    /* 7BC48 8008B448 23004B88 */  lwl        $t3, 0x23($v0)
    /* 7BC4C 8008B44C 20004B98 */  lwr        $t3, 0x20($v0)
    /* 7BC50 8008B450 00000000 */  nop
    /* 7BC54 8008B454 03004BAA */  swl        $t3, 0x3($s2)
    /* 7BC58 8008B458 00004BBA */  swr        $t3, 0x0($s2)
    /* 7BC5C 8008B45C 27004B88 */  lwl        $t3, 0x27($v0)
    /* 7BC60 8008B460 24004B98 */  lwr        $t3, 0x24($v0)
    /* 7BC64 8008B464 00000000 */  nop
    /* 7BC68 8008B468 07004BAA */  swl        $t3, 0x7($s2)
    /* 7BC6C 8008B46C 04004BBA */  swr        $t3, 0x4($s2)
    /* 7BC70 8008B470 2B004B88 */  lwl        $t3, 0x2B($v0)
    /* 7BC74 8008B474 28004B98 */  lwr        $t3, 0x28($v0)
    /* 7BC78 8008B478 00000000 */  nop
    /* 7BC7C 8008B47C 0B004BAA */  swl        $t3, 0xB($s2)
    /* 7BC80 8008B480 08004BBA */  swr        $t3, 0x8($s2)
    /* 7BC84 8008B484 2F004B88 */  lwl        $t3, 0x2F($v0)
    /* 7BC88 8008B488 2C004B98 */  lwr        $t3, 0x2C($v0)
    /* 7BC8C 8008B48C 00000000 */  nop
    /* 7BC90 8008B490 0F004BAA */  swl        $t3, 0xF($s2)
    /* 7BC94 8008B494 0C004BBA */  swr        $t3, 0xC($s2)
    /* 7BC98 8008B498 33004B88 */  lwl        $t3, 0x33($v0)
    /* 7BC9C 8008B49C 30004B98 */  lwr        $t3, 0x30($v0)
    /* 7BCA0 8008B4A0 00000000 */  nop
    /* 7BCA4 8008B4A4 13004BAA */  swl        $t3, 0x13($s2)
    /* 7BCA8 8008B4A8 10004BBA */  swr        $t3, 0x10($s2)
    /* 7BCAC 8008B4AC 37004B88 */  lwl        $t3, 0x37($v0)
    /* 7BCB0 8008B4B0 34004B98 */  lwr        $t3, 0x34($v0)
    /* 7BCB4 8008B4B4 00000000 */  nop
    /* 7BCB8 8008B4B8 17004BAA */  swl        $t3, 0x17($s2)
    /* 7BCBC 8008B4BC 14004BBA */  swr        $t3, 0x14($s2)
    /* 7BCC0 8008B4C0 3B004B88 */  lwl        $t3, 0x3B($v0)
    /* 7BCC4 8008B4C4 38004B98 */  lwr        $t3, 0x38($v0)
    /* 7BCC8 8008B4C8 00000000 */  nop
    /* 7BCCC 8008B4CC 1B004BAA */  swl        $t3, 0x1B($s2)
    /* 7BCD0 8008B4D0 18004BBA */  swr        $t3, 0x18($s2)
    /* 7BCD4 8008B4D4 3F004B88 */  lwl        $t3, 0x3F($v0)
    /* 7BCD8 8008B4D8 3C004B98 */  lwr        $t3, 0x3C($v0)
    /* 7BCDC 8008B4DC 00000000 */  nop
    /* 7BCE0 8008B4E0 1F004BAA */  swl        $t3, 0x1F($s2)
    /* 7BCE4 8008B4E4 1C004BBA */  swr        $t3, 0x1C($s2)
    /* 7BCE8 8008B4E8 0C008294 */  lhu        $v0, 0xC($a0)
    /* 7BCEC 8008B4EC 00000000 */  nop
    /* 7BCF0 8008B4F0 6A0042A6 */  sh         $v0, 0x6A($s2)
    /* 7BCF4 8008B4F4 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 7BCF8 8008B4F8 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 7BCFC 8008B4FC 01000224 */  addiu      $v0, $zero, 0x1
    /* 7BD00 8008B500 0D006210 */  beq        $v1, $v0, .L8008B538
    /* 7BD04 8008B504 2120A002 */   addu      $a0, $s5, $zero
    /* 7BD08 8008B508 03000524 */  addiu      $a1, $zero, 0x3
    /* 7BD0C 8008B50C 21306002 */  addu       $a2, $s3, $zero
    /* 7BD10 8008B510 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BD14 8008B514 21380000 */   addu      $a3, $zero, $zero
    /* 7BD18 8008B518 2120A002 */  addu       $a0, $s5, $zero
    /* 7BD1C 8008B51C 0B000524 */  addiu      $a1, $zero, 0xB
    /* 7BD20 8008B520 21306002 */  addu       $a2, $s3, $zero
    /* 7BD24 8008B524 21380000 */  addu       $a3, $zero, $zero
    /* 7BD28 8008B528 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BD2C 8008B52C 400042AE */   sw        $v0, 0x40($s2)
    /* 7BD30 8008B530 CC2D0208 */  j          .L8008B730
    /* 7BD34 8008B534 500042AE */   sw        $v0, 0x50($s2)
  .L8008B538:
    /* 7BD38 8008B538 0B000524 */  addiu      $a1, $zero, 0xB
    /* 7BD3C 8008B53C 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 7BD40 8008B540 21300000 */   addu      $a2, $zero, $zero
    /* 7BD44 8008B544 2120A002 */  addu       $a0, $s5, $zero
    /* 7BD48 8008B548 03000524 */  addiu      $a1, $zero, 0x3
    /* 7BD4C 8008B54C 21300000 */  addu       $a2, $zero, $zero
    /* 7BD50 8008B550 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 7BD54 8008B554 21A04000 */   addu      $s4, $v0, $zero
    /* 7BD58 8008B558 35008012 */  beqz       $s4, .L8008B630
    /* 7BD5C 8008B55C 21884000 */   addu      $s1, $v0, $zero
    /* 7BD60 8008B560 21300000 */  addu       $a2, $zero, $zero
    /* 7BD64 8008B564 0C00908E */  lw         $s0, 0xC($s4)
    /* 7BD68 8008B568 7F000A24 */  addiu      $t2, $zero, 0x7F
    /* 7BD6C 8008B56C FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 7BD70 8008B570 05000824 */  addiu      $t0, $zero, 0x5
    /* 7BD74 8008B574 10008526 */  addiu      $a1, $s4, 0x10
  .L8008B578:
    /* 7BD78 8008B578 2A10D000 */  slt        $v0, $a2, $s0
    /* 7BD7C 8008B57C 20004010 */  beqz       $v0, .L8008B600
    /* 7BD80 8008B580 00000000 */   nop
    /* 7BD84 8008B584 1200A290 */  lbu        $v0, 0x12($a1)
    /* 7BD88 8008B588 00000000 */  nop
    /* 7BD8C 8008B58C 19004A10 */  beq        $v0, $t2, .L8008B5F4
    /* 7BD90 8008B590 00000000 */   nop
    /* 7BD94 8008B594 1200A390 */  lbu        $v1, 0x12($a1)
    /* 7BD98 8008B598 0C00228E */  lw         $v0, 0xC($s1)
    /* 7BD9C 8008B59C 00000000 */  nop
    /* 7BDA0 8008B5A0 2A106200 */  slt        $v0, $v1, $v0
    /* 7BDA4 8008B5A4 16004010 */  beqz       $v0, .L8008B600
    /* 7BDA8 8008B5A8 10002426 */   addiu     $a0, $s1, 0x10
    /* 7BDAC 8008B5AC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 7BDB0 8008B5B0 06006910 */  beq        $v1, $t1, .L8008B5CC
    /* 7BDB4 8008B5B4 00000000 */   nop
    /* 7BDB8 8008B5B8 FFFF0724 */  addiu      $a3, $zero, -0x1
  .L8008B5BC:
    /* 7BDBC 8008B5BC 00008284 */  lh         $v0, 0x0($a0)
    /* 7BDC0 8008B5C0 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 7BDC4 8008B5C4 FDFF6714 */  bne        $v1, $a3, .L8008B5BC
    /* 7BDC8 8008B5C8 21208200 */   addu      $a0, $a0, $v0
  .L8008B5CC:
    /* 7BDCC 8008B5CC 0C008010 */  beqz       $a0, .L8008B600
    /* 7BDD0 8008B5D0 00000000 */   nop
    /* 7BDD4 8008B5D4 02008290 */  lbu        $v0, 0x2($a0)
    /* 7BDD8 8008B5D8 00000000 */  nop
    /* 7BDDC 8008B5DC 08004814 */  bne        $v0, $t0, .L8008B600
    /* 7BDE0 8008B5E0 00000000 */   nop
    /* 7BDE4 8008B5E4 23008290 */  lbu        $v0, 0x23($a0)
    /* 7BDE8 8008B5E8 00000000 */  nop
    /* 7BDEC 8008B5EC 04004014 */  bnez       $v0, .L8008B600
    /* 7BDF0 8008B5F0 00000000 */   nop
  .L8008B5F4:
    /* 7BDF4 8008B5F4 1400A524 */  addiu      $a1, $a1, 0x14
    /* 7BDF8 8008B5F8 5E2D0208 */  j          .L8008B578
    /* 7BDFC 8008B5FC 0100C624 */   addiu     $a2, $a2, 0x1
  .L8008B600:
    /* 7BE00 8008B600 2180C000 */  addu       $s0, $a2, $zero
    /* 7BE04 8008B604 0A000012 */  beqz       $s0, .L8008B630
    /* 7BE08 8008B608 2120A002 */   addu      $a0, $s5, $zero
    /* 7BE0C 8008B60C 21288002 */  addu       $a1, $s4, $zero
    /* 7BE10 8008B610 21306002 */  addu       $a2, $s3, $zero
    /* 7BE14 8008B614 80381000 */  sll        $a3, $s0, 2
    /* 7BE18 8008B618 2138F000 */  addu       $a3, $a3, $s0
    /* 7BE1C 8008B61C B970020C */  jal        CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
    /* 7BE20 8008B620 80380700 */   sll       $a3, $a3, 2
    /* 7BE24 8008B624 500042AE */  sw         $v0, 0x50($s2)
    /* 7BE28 8008B628 8D2D0208 */  j          .L8008B634
    /* 7BE2C 8008B62C 000050AC */   sw        $s0, 0x0($v0)
  .L8008B630:
    /* 7BE30 8008B630 500040AE */  sw         $zero, 0x50($s2)
  .L8008B634:
    /* 7BE34 8008B634 21002012 */  beqz       $s1, .L8008B6BC
    /* 7BE38 8008B638 21800000 */   addu      $s0, $zero, $zero
    /* 7BE3C 8008B63C 0C00248E */  lw         $a0, 0xC($s1)
    /* 7BE40 8008B640 21380002 */  addu       $a3, $s0, $zero
    /* 7BE44 8008B644 10002326 */  addiu      $v1, $s1, 0x10
    /* 7BE48 8008B648 05000624 */  addiu      $a2, $zero, 0x5
    /* 7BE4C 8008B64C 01000524 */  addiu      $a1, $zero, 0x1
  .L8008B650:
    /* 7BE50 8008B650 2A100402 */  slt        $v0, $s0, $a0
    /* 7BE54 8008B654 12004010 */  beqz       $v0, .L8008B6A0
    /* 7BE58 8008B658 00000000 */   nop
    /* 7BE5C 8008B65C 02006290 */  lbu        $v0, 0x2($v1)
    /* 7BE60 8008B660 00000000 */  nop
    /* 7BE64 8008B664 07004614 */  bne        $v0, $a2, .L8008B684
    /* 7BE68 8008B668 00000000 */   nop
    /* 7BE6C 8008B66C 23006290 */  lbu        $v0, 0x23($v1)
    /* 7BE70 8008B670 00000000 */  nop
    /* 7BE74 8008B674 0A004014 */  bnez       $v0, .L8008B6A0
    /* 7BE78 8008B678 00000000 */   nop
    /* 7BE7C 8008B67C A32D0208 */  j          .L8008B68C
    /* 7BE80 8008B680 00000000 */   nop
  .L8008B684:
    /* 7BE84 8008B684 06004514 */  bne        $v0, $a1, .L8008B6A0
    /* 7BE88 8008B688 00000000 */   nop
  .L8008B68C:
    /* 7BE8C 8008B68C 00006284 */  lh         $v0, 0x0($v1)
    /* 7BE90 8008B690 01001026 */  addiu      $s0, $s0, 0x1
    /* 7BE94 8008B694 2138E200 */  addu       $a3, $a3, $v0
    /* 7BE98 8008B698 942D0208 */  j          .L8008B650
    /* 7BE9C 8008B69C 21186200 */   addu      $v1, $v1, $v0
  .L8008B6A0:
    /* 7BEA0 8008B6A0 2120A002 */  addu       $a0, $s5, $zero
    /* 7BEA4 8008B6A4 21282002 */  addu       $a1, $s1, $zero
    /* 7BEA8 8008B6A8 B970020C */  jal        CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
    /* 7BEAC 8008B6AC 21306002 */   addu      $a2, $s3, $zero
    /* 7BEB0 8008B6B0 400042AE */  sw         $v0, 0x40($s2)
    /* 7BEB4 8008B6B4 B02D0208 */  j          .L8008B6C0
    /* 7BEB8 8008B6B8 000050AC */   sw        $s0, 0x0($v0)
  .L8008B6BC:
    /* 7BEBC 8008B6BC 400040AE */  sw         $zero, 0x40($s2)
  .L8008B6C0:
    /* 7BEC0 8008B6C0 5000438E */  lw         $v1, 0x50($s2)
    /* 7BEC4 8008B6C4 00000000 */  nop
    /* 7BEC8 8008B6C8 1A006010 */  beqz       $v1, .L8008B734
    /* 7BECC 8008B6CC 2120A002 */   addu      $a0, $s5, $zero
    /* 7BED0 8008B6D0 4000428E */  lw         $v0, 0x40($s2)
    /* 7BED4 8008B6D4 00000000 */  nop
    /* 7BED8 8008B6D8 16004010 */  beqz       $v0, .L8008B734
    /* 7BEDC 8008B6DC FFFF0724 */   addiu     $a3, $zero, -0x1
    /* 7BEE0 8008B6E0 0000658C */  lw         $a1, 0x0($v1)
    /* 7BEE4 8008B6E4 7F000624 */  addiu      $a2, $zero, 0x7F
    /* 7BEE8 8008B6E8 10008326 */  addiu      $v1, $s4, 0x10
    /* 7BEEC 8008B6EC 80100500 */  sll        $v0, $a1, 2
    /* 7BEF0 8008B6F0 21104500 */  addu       $v0, $v0, $a1
    /* 7BEF4 8008B6F4 80100200 */  sll        $v0, $v0, 2
    /* 7BEF8 8008B6F8 21204300 */  addu       $a0, $v0, $v1
  .L8008B6FC:
    /* 7BEFC 8008B6FC FFFFA524 */  addiu      $a1, $a1, -0x1
  .L8008B700:
    /* 7BF00 8008B700 0B00A710 */  beq        $a1, $a3, .L8008B730
    /* 7BF04 8008B704 ECFF8424 */   addiu     $a0, $a0, -0x14
    /* 7BF08 8008B708 4000428E */  lw         $v0, 0x40($s2)
    /* 7BF0C 8008B70C 12008390 */  lbu        $v1, 0x12($a0)
    /* 7BF10 8008B710 0000428C */  lw         $v0, 0x0($v0)
    /* 7BF14 8008B714 00000000 */  nop
    /* 7BF18 8008B718 2A186200 */  slt        $v1, $v1, $v0
    /* 7BF1C 8008B71C F8FF6014 */  bnez       $v1, .L8008B700
    /* 7BF20 8008B720 FFFFA524 */   addiu     $a1, $a1, -0x1
    /* 7BF24 8008B724 0100A524 */  addiu      $a1, $a1, 0x1
    /* 7BF28 8008B728 BF2D0208 */  j          .L8008B6FC
    /* 7BF2C 8008B72C 120086A0 */   sb        $a2, 0x12($a0)
  .L8008B730:
    /* 7BF30 8008B730 2120A002 */  addu       $a0, $s5, $zero
  .L8008B734:
    /* 7BF34 8008B734 15000524 */  addiu      $a1, $zero, 0x15
    /* 7BF38 8008B738 21306002 */  addu       $a2, $s3, $zero
    /* 7BF3C 8008B73C 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BF40 8008B740 21380000 */   addu      $a3, $zero, $zero
    /* 7BF44 8008B744 2120A002 */  addu       $a0, $s5, $zero
    /* 7BF48 8008B748 0A000524 */  addiu      $a1, $zero, 0xA
    /* 7BF4C 8008B74C 21306002 */  addu       $a2, $s3, $zero
    /* 7BF50 8008B750 21380000 */  addu       $a3, $zero, $zero
    /* 7BF54 8008B754 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BF58 8008B758 440042AE */   sw        $v0, 0x44($s2)
    /* 7BF5C 8008B75C 2120A002 */  addu       $a0, $s5, $zero
    /* 7BF60 8008B760 05000524 */  addiu      $a1, $zero, 0x5
    /* 7BF64 8008B764 21306002 */  addu       $a2, $s3, $zero
    /* 7BF68 8008B768 21380000 */  addu       $a3, $zero, $zero
    /* 7BF6C 8008B76C 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BF70 8008B770 540042AE */   sw        $v0, 0x54($s2)
    /* 7BF74 8008B774 2120A002 */  addu       $a0, $s5, $zero
    /* 7BF78 8008B778 06000524 */  addiu      $a1, $zero, 0x6
    /* 7BF7C 8008B77C 21306002 */  addu       $a2, $s3, $zero
    /* 7BF80 8008B780 21380000 */  addu       $a3, $zero, $zero
    /* 7BF84 8008B784 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BF88 8008B788 4C0042AE */   sw        $v0, 0x4C($s2)
    /* 7BF8C 8008B78C 2120A002 */  addu       $a0, $s5, $zero
    /* 7BF90 8008B790 09000524 */  addiu      $a1, $zero, 0x9
    /* 7BF94 8008B794 21306002 */  addu       $a2, $s3, $zero
    /* 7BF98 8008B798 21380000 */  addu       $a3, $zero, $zero
    /* 7BF9C 8008B79C 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7BFA0 8008B7A0 480042AE */   sw        $v0, 0x48($s2)
    /* 7BFA4 8008B7A4 2120A002 */  addu       $a0, $s5, $zero
    /* 7BFA8 8008B7A8 17000524 */  addiu      $a1, $zero, 0x17
    /* 7BFAC 8008B7AC 21300000 */  addu       $a2, $zero, $zero
    /* 7BFB0 8008B7B0 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 7BFB4 8008B7B4 580042AE */   sw        $v0, 0x58($s2)
    /* 7BFB8 8008B7B8 21884000 */  addu       $s1, $v0, $zero
    /* 7BFBC 8008B7BC 21202002 */  addu       $a0, $s1, $zero
    /* 7BFC0 8008B7C0 1B000524 */  addiu      $a1, $zero, 0x1B
    /* 7BFC4 8008B7C4 5470020C */  jal        LocateGroupType__15SerializedGroupii
    /* 7BFC8 8008B7C8 21300000 */   addu      $a2, $zero, $zero
    /* 7BFCC 8008B7CC 10005024 */  addiu      $s0, $v0, 0x10
    /* 7BFD0 8008B7D0 0C000292 */  lbu        $v0, 0xC($s0)
    /* 7BFD4 8008B7D4 00000000 */  nop
    /* 7BFD8 8008B7D8 200042A2 */  sb         $v0, 0x20($s2)
    /* 7BFDC 8008B7DC 0E000292 */  lbu        $v0, 0xE($s0)
    /* 7BFE0 8008B7E0 00000000 */  nop
    /* 7BFE4 8008B7E4 210042A2 */  sb         $v0, 0x21($s2)
    /* 7BFE8 8008B7E8 10000292 */  lbu        $v0, 0x10($s0)
    /* 7BFEC 8008B7EC 21202002 */  addu       $a0, $s1, $zero
    /* 7BFF0 8008B7F0 220042A2 */  sb         $v0, 0x22($s2)
    /* 7BFF4 8008B7F4 12000292 */  lbu        $v0, 0x12($s0)
    /* 7BFF8 8008B7F8 19000524 */  addiu      $a1, $zero, 0x19
    /* 7BFFC 8008B7FC 230042A2 */  sb         $v0, 0x23($s2)
    /* 7C000 8008B800 14000292 */  lbu        $v0, 0x14($s0)
    /* 7C004 8008B804 21306002 */  addu       $a2, $s3, $zero
    /* 7C008 8008B808 240042A2 */  sb         $v0, 0x24($s2)
    /* 7C00C 8008B80C 16000292 */  lbu        $v0, 0x16($s0)
    /* 7C010 8008B810 21380000 */  addu       $a3, $zero, $zero
    /* 7C014 8008B814 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C018 8008B818 250042A2 */   sb        $v0, 0x25($s2)
    /* 7C01C 8008B81C 21202002 */  addu       $a0, $s1, $zero
    /* 7C020 8008B820 04004224 */  addiu      $v0, $v0, 0x4
    /* 7C024 8008B824 280042AE */  sw         $v0, 0x28($s2)
    /* 7C028 8008B828 0C000686 */  lh         $a2, 0xC($s0)
    /* 7C02C 8008B82C 1A000524 */  addiu      $a1, $zero, 0x1A
    /* 7C030 8008B830 40180600 */  sll        $v1, $a2, 1
    /* 7C034 8008B834 21186600 */  addu       $v1, $v1, $a2
    /* 7C038 8008B838 40180300 */  sll        $v1, $v1, 1
    /* 7C03C 8008B83C 21104300 */  addu       $v0, $v0, $v1
    /* 7C040 8008B840 2C0042AE */  sw         $v0, 0x2C($s2)
    /* 7C044 8008B844 0E000786 */  lh         $a3, 0xE($s0)
    /* 7C048 8008B848 21306002 */  addu       $a2, $s3, $zero
    /* 7C04C 8008B84C 40180700 */  sll        $v1, $a3, 1
    /* 7C050 8008B850 21186700 */  addu       $v1, $v1, $a3
    /* 7C054 8008B854 40180300 */  sll        $v1, $v1, 1
    /* 7C058 8008B858 21104300 */  addu       $v0, $v0, $v1
    /* 7C05C 8008B85C 300042AE */  sw         $v0, 0x30($s2)
    /* 7C060 8008B860 14000886 */  lh         $t0, 0x14($s0)
    /* 7C064 8008B864 21380000 */  addu       $a3, $zero, $zero
    /* 7C068 8008B868 40180800 */  sll        $v1, $t0, 1
    /* 7C06C 8008B86C 21186800 */  addu       $v1, $v1, $t0
    /* 7C070 8008B870 40180300 */  sll        $v1, $v1, 1
    /* 7C074 8008B874 21104300 */  addu       $v0, $v0, $v1
    /* 7C078 8008B878 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C07C 8008B87C 340042AE */   sw        $v0, 0x34($s2)
    /* 7C080 8008B880 21202002 */  addu       $a0, $s1, $zero
    /* 7C084 8008B884 25000524 */  addiu      $a1, $zero, 0x25
    /* 7C088 8008B888 21306002 */  addu       $a2, $s3, $zero
    /* 7C08C 8008B88C 21380000 */  addu       $a3, $zero, $zero
    /* 7C090 8008B890 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C094 8008B894 380042AE */   sw        $v0, 0x38($s2)
    /* 7C098 8008B898 21202002 */  addu       $a0, $s1, $zero
    /* 7C09C 8008B89C 18000524 */  addiu      $a1, $zero, 0x18
    /* 7C0A0 8008B8A0 21306002 */  addu       $a2, $s3, $zero
    /* 7C0A4 8008B8A4 21380000 */  addu       $a3, $zero, $zero
    /* 7C0A8 8008B8A8 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C0AC 8008B8AC 3C0042AE */   sw        $v0, 0x3C($s2)
    /* 7C0B0 8008B8B0 21202002 */  addu       $a0, $s1, $zero
    /* 7C0B4 8008B8B4 27000524 */  addiu      $a1, $zero, 0x27
    /* 7C0B8 8008B8B8 21306002 */  addu       $a2, $s3, $zero
    /* 7C0BC 8008B8BC 21380000 */  addu       $a3, $zero, $zero
    /* 7C0C0 8008B8C0 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C0C4 8008B8C4 6C0042AE */   sw        $v0, 0x6C($s2)
    /* 7C0C8 8008B8C8 21202002 */  addu       $a0, $s1, $zero
    /* 7C0CC 8008B8CC 28000524 */  addiu      $a1, $zero, 0x28
    /* 7C0D0 8008B8D0 21306002 */  addu       $a2, $s3, $zero
    /* 7C0D4 8008B8D4 21380000 */  addu       $a3, $zero, $zero
    /* 7C0D8 8008B8D8 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C0DC 8008B8DC 5C0042AE */   sw        $v0, 0x5C($s2)
    /* 7C0E0 8008B8E0 21202002 */  addu       $a0, $s1, $zero
    /* 7C0E4 8008B8E4 29000524 */  addiu      $a1, $zero, 0x29
    /* 7C0E8 8008B8E8 21306002 */  addu       $a2, $s3, $zero
    /* 7C0EC 8008B8EC 21380000 */  addu       $a3, $zero, $zero
    /* 7C0F0 8008B8F0 8170020C */  jal        LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
    /* 7C0F4 8008B8F4 600042AE */   sw        $v0, 0x60($s2)
    /* 7C0F8 8008B8F8 640042AE */  sw         $v0, 0x64($s2)
    /* 7C0FC 8008B8FC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 7C100 8008B900 2400B58F */  lw         $s5, 0x24($sp)
    /* 7C104 8008B904 2000B48F */  lw         $s4, 0x20($sp)
    /* 7C108 8008B908 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 7C10C 8008B90C 1800B28F */  lw         $s2, 0x18($sp)
    /* 7C110 8008B910 1400B18F */  lw         $s1, 0x14($sp)
    /* 7C114 8008B914 1000B08F */  lw         $s0, 0x10($sp)
    /* 7C118 8008B918 0800E003 */  jr         $ra
    /* 7C11C 8008B91C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
