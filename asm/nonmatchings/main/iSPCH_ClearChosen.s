.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ClearChosen, 0xC

glabel iSPCH_ClearChosen
    /* F1E50 80101650 1580023C */  lui        $v0, %hi(D_80148448)
    /* F1E54 80101654 0800E003 */  jr         $ra
    /* F1E58 80101658 488440AC */   sw        $zero, %lo(D_80148448)($v0)
endlabel iSPCH_ClearChosen
