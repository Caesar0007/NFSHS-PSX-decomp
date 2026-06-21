.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetBeginner__FR12tMenuCommand, 0xC

glabel MenuExtended_SetBeginner__FR12tMenuCommand
    /* 1E960 8002E160 1180023C */  lui        $v0, %hi(D_80114606)
    /* 1E964 8002E164 0800E003 */  jr         $ra
    /* 1E968 8002E168 064640A0 */   sb        $zero, %lo(D_80114606)($v0)
endlabel MenuExtended_SetBeginner__FR12tMenuCommand
