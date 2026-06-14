.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetSp, 0xC

glabel SetSp
    /* D4CAC 800E44AC 2110A003 */  addu       $v0, $sp, $zero
    /* D4CB0 800E44B0 0800E003 */  jr         $ra
    /* D4CB4 800E44B4 21E88000 */   addu      $sp, $a0, $zero
endlabel SetSp
    /* D4CB8 800E44B8 00000000 */  nop
