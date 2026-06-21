.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand, 0xC

glabel MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand
    /* 1E944 8002E144 1180023C */  lui        $v0, %hi(D_80114722)
    /* 1E948 8002E148 0800E003 */  jr         $ra
    /* 1E94C 8002E14C 224740A0 */   sb        $zero, %lo(D_80114722)($v0)
endlabel MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand
