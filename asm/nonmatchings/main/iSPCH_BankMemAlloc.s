.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_BankMemAlloc, 0x84

glabel iSPCH_BankMemAlloc
    /* DBA34 800EB234 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DBA38 800EB238 1000B0AF */  sw         $s0, 0x10($sp)
    /* DBA3C 800EB23C 1380103C */  lui        $s0, %hi(gVoxBanks)
    /* DBA40 800EB240 B470028E */  lw         $v0, %lo(gVoxBanks)($s0)
    /* DBA44 800EB244 1800BFAF */  sw         $ra, 0x18($sp)
    /* DBA48 800EB248 14004014 */  bnez       $v0, .L800EB29C
    /* DBA4C 800EB24C 1400B1AF */   sw        $s1, 0x14($sp)
    /* DBA50 800EB250 1380113C */  lui        $s1, %hi(gNumBanks)
    /* DBA54 800EB254 0580053C */  lui        $a1, %hi(D_80056C38)
    /* DBA58 800EB258 B87024AE */  sw         $a0, %lo(gNumBanks)($s1)
    /* DBA5C 800EB25C 80200400 */  sll        $a0, $a0, 2
    /* DBA60 800EB260 69AD030C */  jal        iSPCH_MemAlloc
    /* DBA64 800EB264 386CA524 */   addiu     $a1, $a1, %lo(D_80056C38)
    /* DBA68 800EB268 0C004010 */  beqz       $v0, .L800EB29C
    /* DBA6C 800EB26C B47002AE */   sw        $v0, %lo(gVoxBanks)($s0)
    /* DBA70 800EB270 B870248E */  lw         $a0, %lo(gNumBanks)($s1)
    /* DBA74 800EB274 00000000 */  nop
    /* DBA78 800EB278 08008018 */  blez       $a0, .L800EB29C
    /* DBA7C 800EB27C 21180000 */   addu      $v1, $zero, $zero
    /* DBA80 800EB280 21288000 */  addu       $a1, $a0, $zero
    /* DBA84 800EB284 21204000 */  addu       $a0, $v0, $zero
  .L800EB288:
    /* DBA88 800EB288 000080AC */  sw         $zero, 0x0($a0)
    /* DBA8C 800EB28C 01006324 */  addiu      $v1, $v1, 0x1
    /* DBA90 800EB290 2A106500 */  slt        $v0, $v1, $a1
    /* DBA94 800EB294 FCFF4014 */  bnez       $v0, .L800EB288
    /* DBA98 800EB298 04008424 */   addiu     $a0, $a0, 0x4
  .L800EB29C:
    /* DBA9C 800EB29C 1380023C */  lui        $v0, %hi(gVoxBanks)
    /* DBAA0 800EB2A0 B470428C */  lw         $v0, %lo(gVoxBanks)($v0)
    /* DBAA4 800EB2A4 1800BF8F */  lw         $ra, 0x18($sp)
    /* DBAA8 800EB2A8 1400B18F */  lw         $s1, 0x14($sp)
    /* DBAAC 800EB2AC 1000B08F */  lw         $s0, 0x10($sp)
    /* DBAB0 800EB2B0 0800E003 */  jr         $ra
    /* DBAB4 800EB2B4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_BankMemAlloc
