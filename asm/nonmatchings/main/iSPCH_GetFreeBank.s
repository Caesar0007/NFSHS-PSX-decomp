.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetFreeBank, 0x58

glabel iSPCH_GetFreeBank
    /* DBAB8 800EB2B8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* DBABC 800EB2BC 1380023C */  lui        $v0, %hi(gNumBanks)
    /* DBAC0 800EB2C0 B870428C */  lw         $v0, %lo(gNumBanks)($v0)
    /* DBAC4 800EB2C4 00000000 */  nop
    /* DBAC8 800EB2C8 0F004018 */  blez       $v0, .L800EB308
    /* DBACC 800EB2CC 21180000 */   addu      $v1, $zero, $zero
    /* DBAD0 800EB2D0 21304000 */  addu       $a2, $v0, $zero
    /* DBAD4 800EB2D4 1380023C */  lui        $v0, %hi(gVoxBanks)
    /* DBAD8 800EB2D8 B470448C */  lw         $a0, %lo(gVoxBanks)($v0)
  .L800EB2DC:
    /* DBADC 800EB2DC 00000000 */  nop
    /* DBAE0 800EB2E0 0000828C */  lw         $v0, 0x0($a0)
    /* DBAE4 800EB2E4 00000000 */  nop
    /* DBAE8 800EB2E8 03004014 */  bnez       $v0, .L800EB2F8
    /* DBAEC 800EB2EC 00000000 */   nop
    /* DBAF0 800EB2F0 C2AC0308 */  j          .L800EB308
    /* DBAF4 800EB2F4 21286000 */   addu      $a1, $v1, $zero
  .L800EB2F8:
    /* DBAF8 800EB2F8 01006324 */  addiu      $v1, $v1, 0x1
    /* DBAFC 800EB2FC 2A106600 */  slt        $v0, $v1, $a2
    /* DBB00 800EB300 F6FF4014 */  bnez       $v0, .L800EB2DC
    /* DBB04 800EB304 04008424 */   addiu     $a0, $a0, 0x4
  .L800EB308:
    /* DBB08 800EB308 0800E003 */  jr         $ra
    /* DBB0C 800EB30C 2110A000 */   addu      $v0, $a1, $zero
endlabel iSPCH_GetFreeBank
