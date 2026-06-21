.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetExpert__FR12tMenuCommand, 0x10

glabel MenuExtended_SetExpert__FR12tMenuCommand
    /* 1E97C 8002E17C 1180033C */  lui        $v1, %hi(D_80114606)
    /* 1E980 8002E180 02000224 */  addiu      $v0, $zero, 0x2
    /* 1E984 8002E184 0800E003 */  jr         $ra
    /* 1E988 8002E188 064662A0 */   sb        $v0, %lo(D_80114606)($v1)
endlabel MenuExtended_SetExpert__FR12tMenuCommand
