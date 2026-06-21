.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__12tScreenAudio, 0x110

glabel DrawForeground__12tScreenAudio
    /* 365C8 80045DC8 0580023C */  lui        $v0, %hi(menuDefs)
    /* 365CC 80045DCC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 365D0 80045DD0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 365D4 80045DD4 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 365D8 80045DD8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 365DC 80045DDC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 365E0 80045DE0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 365E4 80045DE4 5428428C */  lw         $v0, 0x2854($v0)
    /* 365E8 80045DE8 00000000 */  nop
    /* 365EC 80045DEC 43200200 */  sra        $a0, $v0, 1
    /* 365F0 80045DF0 00140400 */  sll        $v0, $a0, 16
    /* 365F4 80045DF4 031C0200 */  sra        $v1, $v0, 16
    /* 365F8 80045DF8 80006228 */  slti       $v0, $v1, 0x80
    /* 365FC 80045DFC 03004010 */  beqz       $v0, .L80045E0C
    /* 36600 80045E00 81006228 */   slti      $v0, $v1, 0x81
    /* 36604 80045E04 05006018 */  blez       $v1, .L80045E1C
    /* 36608 80045E08 21800000 */   addu      $s0, $zero, $zero
  .L80045E0C:
    /* 3660C 80045E0C 04004014 */  bnez       $v0, .L80045E20
    /* 36610 80045E10 21800000 */   addu      $s0, $zero, $zero
    /* 36614 80045E14 88170108 */  j          .L80045E20
    /* 36618 80045E18 80000424 */   addiu     $a0, $zero, 0x80
  .L80045E1C:
    /* 3661C 80045E1C 21200000 */  addu       $a0, $zero, $zero
  .L80045E20:
    /* 36620 80045E20 21908000 */  addu       $s2, $a0, $zero
    /* 36624 80045E24 00141200 */  sll        $v0, $s2, 16
    /* 36628 80045E28 038C0200 */  sra        $s1, $v0, 16
    /* 3662C 80045E2C 30000426 */  addiu      $a0, $s0, 0x30
  .L80045E30:
    /* 36630 80045E30 01000524 */  addiu      $a1, $zero, 0x1
    /* 36634 80045E34 21300000 */  addu       $a2, $zero, $zero
    /* 36638 80045E38 2138C000 */  addu       $a3, $a2, $zero
    /* 3663C 80045E3C 1000B1AF */  sw         $s1, 0x10($sp)
    /* 36640 80045E40 1400A0AF */  sw         $zero, 0x14($sp)
    /* 36644 80045E44 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 36648 80045E48 1800A0AF */   sw        $zero, 0x18($sp)
    /* 3664C 80045E4C 01001026 */  addiu      $s0, $s0, 0x1
    /* 36650 80045E50 0400022A */  slti       $v0, $s0, 0x4
    /* 36654 80045E54 F6FF4014 */  bnez       $v0, .L80045E30
    /* 36658 80045E58 30000426 */   addiu     $a0, $s0, 0x30
    /* 3665C 80045E5C 00141200 */  sll        $v0, $s2, 16
    /* 36660 80045E60 03140200 */  sra        $v0, $v0, 16
    /* 36664 80045E64 64004228 */  slti       $v0, $v0, 0x64
    /* 36668 80045E68 15004014 */  bnez       $v0, .L80045EC0
    /* 3666C 80045E6C 7D020424 */   addiu     $a0, $zero, 0x27D
    /* 36670 80045E70 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 36674 80045E74 DC000624 */  addiu      $a2, $zero, 0xDC
    /* 36678 80045E78 01000724 */  addiu      $a3, $zero, 0x1
    /* 3667C 80045E7C 2110E000 */  addu       $v0, $a3, $zero
    /* 36680 80045E80 1000A2AF */  sw         $v0, 0x10($sp)
    /* 36684 80045E84 04000224 */  addiu      $v0, $zero, 0x4
    /* 36688 80045E88 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 3668C 80045E8C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 36690 80045E90 94E4020C */  jal        TextSys_Word__Fi
    /* 36694 80045E94 7D020424 */   addiu     $a0, $zero, 0x27D
    /* 36698 80045E98 888F030C */  jal        textpixels
    /* 3669C 80045E9C 21204000 */   addu      $a0, $v0, $zero
    /* 366A0 80045EA0 21200000 */  addu       $a0, $zero, $zero
    /* 366A4 80045EA4 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 366A8 80045EA8 DC000624 */  addiu      $a2, $zero, 0xDC
    /* 366AC 80045EAC 23100200 */  negu       $v0, $v0
    /* 366B0 80045EB0 FBFF4724 */  addiu      $a3, $v0, -0x5
    /* 366B4 80045EB4 07000224 */  addiu      $v0, $zero, 0x7
    /* 366B8 80045EB8 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 366BC 80045EBC 1000A2AF */   sw        $v0, 0x10($sp)
  .L80045EC0:
    /* 366C0 80045EC0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 366C4 80045EC4 2800B28F */  lw         $s2, 0x28($sp)
    /* 366C8 80045EC8 2400B18F */  lw         $s1, 0x24($sp)
    /* 366CC 80045ECC 2000B08F */  lw         $s0, 0x20($sp)
    /* 366D0 80045ED0 0800E003 */  jr         $ra
    /* 366D4 80045ED4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawForeground__12tScreenAudio
