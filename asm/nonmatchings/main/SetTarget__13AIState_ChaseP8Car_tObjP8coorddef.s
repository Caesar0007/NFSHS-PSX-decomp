.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetTarget__13AIState_ChaseP8Car_tObjP8coorddef, 0xE0

glabel SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
    /* 6058C 8006FD8C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 60590 8006FD90 1000B0AF */  sw         $s0, 0x10($sp)
    /* 60594 8006FD94 21808000 */  addu       $s0, $a0, $zero
    /* 60598 8006FD98 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6059C 8006FD9C 2188A000 */  addu       $s1, $a1, $zero
    /* 605A0 8006FDA0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 605A4 8006FDA4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 605A8 8006FDA8 4800028E */  lw         $v0, 0x48($s0)
    /* 605AC 8006FDAC 00000000 */  nop
    /* 605B0 8006FDB0 03005110 */  beq        $v0, $s1, .L8006FDC0
    /* 605B4 8006FDB4 2190C000 */   addu      $s2, $a2, $zero
    /* 605B8 8006FDB8 976A010C */  jal        SetNewTargetCar__10AIDelayCarP8Car_tObj
    /* 605BC 8006FDBC 08000426 */   addiu     $a0, $s0, 0x8
  .L8006FDC0:
    /* 605C0 8006FDC0 480011AE */  sw         $s1, 0x48($s0)
    /* 605C4 8006FDC4 0000478E */  lw         $a3, 0x0($s2)
    /* 605C8 8006FDC8 0400488E */  lw         $t0, 0x4($s2)
    /* 605CC 8006FDCC 0800498E */  lw         $t1, 0x8($s2)
    /* 605D0 8006FDD0 4C0007AE */  sw         $a3, 0x4C($s0)
    /* 605D4 8006FDD4 500008AE */  sw         $t0, 0x50($s0)
    /* 605D8 8006FDD8 540009AE */  sw         $t1, 0x54($s0)
    /* 605DC 8006FDDC 4800028E */  lw         $v0, 0x48($s0)
    /* 605E0 8006FDE0 580000AE */  sw         $zero, 0x58($s0)
    /* 605E4 8006FDE4 5C0000AE */  sw         $zero, 0x5C($s0)
    /* 605E8 8006FDE8 3401448C */  lw         $a0, 0x134($v0)
    /* 605EC 8006FDEC 4C00038E */  lw         $v1, 0x4C($s0)
    /* 605F0 8006FDF0 23100400 */  negu       $v0, $a0
    /* 605F4 8006FDF4 2A106200 */  slt        $v0, $v1, $v0
    /* 605F8 8006FDF8 04004014 */  bnez       $v0, .L8006FE0C
    /* 605FC 8006FDFC FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 60600 8006FE00 2A108300 */  slt        $v0, $a0, $v1
    /* 60604 8006FE04 02004010 */  beqz       $v0, .L8006FE10
    /* 60608 8006FE08 01000224 */   addiu     $v0, $zero, 0x1
  .L8006FE0C:
    /* 6060C 8006FE0C 5C0002AE */  sw         $v0, 0x5C($s0)
  .L8006FE10:
    /* 60610 8006FE10 4800028E */  lw         $v0, 0x48($s0)
    /* 60614 8006FE14 00000000 */  nop
    /* 60618 8006FE18 3C01448C */  lw         $a0, 0x13C($v0)
    /* 6061C 8006FE1C 5400038E */  lw         $v1, 0x54($s0)
    /* 60620 8006FE20 23100400 */  negu       $v0, $a0
    /* 60624 8006FE24 2A106200 */  slt        $v0, $v1, $v0
    /* 60628 8006FE28 04004014 */  bnez       $v0, .L8006FE3C
    /* 6062C 8006FE2C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 60630 8006FE30 2A108300 */  slt        $v0, $a0, $v1
    /* 60634 8006FE34 02004010 */  beqz       $v0, .L8006FE40
    /* 60638 8006FE38 01000224 */   addiu     $v0, $zero, 0x1
  .L8006FE3C:
    /* 6063C 8006FE3C 580002AE */  sw         $v0, 0x58($s0)
  .L8006FE40:
    /* 60640 8006FE40 21200002 */  addu       $a0, $s0, $zero
    /* 60644 8006FE44 700080AC */  sw         $zero, 0x70($a0)
    /* 60648 8006FE48 740080AC */  sw         $zero, 0x74($a0)
    /* 6064C 8006FE4C A6BF010C */  jal        SetUp__13AIState_Chase
    /* 60650 8006FE50 780080AC */   sw        $zero, 0x78($a0)
    /* 60654 8006FE54 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 60658 8006FE58 1800B28F */  lw         $s2, 0x18($sp)
    /* 6065C 8006FE5C 1400B18F */  lw         $s1, 0x14($sp)
    /* 60660 8006FE60 1000B08F */  lw         $s0, 0x10($sp)
    /* 60664 8006FE64 0800E003 */  jr         $ra
    /* 60668 8006FE68 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
