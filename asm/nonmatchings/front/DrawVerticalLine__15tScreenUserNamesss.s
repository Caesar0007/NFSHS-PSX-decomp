.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVerticalLine__15tScreenUserNamesss, 0x80

glabel DrawVerticalLine__15tScreenUserNamesss
    /* 3B8A8 8004B0A8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3B8AC 8004B0AC 00140700 */  sll        $v0, $a3, 16
    /* 3B8B0 8004B0B0 031C0200 */  sra        $v1, $v0, 16
    /* 3B8B4 8004B0B4 04006018 */  blez       $v1, .L8004B0C8
    /* 3B8B8 8004B0B8 2000BFAF */   sw        $ra, 0x20($sp)
    /* 3B8BC 8004B0BC 40006228 */  slti       $v0, $v1, 0x40
    /* 3B8C0 8004B0C0 05004010 */  beqz       $v0, .L8004B0D8
    /* 3B8C4 8004B0C4 7800043C */   lui       $a0, (0x785A5A >> 16)
  .L8004B0C8:
    /* 3B8C8 8004B0C8 04006104 */  bgez       $v1, .L8004B0DC
    /* 3B8CC 8004B0CC 7800043C */   lui       $a0, (0x785A5A >> 16)
    /* 3B8D0 8004B0D0 372C0108 */  j          .L8004B0DC
    /* 3B8D4 8004B0D4 21380000 */   addu      $a3, $zero, $zero
  .L8004B0D8:
    /* 3B8D8 8004B0D8 40000724 */  addiu      $a3, $zero, 0x40
  .L8004B0DC:
    /* 3B8DC 8004B0DC 5A5A8434 */  ori        $a0, $a0, (0x785A5A & 0xFFFF)
    /* 3B8E0 8004B0E0 A2000224 */  addiu      $v0, $zero, 0xA2
    /* 3B8E4 8004B0E4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3B8E8 8004B0E8 01000224 */  addiu      $v0, $zero, 0x1
    /* 3B8EC 8004B0EC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 3B8F0 8004B0F0 00140700 */  sll        $v0, $a3, 16
    /* 3B8F4 8004B0F4 C3130200 */  sra        $v0, $v0, 15
    /* 3B8F8 8004B0F8 002C0500 */  sll        $a1, $a1, 16
    /* 3B8FC 8004B0FC 00340600 */  sll        $a2, $a2, 16
    /* 3B900 8004B100 032C0500 */  sra        $a1, $a1, 16
    /* 3B904 8004B104 03340600 */  sra        $a2, $a2, 16
    /* 3B908 8004B108 02000724 */  addiu      $a3, $zero, 0x2
    /* 3B90C 8004B10C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 3B910 8004B110 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 3B914 8004B114 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* 3B918 8004B118 2000BF8F */  lw         $ra, 0x20($sp)
    /* 3B91C 8004B11C 00000000 */  nop
    /* 3B920 8004B120 0800E003 */  jr         $ra
    /* 3B924 8004B124 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawVerticalLine__15tScreenUserNamesss
