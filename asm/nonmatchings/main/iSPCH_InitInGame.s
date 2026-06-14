.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_InitInGame, 0x18

glabel iSPCH_InitInGame
    /* DBE54 800EB654 1580023C */  lui        $v0, %hi(gVoxInGame)
    /* DBE58 800EB658 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* DBE5C 800EB65C 588043AC */  sw         $v1, %lo(gVoxInGame)($v0)
    /* DBE60 800EB660 58804224 */  addiu      $v0, $v0, %lo(gVoxInGame)
    /* DBE64 800EB664 0800E003 */  jr         $ra
    /* DBE68 800EB668 040040AC */   sw        $zero, 0x4($v0)
endlabel iSPCH_InitInGame
