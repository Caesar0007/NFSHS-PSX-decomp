.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadImage, 0x60

glabel LoadImage
    /* DE290 800EDA90 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE294 800EDA94 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE298 800EDA98 21808000 */  addu       $s0, $a0, $zero
    /* DE29C 800EDA9C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE2A0 800EDAA0 2188A000 */  addu       $s1, $a1, $zero
    /* DE2A4 800EDAA4 0580043C */  lui        $a0, %hi(D_80056E04)
    /* DE2A8 800EDAA8 046E8424 */  addiu      $a0, $a0, %lo(D_80056E04)
    /* DE2AC 800EDAAC 1800BFAF */  sw         $ra, 0x18($sp)
    /* DE2B0 800EDAB0 39B6030C */  jal        func_800ED8E4
    /* DE2B4 800EDAB4 21280002 */   addu      $a1, $s0, $zero
    /* DE2B8 800EDAB8 21280002 */  addu       $a1, $s0, $zero
    /* DE2BC 800EDABC 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE2C0 800EDAC0 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE2C4 800EDAC4 08000624 */  addiu      $a2, $zero, 0x8
    /* DE2C8 800EDAC8 2000448C */  lw         $a0, 0x20($v0)
    /* DE2CC 800EDACC 0800428C */  lw         $v0, 0x8($v0)
    /* DE2D0 800EDAD0 00000000 */  nop
    /* DE2D4 800EDAD4 09F84000 */  jalr       $v0
    /* DE2D8 800EDAD8 21382002 */   addu      $a3, $s1, $zero
    /* DE2DC 800EDADC 1800BF8F */  lw         $ra, 0x18($sp)
    /* DE2E0 800EDAE0 1400B18F */  lw         $s1, 0x14($sp)
    /* DE2E4 800EDAE4 1000B08F */  lw         $s0, 0x10($sp)
    /* DE2E8 800EDAE8 0800E003 */  jr         $ra
    /* DE2EC 800EDAEC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel LoadImage
