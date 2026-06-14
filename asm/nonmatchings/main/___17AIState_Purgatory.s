.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17AIState_Purgatory, 0x120

glabel ___17AIState_Purgatory
    /* 61E3C 8007163C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 61E40 80071640 21388000 */  addu       $a3, $a0, $zero
    /* 61E44 80071644 0580023C */  lui        $v0, %hi(_vt_17AIState_Purgatory)
    /* 61E48 80071648 1000BFAF */  sw         $ra, 0x10($sp)
    /* 61E4C 8007164C 0000E38C */  lw         $v1, 0x0($a3)
    /* 61E50 80071650 80554224 */  addiu      $v0, $v0, %lo(_vt_17AIState_Purgatory)
    /* 61E54 80071654 0400E2AC */  sw         $v0, 0x4($a3)
    /* 61E58 80071658 880760AC */  sw         $zero, 0x788($v1)
    /* 61E5C 8007165C 0000E28C */  lw         $v0, 0x0($a3)
    /* 61E60 80071660 00000000 */  nop
    /* 61E64 80071664 9C0140AC */  sw         $zero, 0x19C($v0)
    /* 61E68 80071668 0000E48C */  lw         $a0, 0x0($a3)
    /* 61E6C 8007166C 00000000 */  nop
    /* 61E70 80071670 7005828C */  lw         $v0, 0x570($a0)
    /* 61E74 80071674 FBFF0324 */  addiu      $v1, $zero, -0x5
    /* 61E78 80071678 24104300 */  and        $v0, $v0, $v1
    /* 61E7C 8007167C 700582AC */  sw         $v0, 0x570($a0)
    /* 61E80 80071680 0000E28C */  lw         $v0, 0x0($a3)
    /* 61E84 80071684 00000000 */  nop
    /* 61E88 80071688 6002428C */  lw         $v0, 0x260($v0)
    /* 61E8C 8007168C 00000000 */  nop
    /* 61E90 80071690 10004230 */  andi       $v0, $v0, 0x10
    /* 61E94 80071694 05004010 */  beqz       $v0, .L800716AC
    /* 61E98 80071698 00000000 */   nop
    /* 61E9C 8007169C 3018828F */  lw         $v0, %gp_rel(_bss_obj)($gp)
    /* 61EA0 800716A0 00000000 */  nop
    /* 61EA4 800716A4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 61EA8 800716A8 301882AF */  sw         $v0, %gp_rel(_bss_obj)($gp)
  .L800716AC:
    /* 61EAC 800716AC 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 61EB0 800716B0 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 61EB4 800716B4 00000000 */  nop
    /* 61EB8 800716B8 FFFF4424 */  addiu      $a0, $v0, -0x1
    /* 61EBC 800716BC 1180023C */  lui        $v0, %hi(Cars_gSortedList)
    /* 61EC0 800716C0 FCFA4224 */  addiu      $v0, $v0, %lo(Cars_gSortedList)
    /* 61EC4 800716C4 80180400 */  sll        $v1, $a0, 2
    /* 61EC8 800716C8 21306200 */  addu       $a2, $v1, $v0
    /* 61ECC 800716CC 0000E38C */  lw         $v1, 0x0($a3)
    /* 61ED0 800716D0 01000224 */  addiu      $v0, $zero, 0x1
    /* 61ED4 800716D4 540562AC */  sw         $v0, 0x554($v1)
    /* 61ED8 800716D8 500562AC */  sw         $v0, 0x550($v1)
  .L800716DC:
    /* 61EDC 800716DC 0E008004 */  bltz       $a0, .L80071718
    /* 61EE0 800716E0 0580023C */   lui       $v0, %hi(D_800555A0)
    /* 61EE4 800716E4 0000C38C */  lw         $v1, 0x0($a2)
    /* 61EE8 800716E8 00000000 */  nop
    /* 61EEC 800716EC 6002628C */  lw         $v0, 0x260($v1)
    /* 61EF0 800716F0 00000000 */  nop
    /* 61EF4 800716F4 00014230 */  andi       $v0, $v0, 0x100
    /* 61EF8 800716F8 03004014 */  bnez       $v0, .L80071708
    /* 61EFC 800716FC FCFFC624 */   addiu     $a2, $a2, -0x4
    /* 61F00 80071700 B7C50108 */  j          .L800716DC
    /* 61F04 80071704 FFFF8424 */   addiu     $a0, $a0, -0x1
  .L80071708:
    /* 61F08 80071708 0000E28C */  lw         $v0, 0x0($a3)
    /* 61F0C 8007170C 00000000 */  nop
    /* 61F10 80071710 780543AC */  sw         $v1, 0x578($v0)
    /* 61F14 80071714 0580023C */  lui        $v0, %hi(D_800555A0)
  .L80071718:
    /* 61F18 80071718 0000E38C */  lw         $v1, 0x0($a3)
    /* 61F1C 8007171C A0554224 */  addiu      $v0, $v0, %lo(D_800555A0)
    /* 61F20 80071720 0400E2AC */  sw         $v0, 0x4($a3)
    /* 61F24 80071724 01000224 */  addiu      $v0, $zero, 0x1
    /* 61F28 80071728 910062A0 */  sb         $v0, 0x91($v1)
    /* 61F2C 8007172C 0580023C */  lui        $v0, %hi(D_80055640)
    /* 61F30 80071730 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 61F34 80071734 0400E2AC */  sw         $v0, 0x4($a3)
    /* 61F38 80071738 0100A230 */  andi       $v0, $a1, 0x1
    /* 61F3C 8007173C 03004010 */  beqz       $v0, .L8007174C
    /* 61F40 80071740 00000000 */   nop
    /* 61F44 80071744 6B8F020C */  jal        __builtin_delete
    /* 61F48 80071748 2120E000 */   addu      $a0, $a3, $zero
  .L8007174C:
    /* 61F4C 8007174C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 61F50 80071750 00000000 */  nop
    /* 61F54 80071754 0800E003 */  jr         $ra
    /* 61F58 80071758 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17AIState_Purgatory
