.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__31tMenuItemOptionsLeftRightChoiceiib, 0x1D8

glabel Draw__31tMenuItemOptionsLeftRightChoiceiib
    /* B3E0 8001ABE0 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* B3E4 8001ABE4 4400B1AF */  sw         $s1, 0x44($sp)
    /* B3E8 8001ABE8 21888000 */  addu       $s1, $a0, $zero
    /* B3EC 8001ABEC 5000B4AF */  sw         $s4, 0x50($sp)
    /* B3F0 8001ABF0 21A0A000 */  addu       $s4, $a1, $zero
    /* B3F4 8001ABF4 5400B5AF */  sw         $s5, 0x54($sp)
    /* B3F8 8001ABF8 21A8C000 */  addu       $s5, $a2, $zero
    /* B3FC 8001ABFC 5800B6AF */  sw         $s6, 0x58($sp)
    /* B400 8001AC00 21B0E000 */  addu       $s6, $a3, $zero
    /* B404 8001AC04 06000424 */  addiu      $a0, $zero, 0x6
    /* B408 8001AC08 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* B40C 8001AC0C 642A428C */  lw         $v0, %lo(gHelpShapes)($v0)
    /* B410 8001AC10 21300000 */  addu       $a2, $zero, $zero
    /* B414 8001AC14 6000BFAF */  sw         $ra, 0x60($sp)
    /* B418 8001AC18 5C00B7AF */  sw         $s7, 0x5C($sp)
    /* B41C 8001AC1C 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* B420 8001AC20 4800B2AF */  sw         $s2, 0x48($sp)
    /* B424 8001AC24 4000B0AF */  sw         $s0, 0x40($sp)
    /* B428 8001AC28 08002586 */  lh         $a1, 0x8($s1)
    /* B42C 8001AC2C 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* B430 8001AC30 20055324 */   addiu     $s3, $v0, 0x520
    /* B434 8001AC34 0400248E */  lw         $a0, 0x4($s1)
    /* B438 8001AC38 94E4020C */  jal        TextSys_Word__Fi
    /* B43C 8001AC3C 21904000 */   addu      $s2, $v0, $zero
    /* B440 8001AC40 21204000 */  addu       $a0, $v0, $zero
    /* B444 8001AC44 94008526 */  addiu      $a1, $s4, 0x94
    /* B448 8001AC48 002C0500 */  sll        $a1, $a1, 16
    /* B44C 8001AC4C 032C0500 */  sra        $a1, $a1, 16
    /* B450 8001AC50 0300B026 */  addiu      $s0, $s5, 0x3
    /* B454 8001AC54 00841000 */  sll        $s0, $s0, 16
    /* B458 8001AC58 03841000 */  sra        $s0, $s0, 16
    /* B45C 8001AC5C 21300002 */  addu       $a2, $s0, $zero
    /* B460 8001AC60 21384002 */  addu       $a3, $s2, $zero
    /* B464 8001AC64 01001724 */  addiu      $s7, $zero, 0x1
    /* B468 8001AC68 1000A0AF */  sw         $zero, 0x10($sp)
    /* B46C 8001AC6C 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* B470 8001AC70 1400B7AF */   sw        $s7, 0x14($sp)
    /* B474 8001AC74 1C00238E */  lw         $v1, 0x1C($s1)
    /* B478 8001AC78 00000000 */  nop
    /* B47C 8001AC7C 0C00628C */  lw         $v0, 0xC($v1)
    /* B480 8001AC80 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* B484 8001AC84 18004484 */  lh         $a0, 0x18($v0)
    /* B488 8001AC88 1C00428C */  lw         $v0, 0x1C($v0)
    /* B48C 8001AC8C 00000000 */  nop
    /* B490 8001AC90 09F84000 */  jalr       $v0
    /* B494 8001AC94 21206400 */   addu      $a0, $v1, $a0
    /* B498 8001AC98 00140200 */  sll        $v0, $v0, 16
    /* B49C 8001AC9C 94E4020C */  jal        TextSys_Word__Fi
    /* B4A0 8001ACA0 03240200 */   sra       $a0, $v0, 16
    /* B4A4 8001ACA4 21204000 */  addu       $a0, $v0, $zero
    /* B4A8 8001ACA8 21300002 */  addu       $a2, $s0, $zero
    /* B4AC 8001ACAC 21384002 */  addu       $a3, $s2, $zero
    /* B4B0 8001ACB0 10006596 */  lhu        $a1, 0x10($s3)
    /* B4B4 8001ACB4 02000224 */  addiu      $v0, $zero, 0x2
    /* B4B8 8001ACB8 1000A0AF */  sw         $zero, 0x10($sp)
    /* B4BC 8001ACBC 1400A2AF */  sw         $v0, 0x14($sp)
    /* B4C0 8001ACC0 002C0500 */  sll        $a1, $a1, 16
    /* B4C4 8001ACC4 432C0500 */  sra        $a1, $a1, 17
    /* B4C8 8001ACC8 2128B400 */  addu       $a1, $a1, $s4
    /* B4CC 8001ACCC D900A524 */  addiu      $a1, $a1, 0xD9
    /* B4D0 8001ACD0 002C0500 */  sll        $a1, $a1, 16
    /* B4D4 8001ACD4 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* B4D8 8001ACD8 032C0500 */   sra       $a1, $a1, 16
    /* B4DC 8001ACDC B500043C */  lui        $a0, (0xB54200 >> 16)
    /* B4E0 8001ACE0 00428434 */  ori        $a0, $a0, (0xB54200 & 0xFFFF)
    /* B4E4 8001ACE4 08002686 */  lh         $a2, 0x8($s1)
    /* B4E8 8001ACE8 FE2D010C */  jal        CalcFadeVal__Fiii
    /* B4EC 8001ACEC BEBE0534 */   ori       $a1, $zero, 0xBEBE
    /* B4F0 8001ACF0 A6008626 */  addiu      $a2, $s4, 0xA6
    /* B4F4 8001ACF4 0600A726 */  addiu      $a3, $s5, 0x6
    /* B4F8 8001ACF8 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* B4FC 8001ACFC 0300C012 */  beqz       $s6, .L8001AD0C
    /* B500 8001AD00 1000A0AF */   sw        $zero, 0x10($sp)
    /* B504 8001AD04 446B0008 */  j          .L8001AD10
    /* B508 8001AD08 1400A0AF */   sw        $zero, 0x14($sp)
  .L8001AD0C:
    /* B50C 8001AD0C 1400B7AF */  sw         $s7, 0x14($sp)
  .L8001AD10:
    /* B510 8001AD10 0A000424 */  addiu      $a0, $zero, 0xA
    /* B514 8001AD14 18010524 */  addiu      $a1, $zero, 0x118
    /* B518 8001AD18 2800A227 */  addiu      $v0, $sp, 0x28
    /* B51C 8001AD1C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* B520 8001AD20 1800A2AF */   sw        $v0, 0x18($sp)
    /* B524 8001AD24 10006286 */  lh         $v0, 0x10($s3)
    /* B528 8001AD28 0600A726 */  addiu      $a3, $s5, 0x6
    /* B52C 8001AD2C 1000A0AF */  sw         $zero, 0x10($sp)
    /* B530 8001AD30 23108202 */  subu       $v0, $s4, $v0
    /* B534 8001AD34 0300C012 */  beqz       $s6, .L8001AD44
    /* B538 8001AD38 2F014624 */   addiu     $a2, $v0, 0x12F
    /* B53C 8001AD3C 536B0008 */  j          .L8001AD4C
    /* B540 8001AD40 1400A0AF */   sw        $zero, 0x14($sp)
  .L8001AD44:
    /* B544 8001AD44 01000224 */  addiu      $v0, $zero, 0x1
    /* B548 8001AD48 1400A2AF */  sw         $v0, 0x14($sp)
  .L8001AD4C:
    /* B54C 8001AD4C 0B000424 */  addiu      $a0, $zero, 0xB
    /* B550 8001AD50 18010524 */  addiu      $a1, $zero, 0x118
    /* B554 8001AD54 2800A227 */  addiu      $v0, $sp, 0x28
    /* B558 8001AD58 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* B55C 8001AD5C 1800A2AF */   sw        $v0, 0x18($sp)
    /* B560 8001AD60 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* B564 8001AD64 2000A527 */  addiu      $a1, $sp, 0x20
    /* B568 8001AD68 29010224 */  addiu      $v0, $zero, 0x129
    /* B56C 8001AD6C 00341600 */  sll        $a2, $s6, 16
    /* B570 8001AD70 2000B4A7 */  sh         $s4, 0x20($sp)
    /* B574 8001AD74 2200B5A7 */  sh         $s5, 0x22($sp)
    /* B578 8001AD78 2400A2A7 */  sh         $v0, 0x24($sp)
    /* B57C 8001AD7C 12006296 */  lhu        $v0, 0x12($s3)
    /* B580 8001AD80 03340600 */  sra        $a2, $a2, 16
    /* B584 8001AD84 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* B588 8001AD88 2600A2A7 */   sh        $v0, 0x26($sp)
    /* B58C 8001AD8C 6000BF8F */  lw         $ra, 0x60($sp)
    /* B590 8001AD90 5C00B78F */  lw         $s7, 0x5C($sp)
    /* B594 8001AD94 5800B68F */  lw         $s6, 0x58($sp)
    /* B598 8001AD98 5400B58F */  lw         $s5, 0x54($sp)
    /* B59C 8001AD9C 5000B48F */  lw         $s4, 0x50($sp)
    /* B5A0 8001ADA0 4C00B38F */  lw         $s3, 0x4C($sp)
    /* B5A4 8001ADA4 4800B28F */  lw         $s2, 0x48($sp)
    /* B5A8 8001ADA8 4400B18F */  lw         $s1, 0x44($sp)
    /* B5AC 8001ADAC 4000B08F */  lw         $s0, 0x40($sp)
    /* B5B0 8001ADB0 0800E003 */  jr         $ra
    /* B5B4 8001ADB4 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Draw__31tMenuItemOptionsLeftRightChoiceiib
