.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcDesiredSpeed__FP8Car_tObj, 0xA4

glabel AISpeeds_CalcDesiredSpeed__FP8Car_tObj
    /* 5F5DC 8006EDDC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5F5E0 8006EDE0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F5E4 8006EDE4 21808000 */  addu       $s0, $a0, $zero
    /* 5F5E8 8006EDE8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5F5EC 8006EDEC 6002038E */  lw         $v1, 0x260($s0)
    /* 5F5F0 8006EDF0 00000000 */  nop
    /* 5F5F4 8006EDF4 08006230 */  andi       $v0, $v1, 0x8
    /* 5F5F8 8006EDF8 05004010 */  beqz       $v0, .L8006EE10
    /* 5F5FC 8006EDFC 5C0500AE */   sw        $zero, 0x55C($s0)
    /* 5F600 8006EE00 4EB6010C */  jal        AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
    /* 5F604 8006EE04 60050526 */   addiu     $a1, $s0, 0x560
    /* 5F608 8006EE08 9CBB0108 */  j          .L8006EE70
    /* 5F60C 8006EE0C 5C0502AE */   sw        $v0, 0x55C($s0)
  .L8006EE10:
    /* 5F610 8006EE10 20006230 */  andi       $v0, $v1, 0x20
    /* 5F614 8006EE14 10004010 */  beqz       $v0, .L8006EE58
    /* 5F618 8006EE18 10006230 */   andi      $v0, $v1, 0x10
    /* 5F61C 8006EE1C 7005028E */  lw         $v0, 0x570($s0)
    /* 5F620 8006EE20 00000000 */  nop
    /* 5F624 8006EE24 02004230 */  andi       $v0, $v0, 0x2
    /* 5F628 8006EE28 05004010 */  beqz       $v0, .L8006EE40
    /* 5F62C 8006EE2C 00000000 */   nop
    /* 5F630 8006EE30 A9BA010C */  jal        AISpeeds_CalcCopTopSpeed__FP8Car_tObj
    /* 5F634 8006EE34 21200002 */   addu      $a0, $s0, $zero
    /* 5F638 8006EE38 93BB0108 */  j          .L8006EE4C
    /* 5F63C 8006EE3C 5C0502AE */   sw        $v0, 0x55C($s0)
  .L8006EE40:
    /* 5F640 8006EE40 DBBA010C */  jal        AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
    /* 5F644 8006EE44 21200002 */   addu      $a0, $s0, $zero
    /* 5F648 8006EE48 5C0502AE */  sw         $v0, 0x55C($s0)
  .L8006EE4C:
    /* 5F64C 8006EE4C 5C05028E */  lw         $v0, 0x55C($s0)
    /* 5F650 8006EE50 9CBB0108 */  j          .L8006EE70
    /* 5F654 8006EE54 600502AE */   sw        $v0, 0x560($s0)
  .L8006EE58:
    /* 5F658 8006EE58 05004010 */  beqz       $v0, .L8006EE70
    /* 5F65C 8006EE5C 00000000 */   nop
    /* 5F660 8006EE60 DBBA010C */  jal        AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
    /* 5F664 8006EE64 21200002 */   addu      $a0, $s0, $zero
    /* 5F668 8006EE68 5C0502AE */  sw         $v0, 0x55C($s0)
    /* 5F66C 8006EE6C 600502AE */  sw         $v0, 0x560($s0)
  .L8006EE70:
    /* 5F670 8006EE70 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5F674 8006EE74 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F678 8006EE78 0800E003 */  jr         $ra
    /* 5F67C 8006EE7C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AISpeeds_CalcDesiredSpeed__FP8Car_tObj
