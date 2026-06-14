.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800E5EDC, 0x3C

glabel func_800E5EDC
    /* D66DC 800E5EDC 21408000 */  addu       $t0, $a0, $zero
    /* D66E0 800E5EE0 2148A000 */  addu       $t1, $a1, $zero
    /* D66E4 800E5EE4 0A00C010 */  beqz       $a2, .L800E5F10
    /* D66E8 800E5EE8 21380000 */   addu      $a3, $zero, $zero
  .L800E5EEC:
    /* D66EC 800E5EEC 21180701 */  addu       $v1, $t0, $a3
    /* D66F0 800E5EF0 21202701 */  addu       $a0, $t1, $a3
    /* D66F4 800E5EF4 00006590 */  lbu        $a1, 0x0($v1)
    /* D66F8 800E5EF8 00008290 */  lbu        $v0, 0x0($a0)
    /* D66FC 800E5EFC 0100E724 */  addiu      $a3, $a3, 0x1
    /* D6700 800E5F00 000062A0 */  sb         $v0, 0x0($v1)
    /* D6704 800E5F04 2B10E600 */  sltu       $v0, $a3, $a2
    /* D6708 800E5F08 F8FF4014 */  bnez       $v0, .L800E5EEC
    /* D670C 800E5F0C 000085A0 */   sb        $a1, 0x0($a0)
  .L800E5F10:
    /* D6710 800E5F10 0800E003 */  jr         $ra
    /* D6714 800E5F14 00000000 */   nop
endlabel func_800E5EDC
    /* D6718 800E5F18 00000000 */  nop
