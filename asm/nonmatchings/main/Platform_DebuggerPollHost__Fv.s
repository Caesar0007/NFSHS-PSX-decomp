.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_DebuggerPollHost__Fv, 0x8

glabel Platform_DebuggerPollHost__Fv
    /* CCC50 800DC450 0800E003 */  jr         $ra
    /* CCC54 800DC454 00000000 */   nop
endlabel Platform_DebuggerPollHost__Fv
