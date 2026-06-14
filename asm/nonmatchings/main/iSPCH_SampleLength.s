.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SampleLength, 0x68

glabel iSPCH_SampleLength
    /* F145C 80100C5C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F1460 80100C60 2000B0AF */  sw         $s0, 0x20($sp)
    /* F1464 80100C64 21800000 */  addu       $s0, $zero, $zero
    /* F1468 80100C68 1580023C */  lui        $v0, %hi(ispch_gPickSamples)
    /* F146C 80100C6C 7C844224 */  addiu      $v0, $v0, %lo(ispch_gPickSamples)
    /* F1470 80100C70 1380033C */  lui        $v1, %hi(gVoxBanks)
    /* F1474 80100C74 2400BFAF */  sw         $ra, 0x24($sp)
    /* F1478 80100C78 08008584 */  lh         $a1, 0x8($a0)
    /* F147C 80100C7C B470638C */  lw         $v1, %lo(gVoxBanks)($v1)
    /* F1480 80100C80 2128A200 */  addu       $a1, $a1, $v0
    /* F1484 80100C84 00008284 */  lh         $v0, 0x0($a0)
    /* F1488 80100C88 0000A590 */  lbu        $a1, 0x0($a1)
    /* F148C 80100C8C 80100200 */  sll        $v0, $v0, 2
    /* F1490 80100C90 21104300 */  addu       $v0, $v0, $v1
    /* F1494 80100C94 0000448C */  lw         $a0, 0x0($v0)
    /* F1498 80100C98 752D040C */  jal        iSPCH_UnPackSample
    /* F149C 80100C9C 1000A627 */   addiu     $a2, $sp, 0x10
    /* F14A0 80100CA0 04004010 */  beqz       $v0, .L80100CB4
    /* F14A4 80100CA4 21100002 */   addu      $v0, $s0, $zero
    /* F14A8 80100CA8 1000B08F */  lw         $s0, 0x10($sp)
    /* F14AC 80100CAC 00000000 */  nop
    /* F14B0 80100CB0 21100002 */  addu       $v0, $s0, $zero
  .L80100CB4:
    /* F14B4 80100CB4 2400BF8F */  lw         $ra, 0x24($sp)
    /* F14B8 80100CB8 2000B08F */  lw         $s0, 0x20($sp)
    /* F14BC 80100CBC 0800E003 */  jr         $ra
    /* F14C0 80100CC0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSPCH_SampleLength
