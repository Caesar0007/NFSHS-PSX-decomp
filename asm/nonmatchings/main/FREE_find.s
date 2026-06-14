.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FREE_find, 0x64

glabel FREE_find
    /* D554C 800E4D4C 0A00C014 */  bnez       $a2, .L800E4D78
    /* D5550 800E4D50 10008424 */   addiu     $a0, $a0, 0x10
  .L800E4D54:
    /* D5554 800E4D54 1000848C */  lw         $a0, 0x10($a0)
    /* D5558 800E4D58 00000000 */  nop
    /* D555C 800E4D5C 0400828C */  lw         $v0, 0x4($a0)
    /* D5560 800E4D60 00000000 */  nop
    /* D5564 800E4D64 2A104500 */  slt        $v0, $v0, $a1
    /* D5568 800E4D68 0A004010 */  beqz       $v0, .L800E4D94
    /* D556C 800E4D6C 00000000 */   nop
    /* D5570 800E4D70 55930308 */  j          .L800E4D54
    /* D5574 800E4D74 00000000 */   nop
  .L800E4D78:
    /* D5578 800E4D78 1400848C */  lw         $a0, 0x14($a0)
    /* D557C 800E4D7C 00000000 */  nop
    /* D5580 800E4D80 0400828C */  lw         $v0, 0x4($a0)
    /* D5584 800E4D84 00000000 */  nop
    /* D5588 800E4D88 2A104500 */  slt        $v0, $v0, $a1
    /* D558C 800E4D8C FAFF4014 */  bnez       $v0, .L800E4D78
    /* D5590 800E4D90 00000000 */   nop
  .L800E4D94:
    /* D5594 800E4D94 00008394 */  lhu        $v1, 0x0($a0)
    /* D5598 800E4D98 53420224 */  addiu      $v0, $zero, 0x4253
    /* D559C 800E4D9C 02006214 */  bne        $v1, $v0, .L800E4DA8
    /* D55A0 800E4DA0 00000000 */   nop
    /* D55A4 800E4DA4 21200000 */  addu       $a0, $zero, $zero
  .L800E4DA8:
    /* D55A8 800E4DA8 0800E003 */  jr         $ra
    /* D55AC 800E4DAC 21108000 */   addu      $v0, $a0, $zero
endlabel FREE_find
