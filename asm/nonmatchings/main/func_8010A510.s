.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010A510, 0x2C

glabel func_8010A510
    /* FAD10 8010A510 E6008294 */  lhu        $v0, 0xE6($a0)
    /* FAD14 8010A514 00000000 */  nop
    /* FAD18 8010A518 05004010 */  beqz       $v0, .L8010A530
    /* FAD1C 8010A51C FF000224 */   addiu     $v0, $zero, 0xFF
    /* FAD20 8010A520 46008390 */  lbu        $v1, 0x46($a0)
    /* FAD24 8010A524 00000000 */  nop
    /* FAD28 8010A528 02006210 */  beq        $v1, $v0, .L8010A534
    /* FAD2C 8010A52C 21100000 */   addu      $v0, $zero, $zero
  .L8010A530:
    /* FAD30 8010A530 01000224 */  addiu      $v0, $zero, 0x1
  .L8010A534:
    /* FAD34 8010A534 0800E003 */  jr         $ra
    /* FAD38 8010A538 00000000 */   nop
endlabel func_8010A510
    /* FAD3C 8010A53C 00000000 */  nop
