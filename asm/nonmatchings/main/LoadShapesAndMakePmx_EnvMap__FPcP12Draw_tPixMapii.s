.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii, 0xB8

glabel LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
    /* A9F78 800B9778 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A9F7C 800B977C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* A9F80 800B9780 21988000 */  addu       $s3, $a0, $zero
    /* A9F84 800B9784 3800B6AF */  sw         $s6, 0x38($sp)
    /* A9F88 800B9788 21B0C000 */  addu       $s6, $a2, $zero
    /* A9F8C 800B978C 3400B5AF */  sw         $s5, 0x34($sp)
    /* A9F90 800B9790 21A8E000 */  addu       $s5, $a3, $zero
    /* A9F94 800B9794 2400B1AF */  sw         $s1, 0x24($sp)
    /* A9F98 800B9798 2188A000 */  addu       $s1, $a1, $zero
    /* A9F9C 800B979C 3000B4AF */  sw         $s4, 0x30($sp)
    /* A9FA0 800B97A0 21A00000 */  addu       $s4, $zero, $zero
    /* A9FA4 800B97A4 2000B0AF */  sw         $s0, 0x20($sp)
    /* A9FA8 800B97A8 21808002 */  addu       $s0, $s4, $zero
    /* A9FAC 800B97AC 2800B2AF */  sw         $s2, 0x28($sp)
    /* A9FB0 800B97B0 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* A9FB4 800B97B4 3C00BFAF */  sw         $ra, 0x3C($sp)
  .L800B97B8:
    /* A9FB8 800B97B8 ABC2030C */  jal        shapecount
    /* A9FBC 800B97BC 21206002 */   addu      $a0, $s3, $zero
    /* A9FC0 800B97C0 2A100202 */  slt        $v0, $s0, $v0
    /* A9FC4 800B97C4 10004010 */  beqz       $v0, .L800B9808
    /* A9FC8 800B97C8 21206002 */   addu      $a0, $s3, $zero
    /* A9FCC 800B97CC AEC2030C */  jal        shapepointer
    /* A9FD0 800B97D0 21280002 */   addu      $a1, $s0, $zero
    /* A9FD4 800B97D4 0A004010 */  beqz       $v0, .L800B9800
    /* A9FD8 800B97D8 21200000 */   addu      $a0, $zero, $zero
    /* A9FDC 800B97DC 21284000 */  addu       $a1, $v0, $zero
    /* A9FE0 800B97E0 42008636 */  ori        $a2, $s4, 0x42
    /* A9FE4 800B97E4 2138C002 */  addu       $a3, $s6, $zero
    /* A9FE8 800B97E8 1000B5AF */  sw         $s5, 0x10($sp)
    /* A9FEC 800B97EC 1400B2AF */  sw         $s2, 0x14($sp)
    /* A9FF0 800B97F0 1800B2AF */  sw         $s2, 0x18($sp)
    /* A9FF4 800B97F4 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* A9FF8 800B97F8 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* A9FFC 800B97FC 10003126 */  addiu      $s1, $s1, 0x10
  .L800B9800:
    /* AA000 800B9800 EEE50208 */  j          .L800B97B8
    /* AA004 800B9804 01001026 */   addiu     $s0, $s0, 0x1
  .L800B9808:
    /* AA008 800B9808 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* AA00C 800B980C 3800B68F */  lw         $s6, 0x38($sp)
    /* AA010 800B9810 3400B58F */  lw         $s5, 0x34($sp)
    /* AA014 800B9814 3000B48F */  lw         $s4, 0x30($sp)
    /* AA018 800B9818 2C00B38F */  lw         $s3, 0x2C($sp)
    /* AA01C 800B981C 2800B28F */  lw         $s2, 0x28($sp)
    /* AA020 800B9820 2400B18F */  lw         $s1, 0x24($sp)
    /* AA024 800B9824 2000B08F */  lw         $s0, 0x20($sp)
    /* AA028 800B9828 0800E003 */  jr         $ra
    /* AA02C 800B982C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
