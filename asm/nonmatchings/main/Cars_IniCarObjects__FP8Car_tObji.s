.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_IniCarObjects__FP8Car_tObji, 0x3EC

glabel Cars_IniCarObjects__FP8Car_tObji
    /* 7A588 80089D88 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 7A58C 80089D8C 3800B0AF */  sw         $s0, 0x38($sp)
    /* 7A590 80089D90 21808000 */  addu       $s0, $a0, $zero
    /* 7A594 80089D94 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 7A598 80089D98 4000BFAF */  sw         $ra, 0x40($sp)
    /* 7A59C 80089D9C 1F18020C */  jal        Cars_InitStats__FP8Car_tObj
    /* 7A5A0 80089DA0 2188A000 */   addu      $s1, $a1, $zero
    /* 7A5A4 80089DA4 1180023C */  lui        $v0, %hi(D_801135B0)
    /* 7A5A8 80089DA8 800200AE */  sw         $zero, 0x280($s0)
    /* 7A5AC 80089DAC 840200AE */  sw         $zero, 0x284($s0)
    /* 7A5B0 80089DB0 B035428C */  lw         $v0, %lo(D_801135B0)($v0)
    /* 7A5B4 80089DB4 00000000 */  nop
    /* 7A5B8 80089DB8 2A102202 */  slt        $v0, $s1, $v0
    /* 7A5BC 80089DBC 34004010 */  beqz       $v0, .L80089E90
    /* 7A5C0 80089DC0 21200002 */   addu      $a0, $s0, $zero
    /* 7A5C4 80089DC4 8802028E */  lw         $v0, 0x288($s0)
    /* 7A5C8 80089DC8 00000000 */  nop
    /* 7A5CC 80089DCC 0000438C */  lw         $v1, 0x0($v0)
    /* 7A5D0 80089DD0 21000224 */  addiu      $v0, $zero, 0x21
    /* 7A5D4 80089DD4 0D006210 */  beq        $v1, $v0, .L80089E0C
    /* 7A5D8 80089DD8 24000224 */   addiu     $v0, $zero, 0x24
    /* 7A5DC 80089DDC 0B006210 */  beq        $v1, $v0, .L80089E0C
    /* 7A5E0 80089DE0 26000224 */   addiu     $v0, $zero, 0x26
    /* 7A5E4 80089DE4 09006210 */  beq        $v1, $v0, .L80089E0C
    /* 7A5E8 80089DE8 27000224 */   addiu     $v0, $zero, 0x27
    /* 7A5EC 80089DEC 07006210 */  beq        $v1, $v0, .L80089E0C
    /* 7A5F0 80089DF0 2F000224 */   addiu     $v0, $zero, 0x2F
    /* 7A5F4 80089DF4 05006210 */  beq        $v1, $v0, .L80089E0C
    /* 7A5F8 80089DF8 30000224 */   addiu     $v0, $zero, 0x30
    /* 7A5FC 80089DFC 03006210 */  beq        $v1, $v0, .L80089E0C
    /* 7A600 80089E00 31000224 */   addiu     $v0, $zero, 0x31
    /* 7A604 80089E04 03006214 */  bne        $v1, $v0, .L80089E14
    /* 7A608 80089E08 22000224 */   addiu     $v0, $zero, 0x22
  .L80089E0C:
    /* 7A60C 80089E0C 99270208 */  j          .L80089E64
    /* 7A610 80089E10 1900063C */   lui       $a2, (0x190000 >> 16)
  .L80089E14:
    /* 7A614 80089E14 09006210 */  beq        $v1, $v0, .L80089E3C
    /* 7A618 80089E18 25000224 */   addiu     $v0, $zero, 0x25
    /* 7A61C 80089E1C 07006210 */  beq        $v1, $v0, .L80089E3C
    /* 7A620 80089E20 29000224 */   addiu     $v0, $zero, 0x29
    /* 7A624 80089E24 05006210 */  beq        $v1, $v0, .L80089E3C
    /* 7A628 80089E28 2B000224 */   addiu     $v0, $zero, 0x2B
    /* 7A62C 80089E2C 03006210 */  beq        $v1, $v0, .L80089E3C
    /* 7A630 80089E30 2C000224 */   addiu     $v0, $zero, 0x2C
    /* 7A634 80089E34 03006214 */  bne        $v1, $v0, .L80089E44
    /* 7A638 80089E38 00000000 */   nop
  .L80089E3C:
    /* 7A63C 80089E3C 99270208 */  j          .L80089E64
    /* 7A640 80089E40 1100063C */   lui       $a2, (0x110000 >> 16)
  .L80089E44:
    /* 7A644 80089E44 6404028E */  lw         $v0, 0x464($s0)
    /* 7A648 80089E48 00000000 */  nop
    /* 7A64C 80089E4C 0000428C */  lw         $v0, 0x0($v0)
    /* 7A650 80089E50 00000000 */  nop
    /* 7A654 80089E54 02004104 */  bgez       $v0, .L80089E60
    /* 7A658 80089E58 00000000 */   nop
    /* 7A65C 80089E5C 7F004224 */  addiu      $v0, $v0, 0x7F
  .L80089E60:
    /* 7A660 80089E60 C3310200 */  sra        $a2, $v0, 7
  .L80089E64:
    /* 7A664 80089E64 3401028E */  lw         $v0, 0x134($s0)
    /* 7A668 80089E68 21200002 */  addu       $a0, $s0, $zero
    /* 7A66C 80089E6C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 7A670 80089E70 3801028E */  lw         $v0, 0x138($s0)
    /* 7A674 80089E74 00012536 */  ori        $a1, $s1, 0x100
    /* 7A678 80089E78 1400A2AF */  sw         $v0, 0x14($sp)
    /* 7A67C 80089E7C 3C01028E */  lw         $v0, 0x13C($s0)
    /* 7A680 80089E80 2138C000 */  addu       $a3, $a2, $zero
    /* 7A684 80089E84 FA86020C */  jal        Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
    /* 7A688 80089E88 1800A2AF */   sw        $v0, 0x18($sp)
    /* 7A68C 80089E8C 21200002 */  addu       $a0, $s0, $zero
  .L80089E90:
    /* 7A690 80089E90 3000A527 */  addiu      $a1, $sp, 0x30
    /* 7A694 80089E94 D126020C */  jal        Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
    /* 7A698 80089E98 2000A627 */   addiu     $a2, $sp, 0x20
    /* 7A69C 80089E9C 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 7A6A0 80089EA0 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 7A6A4 80089EA4 3000A38F */  lw         $v1, 0x30($sp)
    /* 7A6A8 80089EA8 C2170400 */  srl        $v0, $a0, 31
    /* 7A6AC 80089EAC 21108200 */  addu       $v0, $a0, $v0
    /* 7A6B0 80089EB0 43100200 */  sra        $v0, $v0, 1
    /* 7A6B4 80089EB4 2A104300 */  slt        $v0, $v0, $v1
    /* 7A6B8 80089EB8 03004010 */  beqz       $v0, .L80089EC8
    /* 7A6BC 80089EBC 23108300 */   subu      $v0, $a0, $v1
    /* 7A6C0 80089EC0 B3270208 */  j          .L80089ECC
    /* 7A6C4 80089EC4 4C0302AE */   sw        $v0, 0x34C($s0)
  .L80089EC8:
    /* 7A6C8 80089EC8 4C0303AE */  sw         $v1, 0x34C($s0)
  .L80089ECC:
    /* 7A6CC 80089ECC 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 7A6D0 80089ED0 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 7A6D4 80089ED4 00000000 */  nop
    /* 7A6D8 80089ED8 05004010 */  beqz       $v0, .L80089EF0
    /* 7A6DC 80089EDC 21200002 */   addu      $a0, $s0, $zero
    /* 7A6E0 80089EE0 3000A58F */  lw         $a1, 0x30($sp)
    /* 7A6E4 80089EE4 2000A627 */  addiu      $a2, $sp, 0x20
    /* 7A6E8 80089EE8 BF270208 */  j          .L80089EFC
    /* 7A6EC 80089EEC FFFF0724 */   addiu     $a3, $zero, -0x1
  .L80089EF0:
    /* 7A6F0 80089EF0 3000A58F */  lw         $a1, 0x30($sp)
    /* 7A6F4 80089EF4 2000A627 */  addiu      $a2, $sp, 0x20
    /* 7A6F8 80089EF8 01000724 */  addiu      $a3, $zero, 0x1
  .L80089EFC:
    /* 7A6FC 80089EFC E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 7A700 80089F00 00000000 */   nop
    /* 7A704 80089F04 01000224 */  addiu      $v0, $zero, 0x1
    /* 7A708 80089F08 680202AE */  sw         $v0, 0x268($s0)
    /* 7A70C 80089F0C 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 7A710 80089F10 640200AE */  sw         $zero, 0x264($s0)
    /* 7A714 80089F14 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 7A718 80089F18 00000000 */  nop
    /* 7A71C 80089F1C 08004010 */  beqz       $v0, .L80089F40
    /* 7A720 80089F20 00000000 */   nop
    /* 7A724 80089F24 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 7A728 80089F28 C8C74294 */  lhu        $v0, %lo(gNumSlices)($v0)
    /* 7A72C 80089F2C 08000396 */  lhu        $v1, 0x8($s0)
    /* 7A730 80089F30 00000000 */  nop
    /* 7A734 80089F34 23104300 */  subu       $v0, $v0, $v1
    /* 7A738 80089F38 D1270208 */  j          .L80089F44
    /* 7A73C 80089F3C FFFF4224 */   addiu     $v0, $v0, -0x1
  .L80089F40:
    /* 7A740 80089F40 08000296 */  lhu        $v0, 0x8($s0)
  .L80089F44:
    /* 7A744 80089F44 00000000 */  nop
    /* 7A748 80089F48 040002A6 */  sh         $v0, 0x4($s0)
    /* 7A74C 80089F4C D825020C */  jal        Cars_FindTotalSlice__FP8Car_tObj
    /* 7A750 80089F50 21200002 */   addu      $a0, $s0, $zero
    /* 7A754 80089F54 21200000 */  addu       $a0, $zero, $zero
    /* 7A758 80089F58 0100063C */  lui        $a2, (0x10000 >> 16)
    /* 7A75C 80089F5C 01000524 */  addiu      $a1, $zero, 0x1
    /* 7A760 80089F60 21180002 */  addu       $v1, $s0, $zero
    /* 7A764 80089F64 2110C000 */  addu       $v0, $a2, $zero
    /* 7A768 80089F68 600400AE */  sw         $zero, 0x460($s0)
    /* 7A76C 80089F6C 5C0400AE */  sw         $zero, 0x45C($s0)
    /* 7A770 80089F70 580400A2 */  sb         $zero, 0x458($s0)
    /* 7A774 80089F74 590400A2 */  sb         $zero, 0x459($s0)
    /* 7A778 80089F78 700202AE */  sw         $v0, 0x270($s0)
    /* 7A77C 80089F7C 300702AE */  sw         $v0, 0x730($s0)
    /* 7A780 80089F80 340700AE */  sw         $zero, 0x734($s0)
    /* 7A784 80089F84 EC0300AE */  sw         $zero, 0x3EC($s0)
    /* 7A788 80089F88 740200AE */  sw         $zero, 0x274($s0)
    /* 7A78C 80089F8C 780200AE */  sw         $zero, 0x278($s0)
    /* 7A790 80089F90 000400AE */  sw         $zero, 0x400($s0)
    /* 7A794 80089F94 040400AE */  sw         $zero, 0x404($s0)
    /* 7A798 80089F98 080400AE */  sw         $zero, 0x408($s0)
    /* 7A79C 80089F9C F40300AE */  sw         $zero, 0x3F4($s0)
    /* 7A7A0 80089FA0 F80300AE */  sw         $zero, 0x3F8($s0)
    /* 7A7A4 80089FA4 FC0300AE */  sw         $zero, 0x3FC($s0)
    /* 7A7A8 80089FA8 0C0400AE */  sw         $zero, 0x40C($s0)
    /* 7A7AC 80089FAC 100400AE */  sw         $zero, 0x410($s0)
    /* 7A7B0 80089FB0 140400AE */  sw         $zero, 0x414($s0)
    /* 7A7B4 80089FB4 300400AE */  sw         $zero, 0x430($s0)
    /* 7A7B8 80089FB8 340400AE */  sw         $zero, 0x434($s0)
    /* 7A7BC 80089FBC 380400AE */  sw         $zero, 0x438($s0)
    /* 7A7C0 80089FC0 180400AE */  sw         $zero, 0x418($s0)
    /* 7A7C4 80089FC4 1C0400AE */  sw         $zero, 0x41C($s0)
    /* 7A7C8 80089FC8 200400AE */  sw         $zero, 0x420($s0)
    /* 7A7CC 80089FCC 240400AE */  sw         $zero, 0x424($s0)
    /* 7A7D0 80089FD0 280400AE */  sw         $zero, 0x428($s0)
    /* 7A7D4 80089FD4 2C0400AE */  sw         $zero, 0x42C($s0)
  .L80089FD8:
    /* 7A7D8 80089FD8 A40260AC */  sw         $zero, 0x2A4($v1)
    /* 7A7DC 80089FDC 8C0260AC */  sw         $zero, 0x28C($v1)
    /* 7A7E0 80089FE0 900260AC */  sw         $zero, 0x290($v1)
    /* 7A7E4 80089FE4 940260AC */  sw         $zero, 0x294($v1)
    /* 7A7E8 80089FE8 980260AC */  sw         $zero, 0x298($v1)
    /* 7A7EC 80089FEC 9C0266AC */  sw         $a2, 0x29C($v1)
    /* 7A7F0 80089FF0 A00260AC */  sw         $zero, 0x2A0($v1)
    /* 7A7F4 80089FF4 A80260AC */  sw         $zero, 0x2A8($v1)
    /* 7A7F8 80089FF8 AC0260AC */  sw         $zero, 0x2AC($v1)
    /* 7A7FC 80089FFC B00260AC */  sw         $zero, 0x2B0($v1)
    /* 7A800 8008A000 B40260AC */  sw         $zero, 0x2B4($v1)
    /* 7A804 8008A004 B80265AC */  sw         $a1, 0x2B8($v1)
    /* 7A808 8008A008 01008424 */  addiu      $a0, $a0, 0x1
    /* 7A80C 8008A00C 04008228 */  slti       $v0, $a0, 0x4
    /* 7A810 8008A010 F1FF4014 */  bnez       $v0, .L80089FD8
    /* 7A814 8008A014 30006324 */   addiu     $v1, $v1, 0x30
    /* 7A818 8008A018 01000224 */  addiu      $v0, $zero, 0x1
    /* 7A81C 8008A01C 3E0402A2 */  sb         $v0, 0x43E($s0)
    /* 7A820 8008A020 420402A2 */  sb         $v0, 0x442($s0)
    /* 7A824 8008A024 410402A2 */  sb         $v0, 0x441($s0)
    /* 7A828 8008A028 1180023C */  lui        $v0, %hi(D_80113240)
    /* 7A82C 8008A02C 680400AE */  sw         $zero, 0x468($s0)
    /* 7A830 8008A030 6C0400AE */  sw         $zero, 0x46C($s0)
    /* 7A834 8008A034 700400AE */  sw         $zero, 0x470($s0)
    /* 7A838 8008A038 740400AE */  sw         $zero, 0x474($s0)
    /* 7A83C 8008A03C 780400AE */  sw         $zero, 0x478($s0)
    /* 7A840 8008A040 840400AE */  sw         $zero, 0x484($s0)
    /* 7A844 8008A044 880400AE */  sw         $zero, 0x488($s0)
    /* 7A848 8008A048 3C0400A2 */  sb         $zero, 0x43C($s0)
    /* 7A84C 8008A04C 3D0400A2 */  sb         $zero, 0x43D($s0)
    /* 7A850 8008A050 4C0400AE */  sw         $zero, 0x44C($s0)
    /* 7A854 8008A054 430400A2 */  sb         $zero, 0x443($s0)
    /* 7A858 8008A058 440400A2 */  sb         $zero, 0x444($s0)
    /* 7A85C 8008A05C 3F0400A2 */  sb         $zero, 0x43F($s0)
    /* 7A860 8008A060 400400A2 */  sb         $zero, 0x440($s0)
    /* 7A864 8008A064 500400AE */  sw         $zero, 0x450($s0)
    /* 7A868 8008A068 450400A2 */  sb         $zero, 0x445($s0)
    /* 7A86C 8008A06C 460400A2 */  sb         $zero, 0x446($s0)
    /* 7A870 8008A070 4032428C */  lw         $v0, %lo(D_80113240)($v0)
    /* 7A874 8008A074 00000000 */  nop
    /* 7A878 8008A078 03004010 */  beqz       $v0, .L8008A088
    /* 7A87C 8008A07C 03000224 */   addiu     $v0, $zero, 0x3
    /* 7A880 8008A080 23280208 */  j          .L8008A08C
    /* 7A884 8008A084 470402A2 */   sb        $v0, 0x447($s0)
  .L8008A088:
    /* 7A888 8008A088 470400A2 */  sb         $zero, 0x447($s0)
  .L8008A08C:
    /* 7A88C 8008A08C 21200002 */  addu       $a0, $s0, $zero
    /* 7A890 8008A090 490400A2 */  sb         $zero, 0x449($s0)
    /* 7A894 8008A094 480400A2 */  sb         $zero, 0x448($s0)
    /* 7A898 8008A098 540400AE */  sw         $zero, 0x454($s0)
    /* 7A89C 8008A09C 4A0400A2 */  sb         $zero, 0x44A($s0)
    /* 7A8A0 8008A0A0 4B0400A2 */  sb         $zero, 0x44B($s0)
    /* 7A8A4 8008A0A4 7C0400AE */  sw         $zero, 0x47C($s0)
    /* 7A8A8 8008A0A8 8C0400AE */  sw         $zero, 0x48C($s0)
    /* 7A8AC 8008A0AC C00400AE */  sw         $zero, 0x4C0($s0)
    /* 7A8B0 8008A0B0 840400AE */  sw         $zero, 0x484($s0)
    /* 7A8B4 8008A0B4 7B9C010C */  jal        AIInit_RestartAICar__FP8Car_tObj
    /* 7A8B8 8008A0B8 880400AE */   sw        $zero, 0x488($s0)
    /* 7A8BC 8008A0BC 8802028E */  lw         $v0, 0x288($s0)
    /* 7A8C0 8008A0C0 940700AE */  sw         $zero, 0x794($s0)
    /* 7A8C4 8008A0C4 900700AE */  sw         $zero, 0x790($s0)
    /* 7A8C8 8008A0C8 880700AE */  sw         $zero, 0x788($s0)
    /* 7A8CC 8008A0CC 8C0700AE */  sw         $zero, 0x78C($s0)
    /* 7A8D0 8008A0D0 7C0100A6 */  sh         $zero, 0x17C($s0)
    /* 7A8D4 8008A0D4 8C0100AE */  sw         $zero, 0x18C($s0)
    /* 7A8D8 8008A0D8 AC0100AE */  sw         $zero, 0x1AC($s0)
    /* 7A8DC 8008A0DC 900100AE */  sw         $zero, 0x190($s0)
    /* 7A8E0 8008A0E0 940100AE */  sw         $zero, 0x194($s0)
    /* 7A8E4 8008A0E4 9C0100AE */  sw         $zero, 0x19C($s0)
    /* 7A8E8 8008A0E8 840100AE */  sw         $zero, 0x184($s0)
    /* 7A8EC 8008A0EC 740100AE */  sw         $zero, 0x174($s0)
    /* 7A8F0 8008A0F0 C00000AE */  sw         $zero, 0xC0($s0)
    /* 7A8F4 8008A0F4 480800AE */  sw         $zero, 0x848($s0)
    /* 7A8F8 8008A0F8 4C0800AE */  sw         $zero, 0x84C($s0)
    /* 7A8FC 8008A0FC 500800AE */  sw         $zero, 0x850($s0)
    /* 7A900 8008A100 540800AE */  sw         $zero, 0x854($s0)
    /* 7A904 8008A104 580800AE */  sw         $zero, 0x858($s0)
    /* 7A908 8008A108 0000428C */  lw         $v0, 0x0($v0)
    /* 7A90C 8008A10C 00000000 */  nop
    /* 7A910 8008A110 1D004228 */  slti       $v0, $v0, 0x1D
    /* 7A914 8008A114 10004010 */  beqz       $v0, .L8008A158
    /* 7A918 8008A118 00000000 */   nop
    /* 7A91C 8008A11C 6404028E */  lw         $v0, 0x464($s0)
    /* 7A920 8008A120 00000000 */  nop
    /* 7A924 8008A124 3801438C */  lw         $v1, 0x138($v0)
    /* 7A928 8008A128 4801448C */  lw         $a0, 0x148($v0)
    /* 7A92C 8008A12C 40280300 */  sll        $a1, $v1, 1
    /* 7A930 8008A130 0191030C */  jal        rdiv
    /* 7A934 8008A134 2128A300 */   addu      $a1, $a1, $v1
    /* 7A938 8008A138 6404038E */  lw         $v1, 0x464($s0)
    /* 7A93C 8008A13C 5C0802AE */  sw         $v0, 0x85C($s0)
    /* 7A940 8008A140 3801658C */  lw         $a1, 0x138($v1)
    /* 7A944 8008A144 4C01648C */  lw         $a0, 0x14C($v1)
    /* 7A948 8008A148 0191030C */  jal        rdiv
    /* 7A94C 8008A14C 40280500 */   sll       $a1, $a1, 1
    /* 7A950 8008A150 58280208 */  j          .L8008A160
    /* 7A954 8008A154 600802AE */   sw        $v0, 0x860($s0)
  .L8008A158:
    /* 7A958 8008A158 5C0800AE */  sw         $zero, 0x85C($s0)
    /* 7A95C 8008A15C 600800AE */  sw         $zero, 0x860($s0)
  .L8008A160:
    /* 7A960 8008A160 4000BF8F */  lw         $ra, 0x40($sp)
    /* 7A964 8008A164 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 7A968 8008A168 3800B08F */  lw         $s0, 0x38($sp)
    /* 7A96C 8008A16C 0800E003 */  jr         $ra
    /* 7A970 8008A170 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Cars_IniCarObjects__FP8Car_tObji
