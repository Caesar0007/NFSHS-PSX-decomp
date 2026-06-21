.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MDECCompleteHandler__Fv, 0xA4

glabel MDECCompleteHandler__Fv
    /* 41420 80050C20 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 41424 80050C24 0580023C */  lui        $v0, %hi(gMDECinfo)
    /* 41428 80050C28 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4142C 80050C2C 282B5124 */  addiu      $s1, $v0, %lo(gMDECinfo)
    /* 41430 80050C30 1800BFAF */  sw         $ra, 0x18($sp)
    /* 41434 80050C34 1000B0AF */  sw         $s0, 0x10($sp)
    /* 41438 80050C38 0400308E */  lw         $s0, 0x4($s1)
    /* 4143C 80050C3C 00000000 */  nop
    /* 41440 80050C40 2400058E */  lw         $a1, 0x24($s0)
    /* 41444 80050C44 A4B6030C */  jal        LoadImage
    /* 41448 80050C48 18000426 */   addiu     $a0, $s0, 0x18
    /* 4144C 80050C4C 1FB6030C */  jal        DrawSync
    /* 41450 80050C50 21200000 */   addu      $a0, $zero, $zero
    /* 41454 80050C54 03004010 */  beqz       $v0, .L80050C64
    /* 41458 80050C58 0580033C */   lui       $v1, %hi(g_mdecdrawsyncfailed)
    /* 4145C 80050C5C 01000224 */  addiu      $v0, $zero, 0x1
    /* 41460 80050C60 302B62AC */  sw         $v0, %lo(g_mdecdrawsyncfailed)($v1)
  .L80050C64:
    /* 41464 80050C64 18000296 */  lhu        $v0, 0x18($s0)
    /* 41468 80050C68 0C000396 */  lhu        $v1, 0xC($s0)
    /* 4146C 80050C6C 14000486 */  lh         $a0, 0x14($s0)
    /* 41470 80050C70 21104300 */  addu       $v0, $v0, $v1
    /* 41474 80050C74 180002A6 */  sh         $v0, 0x18($s0)
    /* 41478 80050C78 00140200 */  sll        $v0, $v0, 16
    /* 4147C 80050C7C 10000386 */  lh         $v1, 0x10($s0)
    /* 41480 80050C80 03140200 */  sra        $v0, $v0, 16
    /* 41484 80050C84 21186400 */  addu       $v1, $v1, $a0
    /* 41488 80050C88 2A104300 */  slt        $v0, $v0, $v1
    /* 4148C 80050C8C 07004010 */  beqz       $v0, .L80050CAC
    /* 41490 80050C90 00000000 */   nop
    /* 41494 80050C94 2400048E */  lw         $a0, 0x24($s0)
    /* 41498 80050C98 2000058E */  lw         $a1, 0x20($s0)
    /* 4149C 80050C9C 9EE2030C */  jal        DecDCTout
    /* 414A0 80050CA0 00000000 */   nop
    /* 414A4 80050CA4 2C430108 */  j          .L80050CB0
    /* 414A8 80050CA8 00000000 */   nop
  .L80050CAC:
    /* 414AC 80050CAC 040020AE */  sw         $zero, 0x4($s1)
  .L80050CB0:
    /* 414B0 80050CB0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 414B4 80050CB4 1400B18F */  lw         $s1, 0x14($sp)
    /* 414B8 80050CB8 1000B08F */  lw         $s0, 0x10($sp)
    /* 414BC 80050CBC 0800E003 */  jr         $ra
    /* 414C0 80050CC0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MDECCompleteHandler__Fv
    /* 414C4 80050CC4 00000000 */  nop
