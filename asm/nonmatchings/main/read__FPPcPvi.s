.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching read__FPPcPvi, 0x30

glabel read__FPPcPvi
    /* D1FA0 800E17A0 0000878C */  lw         $a3, 0x0($a0)
    /* D1FA4 800E17A4 0800C018 */  blez       $a2, .L800E17C8
    /* D1FA8 800E17A8 21180000 */   addu      $v1, $zero, $zero
  .L800E17AC:
    /* D1FAC 800E17AC 0000E290 */  lbu        $v0, 0x0($a3)
    /* D1FB0 800E17B0 0100E724 */  addiu      $a3, $a3, 0x1
    /* D1FB4 800E17B4 01006324 */  addiu      $v1, $v1, 0x1
    /* D1FB8 800E17B8 0000A2A0 */  sb         $v0, 0x0($a1)
    /* D1FBC 800E17BC 2A106600 */  slt        $v0, $v1, $a2
    /* D1FC0 800E17C0 FAFF4014 */  bnez       $v0, .L800E17AC
    /* D1FC4 800E17C4 0100A524 */   addiu     $a1, $a1, 0x1
  .L800E17C8:
    /* D1FC8 800E17C8 0800E003 */  jr         $ra
    /* D1FCC 800E17CC 000087AC */   sw        $a3, 0x0($a0)
endlabel read__FPPcPvi
