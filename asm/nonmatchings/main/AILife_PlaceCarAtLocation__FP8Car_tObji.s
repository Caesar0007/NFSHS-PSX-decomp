.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_PlaceCarAtLocation__FP8Car_tObji, 0x204

glabel AILife_PlaceCarAtLocation__FP8Car_tObji
    /* 584E0 80067CE0 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 584E4 80067CE4 5000B2AF */  sw         $s2, 0x50($sp)
    /* 584E8 80067CE8 21908000 */  addu       $s2, $a0, $zero
    /* 584EC 80067CEC 5400B3AF */  sw         $s3, 0x54($sp)
    /* 584F0 80067CF0 2198A000 */  addu       $s3, $a1, $zero
    /* 584F4 80067CF4 5800BFAF */  sw         $ra, 0x58($sp)
    /* 584F8 80067CF8 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* 584FC 80067CFC 4800B0AF */  sw         $s0, 0x48($sp)
    /* 58500 80067D00 5805438E */  lw         $v1, 0x558($s2)
    /* 58504 80067D04 6405458E */  lw         $a1, 0x564($s2)
    /* 58508 80067D08 01000224 */  addiu      $v0, $zero, 0x1
    /* 5850C 80067D0C 910042A2 */  sb         $v0, 0x91($s2)
    /* 58510 80067D10 180743AE */  sw         $v1, 0x718($s2)
    /* 58514 80067D14 15B3010C */  jal        AIPhysic_ResetCar__FP8Car_tObj
    /* 58518 80067D18 5C0545AE */   sw        $a1, 0x55C($s2)
    /* 5851C 80067D1C 1480023C */  lui        $v0, %hi(stackSpeedUpEnbabledFlag)
    /* 58520 80067D20 1CD8428C */  lw         $v0, %lo(stackSpeedUpEnbabledFlag)($v0)
    /* 58524 80067D24 00000000 */  nop
    /* 58528 80067D28 16004010 */  beqz       $v0, .L80067D84
    /* 5852C 80067D2C 00000000 */   nop
    /* 58530 80067D30 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 58534 80067D34 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 58538 80067D38 2B91030C */  jal        SetSp
    /* 5853C 80067D3C 00000000 */   nop
    /* 58540 80067D40 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 58544 80067D44 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 58548 80067D48 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 5854C 80067D4C 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 58550 80067D50 239F010C */  jal        AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
    /* 58554 80067D54 21204002 */   addu      $a0, $s2, $zero
    /* 58558 80067D58 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 5855C 80067D5C 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 58560 80067D60 2B91030C */  jal        SetSp
    /* 58564 80067D64 00000000 */   nop
    /* 58568 80067D68 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 5856C 80067D6C 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 58570 80067D70 01000224 */  addiu      $v0, $zero, 0x1
    /* 58574 80067D74 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 58578 80067D78 1CD822AC */  sw         $v0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 5857C 80067D7C 639F0108 */  j          .L80067D8C
    /* 58580 80067D80 00000000 */   nop
  .L80067D84:
    /* 58584 80067D84 239F010C */  jal        AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
    /* 58588 80067D88 21204002 */   addu      $a0, $s2, $zero
  .L80067D8C:
    /* 5858C 80067D8C 6405428E */  lw         $v0, 0x564($s2)
    /* 58590 80067D90 00000000 */  nop
    /* 58594 80067D94 18004010 */  beqz       $v0, .L80067DF8
    /* 58598 80067D98 1000A427 */   addiu     $a0, $sp, 0x10
    /* 5859C 80067D9C 0801478E */  lw         $a3, 0x108($s2)
    /* 585A0 80067DA0 0C01488E */  lw         $t0, 0x10C($s2)
    /* 585A4 80067DA4 1001498E */  lw         $t1, 0x110($s2)
    /* 585A8 80067DA8 1000A7AF */  sw         $a3, 0x10($sp)
    /* 585AC 80067DAC 1400A8AF */  sw         $t0, 0x14($sp)
    /* 585B0 80067DB0 1800A9AF */  sw         $t1, 0x18($sp)
    /* 585B4 80067DB4 6405508E */  lw         $s0, 0x564($s2)
    /* 585B8 80067DB8 1000A58F */  lw         $a1, 0x10($sp)
    /* 585BC 80067DBC 02000106 */  bgez       $s0, .L80067DC8
    /* 585C0 80067DC0 00000000 */   nop
    /* 585C4 80067DC4 23801000 */  negu       $s0, $s0
  .L80067DC8:
    /* 585C8 80067DC8 CA90030C */  jal        fixedmult
    /* 585CC 80067DCC 21200002 */   addu      $a0, $s0, $zero
    /* 585D0 80067DD0 1400A58F */  lw         $a1, 0x14($sp)
    /* 585D4 80067DD4 21200002 */  addu       $a0, $s0, $zero
    /* 585D8 80067DD8 CA90030C */  jal        fixedmult
    /* 585DC 80067DDC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 585E0 80067DE0 1800A58F */  lw         $a1, 0x18($sp)
    /* 585E4 80067DE4 21200002 */  addu       $a0, $s0, $zero
    /* 585E8 80067DE8 CA90030C */  jal        fixedmult
    /* 585EC 80067DEC 1400A2AF */   sw        $v0, 0x14($sp)
    /* 585F0 80067DF0 819F0108 */  j          .L80067E04
    /* 585F4 80067DF4 1800A2AF */   sw        $v0, 0x18($sp)
  .L80067DF8:
    /* 585F8 80067DF8 21280000 */  addu       $a1, $zero, $zero
    /* 585FC 80067DFC C690030C */  jal        memset
    /* 58600 80067E00 0C000624 */   addiu     $a2, $zero, 0xC
  .L80067E04:
    /* 58604 80067E04 1000A78F */  lw         $a3, 0x10($sp)
    /* 58608 80067E08 1400A88F */  lw         $t0, 0x14($sp)
    /* 5860C 80067E0C 1800A98F */  lw         $t1, 0x18($sp)
    /* 58610 80067E10 AC0047AE */  sw         $a3, 0xAC($s2)
    /* 58614 80067E14 B00048AE */  sw         $t0, 0xB0($s2)
    /* 58618 80067E18 B40049AE */  sw         $t1, 0xB4($s2)
    /* 5861C 80067E1C 6002428E */  lw         $v0, 0x260($s2)
    /* 58620 80067E20 00000000 */  nop
    /* 58624 80067E24 04004230 */  andi       $v0, $v0, 0x4
    /* 58628 80067E28 04004010 */  beqz       $v0, .L80067E3C
    /* 5862C 80067E2C 2000B127 */   addiu     $s1, $sp, 0x20
    /* 58630 80067E30 8FA9020C */  jal        Physics_ResetCar__FP8Car_tObj
    /* 58634 80067E34 21204002 */   addu      $a0, $s2, $zero
    /* 58638 80067E38 2000B127 */  addiu      $s1, $sp, 0x20
  .L80067E3C:
    /* 5863C 80067E3C 21202002 */  addu       $a0, $s1, $zero
    /* 58640 80067E40 B196030C */  jal        xformy
    /* 58644 80067E44 21286002 */   addu      $a1, $s3, $zero
    /* 58648 80067E48 F0005026 */  addiu      $s0, $s2, 0xF0
    /* 5864C 80067E4C 21200002 */  addu       $a0, $s0, $zero
    /* 58650 80067E50 21282002 */  addu       $a1, $s1, $zero
    /* 58654 80067E54 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 58658 80067E58 21300002 */   addu      $a2, $s0, $zero
    /* 5865C 80067E5C C4014226 */  addiu      $v0, $s2, 0x1C4
    /* 58660 80067E60 10014326 */  addiu      $v1, $s2, 0x110
  .L80067E64:
    /* 58664 80067E64 0000078E */  lw         $a3, 0x0($s0)
    /* 58668 80067E68 0400088E */  lw         $t0, 0x4($s0)
    /* 5866C 80067E6C 0800098E */  lw         $t1, 0x8($s0)
    /* 58670 80067E70 0C000A8E */  lw         $t2, 0xC($s0)
    /* 58674 80067E74 000047AC */  sw         $a3, 0x0($v0)
    /* 58678 80067E78 040048AC */  sw         $t0, 0x4($v0)
    /* 5867C 80067E7C 080049AC */  sw         $t1, 0x8($v0)
    /* 58680 80067E80 0C004AAC */  sw         $t2, 0xC($v0)
    /* 58684 80067E84 10001026 */  addiu      $s0, $s0, 0x10
    /* 58688 80067E88 F6FF0316 */  bne        $s0, $v1, .L80067E64
    /* 5868C 80067E8C 10004224 */   addiu     $v0, $v0, 0x10
    /* 58690 80067E90 21204002 */  addu       $a0, $s2, $zero
    /* 58694 80067E94 0000078E */  lw         $a3, 0x0($s0)
    /* 58698 80067E98 5D9C010C */  jal        AIInit_ClearAICar__FP8Car_tObj
    /* 5869C 80067E9C 000047AC */   sw        $a3, 0x0($v0)
    /* 586A0 80067EA0 B22B020C */  jal        Cars_CalculateRoadPosition__FP8Car_tObj
    /* 586A4 80067EA4 21204002 */   addu      $a0, $s2, $zero
    /* 586A8 80067EA8 21204002 */  addu       $a0, $s2, $zero
    /* 586AC 80067EAC 180742AE */  sw         $v0, 0x718($s2)
    /* 586B0 80067EB0 580542AE */  sw         $v0, 0x558($s2)
    /* 586B4 80067EB4 202B020C */  jal        Cars_CalculateRoadSpan__FP8Car_tObj
    /* 586B8 80067EB8 740542AE */   sw        $v0, 0x574($s2)
    /* 586BC 80067EBC 21204002 */  addu       $a0, $s2, $zero
    /* 586C0 80067EC0 65CD010C */  jal        AIWorld_CalculateLaneInfo__FP8Car_tObj
    /* 586C4 80067EC4 6C0282AC */   sw        $v0, 0x26C($a0)
    /* 586C8 80067EC8 5800BF8F */  lw         $ra, 0x58($sp)
    /* 586CC 80067ECC 5400B38F */  lw         $s3, 0x54($sp)
    /* 586D0 80067ED0 5000B28F */  lw         $s2, 0x50($sp)
    /* 586D4 80067ED4 4C00B18F */  lw         $s1, 0x4C($sp)
    /* 586D8 80067ED8 4800B08F */  lw         $s0, 0x48($sp)
    /* 586DC 80067EDC 0800E003 */  jr         $ra
    /* 586E0 80067EE0 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel AILife_PlaceCarAtLocation__FP8Car_tObji
