.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_CheckTemplateSample, 0x50

glabel iSPCH_CheckTemplateSample
    /* F1270 80100A70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F1274 80100A74 1000BFAF */  sw         $ra, 0x10($sp)
    /* F1278 80100A78 0600A294 */  lhu        $v0, 0x6($a1)
    /* F127C 80100A7C 02008484 */  lh         $a0, 0x2($a0)
    /* F1280 80100A80 00000000 */  nop
    /* F1284 80100A84 2A108200 */  slt        $v0, $a0, $v0
    /* F1288 80100A88 09004010 */  beqz       $v0, .L80100AB0
    /* F128C 80100A8C 21180000 */   addu      $v1, $zero, $zero
    /* F1290 80100A90 0300A290 */  lbu        $v0, 0x3($a1)
    /* F1294 80100A94 00000000 */  nop
    /* F1298 80100A98 18004400 */  mult       $v0, $a0
    /* F129C 80100A9C 2120A000 */  addu       $a0, $a1, $zero
    /* F12A0 80100AA0 12380000 */  mflo       $a3
    /* F12A4 80100AA4 8702040C */  jal        iSPCH_CheckBankBit
    /* F12A8 80100AA8 2128C700 */   addu      $a1, $a2, $a3
    /* F12AC 80100AAC 21184000 */  addu       $v1, $v0, $zero
  .L80100AB0:
    /* F12B0 80100AB0 1000BF8F */  lw         $ra, 0x10($sp)
    /* F12B4 80100AB4 21106000 */  addu       $v0, $v1, $zero
    /* F12B8 80100AB8 0800E003 */  jr         $ra
    /* F12BC 80100ABC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_CheckTemplateSample
