.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawOTag, 0x70

glabel DrawOTag
    /* DE4B4 800EDCB4 1280023C */  lui        $v0, %hi(D_8012369E)
    /* DE4B8 800EDCB8 9E364290 */  lbu        $v0, %lo(D_8012369E)($v0)
    /* DE4BC 800EDCBC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DE4C0 800EDCC0 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE4C4 800EDCC4 21808000 */  addu       $s0, $a0, $zero
    /* DE4C8 800EDCC8 0200422C */  sltiu      $v0, $v0, 0x2
    /* DE4CC 800EDCCC 08004014 */  bnez       $v0, .L800EDCF0
    /* DE4D0 800EDCD0 1400BFAF */   sw        $ra, 0x14($sp)
    /* DE4D4 800EDCD4 0580043C */  lui        $a0, %hi(D_80056E58)
    /* DE4D8 800EDCD8 586E8424 */  addiu      $a0, $a0, %lo(D_80056E58)
    /* DE4DC 800EDCDC 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE4E0 800EDCE0 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE4E4 800EDCE4 00000000 */  nop
    /* DE4E8 800EDCE8 09F84000 */  jalr       $v0
    /* DE4EC 800EDCEC 21280002 */   addu      $a1, $s0, $zero
  .L800EDCF0:
    /* DE4F0 800EDCF0 21280002 */  addu       $a1, $s0, $zero
    /* DE4F4 800EDCF4 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE4F8 800EDCF8 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE4FC 800EDCFC 21300000 */  addu       $a2, $zero, $zero
    /* DE500 800EDD00 1800448C */  lw         $a0, 0x18($v0)
    /* DE504 800EDD04 0800428C */  lw         $v0, 0x8($v0)
    /* DE508 800EDD08 00000000 */  nop
    /* DE50C 800EDD0C 09F84000 */  jalr       $v0
    /* DE510 800EDD10 21380000 */   addu      $a3, $zero, $zero
    /* DE514 800EDD14 1400BF8F */  lw         $ra, 0x14($sp)
    /* DE518 800EDD18 1000B08F */  lw         $s0, 0x10($sp)
    /* DE51C 800EDD1C 0800E003 */  jr         $ra
    /* DE520 800EDD20 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawOTag
