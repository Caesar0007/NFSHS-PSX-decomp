.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_FindBank, 0x6C

glabel iSPCH_FindBank
    /* DBB10 800EB310 1380023C */  lui        $v0, %hi(gVoxBanks)
    /* DBB14 800EB314 B470458C */  lw         $a1, %lo(gVoxBanks)($v0)
    /* DBB18 800EB318 00000000 */  nop
    /* DBB1C 800EB31C 1300A010 */  beqz       $a1, .L800EB36C
    /* DBB20 800EB320 1380023C */   lui       $v0, %hi(gNumBanks)
    /* DBB24 800EB324 B870428C */  lw         $v0, %lo(gNumBanks)($v0)
    /* DBB28 800EB328 00000000 */  nop
    /* DBB2C 800EB32C 0F004018 */  blez       $v0, .L800EB36C
    /* DBB30 800EB330 21180000 */   addu      $v1, $zero, $zero
    /* DBB34 800EB334 FFFF8430 */  andi       $a0, $a0, 0xFFFF
    /* DBB38 800EB338 21304000 */  addu       $a2, $v0, $zero
  .L800EB33C:
    /* DBB3C 800EB33C 0000A28C */  lw         $v0, 0x0($a1)
    /* DBB40 800EB340 00000000 */  nop
    /* DBB44 800EB344 05004010 */  beqz       $v0, .L800EB35C
    /* DBB48 800EB348 00000000 */   nop
    /* DBB4C 800EB34C 00004294 */  lhu        $v0, 0x0($v0)
    /* DBB50 800EB350 00000000 */  nop
    /* DBB54 800EB354 07004410 */  beq        $v0, $a0, .L800EB374
    /* DBB58 800EB358 21106000 */   addu      $v0, $v1, $zero
  .L800EB35C:
    /* DBB5C 800EB35C 01006324 */  addiu      $v1, $v1, 0x1
    /* DBB60 800EB360 2A106600 */  slt        $v0, $v1, $a2
    /* DBB64 800EB364 F5FF4014 */  bnez       $v0, .L800EB33C
    /* DBB68 800EB368 0400A524 */   addiu     $a1, $a1, 0x4
  .L800EB36C:
    /* DBB6C 800EB36C 0800E003 */  jr         $ra
    /* DBB70 800EB370 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800EB374:
    /* DBB74 800EB374 0800E003 */  jr         $ra
    /* DBB78 800EB378 00000000 */   nop
endlabel iSPCH_FindBank
