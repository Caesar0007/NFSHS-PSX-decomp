.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching readfile, 0xA0

glabel readfile
    /* E46E0 800F3EE0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E46E4 800F3EE4 1000BFAF */  sw         $ra, 0x10($sp)
    /* E46E8 800F3EE8 FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* E46EC 800F3EEC FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* E46F0 800F3EF0 21480000 */  addu       $t1, $zero, $zero
    /* E46F4 800F3EF4 031E0400 */  sra        $v1, $a0, 24
    /* E46F8 800F3EF8 01000B24 */  addiu      $t3, $zero, 0x1
    /* E46FC 800F3EFC 05006B14 */  bne        $v1, $t3, .L800F3F14
    /* E4700 800F3F00 24208200 */   and       $a0, $a0, $v0
    /* E4704 800F3F04 9EE9030C */  jal        CD_Read
    /* E4708 800F3F08 00000000 */   nop
    /* E470C 800F3F0C DCCF0308 */  j          .L800F3F70
    /* E4710 800F3F10 21484000 */   addu      $t1, $v0, $zero
  .L800F3F14:
    /* E4714 800F3F14 02000224 */  addiu      $v0, $zero, 0x2
    /* E4718 800F3F18 15006214 */  bne        $v1, $v0, .L800F3F70
    /* E471C 800F3F1C 00000000 */   nop
    /* E4720 800F3F20 00600A40 */  mfc0       $t2, $12 /* handwritten instruction */
    /* E4724 800F3F24 00000000 */  nop
    /* E4728 800F3F28 FEFB0124 */  addiu      $at, $zero, -0x402
    /* E472C 800F3F2C 24404101 */  and        $t0, $t2, $at
    /* E4730 800F3F30 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* E4734 800F3F34 00000000 */  nop
    /* E4738 800F3F38 00000000 */  nop
    /* E473C 800F3F3C 00000000 */  nop
    /* E4740 800F3F40 1480033C */  lui        $v1, %hi(readcmd)
    /* E4744 800F3F44 0004628C */  lw         $v0, %lo(readcmd)($v1)
    /* E4748 800F3F48 00000000 */  nop
    /* E474C 800F3F4C 07004014 */  bnez       $v0, .L800F3F6C
    /* E4750 800F3F50 00046824 */   addiu     $t0, $v1, %lo(readcmd)
    /* E4754 800F3F54 01000924 */  addiu      $t1, $zero, 0x1
    /* E4758 800F3F58 00046BAC */  sw         $t3, %lo(readcmd)($v1)
    /* E475C 800F3F5C 040004AD */  sw         $a0, 0x4($t0)
    /* E4760 800F3F60 080005AD */  sw         $a1, 0x8($t0)
    /* E4764 800F3F64 0C0006AD */  sw         $a2, 0xC($t0)
    /* E4768 800F3F68 100007AD */  sw         $a3, 0x10($t0)
  .L800F3F6C:
    /* E476C 800F3F6C 00608A40 */  mtc0       $t2, $12 /* handwritten instruction */
  .L800F3F70:
    /* E4770 800F3F70 1000BF8F */  lw         $ra, 0x10($sp)
    /* E4774 800F3F74 21102001 */  addu       $v0, $t1, $zero
    /* E4778 800F3F78 0800E003 */  jr         $ra
    /* E477C 800F3F7C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel readfile
