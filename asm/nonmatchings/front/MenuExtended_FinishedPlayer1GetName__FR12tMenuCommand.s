.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand, 0x110

glabel MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand
    /* 1E404 8002DC04 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 1E408 8002DC08 2000B2AF */  sw         $s2, 0x20($sp)
    /* 1E40C 8002DC0C 21908000 */  addu       $s2, $a0, $zero
    /* 1E410 8002DC10 0580023C */  lui        $v0, %hi(FEApp)
    /* 1E414 8002DC14 C014438C */  lw         $v1, %lo(FEApp)($v0)
    /* 1E418 8002DC18 02000224 */  addiu      $v0, $zero, 0x2
    /* 1E41C 8002DC1C 2400BFAF */  sw         $ra, 0x24($sp)
    /* 1E420 8002DC20 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 1E424 8002DC24 1800B0AF */  sw         $s0, 0x18($sp)
    /* 1E428 8002DC28 000042AE */  sw         $v0, 0x0($s2)
    /* 1E42C 8002DC2C 7403628C */  lw         $v0, 0x374($v1)
    /* 1E430 8002DC30 00000000 */  nop
    /* 1E434 8002DC34 17004010 */  beqz       $v0, .L8002DC94
    /* 1E438 8002DC38 1180023C */   lui       $v0, %hi(Cars_gNewCarStatsList)
    /* 1E43C 8002DC3C 6C03628C */  lw         $v0, 0x36C($v1)
    /* 1E440 8002DC40 00000000 */  nop
    /* 1E444 8002DC44 13004014 */  bnez       $v0, .L8002DC94
    /* 1E448 8002DC48 1180023C */   lui       $v0, %hi(Cars_gNewCarStatsList)
    /* 1E44C 8002DC4C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1E450 8002DC50 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 1E454 8002DC54 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E458 8002DC58 44328324 */  addiu      $v1, $a0, 0x3244
    /* 1E45C 8002DC5C 800062A4 */  sh         $v0, 0x80($v1)
    /* 1E460 8002DC60 1180023C */  lui        $v0, %hi(D_8011496C)
    /* 1E464 8002DC64 6C494224 */  addiu      $v0, $v0, %lo(D_8011496C)
    /* 1E468 8002DC68 1C0062AC */  sw         $v0, 0x1C($v1)
    /* 1E46C 8002DC6C 07000224 */  addiu      $v0, $zero, 0x7
    /* 1E470 8002DC70 200062A4 */  sh         $v0, 0x20($v1)
    /* 1E474 8002DC74 0580023C */  lui        $v0, %hi(screenUserName)
    /* 1E478 8002DC78 B429428C */  lw         $v0, %lo(screenUserName)($v0)
    /* 1E47C 8002DC7C 50378424 */  addiu      $a0, $a0, 0x3750
    /* 1E480 8002DC80 240060A4 */  sh         $zero, 0x24($v1)
    /* 1E484 8002DC84 220060A4 */  sh         $zero, 0x22($v1)
    /* 1E488 8002DC88 640044AC */  sw         $a0, 0x64($v0)
    /* 1E48C 8002DC8C 3FB70008 */  j          .L8002DCFC
    /* 1E490 8002DC90 040044AE */   sw        $a0, 0x4($s2)
  .L8002DC94:
    /* 1E494 8002DC94 44FB5124 */  addiu      $s1, $v0, %lo(Cars_gNewCarStatsList)
    /* 1E498 8002DC98 21202002 */  addu       $a0, $s1, $zero
    /* 1E49C 8002DC9C 1480103C */  lui        $s0, %hi(Cars_gNumRaceCars)
    /* 1E4A0 8002DCA0 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E4A4 8002DCA4 1026010C */  jal        StatChk_IsRecordLapTime__FP10Car_tStatssPs
    /* 1E4A8 8002DCA8 1000A627 */   addiu     $a2, $sp, 0x10
    /* 1E4AC 8002DCAC 05004010 */  beqz       $v0, .L8002DCC4
    /* 1E4B0 8002DCB0 00000000 */   nop
    /* 1E4B4 8002DCB4 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E4B8 8002DCB8 1000A687 */  lh         $a2, 0x10($sp)
    /* 1E4BC 8002DCBC DF26010C */  jal        StatChk_SaveRecordLapTime__FP10Car_tStatsss
    /* 1E4C0 8002DCC0 21202002 */   addu      $a0, $s1, $zero
  .L8002DCC4:
    /* 1E4C4 8002DCC4 F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E4C8 8002DCC8 4327010C */  jal        StatChk_IsTopTime__FP10Car_tStatss
    /* 1E4CC 8002DCCC 21202002 */   addu      $a0, $s1, $zero
    /* 1E4D0 8002DCD0 00140200 */  sll        $v0, $v0, 16
    /* 1E4D4 8002DCD4 05004010 */  beqz       $v0, .L8002DCEC
    /* 1E4D8 8002DCD8 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1E4DC 8002DCDC F8C70586 */  lh         $a1, %lo(Cars_gNumRaceCars)($s0)
    /* 1E4E0 8002DCE0 6E28010C */  jal        StatChk_SaveTopTime__FP10Car_tStatss
    /* 1E4E4 8002DCE4 21202002 */   addu      $a0, $s1, $zero
    /* 1E4E8 8002DCE8 0580023C */  lui        $v0, %hi(menuDefs)
  .L8002DCEC:
    /* 1E4EC 8002DCEC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E4F0 8002DCF0 00000000 */  nop
    /* 1E4F4 8002DCF4 FC374224 */  addiu      $v0, $v0, 0x37FC
    /* 1E4F8 8002DCF8 040042AE */  sw         $v0, 0x4($s2)
  .L8002DCFC:
    /* 1E4FC 8002DCFC 2400BF8F */  lw         $ra, 0x24($sp)
    /* 1E500 8002DD00 2000B28F */  lw         $s2, 0x20($sp)
    /* 1E504 8002DD04 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 1E508 8002DD08 1800B08F */  lw         $s0, 0x18($sp)
    /* 1E50C 8002DD0C 0800E003 */  jr         $ra
    /* 1E510 8002DD10 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand
