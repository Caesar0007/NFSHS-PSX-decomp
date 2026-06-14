.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_SetWeatherColors__Fi, 0x7C

glabel Night_SetWeatherColors__Fi
    /* CC2D4 800DBAD4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CC2D8 800DBAD8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CC2DC 800DBADC 21988000 */  addu       $s3, $a0, $zero
    /* CC2E0 800DBAE0 1800B2AF */  sw         $s2, 0x18($sp)
    /* CC2E4 800DBAE4 21900000 */  addu       $s2, $zero, $zero
    /* CC2E8 800DBAE8 1400B1AF */  sw         $s1, 0x14($sp)
    /* CC2EC 800DBAEC 1480113C */  lui        $s1, %hi(Night_gWeatherColor)
    /* CC2F0 800DBAF0 88DA3126 */  addiu      $s1, $s1, %lo(Night_gWeatherColor)
    /* CC2F4 800DBAF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC2F8 800DBAF8 1480103C */  lui        $s0, %hi(Night_gWeatherLightingTable)
    /* CC2FC 800DBAFC F0D91026 */  addiu      $s0, $s0, %lo(Night_gWeatherLightingTable)
    /* CC300 800DBB00 2000BFAF */  sw         $ra, 0x20($sp)
  .L800DBB04:
    /* CC304 800DBB04 0000258E */  lw         $a1, 0x0($s1)
    /* CC308 800DBB08 04003126 */  addiu      $s1, $s1, 0x4
    /* CC30C 800DBB0C 0000078E */  lw         $a3, 0x0($s0)
    /* CC310 800DBB10 04001026 */  addiu      $s0, $s0, 0x4
    /* CC314 800DBB14 01005226 */  addiu      $s2, $s2, 0x1
    /* CC318 800DBB18 21206002 */  addu       $a0, $s3, $zero
    /* CC31C 800DBB1C 0F000624 */  addiu      $a2, $zero, 0xF
    /* CC320 800DBB20 F86C030C */  jal        Night_CreateNightTableElement__FiliPUc
    /* CC324 800DBB24 2138F300 */   addu      $a3, $a3, $s3
    /* CC328 800DBB28 0200422A */  slti       $v0, $s2, 0x2
    /* CC32C 800DBB2C F5FF4014 */  bnez       $v0, .L800DBB04
    /* CC330 800DBB30 00000000 */   nop
    /* CC334 800DBB34 2000BF8F */  lw         $ra, 0x20($sp)
    /* CC338 800DBB38 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CC33C 800DBB3C 1800B28F */  lw         $s2, 0x18($sp)
    /* CC340 800DBB40 1400B18F */  lw         $s1, 0x14($sp)
    /* CC344 800DBB44 1000B08F */  lw         $s0, 0x10($sp)
    /* CC348 800DBB48 0800E003 */  jr         $ra
    /* CC34C 800DBB4C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Night_SetWeatherColors__Fi
