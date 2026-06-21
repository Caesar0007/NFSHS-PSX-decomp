.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawItem__18tMenuNFS4TwoPlayeri, 0x78

glabel DrawItem__18tMenuNFS4TwoPlayeri
    /* BED0 8001B6D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BED4 8001B6D4 0580023C */  lui        $v0, %hi(FEApp)
    /* BED8 8001B6D8 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* BEDC 8001B6DC 1000BFAF */  sw         $ra, 0x10($sp)
    /* BEE0 8001B6E0 2C024390 */  lbu        $v1, 0x22C($v0)
    /* BEE4 8001B6E4 01000224 */  addiu      $v0, $zero, 0x1
    /* BEE8 8001B6E8 02006214 */  bne        $v1, $v0, .L8001B6F4
    /* BEEC 8001B6EC 2B000824 */   addiu     $t0, $zero, 0x2B
    /* BEF0 8001B6F0 94000824 */  addiu      $t0, $zero, 0x94
  .L8001B6F4:
    /* BEF4 8001B6F4 80100500 */  sll        $v0, $a1, 2
    /* BEF8 8001B6F8 21108200 */  addu       $v0, $a0, $v0
    /* BEFC 8001B6FC C0300500 */  sll        $a2, $a1, 3
    /* BF00 8001B700 2130C500 */  addu       $a2, $a2, $a1
    /* BF04 8001B704 40300600 */  sll        $a2, $a2, 1
    /* BF08 8001B708 21300601 */  addu       $a2, $t0, $a2
    /* BF0C 8001B70C 1000428C */  lw         $v0, 0x10($v0)
    /* BF10 8001B710 0800878C */  lw         $a3, 0x8($a0)
    /* BF14 8001B714 1800438C */  lw         $v1, 0x18($v0)
    /* BF18 8001B718 2638A700 */  xor        $a3, $a1, $a3
    /* BF1C 8001B71C 28006484 */  lh         $a0, 0x28($v1)
    /* BF20 8001B720 0A000524 */  addiu      $a1, $zero, 0xA
    /* BF24 8001B724 21204400 */  addu       $a0, $v0, $a0
    /* BF28 8001B728 2C00628C */  lw         $v0, 0x2C($v1)
    /* BF2C 8001B72C 00000000 */  nop
    /* BF30 8001B730 09F84000 */  jalr       $v0
    /* BF34 8001B734 0100E72C */   sltiu     $a3, $a3, 0x1
    /* BF38 8001B738 1000BF8F */  lw         $ra, 0x10($sp)
    /* BF3C 8001B73C 00000000 */  nop
    /* BF40 8001B740 0800E003 */  jr         $ra
    /* BF44 8001B744 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawItem__18tMenuNFS4TwoPlayeri
