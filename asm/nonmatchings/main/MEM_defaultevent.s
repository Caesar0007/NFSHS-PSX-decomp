.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MEM_defaultevent, 0x8

glabel MEM_defaultevent
    /* E4978 800F4178 0800E003 */  jr         $ra
    /* E497C 800F417C 21100000 */   addu      $v0, $zero, $zero
endlabel MEM_defaultevent
