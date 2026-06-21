.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_TierFinished__FR12tMenuCommand, 0x80

glabel MenuExtended_TierFinished__FR12tMenuCommand
    /* 1E168 8002D968 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 1E16C 8002D96C 5800B0AF */  sw         $s0, 0x58($sp)
    /* 1E170 8002D970 21808000 */  addu       $s0, $a0, $zero
    /* 1E174 8002D974 02000224 */  addiu      $v0, $zero, 0x2
    /* 1E178 8002D978 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 1E17C 8002D97C D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 1E180 8002D980 1000A527 */  addiu      $a1, $sp, 0x10
    /* 1E184 8002D984 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 1E188 8002D988 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 1E18C 8002D98C 000002AE */   sw        $v0, 0x0($s0)
    /* 1E190 8002D990 4000A28F */  lw         $v0, 0x40($sp)
    /* 1E194 8002D994 00000000 */  nop
    /* 1E198 8002D998 04004010 */  beqz       $v0, .L8002D9AC
    /* 1E19C 8002D99C 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E1A0 8002D9A0 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E1A4 8002D9A4 75B60008 */  j          .L8002D9D4
    /* 1E1A8 8002D9A8 74394224 */   addiu     $v0, $v0, 0x3974
  .L8002D9AC:
    /* 1E1AC 8002D9AC 07B1000C */  jal        AskTheUserToSaveTheGame__Fv
    /* 1E1B0 8002D9B0 00000000 */   nop
    /* 1E1B4 8002D9B4 04004010 */  beqz       $v0, .L8002D9C8
    /* 1E1B8 8002D9B8 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E1BC 8002D9BC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E1C0 8002D9C0 75B60008 */  j          .L8002D9D4
    /* 1E1C4 8002D9C4 983A4224 */   addiu     $v0, $v0, 0x3A98
  .L8002D9C8:
    /* 1E1C8 8002D9C8 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E1CC 8002D9CC 00000000 */  nop
    /* 1E1D0 8002D9D0 B0004224 */  addiu      $v0, $v0, 0xB0
  .L8002D9D4:
    /* 1E1D4 8002D9D4 040002AE */  sw         $v0, 0x4($s0)
    /* 1E1D8 8002D9D8 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 1E1DC 8002D9DC 5800B08F */  lw         $s0, 0x58($sp)
    /* 1E1E0 8002D9E0 0800E003 */  jr         $ra
    /* 1E1E4 8002D9E4 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel MenuExtended_TierFinished__FR12tMenuCommand
