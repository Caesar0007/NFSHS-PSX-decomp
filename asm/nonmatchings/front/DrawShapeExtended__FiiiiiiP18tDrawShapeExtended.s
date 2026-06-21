.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawShapeExtended__FiiiiiiP18tDrawShapeExtended, 0x104

glabel DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3EE78 8004E678 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 3EE7C 8004E67C 3800B2AF */  sw         $s2, 0x38($sp)
    /* 3EE80 8004E680 5400B28F */  lw         $s2, 0x54($sp)
    /* 3EE84 8004E684 5800AA8F */  lw         $t2, 0x58($sp)
    /* 3EE88 8004E688 21408000 */  addu       $t0, $a0, $zero
    /* 3EE8C 8004E68C 4400A5AF */  sw         $a1, 0x44($sp)
    /* 3EE90 8004E690 0800A530 */  andi       $a1, $a1, 0x8
    /* 3EE94 8004E694 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 3EE98 8004E698 3400B1AF */  sw         $s1, 0x34($sp)
    /* 3EE9C 8004E69C 3000B0AF */  sw         $s0, 0x30($sp)
    /* 3EEA0 8004E6A0 4800A6AF */  sw         $a2, 0x48($sp)
    /* 3EEA4 8004E6A4 0500A010 */  beqz       $a1, .L8004E6BC
    /* 3EEA8 8004E6A8 4C00A7AF */   sw        $a3, 0x4C($sp)
    /* 3EEAC 8004E6AC 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* 3EEB0 8004E6B0 642A438C */  lw         $v1, %lo(gHelpShapes)($v0)
    /* 3EEB4 8004E6B4 B2390108 */  j          .L8004E6C8
    /* 3EEB8 8004E6B8 40110800 */   sll       $v0, $t0, 5
  .L8004E6BC:
    /* 3EEBC 8004E6BC 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 3EEC0 8004E6C0 CC17438C */  lw         $v1, %lo(gCurrentShapes)($v0)
    /* 3EEC4 8004E6C4 40110800 */  sll        $v0, $t0, 5
  .L8004E6C8:
    /* 3EEC8 8004E6C8 21806200 */  addu       $s0, $v1, $v0
    /* 3EECC 8004E6CC 80000224 */  addiu      $v0, $zero, 0x80
    /* 3EED0 8004E6D0 5000A48F */  lw         $a0, 0x50($sp)
    /* 3EED4 8004E6D4 4400A38F */  lw         $v1, 0x44($sp)
    /* 3EED8 8004E6D8 00000000 */  nop
    /* 3EEDC 8004E6DC 00026330 */  andi       $v1, $v1, 0x200
    /* 3EEE0 8004E6E0 04006010 */  beqz       $v1, .L8004E6F4
    /* 3EEE4 8004E6E4 23484400 */   subu      $t1, $v0, $a0
    /* 3EEE8 8004E6E8 1400438D */  lw         $v1, 0x14($t2)
    /* 3EEEC 8004E6EC 40110800 */  sll        $v0, $t0, 5
    /* 3EEF0 8004E6F0 21806200 */  addu       $s0, $v1, $v0
  .L8004E6F4:
    /* 3EEF4 8004E6F4 21200002 */  addu       $a0, $s0, $zero
    /* 3EEF8 8004E6F8 4800A527 */  addiu      $a1, $sp, 0x48
    /* 3EEFC 8004E6FC 4C00A627 */  addiu      $a2, $sp, 0x4C
    /* 3EF00 8004E700 4400A727 */  addiu      $a3, $sp, 0x44
    /* 3EF04 8004E704 00140900 */  sll        $v0, $t1, 16
    /* 3EF08 8004E708 03140200 */  sra        $v0, $v0, 16
    /* 3EF0C 8004E70C 2000B127 */  addiu      $s1, $sp, 0x20
    /* 3EF10 8004E710 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3EF14 8004E714 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3EF18 8004E718 CE37010C */  jal        func_8004DF38
    /* 3EF1C 8004E71C 1800AAAF */   sw        $t2, 0x18($sp)
    /* 3EF20 8004E720 4400A58F */  lw         $a1, 0x44($sp)
    /* 3EF24 8004E724 00000000 */  nop
    /* 3EF28 8004E728 C000A230 */  andi       $v0, $a1, 0xC0
    /* 3EF2C 8004E72C 08004010 */  beqz       $v0, .L8004E750
    /* 3EF30 8004E730 21200002 */   addu      $a0, $s0, $zero
    /* 3EF34 8004E734 4800A68F */  lw         $a2, 0x48($sp)
    /* 3EF38 8004E738 4C00A78F */  lw         $a3, 0x4C($sp)
    /* 3EF3C 8004E73C 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3EF40 8004E740 9938010C */  jal        func_8004E264
    /* 3EF44 8004E744 1400B2AF */   sw        $s2, 0x14($sp)
    /* 3EF48 8004E748 D9390108 */  j          .L8004E764
    /* 3EF4C 8004E74C 00000000 */   nop
  .L8004E750:
    /* 3EF50 8004E750 4800A68F */  lw         $a2, 0x48($sp)
    /* 3EF54 8004E754 4C00A78F */  lw         $a3, 0x4C($sp)
    /* 3EF58 8004E758 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3EF5C 8004E75C 8E39010C */  jal        func_8004E638
    /* 3EF60 8004E760 1400B2AF */   sw        $s2, 0x14($sp)
  .L8004E764:
    /* 3EF64 8004E764 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 3EF68 8004E768 3800B28F */  lw         $s2, 0x38($sp)
    /* 3EF6C 8004E76C 3400B18F */  lw         $s1, 0x34($sp)
    /* 3EF70 8004E770 3000B08F */  lw         $s0, 0x30($sp)
    /* 3EF74 8004E774 0800E003 */  jr         $ra
    /* 3EF78 8004E778 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
