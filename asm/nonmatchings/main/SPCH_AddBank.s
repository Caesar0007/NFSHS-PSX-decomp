.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_AddBank, 0x84

glabel SPCH_AddBank
    /* DBD20 800EB520 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DBD24 800EB524 1800B2AF */  sw         $s2, 0x18($sp)
    /* DBD28 800EB528 1380123C */  lui        $s2, %hi(gVoxBanks)
    /* DBD2C 800EB52C B470428E */  lw         $v0, %lo(gVoxBanks)($s2)
    /* DBD30 800EB530 1400B1AF */  sw         $s1, 0x14($sp)
    /* DBD34 800EB534 21888000 */  addu       $s1, $a0, $zero
    /* DBD38 800EB538 1000B0AF */  sw         $s0, 0x10($sp)
    /* DBD3C 800EB53C FFFF1024 */  addiu      $s0, $zero, -0x1
    /* DBD40 800EB540 11004010 */  beqz       $v0, .L800EB588
    /* DBD44 800EB544 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* DBD48 800EB548 AEAC030C */  jal        iSPCH_GetFreeBank
    /* DBD4C 800EB54C 00000000 */   nop
    /* DBD50 800EB550 21804000 */  addu       $s0, $v0, $zero
    /* DBD54 800EB554 0D000006 */  bltz       $s0, .L800EB58C
    /* DBD58 800EB558 21100002 */   addu      $v0, $s0, $zero
    /* DBD5C 800EB55C 02002292 */  lbu        $v0, 0x2($s1)
    /* DBD60 800EB560 00000000 */  nop
    /* DBD64 800EB564 F0004230 */  andi       $v0, $v0, 0xF0
    /* DBD68 800EB568 03004010 */  beqz       $v0, .L800EB578
    /* DBD6C 800EB56C 00000000 */   nop
    /* DBD70 800EB570 F2AC030C */  jal        iSPCH_SetCycleBits
    /* DBD74 800EB574 21202002 */   addu      $a0, $s1, $zero
  .L800EB578:
    /* DBD78 800EB578 B470438E */  lw         $v1, %lo(gVoxBanks)($s2)
    /* DBD7C 800EB57C 80101000 */  sll        $v0, $s0, 2
    /* DBD80 800EB580 21104300 */  addu       $v0, $v0, $v1
    /* DBD84 800EB584 000051AC */  sw         $s1, 0x0($v0)
  .L800EB588:
    /* DBD88 800EB588 21100002 */  addu       $v0, $s0, $zero
  .L800EB58C:
    /* DBD8C 800EB58C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DBD90 800EB590 1800B28F */  lw         $s2, 0x18($sp)
    /* DBD94 800EB594 1400B18F */  lw         $s1, 0x14($sp)
    /* DBD98 800EB598 1000B08F */  lw         $s0, 0x10($sp)
    /* DBD9C 800EB59C 0800E003 */  jr         $ra
    /* DBDA0 800EB5A0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SPCH_AddBank
