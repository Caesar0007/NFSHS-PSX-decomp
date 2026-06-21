.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetAwardInformation__18tTournamentManagerR17tAwardInformation, 0x40

glabel GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 240D4 800338D4 40028224 */  addiu      $v0, $a0, 0x240
    /* 240D8 800338D8 80028424 */  addiu      $a0, $a0, 0x280
  .L800338DC:
    /* 240DC 800338DC 0000438C */  lw         $v1, 0x0($v0)
    /* 240E0 800338E0 0400468C */  lw         $a2, 0x4($v0)
    /* 240E4 800338E4 0800478C */  lw         $a3, 0x8($v0)
    /* 240E8 800338E8 0C00488C */  lw         $t0, 0xC($v0)
    /* 240EC 800338EC 0000A3AC */  sw         $v1, 0x0($a1)
    /* 240F0 800338F0 0400A6AC */  sw         $a2, 0x4($a1)
    /* 240F4 800338F4 0800A7AC */  sw         $a3, 0x8($a1)
    /* 240F8 800338F8 0C00A8AC */  sw         $t0, 0xC($a1)
    /* 240FC 800338FC 10004224 */  addiu      $v0, $v0, 0x10
    /* 24100 80033900 F6FF4414 */  bne        $v0, $a0, .L800338DC
    /* 24104 80033904 1000A524 */   addiu     $a1, $a1, 0x10
    /* 24108 80033908 0000438C */  lw         $v1, 0x0($v0)
    /* 2410C 8003390C 0800E003 */  jr         $ra
    /* 24110 80033910 0000A3AC */   sw        $v1, 0x0($a1)
endlabel GetAwardInformation__18tTournamentManagerR17tAwardInformation
