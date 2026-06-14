.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_SfxQueued__Fv, 0x6C

glabel CopSpeak_SfxQueued__Fv
    /* 8B460 8009AC60 800B848F */  lw         $a0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B464 8009AC64 7C0B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B468 8009AC68 00000000 */  nop
    /* 8B46C 8009AC6C 15008310 */  beq        $a0, $v1, .L8009ACC4
    /* 8B470 8009AC70 21280000 */   addu      $a1, $zero, $zero
    /* 8B474 8009AC74 1180023C */  lui        $v0, %hi(CopSpeak_gQueue)
    /* 8B478 8009AC78 241F4724 */  addiu      $a3, $v0, %lo(CopSpeak_gQueue)
    /* 8B47C 8009AC7C 21306000 */  addu       $a2, $v1, $zero
    /* 8B480 8009AC80 40110400 */  sll        $v0, $a0, 5
  .L8009AC84:
    /* 8B484 8009AC84 21184700 */  addu       $v1, $v0, $a3
    /* 8B488 8009AC88 1E006280 */  lb         $v0, 0x1E($v1)
    /* 8B48C 8009AC8C 00000000 */  nop
    /* 8B490 8009AC90 06004004 */  bltz       $v0, .L8009ACAC
    /* 8B494 8009AC94 3F008228 */   slti      $v0, $a0, 0x3F
    /* 8B498 8009AC98 1D006290 */  lbu        $v0, 0x1D($v1)
    /* 8B49C 8009AC9C 00000000 */  nop
    /* 8B4A0 8009ACA0 02004010 */  beqz       $v0, .L8009ACAC
    /* 8B4A4 8009ACA4 3F008228 */   slti      $v0, $a0, 0x3F
    /* 8B4A8 8009ACA8 0100A524 */  addiu      $a1, $a1, 0x1
  .L8009ACAC:
    /* 8B4AC 8009ACAC 02004010 */  beqz       $v0, .L8009ACB8
    /* 8B4B0 8009ACB0 21180000 */   addu      $v1, $zero, $zero
    /* 8B4B4 8009ACB4 01008324 */  addiu      $v1, $a0, 0x1
  .L8009ACB8:
    /* 8B4B8 8009ACB8 21206000 */  addu       $a0, $v1, $zero
    /* 8B4BC 8009ACBC F1FF8614 */  bne        $a0, $a2, .L8009AC84
    /* 8B4C0 8009ACC0 40110400 */   sll       $v0, $a0, 5
  .L8009ACC4:
    /* 8B4C4 8009ACC4 0800E003 */  jr         $ra
    /* 8B4C8 8009ACC8 2110A000 */   addu      $v0, $a1, $zero
endlabel CopSpeak_SfxQueued__Fv
