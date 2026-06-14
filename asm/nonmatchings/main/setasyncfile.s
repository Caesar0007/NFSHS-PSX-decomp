.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching setasyncfile, 0x60

glabel setasyncfile
    /* E1C5C 800F145C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1C60 800F1460 1000B0AF */  sw         $s0, 0x10($sp)
    /* E1C64 800F1464 21808000 */  addu       $s0, $a0, $zero
    /* E1C68 800F1468 6419848F */  lw         $a0, %gp_rel(D_8013DEB0)($gp)
    /* E1C6C 800F146C 00000000 */  nop
    /* E1C70 800F1470 03008010 */  beqz       $a0, .L800F1480
    /* E1C74 800F1474 1400BFAF */   sw        $ra, 0x14($sp)
    /* E1C78 800F1478 54AA030C */  jal        FILE_closesync
    /* E1C7C 800F147C 64000524 */   addiu     $a1, $zero, 0x64
  .L800F1480:
    /* E1C80 800F1480 04000016 */  bnez       $s0, .L800F1494
    /* E1C84 800F1484 21200002 */   addu      $a0, $s0, $zero
    /* E1C88 800F1488 641980AF */  sw         $zero, %gp_rel(D_8013DEB0)($gp)
    /* E1C8C 800F148C 2BC50308 */  j          .L800F14AC
    /* E1C90 800F1490 00000000 */   nop
  .L800F1494:
    /* E1C94 800F1494 01000524 */  addiu      $a1, $zero, 0x1
    /* E1C98 800F1498 1480073C */  lui        $a3, %hi(D_8013DEB0)
    /* E1C9C 800F149C B0DEE724 */  addiu      $a3, $a3, %lo(D_8013DEB0)
    /* E1CA0 800F14A0 2AAA030C */  jal        FILE_opensync
    /* E1CA4 800F14A4 64000624 */   addiu     $a2, $zero, 0x64
    /* E1CA8 800F14A8 681980AF */  sw         $zero, %gp_rel(D_8013DEB4)($gp)
  .L800F14AC:
    /* E1CAC 800F14AC 1400BF8F */  lw         $ra, 0x14($sp)
    /* E1CB0 800F14B0 1000B08F */  lw         $s0, 0x10($sp)
    /* E1CB4 800F14B4 0800E003 */  jr         $ra
    /* E1CB8 800F14B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel setasyncfile
