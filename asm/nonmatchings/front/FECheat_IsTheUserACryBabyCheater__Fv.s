.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_IsTheUserACryBabyCheater__Fv, 0x10

glabel FECheat_IsTheUserACryBabyCheater__Fv
    /* 13FD0 800237D0 1480023C */  lui        $v0, %hi(gFECheats)
    /* 13FD4 800237D4 78D2428C */  lw         $v0, %lo(gFECheats)($v0)
    /* 13FD8 800237D8 0800E003 */  jr         $ra
    /* 13FDC 800237DC 2B100200 */   sltu      $v0, $zero, $v0
endlabel FECheat_IsTheUserACryBabyCheater__Fv
