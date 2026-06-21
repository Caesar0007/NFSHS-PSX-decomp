.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetHPSoloRace__FR12tMenuCommand, 0x2C

glabel MenuExtended_SetHPSoloRace__FR12tMenuCommand
    /* 1DAF8 8002D2F8 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1DAFC 8002D2FC 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1DB00 8002D300 01000324 */  addiu      $v1, $zero, 0x1
    /* 1DB04 8002D304 460040A0 */  sb         $zero, 0x46($v0)
    /* 1DB08 8002D308 040043A0 */  sb         $v1, 0x4($v0)
    /* 1DB0C 8002D30C 1E0340A0 */  sb         $zero, 0x31E($v0)
    /* 1DB10 8002D310 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1DB14 8002D314 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1DB18 8002D318 0B000224 */  addiu      $v0, $zero, 0xB
    /* 1DB1C 8002D31C 0800E003 */  jr         $ra
    /* 1DB20 8002D320 7C1162AC */   sw        $v0, 0x117C($v1)
endlabel MenuExtended_SetHPSoloRace__FR12tMenuCommand
