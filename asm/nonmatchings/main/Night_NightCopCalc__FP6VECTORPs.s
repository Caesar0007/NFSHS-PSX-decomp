.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_NightCopCalc__FP6VECTORPs, 0xA0

glabel Night_NightCopCalc__FP6VECTORPs
    /* B6718 800C5F18 0800838C */  lw         $v1, 0x8($a0)
    /* B671C 800C5F1C 00000000 */  nop
    /* B6720 800C5F20 FF076224 */  addiu      $v0, $v1, 0x7FF
    /* B6724 800C5F24 FF0F422C */  sltiu      $v0, $v0, 0xFFF
    /* B6728 800C5F28 21004010 */  beqz       $v0, .L800C5FB0
    /* B672C 800C5F2C 2138A000 */   addu      $a3, $a1, $zero
    /* B6730 800C5F30 0000868C */  lw         $a2, 0x0($a0)
    /* B6734 800C5F34 00000000 */  nop
    /* B6738 800C5F38 FF03C224 */  addiu      $v0, $a2, 0x3FF
    /* B673C 800C5F3C FF07422C */  sltiu      $v0, $v0, 0x7FF
    /* B6740 800C5F40 1B004010 */  beqz       $v0, .L800C5FB0
    /* B6744 800C5F44 00000000 */   nop
    /* B6748 800C5F48 03006104 */  bgez       $v1, .L800C5F58
    /* B674C 800C5F4C 21280000 */   addu      $a1, $zero, $zero
    /* B6750 800C5F50 23180300 */  negu       $v1, $v1
    /* B6754 800C5F54 01000524 */  addiu      $a1, $zero, 0x1
  .L800C5F58:
    /* B6758 800C5F58 43190300 */  sra        $v1, $v1, 5
    /* B675C 800C5F5C 0004C624 */  addiu      $a2, $a2, 0x400
    /* B6760 800C5F60 43310600 */  sra        $a2, $a2, 5
    /* B6764 800C5F64 80200500 */  sll        $a0, $a1, 2
    /* B6768 800C5F68 80110300 */  sll        $v0, $v1, 6
    /* B676C 800C5F6C 1480033C */  lui        $v1, %hi(Night_gNightTbl)
    /* B6770 800C5F70 40DA638C */  lw         $v1, %lo(Night_gNightTbl)($v1)
    /* B6774 800C5F74 21104600 */  addu       $v0, $v0, $a2
    /* B6778 800C5F78 21186200 */  addu       $v1, $v1, $v0
    /* B677C 800C5F7C 1480023C */  lui        $v0, %hi(Night_gCopColor)
    /* B6780 800C5F80 4CDA4224 */  addiu      $v0, $v0, %lo(Night_gCopColor)
    /* B6784 800C5F84 21208200 */  addu       $a0, $a0, $v0
    /* B6788 800C5F88 00006590 */  lbu        $a1, 0x0($v1)
    /* B678C 800C5F8C 0000E284 */  lh         $v0, 0x0($a3)
    /* B6790 800C5F90 0000838C */  lw         $v1, 0x0($a0)
    /* B6794 800C5F94 43280500 */  sra        $a1, $a1, 1
    /* B6798 800C5F98 C0100200 */  sll        $v0, $v0, 3
    /* B679C 800C5F9C 21104300 */  addu       $v0, $v0, $v1
    /* B67A0 800C5FA0 21104500 */  addu       $v0, $v0, $a1
    /* B67A4 800C5FA4 00004290 */  lbu        $v0, 0x0($v0)
    /* B67A8 800C5FA8 00000000 */  nop
    /* B67AC 800C5FAC 0000E2A4 */  sh         $v0, 0x0($a3)
  .L800C5FB0:
    /* B67B0 800C5FB0 0800E003 */  jr         $ra
    /* B67B4 800C5FB4 00000000 */   nop
endlabel Night_NightCopCalc__FP6VECTORPs
