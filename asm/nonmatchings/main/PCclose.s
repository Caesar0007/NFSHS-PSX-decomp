.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PCclose, 0x10

glabel PCclose
    /* F7540 80106D40 21288000 */  addu       $a1, $a0, $zero
    /* F7544 80106D44 0D410000 */  break      0, 260
    /* F7548 80106D48 0800E003 */  jr         $ra
    /* F754C 80106D4C 00000000 */   nop
endlabel PCclose
