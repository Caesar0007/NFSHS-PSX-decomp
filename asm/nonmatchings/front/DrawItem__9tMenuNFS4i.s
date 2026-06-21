.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawItem__9tMenuNFS4i, 0x60

glabel DrawItem__9tMenuNFS4i
    /* BC94 8001B494 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BC98 8001B498 2138A000 */  addu       $a3, $a1, $zero
    /* BC9C 8001B49C 80100700 */  sll        $v0, $a3, 2
    /* BCA0 8001B4A0 21108200 */  addu       $v0, $a0, $v0
    /* BCA4 8001B4A4 C0300700 */  sll        $a2, $a3, 3
    /* BCA8 8001B4A8 2130C700 */  addu       $a2, $a2, $a3
    /* BCAC 8001B4AC 40300600 */  sll        $a2, $a2, 1
    /* BCB0 8001B4B0 0A000524 */  addiu      $a1, $zero, 0xA
    /* BCB4 8001B4B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* BCB8 8001B4B8 1000438C */  lw         $v1, 0x10($v0)
    /* BCBC 8001B4BC 0800828C */  lw         $v0, 0x8($a0)
    /* BCC0 8001B4C0 2B00C624 */  addiu      $a2, $a2, 0x2B
    /* BCC4 8001B4C4 2638E200 */  xor        $a3, $a3, $v0
    /* BCC8 8001B4C8 1800688C */  lw         $t0, 0x18($v1)
    /* BCCC 8001B4CC 0100E72C */  sltiu      $a3, $a3, 0x1
    /* BCD0 8001B4D0 28000485 */  lh         $a0, 0x28($t0)
    /* BCD4 8001B4D4 2C00028D */  lw         $v0, 0x2C($t0)
    /* BCD8 8001B4D8 00000000 */  nop
    /* BCDC 8001B4DC 09F84000 */  jalr       $v0
    /* BCE0 8001B4E0 21206400 */   addu      $a0, $v1, $a0
    /* BCE4 8001B4E4 1000BF8F */  lw         $ra, 0x10($sp)
    /* BCE8 8001B4E8 00000000 */  nop
    /* BCEC 8001B4EC 0800E003 */  jr         $ra
    /* BCF0 8001B4F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawItem__9tMenuNFS4i
