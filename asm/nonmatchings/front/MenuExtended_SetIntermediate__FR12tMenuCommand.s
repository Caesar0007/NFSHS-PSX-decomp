.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetIntermediate__FR12tMenuCommand, 0x10

glabel MenuExtended_SetIntermediate__FR12tMenuCommand
    /* 1E96C 8002E16C 1180033C */  lui        $v1, %hi(D_80114606)
    /* 1E970 8002E170 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E974 8002E174 0800E003 */  jr         $ra
    /* 1E978 8002E178 064662A0 */   sb        $v0, %lo(D_80114606)($v1)
endlabel MenuExtended_SetIntermediate__FR12tMenuCommand
