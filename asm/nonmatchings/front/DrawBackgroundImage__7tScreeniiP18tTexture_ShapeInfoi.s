.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi, 0xD0

glabel DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 164C8 80025CC8 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 164CC 80025CCC 4000B2AF */  sw         $s2, 0x40($sp)
    /* 164D0 80025CD0 21908000 */  addu       $s2, $a0, $zero
    /* 164D4 80025CD4 4400B3AF */  sw         $s3, 0x44($sp)
    /* 164D8 80025CD8 2198A000 */  addu       $s3, $a1, $zero
    /* 164DC 80025CDC 4800B4AF */  sw         $s4, 0x48($sp)
    /* 164E0 80025CE0 21A0C000 */  addu       $s4, $a2, $zero
    /* 164E4 80025CE4 3800B0AF */  sw         $s0, 0x38($sp)
    /* 164E8 80025CE8 21806002 */  addu       $s0, $s3, $zero
    /* 164EC 80025CEC 21101402 */  addu       $v0, $s0, $s4
    /* 164F0 80025CF0 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 164F4 80025CF4 6800B58F */  lw         $s5, 0x68($sp)
    /* 164F8 80025CF8 2A100202 */  slt        $v0, $s0, $v0
    /* 164FC 80025CFC 5000BFAF */  sw         $ra, 0x50($sp)
    /* 16500 80025D00 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 16504 80025D04 3400A7AF */  sw         $a3, 0x34($sp)
    /* 16508 80025D08 1A004010 */  beqz       $v0, .L80025D74
    /* 1650C 80025D0C 2000B5A7 */   sh        $s5, 0x20($sp)
    /* 16510 80025D10 2000B127 */  addiu      $s1, $sp, 0x20
    /* 16514 80025D14 21200002 */  addu       $a0, $s0, $zero
  .L80025D18:
    /* 16518 80025D18 00020524 */  addiu      $a1, $zero, 0x200
    /* 1651C 80025D1C 21300000 */  addu       $a2, $zero, $zero
    /* 16520 80025D20 5C004286 */  lh         $v0, 0x5C($s2)
    /* 16524 80025D24 2138C000 */  addu       $a3, $a2, $zero
    /* 16528 80025D28 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1652C 80025D2C 1800B1AF */  sw         $s1, 0x18($sp)
    /* 16530 80025D30 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 16534 80025D34 1000A2AF */   sw        $v0, 0x10($sp)
    /* 16538 80025D38 0900A01A */  blez       $s5, .L80025D60
    /* 1653C 80025D3C 21200002 */   addu      $a0, $s0, $zero
    /* 16540 80025D40 60020524 */  addiu      $a1, $zero, 0x260
    /* 16544 80025D44 21300000 */  addu       $a2, $zero, $zero
    /* 16548 80025D48 5C004286 */  lh         $v0, 0x5C($s2)
    /* 1654C 80025D4C 2138C000 */  addu       $a3, $a2, $zero
    /* 16550 80025D50 1400A0AF */  sw         $zero, 0x14($sp)
    /* 16554 80025D54 1800B1AF */  sw         $s1, 0x18($sp)
    /* 16558 80025D58 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 1655C 80025D5C 1000A2AF */   sw        $v0, 0x10($sp)
  .L80025D60:
    /* 16560 80025D60 01001026 */  addiu      $s0, $s0, 0x1
    /* 16564 80025D64 21107402 */  addu       $v0, $s3, $s4
    /* 16568 80025D68 2A100202 */  slt        $v0, $s0, $v0
    /* 1656C 80025D6C EAFF4014 */  bnez       $v0, .L80025D18
    /* 16570 80025D70 21200002 */   addu      $a0, $s0, $zero
  .L80025D74:
    /* 16574 80025D74 5000BF8F */  lw         $ra, 0x50($sp)
    /* 16578 80025D78 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 1657C 80025D7C 4800B48F */  lw         $s4, 0x48($sp)
    /* 16580 80025D80 4400B38F */  lw         $s3, 0x44($sp)
    /* 16584 80025D84 4000B28F */  lw         $s2, 0x40($sp)
    /* 16588 80025D88 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 1658C 80025D8C 3800B08F */  lw         $s0, 0x38($sp)
    /* 16590 80025D90 0800E003 */  jr         $ra
    /* 16594 80025D94 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
