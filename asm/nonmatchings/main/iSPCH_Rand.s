.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_Rand, 0x54

glabel iSPCH_Rand
    /* DC330 800EBB30 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DC334 800EBB34 1000B0AF */  sw         $s0, 0x10($sp)
    /* DC338 800EBB38 1400BFAF */  sw         $ra, 0x14($sp)
    /* DC33C 800EBB3C 71AE030C */  jal        iSPCH_EACrandom
    /* DC340 800EBB40 21808000 */   addu      $s0, $a0, $zero
    /* DC344 800EBB44 FFFF4330 */  andi       $v1, $v0, 0xFFFF
    /* DC348 800EBB48 1A007000 */  div        $zero, $v1, $s0
    /* DC34C 800EBB4C 02000016 */  bnez       $s0, .L800EBB58
    /* DC350 800EBB50 00000000 */   nop
    /* DC354 800EBB54 0D000700 */  break      7
  .L800EBB58:
    /* DC358 800EBB58 FFFF0124 */  addiu      $at, $zero, -0x1
    /* DC35C 800EBB5C 04000116 */  bne        $s0, $at, .L800EBB70
    /* DC360 800EBB60 0080013C */   lui       $at, (0x80000000 >> 16)
    /* DC364 800EBB64 02006114 */  bne        $v1, $at, .L800EBB70
    /* DC368 800EBB68 00000000 */   nop
    /* DC36C 800EBB6C 0D000600 */  break      6
  .L800EBB70:
    /* DC370 800EBB70 10100000 */  mfhi       $v0
    /* DC374 800EBB74 1400BF8F */  lw         $ra, 0x14($sp)
    /* DC378 800EBB78 1000B08F */  lw         $s0, 0x10($sp)
    /* DC37C 800EBB7C 0800E003 */  jr         $ra
    /* DC380 800EBB80 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_Rand
