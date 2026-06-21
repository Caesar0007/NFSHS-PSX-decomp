.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xC4

glabel ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 112F4 80020AF4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 112F8 80020AF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 112FC 80020AFC 21808000 */  addu       $s0, $a0, $zero
    /* 11300 80020B00 1800B2AF */  sw         $s2, 0x18($sp)
    /* 11304 80020B04 2190A000 */  addu       $s2, $a1, $zero
    /* 11308 80020B08 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1130C 80020B0C 2188C000 */  addu       $s1, $a2, $zero
    /* 11310 80020B10 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 11314 80020B14 2000BFAF */  sw         $ra, 0x20($sp)
    /* 11318 80020B18 0000238E */  lw         $v1, 0x0($s1)
    /* 1131C 80020B1C 00080224 */  addiu      $v0, $zero, 0x800
    /* 11320 80020B20 04006210 */  beq        $v1, $v0, .L80020B34
    /* 11324 80020B24 2198E000 */   addu      $s3, $a3, $zero
    /* 11328 80020B28 00100224 */  addiu      $v0, $zero, 0x1000
    /* 1132C 80020B2C 17006214 */  bne        $v1, $v0, .L80020B8C
    /* 11330 80020B30 21200002 */   addu      $a0, $s0, $zero
  .L80020B34:
    /* 11334 80020B34 00100224 */  addiu      $v0, $zero, 0x1000
    /* 11338 80020B38 10006214 */  bne        $v1, $v0, .L80020B7C
    /* 1133C 80020B3C 0580023C */   lui       $v0, %hi(screenControllerConfig)
    /* 11340 80020B40 1C00038E */  lw         $v1, 0x1C($s0)
    /* 11344 80020B44 00000000 */  nop
    /* 11348 80020B48 0C00628C */  lw         $v0, 0xC($v1)
    /* 1134C 80020B4C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 11350 80020B50 10004484 */  lh         $a0, 0x10($v0)
    /* 11354 80020B54 1400428C */  lw         $v0, 0x14($v0)
    /* 11358 80020B58 00000000 */  nop
    /* 1135C 80020B5C 09F84000 */  jalr       $v0
    /* 11360 80020B60 21206400 */   addu      $a0, $v1, $a0
    /* 11364 80020B64 1C00038E */  lw         $v1, 0x1C($s0)
    /* 11368 80020B68 00000000 */  nop
    /* 1136C 80020B6C 09006390 */  lbu        $v1, 0x9($v1)
    /* 11370 80020B70 FF004230 */  andi       $v0, $v0, 0xFF
    /* 11374 80020B74 04004310 */  beq        $v0, $v1, .L80020B88
    /* 11378 80020B78 0580023C */   lui       $v0, %hi(screenControllerConfig)
  .L80020B7C:
    /* 1137C 80020B7C D028438C */  lw         $v1, %lo(screenControllerConfig)($v0)
    /* 11380 80020B80 01000224 */  addiu      $v0, $zero, 0x1
    /* 11384 80020B84 700162AC */  sw         $v0, 0x170($v1)
  .L80020B88:
    /* 11388 80020B88 21200002 */  addu       $a0, $s0, $zero
  .L80020B8C:
    /* 1138C 80020B8C 21284002 */  addu       $a1, $s2, $zero
    /* 11390 80020B90 21302002 */  addu       $a2, $s1, $zero
    /* 11394 80020B94 E192000C */  jal        ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 11398 80020B98 21386002 */   addu      $a3, $s3, $zero
    /* 1139C 80020B9C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 113A0 80020BA0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 113A4 80020BA4 1800B28F */  lw         $s2, 0x18($sp)
    /* 113A8 80020BA8 1400B18F */  lw         $s1, 0x14($sp)
    /* 113AC 80020BAC 1000B08F */  lw         $s0, 0x10($sp)
    /* 113B0 80020BB0 0800E003 */  jr         $ra
    /* 113B4 80020BB4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
