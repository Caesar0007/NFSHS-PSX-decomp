.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex, 0xE0

glabel TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
    /* D24E0 800E1CE0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* D24E4 800E1CE4 2800B2AF */  sw         $s2, 0x28($sp)
    /* D24E8 800E1CE8 5800B28F */  lw         $s2, 0x58($sp)
    /* D24EC 800E1CEC 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* D24F0 800E1CF0 21B88000 */  addu       $s7, $a0, $zero
    /* D24F4 800E1CF4 3000B4AF */  sw         $s4, 0x30($sp)
    /* D24F8 800E1CF8 21A0A000 */  addu       $s4, $a1, $zero
    /* D24FC 800E1CFC 3400B5AF */  sw         $s5, 0x34($sp)
    /* D2500 800E1D00 21A8C000 */  addu       $s5, $a2, $zero
    /* D2504 800E1D04 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D2508 800E1D08 2198E000 */  addu       $s3, $a3, $zero
    /* D250C 800E1D0C 2400B1AF */  sw         $s1, 0x24($sp)
    /* D2510 800E1D10 21880000 */  addu       $s1, $zero, $zero
    /* D2514 800E1D14 4000BFAF */  sw         $ra, 0x40($sp)
    /* D2518 800E1D18 3800B6AF */  sw         $s6, 0x38($sp)
    /* D251C 800E1D1C 1D00A01A */  blez       $s5, .L800E1D94
    /* D2520 800E1D20 2000B0AF */   sw        $s0, 0x20($sp)
    /* D2524 800E1D24 0A001624 */  addiu      $s6, $zero, 0xA
    /* D2528 800E1D28 06005026 */  addiu      $s0, $s2, 0x6
  .L800E1D2C:
    /* D252C 800E1D2C 21206002 */  addu       $a0, $s3, $zero
    /* D2530 800E1D30 2128E002 */  addu       $a1, $s7, $zero
    /* D2534 800E1D34 B6AB030C */  jal        transform
    /* D2538 800E1D38 1000A627 */   addiu     $a2, $sp, 0x10
    /* D253C 800E1D3C 1000A28F */  lw         $v0, 0x10($sp)
    /* D2540 800E1D40 0000838E */  lw         $v1, 0x0($s4)
    /* D2544 800E1D44 0C007326 */  addiu      $s3, $s3, 0xC
    /* D2548 800E1D48 21104300 */  addu       $v0, $v0, $v1
    /* D254C 800E1D4C 83120200 */  sra        $v0, $v0, 10
    /* D2550 800E1D50 000042A6 */  sh         $v0, 0x0($s2)
    /* D2554 800E1D54 1400A28F */  lw         $v0, 0x14($sp)
    /* D2558 800E1D58 0400838E */  lw         $v1, 0x4($s4)
    /* D255C 800E1D5C 01003126 */  addiu      $s1, $s1, 0x1
    /* D2560 800E1D60 21104300 */  addu       $v0, $v0, $v1
    /* D2564 800E1D64 83120200 */  sra        $v0, $v0, 10
    /* D2568 800E1D68 FCFF02A6 */  sh         $v0, -0x4($s0)
    /* D256C 800E1D6C 1800A28F */  lw         $v0, 0x18($sp)
    /* D2570 800E1D70 0800838E */  lw         $v1, 0x8($s4)
    /* D2574 800E1D74 08005226 */  addiu      $s2, $s2, 0x8
    /* D2578 800E1D78 000016A6 */  sh         $s6, 0x0($s0)
    /* D257C 800E1D7C 21104300 */  addu       $v0, $v0, $v1
    /* D2580 800E1D80 83120200 */  sra        $v0, $v0, 10
    /* D2584 800E1D84 FEFF02A6 */  sh         $v0, -0x2($s0)
    /* D2588 800E1D88 2A103502 */  slt        $v0, $s1, $s5
    /* D258C 800E1D8C E7FF4014 */  bnez       $v0, .L800E1D2C
    /* D2590 800E1D90 08001026 */   addiu     $s0, $s0, 0x8
  .L800E1D94:
    /* D2594 800E1D94 4000BF8F */  lw         $ra, 0x40($sp)
    /* D2598 800E1D98 3C00B78F */  lw         $s7, 0x3C($sp)
    /* D259C 800E1D9C 3800B68F */  lw         $s6, 0x38($sp)
    /* D25A0 800E1DA0 3400B58F */  lw         $s5, 0x34($sp)
    /* D25A4 800E1DA4 3000B48F */  lw         $s4, 0x30($sp)
    /* D25A8 800E1DA8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D25AC 800E1DAC 2800B28F */  lw         $s2, 0x28($sp)
    /* D25B0 800E1DB0 2400B18F */  lw         $s1, 0x24($sp)
    /* D25B4 800E1DB4 2000B08F */  lw         $s0, 0x20($sp)
    /* D25B8 800E1DB8 0800E003 */  jr         $ra
    /* D25BC 800E1DBC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
