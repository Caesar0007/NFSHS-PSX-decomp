.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StatusCount__Q26Speech15DispatchSpeaker, 0xC

glabel StatusCount__Q26Speech15DispatchSpeaker
    /* 89B58 80099358 5000828C */  lw         $v0, 0x50($a0)
    /* 89B5C 8009935C 0800E003 */  jr         $ra
    /* 89B60 80099360 00000000 */   nop
endlabel StatusCount__Q26Speech15DispatchSpeaker
