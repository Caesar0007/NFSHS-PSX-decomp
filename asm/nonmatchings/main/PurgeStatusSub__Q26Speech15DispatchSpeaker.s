.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PurgeStatusSub__Q26Speech15DispatchSpeaker, 0x8

glabel PurgeStatusSub__Q26Speech15DispatchSpeaker
    /* 89B44 80099344 0800E003 */  jr         $ra
    /* 89B48 80099348 540080AC */   sw        $zero, 0x54($a0)
endlabel PurgeStatusSub__Q26Speech15DispatchSpeaker
