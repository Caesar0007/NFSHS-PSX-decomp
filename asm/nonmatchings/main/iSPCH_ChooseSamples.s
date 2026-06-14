.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ChooseSamples, 0x110

glabel iSPCH_ChooseSamples
    /* F134C 80100B4C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* F1350 80100B50 3800B6AF */  sw         $s6, 0x38($sp)
    /* F1354 80100B54 21B08000 */  addu       $s6, $a0, $zero
    /* F1358 80100B58 4000BEAF */  sw         $fp, 0x40($sp)
    /* F135C 80100B5C 21F0A000 */  addu       $fp, $a1, $zero
    /* F1360 80100B60 2000B0AF */  sw         $s0, 0x20($sp)
    /* F1364 80100B64 21800000 */  addu       $s0, $zero, $zero
    /* F1368 80100B68 1380023C */  lui        $v0, %hi(gVoxBanks)
    /* F136C 80100B6C 4400BFAF */  sw         $ra, 0x44($sp)
    /* F1370 80100B70 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* F1374 80100B74 3400B5AF */  sw         $s5, 0x34($sp)
    /* F1378 80100B78 3000B4AF */  sw         $s4, 0x30($sp)
    /* F137C 80100B7C 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F1380 80100B80 2800B2AF */  sw         $s2, 0x28($sp)
    /* F1384 80100B84 2400B1AF */  sw         $s1, 0x24($sp)
    /* F1388 80100B88 5000A6AF */  sw         $a2, 0x50($sp)
    /* F138C 80100B8C 5400A7AF */  sw         $a3, 0x54($sp)
    /* F1390 80100B90 0000D586 */  lh         $s5, 0x0($s6)
    /* F1394 80100B94 B470438C */  lw         $v1, %lo(gVoxBanks)($v0)
    /* F1398 80100B98 80101500 */  sll        $v0, $s5, 2
    /* F139C 80100B9C 21104300 */  addu       $v0, $v0, $v1
    /* F13A0 80100BA0 0000538C */  lw         $s3, 0x0($v0)
    /* F13A4 80100BA4 00000000 */  nop
    /* F13A8 80100BA8 03007492 */  lbu        $s4, 0x3($s3)
    /* F13AC 80100BAC 0600D286 */  lh         $s2, 0x6($s6)
    /* F13B0 80100BB0 1D008012 */  beqz       $s4, .L80100C28
    /* F13B4 80100BB4 21880002 */   addu      $s1, $s0, $zero
    /* F13B8 80100BB8 1580023C */  lui        $v0, %hi(ispch_gPickSamples)
    /* F13BC 80100BBC 7C845724 */  addiu      $s7, $v0, %lo(ispch_gPickSamples)
    /* F13C0 80100BC0 21206002 */  addu       $a0, $s3, $zero
  .L80100BC4:
    /* F13C4 80100BC4 21280002 */  addu       $a1, $s0, $zero
    /* F13C8 80100BC8 752D040C */  jal        iSPCH_UnPackSample
    /* F13CC 80100BCC 1000A627 */   addiu     $a2, $sp, 0x10
    /* F13D0 80100BD0 11004010 */  beqz       $v0, .L80100C18
    /* F13D4 80100BD4 2120A002 */   addu      $a0, $s5, $zero
    /* F13D8 80100BD8 5000A68F */  lw         $a2, 0x50($sp)
    /* F13DC 80100BDC 5400A78F */  lw         $a3, 0x54($sp)
    /* F13E0 80100BE0 DF01040C */  jal        iSPCH_MatchSample
    /* F13E4 80100BE4 1000A527 */   addiu     $a1, $sp, 0x10
    /* F13E8 80100BE8 0B004010 */  beqz       $v0, .L80100C18
    /* F13EC 80100BEC 2120C002 */   addu      $a0, $s6, $zero
    /* F13F0 80100BF0 21286002 */  addu       $a1, $s3, $zero
    /* F13F4 80100BF4 B002040C */  jal        iSPCH_SampleExists
    /* F13F8 80100BF8 21300002 */   addu      $a2, $s0, $zero
    /* F13FC 80100BFC 06004010 */  beqz       $v0, .L80100C18
    /* F1400 80100C00 21105702 */   addu      $v0, $s2, $s7
    /* F1404 80100C04 000050A0 */  sb         $s0, 0x0($v0)
    /* F1408 80100C08 01003126 */  addiu      $s1, $s1, 0x1
    /* F140C 80100C0C 2A103E02 */  slt        $v0, $s1, $fp
    /* F1410 80100C10 05004010 */  beqz       $v0, .L80100C28
    /* F1414 80100C14 01005226 */   addiu     $s2, $s2, 0x1
  .L80100C18:
    /* F1418 80100C18 01001026 */  addiu      $s0, $s0, 0x1
    /* F141C 80100C1C 2A101402 */  slt        $v0, $s0, $s4
    /* F1420 80100C20 E8FF4014 */  bnez       $v0, .L80100BC4
    /* F1424 80100C24 21206002 */   addu      $a0, $s3, $zero
  .L80100C28:
    /* F1428 80100C28 21102002 */  addu       $v0, $s1, $zero
    /* F142C 80100C2C 4400BF8F */  lw         $ra, 0x44($sp)
    /* F1430 80100C30 4000BE8F */  lw         $fp, 0x40($sp)
    /* F1434 80100C34 3C00B78F */  lw         $s7, 0x3C($sp)
    /* F1438 80100C38 3800B68F */  lw         $s6, 0x38($sp)
    /* F143C 80100C3C 3400B58F */  lw         $s5, 0x34($sp)
    /* F1440 80100C40 3000B48F */  lw         $s4, 0x30($sp)
    /* F1444 80100C44 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F1448 80100C48 2800B28F */  lw         $s2, 0x28($sp)
    /* F144C 80100C4C 2400B18F */  lw         $s1, 0x24($sp)
    /* F1450 80100C50 2000B08F */  lw         $s0, 0x20($sp)
    /* F1454 80100C54 0800E003 */  jr         $ra
    /* F1458 80100C58 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSPCH_ChooseSamples
