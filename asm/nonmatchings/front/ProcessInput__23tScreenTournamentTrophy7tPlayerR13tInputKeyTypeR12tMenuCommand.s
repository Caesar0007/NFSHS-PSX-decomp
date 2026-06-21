.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x48

glabel ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 39670 80048E70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39674 80048E74 1000BFAF */  sw         $ra, 0x10($sp)
    /* 39678 80048E78 0000C38C */  lw         $v1, 0x0($a2)
    /* 3967C 80048E7C 02000224 */  addiu      $v0, $zero, 0x2
    /* 39680 80048E80 07006214 */  bne        $v1, $v0, .L80048EA0
    /* 39684 80048E84 00000000 */   nop
    /* 39688 80048E88 6801828C */  lw         $v0, 0x168($a0)
    /* 3968C 80048E8C 00000000 */  nop
    /* 39690 80048E90 03004014 */  bnez       $v0, .L80048EA0
    /* 39694 80048E94 01000224 */   addiu     $v0, $zero, 0x1
    /* 39698 80048E98 0000C2AC */  sw         $v0, 0x0($a2)
    /* 3969C 80048E9C 6C0182AC */  sw         $v0, 0x16C($a0)
  .L80048EA0:
    /* 396A0 80048EA0 BC22010C */  jal        ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 396A4 80048EA4 00000000 */   nop
    /* 396A8 80048EA8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 396AC 80048EAC 00000000 */  nop
    /* 396B0 80048EB0 0800E003 */  jr         $ra
    /* 396B4 80048EB4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand
