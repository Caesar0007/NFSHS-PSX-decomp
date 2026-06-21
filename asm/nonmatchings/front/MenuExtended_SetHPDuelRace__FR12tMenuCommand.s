.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetHPDuelRace__FR12tMenuCommand, 0x2C

glabel MenuExtended_SetHPDuelRace__FR12tMenuCommand
    /* 1DB24 8002D324 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1DB28 8002D328 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1DB2C 8002D32C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1DB30 8002D330 460040A0 */  sb         $zero, 0x46($v0)
    /* 1DB34 8002D334 040043A0 */  sb         $v1, 0x4($v0)
    /* 1DB38 8002D338 1E0343A0 */  sb         $v1, 0x31E($v0)
    /* 1DB3C 8002D33C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1DB40 8002D340 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1DB44 8002D344 01000224 */  addiu      $v0, $zero, 0x1
    /* 1DB48 8002D348 0800E003 */  jr         $ra
    /* 1DB4C 8002D34C 7C1162AC */   sw        $v0, 0x117C($v1)
endlabel MenuExtended_SetHPDuelRace__FR12tMenuCommand
