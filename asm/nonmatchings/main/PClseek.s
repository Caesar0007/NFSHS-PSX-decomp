.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PClseek, 0x24

glabel PClseek
    /* F751C 80106D1C 2138C000 */  addu       $a3, $a2, $zero
    /* F7520 80106D20 2130A000 */  addu       $a2, $a1, $zero
    /* F7524 80106D24 21288000 */  addu       $a1, $a0, $zero
    /* F7528 80106D28 CD410000 */  break      0, 263
    /* F752C 80106D2C 02004010 */  beqz       $v0, .L80106D38
    /* F7530 80106D30 21106000 */   addu      $v0, $v1, $zero
    /* F7534 80106D34 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80106D38:
    /* F7538 80106D38 0800E003 */  jr         $ra
    /* F753C 80106D3C 00000000 */   nop
endlabel PClseek
