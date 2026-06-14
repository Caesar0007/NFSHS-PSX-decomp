.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_OneChosen, 0x10

glabel iSPCH_OneChosen
    /* F1EA4 801016A4 1580023C */  lui        $v0, %hi(D_80148448)
    /* F1EA8 801016A8 4884428C */  lw         $v0, %lo(D_80148448)($v0)
    /* F1EAC 801016AC 0800E003 */  jr         $ra
    /* F1EB0 801016B0 00000000 */   nop
endlabel iSPCH_OneChosen
