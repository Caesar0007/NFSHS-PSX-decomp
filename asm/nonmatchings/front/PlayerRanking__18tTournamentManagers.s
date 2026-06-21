.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PlayerRanking__18tTournamentManagers, 0x90

glabel PlayerRanking__18tTournamentManagers
    /* 242A8 80033AA8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 242AC 80033AAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 242B0 80033AB0 21888000 */  addu       $s1, $a0, $zero
    /* 242B4 80033AB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 242B8 80033AB8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 242BC 80033ABC 63CD000C */  jal        GetNumCompetitors__18tTournamentManager
    /* 242C0 80033AC0 2180A000 */   addu      $s0, $a1, $zero
    /* 242C4 80033AC4 00140200 */  sll        $v0, $v0, 16
    /* 242C8 80033AC8 031C0200 */  sra        $v1, $v0, 16
    /* 242CC 80033ACC 14006018 */  blez       $v1, .L80033B20
    /* 242D0 80033AD0 21200000 */   addu      $a0, $zero, $zero
    /* 242D4 80033AD4 00141000 */  sll        $v0, $s0, 16
    /* 242D8 80033AD8 03340200 */  sra        $a2, $v0, 16
    /* 242DC 80033ADC 21286000 */  addu       $a1, $v1, $zero
    /* 242E0 80033AE0 00140400 */  sll        $v0, $a0, 16
  .L80033AE4:
    /* 242E4 80033AE4 031C0200 */  sra        $v1, $v0, 16
    /* 242E8 80033AE8 00110300 */  sll        $v0, $v1, 4
    /* 242EC 80033AEC 21102202 */  addu       $v0, $s1, $v0
    /* 242F0 80033AF0 26014290 */  lbu        $v0, 0x126($v0)
    /* 242F4 80033AF4 00000000 */  nop
    /* 242F8 80033AF8 03004614 */  bne        $v0, $a2, .L80033B08
    /* 242FC 80033AFC 01008224 */   addiu     $v0, $a0, 0x1
    /* 24300 80033B00 C9CE0008 */  j          .L80033B24
    /* 24304 80033B04 21106000 */   addu      $v0, $v1, $zero
  .L80033B08:
    /* 24308 80033B08 21204000 */  addu       $a0, $v0, $zero
    /* 2430C 80033B0C 00140200 */  sll        $v0, $v0, 16
    /* 24310 80033B10 03140200 */  sra        $v0, $v0, 16
    /* 24314 80033B14 2A104500 */  slt        $v0, $v0, $a1
    /* 24318 80033B18 F2FF4014 */  bnez       $v0, .L80033AE4
    /* 2431C 80033B1C 00140400 */   sll       $v0, $a0, 16
  .L80033B20:
    /* 24320 80033B20 21100000 */  addu       $v0, $zero, $zero
  .L80033B24:
    /* 24324 80033B24 1800BF8F */  lw         $ra, 0x18($sp)
    /* 24328 80033B28 1400B18F */  lw         $s1, 0x14($sp)
    /* 2432C 80033B2C 1000B08F */  lw         $s0, 0x10($sp)
    /* 24330 80033B30 0800E003 */  jr         $ra
    /* 24334 80033B34 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PlayerRanking__18tTournamentManagers
