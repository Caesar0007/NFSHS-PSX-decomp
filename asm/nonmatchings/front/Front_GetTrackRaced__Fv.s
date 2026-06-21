.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_GetTrackRaced__Fv, 0x70

glabel Front_GetTrackRaced__Fv
    /* 1C160 8002B960 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 1C164 8002B964 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1C168 8002B968 00464524 */  addiu      $a1, $v0, %lo(frontEnd)
    /* 1C16C 8002B96C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 1C170 8002B970 0400A390 */  lbu        $v1, 0x4($a1)
    /* 1C174 8002B974 02000224 */  addiu      $v0, $zero, 0x2
    /* 1C178 8002B978 06006214 */  bne        $v1, $v0, .L8002B994
    /* 1C17C 8002B97C 1180043C */   lui       $a0, %hi(trackManager)
    /* 1C180 8002B980 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 1C184 8002B984 23CD000C */  jal        GetLastTrackRaced__18tTournamentManager
    /* 1C188 8002B988 D84A8424 */   addiu     $a0, $a0, %lo(tournamentManager)
    /* 1C18C 8002B98C 70AE0008 */  j          .L8002B9C0
    /* 1C190 8002B990 00140200 */   sll       $v0, $v0, 16
  .L8002B994:
    /* 1C194 8002B994 4600A290 */  lbu        $v0, 0x46($a1)
    /* 1C198 8002B998 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 1C19C 8002B99C 21104500 */  addu       $v0, $v0, $a1
    /* 1C1A0 8002B9A0 23004590 */  lbu        $a1, 0x23($v0)
    /* 1C1A4 8002B9A4 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 1C1A8 8002B9A8 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1C1AC 8002B9AC 1000A293 */  lbu        $v0, 0x10($sp)
    /* 1C1B0 8002B9B0 00000000 */  nop
    /* 1C1B4 8002B9B4 00160200 */  sll        $v0, $v0, 24
    /* 1C1B8 8002B9B8 03160200 */  sra        $v0, $v0, 24
    /* 1C1BC 8002B9BC 00140200 */  sll        $v0, $v0, 16
  .L8002B9C0:
    /* 1C1C0 8002B9C0 4000BF8F */  lw         $ra, 0x40($sp)
    /* 1C1C4 8002B9C4 03140200 */  sra        $v0, $v0, 16
    /* 1C1C8 8002B9C8 0800E003 */  jr         $ra
    /* 1C1CC 8002B9CC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Front_GetTrackRaced__Fv
