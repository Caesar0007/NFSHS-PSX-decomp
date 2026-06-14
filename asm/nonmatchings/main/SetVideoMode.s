.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetVideoMode, 0x14

glabel SetVideoMode
    /* E1F70 800F1770 1380023C */  lui        $v0, %hi(D_80134838)
    /* E1F74 800F1774 3848428C */  lw         $v0, %lo(D_80134838)($v0)
    /* E1F78 800F1778 1380013C */  lui        $at, %hi(D_80134838)
    /* E1F7C 800F177C 0800E003 */  jr         $ra
    /* E1F80 800F1780 384824AC */   sw        $a0, %lo(D_80134838)($at)
endlabel SetVideoMode
