.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PCopen, 0x20

glabel PCopen
    /* F74A4 80106CA4 2130A000 */  addu       $a2, $a1, $zero
    /* F74A8 80106CA8 21288000 */  addu       $a1, $a0, $zero
    /* F74AC 80106CAC CD400000 */  break      0, 259
    /* F74B0 80106CB0 02004010 */  beqz       $v0, .L80106CBC
    /* F74B4 80106CB4 21106000 */   addu      $v0, $v1, $zero
    /* F74B8 80106CB8 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80106CBC:
    /* F74BC 80106CBC 0800E003 */  jr         $ra
    /* F74C0 80106CC0 00000000 */   nop
endlabel PCopen
