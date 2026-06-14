.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_DebugCrap__Fv, 0x8

glabel Hud_DebugCrap__Fv
    /* C2790 800D1F90 0800E003 */  jr         $ra
    /* C2794 800D1F94 00000000 */   nop
endlabel Hud_DebugCrap__Fv
