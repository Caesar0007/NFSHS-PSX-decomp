.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_SaveBonus__FRUl, 0x10

glabel FECheat_SaveBonus__FRUl
    /* 13F48 80023748 1480023C */  lui        $v0, %hi(gFEBonus)
    /* 13F4C 8002374C 7CD2428C */  lw         $v0, %lo(gFEBonus)($v0)
    /* 13F50 80023750 0800E003 */  jr         $ra
    /* 13F54 80023754 000082AC */   sw        $v0, 0x0($a0)
endlabel FECheat_SaveBonus__FRUl
