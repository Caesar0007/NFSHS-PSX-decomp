.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TestForRelease__12AIState_Base_8005F678, 0x8

glabel TestForRelease__12AIState_Base_8005F678
    /* 4FE78 8005F678 0800E003 */  jr         $ra
    /* 4FE7C 8005F67C 21100000 */   addu      $v0, $zero, $zero
endlabel TestForRelease__12AIState_Base_8005F678
