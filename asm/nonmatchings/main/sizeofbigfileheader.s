.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching sizeofbigfileheader, 0x78

glabel sizeofbigfileheader
    /* D6784 800E5F84 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D6788 800E5F88 1400B1AF */  sw         $s1, 0x14($sp)
    /* D678C 800E5F8C 21888000 */  addu       $s1, $a0, $zero
    /* D6790 800E5F90 1000B0AF */  sw         $s0, 0x10($sp)
    /* D6794 800E5F94 1800BFAF */  sw         $ra, 0x18($sp)
    /* D6798 800E5F98 C797030C */  jal        typeofbigfile
    /* D679C 800E5F9C 21800000 */   addu      $s0, $zero, $zero
    /* D67A0 800E5FA0 21184000 */  addu       $v1, $v0, $zero
    /* D67A4 800E5FA4 01000224 */  addiu      $v0, $zero, 0x1
    /* D67A8 800E5FA8 05006210 */  beq        $v1, $v0, .L800E5FC0
    /* D67AC 800E5FAC 02000224 */   addiu     $v0, $zero, 0x2
    /* D67B0 800E5FB0 08006210 */  beq        $v1, $v0, .L800E5FD4
    /* D67B4 800E5FB4 21100002 */   addu      $v0, $s0, $zero
    /* D67B8 800E5FB8 FA970308 */  j          .L800E5FE8
    /* D67BC 800E5FBC 00000000 */   nop
  .L800E5FC0:
    /* D67C0 800E5FC0 02002426 */  addiu      $a0, $s1, 0x2
    /* D67C4 800E5FC4 09CC030C */  jal        getm
    /* D67C8 800E5FC8 02000524 */   addiu     $a1, $zero, 0x2
    /* D67CC 800E5FCC F9970308 */  j          .L800E5FE4
    /* D67D0 800E5FD0 04005024 */   addiu     $s0, $v0, 0x4
  .L800E5FD4:
    /* D67D4 800E5FD4 0C002426 */  addiu      $a0, $s1, 0xC
    /* D67D8 800E5FD8 09CC030C */  jal        getm
    /* D67DC 800E5FDC 04000524 */   addiu     $a1, $zero, 0x4
    /* D67E0 800E5FE0 21804000 */  addu       $s0, $v0, $zero
  .L800E5FE4:
    /* D67E4 800E5FE4 21100002 */  addu       $v0, $s0, $zero
  .L800E5FE8:
    /* D67E8 800E5FE8 1800BF8F */  lw         $ra, 0x18($sp)
    /* D67EC 800E5FEC 1400B18F */  lw         $s1, 0x14($sp)
    /* D67F0 800E5FF0 1000B08F */  lw         $s0, 0x10($sp)
    /* D67F4 800E5FF4 0800E003 */  jr         $ra
    /* D67F8 800E5FF8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel sizeofbigfileheader
