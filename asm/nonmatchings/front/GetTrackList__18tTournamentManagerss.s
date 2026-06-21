.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTrackList__18tTournamentManagerss, 0x38

glabel GetTrackList__18tTournamentManagerss
    /* 22E54 80032654 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 22E58 80032658 1000B0AF */  sw         $s0, 0x10($sp)
    /* 22E5C 8003265C 21808000 */  addu       $s0, $a0, $zero
    /* 22E60 80032660 002C0500 */  sll        $a1, $a1, 16
    /* 22E64 80032664 00340600 */  sll        $a2, $a2, 16
    /* 22E68 80032668 032C0500 */  sra        $a1, $a1, 16
    /* 22E6C 8003266C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 22E70 80032670 61C9000C */  jal        UpdateTrackList__18tTournamentManagerss
    /* 22E74 80032674 03340600 */   sra       $a2, $a2, 16
    /* 22E78 80032678 B6000226 */  addiu      $v0, $s0, 0xB6
    /* 22E7C 8003267C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 22E80 80032680 1000B08F */  lw         $s0, 0x10($sp)
    /* 22E84 80032684 0800E003 */  jr         $ra
    /* 22E88 80032688 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetTrackList__18tTournamentManagerss
