.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDresolvetaggedpatch, 0xD4

glabel iSNDresolvetaggedpatch
    /* F2CEC 801024EC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F2CF0 801024F0 2400B1AF */  sw         $s1, 0x24($sp)
    /* F2CF4 801024F4 21888000 */  addu       $s1, $a0, $zero
    /* F2CF8 801024F8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F2CFC 801024FC 2198A000 */  addu       $s3, $a1, $zero
    /* F2D00 80102500 3000B4AF */  sw         $s4, 0x30($sp)
    /* F2D04 80102504 21A0C000 */  addu       $s4, $a2, $zero
    /* F2D08 80102508 3400BFAF */  sw         $ra, 0x34($sp)
    /* F2D0C 8010250C 2800B2AF */  sw         $s2, 0x28($sp)
    /* F2D10 80102510 2000B0AF */  sw         $s0, 0x20($sp)
    /* F2D14 80102514 1000B1AF */  sw         $s1, 0x10($sp)
    /* F2D18 80102518 03002292 */  lbu        $v0, 0x3($s1)
    /* F2D1C 8010251C 00000000 */  nop
    /* F2D20 80102520 02004230 */  andi       $v0, $v0, 0x2
    /* F2D24 80102524 03004010 */  beqz       $v0, .L80102534
    /* F2D28 80102528 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* F2D2C 8010252C 4E090408 */  j          .L80102538
    /* F2D30 80102530 08002226 */   addiu     $v0, $s1, 0x8
  .L80102534:
    /* F2D34 80102534 04002226 */  addiu      $v0, $s1, 0x4
  .L80102538:
    /* F2D38 80102538 1000A2AF */  sw         $v0, 0x10($sp)
    /* F2D3C 8010253C FD001224 */  addiu      $s2, $zero, 0xFD
  .L80102540:
    /* F2D40 80102540 1000A427 */  addiu      $a0, $sp, 0x10
  .L80102544:
    /* F2D44 80102544 1400A527 */  addiu      $a1, $sp, 0x14
    /* F2D48 80102548 1800A627 */  addiu      $a2, $sp, 0x18
    /* F2D4C 8010254C 542F040C */  jal        iSNDgettag
    /* F2D50 80102550 1C00A727 */   addiu     $a3, $sp, 0x1C
    /* F2D54 80102554 0B004010 */  beqz       $v0, .L80102584
    /* F2D58 80102558 00000000 */   nop
    /* F2D5C 8010255C 1400A28F */  lw         $v0, 0x14($sp)
    /* F2D60 80102560 00000000 */  nop
    /* F2D64 80102564 F7FF5214 */  bne        $v0, $s2, .L80102544
    /* F2D68 80102568 1000A427 */   addiu     $a0, $sp, 0x10
    /* F2D6C 8010256C 1000A48F */  lw         $a0, 0x10($sp)
    /* F2D70 80102570 21286002 */  addu       $a1, $s3, $zero
    /* F2D74 80102574 D72D040C */  jal        iSNDplatformresolve
    /* F2D78 80102578 21308002 */   addu      $a2, $s4, $zero
    /* F2D7C 8010257C 50090408 */  j          .L80102540
    /* F2D80 80102580 21804000 */   addu      $s0, $v0, $zero
  .L80102584:
    /* F2D84 80102584 06000006 */  bltz       $s0, .L801025A0
    /* F2D88 80102588 21100002 */   addu      $v0, $s0, $zero
    /* F2D8C 8010258C 03002292 */  lbu        $v0, 0x3($s1)
    /* F2D90 80102590 00000000 */  nop
    /* F2D94 80102594 01004234 */  ori        $v0, $v0, 0x1
    /* F2D98 80102598 030022A2 */  sb         $v0, 0x3($s1)
    /* F2D9C 8010259C 21100002 */  addu       $v0, $s0, $zero
  .L801025A0:
    /* F2DA0 801025A0 3400BF8F */  lw         $ra, 0x34($sp)
    /* F2DA4 801025A4 3000B48F */  lw         $s4, 0x30($sp)
    /* F2DA8 801025A8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F2DAC 801025AC 2800B28F */  lw         $s2, 0x28($sp)
    /* F2DB0 801025B0 2400B18F */  lw         $s1, 0x24($sp)
    /* F2DB4 801025B4 2000B08F */  lw         $s0, 0x20($sp)
    /* F2DB8 801025B8 0800E003 */  jr         $ra
    /* F2DBC 801025BC 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSNDresolvetaggedpatch
