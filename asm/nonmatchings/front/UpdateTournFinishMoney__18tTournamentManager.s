.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTournFinishMoney__18tTournamentManager, 0x130

glabel UpdateTournFinishMoney__18tTournamentManager
    /* 232DC 80032ADC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 232E0 80032AE0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 232E4 80032AE4 21908000 */  addu       $s2, $a0, $zero
    /* 232E8 80032AE8 2000BFAF */  sw         $ra, 0x20($sp)
    /* 232EC 80032AEC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 232F0 80032AF0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 232F4 80032AF4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 232F8 80032AF8 0400438E */  lw         $v1, 0x4($s2)
    /* 232FC 80032AFC 1800448E */  lw         $a0, 0x18($s2)
    /* 23300 80032B00 40100300 */  sll        $v0, $v1, 1
    /* 23304 80032B04 21104300 */  addu       $v0, $v0, $v1
    /* 23308 80032B08 80100200 */  sll        $v0, $v0, 2
    /* 2330C 80032B0C 21108200 */  addu       $v0, $a0, $v0
    /* 23310 80032B10 02004390 */  lbu        $v1, 0x2($v0)
    /* 23314 80032B14 0800428E */  lw         $v0, 0x8($s2)
    /* 23318 80032B18 00000000 */  nop
    /* 2331C 80032B1C 21186200 */  addu       $v1, $v1, $v0
    /* 23320 80032B20 80100300 */  sll        $v0, $v1, 2
    /* 23324 80032B24 21104300 */  addu       $v0, $v0, $v1
    /* 23328 80032B28 80100200 */  sll        $v0, $v0, 2
    /* 2332C 80032B2C 21104300 */  addu       $v0, $v0, $v1
    /* 23330 80032B30 80100200 */  sll        $v0, $v0, 2
    /* 23334 80032B34 24004224 */  addiu      $v0, $v0, 0x24
    /* 23338 80032B38 21988200 */  addu       $s3, $a0, $v0
    /* 2333C 80032B3C 00006282 */  lb         $v0, 0x0($s3)
    /* 23340 80032B40 00000000 */  nop
    /* 23344 80032B44 21104202 */  addu       $v0, $s2, $v0
    /* 23348 80032B48 F0014290 */  lbu        $v0, 0x1F0($v0)
    /* 2334C 80032B4C 00000000 */  nop
    /* 23350 80032B50 300242A2 */  sb         $v0, 0x230($s2)
    /* 23354 80032B54 05006292 */  lbu        $v0, 0x5($s3)
    /* 23358 80032B58 00000000 */  nop
    /* 2335C 80032B5C 09004010 */  beqz       $v0, .L80032B84
    /* 23360 80032B60 21204002 */   addu      $a0, $s2, $zero
    /* 23364 80032B64 26014592 */  lbu        $a1, 0x126($s2)
    /* 23368 80032B68 18CE000C */  jal        GetTournamentFinishPrize__18tTournamentManagers
    /* 2336C 80032B6C FFFFA524 */   addiu     $a1, $a1, -0x1
    /* 23370 80032B70 4402438E */  lw         $v1, 0x244($s2)
    /* 23374 80032B74 00000000 */  nop
    /* 23378 80032B78 21186200 */  addu       $v1, $v1, $v0
    /* 2337C 80032B7C FCCA0008 */  j          .L80032BF0
    /* 23380 80032B80 440243AE */   sw        $v1, 0x244($s2)
  .L80032B84:
    /* 23384 80032B84 21800000 */  addu       $s0, $zero, $zero
    /* 23388 80032B88 FF001132 */  andi       $s1, $s0, 0xFF
  .L80032B8C:
    /* 2338C 80032B8C 21105102 */  addu       $v0, $s2, $s1
    /* 23390 80032B90 37024290 */  lbu        $v0, 0x237($v0)
    /* 23394 80032B94 00000000 */  nop
    /* 23398 80032B98 10004014 */  bnez       $v0, .L80032BDC
    /* 2339C 80032B9C 21204002 */   addu      $a0, $s2, $zero
    /* 233A0 80032BA0 18CE000C */  jal        GetTournamentFinishPrize__18tTournamentManagers
    /* 233A4 80032BA4 FF000532 */   andi      $a1, $s0, 0xFF
    /* 233A8 80032BA8 4402438E */  lw         $v1, 0x244($s2)
    /* 233AC 80032BAC 00000000 */  nop
    /* 233B0 80032BB0 21186200 */  addu       $v1, $v1, $v0
    /* 233B4 80032BB4 440243AE */  sw         $v1, 0x244($s2)
    /* 233B8 80032BB8 00006282 */  lb         $v0, 0x0($s3)
    /* 233BC 80032BBC 00000000 */  nop
    /* 233C0 80032BC0 21184202 */  addu       $v1, $s2, $v0
    /* 233C4 80032BC4 F0016280 */  lb         $v0, 0x1F0($v1)
    /* 233C8 80032BC8 00000000 */  nop
    /* 233CC 80032BCC 2A102202 */  slt        $v0, $s1, $v0
    /* 233D0 80032BD0 02004010 */  beqz       $v0, .L80032BDC
    /* 233D4 80032BD4 01000226 */   addiu     $v0, $s0, 0x1
    /* 233D8 80032BD8 F00162A0 */  sb         $v0, 0x1F0($v1)
  .L80032BDC:
    /* 233DC 80032BDC 01001026 */  addiu      $s0, $s0, 0x1
    /* 233E0 80032BE0 FF000232 */  andi       $v0, $s0, 0xFF
    /* 233E4 80032BE4 0600422C */  sltiu      $v0, $v0, 0x6
    /* 233E8 80032BE8 E8FF4014 */  bnez       $v0, .L80032B8C
    /* 233EC 80032BEC FF001132 */   andi      $s1, $s0, 0xFF
  .L80032BF0:
    /* 233F0 80032BF0 2000BF8F */  lw         $ra, 0x20($sp)
    /* 233F4 80032BF4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 233F8 80032BF8 1800B28F */  lw         $s2, 0x18($sp)
    /* 233FC 80032BFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 23400 80032C00 1000B08F */  lw         $s0, 0x10($sp)
    /* 23404 80032C04 0800E003 */  jr         $ra
    /* 23408 80032C08 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel UpdateTournFinishMoney__18tTournamentManager
