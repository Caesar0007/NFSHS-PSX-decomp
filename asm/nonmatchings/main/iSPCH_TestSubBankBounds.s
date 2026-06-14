.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_TestSubBankBounds, 0x4C

glabel iSPCH_TestSubBankBounds
    /* DBB7C 800EB37C 1380023C */  lui        $v0, %hi(gVoxBanks)
    /* DBB80 800EB380 B470438C */  lw         $v1, %lo(gVoxBanks)($v0)
    /* DBB84 800EB384 00000000 */  nop
    /* DBB88 800EB388 0D006010 */  beqz       $v1, .L800EB3C0
    /* DBB8C 800EB38C 21300000 */   addu      $a2, $zero, $zero
    /* DBB90 800EB390 0B008004 */  bltz       $a0, .L800EB3C0
    /* DBB94 800EB394 80100400 */   sll       $v0, $a0, 2
    /* DBB98 800EB398 21104300 */  addu       $v0, $v0, $v1
    /* DBB9C 800EB39C 0000448C */  lw         $a0, 0x0($v0)
    /* DBBA0 800EB3A0 00000000 */  nop
    /* DBBA4 800EB3A4 06008394 */  lhu        $v1, 0x6($a0)
    /* DBBA8 800EB3A8 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* DBBAC 800EB3AC 04006210 */  beq        $v1, $v0, .L800EB3C0
    /* DBBB0 800EB3B0 00000000 */   nop
    /* DBBB4 800EB3B4 0200A004 */  bltz       $a1, .L800EB3C0
    /* DBBB8 800EB3B8 21106000 */   addu      $v0, $v1, $zero
    /* DBBBC 800EB3BC 2A30A200 */  slt        $a2, $a1, $v0
  .L800EB3C0:
    /* DBBC0 800EB3C0 0800E003 */  jr         $ra
    /* DBBC4 800EB3C4 2110C000 */   addu      $v0, $a2, $zero
endlabel iSPCH_TestSubBankBounds
