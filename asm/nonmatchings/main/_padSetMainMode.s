.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSetMainMode, 0x98

glabel _padSetMainMode
    /* F6540 80105D40 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F6544 80105D44 1000B0AF */  sw         $s0, 0x10($sp)
    /* F6548 80105D48 21808000 */  addu       $s0, $a0, $zero
    /* F654C 80105D4C 1400B1AF */  sw         $s1, 0x14($sp)
    /* F6550 80105D50 2188A000 */  addu       $s1, $a1, $zero
    /* F6554 80105D54 1800B2AF */  sw         $s2, 0x18($sp)
    /* F6558 80105D58 2190C000 */  addu       $s2, $a2, $zero
    /* F655C 80105D5C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F6560 80105D60 1380023C */  lui        $v0, %hi(_padFuncChkEng)
    /* F6564 80105D64 947C428C */  lw         $v0, %lo(_padFuncChkEng)($v0)
    /* F6568 80105D68 2000BFAF */  sw         $ra, 0x20($sp)
    /* F656C 80105D6C 09F84000 */  jalr       $v0
    /* F6570 80105D70 21982002 */   addu      $s3, $s1, $zero
    /* F6574 80105D74 11004014 */  bnez       $v0, .L80105DBC
    /* F6578 80105D78 21100000 */   addu      $v0, $zero, $zero
    /* F657C 80105D7C 01000224 */  addiu      $v0, $zero, 0x1
    /* F6580 80105D80 E4000492 */  lbu        $a0, 0xE4($s0)
    /* F6584 80105D84 01000324 */  addiu      $v1, $zero, 0x1
    /* F6588 80105D88 460003A2 */  sb         $v1, 0x46($s0)
    /* F658C 80105D8C 1080033C */  lui        $v1, %hi(func_80105DD8)
    /* F6590 80105D90 D85D6324 */  addiu      $v1, $v1, %lo(func_80105DD8)
    /* F6594 80105D94 140003AE */  sw         $v1, 0x14($s0)
    /* F6598 80105D98 1080033C */  lui        $v1, %hi(func_80105E2C)
    /* F659C 80105D9C 2C5E6324 */  addiu      $v1, $v1, %lo(func_80105E2C)
    /* F65A0 80105DA0 180003AE */  sw         $v1, 0x18($s0)
    /* F65A4 80105DA4 FF006332 */  andi       $v1, $s3, 0xFF
    /* F65A8 80105DA8 510011A2 */  sb         $s1, 0x51($s0)
    /* F65AC 80105DAC 520012A2 */  sb         $s2, 0x52($s0)
    /* F65B0 80105DB0 26186400 */  xor        $v1, $v1, $a0
    /* F65B4 80105DB4 0100632C */  sltiu      $v1, $v1, 0x1
    /* F65B8 80105DB8 530003A2 */  sb         $v1, 0x53($s0)
  .L80105DBC:
    /* F65BC 80105DBC 2000BF8F */  lw         $ra, 0x20($sp)
    /* F65C0 80105DC0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F65C4 80105DC4 1800B28F */  lw         $s2, 0x18($sp)
    /* F65C8 80105DC8 1400B18F */  lw         $s1, 0x14($sp)
    /* F65CC 80105DCC 1000B08F */  lw         $s0, 0x10($sp)
    /* F65D0 80105DD0 0800E003 */  jr         $ra
    /* F65D4 80105DD4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel _padSetMainMode
