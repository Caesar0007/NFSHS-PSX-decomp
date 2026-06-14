.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StartUp__17AIState_Purgatory, 0xC

glabel StartUp__17AIState_Purgatory
    /* 62040 80071840 301880AF */  sw         $zero, %gp_rel(_bss_obj)($gp)
    /* 62044 80071844 0800E003 */  jr         $ra
    /* 62048 80071848 00000000 */   nop
endlabel StartUp__17AIState_Purgatory
