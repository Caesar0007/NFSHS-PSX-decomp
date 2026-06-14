.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PCcreat, 0x20

glabel PCcreat
    /* F74D0 80106CD0 21288000 */  addu       $a1, $a0, $zero
    /* F74D4 80106CD4 21300000 */  addu       $a2, $zero, $zero
    /* F74D8 80106CD8 8D400000 */  break      0, 258
    /* F74DC 80106CDC 02004010 */  beqz       $v0, .L80106CE8
    /* F74E0 80106CE0 21106000 */   addu      $v0, $v1, $zero
    /* F74E4 80106CE4 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80106CE8:
    /* F74E8 80106CE8 0800E003 */  jr         $ra
    /* F74EC 80106CEC 00000000 */   nop
endlabel PCcreat
