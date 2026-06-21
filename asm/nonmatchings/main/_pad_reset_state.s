.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _pad_reset_state, 0x68

glabel _pad_reset_state
    /* EE688 800FDE88 49008290 */  lbu        $v0, 0x49($a0)
    /* EE68C 800FDE8C 00000000 */  nop
    /* EE690 800FDE90 15004010 */  beqz       $v0, .L800FDEE8
    /* EE694 800FDE94 00000000 */   nop
    /* EE698 800FDE98 5D008324 */  addiu      $v1, $a0, 0x5D
    /* EE69C 800FDE9C FF000524 */  addiu      $a1, $zero, 0xFF
    /* EE6A0 800FDEA0 05000224 */  addiu      $v0, $zero, 0x5
    /* EE6A4 800FDEA4 490080A0 */  sb         $zero, 0x49($a0)
    /* EE6A8 800FDEA8 460080A0 */  sb         $zero, 0x46($a0)
    /* EE6AC 800FDEAC E60080A4 */  sh         $zero, 0xE6($a0)
    /* EE6B0 800FDEB0 140080AC */  sw         $zero, 0x14($a0)
    /* EE6B4 800FDEB4 180080AC */  sw         $zero, 0x18($a0)
    /* EE6B8 800FDEB8 E30080A0 */  sb         $zero, 0xE3($a0)
    /* EE6BC 800FDEBC E40080A0 */  sb         $zero, 0xE4($a0)
    /* EE6C0 800FDEC0 E60080A4 */  sh         $zero, 0xE6($a0)
    /* EE6C4 800FDEC4 E90080A0 */  sb         $zero, 0xE9($a0)
    /* EE6C8 800FDEC8 EA0080A0 */  sb         $zero, 0xEA($a0)
    /* EE6CC 800FDECC 000080AC */  sw         $zero, 0x0($a0)
    /* EE6D0 800FDED0 040080AC */  sw         $zero, 0x4($a0)
    /* EE6D4 800FDED4 080080AC */  sw         $zero, 0x8($a0)
  .L800FDED8:
    /* EE6D8 800FDED8 000065A0 */  sb         $a1, 0x0($v1)
    /* EE6DC 800FDEDC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* EE6E0 800FDEE0 FDFF4104 */  bgez       $v0, .L800FDED8
    /* EE6E4 800FDEE4 01006324 */   addiu     $v1, $v1, 0x1
  .L800FDEE8:
    /* EE6E8 800FDEE8 0800E003 */  jr         $ra
    /* EE6EC 800FDEEC 00000000 */   nop
endlabel _pad_reset_state
