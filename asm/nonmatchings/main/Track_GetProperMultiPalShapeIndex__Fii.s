.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_GetProperMultiPalShapeIndex__Fii, 0x50

glabel Track_GetProperMultiPalShapeIndex__Fii
    /* AA374 800B9B74 21300000 */  addu       $a2, $zero, $zero
    /* AA378 800B9B78 8C18838F */  lw         $v1, %gp_rel(D_8013DDD8)($gp)
  .L800B9B7C:
    /* AA37C 800B9B7C 00000000 */  nop
    /* AA380 800B9B80 04006284 */  lh         $v0, 0x4($v1)
    /* AA384 800B9B84 00000000 */  nop
    /* AA388 800B9B88 08004414 */  bne        $v0, $a0, .L800B9BAC
    /* AA38C 800B9B8C 00000000 */   nop
    /* AA390 800B9B90 02006284 */  lh         $v0, 0x2($v1)
    /* AA394 800B9B94 00000000 */  nop
    /* AA398 800B9B98 05004514 */  bne        $v0, $a1, .L800B9BB0
    /* AA39C 800B9B9C 0100C624 */   addiu     $a2, $a2, 0x1
    /* AA3A0 800B9BA0 06006284 */  lh         $v0, 0x6($v1)
    /* AA3A4 800B9BA4 0800E003 */  jr         $ra
    /* AA3A8 800B9BA8 00000000 */   nop
  .L800B9BAC:
    /* AA3AC 800B9BAC 0100C624 */  addiu      $a2, $a2, 0x1
  .L800B9BB0:
    /* AA3B0 800B9BB0 8000C228 */  slti       $v0, $a2, 0x80
    /* AA3B4 800B9BB4 F1FF4014 */  bnez       $v0, .L800B9B7C
    /* AA3B8 800B9BB8 08006324 */   addiu     $v1, $v1, 0x8
    /* AA3BC 800B9BBC 0800E003 */  jr         $ra
    /* AA3C0 800B9BC0 21108000 */   addu      $v0, $a0, $zero
endlabel Track_GetProperMultiPalShapeIndex__Fii
