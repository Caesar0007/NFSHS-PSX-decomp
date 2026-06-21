.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x30

glabel ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 2A354 80039B54 0000C38C */  lw         $v1, 0x0($a2)
    /* 2A358 80039B58 02000224 */  addiu      $v0, $zero, 0x2
    /* 2A35C 80039B5C 07006214 */  bne        $v1, $v0, .L80039B7C
    /* 2A360 80039B60 00000000 */   nop
    /* 2A364 80039B64 8800828C */  lw         $v0, 0x88($a0)
    /* 2A368 80039B68 00000000 */  nop
    /* 2A36C 80039B6C 03004014 */  bnez       $v0, .L80039B7C
    /* 2A370 80039B70 01000224 */   addiu     $v0, $zero, 0x1
    /* 2A374 80039B74 0000C2AC */  sw         $v0, 0x0($a2)
    /* 2A378 80039B78 8C0082AC */  sw         $v0, 0x8C($a0)
  .L80039B7C:
    /* 2A37C 80039B7C 0800E003 */  jr         $ra
    /* 2A380 80039B80 00000000 */   nop
endlabel ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
