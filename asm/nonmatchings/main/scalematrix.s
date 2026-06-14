.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching scalematrix, 0x78

glabel scalematrix
    /* E0A6C 800F026C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E0A70 800F0270 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E0A74 800F0274 2198A000 */  addu       $s3, $a1, $zero
    /* E0A78 800F0278 2000B4AF */  sw         $s4, 0x20($sp)
    /* E0A7C 800F027C 21A0C000 */  addu       $s4, $a2, $zero
    /* E0A80 800F0280 1800B2AF */  sw         $s2, 0x18($sp)
    /* E0A84 800F0284 21900000 */  addu       $s2, $zero, $zero
    /* E0A88 800F0288 1400B1AF */  sw         $s1, 0x14($sp)
    /* E0A8C 800F028C 21888002 */  addu       $s1, $s4, $zero
    /* E0A90 800F0290 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0A94 800F0294 21808000 */  addu       $s0, $a0, $zero
    /* E0A98 800F0298 2400BFAF */  sw         $ra, 0x24($sp)
  .L800F029C:
    /* E0A9C 800F029C 0000048E */  lw         $a0, 0x0($s0)
    /* E0AA0 800F02A0 04001026 */  addiu      $s0, $s0, 0x4
    /* E0AA4 800F02A4 01005226 */  addiu      $s2, $s2, 0x1
    /* E0AA8 800F02A8 CA90030C */  jal        fixedmult
    /* E0AAC 800F02AC 21286002 */   addu      $a1, $s3, $zero
    /* E0AB0 800F02B0 000022AE */  sw         $v0, 0x0($s1)
    /* E0AB4 800F02B4 0900422A */  slti       $v0, $s2, 0x9
    /* E0AB8 800F02B8 F8FF4014 */  bnez       $v0, .L800F029C
    /* E0ABC 800F02BC 04003126 */   addiu     $s1, $s1, 0x4
    /* E0AC0 800F02C0 21108002 */  addu       $v0, $s4, $zero
    /* E0AC4 800F02C4 2400BF8F */  lw         $ra, 0x24($sp)
    /* E0AC8 800F02C8 2000B48F */  lw         $s4, 0x20($sp)
    /* E0ACC 800F02CC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E0AD0 800F02D0 1800B28F */  lw         $s2, 0x18($sp)
    /* E0AD4 800F02D4 1400B18F */  lw         $s1, 0x14($sp)
    /* E0AD8 800F02D8 1000B08F */  lw         $s0, 0x10($sp)
    /* E0ADC 800F02DC 0800E003 */  jr         $ra
    /* E0AE0 800F02E0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel scalematrix
