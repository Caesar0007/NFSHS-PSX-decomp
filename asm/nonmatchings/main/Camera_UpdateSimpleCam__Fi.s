.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_UpdateSimpleCam__Fi, 0xE4

glabel Camera_UpdateSimpleCam__Fi
    /* 712C8 80080AC8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 712CC 80080ACC 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 712D0 80080AD0 21988000 */  addu       $s3, $a0, $zero
    /* 712D4 80080AD4 3800B2AF */  sw         $s2, 0x38($sp)
    /* 712D8 80080AD8 1180123C */  lui        $s2, %hi(Camera_gInfo)
    /* 712DC 80080ADC ACF25226 */  addiu      $s2, $s2, %lo(Camera_gInfo)
    /* 712E0 80080AE0 3400B1AF */  sw         $s1, 0x34($sp)
    /* 712E4 80080AE4 00891300 */  sll        $s1, $s3, 4
    /* 712E8 80080AE8 21883302 */  addu       $s1, $s1, $s3
    /* 712EC 80080AEC 00891100 */  sll        $s1, $s1, 4
    /* 712F0 80080AF0 3000B0AF */  sw         $s0, 0x30($sp)
    /* 712F4 80080AF4 21803202 */  addu       $s0, $s1, $s2
    /* 712F8 80080AF8 1180033C */  lui        $v1, %hi(Camera_gFlags)
    /* 712FC 80080AFC 50F56324 */  addiu      $v1, $v1, %lo(Camera_gFlags)
    /* 71300 80080B00 4000BFAF */  sw         $ra, 0x40($sp)
    /* 71304 80080B04 70000286 */  lh         $v0, 0x70($s0)
    /* 71308 80080B08 1000A427 */  addiu      $a0, $sp, 0x10
    /* 7130C 80080B0C 00110200 */  sll        $v0, $v0, 4
    /* 71310 80080B10 21104300 */  addu       $v0, $v0, $v1
    /* 71314 80080B14 0000478C */  lw         $a3, 0x0($v0)
    /* 71318 80080B18 0400488C */  lw         $t0, 0x4($v0)
    /* 7131C 80080B1C 0800498C */  lw         $t1, 0x8($v0)
    /* 71320 80080B20 1000A7AF */  sw         $a3, 0x10($sp)
    /* 71324 80080B24 1400A8AF */  sw         $t0, 0x14($sp)
    /* 71328 80080B28 1800A9AF */  sw         $t1, 0x18($sp)
    /* 7132C 80080B2C 0000058E */  lw         $a1, 0x0($s0)
    /* 71330 80080B30 2000A627 */  addiu      $a2, $sp, 0x20
    /* 71334 80080B34 B6AB030C */  jal        transform
    /* 71338 80080B38 F000A524 */   addiu     $a1, $a1, 0xF0
    /* 7133C 80080B3C 21206002 */  addu       $a0, $s3, $zero
    /* 71340 80080B40 F101020C */  jal        Camera_TunnelLimit__FiPi
    /* 71344 80080B44 2400A527 */   addiu     $a1, $sp, 0x24
    /* 71348 80080B48 30005226 */  addiu      $s2, $s2, 0x30
    /* 7134C 80080B4C 0000028E */  lw         $v0, 0x0($s0)
    /* 71350 80080B50 2000A38F */  lw         $v1, 0x20($sp)
    /* 71354 80080B54 A000428C */  lw         $v0, 0xA0($v0)
    /* 71358 80080B58 0000048E */  lw         $a0, 0x0($s0)
    /* 7135C 80080B5C 21104300 */  addu       $v0, $v0, $v1
    /* 71360 80080B60 080002AE */  sw         $v0, 0x8($s0)
    /* 71364 80080B64 A400828C */  lw         $v0, 0xA4($a0)
    /* 71368 80080B68 2400A38F */  lw         $v1, 0x24($sp)
    /* 7136C 80080B6C 21283202 */  addu       $a1, $s1, $s2
    /* 71370 80080B70 21104300 */  addu       $v0, $v0, $v1
    /* 71374 80080B74 0C0002AE */  sw         $v0, 0xC($s0)
    /* 71378 80080B78 A800828C */  lw         $v0, 0xA8($a0)
    /* 7137C 80080B7C 2800A38F */  lw         $v1, 0x28($sp)
    /* 71380 80080B80 F0008424 */  addiu      $a0, $a0, 0xF0
    /* 71384 80080B84 21104300 */  addu       $v0, $v0, $v1
    /* 71388 80080B88 CF01020C */  jal        Camera_LookBack__FP10matrixtdefT0
    /* 7138C 80080B8C 100002AE */   sw        $v0, 0x10($s0)
    /* 71390 80080B90 4000BF8F */  lw         $ra, 0x40($sp)
    /* 71394 80080B94 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 71398 80080B98 3800B28F */  lw         $s2, 0x38($sp)
    /* 7139C 80080B9C 3400B18F */  lw         $s1, 0x34($sp)
    /* 713A0 80080BA0 3000B08F */  lw         $s0, 0x30($sp)
    /* 713A4 80080BA4 0800E003 */  jr         $ra
    /* 713A8 80080BA8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Camera_UpdateSimpleCam__Fi
