.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Draw321Num__Fiiiiii, 0x1BC

glabel Hud_Draw321Num__Fiiiiii
    /* C84A8 800D7CA8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C84AC 800D7CAC 4000BEAF */  sw         $fp, 0x40($sp)
    /* C84B0 800D7CB0 21F08000 */  addu       $fp, $a0, $zero
    /* C84B4 800D7CB4 3800B6AF */  sw         $s6, 0x38($sp)
    /* C84B8 800D7CB8 21B0E000 */  addu       $s6, $a3, $zero
    /* C84BC 800D7CBC 4400BFAF */  sw         $ra, 0x44($sp)
    /* C84C0 800D7CC0 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* C84C4 800D7CC4 3400B5AF */  sw         $s5, 0x34($sp)
    /* C84C8 800D7CC8 3000B4AF */  sw         $s4, 0x30($sp)
    /* C84CC 800D7CCC 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* C84D0 800D7CD0 2800B2AF */  sw         $s2, 0x28($sp)
    /* C84D4 800D7CD4 2400B1AF */  sw         $s1, 0x24($sp)
    /* C84D8 800D7CD8 2000B0AF */  sw         $s0, 0x20($sp)
    /* C84DC 800D7CDC 4C00A5AF */  sw         $a1, 0x4C($sp)
    /* C84E0 800D7CE0 2000C012 */  beqz       $s6, .L800D7D64
    /* C84E4 800D7CE4 5000A6AF */   sw        $a2, 0x50($sp)
    /* C84E8 800D7CE8 21900000 */  addu       $s2, $zero, $zero
    /* C84EC 800D7CEC 21984002 */  addu       $s3, $s2, $zero
    /* C84F0 800D7CF0 1280023C */  lui        $v0, %hi(Hud_Character)
    /* C84F4 800D7CF4 AC0A4224 */  addiu      $v0, $v0, %lo(Hud_Character)
    /* C84F8 800D7CF8 80180600 */  sll        $v1, $a2, 2
    /* C84FC 800D7CFC 21B86200 */  addu       $s7, $v1, $v0
    /* C8500 800D7D00 21A0A000 */  addu       $s4, $a1, $zero
  .L800D7D04:
    /* C8504 800D7D04 21800000 */  addu       $s0, $zero, $zero
    /* C8508 800D7D08 21A88002 */  addu       $s5, $s4, $zero
    /* C850C 800D7D0C 2188C003 */  addu       $s1, $fp, $zero
  .L800D7D10:
    /* C8510 800D7D10 01000224 */  addiu      $v0, $zero, 0x1
    /* C8514 800D7D14 0000E38E */  lw         $v1, 0x0($s7)
    /* C8518 800D7D18 04104202 */  sllv       $v0, $v0, $s2
    /* C851C 800D7D1C 24186200 */  and        $v1, $v1, $v0
    /* C8520 800D7D20 07006010 */  beqz       $v1, .L800D7D40
    /* C8524 800D7D24 06000224 */   addiu     $v0, $zero, 0x6
    /* C8528 800D7D28 1000A2AF */  sw         $v0, 0x10($sp)
    /* C852C 800D7D2C 04002426 */  addiu      $a0, $s1, 0x4
    /* C8530 800D7D30 0400A526 */  addiu      $a1, $s5, 0x4
    /* C8534 800D7D34 2130C002 */  addu       $a2, $s6, $zero
    /* C8538 800D7D38 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* C853C 800D7D3C 2138C002 */   addu      $a3, $s6, $zero
  .L800D7D40:
    /* C8540 800D7D40 0A003126 */  addiu      $s1, $s1, 0xA
    /* C8544 800D7D44 01001026 */  addiu      $s0, $s0, 0x1
    /* C8548 800D7D48 0500022A */  slti       $v0, $s0, 0x5
    /* C854C 800D7D4C F0FF4014 */  bnez       $v0, .L800D7D10
    /* C8550 800D7D50 01005226 */   addiu     $s2, $s2, 0x1
    /* C8554 800D7D54 01007326 */  addiu      $s3, $s3, 0x1
    /* C8558 800D7D58 0500622A */  slti       $v0, $s3, 0x5
    /* C855C 800D7D5C E9FF4014 */  bnez       $v0, .L800D7D04
    /* C8560 800D7D60 09009426 */   addiu     $s4, $s4, 0x9
  .L800D7D64:
    /* C8564 800D7D64 FDFFC427 */  addiu      $a0, $fp, -0x3
    /* C8568 800D7D68 38000624 */  addiu      $a2, $zero, 0x38
    /* C856C 800D7D6C 4C00A88F */  lw         $t0, 0x4C($sp)
    /* C8570 800D7D70 31000724 */  addiu      $a3, $zero, 0x31
    /* C8574 800D7D74 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C8578 800D7D78 FEFF0525 */   addiu     $a1, $t0, -0x2
    /* C857C 800D7D7C 21900000 */  addu       $s2, $zero, $zero
    /* C8580 800D7D80 21984002 */  addu       $s3, $s2, $zero
    /* C8584 800D7D84 1280023C */  lui        $v0, %hi(Hud_Character)
    /* C8588 800D7D88 AC0A4224 */  addiu      $v0, $v0, %lo(Hud_Character)
    /* C858C 800D7D8C 5000A88F */  lw         $t0, 0x50($sp)
    /* C8590 800D7D90 4C00B48F */  lw         $s4, 0x4C($sp)
    /* C8594 800D7D94 80180800 */  sll        $v1, $t0, 2
    /* C8598 800D7D98 21B06200 */  addu       $s6, $v1, $v0
  .L800D7D9C:
    /* C859C 800D7D9C 21800000 */  addu       $s0, $zero, $zero
    /* C85A0 800D7DA0 01009526 */  addiu      $s5, $s4, 0x1
    /* C85A4 800D7DA4 2188C003 */  addu       $s1, $fp, $zero
    /* C85A8 800D7DA8 01002526 */  addiu      $a1, $s1, 0x1
  .L800D7DAC:
    /* C85AC 800D7DAC 2130A002 */  addu       $a2, $s5, $zero
    /* C85B0 800D7DB0 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C85B4 800D7DB4 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C85B8 800D7DB8 0A003126 */  addiu      $s1, $s1, 0xA
    /* C85BC 800D7DBC 01001026 */  addiu      $s0, $s0, 0x1
    /* C85C0 800D7DC0 01000224 */  addiu      $v0, $zero, 0x1
    /* C85C4 800D7DC4 04104202 */  sllv       $v0, $v0, $s2
    /* C85C8 800D7DC8 0000C38E */  lw         $v1, 0x0($s6)
    /* C85CC 800D7DCC 01005226 */  addiu      $s2, $s2, 0x1
    /* C85D0 800D7DD0 1000A0AF */  sw         $zero, 0x10($sp)
    /* C85D4 800D7DD4 24186200 */  and        $v1, $v1, $v0
    /* C85D8 800D7DD8 2B180300 */  sltu       $v1, $zero, $v1
    /* C85DC 800D7DDC 1C48030C */  jal        Hud_FBuildSprite__FiiiUli
    /* C85E0 800D7DE0 3C006434 */   ori       $a0, $v1, 0x3C
    /* C85E4 800D7DE4 0500022A */  slti       $v0, $s0, 0x5
    /* C85E8 800D7DE8 F0FF4014 */  bnez       $v0, .L800D7DAC
    /* C85EC 800D7DEC 01002526 */   addiu     $a1, $s1, 0x1
    /* C85F0 800D7DF0 01007326 */  addiu      $s3, $s3, 0x1
    /* C85F4 800D7DF4 0500622A */  slti       $v0, $s3, 0x5
    /* C85F8 800D7DF8 E8FF4014 */  bnez       $v0, .L800D7D9C
    /* C85FC 800D7DFC 09009426 */   addiu     $s4, $s4, 0x9
    /* C8600 800D7E00 21200000 */  addu       $a0, $zero, $zero
    /* C8604 800D7E04 FDFFC527 */  addiu      $a1, $fp, -0x3
    /* C8608 800D7E08 38000724 */  addiu      $a3, $zero, 0x38
    /* C860C 800D7E0C 4C00A88F */  lw         $t0, 0x4C($sp)
    /* C8610 800D7E10 31000224 */  addiu      $v0, $zero, 0x31
    /* C8614 800D7E14 1000A2AF */  sw         $v0, 0x10($sp)
    /* C8618 800D7E18 1400A0AF */  sw         $zero, 0x14($sp)
    /* C861C 800D7E1C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8620 800D7E20 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C8624 800D7E24 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8628 800D7E28 FEFF0625 */   addiu     $a2, $t0, -0x2
    /* C862C 800D7E2C 5B47030C */  jal        Hud_GoTpage__Fi
    /* C8630 800D7E30 01000424 */   addiu     $a0, $zero, 0x1
    /* C8634 800D7E34 4400BF8F */  lw         $ra, 0x44($sp)
    /* C8638 800D7E38 4000BE8F */  lw         $fp, 0x40($sp)
    /* C863C 800D7E3C 3C00B78F */  lw         $s7, 0x3C($sp)
    /* C8640 800D7E40 3800B68F */  lw         $s6, 0x38($sp)
    /* C8644 800D7E44 3400B58F */  lw         $s5, 0x34($sp)
    /* C8648 800D7E48 3000B48F */  lw         $s4, 0x30($sp)
    /* C864C 800D7E4C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* C8650 800D7E50 2800B28F */  lw         $s2, 0x28($sp)
    /* C8654 800D7E54 2400B18F */  lw         $s1, 0x24($sp)
    /* C8658 800D7E58 2000B08F */  lw         $s0, 0x20($sp)
    /* C865C 800D7E5C 0800E003 */  jr         $ra
    /* C8660 800D7E60 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hud_Draw321Num__Fiiiiii
