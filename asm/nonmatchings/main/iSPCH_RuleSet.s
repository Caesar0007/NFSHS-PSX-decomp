.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_RuleSet, 0x138

glabel iSPCH_RuleSet
    /* FBA94 8010B294 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* FBA98 8010B298 2400B1AF */  sw         $s1, 0x24($sp)
    /* FBA9C 8010B29C 1380113C */  lui        $s1, %hi(gSentenceRuleSet)
    /* FBAA0 8010B2A0 9C70228E */  lw         $v0, %lo(gSentenceRuleSet)($s1)
    /* FBAA4 8010B2A4 3400B5AF */  sw         $s5, 0x34($sp)
    /* FBAA8 8010B2A8 21A88000 */  addu       $s5, $a0, $zero
    /* FBAAC 8010B2AC 2000B0AF */  sw         $s0, 0x20($sp)
    /* FBAB0 8010B2B0 2180A000 */  addu       $s0, $a1, $zero
    /* FBAB4 8010B2B4 4400BFAF */  sw         $ra, 0x44($sp)
    /* FBAB8 8010B2B8 4000BEAF */  sw         $fp, 0x40($sp)
    /* FBABC 8010B2BC 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* FBAC0 8010B2C0 3800B6AF */  sw         $s6, 0x38($sp)
    /* FBAC4 8010B2C4 3000B4AF */  sw         $s4, 0x30($sp)
    /* FBAC8 8010B2C8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* FBACC 8010B2CC 2800B2AF */  sw         $s2, 0x28($sp)
    /* FBAD0 8010B2D0 32004010 */  beqz       $v0, .L8010B39C
    /* FBAD4 8010B2D4 5000A6AF */   sw        $a2, 0x50($sp)
    /* FBAD8 8010B2D8 0700B482 */  lb         $s4, 0x7($s5)
    /* FBADC 8010B2DC 502C040C */  jal        func_8010B140
    /* FBAE0 8010B2E0 21900000 */   addu      $s2, $zero, $zero
    /* FBAE4 8010B2E4 2120A002 */  addu       $a0, $s5, $zero
    /* FBAE8 8010B2E8 0C00A526 */  addiu      $a1, $s5, 0xC
    /* FBAEC 8010B2EC 21300002 */  addu       $a2, $s0, $zero
    /* FBAF0 8010B2F0 492C040C */  jal        func_8010B124
    /* FBAF4 8010B2F4 21804000 */   addu      $s0, $v0, $zero
    /* FBAF8 8010B2F8 2800801A */  blez       $s4, .L8010B39C
    /* FBAFC 8010B2FC 21B04000 */   addu      $s6, $v0, $zero
    /* FBB00 8010B300 0580023C */  lui        $v0, %hi(jtbl_80057968)
    /* FBB04 8010B304 68795E24 */  addiu      $fp, $v0, %lo(jtbl_80057968)
    /* FBB08 8010B308 21B82002 */  addu       $s7, $s1, $zero
  .L8010B30C:
    /* FBB0C 8010B30C 00000492 */  lbu        $a0, 0x0($s0)
    /* FBB10 8010B310 00000000 */  nop
    /* FBB14 8010B314 1000A4AF */  sw         $a0, 0x10($sp)
    /* FBB18 8010B318 01000392 */  lbu        $v1, 0x1($s0)
    /* FBB1C 8010B31C 21988000 */  addu       $s3, $a0, $zero
    /* FBB20 8010B320 0F006330 */  andi       $v1, $v1, 0xF
    /* FBB24 8010B324 1400A3AF */  sw         $v1, 0x14($sp)
    /* FBB28 8010B328 01000292 */  lbu        $v0, 0x1($s0)
    /* FBB2C 8010B32C 21886000 */  addu       $s1, $v1, $zero
    /* FBB30 8010B330 02290200 */  srl        $a1, $v0, 4
    /* FBB34 8010B334 0500A22C */  sltiu      $v0, $a1, 0x5
    /* FBB38 8010B338 14004010 */  beqz       $v0, .L8010B38C
    /* FBB3C 8010B33C 1800A5AF */   sw        $a1, 0x18($sp)
    /* FBB40 8010B340 80100500 */  sll        $v0, $a1, 2
    /* FBB44 8010B344 21105E00 */  addu       $v0, $v0, $fp
    /* FBB48 8010B348 0000428C */  lw         $v0, 0x0($v0)
    /* FBB4C 8010B34C 00000000 */  nop
    /* FBB50 8010B350 08004000 */  jr         $v0
    /* FBB54 8010B354 00000000 */   nop
  jlabel .L8010B358
    /* FBB58 8010B358 2120C002 */  addu       $a0, $s6, $zero
    /* FBB5C 8010B35C 562C040C */  jal        iSPCH_SentenceUsesParm
    /* FBB60 8010B360 21282002 */   addu      $a1, $s1, $zero
    /* FBB64 8010B364 09004010 */  beqz       $v0, .L8010B38C
    /* FBB68 8010B368 80101100 */   sll       $v0, $s1, 2
    /* FBB6C 8010B36C 5000A78F */  lw         $a3, 0x50($sp)
    /* FBB70 8010B370 0000A496 */  lhu        $a0, 0x0($s5)
    /* FBB74 8010B374 21104700 */  addu       $v0, $v0, $a3
    /* FBB78 8010B378 0000468C */  lw         $a2, 0x0($v0)
    /* FBB7C 8010B37C 9C70E28E */  lw         $v0, %lo(gSentenceRuleSet)($s7)
    /* FBB80 8010B380 00000000 */  nop
    /* FBB84 8010B384 09F84000 */  jalr       $v0
    /* FBB88 8010B388 21286002 */   addu      $a1, $s3, $zero
  jlabel .L8010B38C
    /* FBB8C 8010B38C 01005226 */  addiu      $s2, $s2, 0x1
    /* FBB90 8010B390 2A105402 */  slt        $v0, $s2, $s4
    /* FBB94 8010B394 DDFF4014 */  bnez       $v0, .L8010B30C
    /* FBB98 8010B398 02001026 */   addiu     $s0, $s0, 0x2
  .L8010B39C:
    /* FBB9C 8010B39C 4400BF8F */  lw         $ra, 0x44($sp)
    /* FBBA0 8010B3A0 4000BE8F */  lw         $fp, 0x40($sp)
    /* FBBA4 8010B3A4 3C00B78F */  lw         $s7, 0x3C($sp)
    /* FBBA8 8010B3A8 3800B68F */  lw         $s6, 0x38($sp)
    /* FBBAC 8010B3AC 3400B58F */  lw         $s5, 0x34($sp)
    /* FBBB0 8010B3B0 3000B48F */  lw         $s4, 0x30($sp)
    /* FBBB4 8010B3B4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* FBBB8 8010B3B8 2800B28F */  lw         $s2, 0x28($sp)
    /* FBBBC 8010B3BC 2400B18F */  lw         $s1, 0x24($sp)
    /* FBBC0 8010B3C0 2000B08F */  lw         $s0, 0x20($sp)
    /* FBBC4 8010B3C4 0800E003 */  jr         $ra
    /* FBBC8 8010B3C8 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSPCH_RuleSet
