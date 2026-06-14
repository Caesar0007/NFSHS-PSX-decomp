.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_Initialize__FPci, 0x24

glabel Cars_Initialize__FPci
    /* 7ADB4 8008A5B4 0600A018 */  blez       $a1, .L8008A5D0
    /* 7ADB8 8008A5B8 21180000 */   addu      $v1, $zero, $zero
  .L8008A5BC:
    /* 7ADBC 8008A5BC 000080A0 */  sb         $zero, 0x0($a0)
    /* 7ADC0 8008A5C0 01006324 */  addiu      $v1, $v1, 0x1
    /* 7ADC4 8008A5C4 2A106500 */  slt        $v0, $v1, $a1
    /* 7ADC8 8008A5C8 FCFF4014 */  bnez       $v0, .L8008A5BC
    /* 7ADCC 8008A5CC 01008424 */   addiu     $a0, $a0, 0x1
  .L8008A5D0:
    /* 7ADD0 8008A5D0 0800E003 */  jr         $ra
    /* 7ADD4 8008A5D4 00000000 */   nop
endlabel Cars_Initialize__FPci
