.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii, 0x184

glabel AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
    /* 58CD4 800684D4 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 58CD8 800684D8 6000B2AF */  sw         $s2, 0x60($sp)
    /* 58CDC 800684DC 21908000 */  addu       $s2, $a0, $zero
    /* 58CE0 800684E0 5800B0AF */  sw         $s0, 0x58($sp)
    /* 58CE4 800684E4 2180A000 */  addu       $s0, $a1, $zero
    /* 58CE8 800684E8 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 58CEC 800684EC 2188C000 */  addu       $s1, $a2, $zero
    /* 58CF0 800684F0 6400B3AF */  sw         $s3, 0x64($sp)
    /* 58CF4 800684F4 2198E000 */  addu       $s3, $a3, $zero
    /* 58CF8 800684F8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 58CFC 800684FC 21280000 */  addu       $a1, $zero, $zero
    /* 58D00 80068500 6800BFAF */  sw         $ra, 0x68($sp)
    /* 58D04 80068504 C690030C */  jal        memset
    /* 58D08 80068508 0C000624 */   addiu     $a2, $zero, 0xC
    /* 58D0C 8006850C 2000A427 */  addiu      $a0, $sp, 0x20
    /* 58D10 80068510 21280000 */  addu       $a1, $zero, $zero
    /* 58D14 80068514 C690030C */  jal        memset
    /* 58D18 80068518 0C000624 */   addiu     $a2, $zero, 0xC
    /* 58D1C 8006851C 01000224 */  addiu      $v0, $zero, 0x1
    /* 58D20 80068520 910042A2 */  sb         $v0, 0x91($s2)
    /* 58D24 80068524 1480023C */  lui        $v0, %hi(AITune_oneWay)
    /* 58D28 80068528 F0C5428C */  lw         $v0, %lo(AITune_oneWay)($v0)
    /* 58D2C 8006852C 00000000 */  nop
    /* 58D30 80068530 07004010 */  beqz       $v0, .L80068550
    /* 58D34 80068534 080050A6 */   sh        $s0, 0x8($s2)
    /* 58D38 80068538 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 58D3C 8006853C 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 58D40 80068540 00000000 */  nop
    /* 58D44 80068544 02004014 */  bnez       $v0, .L80068550
    /* 58D48 80068548 FFFF1124 */   addiu     $s1, $zero, -0x1
    /* 58D4C 8006854C 01001124 */  addiu      $s1, $zero, 0x1
  .L80068550:
    /* 58D50 80068550 21204002 */  addu       $a0, $s2, $zero
    /* 58D54 80068554 540551AE */  sw         $s1, 0x554($s2)
    /* 58D58 80068558 500551AE */  sw         $s1, 0x550($s2)
    /* 58D5C 8006855C 5C0540AE */  sw         $zero, 0x55C($s2)
    /* 58D60 80068560 15B3010C */  jal        AIPhysic_ResetCar__FP8Car_tObj
    /* 58D64 80068564 640540AE */   sw        $zero, 0x564($s2)
    /* 58D68 80068568 5405428E */  lw         $v0, 0x554($s2)
    /* 58D6C 8006856C 00000000 */  nop
    /* 58D70 80068570 18006202 */  mult       $s3, $v0
    /* 58D74 80068574 21204002 */  addu       $a0, $s2, $zero
    /* 58D78 80068578 12400000 */  mflo       $t0
    /* 58D7C 8006857C 2000A8AF */  sw         $t0, 0x20($sp)
    /* 58D80 80068580 08004586 */  lh         $a1, 0x8($s2)
    /* 58D84 80068584 5405478E */  lw         $a3, 0x554($s2)
    /* 58D88 80068588 E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 58D8C 8006858C 2000A627 */   addiu     $a2, $sp, 0x20
    /* 58D90 80068590 3000B127 */  addiu      $s1, $sp, 0x30
    /* 58D94 80068594 8000A58F */  lw         $a1, 0x80($sp)
    /* 58D98 80068598 B196030C */  jal        xformy
    /* 58D9C 8006859C 21202002 */   addu      $a0, $s1, $zero
    /* 58DA0 800685A0 F0005026 */  addiu      $s0, $s2, 0xF0
    /* 58DA4 800685A4 21200002 */  addu       $a0, $s0, $zero
    /* 58DA8 800685A8 21282002 */  addu       $a1, $s1, $zero
    /* 58DAC 800685AC 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 58DB0 800685B0 21300002 */   addu      $a2, $s0, $zero
    /* 58DB4 800685B4 C4014226 */  addiu      $v0, $s2, 0x1C4
    /* 58DB8 800685B8 10014326 */  addiu      $v1, $s2, 0x110
  .L800685BC:
    /* 58DBC 800685BC 0000098E */  lw         $t1, 0x0($s0)
    /* 58DC0 800685C0 04000A8E */  lw         $t2, 0x4($s0)
    /* 58DC4 800685C4 08000B8E */  lw         $t3, 0x8($s0)
    /* 58DC8 800685C8 0C00088E */  lw         $t0, 0xC($s0)
    /* 58DCC 800685CC 000049AC */  sw         $t1, 0x0($v0)
    /* 58DD0 800685D0 04004AAC */  sw         $t2, 0x4($v0)
    /* 58DD4 800685D4 08004BAC */  sw         $t3, 0x8($v0)
    /* 58DD8 800685D8 0C0048AC */  sw         $t0, 0xC($v0)
    /* 58DDC 800685DC 10001026 */  addiu      $s0, $s0, 0x10
    /* 58DE0 800685E0 F6FF0316 */  bne        $s0, $v1, .L800685BC
    /* 58DE4 800685E4 10004224 */   addiu     $v0, $v0, 0x10
    /* 58DE8 800685E8 0000098E */  lw         $t1, 0x0($s0)
    /* 58DEC 800685EC 00000000 */  nop
    /* 58DF0 800685F0 000049AC */  sw         $t1, 0x0($v0)
    /* 58DF4 800685F4 1000A98F */  lw         $t1, 0x10($sp)
    /* 58DF8 800685F8 1400AA8F */  lw         $t2, 0x14($sp)
    /* 58DFC 800685FC 1800AB8F */  lw         $t3, 0x18($sp)
    /* 58E00 80068600 AC0049AE */  sw         $t1, 0xAC($s2)
    /* 58E04 80068604 B0004AAE */  sw         $t2, 0xB0($s2)
    /* 58E08 80068608 B4004BAE */  sw         $t3, 0xB4($s2)
    /* 58E0C 8006860C 5D9C010C */  jal        AIInit_ClearAICar__FP8Car_tObj
    /* 58E10 80068610 21204002 */   addu      $a0, $s2, $zero
    /* 58E14 80068614 B22B020C */  jal        Cars_CalculateRoadPosition__FP8Car_tObj
    /* 58E18 80068618 21204002 */   addu      $a0, $s2, $zero
    /* 58E1C 8006861C 21204002 */  addu       $a0, $s2, $zero
    /* 58E20 80068620 180742AE */  sw         $v0, 0x718($s2)
    /* 58E24 80068624 580542AE */  sw         $v0, 0x558($s2)
    /* 58E28 80068628 202B020C */  jal        Cars_CalculateRoadSpan__FP8Car_tObj
    /* 58E2C 8006862C 740542AE */   sw        $v0, 0x574($s2)
    /* 58E30 80068630 21204002 */  addu       $a0, $s2, $zero
    /* 58E34 80068634 65CD010C */  jal        AIWorld_CalculateLaneInfo__FP8Car_tObj
    /* 58E38 80068638 6C0282AC */   sw        $v0, 0x26C($a0)
    /* 58E3C 8006863C 6800BF8F */  lw         $ra, 0x68($sp)
    /* 58E40 80068640 6400B38F */  lw         $s3, 0x64($sp)
    /* 58E44 80068644 6000B28F */  lw         $s2, 0x60($sp)
    /* 58E48 80068648 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 58E4C 8006864C 5800B08F */  lw         $s0, 0x58($sp)
    /* 58E50 80068650 0800E003 */  jr         $ra
    /* 58E54 80068654 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
