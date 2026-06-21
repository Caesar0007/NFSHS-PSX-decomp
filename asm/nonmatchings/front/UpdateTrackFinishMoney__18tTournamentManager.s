.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTrackFinishMoney__18tTournamentManager, 0x60

glabel UpdateTrackFinishMoney__18tTournamentManager
    /* 2340C 80032C0C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 23410 80032C10 1000B0AF */  sw         $s0, 0x10($sp)
    /* 23414 80032C14 21808000 */  addu       $s0, $a0, $zero
    /* 23418 80032C18 1180023C */  lui        $v0, %hi(Cars_gNewCarStatsList)
    /* 2341C 80032C1C 44FB4424 */  addiu      $a0, $v0, %lo(Cars_gNewCarStatsList)
    /* 23420 80032C20 1400BFAF */  sw         $ra, 0x14($sp)
    /* 23424 80032C24 8000838C */  lw         $v1, 0x80($a0)
    /* 23428 80032C28 02000224 */  addiu      $v0, $zero, 0x2
    /* 2342C 80032C2C 0B006214 */  bne        $v1, $v0, .L80032C5C
    /* 23430 80032C30 00000000 */   nop
    /* 23434 80032C34 84008594 */  lhu        $a1, 0x84($a0)
    /* 23438 80032C38 21200002 */  addu       $a0, $s0, $zero
    /* 2343C 80032C3C FFFFA524 */  addiu      $a1, $a1, -0x1
    /* 23440 80032C40 002C0500 */  sll        $a1, $a1, 16
    /* 23444 80032C44 A2CD000C */  jal        GetTrackFinishPrize__18tTournamentManagers
    /* 23448 80032C48 032C0500 */   sra       $a1, $a1, 16
    /* 2344C 80032C4C 4002038E */  lw         $v1, 0x240($s0)
    /* 23450 80032C50 00000000 */  nop
    /* 23454 80032C54 21186200 */  addu       $v1, $v1, $v0
    /* 23458 80032C58 400203AE */  sw         $v1, 0x240($s0)
  .L80032C5C:
    /* 2345C 80032C5C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 23460 80032C60 1000B08F */  lw         $s0, 0x10($sp)
    /* 23464 80032C64 0800E003 */  jr         $ra
    /* 23468 80032C68 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateTrackFinishMoney__18tTournamentManager
