.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StatusSub__Q26Speech15DispatchSpeaker, 0xC

glabel StatusSub__Q26Speech15DispatchSpeaker
    /* 89B4C 8009934C 5400828C */  lw         $v0, 0x54($a0)
    /* 89B50 80099350 0800E003 */  jr         $ra
    /* 89B54 80099354 00000000 */   nop
endlabel StatusSub__Q26Speech15DispatchSpeaker
