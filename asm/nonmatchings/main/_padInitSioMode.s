.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padInitSioMode, 0x334

glabel _padInitSioMode
    /* F552C 80104D2C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F5530 80104D30 1000B0AF */  sw         $s0, 0x10($sp)
    /* F5534 80104D34 21808000 */  addu       $s0, $a0, $zero
    /* F5538 80104D38 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F553C 80104D3C DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F5540 80104D40 40000224 */  addiu      $v0, $zero, 0x40
    /* F5544 80104D44 1800BFAF */  sw         $ra, 0x18($sp)
    /* F5548 80104D48 1400B1AF */  sw         $s1, 0x14($sp)
    /* F554C 80104D4C 0A0062A4 */  sh         $v0, 0xA($v1)
    /* F5550 80104D50 0D000224 */  addiu      $v0, $zero, 0xD
    /* F5554 80104D54 0A0060A4 */  sh         $zero, 0xA($v1)
    /* F5558 80104D58 080062A4 */  sh         $v0, 0x8($v1)
    /* F555C 80104D5C 88000224 */  addiu      $v0, $zero, 0x88
    /* F5560 80104D60 0E0062A4 */  sh         $v0, 0xE($v1)
    /* F5564 80104D64 E8000392 */  lbu        $v1, 0xE8($s0)
    /* F5568 80104D68 08000224 */  addiu      $v0, $zero, 0x8
    /* F556C 80104D6C 02006214 */  bne        $v1, $v0, .L80104D78
    /* F5570 80104D70 91000424 */   addiu     $a0, $zero, 0x91
    /* F5574 80104D74 50000424 */  addiu      $a0, $zero, 0x50
  .L80104D78:
    /* F5578 80104D78 FA2F040C */  jal        setRC2wait
    /* F557C 80104D7C 00000000 */   nop
    /* F5580 80104D80 1380023C */  lui        $v0, %hi(_padSioChan)
    /* F5584 80104D84 B87C428C */  lw         $v0, %lo(_padSioChan)($v0)
    /* F5588 80104D88 1380043C */  lui        $a0, %hi(D_80137CDC)
    /* F558C 80104D8C DC7C848C */  lw         $a0, %lo(D_80137CDC)($a0)
    /* F5590 80104D90 02004010 */  beqz       $v0, .L80104D9C
    /* F5594 80104D94 03100324 */   addiu     $v1, $zero, 0x1003
    /* F5598 80104D98 03300324 */  addiu      $v1, $zero, 0x3003
  .L80104D9C:
    /* F559C 80104D9C 80100200 */  sll        $v0, $v0, 2
    /* F55A0 80104DA0 0A0083A4 */  sh         $v1, 0xA($a0)
    /* F55A4 80104DA4 1380013C */  lui        $at, %hi(_padFixResult)
    /* F55A8 80104DA8 21082200 */  addu       $at, $at, $v0
    /* F55AC 80104DAC D07C228C */  lw         $v0, %lo(_padFixResult)($at)
    /* F55B0 80104DB0 1380033C */  lui        $v1, %hi(_padFixResult)
    /* F55B4 80104DB4 34004004 */  bltz       $v0, .L80104E88
    /* F55B8 80104DB8 D07C6324 */   addiu     $v1, $v1, %lo(_padFixResult)
    /* F55BC 80104DBC 1D004018 */  blez       $v0, .L80104E34
    /* F55C0 80104DC0 00000000 */   nop
    /* F55C4 80104DC4 21886000 */  addu       $s1, $v1, $zero
  .L80104DC8:
    /* F55C8 80104DC8 1380033C */  lui        $v1, %hi(_padSioChan)
    /* F55CC 80104DCC B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* F55D0 80104DD0 00000000 */  nop
    /* F55D4 80104DD4 80180300 */  sll        $v1, $v1, 2
    /* F55D8 80104DD8 21187100 */  addu       $v1, $v1, $s1
    /* F55DC 80104DDC 0000628C */  lw         $v0, 0x0($v1)
    /* F55E0 80104DE0 00000000 */  nop
    /* F55E4 80104DE4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F55E8 80104DE8 00210200 */  sll        $a0, $v0, 4
    /* F55EC 80104DEC 23208200 */  subu       $a0, $a0, $v0
    /* F55F0 80104DF0 00210400 */  sll        $a0, $a0, 4
    /* F55F4 80104DF4 000062AC */  sw         $v0, 0x0($v1)
    /* F55F8 80104DF8 0C00028E */  lw         $v0, 0xC($s0)
    /* F55FC 80104DFC 1380033C */  lui        $v1, %hi(_padFuncRecvAuto)
    /* F5600 80104E00 987C638C */  lw         $v1, %lo(_padFuncRecvAuto)($v1)
    /* F5604 80104E04 00000000 */  nop
    /* F5608 80104E08 09F86000 */  jalr       $v1
    /* F560C 80104E0C 21204400 */   addu      $a0, $v0, $a0
    /* F5610 80104E10 1380023C */  lui        $v0, %hi(_padSioChan)
    /* F5614 80104E14 B87C428C */  lw         $v0, %lo(_padSioChan)($v0)
    /* F5618 80104E18 00000000 */  nop
    /* F561C 80104E1C 80100200 */  sll        $v0, $v0, 2
    /* F5620 80104E20 21105100 */  addu       $v0, $v0, $s1
    /* F5624 80104E24 0000428C */  lw         $v0, 0x0($v0)
    /* F5628 80104E28 00000000 */  nop
    /* F562C 80104E2C E6FF401C */  bgtz       $v0, .L80104DC8
    /* F5630 80104E30 00000000 */   nop
  .L80104E34:
    /* F5634 80104E34 1380023C */  lui        $v0, %hi(_padSioChan)
    /* F5638 80104E38 B87C428C */  lw         $v0, %lo(_padSioChan)($v0)
    /* F563C 80104E3C 1380033C */  lui        $v1, %hi(_padFixResult)
    /* F5640 80104E40 D07C6324 */  addiu      $v1, $v1, %lo(_padFixResult)
    /* F5644 80104E44 80100200 */  sll        $v0, $v0, 2
    /* F5648 80104E48 21284300 */  addu       $a1, $v0, $v1
    /* F564C 80104E4C 0000A28C */  lw         $v0, 0x0($a1)
    /* F5650 80104E50 00000000 */  nop
    /* F5654 80104E54 0C004014 */  bnez       $v0, .L80104E88
    /* F5658 80104E58 FFFF0324 */   addiu     $v1, $zero, -0x1
    /* F565C 80104E5C 21200002 */  addu       $a0, $s0, $zero
    /* F5660 80104E60 1380023C */  lui        $v0, %hi(_padFuncRecvAuto)
    /* F5664 80104E64 987C428C */  lw         $v0, %lo(_padFuncRecvAuto)($v0)
    /* F5668 80104E68 00000000 */  nop
    /* F566C 80104E6C 09F84000 */  jalr       $v0
    /* F5670 80104E70 0000A3AC */   sw        $v1, 0x0($a1)
    /* F5674 80104E74 1380023C */  lui        $v0, %hi(_padFuncClrCmdNo)
    /* F5678 80104E78 9C7C428C */  lw         $v0, %lo(_padFuncClrCmdNo)($v0)
    /* F567C 80104E7C 00000000 */  nop
    /* F5680 80104E80 09F84000 */  jalr       $v0
    /* F5684 80104E84 21200002 */   addu      $a0, $s0, $zero
  .L80104E88:
    /* F5688 80104E88 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F568C 80104E8C DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F5690 80104E90 00000000 */  nop
    /* F5694 80104E94 04006294 */  lhu        $v0, 0x4($v1)
    /* F5698 80104E98 00000000 */  nop
    /* F569C 80104E9C 00024230 */  andi       $v0, $v0, 0x200
    /* F56A0 80104EA0 61004010 */  beqz       $v0, .L80105028
    /* F56A4 80104EA4 00000000 */   nop
    /* F56A8 80104EA8 0A006294 */  lhu        $v0, 0xA($v1)
    /* F56AC 80104EAC 00000000 */  nop
    /* F56B0 80104EB0 10004234 */  ori        $v0, $v0, 0x10
    /* F56B4 80104EB4 0A0062A4 */  sh         $v0, 0xA($v1)
    /* F56B8 80104EB8 04006294 */  lhu        $v0, 0x4($v1)
    /* F56BC 80104EBC 00000000 */  nop
    /* F56C0 80104EC0 00024230 */  andi       $v0, $v0, 0x200
    /* F56C4 80104EC4 54004010 */  beqz       $v0, .L80105018
    /* F56C8 80104EC8 7FFF0224 */   addiu     $v0, $zero, -0x81
  .L80104ECC:
    /* F56CC 80104ECC 0230040C */  jal        chkRC2wait
    /* F56D0 80104ED0 00000000 */   nop
    /* F56D4 80104ED4 FDFF4010 */  beqz       $v0, .L80104ECC
    /* F56D8 80104ED8 64000424 */   addiu     $a0, $zero, 0x64
    /* F56DC 80104EDC 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F56E0 80104EE0 DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F56E4 80104EE4 01000224 */  addiu      $v0, $zero, 0x1
    /* F56E8 80104EE8 FA2F040C */  jal        setRC2wait
    /* F56EC 80104EEC 000062A0 */   sb        $v0, 0x0($v1)
    /* F56F0 80104EF0 4E15040C */  jal        _padClrIntSio0
    /* F56F4 80104EF4 00000000 */   nop
    /* F56F8 80104EF8 54004010 */  beqz       $v0, .L8010504C
    /* F56FC 80104EFC 21100000 */   addu      $v0, $zero, $zero
    /* F5700 80104F00 7215040C */  jal        _padWaitRXready
    /* F5704 80104F04 00000000 */   nop
    /* F5708 80104F08 1380023C */  lui        $v0, %hi(D_80137CDC)
    /* F570C 80104F0C DC7C428C */  lw         $v0, %lo(D_80137CDC)($v0)
    /* F5710 80104F10 AE010424 */  addiu      $a0, $zero, 0x1AE
    /* F5714 80104F14 00004290 */  lbu        $v0, 0x0($v0)
    /* F5718 80104F18 FA2F040C */  jal        setRC2wait
    /* F571C 80104F1C 00000000 */   nop
    /* F5720 80104F20 CE130408 */  j          .L80104F38
    /* F5724 80104F24 00000000 */   nop
  .L80104F28:
    /* F5728 80104F28 0230040C */  jal        chkRC2wait
    /* F572C 80104F2C 00000000 */   nop
    /* F5730 80104F30 46004014 */  bnez       $v0, .L8010504C
    /* F5734 80104F34 21100000 */   addu      $v0, $zero, $zero
  .L80104F38:
    /* F5738 80104F38 1380023C */  lui        $v0, %hi(D_80137CD8)
    /* F573C 80104F3C D87C428C */  lw         $v0, %lo(D_80137CD8)($v0)
    /* F5740 80104F40 00000000 */  nop
    /* F5744 80104F44 0000428C */  lw         $v0, 0x0($v0)
    /* F5748 80104F48 00000000 */  nop
    /* F574C 80104F4C 80004230 */  andi       $v0, $v0, 0x80
    /* F5750 80104F50 F5FF4010 */  beqz       $v0, .L80104F28
    /* F5754 80104F54 3C000424 */   addiu     $a0, $zero, 0x3C
    /* F5758 80104F58 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F575C 80104F5C DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F5760 80104F60 42000224 */  addiu      $v0, $zero, 0x42
    /* F5764 80104F64 FA2F040C */  jal        setRC2wait
    /* F5768 80104F68 000062A0 */   sb        $v0, 0x0($v1)
    /* F576C 80104F6C 4E15040C */  jal        _padClrIntSio0
    /* F5770 80104F70 00000000 */   nop
    /* F5774 80104F74 35004010 */  beqz       $v0, .L8010504C
    /* F5778 80104F78 21100000 */   addu      $v0, $zero, $zero
    /* F577C 80104F7C 7215040C */  jal        _padWaitRXready
    /* F5780 80104F80 00000000 */   nop
    /* F5784 80104F84 1380023C */  lui        $v0, %hi(D_80137CDC)
    /* F5788 80104F88 DC7C428C */  lw         $v0, %lo(D_80137CDC)($v0)
    /* F578C 80104F8C AE010424 */  addiu      $a0, $zero, 0x1AE
    /* F5790 80104F90 00004290 */  lbu        $v0, 0x0($v0)
    /* F5794 80104F94 FA2F040C */  jal        setRC2wait
    /* F5798 80104F98 00000000 */   nop
    /* F579C 80104F9C ED130408 */  j          .L80104FB4
    /* F57A0 80104FA0 00000000 */   nop
  .L80104FA4:
    /* F57A4 80104FA4 0230040C */  jal        chkRC2wait
    /* F57A8 80104FA8 00000000 */   nop
    /* F57AC 80104FAC 27004014 */  bnez       $v0, .L8010504C
    /* F57B0 80104FB0 21100000 */   addu      $v0, $zero, $zero
  .L80104FB4:
    /* F57B4 80104FB4 1380023C */  lui        $v0, %hi(D_80137CD8)
    /* F57B8 80104FB8 D87C428C */  lw         $v0, %lo(D_80137CD8)($v0)
    /* F57BC 80104FBC 00000000 */  nop
    /* F57C0 80104FC0 0000428C */  lw         $v0, 0x0($v0)
    /* F57C4 80104FC4 00000000 */  nop
    /* F57C8 80104FC8 80004230 */  andi       $v0, $v0, 0x80
    /* F57CC 80104FCC F5FF4010 */  beqz       $v0, .L80104FA4
    /* F57D0 80104FD0 3C000424 */   addiu     $a0, $zero, 0x3C
    /* F57D4 80104FD4 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F57D8 80104FD8 DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F57DC 80104FDC 01000224 */  addiu      $v0, $zero, 0x1
    /* F57E0 80104FE0 FA2F040C */  jal        setRC2wait
    /* F57E4 80104FE4 000062A0 */   sb        $v0, 0x0($v1)
    /* F57E8 80104FE8 4E15040C */  jal        _padClrIntSio0
    /* F57EC 80104FEC 00000000 */   nop
    /* F57F0 80104FF0 16004010 */  beqz       $v0, .L8010504C
    /* F57F4 80104FF4 21100000 */   addu      $v0, $zero, $zero
    /* F57F8 80104FF8 7215040C */  jal        _padWaitRXready
    /* F57FC 80104FFC 00000000 */   nop
    /* F5800 80105000 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F5804 80105004 DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F5808 80105008 21100000 */  addu       $v0, $zero, $zero
    /* F580C 8010500C 00006390 */  lbu        $v1, 0x0($v1)
    /* F5810 80105010 13140408 */  j          .L8010504C
    /* F5814 80105014 00000000 */   nop
  .L80105018:
    /* F5818 80105018 1380033C */  lui        $v1, %hi(D_80137CD8)
    /* F581C 8010501C D87C638C */  lw         $v1, %lo(D_80137CD8)($v1)
    /* F5820 80105020 00000000 */  nop
    /* F5824 80105024 000062AC */  sw         $v0, 0x0($v1)
  .L80105028:
    /* F5828 80105028 50000292 */  lbu        $v0, 0x50($s0)
    /* F582C 8010502C 00000000 */  nop
    /* F5830 80105030 06004010 */  beqz       $v0, .L8010504C
    /* F5834 80105034 01000224 */   addiu     $v0, $zero, 0x1
    /* F5838 80105038 36000392 */  lbu        $v1, 0x36($s0)
    /* F583C 8010503C 00000000 */  nop
    /* F5840 80105040 02006014 */  bnez       $v1, .L8010504C
    /* F5844 80105044 21100000 */   addu      $v0, $zero, $zero
    /* F5848 80105048 01000224 */  addiu      $v0, $zero, 0x1
  .L8010504C:
    /* F584C 8010504C 1800BF8F */  lw         $ra, 0x18($sp)
    /* F5850 80105050 1400B18F */  lw         $s1, 0x14($sp)
    /* F5854 80105054 1000B08F */  lw         $s0, 0x10($sp)
    /* F5858 80105058 0800E003 */  jr         $ra
    /* F585C 8010505C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _padInitSioMode
