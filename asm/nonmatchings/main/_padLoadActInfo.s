.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padLoadActInfo, 0xD4

glabel _padLoadActInfo
    /* F6004 80105804 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F6008 80105808 1000B0AF */  sw         $s0, 0x10($sp)
    /* F600C 8010580C 21808000 */  addu       $s0, $a0, $zero
    /* F6010 80105810 1400B1AF */  sw         $s1, 0x14($sp)
    /* F6014 80105814 2188A000 */  addu       $s1, $a1, $zero
    /* F6018 80105818 0C002012 */  beqz       $s1, .L8010584C
    /* F601C 8010581C 1800BFAF */   sw        $ra, 0x18($sp)
    /* F6020 80105820 0400028E */  lw         $v0, 0x4($s0)
    /* F6024 80105824 00000000 */  nop
    /* F6028 80105828 26004014 */  bnez       $v0, .L801058C4
    /* F602C 8010582C 21100000 */   addu      $v0, $zero, $zero
    /* F6030 80105830 1380023C */  lui        $v0, %hi(_padFuncChkEng)
    /* F6034 80105834 947C428C */  lw         $v0, %lo(_padFuncChkEng)($v0)
    /* F6038 80105838 00000000 */  nop
    /* F603C 8010583C 09F84000 */  jalr       $v0
    /* F6040 80105840 00000000 */   nop
    /* F6044 80105844 03004010 */  beqz       $v0, .L80105854
    /* F6048 80105848 01000224 */   addiu     $v0, $zero, 0x1
  .L8010584C:
    /* F604C 8010584C 31160408 */  j          .L801058C4
    /* F6050 80105850 21100000 */   addu      $v0, $zero, $zero
  .L80105854:
    /* F6054 80105854 04000324 */  addiu      $v1, $zero, 0x4
    /* F6058 80105858 03002526 */  addiu      $a1, $s1, 0x3
    /* F605C 8010585C 83280500 */  sra        $a1, $a1, 2
    /* F6060 80105860 490003A2 */  sb         $v1, 0x49($s0)
    /* F6064 80105864 01000324 */  addiu      $v1, $zero, 0x1
    /* F6068 80105868 460003A2 */  sb         $v1, 0x46($s0)
    /* F606C 8010586C 1080033C */  lui        $v1, %hi(_padLoadActInfo_snd)
    /* F6070 80105870 D8586324 */  addiu      $v1, $v1, %lo(_padLoadActInfo_snd)
    /* F6074 80105874 140003AE */  sw         $v1, 0x14($s0)
    /* F6078 80105878 E3000392 */  lbu        $v1, 0xE3($s0)
    /* F607C 8010587C 1080043C */  lui        $a0, %hi(_padLoadActInfo_rcv)
    /* F6080 80105880 80598424 */  addiu      $a0, $a0, %lo(_padLoadActInfo_rcv)
    /* F6084 80105884 180004AE */  sw         $a0, 0x18($s0)
    /* F6088 80105888 E9000492 */  lbu        $a0, 0xE9($s0)
    /* F608C 8010588C 80280500 */  sll        $a1, $a1, 2
    /* F6090 80105890 000005AE */  sw         $a1, 0x0($s0)
    /* F6094 80105894 470000A2 */  sb         $zero, 0x47($s0)
    /* F6098 80105898 01006324 */  addiu      $v1, $v1, 0x1
    /* F609C 8010589C 43180300 */  sra        $v1, $v1, 1
    /* F60A0 801058A0 80180300 */  sll        $v1, $v1, 2
    /* F60A4 801058A4 2128A300 */  addu       $a1, $a1, $v1
    /* F60A8 801058A8 80180400 */  sll        $v1, $a0, 2
    /* F60AC 801058AC 21186400 */  addu       $v1, $v1, $a0
    /* F60B0 801058B0 03006324 */  addiu      $v1, $v1, 0x3
    /* F60B4 801058B4 FC0F6330 */  andi       $v1, $v1, 0xFFC
    /* F60B8 801058B8 040005AE */  sw         $a1, 0x4($s0)
    /* F60BC 801058BC 2128A300 */  addu       $a1, $a1, $v1
    /* F60C0 801058C0 080005AE */  sw         $a1, 0x8($s0)
  .L801058C4:
    /* F60C4 801058C4 1800BF8F */  lw         $ra, 0x18($sp)
    /* F60C8 801058C8 1400B18F */  lw         $s1, 0x14($sp)
    /* F60CC 801058CC 1000B08F */  lw         $s0, 0x10($sp)
    /* F60D0 801058D0 0800E003 */  jr         $ra
    /* F60D4 801058D4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _padLoadActInfo
