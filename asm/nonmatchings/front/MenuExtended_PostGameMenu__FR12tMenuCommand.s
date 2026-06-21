.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_PostGameMenu__FR12tMenuCommand, 0x100

glabel MenuExtended_PostGameMenu__FR12tMenuCommand
    /* 1E304 8002DB04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1E308 8002DB08 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1E30C 8002DB0C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1E310 8002DB10 0E2A010C */  jal        StatChk_ClearNewRecords__Fv
    /* 1E314 8002DB14 21808000 */   addu      $s0, $a0, $zero
    /* 1E318 8002DB18 02000324 */  addiu      $v1, $zero, 0x2
    /* 1E31C 8002DB1C 1180023C */  lui        $v0, %hi(D_80114604)
    /* 1E320 8002DB20 000003AE */  sw         $v1, 0x0($s0)
    /* 1E324 8002DB24 04464490 */  lbu        $a0, %lo(D_80114604)($v0)
    /* 1E328 8002DB28 00000000 */  nop
    /* 1E32C 8002DB2C 0C008310 */  beq        $a0, $v1, .L8002DB60
    /* 1E330 8002DB30 03008228 */   slti      $v0, $a0, 0x3
    /* 1E334 8002DB34 05004010 */  beqz       $v0, .L8002DB4C
    /* 1E338 8002DB38 01000224 */   addiu     $v0, $zero, 0x1
    /* 1E33C 8002DB3C 22008210 */  beq        $a0, $v0, .L8002DBC8
    /* 1E340 8002DB40 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E344 8002DB44 F9B60008 */  j          .L8002DBE4
    /* 1E348 8002DB48 00000000 */   nop
  .L8002DB4C:
    /* 1E34C 8002DB4C 06000224 */  addiu      $v0, $zero, 0x6
    /* 1E350 8002DB50 1A008210 */  beq        $a0, $v0, .L8002DBBC
    /* 1E354 8002DB54 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E358 8002DB58 F9B60008 */  j          .L8002DBE4
    /* 1E35C 8002DB5C 00000000 */   nop
  .L8002DB60:
    /* 1E360 8002DB60 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 1E364 8002DB64 6FCA000C */  jal        IsTournamentFinished__18tTournamentManager
    /* 1E368 8002DB68 D84A8424 */   addiu     $a0, $a0, %lo(tournamentManager)
    /* 1E36C 8002DB6C 00140200 */  sll        $v0, $v0, 16
    /* 1E370 8002DB70 09004010 */  beqz       $v0, .L8002DB98
    /* 1E374 8002DB74 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E378 8002DB78 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E37C 8002DB7C 00000000 */  nop
    /* 1E380 8002DB80 D8354224 */  addiu      $v0, $v0, 0x35D8
    /* 1E384 8002DB84 040002AE */  sw         $v0, 0x4($s0)
    /* 1E388 8002DB88 0580023C */  lui        $v0, %hi(screenTournamentStandings)
    /* 1E38C 8002DB8C 681E438C */  lw         $v1, %lo(screenTournamentStandings)($v0)
    /* 1E390 8002DB90 EDB60008 */  j          .L8002DBB4
    /* 1E394 8002DB94 01000224 */   addiu     $v0, $zero, 0x1
  .L8002DB98:
    /* 1E398 8002DB98 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E39C 8002DB9C 00000000 */  nop
    /* 1E3A0 8002DBA0 30354224 */  addiu      $v0, $v0, 0x3530
    /* 1E3A4 8002DBA4 040002AE */  sw         $v0, 0x4($s0)
    /* 1E3A8 8002DBA8 0580023C */  lui        $v0, %hi(screenTournamentStandings3item)
    /* 1E3AC 8002DBAC 6C1E438C */  lw         $v1, %lo(screenTournamentStandings3item)($v0)
    /* 1E3B0 8002DBB0 01000224 */  addiu      $v0, $zero, 0x1
  .L8002DBB4:
    /* 1E3B4 8002DBB4 FDB60008 */  j          .L8002DBF4
    /* 1E3B8 8002DBB8 840062AC */   sw        $v0, 0x84($v1)
  .L8002DBBC:
    /* 1E3BC 8002DBBC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E3C0 8002DBC0 FCB60008 */  j          .L8002DBF0
    /* 1E3C4 8002DBC4 5C344224 */   addiu     $v0, $v0, 0x345C
  .L8002DBC8:
    /* 1E3C8 8002DBC8 7AB6000C */  jal        func_8002D9E8
    /* 1E3CC 8002DBCC 00000000 */   nop
    /* 1E3D0 8002DBD0 04004010 */  beqz       $v0, .L8002DBE4
    /* 1E3D4 8002DBD4 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E3D8 8002DBD8 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E3DC 8002DBDC FCB60008 */  j          .L8002DBF0
    /* 1E3E0 8002DBE0 F8384224 */   addiu     $v0, $v0, 0x38F8
  .L8002DBE4:
    /* 1E3E4 8002DBE4 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E3E8 8002DBE8 00000000 */  nop
    /* 1E3EC 8002DBEC B0004224 */  addiu      $v0, $v0, 0xB0
  .L8002DBF0:
    /* 1E3F0 8002DBF0 040002AE */  sw         $v0, 0x4($s0)
  .L8002DBF4:
    /* 1E3F4 8002DBF4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1E3F8 8002DBF8 1000B08F */  lw         $s0, 0x10($sp)
    /* 1E3FC 8002DBFC 0800E003 */  jr         $ra
    /* 1E400 8002DC00 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_PostGameMenu__FR12tMenuCommand
