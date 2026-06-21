.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetStockCar__11tCarManagersR8tCarInfo, 0xBC

glabel GetStockCar__11tCarManagersR8tCarInfo
    /* 7690 80016E90 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7694 80016E94 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7698 80016E98 21888000 */  addu       $s1, $a0, $zero
    /* 769C 80016E9C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 76A0 80016EA0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 76A4 80016EA4 2190A000 */  addu       $s2, $a1, $zero
    /* 76A8 80016EA8 002C0500 */  sll        $a1, $a1, 16
    /* 76AC 80016EAC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 76B0 80016EB0 0000228E */  lw         $v0, 0x0($s1)
    /* 76B4 80016EB4 031C0500 */  sra        $v1, $a1, 16
    /* 76B8 80016EB8 2B106200 */  sltu       $v0, $v1, $v0
    /* 76BC 80016EBC 06004014 */  bnez       $v0, .L80016ED8
    /* 76C0 80016EC0 2180C000 */   addu      $s0, $a2, $zero
    /* 76C4 80016EC4 21286000 */  addu       $a1, $v1, $zero
    /* 76C8 80016EC8 D35B000C */  jal        GetGarageCar__11tCarManagersR8tCarInfos
    /* 76CC 80016ECC 21380000 */   addu      $a3, $zero, $zero
    /* 76D0 80016ED0 CD5B0008 */  j          .L80016F34
    /* 76D4 80016ED4 C80012A2 */   sb        $s2, 0xC8($s0)
  .L80016ED8:
    /* 76D8 80016ED8 21280002 */  addu       $a1, $s0, $zero
    /* 76DC 80016EDC CC000624 */  addiu      $a2, $zero, 0xCC
    /* 76E0 80016EE0 40200300 */  sll        $a0, $v1, 1
    /* 76E4 80016EE4 21208300 */  addu       $a0, $a0, $v1
    /* 76E8 80016EE8 00110400 */  sll        $v0, $a0, 4
    /* 76EC 80016EEC 21208200 */  addu       $a0, $a0, $v0
    /* 76F0 80016EF0 0400228E */  lw         $v0, 0x4($s1)
    /* 76F4 80016EF4 80200400 */  sll        $a0, $a0, 2
    /* 76F8 80016EF8 B798030C */  jal        blockmove
    /* 76FC 80016EFC 21204400 */   addu      $a0, $v0, $a0
    /* 7700 80016F00 00000282 */  lb         $v0, 0x0($s0)
    /* 7704 80016F04 00000000 */  nop
    /* 7708 80016F08 21102202 */  addu       $v0, $s1, $v0
    /* 770C 80016F0C 08024390 */  lbu        $v1, 0x208($v0)
    /* 7710 80016F10 00000282 */  lb         $v0, 0x0($s0)
    /* 7714 80016F14 00000000 */  nop
    /* 7718 80016F18 21102202 */  addu       $v0, $s1, $v0
    /* 771C 80016F1C 070003A2 */  sb         $v1, 0x7($s0)
    /* 7720 80016F20 38024290 */  lbu        $v0, 0x238($v0)
    /* 7724 80016F24 C40000A2 */  sb         $zero, 0xC4($s0)
    /* 7728 80016F28 C70000A2 */  sb         $zero, 0xC7($s0)
    /* 772C 80016F2C C60002A2 */  sb         $v0, 0xC6($s0)
    /* 7730 80016F30 C80012A2 */  sb         $s2, 0xC8($s0)
  .L80016F34:
    /* 7734 80016F34 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 7738 80016F38 1800B28F */  lw         $s2, 0x18($sp)
    /* 773C 80016F3C 1400B18F */  lw         $s1, 0x14($sp)
    /* 7740 80016F40 1000B08F */  lw         $s0, 0x10($sp)
    /* 7744 80016F44 0800E003 */  jr         $ra
    /* 7748 80016F48 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetStockCar__11tCarManagersR8tCarInfo
