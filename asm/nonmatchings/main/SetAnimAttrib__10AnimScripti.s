.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetAnimAttrib__10AnimScripti, 0x8

glabel SetAnimAttrib__10AnimScripti
    /* 64D34 80074534 0800E003 */  jr         $ra
    /* 64D38 80074538 080085AC */   sw        $a1, 0x8($a0)
endlabel SetAnimAttrib__10AnimScripti
