.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_GetRearEndDamageFactor__FP8Car_tObj, 0x58

glabel AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
    /* 5C270 8006BA70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5C274 8006BA74 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5C278 8006BA78 2802838C */  lw         $v1, 0x228($a0)
    /* 5C27C 8006BA7C 2C02828C */  lw         $v0, 0x22C($a0)
    /* 5C280 8006BA80 47010524 */  addiu      $a1, $zero, 0x147
    /* 5C284 8006BA84 21186200 */  addu       $v1, $v1, $v0
    /* 5C288 8006BA88 3002828C */  lw         $v0, 0x230($a0)
    /* 5C28C 8006BA8C 3C02848C */  lw         $a0, 0x23C($a0)
    /* 5C290 8006BA90 21186200 */  addu       $v1, $v1, $v0
    /* 5C294 8006BA94 CA90030C */  jal        fixedmult
    /* 5C298 8006BA98 21206400 */   addu      $a0, $v1, $a0
    /* 5C29C 8006BA9C 21184000 */  addu       $v1, $v0, $zero
    /* 5C2A0 8006BAA0 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 5C2A4 8006BAA4 21108000 */  addu       $v0, $a0, $zero
    /* 5C2A8 8006BAA8 2A104300 */  slt        $v0, $v0, $v1
    /* 5C2AC 8006BAAC 02004014 */  bnez       $v0, .L8006BAB8
    /* 5C2B0 8006BAB0 00000000 */   nop
    /* 5C2B4 8006BAB4 21206000 */  addu       $a0, $v1, $zero
  .L8006BAB8:
    /* 5C2B8 8006BAB8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5C2BC 8006BABC 21108000 */  addu       $v0, $a0, $zero
    /* 5C2C0 8006BAC0 0800E003 */  jr         $ra
    /* 5C2C4 8006BAC4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
