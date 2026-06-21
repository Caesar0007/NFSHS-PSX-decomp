.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xE4

glabel ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* A598 80019D98 0580023C */  lui        $v0, %hi(CURRENTPLAYER)
    /* A59C 80019D9C 681A428C */  lw         $v0, %lo(CURRENTPLAYER)($v0)
    /* A5A0 80019DA0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* A5A4 80019DA4 1800B2AF */  sw         $s2, 0x18($sp)
    /* A5A8 80019DA8 21908000 */  addu       $s2, $a0, $zero
    /* A5AC 80019DAC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A5B0 80019DB0 2198A000 */  addu       $s3, $a1, $zero
    /* A5B4 80019DB4 2000B4AF */  sw         $s4, 0x20($sp)
    /* A5B8 80019DB8 21A0C000 */  addu       $s4, $a2, $zero
    /* A5BC 80019DBC 2400B5AF */  sw         $s5, 0x24($sp)
    /* A5C0 80019DC0 21A8E000 */  addu       $s5, $a3, $zero
    /* A5C4 80019DC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* A5C8 80019DC8 21800000 */  addu       $s0, $zero, $zero
    /* A5CC 80019DCC 2800BFAF */  sw         $ra, 0x28($sp)
    /* A5D0 80019DD0 1400B1AF */  sw         $s1, 0x14($sp)
    /* A5D4 80019DD4 80100200 */  sll        $v0, $v0, 2
    /* A5D8 80019DD8 01005124 */  addiu      $s1, $v0, 0x1
    /* A5DC 80019DDC A03F010C */  jal        MCRD_handlecardevents
    /* A5E0 80019DE0 21202002 */   addu      $a0, $s1, $zero
    /* A5E4 80019DE4 FEFF4324 */  addiu      $v1, $v0, -0x2
    /* A5E8 80019DE8 1600622C */  sltiu      $v0, $v1, 0x16
    /* A5EC 80019DEC 09004010 */  beqz       $v0, .L80019E14
    /* A5F0 80019DF0 0180023C */   lui       $v0, %hi(jtbl_80010258)
    /* A5F4 80019DF4 58024224 */  addiu      $v0, $v0, %lo(jtbl_80010258)
    /* A5F8 80019DF8 80180300 */  sll        $v1, $v1, 2
    /* A5FC 80019DFC 21186200 */  addu       $v1, $v1, $v0
    /* A600 80019E00 0000628C */  lw         $v0, 0x0($v1)
    /* A604 80019E04 00000000 */  nop
    /* A608 80019E08 08004000 */  jr         $v0
    /* A60C 80019E0C 00000000 */   nop
  jlabel .L80019E10
    /* A610 80019E10 01001024 */  addiu      $s0, $zero, 0x1
  jlabel .L80019E14
    /* A614 80019E14 9140010C */  jal        MCRD_getcard
    /* A618 80019E18 21202002 */   addu      $a0, $s1, $zero
    /* A61C 80019E1C 0000428C */  lw         $v0, 0x0($v0)
    /* A620 80019E20 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* A624 80019E24 02004314 */  bne        $v0, $v1, .L80019E30
    /* A628 80019E28 00000000 */   nop
    /* A62C 80019E2C 01001024 */  addiu      $s0, $zero, 0x1
  .L80019E30:
    /* A630 80019E30 04000012 */  beqz       $s0, .L80019E44
    /* A634 80019E34 01000224 */   addiu     $v0, $zero, 0x1
    /* A638 80019E38 980042AE */  sw         $v0, 0x98($s2)
    /* A63C 80019E3C 96670008 */  j          .L80019E58
    /* A640 80019E40 8A0043A6 */   sh        $v1, 0x8A($s2)
  .L80019E44:
    /* A644 80019E44 21204002 */  addu       $a0, $s2, $zero
    /* A648 80019E48 21286002 */  addu       $a1, $s3, $zero
    /* A64C 80019E4C 21308002 */  addu       $a2, $s4, $zero
    /* A650 80019E50 3367000C */  jal        ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* A654 80019E54 2138A002 */   addu      $a3, $s5, $zero
  .L80019E58:
    /* A658 80019E58 2800BF8F */  lw         $ra, 0x28($sp)
    /* A65C 80019E5C 2400B58F */  lw         $s5, 0x24($sp)
    /* A660 80019E60 2000B48F */  lw         $s4, 0x20($sp)
    /* A664 80019E64 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A668 80019E68 1800B28F */  lw         $s2, 0x18($sp)
    /* A66C 80019E6C 1400B18F */  lw         $s1, 0x14($sp)
    /* A670 80019E70 1000B08F */  lw         $s0, 0x10($sp)
    /* A674 80019E74 0800E003 */  jr         $ra
    /* A678 80019E78 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand
