.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj, 0x2DC

glabel AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
    /* 5FC1C 8006F41C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5FC20 8006F420 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5FC24 8006F424 21908000 */  addu       $s2, $a0, $zero
    /* 5FC28 8006F428 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 5FC2C 8006F42C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5FC30 8006F430 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5FC34 8006F434 08004586 */  lh         $a1, 0x8($s2)
    /* 5FC38 8006F438 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5FC3C 8006F43C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5FC40 8006F440 00000000 */  nop
    /* 5FC44 8006F444 2A10A300 */  slt        $v0, $a1, $v1
    /* 5FC48 8006F448 02004014 */  bnez       $v0, .L8006F454
    /* 5FC4C 8006F44C 2188A000 */   addu      $s1, $a1, $zero
    /* 5FC50 8006F450 2328A300 */  subu       $a1, $a1, $v1
  .L8006F454:
    /* 5FC54 8006F454 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5FC58 8006F458 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5FC5C 8006F45C E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5FC60 8006F460 00000000 */   nop
    /* 5FC64 8006F464 5405438E */  lw         $v1, 0x554($s2)
    /* 5FC68 8006F468 21804000 */  addu       $s0, $v0, $zero
    /* 5FC6C 8006F46C 80100300 */  sll        $v0, $v1, 2
    /* 5FC70 8006F470 09004004 */  bltz       $v0, .L8006F498
    /* 5FC74 8006F474 21282202 */   addu      $a1, $s1, $v0
    /* 5FC78 8006F478 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5FC7C 8006F47C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5FC80 8006F480 00000000 */  nop
    /* 5FC84 8006F484 2A10A300 */  slt        $v0, $a1, $v1
    /* 5FC88 8006F488 09004014 */  bnez       $v0, .L8006F4B0
    /* 5FC8C 8006F48C 00000000 */   nop
    /* 5FC90 8006F490 2CBD0108 */  j          .L8006F4B0
    /* 5FC94 8006F494 2328A300 */   subu      $a1, $a1, $v1
  .L8006F498:
    /* 5FC98 8006F498 0500A104 */  bgez       $a1, .L8006F4B0
    /* 5FC9C 8006F49C 00000000 */   nop
    /* 5FCA0 8006F4A0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5FCA4 8006F4A4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5FCA8 8006F4A8 00000000 */  nop
    /* 5FCAC 8006F4AC 2128A200 */  addu       $a1, $a1, $v0
  .L8006F4B0:
    /* 5FCB0 8006F4B0 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5FCB4 8006F4B4 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5FCB8 8006F4B8 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5FCBC 8006F4BC 00000000 */   nop
    /* 5FCC0 8006F4C0 21184000 */  addu       $v1, $v0, $zero
    /* 5FCC4 8006F4C4 2A100302 */  slt        $v0, $s0, $v1
    /* 5FCC8 8006F4C8 02004010 */  beqz       $v0, .L8006F4D4
    /* 5FCCC 8006F4CC 00000000 */   nop
    /* 5FCD0 8006F4D0 21806000 */  addu       $s0, $v1, $zero
  .L8006F4D4:
    /* 5FCD4 8006F4D4 5405428E */  lw         $v0, 0x554($s2)
    /* 5FCD8 8006F4D8 00000000 */  nop
    /* 5FCDC 8006F4DC C0100200 */  sll        $v0, $v0, 3
    /* 5FCE0 8006F4E0 09004004 */  bltz       $v0, .L8006F508
    /* 5FCE4 8006F4E4 21282202 */   addu      $a1, $s1, $v0
    /* 5FCE8 8006F4E8 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5FCEC 8006F4EC C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5FCF0 8006F4F0 00000000 */  nop
    /* 5FCF4 8006F4F4 2A10A300 */  slt        $v0, $a1, $v1
    /* 5FCF8 8006F4F8 09004014 */  bnez       $v0, .L8006F520
    /* 5FCFC 8006F4FC 00000000 */   nop
    /* 5FD00 8006F500 48BD0108 */  j          .L8006F520
    /* 5FD04 8006F504 2328A300 */   subu      $a1, $a1, $v1
  .L8006F508:
    /* 5FD08 8006F508 0500A104 */  bgez       $a1, .L8006F520
    /* 5FD0C 8006F50C 00000000 */   nop
    /* 5FD10 8006F510 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5FD14 8006F514 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5FD18 8006F518 00000000 */  nop
    /* 5FD1C 8006F51C 2128A200 */  addu       $a1, $a1, $v0
  .L8006F520:
    /* 5FD20 8006F520 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5FD24 8006F524 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5FD28 8006F528 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5FD2C 8006F52C 00000000 */   nop
    /* 5FD30 8006F530 21184000 */  addu       $v1, $v0, $zero
    /* 5FD34 8006F534 2A100302 */  slt        $v0, $s0, $v1
    /* 5FD38 8006F538 02004010 */  beqz       $v0, .L8006F544
    /* 5FD3C 8006F53C 00000000 */   nop
    /* 5FD40 8006F540 21806000 */  addu       $s0, $v1, $zero
  .L8006F544:
    /* 5FD44 8006F544 5405438E */  lw         $v1, 0x554($s2)
    /* 5FD48 8006F548 00000000 */  nop
    /* 5FD4C 8006F54C 40100300 */  sll        $v0, $v1, 1
    /* 5FD50 8006F550 21104300 */  addu       $v0, $v0, $v1
    /* 5FD54 8006F554 80100200 */  sll        $v0, $v0, 2
    /* 5FD58 8006F558 09004004 */  bltz       $v0, .L8006F580
    /* 5FD5C 8006F55C 21282202 */   addu      $a1, $s1, $v0
    /* 5FD60 8006F560 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5FD64 8006F564 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5FD68 8006F568 00000000 */  nop
    /* 5FD6C 8006F56C 2A10A300 */  slt        $v0, $a1, $v1
    /* 5FD70 8006F570 09004014 */  bnez       $v0, .L8006F598
    /* 5FD74 8006F574 00000000 */   nop
    /* 5FD78 8006F578 66BD0108 */  j          .L8006F598
    /* 5FD7C 8006F57C 2328A300 */   subu      $a1, $a1, $v1
  .L8006F580:
    /* 5FD80 8006F580 0500A104 */  bgez       $a1, .L8006F598
    /* 5FD84 8006F584 00000000 */   nop
    /* 5FD88 8006F588 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5FD8C 8006F58C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5FD90 8006F590 00000000 */  nop
    /* 5FD94 8006F594 2128A200 */  addu       $a1, $a1, $v0
  .L8006F598:
    /* 5FD98 8006F598 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5FD9C 8006F59C A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5FDA0 8006F5A0 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5FDA4 8006F5A4 00000000 */   nop
    /* 5FDA8 8006F5A8 21184000 */  addu       $v1, $v0, $zero
    /* 5FDAC 8006F5AC 2A100302 */  slt        $v0, $s0, $v1
    /* 5FDB0 8006F5B0 02004010 */  beqz       $v0, .L8006F5BC
    /* 5FDB4 8006F5B4 00000000 */   nop
    /* 5FDB8 8006F5B8 21806000 */  addu       $s0, $v1, $zero
  .L8006F5BC:
    /* 5FDBC 8006F5BC 5405428E */  lw         $v0, 0x554($s2)
    /* 5FDC0 8006F5C0 00000000 */  nop
    /* 5FDC4 8006F5C4 00110200 */  sll        $v0, $v0, 4
    /* 5FDC8 8006F5C8 09004004 */  bltz       $v0, .L8006F5F0
    /* 5FDCC 8006F5CC 21282202 */   addu      $a1, $s1, $v0
    /* 5FDD0 8006F5D0 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5FDD4 8006F5D4 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5FDD8 8006F5D8 00000000 */  nop
    /* 5FDDC 8006F5DC 2A10A300 */  slt        $v0, $a1, $v1
    /* 5FDE0 8006F5E0 09004014 */  bnez       $v0, .L8006F608
    /* 5FDE4 8006F5E4 00000000 */   nop
    /* 5FDE8 8006F5E8 82BD0108 */  j          .L8006F608
    /* 5FDEC 8006F5EC 2328A300 */   subu      $a1, $a1, $v1
  .L8006F5F0:
    /* 5FDF0 8006F5F0 0500A104 */  bgez       $a1, .L8006F608
    /* 5FDF4 8006F5F4 00000000 */   nop
    /* 5FDF8 8006F5F8 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5FDFC 8006F5FC C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5FE00 8006F600 00000000 */  nop
    /* 5FE04 8006F604 2128A200 */  addu       $a1, $a1, $v0
  .L8006F608:
    /* 5FE08 8006F608 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5FE0C 8006F60C A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5FE10 8006F610 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5FE14 8006F614 00000000 */   nop
    /* 5FE18 8006F618 21184000 */  addu       $v1, $v0, $zero
    /* 5FE1C 8006F61C 2A100302 */  slt        $v0, $s0, $v1
    /* 5FE20 8006F620 02004010 */  beqz       $v0, .L8006F62C
    /* 5FE24 8006F624 00000000 */   nop
    /* 5FE28 8006F628 21806000 */  addu       $s0, $v1, $zero
  .L8006F62C:
    /* 5FE2C 8006F62C 5405438E */  lw         $v1, 0x554($s2)
    /* 5FE30 8006F630 00000000 */  nop
    /* 5FE34 8006F634 80100300 */  sll        $v0, $v1, 2
    /* 5FE38 8006F638 21104300 */  addu       $v0, $v0, $v1
    /* 5FE3C 8006F63C 80100200 */  sll        $v0, $v0, 2
    /* 5FE40 8006F640 09004004 */  bltz       $v0, .L8006F668
    /* 5FE44 8006F644 21282202 */   addu      $a1, $s1, $v0
    /* 5FE48 8006F648 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5FE4C 8006F64C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5FE50 8006F650 00000000 */  nop
    /* 5FE54 8006F654 2A10A300 */  slt        $v0, $a1, $v1
    /* 5FE58 8006F658 09004014 */  bnez       $v0, .L8006F680
    /* 5FE5C 8006F65C 00000000 */   nop
    /* 5FE60 8006F660 A0BD0108 */  j          .L8006F680
    /* 5FE64 8006F664 2328A300 */   subu      $a1, $a1, $v1
  .L8006F668:
    /* 5FE68 8006F668 0500A104 */  bgez       $a1, .L8006F680
    /* 5FE6C 8006F66C 00000000 */   nop
    /* 5FE70 8006F670 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5FE74 8006F674 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5FE78 8006F678 00000000 */  nop
    /* 5FE7C 8006F67C 2128A200 */  addu       $a1, $a1, $v0
  .L8006F680:
    /* 5FE80 8006F680 1480043C */  lui        $a0, %hi(AIDataRecord_TrackCurve)
    /* 5FE84 8006F684 A4C5848C */  lw         $a0, %lo(AIDataRecord_TrackCurve)($a0)
    /* 5FE88 8006F688 E9B4010C */  jal        Get__25AIDataRecord_TrackCurve_ti
    /* 5FE8C 8006F68C 00000000 */   nop
    /* 5FE90 8006F690 21184000 */  addu       $v1, $v0, $zero
    /* 5FE94 8006F694 2A100302 */  slt        $v0, $s0, $v1
    /* 5FE98 8006F698 02004010 */  beqz       $v0, .L8006F6A4
    /* 5FE9C 8006F69C 0100023C */   lui       $v0, (0x1A666 >> 16)
    /* 5FEA0 8006F6A0 21806000 */  addu       $s0, $v1, $zero
  .L8006F6A4:
    /* 5FEA4 8006F6A4 66A64234 */  ori        $v0, $v0, (0x1A666 & 0xFFFF)
    /* 5FEA8 8006F6A8 18000202 */  mult       $s0, $v0
    /* 5FEAC 8006F6AC 12280000 */  mflo       $a1
    /* 5FEB0 8006F6B0 0400A104 */  bgez       $a1, .L8006F6C4
    /* 5FEB4 8006F6B4 03840500 */   sra       $s0, $a1, 16
    /* 5FEB8 8006F6B8 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5FEBC 8006F6BC 2128A200 */  addu       $a1, $a1, $v0
    /* 5FEC0 8006F6C0 03840500 */  sra        $s0, $a1, 16
  .L8006F6C4:
    /* 5FEC4 8006F6C4 0001022A */  slti       $v0, $s0, 0x100
    /* 5FEC8 8006F6C8 02004014 */  bnez       $v0, .L8006F6D4
    /* 5FECC 8006F6CC 00000000 */   nop
    /* 5FED0 8006F6D0 FF001024 */  addiu      $s0, $zero, 0xFF
  .L8006F6D4:
    /* 5FED4 8006F6D4 B406448E */  lw         $a0, 0x6B4($s2)
    /* 5FED8 8006F6D8 13B5010C */  jal        Get__30AIDataRecord_CurveSpeedTable_ti
    /* 5FEDC 8006F6DC 21280002 */   addu      $a1, $s0, $zero
    /* 5FEE0 8006F6E0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 5FEE4 8006F6E4 1800B28F */  lw         $s2, 0x18($sp)
    /* 5FEE8 8006F6E8 1400B18F */  lw         $s1, 0x14($sp)
    /* 5FEEC 8006F6EC 1000B08F */  lw         $s0, 0x10($sp)
    /* 5FEF0 8006F6F0 0800E003 */  jr         $ra
    /* 5FEF4 8006F6F4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
