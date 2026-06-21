.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsShapeFileLoaded__7tScreenR17tShapeInformation, 0x178

glabel IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 1660C 80025E0C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 16610 80025E10 1800B2AF */  sw         $s2, 0x18($sp)
    /* 16614 80025E14 21908000 */  addu       $s2, $a0, $zero
    /* 16618 80025E18 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1661C 80025E1C 2180A000 */  addu       $s0, $a1, $zero
    /* 16620 80025E20 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 16624 80025E24 1400B1AF */  sw         $s1, 0x14($sp)
    /* 16628 80025E28 0C00048E */  lw         $a0, 0xC($s0)
    /* 1662C 80025E2C 00000000 */  nop
    /* 16630 80025E30 35008010 */  beqz       $a0, .L80025F08
    /* 16634 80025E34 01001124 */   addiu     $s1, $zero, 0x1
    /* 16638 80025E38 B6C5030C */  jal        getasyncreadstatus
    /* 1663C 80025E3C 00000000 */   nop
    /* 16640 80025E40 21184000 */  addu       $v1, $v0, $zero
    /* 16644 80025E44 19006018 */  blez       $v1, .L80025EAC
    /* 16648 80025E48 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 1664C 80025E4C 0800028E */  lw         $v0, 0x8($s0)
    /* 16650 80025E50 00000000 */  nop
    /* 16654 80025E54 04004014 */  bnez       $v0, .L80025E68
    /* 16658 80025E58 00000000 */   nop
    /* 1665C 80025E5C 0C00048E */  lw         $a0, 0xC($s0)
    /* 16660 80025E60 90C5030C */  jal        getasyncreadadr
    /* 16664 80025E64 00000000 */   nop
  .L80025E68:
    /* 16668 80025E68 040002AE */  sw         $v0, 0x4($s0)
    /* 1666C 80025E6C 0400048E */  lw         $a0, 0x4($s0)
    /* 16670 80025E70 00000000 */  nop
    /* 16674 80025E74 3C008010 */  beqz       $a0, .L80025F68
    /* 16678 80025E78 0C0000AE */   sw        $zero, 0xC($s0)
    /* 1667C 80025E7C 2400028E */  lw         $v0, 0x24($s0)
    /* 16680 80025E80 00000000 */  nop
    /* 16684 80025E84 39004010 */  beqz       $v0, .L80025F6C
    /* 16688 80025E88 21102002 */   addu      $v0, $s1, $zero
    /* 1668C 80025E8C 0800028E */  lw         $v0, 0x8($s0)
    /* 16690 80025E90 00000000 */  nop
    /* 16694 80025E94 03004014 */  bnez       $v0, .L80025EA4
    /* 16698 80025E98 00000000 */   nop
    /* 1669C 80025E9C 5095030C */  jal        purgememadr
    /* 166A0 80025EA0 00000000 */   nop
  .L80025EA4:
    /* 166A4 80025EA4 DA970008 */  j          .L80025F68
    /* 166A8 80025EA8 040000AE */   sw        $zero, 0x4($s0)
  .L80025EAC:
    /* 166AC 80025EAC 0E006214 */  bne        $v1, $v0, .L80025EE8
    /* 166B0 80025EB0 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* 166B4 80025EB4 0C00048E */  lw         $a0, 0xC($s0)
    /* 166B8 80025EB8 90C5030C */  jal        getasyncreadadr
    /* 166BC 80025EBC 00000000 */   nop
    /* 166C0 80025EC0 04004010 */  beqz       $v0, .L80025ED4
    /* 166C4 80025EC4 21204002 */   addu      $a0, $s2, $zero
    /* 166C8 80025EC8 5095030C */  jal        purgememadr
    /* 166CC 80025ECC 21204000 */   addu      $a0, $v0, $zero
    /* 166D0 80025ED0 21204002 */  addu       $a0, $s2, $zero
  .L80025ED4:
    /* 166D4 80025ED4 14000526 */  addiu      $a1, $s0, 0x14
    /* 166D8 80025ED8 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 166DC 80025EDC 21300002 */   addu      $a2, $s0, $zero
    /* 166E0 80025EE0 DA970008 */  j          .L80025F68
    /* 166E4 80025EE4 21880000 */   addu      $s1, $zero, $zero
  .L80025EE8:
    /* 166E8 80025EE8 1F006214 */  bne        $v1, $v0, .L80025F68
    /* 166EC 80025EEC 21880000 */   addu      $s1, $zero, $zero
    /* 166F0 80025EF0 21204002 */  addu       $a0, $s2, $zero
    /* 166F4 80025EF4 14000526 */  addiu      $a1, $s0, 0x14
    /* 166F8 80025EF8 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 166FC 80025EFC 21300002 */   addu      $a2, $s0, $zero
    /* 16700 80025F00 DA970008 */  j          .L80025F68
    /* 16704 80025F04 21880000 */   addu      $s1, $zero, $zero
  .L80025F08:
    /* 16708 80025F08 2400028E */  lw         $v0, 0x24($s0)
    /* 1670C 80025F0C 00000000 */  nop
    /* 16710 80025F10 16004010 */  beqz       $v0, .L80025F6C
    /* 16714 80025F14 21102002 */   addu      $v0, $s1, $zero
    /* 16718 80025F18 0400048E */  lw         $a0, 0x4($s0)
    /* 1671C 80025F1C 00000000 */  nop
    /* 16720 80025F20 08008010 */  beqz       $a0, .L80025F44
    /* 16724 80025F24 00000000 */   nop
    /* 16728 80025F28 0800028E */  lw         $v0, 0x8($s0)
    /* 1672C 80025F2C 00000000 */  nop
    /* 16730 80025F30 03004014 */  bnez       $v0, .L80025F40
    /* 16734 80025F34 00000000 */   nop
    /* 16738 80025F38 5095030C */  jal        purgememadr
    /* 1673C 80025F3C 00000000 */   nop
  .L80025F40:
    /* 16740 80025F40 040000AE */  sw         $zero, 0x4($s0)
  .L80025F44:
    /* 16744 80025F44 240000AE */  sw         $zero, 0x24($s0)
    /* 16748 80025F48 21204002 */  addu       $a0, $s2, $zero
    /* 1674C 80025F4C 14000526 */  addiu      $a1, $s0, 0x14
    /* 16750 80025F50 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 16754 80025F54 21300002 */   addu      $a2, $s0, $zero
    /* 16758 80025F58 21204002 */  addu       $a0, $s2, $zero
    /* 1675C 80025F5C 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 16760 80025F60 21280002 */   addu      $a1, $s0, $zero
    /* 16764 80025F64 21880000 */  addu       $s1, $zero, $zero
  .L80025F68:
    /* 16768 80025F68 21102002 */  addu       $v0, $s1, $zero
  .L80025F6C:
    /* 1676C 80025F6C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 16770 80025F70 1800B28F */  lw         $s2, 0x18($sp)
    /* 16774 80025F74 1400B18F */  lw         $s1, 0x14($sp)
    /* 16778 80025F78 1000B08F */  lw         $s0, 0x10($sp)
    /* 1677C 80025F7C 0800E003 */  jr         $ra
    /* 16780 80025F80 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel IsShapeFileLoaded__7tScreenR17tShapeInformation
