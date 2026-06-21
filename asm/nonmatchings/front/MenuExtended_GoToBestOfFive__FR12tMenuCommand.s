.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToBestOfFive__FR12tMenuCommand, 0x5C

glabel MenuExtended_GoToBestOfFive__FR12tMenuCommand
    /* 1D43C 8002CC3C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1D440 8002CC40 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1D444 8002CC44 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1D448 8002CC48 AFB2000C */  jal        PinkSlipsPreSave__Fv
    /* 1D44C 8002CC4C 21808000 */   addu      $s0, $a0, $zero
    /* 1D450 8002CC50 07004010 */  beqz       $v0, .L8002CC70
    /* 1D454 8002CC54 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1D458 8002CC58 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1D45C 8002CC5C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D460 8002CC60 000003AE */  sw         $v1, 0x0($s0)
    /* 1D464 8002CC64 0C0C4224 */  addiu      $v0, $v0, 0xC0C
    /* 1D468 8002CC68 1DB30008 */  j          .L8002CC74
    /* 1D46C 8002CC6C 040002AE */   sw        $v0, 0x4($s0)
  .L8002CC70:
    /* 1D470 8002CC70 000000AE */  sw         $zero, 0x0($s0)
  .L8002CC74:
    /* 1D474 8002CC74 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1D478 8002CC78 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1D47C 8002CC7C 05000324 */  addiu      $v1, $zero, 0x5
    /* 1D480 8002CC80 460040A0 */  sb         $zero, 0x46($v0)
    /* 1D484 8002CC84 470043A0 */  sb         $v1, 0x47($v0)
    /* 1D488 8002CC88 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1D48C 8002CC8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 1D490 8002CC90 0800E003 */  jr         $ra
    /* 1D494 8002CC94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_GoToBestOfFive__FR12tMenuCommand
