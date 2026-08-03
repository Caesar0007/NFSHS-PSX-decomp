.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TestForRelease__12AIState_Base_80072830, 0x8

glabel TestForRelease__12AIState_Base_80072830
    /* 63030 80072830 0800E003 */  jr         $ra
    /* 63034 80072834 21100000 */   addu      $v0, $zero, $zero
endlabel TestForRelease__12AIState_Base_80072830
