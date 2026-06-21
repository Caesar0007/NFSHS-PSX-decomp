.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToSETrophyRoom__FR12tMenuCommand, 0x10

glabel MenuExtended_GoToSETrophyRoom__FR12tMenuCommand
    /* 1E950 8002E150 1180033C */  lui        $v1, %hi(D_80114722)
    /* 1E954 8002E154 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E958 8002E158 0800E003 */  jr         $ra
    /* 1E95C 8002E15C 224762A0 */   sb        $v0, %lo(D_80114722)($v1)
endlabel MenuExtended_GoToSETrophyRoom__FR12tMenuCommand
