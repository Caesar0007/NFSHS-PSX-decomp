.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__14AIState_Cruise, 0xD4

glabel Execute__14AIState_Cruise
    /* 62D88 80072588 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62D8C 8007258C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 62D90 80072590 21808000 */  addu       $s0, $a0, $zero
    /* 62D94 80072594 1400BFAF */  sw         $ra, 0x14($sp)
    /* 62D98 80072598 0800038E */  lw         $v1, 0x8($s0)
    /* 62D9C 8007259C 01000224 */  addiu      $v0, $zero, 0x1
    /* 62DA0 800725A0 13006210 */  beq        $v1, $v0, .L800725F0
    /* 62DA4 800725A4 02006228 */   slti      $v0, $v1, 0x2
    /* 62DA8 800725A8 05004010 */  beqz       $v0, .L800725C0
    /* 62DAC 800725AC 02000224 */   addiu     $v0, $zero, 0x2
    /* 62DB0 800725B0 07006010 */  beqz       $v1, .L800725D0
    /* 62DB4 800725B4 00000000 */   nop
    /* 62DB8 800725B8 8AC90108 */  j          .L80072628
    /* 62DBC 800725BC 00000000 */   nop
  .L800725C0:
    /* 62DC0 800725C0 16006210 */  beq        $v1, $v0, .L8007261C
    /* 62DC4 800725C4 00000000 */   nop
    /* 62DC8 800725C8 8AC90108 */  j          .L80072628
    /* 62DCC 800725CC 00000000 */   nop
  .L800725D0:
    /* 62DD0 800725D0 0000048E */  lw         $a0, 0x0($s0)
    /* 62DD4 800725D4 0C00038E */  lw         $v1, 0xC($s0)
    /* 62DD8 800725D8 5405828C */  lw         $v0, 0x554($a0)
    /* 62DDC 800725DC 00000000 */  nop
    /* 62DE0 800725E0 18006200 */  mult       $v1, $v0
    /* 62DE4 800725E4 12300000 */  mflo       $a2
    /* 62DE8 800725E8 8AC90108 */  j          .L80072628
    /* 62DEC 800725EC 5C0586AC */   sw        $a2, 0x55C($a0)
  .L800725F0:
    /* 62DF0 800725F0 0000048E */  lw         $a0, 0x0($s0)
    /* 62DF4 800725F4 77BB010C */  jal        AISpeeds_CalcDesiredSpeed__FP8Car_tObj
    /* 62DF8 800725F8 00000000 */   nop
    /* 62DFC 800725FC 0000028E */  lw         $v0, 0x0($s0)
    /* 62E00 80072600 1000058E */  lw         $a1, 0x10($s0)
    /* 62E04 80072604 5C05448C */  lw         $a0, 0x55C($v0)
    /* 62E08 80072608 CA90030C */  jal        fixedmult
    /* 62E0C 8007260C 00000000 */   nop
    /* 62E10 80072610 0000038E */  lw         $v1, 0x0($s0)
    /* 62E14 80072614 8AC90108 */  j          .L80072628
    /* 62E18 80072618 5C0562AC */   sw        $v0, 0x55C($v1)
  .L8007261C:
    /* 62E1C 8007261C 0000048E */  lw         $a0, 0x0($s0)
    /* 62E20 80072620 DBBA010C */  jal        AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
    /* 62E24 80072624 00000000 */   nop
  .L80072628:
    /* 62E28 80072628 0000048E */  lw         $a0, 0x0($s0)
    /* 62E2C 8007262C 9B5E010C */  jal        AI_GenericBeginCycle__FP8Car_tObj
    /* 62E30 80072630 00000000 */   nop
    /* 62E34 80072634 0000048E */  lw         $a0, 0x0($s0)
    /* 62E38 80072638 A55E010C */  jal        AI_GenericCycle__FP8Car_tObj
    /* 62E3C 8007263C 00000000 */   nop
    /* 62E40 80072640 0000048E */  lw         $a0, 0x0($s0)
    /* 62E44 80072644 BA5E010C */  jal        AI_GenericEndCycle__FP8Car_tObj
    /* 62E48 80072648 00000000 */   nop
    /* 62E4C 8007264C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 62E50 80072650 1000B08F */  lw         $s0, 0x10($sp)
    /* 62E54 80072654 0800E003 */  jr         $ra
    /* 62E58 80072658 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Execute__14AIState_Cruise
