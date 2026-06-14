.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_Null__FUl, 0x8

glabel Device_Null__FUl
    /* AE2B8 800BDAB8 0800E003 */  jr         $ra
    /* AE2BC 800BDABC 21100000 */   addu      $v0, $zero, $zero
endlabel Device_Null__FUl
