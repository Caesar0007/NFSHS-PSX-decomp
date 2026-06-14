.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_GetNumOpponents__Fv, 0x54

glabel Stats_GetNumOpponents__Fv
    /* A89A8 800B81A8 21280000 */  addu       $a1, $zero, $zero
    /* A89AC 800B81AC 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* A89B0 800B81B0 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* A89B4 800B81B4 00000000 */  nop
    /* A89B8 800B81B8 0E004018 */  blez       $v0, .L800B81F4
    /* A89BC 800B81BC 2120A000 */   addu      $a0, $a1, $zero
    /* A89C0 800B81C0 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* A89C4 800B81C4 21304000 */  addu       $a2, $v0, $zero
    /* A89C8 800B81C8 1280023C */  lui        $v0, %hi(Stats_racePosition)
    /* A89CC 800B81CC E0E04324 */  addiu      $v1, $v0, %lo(Stats_racePosition)
  .L800B81D0:
    /* A89D0 800B81D0 0000628C */  lw         $v0, 0x0($v1)
    /* A89D4 800B81D4 00000000 */  nop
    /* A89D8 800B81D8 02004710 */  beq        $v0, $a3, .L800B81E4
    /* A89DC 800B81DC 00000000 */   nop
    /* A89E0 800B81E0 01008424 */  addiu      $a0, $a0, 0x1
  .L800B81E4:
    /* A89E4 800B81E4 0100A524 */  addiu      $a1, $a1, 0x1
    /* A89E8 800B81E8 2A10A600 */  slt        $v0, $a1, $a2
    /* A89EC 800B81EC F8FF4014 */  bnez       $v0, .L800B81D0
    /* A89F0 800B81F0 10006324 */   addiu     $v1, $v1, 0x10
  .L800B81F4:
    /* A89F4 800B81F4 0800E003 */  jr         $ra
    /* A89F8 800B81F8 21108000 */   addu      $v0, $a0, $zero
endlabel Stats_GetNumOpponents__Fv
