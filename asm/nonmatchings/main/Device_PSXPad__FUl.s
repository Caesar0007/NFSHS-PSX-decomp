.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_PSXPad__FUl, 0x68

glabel Device_PSXPad__FUl
    /* ADE44 800BD644 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ADE48 800BD648 1400B1AF */  sw         $s1, 0x14($sp)
    /* ADE4C 800BD64C 21888000 */  addu       $s1, $a0, $zero
    /* ADE50 800BD650 1000B0AF */  sw         $s0, 0x10($sp)
    /* ADE54 800BD654 02841100 */  srl        $s0, $s1, 16
    /* ADE58 800BD658 1800BFAF */  sw         $ra, 0x18($sp)
    /* ADE5C 800BD65C F0F4020C */  jal        Device_VerifyType__Fi
    /* ADE60 800BD660 21200002 */   addu      $a0, $s0, $zero
    /* ADE64 800BD664 0B004010 */  beqz       $v0, .L800BD694
    /* ADE68 800BD668 1480033C */   lui       $v1, %hi(D_8013E8A2)
    /* ADE6C 800BD66C A2E86324 */  addiu      $v1, $v1, %lo(D_8013E8A2)
    /* ADE70 800BD670 C0101000 */  sll        $v0, $s0, 3
    /* ADE74 800BD674 21104300 */  addu       $v0, $v0, $v1
    /* ADE78 800BD678 00004394 */  lhu        $v1, 0x0($v0)
    /* ADE7C 800BD67C 00000000 */  nop
    /* ADE80 800BD680 27180300 */  nor        $v1, $zero, $v1
    /* ADE84 800BD684 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* ADE88 800BD688 24187100 */  and        $v1, $v1, $s1
    /* ADE8C 800BD68C 02006014 */  bnez       $v1, .L800BD698
    /* ADE90 800BD690 FF000224 */   addiu     $v0, $zero, 0xFF
  .L800BD694:
    /* ADE94 800BD694 21100000 */  addu       $v0, $zero, $zero
  .L800BD698:
    /* ADE98 800BD698 1800BF8F */  lw         $ra, 0x18($sp)
    /* ADE9C 800BD69C 1400B18F */  lw         $s1, 0x14($sp)
    /* ADEA0 800BD6A0 1000B08F */  lw         $s0, 0x10($sp)
    /* ADEA4 800BD6A4 0800E003 */  jr         $ra
    /* ADEA8 800BD6A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Device_PSXPad__FUl
