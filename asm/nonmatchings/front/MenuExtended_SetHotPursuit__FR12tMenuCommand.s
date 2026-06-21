.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetHotPursuit__FR12tMenuCommand, 0x50

glabel MenuExtended_SetHotPursuit__FR12tMenuCommand
    /* 1DB50 8002D350 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1DB54 8002D354 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1DB58 8002D358 01000324 */  addiu      $v1, $zero, 0x1
    /* 1DB5C 8002D35C 2A0140A0 */  sb         $zero, 0x12A($v0)
    /* 1DB60 8002D360 460040A0 */  sb         $zero, 0x46($v0)
    /* 1DB64 8002D364 040043A0 */  sb         $v1, 0x4($v0)
    /* 1DB68 8002D368 03004290 */  lbu        $v0, 0x3($v0)
    /* 1DB6C 8002D36C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1DB70 8002D370 05004314 */  bne        $v0, $v1, .L8002D388
    /* 1DB74 8002D374 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1DB78 8002D378 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1DB7C 8002D37C 09000224 */  addiu      $v0, $zero, 0x9
    /* 1DB80 8002D380 E5B40008 */  j          .L8002D394
    /* 1DB84 8002D384 7C1162AC */   sw        $v0, 0x117C($v1)
  .L8002D388:
    /* 1DB88 8002D388 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1DB8C 8002D38C 00000000 */  nop
    /* 1DB90 8002D390 7C1143AC */  sw         $v1, 0x117C($v0)
  .L8002D394:
    /* 1DB94 8002D394 1180023C */  lui        $v0, %hi(D_8011491E)
    /* 1DB98 8002D398 0800E003 */  jr         $ra
    /* 1DB9C 8002D39C 1E4940A0 */   sb        $zero, %lo(D_8011491E)($v0)
endlabel MenuExtended_SetHotPursuit__FR12tMenuCommand
