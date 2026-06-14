.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching crossproduct, 0xB8

glabel crossproduct
    /* DB2E4 800EAAE4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DB2E8 800EAAE8 1400B1AF */  sw         $s1, 0x14($sp)
    /* DB2EC 800EAAEC 21888000 */  addu       $s1, $a0, $zero
    /* DB2F0 800EAAF0 1800B2AF */  sw         $s2, 0x18($sp)
    /* DB2F4 800EAAF4 2190A000 */  addu       $s2, $a1, $zero
    /* DB2F8 800EAAF8 2000BFAF */  sw         $ra, 0x20($sp)
    /* DB2FC 800EAAFC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DB300 800EAB00 1000B0AF */  sw         $s0, 0x10($sp)
    /* DB304 800EAB04 0400248E */  lw         $a0, 0x4($s1)
    /* DB308 800EAB08 0800458E */  lw         $a1, 0x8($s2)
    /* DB30C 800EAB0C CA90030C */  jal        fixedmult
    /* DB310 800EAB10 2198C000 */   addu      $s3, $a2, $zero
    /* DB314 800EAB14 0800248E */  lw         $a0, 0x8($s1)
    /* DB318 800EAB18 0400458E */  lw         $a1, 0x4($s2)
    /* DB31C 800EAB1C CA90030C */  jal        fixedmult
    /* DB320 800EAB20 21804000 */   addu      $s0, $v0, $zero
    /* DB324 800EAB24 23800202 */  subu       $s0, $s0, $v0
    /* DB328 800EAB28 000070AE */  sw         $s0, 0x0($s3)
    /* DB32C 800EAB2C 0000248E */  lw         $a0, 0x0($s1)
    /* DB330 800EAB30 0800458E */  lw         $a1, 0x8($s2)
    /* DB334 800EAB34 CA90030C */  jal        fixedmult
    /* DB338 800EAB38 00000000 */   nop
    /* DB33C 800EAB3C 0800248E */  lw         $a0, 0x8($s1)
    /* DB340 800EAB40 0000458E */  lw         $a1, 0x0($s2)
    /* DB344 800EAB44 CA90030C */  jal        fixedmult
    /* DB348 800EAB48 21804000 */   addu      $s0, $v0, $zero
    /* DB34C 800EAB4C 23105000 */  subu       $v0, $v0, $s0
    /* DB350 800EAB50 040062AE */  sw         $v0, 0x4($s3)
    /* DB354 800EAB54 0000248E */  lw         $a0, 0x0($s1)
    /* DB358 800EAB58 0400458E */  lw         $a1, 0x4($s2)
    /* DB35C 800EAB5C CA90030C */  jal        fixedmult
    /* DB360 800EAB60 00000000 */   nop
    /* DB364 800EAB64 0400248E */  lw         $a0, 0x4($s1)
    /* DB368 800EAB68 0000458E */  lw         $a1, 0x0($s2)
    /* DB36C 800EAB6C CA90030C */  jal        fixedmult
    /* DB370 800EAB70 21804000 */   addu      $s0, $v0, $zero
    /* DB374 800EAB74 23800202 */  subu       $s0, $s0, $v0
    /* DB378 800EAB78 21106002 */  addu       $v0, $s3, $zero
    /* DB37C 800EAB7C 080050AC */  sw         $s0, 0x8($v0)
    /* DB380 800EAB80 2000BF8F */  lw         $ra, 0x20($sp)
    /* DB384 800EAB84 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DB388 800EAB88 1800B28F */  lw         $s2, 0x18($sp)
    /* DB38C 800EAB8C 1400B18F */  lw         $s1, 0x14($sp)
    /* DB390 800EAB90 1000B08F */  lw         $s0, 0x10($sp)
    /* DB394 800EAB94 0800E003 */  jr         $ra
    /* DB398 800EAB98 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel crossproduct
