.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetGlueFactor__FP8Car_tObj, 0x20C

glabel AISpeeds_GetGlueFactor__FP8Car_tObj
    /* 5EE8C 8006E68C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5EE90 8006E690 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5EE94 8006E694 21A08000 */  addu       $s4, $a0, $zero
    /* 5EE98 8006E698 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5EE9C 8006E69C 1180103C */  lui        $s0, %hi(leaderBoard)
    /* 5EEA0 8006E6A0 A4DD1026 */  addiu      $s0, $s0, %lo(leaderBoard)
    /* 5EEA4 8006E6A4 2400BFAF */  sw         $ra, 0x24($sp)
    /* 5EEA8 8006E6A8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5EEAC 8006E6AC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5EEB0 8006E6B0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5EEB4 8006E6B4 0400048E */  lw         $a0, 0x4($s0)
    /* 5EEB8 8006E6B8 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 5EEBC 8006E6BC 0100123C */   lui       $s2, (0x10000 >> 16)
    /* 5EEC0 8006E6C0 0800048E */  lw         $a0, 0x8($s0)
    /* 5EEC4 8006E6C4 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 5EEC8 8006E6C8 21984000 */   addu      $s3, $v0, $zero
    /* 5EECC 8006E6CC 0C00048E */  lw         $a0, 0xC($s0)
    /* 5EED0 8006E6D0 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 5EED4 8006E6D4 21884000 */   addu      $s1, $v0, $zero
    /* 5EED8 8006E6D8 0400038E */  lw         $v1, 0x4($s0)
    /* 5EEDC 8006E6DC 0900043C */  lui        $a0, (0x9FFFF >> 16)
    /* 5EEE0 8006E6E0 6405638C */  lw         $v1, 0x564($v1)
    /* 5EEE4 8006E6E4 FFFF8434 */  ori        $a0, $a0, (0x9FFFF & 0xFFFF)
    /* 5EEE8 8006E6E8 02006104 */  bgez       $v1, .L8006E6F4
    /* 5EEEC 8006E6EC 00000000 */   nop
    /* 5EEF0 8006E6F0 23180300 */  negu       $v1, $v1
  .L8006E6F4:
    /* 5EEF4 8006E6F4 2A208300 */  slt        $a0, $a0, $v1
    /* 5EEF8 8006E6F8 03008014 */  bnez       $a0, .L8006E708
    /* 5EEFC 8006E6FC 2A106202 */   slt       $v0, $s3, $v0
    /* 5EF00 8006E700 06BA0108 */  j          .L8006E818
    /* 5EF04 8006E704 21804002 */   addu      $s0, $s2, $zero
  .L8006E708:
    /* 5EF08 8006E708 0E004010 */  beqz       $v0, .L8006E744
    /* 5EF0C 8006E70C 8888023C */   lui       $v0, (0x88888889 >> 16)
    /* 5EF10 8006E710 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* 5EF14 8006E714 23183302 */  subu       $v1, $s1, $s3
    /* 5EF18 8006E718 18006200 */  mult       $v1, $v0
    /* 5EF1C 8006E71C 10300000 */  mfhi       $a2
    /* 5EF20 8006E720 2110C300 */  addu       $v0, $a2, $v1
    /* 5EF24 8006E724 43150200 */  sra        $v0, $v0, 21
    /* 5EF28 8006E728 C31F0300 */  sra        $v1, $v1, 31
    /* 5EF2C 8006E72C 23104300 */  subu       $v0, $v0, $v1
    /* 5EF30 8006E730 0A004324 */  addiu      $v1, $v0, 0xA
    /* 5EF34 8006E734 11006104 */  bgez       $v1, .L8006E77C
    /* 5EF38 8006E738 15006228 */   slti      $v0, $v1, 0x15
    /* 5EF3C 8006E73C E4B90108 */  j          .L8006E790
    /* 5EF40 8006E740 21200000 */   addu      $a0, $zero, $zero
  .L8006E744:
    /* 5EF44 8006E744 2A103302 */  slt        $v0, $s1, $s3
    /* 5EF48 8006E748 18004010 */  beqz       $v0, .L8006E7AC
    /* 5EF4C 8006E74C 8888023C */   lui       $v0, (0x88888889 >> 16)
    /* 5EF50 8006E750 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* 5EF54 8006E754 23183302 */  subu       $v1, $s1, $s3
    /* 5EF58 8006E758 18006200 */  mult       $v1, $v0
    /* 5EF5C 8006E75C 10300000 */  mfhi       $a2
    /* 5EF60 8006E760 2110C300 */  addu       $v0, $a2, $v1
    /* 5EF64 8006E764 43150200 */  sra        $v0, $v0, 21
    /* 5EF68 8006E768 C31F0300 */  sra        $v1, $v1, 31
    /* 5EF6C 8006E76C 23104300 */  subu       $v0, $v0, $v1
    /* 5EF70 8006E770 0A004324 */  addiu      $v1, $v0, 0xA
    /* 5EF74 8006E774 05006004 */  bltz       $v1, .L8006E78C
    /* 5EF78 8006E778 15006228 */   slti      $v0, $v1, 0x15
  .L8006E77C:
    /* 5EF7C 8006E77C 04004010 */  beqz       $v0, .L8006E790
    /* 5EF80 8006E780 14000424 */   addiu     $a0, $zero, 0x14
    /* 5EF84 8006E784 E4B90108 */  j          .L8006E790
    /* 5EF88 8006E788 21206000 */   addu      $a0, $v1, $zero
  .L8006E78C:
    /* 5EF8C 8006E78C 21200000 */  addu       $a0, $zero, $zero
  .L8006E790:
    /* 5EF90 8006E790 1180033C */  lui        $v1, %hi(AIPerson_glueTable)
    /* 5EF94 8006E794 14D76324 */  addiu      $v1, $v1, %lo(AIPerson_glueTable)
    /* 5EF98 8006E798 80100400 */  sll        $v0, $a0, 2
    /* 5EF9C 8006E79C 21104300 */  addu       $v0, $v0, $v1
    /* 5EFA0 8006E7A0 0000508C */  lw         $s0, 0x0($v0)
    /* 5EFA4 8006E7A4 06BA0108 */  j          .L8006E818
    /* 5EFA8 8006E7A8 0100123C */   lui       $s2, (0x10000 >> 16)
  .L8006E7AC:
    /* 5EFAC 8006E7AC 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* 5EFB0 8006E7B0 23183302 */  subu       $v1, $s1, $s3
    /* 5EFB4 8006E7B4 18006200 */  mult       $v1, $v0
    /* 5EFB8 8006E7B8 10300000 */  mfhi       $a2
    /* 5EFBC 8006E7BC 2110C300 */  addu       $v0, $a2, $v1
    /* 5EFC0 8006E7C0 43150200 */  sra        $v0, $v0, 21
    /* 5EFC4 8006E7C4 C31F0300 */  sra        $v1, $v1, 31
    /* 5EFC8 8006E7C8 23104300 */  subu       $v0, $v0, $v1
    /* 5EFCC 8006E7CC 0A004324 */  addiu      $v1, $v0, 0xA
    /* 5EFD0 8006E7D0 05006004 */  bltz       $v1, .L8006E7E8
    /* 5EFD4 8006E7D4 15006228 */   slti      $v0, $v1, 0x15
    /* 5EFD8 8006E7D8 04004010 */  beqz       $v0, .L8006E7EC
    /* 5EFDC 8006E7DC 14000424 */   addiu     $a0, $zero, 0x14
    /* 5EFE0 8006E7E0 FBB90108 */  j          .L8006E7EC
    /* 5EFE4 8006E7E4 21206000 */   addu      $a0, $v1, $zero
  .L8006E7E8:
    /* 5EFE8 8006E7E8 21200000 */  addu       $a0, $zero, $zero
  .L8006E7EC:
    /* 5EFEC 8006E7EC 1180033C */  lui        $v1, %hi(AIPerson_glueTable)
    /* 5EFF0 8006E7F0 14D76324 */  addiu      $v1, $v1, %lo(AIPerson_glueTable)
    /* 5EFF4 8006E7F4 80100400 */  sll        $v0, $a0, 2
    /* 5EFF8 8006E7F8 21104300 */  addu       $v0, $v0, $v1
    /* 5EFFC 8006E7FC 0000508C */  lw         $s0, 0x0($v0)
    /* 5F000 8006E800 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5F004 8006E804 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5F008 8006E808 03000224 */  addiu      $v0, $zero, 0x3
    /* 5F00C 8006E80C 02006210 */  beq        $v1, $v0, .L8006E818
    /* 5F010 8006E810 00801234 */   ori       $s2, $zero, 0x8000
    /* 5F014 8006E814 66E61234 */  ori        $s2, $zero, 0xE666
  .L8006E818:
    /* 5F018 8006E818 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 5F01C 8006E81C 21208002 */   addu      $a0, $s4, $zero
    /* 5F020 8006E820 3C00033C */  lui        $v1, (0x3C0000 >> 16)
    /* 5F024 8006E824 21186302 */  addu       $v1, $s3, $v1
    /* 5F028 8006E828 2A104300 */  slt        $v0, $v0, $v1
    /* 5F02C 8006E82C 05004010 */  beqz       $v0, .L8006E844
    /* 5F030 8006E830 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 5F034 8006E834 2A105000 */  slt        $v0, $v0, $s0
    /* 5F038 8006E838 03004014 */  bnez       $v0, .L8006E848
    /* 5F03C 8006E83C 0100113C */   lui       $s1, (0x10000 >> 16)
    /* 5F040 8006E840 0100103C */  lui        $s0, (0x10000 >> 16)
  .L8006E844:
    /* 5F044 8006E844 0100113C */  lui        $s1, (0x10000 >> 16)
  .L8006E848:
    /* 5F048 8006E848 2A103002 */  slt        $v0, $s1, $s0
    /* 5F04C 8006E84C 05004010 */  beqz       $v0, .L8006E864
    /* 5F050 8006E850 23201102 */   subu      $a0, $s0, $s1
    /* 5F054 8006E854 CA90030C */  jal        fixedmult
    /* 5F058 8006E858 21284002 */   addu      $a1, $s2, $zero
    /* 5F05C 8006E85C 1DBA0108 */  j          .L8006E874
    /* 5F060 8006E860 21805100 */   addu      $s0, $v0, $s1
  .L8006E864:
    /* 5F064 8006E864 23203002 */  subu       $a0, $s1, $s0
    /* 5F068 8006E868 CA90030C */  jal        fixedmult
    /* 5F06C 8006E86C 21284002 */   addu      $a1, $s2, $zero
    /* 5F070 8006E870 23802202 */  subu       $s0, $s1, $v0
  .L8006E874:
    /* 5F074 8006E874 21100002 */  addu       $v0, $s0, $zero
    /* 5F078 8006E878 2400BF8F */  lw         $ra, 0x24($sp)
    /* 5F07C 8006E87C 2000B48F */  lw         $s4, 0x20($sp)
    /* 5F080 8006E880 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5F084 8006E884 1800B28F */  lw         $s2, 0x18($sp)
    /* 5F088 8006E888 1400B18F */  lw         $s1, 0x14($sp)
    /* 5F08C 8006E88C 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F090 8006E890 0800E003 */  jr         $ra
    /* 5F094 8006E894 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AISpeeds_GetGlueFactor__FP8Car_tObj
