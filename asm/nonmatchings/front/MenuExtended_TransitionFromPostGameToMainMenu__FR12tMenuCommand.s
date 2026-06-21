.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand, 0x1C

glabel MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
    /* 1CC94 8002C494 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1CC98 8002C498 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CC9C 8002C49C 02000324 */  addiu      $v1, $zero, 0x2
    /* 1CCA0 8002C4A0 000083AC */  sw         $v1, 0x0($a0)
    /* 1CCA4 8002C4A4 B0004224 */  addiu      $v0, $v0, 0xB0
    /* 1CCA8 8002C4A8 0800E003 */  jr         $ra
    /* 1CCAC 8002C4AC 040082AC */   sw        $v0, 0x4($a0)
endlabel MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
