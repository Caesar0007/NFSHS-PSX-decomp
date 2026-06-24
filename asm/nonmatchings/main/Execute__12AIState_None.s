.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__12AIState_None, 0x8

glabel Execute__12AIState_None
    /* 4BC88 8005B488 0800E003 */  jr         $ra
    /* 4BC8C 8005B48C 00000000 */   nop
endlabel Execute__12AIState_None
