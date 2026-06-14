.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIHigh_CleanUp__Fv, 0x8C

glabel AIHigh_CleanUp__Fv
    /* 4B984 8005B184 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4B988 8005B188 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4B98C 8005B18C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4B990 8005B190 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4B994 8005B194 21880000 */  addu       $s1, $zero, $zero
    /* 4B998 8005B198 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4B99C 8005B19C 15004018 */  blez       $v0, .L8005B1F4
    /* 4B9A0 8005B1A0 1000B0AF */   sw        $s0, 0x10($sp)
    /* 4B9A4 8005B1A4 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4B9A8 8005B1A8 38CD5024 */  addiu      $s0, $v0, %lo(highLevelAIObjs)
  .L8005B1AC:
    /* 4B9AC 8005B1AC 0000038E */  lw         $v1, 0x0($s0)
    /* 4B9B0 8005B1B0 00000000 */  nop
    /* 4B9B4 8005B1B4 09006010 */  beqz       $v1, .L8005B1DC
    /* 4B9B8 8005B1B8 03000524 */   addiu     $a1, $zero, 0x3
    /* 4B9BC 8005B1BC 1400628C */  lw         $v0, 0x14($v1)
    /* 4B9C0 8005B1C0 00000000 */  nop
    /* 4B9C4 8005B1C4 10004484 */  lh         $a0, 0x10($v0)
    /* 4B9C8 8005B1C8 1400428C */  lw         $v0, 0x14($v0)
    /* 4B9CC 8005B1CC 00000000 */  nop
    /* 4B9D0 8005B1D0 09F84000 */  jalr       $v0
    /* 4B9D4 8005B1D4 21206400 */   addu      $a0, $v1, $a0
    /* 4B9D8 8005B1D8 000000AE */  sw         $zero, 0x0($s0)
  .L8005B1DC:
    /* 4B9DC 8005B1DC 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4B9E0 8005B1E0 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4B9E4 8005B1E4 01003126 */  addiu      $s1, $s1, 0x1
    /* 4B9E8 8005B1E8 2A102202 */  slt        $v0, $s1, $v0
    /* 4B9EC 8005B1EC EFFF4014 */  bnez       $v0, .L8005B1AC
    /* 4B9F0 8005B1F0 04001026 */   addiu     $s0, $s0, 0x4
  .L8005B1F4:
    /* 4B9F4 8005B1F4 79BE010C */  jal        AIState_CleanUp__Fv
    /* 4B9F8 8005B1F8 00000000 */   nop
    /* 4B9FC 8005B1FC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4BA00 8005B200 1400B18F */  lw         $s1, 0x14($sp)
    /* 4BA04 8005B204 1000B08F */  lw         $s0, 0x10($sp)
    /* 4BA08 8005B208 0800E003 */  jr         $ra
    /* 4BA0C 8005B20C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIHigh_CleanUp__Fv
