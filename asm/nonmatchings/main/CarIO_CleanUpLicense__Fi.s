.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_CleanUpLicense__Fi, 0x78

glabel CarIO_CleanUpLicense__Fi
    /* ACDF0 800BC5F0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ACDF4 800BC5F4 1400B1AF */  sw         $s1, 0x14($sp)
    /* ACDF8 800BC5F8 80880400 */  sll        $s1, $a0, 2
    /* ACDFC 800BC5FC 1480023C */  lui        $v0, %hi(CarIO_Plate1)
    /* ACE00 800BC600 48D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate1)
    /* ACE04 800BC604 1000B0AF */  sw         $s0, 0x10($sp)
    /* ACE08 800BC608 21802202 */  addu       $s0, $s1, $v0
    /* ACE0C 800BC60C 1800BFAF */  sw         $ra, 0x18($sp)
    /* ACE10 800BC610 0000048E */  lw         $a0, 0x0($s0)
    /* ACE14 800BC614 00000000 */  nop
    /* ACE18 800BC618 03008010 */  beqz       $a0, .L800BC628
    /* ACE1C 800BC61C 00000000 */   nop
    /* ACE20 800BC620 5095030C */  jal        purgememadr
    /* ACE24 800BC624 00000000 */   nop
  .L800BC628:
    /* ACE28 800BC628 1480023C */  lui        $v0, %hi(CarIO_Plate2)
    /* ACE2C 800BC62C 50D74224 */  addiu      $v0, $v0, %lo(CarIO_Plate2)
    /* ACE30 800BC630 000000AE */  sw         $zero, 0x0($s0)
    /* ACE34 800BC634 21802202 */  addu       $s0, $s1, $v0
    /* ACE38 800BC638 0000048E */  lw         $a0, 0x0($s0)
    /* ACE3C 800BC63C 00000000 */  nop
    /* ACE40 800BC640 03008010 */  beqz       $a0, .L800BC650
    /* ACE44 800BC644 00000000 */   nop
    /* ACE48 800BC648 5095030C */  jal        purgememadr
    /* ACE4C 800BC64C 00000000 */   nop
  .L800BC650:
    /* ACE50 800BC650 000000AE */  sw         $zero, 0x0($s0)
    /* ACE54 800BC654 1800BF8F */  lw         $ra, 0x18($sp)
    /* ACE58 800BC658 1400B18F */  lw         $s1, 0x14($sp)
    /* ACE5C 800BC65C 1000B08F */  lw         $s0, 0x10($sp)
    /* ACE60 800BC660 0800E003 */  jr         $ra
    /* ACE64 800BC664 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CarIO_CleanUpLicense__Fi
