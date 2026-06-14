.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unpackz, 0xB4

glabel unpackz
    /* D4668 800E3E68 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D466C 800E3E6C 1000BFAF */  sw         $ra, 0x10($sp)
    /* D4670 800E3E70 01008390 */  lbu        $v1, 0x1($a0)
    /* D4674 800E3E74 FB000224 */  addiu      $v0, $zero, 0xFB
    /* D4678 800E3E78 04006210 */  beq        $v1, $v0, .L800E3E8C
    /* D467C 800E3E7C 21300000 */   addu      $a2, $zero, $zero
    /* D4680 800E3E80 32000224 */  addiu      $v0, $zero, 0x32
    /* D4684 800E3E84 21006214 */  bne        $v1, $v0, .L800E3F0C
    /* D4688 800E3E88 00000000 */   nop
  .L800E3E8C:
    /* D468C 800E3E8C 00008290 */  lbu        $v0, 0x0($a0)
    /* D4690 800E3E90 00000000 */  nop
    /* D4694 800E3E94 FE004330 */  andi       $v1, $v0, 0xFE
    /* D4698 800E3E98 32000224 */  addiu      $v0, $zero, 0x32
    /* D469C 800E3E9C 14006210 */  beq        $v1, $v0, .L800E3EF0
    /* D46A0 800E3EA0 33006228 */   slti      $v0, $v1, 0x33
    /* D46A4 800E3EA4 07004010 */  beqz       $v0, .L800E3EC4
    /* D46A8 800E3EA8 10000224 */   addiu     $v0, $zero, 0x10
    /* D46AC 800E3EAC 0C006210 */  beq        $v1, $v0, .L800E3EE0
    /* D46B0 800E3EB0 30000224 */   addiu     $v0, $zero, 0x30
    /* D46B4 800E3EB4 0E006210 */  beq        $v1, $v0, .L800E3EF0
    /* D46B8 800E3EB8 00000000 */   nop
    /* D46BC 800E3EBC C38F0308 */  j          .L800E3F0C
    /* D46C0 800E3EC0 00000000 */   nop
  .L800E3EC4:
    /* D46C4 800E3EC4 34000224 */  addiu      $v0, $zero, 0x34
    /* D46C8 800E3EC8 09006210 */  beq        $v1, $v0, .L800E3EF0
    /* D46CC 800E3ECC 46000224 */   addiu     $v0, $zero, 0x46
    /* D46D0 800E3ED0 0B006210 */  beq        $v1, $v0, .L800E3F00
    /* D46D4 800E3ED4 00000000 */   nop
    /* D46D8 800E3ED8 C38F0308 */  j          .L800E3F0C
    /* D46DC 800E3EDC 00000000 */   nop
  .L800E3EE0:
    /* D46E0 800E3EE0 AED4030C */  jal        unrefpack
    /* D46E4 800E3EE4 01000624 */   addiu     $a2, $zero, 0x1
    /* D46E8 800E3EE8 C38F0308 */  j          .L800E3F0C
    /* D46EC 800E3EEC 21304000 */   addu      $a2, $v0, $zero
  .L800E3EF0:
    /* D46F0 800E3EF0 67D1030C */  jal        unhuff
    /* D46F4 800E3EF4 01000624 */   addiu     $a2, $zero, 0x1
    /* D46F8 800E3EF8 C38F0308 */  j          .L800E3F0C
    /* D46FC 800E3EFC 21304000 */   addu      $a2, $v0, $zero
  .L800E3F00:
    /* D4700 800E3F00 6DD5030C */  jal        unbtree
    /* D4704 800E3F04 00000000 */   nop
    /* D4708 800E3F08 21304000 */  addu       $a2, $v0, $zero
  .L800E3F0C:
    /* D470C 800E3F0C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D4710 800E3F10 2110C000 */  addu       $v0, $a2, $zero
    /* D4714 800E3F14 0800E003 */  jr         $ra
    /* D4718 800E3F18 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel unpackz
