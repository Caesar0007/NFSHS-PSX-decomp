.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching psxdevelopmentsystem, 0x2C

glabel psxdevelopmentsystem
    /* F74F0 80106CF0 86000494 */  lhu        $a0, 0x86($zero)
    /* F74F4 80106CF4 5A370224 */  addiu      $v0, $zero, 0x375A
    /* F74F8 80106CF8 05008210 */  beq        $a0, $v0, .L80106D10
    /* F74FC 80106CFC 5A270324 */   addiu     $v1, $zero, 0x275A
    /* F7500 80106D00 04008310 */  beq        $a0, $v1, .L80106D14
    /* F7504 80106D04 21100000 */   addu      $v0, $zero, $zero
    /* F7508 80106D08 0800E003 */  jr         $ra
    /* F750C 80106D0C FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80106D10:
    /* F7510 80106D10 01000224 */  addiu      $v0, $zero, 0x1
  .L80106D14:
    /* F7514 80106D14 0800E003 */  jr         $ra
    /* F7518 80106D18 00000000 */   nop
endlabel psxdevelopmentsystem
