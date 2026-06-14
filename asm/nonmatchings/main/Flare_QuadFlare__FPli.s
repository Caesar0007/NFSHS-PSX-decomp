.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_QuadFlare__FPli, 0x11C

glabel Flare_QuadFlare__FPli
    /* BD23C 800CCA3C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* BD240 800CCA40 2800B2AF */  sw         $s2, 0x28($sp)
    /* BD244 800CCA44 21908000 */  addu       $s2, $a0, $zero
    /* BD248 800CCA48 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* BD24C 800CCA4C 2198A000 */  addu       $s3, $a1, $zero
    /* BD250 800CCA50 1280023C */  lui        $v0, %hi(Flare_gQuad)
    /* BD254 800CCA54 48FF4224 */  addiu      $v0, $v0, %lo(Flare_gQuad)
    /* BD258 800CCA58 3400BFAF */  sw         $ra, 0x34($sp)
    /* BD25C 800CCA5C 3000B4AF */  sw         $s4, 0x30($sp)
    /* BD260 800CCA60 2400B1AF */  sw         $s1, 0x24($sp)
    /* BD264 800CCA64 2000B0AF */  sw         $s0, 0x20($sp)
    /* BD268 800CCA68 000040C8 */  lwc2       $0, 0x0($v0)
    /* BD26C 800CCA6C 040041C8 */  lwc2       $1, 0x4($v0)
    /* BD270 800CCA70 00000000 */  nop
    /* BD274 800CCA74 00000000 */  nop
    /* BD278 800CCA78 0100184A */  .word 0x4A180001  /* rtps */
    /* BD27C 800CCA7C 1800B427 */  addiu      $s4, $sp, 0x18
    /* BD280 800CCA80 00008EEA */  swc2       $14, 0x0($s4)
    /* BD284 800CCA84 1280023C */  lui        $v0, %hi(D_8011FF50)
    /* BD288 800CCA88 50FF4224 */  addiu      $v0, $v0, %lo(D_8011FF50)
    /* BD28C 800CCA8C 000040C8 */  lwc2       $0, 0x0($v0)
    /* BD290 800CCA90 040041C8 */  lwc2       $1, 0x4($v0)
    /* BD294 800CCA94 00000000 */  nop
    /* BD298 800CCA98 00000000 */  nop
    /* BD29C 800CCA9C 0100184A */  .word 0x4A180001  /* rtps */
    /* BD2A0 800CCAA0 1400B127 */  addiu      $s1, $sp, 0x14
    /* BD2A4 800CCAA4 00002EEA */  swc2       $14, 0x0($s1)
    /* BD2A8 800CCAA8 21288002 */  addu       $a1, $s4, $zero
    /* BD2AC 800CCAAC 21302002 */  addu       $a2, $s1, $zero
    /* BD2B0 800CCAB0 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BD2B4 800CCAB4 21386002 */   addu      $a3, $s3, $zero
    /* BD2B8 800CCAB8 1280023C */  lui        $v0, %hi(D_8011FF58)
    /* BD2BC 800CCABC 58FF4224 */  addiu      $v0, $v0, %lo(D_8011FF58)
    /* BD2C0 800CCAC0 000040C8 */  lwc2       $0, 0x0($v0)
    /* BD2C4 800CCAC4 040041C8 */  lwc2       $1, 0x4($v0)
    /* BD2C8 800CCAC8 00000000 */  nop
    /* BD2CC 800CCACC 00000000 */  nop
    /* BD2D0 800CCAD0 0100184A */  .word 0x4A180001  /* rtps */
    /* BD2D4 800CCAD4 1000B027 */  addiu      $s0, $sp, 0x10
    /* BD2D8 800CCAD8 00000EEA */  swc2       $14, 0x0($s0)
    /* BD2DC 800CCADC 21204002 */  addu       $a0, $s2, $zero
    /* BD2E0 800CCAE0 21282002 */  addu       $a1, $s1, $zero
    /* BD2E4 800CCAE4 21300002 */  addu       $a2, $s0, $zero
    /* BD2E8 800CCAE8 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BD2EC 800CCAEC 21386002 */   addu      $a3, $s3, $zero
    /* BD2F0 800CCAF0 1280023C */  lui        $v0, %hi(D_8011FF60)
    /* BD2F4 800CCAF4 60FF4224 */  addiu      $v0, $v0, %lo(D_8011FF60)
    /* BD2F8 800CCAF8 000040C8 */  lwc2       $0, 0x0($v0)
    /* BD2FC 800CCAFC 040041C8 */  lwc2       $1, 0x4($v0)
    /* BD300 800CCB00 00000000 */  nop
    /* BD304 800CCB04 00000000 */  nop
    /* BD308 800CCB08 0100184A */  .word 0x4A180001  /* rtps */
    /* BD30C 800CCB0C 00002EEA */  swc2       $14, 0x0($s1)
    /* BD310 800CCB10 21204002 */  addu       $a0, $s2, $zero
    /* BD314 800CCB14 21280002 */  addu       $a1, $s0, $zero
    /* BD318 800CCB18 21302002 */  addu       $a2, $s1, $zero
    /* BD31C 800CCB1C 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BD320 800CCB20 21386002 */   addu      $a3, $s3, $zero
    /* BD324 800CCB24 21204002 */  addu       $a0, $s2, $zero
    /* BD328 800CCB28 21282002 */  addu       $a1, $s1, $zero
    /* BD32C 800CCB2C 21308002 */  addu       $a2, $s4, $zero
    /* BD330 800CCB30 2C2F030C */  jal        Flare_Tri__FPlN20i
    /* BD334 800CCB34 21386002 */   addu      $a3, $s3, $zero
    /* BD338 800CCB38 3400BF8F */  lw         $ra, 0x34($sp)
    /* BD33C 800CCB3C 3000B48F */  lw         $s4, 0x30($sp)
    /* BD340 800CCB40 2C00B38F */  lw         $s3, 0x2C($sp)
    /* BD344 800CCB44 2800B28F */  lw         $s2, 0x28($sp)
    /* BD348 800CCB48 2400B18F */  lw         $s1, 0x24($sp)
    /* BD34C 800CCB4C 2000B08F */  lw         $s0, 0x20($sp)
    /* BD350 800CCB50 0800E003 */  jr         $ra
    /* BD354 800CCB54 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Flare_QuadFlare__FPli
