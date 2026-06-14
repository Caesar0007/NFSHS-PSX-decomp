.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef, 0x88

glabel AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
    /* 65360 80074B60 0000A38C */  lw         $v1, 0x0($a1)
    /* 65364 80074B64 0000828C */  lw         $v0, 0x0($a0)
    /* 65368 80074B68 0400A68C */  lw         $a2, 0x4($a1)
    /* 6536C 80074B6C 0800A58C */  lw         $a1, 0x8($a1)
    /* 65370 80074B70 23386200 */  subu       $a3, $v1, $v0
    /* 65374 80074B74 0200E104 */  bgez       $a3, .L80074B80
    /* 65378 80074B78 00000000 */   nop
    /* 6537C 80074B7C 23380700 */  negu       $a3, $a3
  .L80074B80:
    /* 65380 80074B80 0400838C */  lw         $v1, 0x4($a0)
    /* 65384 80074B84 0800828C */  lw         $v0, 0x8($a0)
    /* 65388 80074B88 2330C300 */  subu       $a2, $a2, $v1
    /* 6538C 80074B8C 2318A200 */  subu       $v1, $a1, $v0
    /* 65390 80074B90 0200C104 */  bgez       $a2, .L80074B9C
    /* 65394 80074B94 00000000 */   nop
    /* 65398 80074B98 23300600 */  negu       $a2, $a2
  .L80074B9C:
    /* 6539C 80074B9C 02006104 */  bgez       $v1, .L80074BA8
    /* 653A0 80074BA0 00000000 */   nop
    /* 653A4 80074BA4 23180300 */  negu       $v1, $v1
  .L80074BA8:
    /* 653A8 80074BA8 2A106700 */  slt        $v0, $v1, $a3
    /* 653AC 80074BAC 03004010 */  beqz       $v0, .L80074BBC
    /* 653B0 80074BB0 83100300 */   sra       $v0, $v1, 2
    /* 653B4 80074BB4 F1D20108 */  j          .L80074BC4
    /* 653B8 80074BB8 2118E200 */   addu      $v1, $a3, $v0
  .L80074BBC:
    /* 653BC 80074BBC 83100700 */  sra        $v0, $a3, 2
    /* 653C0 80074BC0 21186200 */  addu       $v1, $v1, $v0
  .L80074BC4:
    /* 653C4 80074BC4 2A106600 */  slt        $v0, $v1, $a2
    /* 653C8 80074BC8 04004010 */  beqz       $v0, .L80074BDC
    /* 653CC 80074BCC 00000000 */   nop
    /* 653D0 80074BD0 83100300 */  sra        $v0, $v1, 2
    /* 653D4 80074BD4 0800E003 */  jr         $ra
    /* 653D8 80074BD8 2110C200 */   addu      $v0, $a2, $v0
  .L80074BDC:
    /* 653DC 80074BDC 83100600 */  sra        $v0, $a2, 2
    /* 653E0 80074BE0 0800E003 */  jr         $ra
    /* 653E4 80074BE4 21106200 */   addu      $v0, $v1, $v0
endlabel AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
