.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_SetAnimationTime__FP15Trk_AnimateInstPii, 0x140

glabel DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
    /* B7EC8 800C76C8 03008290 */  lbu        $v0, 0x3($a0)
    /* B7ECC 800C76CC 00000000 */  nop
    /* B7ED0 800C76D0 FFFF4424 */  addiu      $a0, $v0, -0x1
    /* B7ED4 800C76D4 1280023C */  lui        $v0, %hi(animation_timer)
    /* B7ED8 800C76D8 18F74224 */  addiu      $v0, $v0, %lo(animation_timer)
    /* B7EDC 800C76DC 80180400 */  sll        $v1, $a0, 2
    /* B7EE0 800C76E0 21186200 */  addu       $v1, $v1, $v0
    /* B7EE4 800C76E4 0000628C */  lw         $v0, 0x0($v1)
    /* B7EE8 800C76E8 00000000 */  nop
    /* B7EEC 800C76EC 010F4228 */  slti       $v0, $v0, 0xF01
    /* B7EF0 800C76F0 1C004014 */  bnez       $v0, .L800C7764
    /* B7EF4 800C76F4 1280023C */   lui       $v0, %hi(animation_timer)
    /* B7EF8 800C76F8 21380000 */  addu       $a3, $zero, $zero
    /* B7EFC 800C76FC 1480083C */  lui        $t0, %hi(Cars_gNumHumanRaceCars)
    /* B7F00 800C7700 00C8088D */  lw         $t0, %lo(Cars_gNumHumanRaceCars)($t0)
    /* B7F04 800C7704 C0100400 */  sll        $v0, $a0, 3
    /* B7F08 800C7708 21284500 */  addu       $a1, $v0, $a1
    /* B7F0C 800C770C 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* B7F10 800C7710 48FA4624 */  addiu      $a2, $v0, %lo(Cars_gHumanRaceCarList)
  .L800C7714:
    /* B7F14 800C7714 2A10E800 */  slt        $v0, $a3, $t0
    /* B7F18 800C7718 39004010 */  beqz       $v0, .L800C7800
    /* B7F1C 800C771C 00000000 */   nop
    /* B7F20 800C7720 0000C28C */  lw         $v0, 0x0($a2)
    /* B7F24 800C7724 00000000 */  nop
    /* B7F28 800C7728 08004484 */  lh         $a0, 0x8($v0)
    /* B7F2C 800C772C 0000A28C */  lw         $v0, 0x0($a1)
    /* B7F30 800C7730 00000000 */  nop
    /* B7F34 800C7734 2A108200 */  slt        $v0, $a0, $v0
    /* B7F38 800C7738 06004014 */  bnez       $v0, .L800C7754
    /* B7F3C 800C773C 00000000 */   nop
    /* B7F40 800C7740 0400A28C */  lw         $v0, 0x4($a1)
    /* B7F44 800C7744 00000000 */  nop
    /* B7F48 800C7748 2A104400 */  slt        $v0, $v0, $a0
    /* B7F4C 800C774C 02004010 */  beqz       $v0, .L800C7758
    /* B7F50 800C7750 00000000 */   nop
  .L800C7754:
    /* B7F54 800C7754 000060AC */  sw         $zero, 0x0($v1)
  .L800C7758:
    /* B7F58 800C7758 0400C624 */  addiu      $a2, $a2, 0x4
    /* B7F5C 800C775C C51D0308 */  j          .L800C7714
    /* B7F60 800C7760 0100E724 */   addiu     $a3, $a3, 0x1
  .L800C7764:
    /* B7F64 800C7764 18F74224 */  addiu      $v0, $v0, %lo(animation_timer)
    /* B7F68 800C7768 80180400 */  sll        $v1, $a0, 2
    /* B7F6C 800C776C 21186200 */  addu       $v1, $v1, $v0
    /* B7F70 800C7770 0000628C */  lw         $v0, 0x0($v1)
    /* B7F74 800C7774 00000000 */  nop
    /* B7F78 800C7778 04004018 */  blez       $v0, .L800C778C
    /* B7F7C 800C777C 21380000 */   addu      $a3, $zero, $zero
    /* B7F80 800C7780 01004224 */  addiu      $v0, $v0, 0x1
    /* B7F84 800C7784 0800E003 */  jr         $ra
    /* B7F88 800C7788 000062AC */   sw        $v0, 0x0($v1)
  .L800C778C:
    /* B7F8C 800C778C 1480083C */  lui        $t0, %hi(Cars_gNumHumanRaceCars)
    /* B7F90 800C7790 00C8088D */  lw         $t0, %lo(Cars_gNumHumanRaceCars)($t0)
    /* B7F94 800C7794 C0100400 */  sll        $v0, $a0, 3
    /* B7F98 800C7798 21284500 */  addu       $a1, $v0, $a1
    /* B7F9C 800C779C 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* B7FA0 800C77A0 48FA4624 */  addiu      $a2, $v0, %lo(Cars_gHumanRaceCarList)
  .L800C77A4:
    /* B7FA4 800C77A4 2A10E800 */  slt        $v0, $a3, $t0
    /* B7FA8 800C77A8 15004010 */  beqz       $v0, .L800C7800
    /* B7FAC 800C77AC 00000000 */   nop
    /* B7FB0 800C77B0 0000C28C */  lw         $v0, 0x0($a2)
    /* B7FB4 800C77B4 00000000 */  nop
    /* B7FB8 800C77B8 08004484 */  lh         $a0, 0x8($v0)
    /* B7FBC 800C77BC 0000A28C */  lw         $v0, 0x0($a1)
    /* B7FC0 800C77C0 00000000 */  nop
    /* B7FC4 800C77C4 2A108200 */  slt        $v0, $a0, $v0
    /* B7FC8 800C77C8 0A004014 */  bnez       $v0, .L800C77F4
    /* B7FCC 800C77CC 00000000 */   nop
    /* B7FD0 800C77D0 0400A28C */  lw         $v0, 0x4($a1)
    /* B7FD4 800C77D4 00000000 */  nop
    /* B7FD8 800C77D8 2A104400 */  slt        $v0, $v0, $a0
    /* B7FDC 800C77DC 05004014 */  bnez       $v0, .L800C77F4
    /* B7FE0 800C77E0 00000000 */   nop
    /* B7FE4 800C77E4 0000628C */  lw         $v0, 0x0($v1)
    /* B7FE8 800C77E8 00000000 */  nop
    /* B7FEC 800C77EC 01004224 */  addiu      $v0, $v0, 0x1
    /* B7FF0 800C77F0 000062AC */  sw         $v0, 0x0($v1)
  .L800C77F4:
    /* B7FF4 800C77F4 0400C624 */  addiu      $a2, $a2, 0x4
    /* B7FF8 800C77F8 E91D0308 */  j          .L800C77A4
    /* B7FFC 800C77FC 0100E724 */   addiu     $a3, $a3, 0x1
  .L800C7800:
    /* B8000 800C7800 0800E003 */  jr         $ra
    /* B8004 800C7804 00000000 */   nop
endlabel DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
