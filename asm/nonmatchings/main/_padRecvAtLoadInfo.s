.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padRecvAtLoadInfo, 0x14C

glabel _padRecvAtLoadInfo
    /* F5E80 80105680 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F5E84 80105684 1000B0AF */  sw         $s0, 0x10($sp)
    /* F5E88 80105688 21808000 */  addu       $s0, $a0, $zero
    /* F5E8C 8010568C 1400BFAF */  sw         $ra, 0x14($sp)
    /* F5E90 80105690 46000392 */  lbu        $v1, 0x46($s0)
    /* F5E94 80105694 03000224 */  addiu      $v0, $zero, 0x3
    /* F5E98 80105698 1C006210 */  beq        $v1, $v0, .L8010570C
    /* F5E9C 8010569C 04006228 */   slti      $v0, $v1, 0x4
    /* F5EA0 801056A0 05004010 */  beqz       $v0, .L801056B8
    /* F5EA4 801056A4 02000224 */   addiu     $v0, $zero, 0x2
    /* F5EA8 801056A8 08006210 */  beq        $v1, $v0, .L801056CC
    /* F5EAC 801056AC 01000224 */   addiu     $v0, $zero, 0x1
    /* F5EB0 801056B0 EF150408 */  j          .L801057BC
    /* F5EB4 801056B4 00000000 */   nop
  .L801056B8:
    /* F5EB8 801056B8 04000224 */  addiu      $v0, $zero, 0x4
    /* F5EBC 801056BC 1C006210 */  beq        $v1, $v0, .L80105730
    /* F5EC0 801056C0 01000224 */   addiu     $v0, $zero, 0x1
    /* F5EC4 801056C4 EF150408 */  j          .L801057BC
    /* F5EC8 801056C8 00000000 */   nop
  .L801056CC:
    /* F5ECC 801056CC 3C00028E */  lw         $v0, 0x3C($s0)
    /* F5ED0 801056D0 3C00038E */  lw         $v1, 0x3C($s0)
    /* F5ED4 801056D4 03004290 */  lbu        $v0, 0x3($v0)
    /* F5ED8 801056D8 00000000 */  nop
    /* F5EDC 801056DC E30002A2 */  sb         $v0, 0xE3($s0)
    /* F5EE0 801056E0 04006290 */  lbu        $v0, 0x4($v1)
    /* F5EE4 801056E4 3C00038E */  lw         $v1, 0x3C($s0)
    /* F5EE8 801056E8 E60000A6 */  sh         $zero, 0xE6($s0)
    /* F5EEC 801056EC E40002A2 */  sb         $v0, 0xE4($s0)
    /* F5EF0 801056F0 05006290 */  lbu        $v0, 0x5($v1)
    /* F5EF4 801056F4 3C00038E */  lw         $v1, 0x3C($s0)
    /* F5EF8 801056F8 E90002A2 */  sb         $v0, 0xE9($s0)
    /* F5EFC 801056FC 06006290 */  lbu        $v0, 0x6($v1)
    /* F5F00 80105700 EC0000AE */  sw         $zero, 0xEC($s0)
    /* F5F04 80105704 EE150408 */  j          .L801057B8
    /* F5F08 80105708 EA0002A2 */   sb        $v0, 0xEA($s0)
  .L8010570C:
    /* F5F0C 8010570C 3C00028E */  lw         $v0, 0x3C($s0)
    /* F5F10 80105710 00000000 */  nop
    /* F5F14 80105714 04004390 */  lbu        $v1, 0x4($v0)
    /* F5F18 80105718 05004290 */  lbu        $v0, 0x5($v0)
    /* F5F1C 8010571C 470000A2 */  sb         $zero, 0x47($s0)
    /* F5F20 80105720 001A0300 */  sll        $v1, $v1, 8
    /* F5F24 80105724 21104300 */  addu       $v0, $v0, $v1
    /* F5F28 80105728 EE150408 */  j          .L801057B8
    /* F5F2C 8010572C E60002A6 */   sh        $v0, 0xE6($s0)
  .L80105730:
    /* F5F30 80105730 EC00048E */  lw         $a0, 0xEC($s0)
    /* F5F34 80105734 47000292 */  lbu        $v0, 0x47($s0)
    /* F5F38 80105738 3C00038E */  lw         $v1, 0x3C($s0)
    /* F5F3C 8010573C 01004224 */  addiu      $v0, $v0, 0x1
    /* F5F40 80105740 04006390 */  lbu        $v1, 0x4($v1)
    /* F5F44 80105744 08008424 */  addiu      $a0, $a0, 0x8
    /* F5F48 80105748 470002A2 */  sb         $v0, 0x47($s0)
    /* F5F4C 8010574C 03006324 */  addiu      $v1, $v1, 0x3
    /* F5F50 80105750 FC016330 */  andi       $v1, $v1, 0x1FC
    /* F5F54 80105754 21208300 */  addu       $a0, $a0, $v1
    /* F5F58 80105758 EA000392 */  lbu        $v1, 0xEA($s0)
    /* F5F5C 8010575C FF004230 */  andi       $v0, $v0, 0xFF
    /* F5F60 80105760 2B104300 */  sltu       $v0, $v0, $v1
    /* F5F64 80105764 03004010 */  beqz       $v0, .L80105774
    /* F5F68 80105768 EC0004AE */   sw        $a0, 0xEC($s0)
  .L8010576C:
    /* F5F6C 8010576C EF150408 */  j          .L801057BC
    /* F5F70 80105770 21100000 */   addu      $v0, $zero, $zero
  .L80105774:
    /* F5F74 80105774 F315040C */  jal        _padGetActSize
    /* F5F78 80105778 21200002 */   addu      $a0, $s0, $zero
    /* F5F7C 8010577C 81004228 */  slti       $v0, $v0, 0x81
    /* F5F80 80105780 06004014 */  bnez       $v0, .L8010579C
    /* F5F84 80105784 21200002 */   addu      $a0, $s0, $zero
    /* F5F88 80105788 FE000224 */  addiu      $v0, $zero, 0xFE
    /* F5F8C 8010578C 460002A2 */  sb         $v0, 0x46($s0)
    /* F5F90 80105790 02000224 */  addiu      $v0, $zero, 0x2
    /* F5F94 80105794 DB150408 */  j          .L8010576C
    /* F5F98 80105798 490002A2 */   sb        $v0, 0x49($s0)
  .L8010579C:
    /* F5F9C 8010579C FF000224 */  addiu      $v0, $zero, 0xFF
    /* F5FA0 801057A0 63000526 */  addiu      $a1, $s0, 0x63
    /* F5FA4 801057A4 0116040C */  jal        _padLoadActInfo
    /* F5FA8 801057A8 460002A2 */   sb        $v0, 0x46($s0)
    /* F5FAC 801057AC 02000224 */  addiu      $v0, $zero, 0x2
    /* F5FB0 801057B0 DB150408 */  j          .L8010576C
    /* F5FB4 801057B4 460002A2 */   sb        $v0, 0x46($s0)
  .L801057B8:
    /* F5FB8 801057B8 01000224 */  addiu      $v0, $zero, 0x1
  .L801057BC:
    /* F5FBC 801057BC 1400BF8F */  lw         $ra, 0x14($sp)
    /* F5FC0 801057C0 1000B08F */  lw         $s0, 0x10($sp)
    /* F5FC4 801057C4 0800E003 */  jr         $ra
    /* F5FC8 801057C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _padRecvAtLoadInfo
