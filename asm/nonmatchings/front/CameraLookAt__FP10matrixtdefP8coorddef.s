.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CameraLookAt__FP10matrixtdefP8coorddef, 0x114

glabel CameraLookAt__FP10matrixtdefP8coorddef
    /* 32E4 80012AE4 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 32E8 80012AE8 0180023C */  lui        $v0, %hi(D_8001002C)
    /* 32EC 80012AEC 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 32F0 80012AF0 4800B2AF */  sw         $s2, 0x48($sp)
    /* 32F4 80012AF4 4400B1AF */  sw         $s1, 0x44($sp)
    /* 32F8 80012AF8 4000B0AF */  sw         $s0, 0x40($sp)
    /* 32FC 80012AFC 2C004924 */  addiu      $t1, $v0, %lo(D_8001002C)
    /* 3300 80012B00 0000238D */  lw         $v1, 0x0($t1)
    /* 3304 80012B04 0400278D */  lw         $a3, 0x4($t1)
    /* 3308 80012B08 0800288D */  lw         $t0, 0x8($t1)
    /* 330C 80012B0C 3000A3AF */  sw         $v1, 0x30($sp)
    /* 3310 80012B10 3400A7AF */  sw         $a3, 0x34($sp)
    /* 3314 80012B14 3800A8AF */  sw         $t0, 0x38($sp)
    /* 3318 80012B18 0000A28C */  lw         $v0, 0x0($a1)
    /* 331C 80012B1C 00000000 */  nop
    /* 3320 80012B20 23100200 */  negu       $v0, $v0
    /* 3324 80012B24 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3328 80012B28 0400A28C */  lw         $v0, 0x4($a1)
    /* 332C 80012B2C 21888000 */  addu       $s1, $a0, $zero
    /* 3330 80012B30 23100200 */  negu       $v0, $v0
    /* 3334 80012B34 1400A2AF */  sw         $v0, 0x14($sp)
    /* 3338 80012B38 0800A28C */  lw         $v0, 0x8($a1)
    /* 333C 80012B3C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3340 80012B40 23100200 */  negu       $v0, $v0
    /* 3344 80012B44 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* 3348 80012B48 1800A2AF */   sw        $v0, 0x18($sp)
    /* 334C 80012B4C 3000B227 */  addiu      $s2, $sp, 0x30
    /* 3350 80012B50 21204002 */  addu       $a0, $s2, $zero
    /* 3354 80012B54 1000A527 */  addiu      $a1, $sp, 0x10
    /* 3358 80012B58 2000B027 */  addiu      $s0, $sp, 0x20
    /* 335C 80012B5C B9AA030C */  jal        crossproduct
    /* 3360 80012B60 21300002 */   addu      $a2, $s0, $zero
    /* 3364 80012B64 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3368 80012B68 21280002 */  addu       $a1, $s0, $zero
    /* 336C 80012B6C B9AA030C */  jal        crossproduct
    /* 3370 80012B70 21304002 */   addu      $a2, $s2, $zero
    /* 3374 80012B74 2000A28F */  lw         $v0, 0x20($sp)
    /* 3378 80012B78 00000000 */  nop
    /* 337C 80012B7C 000022AE */  sw         $v0, 0x0($s1)
    /* 3380 80012B80 2400A28F */  lw         $v0, 0x24($sp)
    /* 3384 80012B84 00000000 */  nop
    /* 3388 80012B88 040022AE */  sw         $v0, 0x4($s1)
    /* 338C 80012B8C 2800A28F */  lw         $v0, 0x28($sp)
    /* 3390 80012B90 00000000 */  nop
    /* 3394 80012B94 080022AE */  sw         $v0, 0x8($s1)
    /* 3398 80012B98 3000A28F */  lw         $v0, 0x30($sp)
    /* 339C 80012B9C 00000000 */  nop
    /* 33A0 80012BA0 0C0022AE */  sw         $v0, 0xC($s1)
    /* 33A4 80012BA4 3400A28F */  lw         $v0, 0x34($sp)
    /* 33A8 80012BA8 00000000 */  nop
    /* 33AC 80012BAC 100022AE */  sw         $v0, 0x10($s1)
    /* 33B0 80012BB0 3800A28F */  lw         $v0, 0x38($sp)
    /* 33B4 80012BB4 00000000 */  nop
    /* 33B8 80012BB8 140022AE */  sw         $v0, 0x14($s1)
    /* 33BC 80012BBC 1000A28F */  lw         $v0, 0x10($sp)
    /* 33C0 80012BC0 00000000 */  nop
    /* 33C4 80012BC4 180022AE */  sw         $v0, 0x18($s1)
    /* 33C8 80012BC8 1400A28F */  lw         $v0, 0x14($sp)
    /* 33CC 80012BCC 00000000 */  nop
    /* 33D0 80012BD0 1C0022AE */  sw         $v0, 0x1C($s1)
    /* 33D4 80012BD4 1800A28F */  lw         $v0, 0x18($sp)
    /* 33D8 80012BD8 00000000 */  nop
    /* 33DC 80012BDC 200022AE */  sw         $v0, 0x20($s1)
    /* 33E0 80012BE0 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 33E4 80012BE4 4800B28F */  lw         $s2, 0x48($sp)
    /* 33E8 80012BE8 4400B18F */  lw         $s1, 0x44($sp)
    /* 33EC 80012BEC 4000B08F */  lw         $s0, 0x40($sp)
    /* 33F0 80012BF0 0800E003 */  jr         $ra
    /* 33F4 80012BF4 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel CameraLookAt__FP10matrixtdefP8coorddef
