.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_sync, 0x280

glabel CD_sync
    /* F7DDC 801075DC C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* F7DE0 801075E0 3000B6AF */  sw         $s6, 0x30($sp)
    /* F7DE4 801075E4 21B08000 */  addu       $s6, $a0, $zero
    /* F7DE8 801075E8 3400B7AF */  sw         $s7, 0x34($sp)
    /* F7DEC 801075EC 21B8A000 */  addu       $s7, $a1, $zero
    /* F7DF0 801075F0 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* F7DF4 801075F4 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* F7DF8 801075F8 3800BEAF */  sw         $fp, 0x38($sp)
    /* F7DFC 801075FC 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* F7E00 80107600 2800B4AF */  sw         $s4, 0x28($sp)
    /* F7E04 80107604 2400B3AF */  sw         $s3, 0x24($sp)
    /* F7E08 80107608 2000B2AF */  sw         $s2, 0x20($sp)
    /* F7E0C 8010760C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* F7E10 80107610 C7C8030C */  jal        VSync
    /* F7E14 80107614 1800B0AF */   sw        $s0, 0x18($sp)
    /* F7E18 80107618 14801E3C */  lui        $fp, %hi(CD_comstr)
    /* F7E1C 8010761C 6CBFDE27 */  addiu      $fp, $fp, %lo(CD_comstr)
    /* F7E20 80107620 1480143C */  lui        $s4, %hi(CD_intstr)
    /* F7E24 80107624 ECBF9426 */  addiu      $s4, $s4, %lo(CD_intstr)
    /* F7E28 80107628 1480123C */  lui        $s2, %hi(D_8013C224)
    /* F7E2C 8010762C 24C25226 */  addiu      $s2, $s2, %lo(D_8013C224)
    /* F7E30 80107630 01005526 */  addiu      $s5, $s2, 0x1
    /* F7E34 80107634 02001324 */  addiu      $s3, $zero, 0x2
    /* F7E38 80107638 C0034224 */  addiu      $v0, $v0, 0x3C0
    /* F7E3C 8010763C 1580013C */  lui        $at, %hi(D_801489B4)
    /* F7E40 80107640 B48922AC */  sw         $v0, %lo(D_801489B4)($at)
    /* F7E44 80107644 0580023C */  lui        $v0, %hi(D_800577FC)
    /* F7E48 80107648 FC774224 */  addiu      $v0, $v0, %lo(D_800577FC)
    /* F7E4C 8010764C 1580013C */  lui        $at, %hi(D_801489B8)
    /* F7E50 80107650 B88920AC */  sw         $zero, %lo(D_801489B8)($at)
    /* F7E54 80107654 1580013C */  lui        $at, %hi(D_801489BC)
    /* F7E58 80107658 BC8922AC */  sw         $v0, %lo(D_801489BC)($at)
  .L8010765C:
    /* F7E5C 8010765C C7C8030C */  jal        VSync
    /* F7E60 80107660 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F7E64 80107664 1580033C */  lui        $v1, %hi(D_801489B4)
    /* F7E68 80107668 B489638C */  lw         $v1, %lo(D_801489B4)($v1)
    /* F7E6C 8010766C 00000000 */  nop
    /* F7E70 80107670 2A186200 */  slt        $v1, $v1, $v0
    /* F7E74 80107674 0C006014 */  bnez       $v1, .L801076A8
    /* F7E78 80107678 00000000 */   nop
    /* F7E7C 8010767C 1580023C */  lui        $v0, %hi(D_801489B8)
    /* F7E80 80107680 B889428C */  lw         $v0, %lo(D_801489B8)($v0)
    /* F7E84 80107684 00000000 */  nop
    /* F7E88 80107688 21184000 */  addu       $v1, $v0, $zero
    /* F7E8C 8010768C 01004224 */  addiu      $v0, $v0, 0x1
    /* F7E90 80107690 1580013C */  lui        $at, %hi(D_801489B8)
    /* F7E94 80107694 B88922AC */  sw         $v0, %lo(D_801489B8)($at)
    /* F7E98 80107698 3C00023C */  lui        $v0, (0x3C0000 >> 16)
    /* F7E9C 8010769C 2A104300 */  slt        $v0, $v0, $v1
    /* F7EA0 801076A0 1B004010 */  beqz       $v0, .L80107710
    /* F7EA4 801076A4 00000000 */   nop
  .L801076A8:
    /* F7EA8 801076A8 0580043C */  lui        $a0, %hi(D_80057774)
    /* F7EAC 801076AC 33A0030C */  jal        puts
    /* F7EB0 801076B0 74778424 */   addiu     $a0, $a0, %lo(D_80057774)
    /* F7EB4 801076B4 00004492 */  lbu        $a0, 0x0($s2)
    /* F7EB8 801076B8 01004292 */  lbu        $v0, 0x1($s2)
    /* F7EBC 801076BC 1580053C */  lui        $a1, %hi(D_801489BC)
    /* F7EC0 801076C0 BC89A58C */  lw         $a1, %lo(D_801489BC)($a1)
    /* F7EC4 801076C4 80100200 */  sll        $v0, $v0, 2
    /* F7EC8 801076C8 21105400 */  addu       $v0, $v0, $s4
    /* F7ECC 801076CC 80200400 */  sll        $a0, $a0, 2
    /* F7ED0 801076D0 0000438C */  lw         $v1, 0x0($v0)
    /* F7ED4 801076D4 1480023C */  lui        $v0, %hi(CD_com)
    /* F7ED8 801076D8 65BF4290 */  lbu        $v0, %lo(CD_com)($v0)
    /* F7EDC 801076DC 21209400 */  addu       $a0, $a0, $s4
    /* F7EE0 801076E0 80100200 */  sll        $v0, $v0, 2
    /* F7EE4 801076E4 21105E00 */  addu       $v0, $v0, $fp
    /* F7EE8 801076E8 1000A3AF */  sw         $v1, 0x10($sp)
    /* F7EEC 801076EC 0000468C */  lw         $a2, 0x0($v0)
    /* F7EF0 801076F0 0000878C */  lw         $a3, 0x0($a0)
    /* F7EF4 801076F4 0580043C */  lui        $a0, %hi(D_80057784)
    /* F7EF8 801076F8 2B0A040C */  jal        printf
    /* F7EFC 801076FC 84778424 */   addiu     $a0, $a0, %lo(D_80057784)
    /* F7F00 80107700 CC1F040C */  jal        CD_flush
    /* F7F04 80107704 00000000 */   nop
    /* F7F08 80107708 C51D0408 */  j          .L80107714
    /* F7F0C 8010770C FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80107710:
    /* F7F10 80107710 21100000 */  addu       $v0, $zero, $zero
  .L80107714:
    /* F7F14 80107714 45004014 */  bnez       $v0, .L8010782C
    /* F7F18 80107718 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F7F1C 8010771C 50CA030C */  jal        CheckCallback
    /* F7F20 80107720 00000000 */   nop
    /* F7F24 80107724 29004010 */  beqz       $v0, .L801077CC
    /* F7F28 80107728 00000000 */   nop
    /* F7F2C 8010772C 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F7F30 80107730 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F7F34 80107734 00000000 */  nop
    /* F7F38 80107738 00004290 */  lbu        $v0, 0x0($v0)
    /* F7F3C 8010773C 00000000 */  nop
    /* F7F40 80107740 03005130 */  andi       $s1, $v0, 0x3
  .L80107744:
    /* F7F44 80107744 201C040C */  jal        func_80107080
    /* F7F48 80107748 00000000 */   nop
    /* F7F4C 8010774C 21804000 */  addu       $s0, $v0, $zero
    /* F7F50 80107750 1A000012 */  beqz       $s0, .L801077BC
    /* F7F54 80107754 04000232 */   andi      $v0, $s0, 0x4
    /* F7F58 80107758 0B004010 */  beqz       $v0, .L80107788
    /* F7F5C 8010775C 02000232 */   andi      $v0, $s0, 0x2
    /* F7F60 80107760 1480023C */  lui        $v0, %hi(CD_cbready)
    /* F7F64 80107764 4CBF428C */  lw         $v0, %lo(CD_cbready)($v0)
    /* F7F68 80107768 00000000 */  nop
    /* F7F6C 8010776C 05004010 */  beqz       $v0, .L80107784
    /* F7F70 80107770 00000000 */   nop
    /* F7F74 80107774 0000A492 */  lbu        $a0, 0x0($s5)
    /* F7F78 80107778 1580053C */  lui        $a1, %hi(D_801489A4)
    /* F7F7C 8010777C 09F84000 */  jalr       $v0
    /* F7F80 80107780 A489A524 */   addiu     $a1, $a1, %lo(D_801489A4)
  .L80107784:
    /* F7F84 80107784 02000232 */  andi       $v0, $s0, 0x2
  .L80107788:
    /* F7F88 80107788 EEFF4010 */  beqz       $v0, .L80107744
    /* F7F8C 8010778C 00000000 */   nop
    /* F7F90 80107790 1480023C */  lui        $v0, %hi(CD_cbsync)
    /* F7F94 80107794 48BF428C */  lw         $v0, %lo(CD_cbsync)($v0)
    /* F7F98 80107798 00000000 */  nop
    /* F7F9C 8010779C E9FF4010 */  beqz       $v0, .L80107744
    /* F7FA0 801077A0 00000000 */   nop
    /* F7FA4 801077A4 00004492 */  lbu        $a0, 0x0($s2)
    /* F7FA8 801077A8 1580053C */  lui        $a1, %hi(D_8014899C)
    /* F7FAC 801077AC 09F84000 */  jalr       $v0
    /* F7FB0 801077B0 9C89A524 */   addiu     $a1, $a1, %lo(D_8014899C)
    /* F7FB4 801077B4 D11D0408 */  j          .L80107744
    /* F7FB8 801077B8 00000000 */   nop
  .L801077BC:
    /* F7FBC 801077BC 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F7FC0 801077C0 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F7FC4 801077C4 00000000 */  nop
    /* F7FC8 801077C8 000051A0 */  sb         $s1, 0x0($v0)
  .L801077CC:
    /* F7FCC 801077CC 00004292 */  lbu        $v0, 0x0($s2)
    /* F7FD0 801077D0 00000000 */  nop
    /* F7FD4 801077D4 FF004630 */  andi       $a2, $v0, 0xFF
    /* F7FD8 801077D8 0300D310 */  beq        $a2, $s3, .L801077E8
    /* F7FDC 801077DC 05000224 */   addiu     $v0, $zero, 0x5
    /* F7FE0 801077E0 1000C214 */  bne        $a2, $v0, .L80107824
    /* F7FE4 801077E4 00000000 */   nop
  .L801077E8:
    /* F7FE8 801077E8 000053A2 */  sb         $s3, 0x0($s2)
    /* F7FEC 801077EC 2128E002 */  addu       $a1, $s7, $zero
    /* F7FF0 801077F0 1580043C */  lui        $a0, %hi(D_8014899C)
    /* F7FF4 801077F4 9C898424 */  addiu      $a0, $a0, %lo(D_8014899C)
    /* F7FF8 801077F8 0800A010 */  beqz       $a1, .L8010781C
    /* F7FFC 801077FC 07000324 */   addiu     $v1, $zero, 0x7
    /* F8000 80107800 FFFF0724 */  addiu      $a3, $zero, -0x1
  .L80107804:
    /* F8004 80107804 00008290 */  lbu        $v0, 0x0($a0)
    /* F8008 80107808 01008424 */  addiu      $a0, $a0, 0x1
    /* F800C 8010780C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* F8010 80107810 0000A2A0 */  sb         $v0, 0x0($a1)
    /* F8014 80107814 FBFF6714 */  bne        $v1, $a3, .L80107804
    /* F8018 80107818 0100A524 */   addiu     $a1, $a1, 0x1
  .L8010781C:
    /* F801C 8010781C 0B1E0408 */  j          .L8010782C
    /* F8020 80107820 2110C000 */   addu      $v0, $a2, $zero
  .L80107824:
    /* F8024 80107824 8DFFC012 */  beqz       $s6, .L8010765C
    /* F8028 80107828 21100000 */   addu      $v0, $zero, $zero
  .L8010782C:
    /* F802C 8010782C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* F8030 80107830 3800BE8F */  lw         $fp, 0x38($sp)
    /* F8034 80107834 3400B78F */  lw         $s7, 0x34($sp)
    /* F8038 80107838 3000B68F */  lw         $s6, 0x30($sp)
    /* F803C 8010783C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* F8040 80107840 2800B48F */  lw         $s4, 0x28($sp)
    /* F8044 80107844 2400B38F */  lw         $s3, 0x24($sp)
    /* F8048 80107848 2000B28F */  lw         $s2, 0x20($sp)
    /* F804C 8010784C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F8050 80107850 1800B08F */  lw         $s0, 0x18($sp)
    /* F8054 80107854 0800E003 */  jr         $ra
    /* F8058 80107858 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CD_sync
