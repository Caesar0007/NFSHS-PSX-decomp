.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_Fail__Fi, 0x70

glabel Device_Fail__Fi
    /* ADC68 800BD468 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* ADC6C 800BD46C 1000B0AF */  sw         $s0, 0x10($sp)
    /* ADC70 800BD470 1400BFAF */  sw         $ra, 0x14($sp)
    /* ADC74 800BD474 F0F4020C */  jal        Device_VerifyType__Fi
    /* ADC78 800BD478 21808000 */   addu      $s0, $a0, $zero
    /* ADC7C 800BD47C 06004010 */  beqz       $v0, .L800BD498
    /* ADC80 800BD480 2B101000 */   sltu      $v0, $zero, $s0
    /* ADC84 800BD484 1480033C */  lui        $v1, %hi(D_8013DDE4)
    /* ADC88 800BD488 E4DD6324 */  addiu      $v1, $v1, %lo(D_8013DDE4)
    /* ADC8C 800BD48C 21104300 */  addu       $v0, $v0, $v1
    /* ADC90 800BD490 31F50208 */  j          .L800BD4C4
    /* ADC94 800BD494 000040A0 */   sb        $zero, 0x0($v0)
  .L800BD498:
    /* ADC98 800BD498 1480033C */  lui        $v1, %hi(D_8013DDE4)
    /* ADC9C 800BD49C E4DD6324 */  addiu      $v1, $v1, %lo(D_8013DDE4)
    /* ADCA0 800BD4A0 21204300 */  addu       $a0, $v0, $v1
    /* ADCA4 800BD4A4 00008390 */  lbu        $v1, 0x0($a0)
    /* ADCA8 800BD4A8 00000000 */  nop
    /* ADCAC 800BD4AC 0900622C */  sltiu      $v0, $v1, 0x9
    /* ADCB0 800BD4B0 03004014 */  bnez       $v0, .L800BD4C0
    /* ADCB4 800BD4B4 01006224 */   addiu     $v0, $v1, 0x1
    /* ADCB8 800BD4B8 32F50208 */  j          .L800BD4C8
    /* ADCBC 800BD4BC 01000224 */   addiu     $v0, $zero, 0x1
  .L800BD4C0:
    /* ADCC0 800BD4C0 000082A0 */  sb         $v0, 0x0($a0)
  .L800BD4C4:
    /* ADCC4 800BD4C4 21100000 */  addu       $v0, $zero, $zero
  .L800BD4C8:
    /* ADCC8 800BD4C8 1400BF8F */  lw         $ra, 0x14($sp)
    /* ADCCC 800BD4CC 1000B08F */  lw         $s0, 0x10($sp)
    /* ADCD0 800BD4D0 0800E003 */  jr         $ra
    /* ADCD4 800BD4D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Device_Fail__Fi
