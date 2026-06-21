.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand, 0xA0

glabel MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand
    /* 1E514 8002DD14 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 1E518 8002DD18 2000B2AF */  sw         $s2, 0x20($sp)
    /* 1E51C 8002DD1C 21908000 */  addu       $s2, $a0, $zero
    /* 1E520 8002DD20 1180023C */  lui        $v0, %hi(Cars_gNewCarStatsList)
    /* 1E524 8002DD24 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 1E528 8002DD28 44FB5124 */  addiu      $s1, $v0, %lo(Cars_gNewCarStatsList)
    /* 1E52C 8002DD2C 21202002 */  addu       $a0, $s1, $zero
    /* 1E530 8002DD30 1800B0AF */  sw         $s0, 0x18($sp)
    /* 1E534 8002DD34 1480103C */  lui        $s0, %hi(Cars_gNumRaceCars)
    /* 1E538 8002DD38 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E53C 8002DD3C 2400BFAF */  sw         $ra, 0x24($sp)
    /* 1E540 8002DD40 1026010C */  jal        StatChk_IsRecordLapTime__FP10Car_tStatssPs
    /* 1E544 8002DD44 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1E548 8002DD48 05004010 */  beqz       $v0, .L8002DD60
    /* 1E54C 8002DD4C 00000000 */   nop
    /* 1E550 8002DD50 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E554 8002DD54 1000A687 */  lh         $a2, 0x10($sp)
    /* 1E558 8002DD58 DF26010C */  jal        StatChk_SaveRecordLapTime__FP10Car_tStatsss
    /* 1E55C 8002DD5C 21202002 */   addu      $a0, $s1, $zero
  .L8002DD60:
    /* 1E560 8002DD60 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E564 8002DD64 4327010C */  jal        StatChk_IsTopTime__FP10Car_tStatss
    /* 1E568 8002DD68 21202002 */   addu      $a0, $s1, $zero
    /* 1E56C 8002DD6C 00140200 */  sll        $v0, $v0, 16
    /* 1E570 8002DD70 05004010 */  beqz       $v0, .L8002DD88
    /* 1E574 8002DD74 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E578 8002DD78 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E57C 8002DD7C 6E28010C */  jal        StatChk_SaveTopTime__FP10Car_tStatss
    /* 1E580 8002DD80 21202002 */   addu      $a0, $s1, $zero
    /* 1E584 8002DD84 0580023C */  lui        $v0, %hi(menuDefs)
  .L8002DD88:
    /* 1E588 8002DD88 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E58C 8002DD8C 02000324 */  addiu      $v1, $zero, 0x2
    /* 1E590 8002DD90 000043AE */  sw         $v1, 0x0($s2)
    /* 1E594 8002DD94 FC374224 */  addiu      $v0, $v0, 0x37FC
    /* 1E598 8002DD98 040042AE */  sw         $v0, 0x4($s2)
    /* 1E59C 8002DD9C 2400BF8F */  lw         $ra, 0x24($sp)
    /* 1E5A0 8002DDA0 2000B28F */  lw         $s2, 0x20($sp)
    /* 1E5A4 8002DDA4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 1E5A8 8002DDA8 1800B08F */  lw         $s0, 0x18($sp)
    /* 1E5AC 8002DDAC 0800E003 */  jr         $ra
    /* 1E5B0 8002DDB0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand
