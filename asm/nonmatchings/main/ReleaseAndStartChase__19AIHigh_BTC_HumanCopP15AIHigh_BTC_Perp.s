.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp, 0x70

glabel ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
    /* 4DB20 8005D320 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4DB24 8005D324 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4DB28 8005D328 21888000 */  addu       $s1, $a0, $zero
    /* 4DB2C 8005D32C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4DB30 8005D330 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4DB34 8005D334 0000238E */  lw         $v1, 0x0($s1)
    /* 4DB38 8005D338 2180A000 */  addu       $s0, $a1, $zero
    /* 4DB3C 8005D33C 7005628C */  lw         $v0, 0x570($v1)
    /* 4DB40 8005D340 00000000 */  nop
    /* 4DB44 8005D344 02004234 */  ori        $v0, $v0, 0x2
    /* 4DB48 8005D348 2E73010C */  jal        CheckForNewTarget__14AIHigh_BTC_Cop
    /* 4DB4C 8005D34C 700562AC */   sw        $v0, 0x570($v1)
    /* 4DB50 8005D350 5800228E */  lw         $v0, 0x58($s1)
    /* 4DB54 8005D354 00000000 */  nop
    /* 4DB58 8005D358 06005014 */  bne        $v0, $s0, .L8005D374
    /* 4DB5C 8005D35C 02000224 */   addiu     $v0, $zero, 0x2
    /* 4DB60 8005D360 600022AE */  sw         $v0, 0x60($s1)
    /* 4DB64 8005D364 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 4DB68 8005D368 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4DB6C 8005D36C 00000000 */  nop
    /* 4DB70 8005D370 740022AE */  sw         $v0, 0x74($s1)
  .L8005D374:
    /* 4DB74 8005D374 FE77010C */  jal        ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
    /* 4DB78 8005D378 21202002 */   addu      $a0, $s1, $zero
    /* 4DB7C 8005D37C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4DB80 8005D380 1400B18F */  lw         $s1, 0x14($sp)
    /* 4DB84 8005D384 1000B08F */  lw         $s0, 0x10($sp)
    /* 4DB88 8005D388 0800E003 */  jr         $ra
    /* 4DB8C 8005D38C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
