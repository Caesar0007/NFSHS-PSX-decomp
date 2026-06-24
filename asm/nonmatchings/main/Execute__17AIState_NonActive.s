.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__17AIState_NonActive, 0x8

glabel Execute__17AIState_NonActive
    /* 4FE24 8005F624 0800E003 */  jr         $ra
    /* 4FE28 8005F628 00000000 */   nop
endlabel Execute__17AIState_NonActive
