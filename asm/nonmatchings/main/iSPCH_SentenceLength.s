.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SentenceLength, 0x74

glabel iSPCH_SentenceLength
    /* F1520 80100D20 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F1524 80100D24 1800B2AF */  sw         $s2, 0x18($sp)
    /* F1528 80100D28 21900000 */  addu       $s2, $zero, $zero
    /* F152C 80100D2C 2000BFAF */  sw         $ra, 0x20($sp)
    /* F1530 80100D30 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F1534 80100D34 1400B1AF */  sw         $s1, 0x14($sp)
    /* F1538 80100D38 CC01040C */  jal        func_80100730
    /* F153C 80100D3C 1000B0AF */   sw        $s0, 0x10($sp)
    /* F1540 80100D40 21984000 */  addu       $s3, $v0, $zero
    /* F1544 80100D44 0A00601A */  blez       $s3, .L80100D70
    /* F1548 80100D48 21884002 */   addu      $s1, $s2, $zero
    /* F154C 80100D4C 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F1550 80100D50 E4845024 */  addiu      $s0, $v0, %lo(ispch_gChoice)
  .L80100D54:
    /* F1554 80100D54 1703040C */  jal        iSPCH_SampleLength
    /* F1558 80100D58 21200002 */   addu      $a0, $s0, $zero
    /* F155C 80100D5C 21904202 */  addu       $s2, $s2, $v0
    /* F1560 80100D60 01003126 */  addiu      $s1, $s1, 0x1
    /* F1564 80100D64 2A103302 */  slt        $v0, $s1, $s3
    /* F1568 80100D68 FAFF4014 */  bnez       $v0, .L80100D54
    /* F156C 80100D6C 0C001026 */   addiu     $s0, $s0, 0xC
  .L80100D70:
    /* F1570 80100D70 3103040C */  jal        iSPCH_ConvertTime
    /* F1574 80100D74 21204002 */   addu      $a0, $s2, $zero
    /* F1578 80100D78 2000BF8F */  lw         $ra, 0x20($sp)
    /* F157C 80100D7C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F1580 80100D80 1800B28F */  lw         $s2, 0x18($sp)
    /* F1584 80100D84 1400B18F */  lw         $s1, 0x14($sp)
    /* F1588 80100D88 1000B08F */  lw         $s0, 0x10($sp)
    /* F158C 80100D8C 0800E003 */  jr         $ra
    /* F1590 80100D90 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSPCH_SentenceLength
