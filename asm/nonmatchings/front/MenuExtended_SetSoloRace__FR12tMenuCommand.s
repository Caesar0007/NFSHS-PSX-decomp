.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetSoloRace__FR12tMenuCommand, 0x20

glabel MenuExtended_SetSoloRace__FR12tMenuCommand
    /* 1CA68 8002C268 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CA6C 8002C26C 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1CA70 8002C270 01000324 */  addiu      $v1, $zero, 0x1
    /* 1CA74 8002C274 460040A0 */  sb         $zero, 0x46($v0)
    /* 1CA78 8002C278 040040A0 */  sb         $zero, 0x4($v0)
    /* 1CA7C 8002C27C 1E0340A0 */  sb         $zero, 0x31E($v0)
    /* 1CA80 8002C280 0800E003 */  jr         $ra
    /* 1CA84 8002C284 2A0143A0 */   sb        $v1, 0x12A($v0)
endlabel MenuExtended_SetSoloRace__FR12tMenuCommand
