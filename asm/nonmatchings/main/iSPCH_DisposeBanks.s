.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_DisposeBanks, 0x40

glabel iSPCH_DisposeBanks
    /* DB9F4 800EB1F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DB9F8 800EB1F8 1000B0AF */  sw         $s0, 0x10($sp)
    /* DB9FC 800EB1FC 1380103C */  lui        $s0, %hi(gVoxBanks)
    /* DBA00 800EB200 B470048E */  lw         $a0, %lo(gVoxBanks)($s0)
    /* DBA04 800EB204 00000000 */  nop
    /* DBA08 800EB208 03008010 */  beqz       $a0, .L800EB218
    /* DBA0C 800EB20C 1400BFAF */   sw        $ra, 0x14($sp)
    /* DBA10 800EB210 75AD030C */  jal        iSPCH_MemFree
    /* DBA14 800EB214 00000000 */   nop
  .L800EB218:
    /* DBA18 800EB218 1400BF8F */  lw         $ra, 0x14($sp)
    /* DBA1C 800EB21C B47000AE */  sw         $zero, %lo(gVoxBanks)($s0)
    /* DBA20 800EB220 1000B08F */  lw         $s0, 0x10($sp)
    /* DBA24 800EB224 1380023C */  lui        $v0, %hi(gNumBanks)
    /* DBA28 800EB228 B87040AC */  sw         $zero, %lo(gNumBanks)($v0)
    /* DBA2C 800EB22C 0800E003 */  jr         $ra
    /* DBA30 800EB230 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_DisposeBanks
