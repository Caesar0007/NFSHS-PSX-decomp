.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x208

glabel ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* F67C 8001EE7C 0580023C */  lui        $v0, %hi(screenAudio)
    /* F680 8001EE80 E828428C */  lw         $v0, %lo(screenAudio)($v0)
    /* F684 8001EE84 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F688 8001EE88 1000B0AF */  sw         $s0, 0x10($sp)
    /* F68C 8001EE8C 21808000 */  addu       $s0, $a0, $zero
    /* F690 8001EE90 1800BFAF */  sw         $ra, 0x18($sp)
    /* F694 8001EE94 1400B1AF */  sw         $s1, 0x14($sp)
    /* F698 8001EE98 7800428C */  lw         $v0, 0x78($v0)
    /* F69C 8001EE9C 00000000 */  nop
    /* F6A0 8001EEA0 73004010 */  beqz       $v0, .L8001F070
    /* F6A4 8001EEA4 2188C000 */   addu      $s1, $a2, $zero
    /* F6A8 8001EEA8 0000238E */  lw         $v1, 0x0($s1)
    /* F6AC 8001EEAC 00080224 */  addiu      $v0, $zero, 0x800
    /* F6B0 8001EEB0 03006214 */  bne        $v1, $v0, .L8001EEC0
    /* F6B4 8001EEB4 00100224 */   addiu     $v0, $zero, 0x1000
    /* F6B8 8001EEB8 B27B0008 */  j          .L8001EEC8
    /* F6BC 8001EEBC 05000424 */   addiu     $a0, $zero, 0x5
  .L8001EEC0:
    /* F6C0 8001EEC0 03006214 */  bne        $v1, $v0, .L8001EED0
    /* F6C4 8001EEC4 06000424 */   addiu     $a0, $zero, 0x6
  .L8001EEC8:
    /* F6C8 8001EEC8 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* F6CC 8001EECC 00000000 */   nop
  .L8001EED0:
    /* F6D0 8001EED0 0000238E */  lw         $v1, 0x0($s1)
    /* F6D4 8001EED4 00040224 */  addiu      $v0, $zero, 0x400
    /* F6D8 8001EED8 39006210 */  beq        $v1, $v0, .L8001EFC0
    /* F6DC 8001EEDC 01046228 */   slti      $v0, $v1, 0x401
    /* F6E0 8001EEE0 05004010 */  beqz       $v0, .L8001EEF8
    /* F6E4 8001EEE4 00020224 */   addiu     $v0, $zero, 0x200
    /* F6E8 8001EEE8 14006210 */  beq        $v1, $v0, .L8001EF3C
    /* F6EC 8001EEEC 0580023C */   lui       $v0, %hi(screenAudio)
    /* F6F0 8001EEF0 1C7C0008 */  j          .L8001F070
    /* F6F4 8001EEF4 00000000 */   nop
  .L8001EEF8:
    /* F6F8 8001EEF8 00080224 */  addiu      $v0, $zero, 0x800
    /* F6FC 8001EEFC 03006210 */  beq        $v1, $v0, .L8001EF0C
    /* F700 8001EF00 00100224 */   addiu     $v0, $zero, 0x1000
    /* F704 8001EF04 5A006214 */  bne        $v1, $v0, .L8001F070
    /* F708 8001EF08 00000000 */   nop
  .L8001EF0C:
    /* F70C 8001EF0C 0580023C */  lui        $v0, %hi(screenAudio)
    /* F710 8001EF10 E828438C */  lw         $v1, %lo(screenAudio)($v0)
    /* F714 8001EF14 1180023C */  lui        $v0, %hi(frontEnd)
    /* F718 8001EF18 74006384 */  lh         $v1, 0x74($v1)
    /* F71C 8001EF1C 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* F720 8001EF20 80180300 */  sll        $v1, $v1, 2
    /* F724 8001EF24 21186200 */  addu       $v1, $v1, $v0
    /* F728 8001EF28 9C03628C */  lw         $v0, 0x39C($v1)
    /* F72C 8001EF2C 00000000 */  nop
    /* F730 8001EF30 0100422C */  sltiu      $v0, $v0, 0x1
    /* F734 8001EF34 1A7C0008 */  j          .L8001F068
    /* F738 8001EF38 9C0362AC */   sw        $v0, 0x39C($v1)
  .L8001EF3C:
    /* F73C 8001EF3C E828428C */  lw         $v0, %lo(screenAudio)($v0)
    /* F740 8001EF40 00000000 */  nop
    /* F744 8001EF44 74004284 */  lh         $v0, 0x74($v0)
    /* F748 8001EF48 00000000 */  nop
    /* F74C 8001EF4C 47004018 */  blez       $v0, .L8001F06C
    /* F750 8001EF50 01000224 */   addiu     $v0, $zero, 0x1
    /* F754 8001EF54 6E000286 */  lh         $v0, 0x6E($s0)
    /* F758 8001EF58 00000000 */  nop
    /* F75C 8001EF5C 43004014 */  bnez       $v0, .L8001F06C
    /* F760 8001EF60 01000224 */   addiu     $v0, $zero, 0x1
    /* F764 8001EF64 04000524 */  addiu      $a1, $zero, 0x4
    /* F768 8001EF68 EBFF0224 */  addiu      $v0, $zero, -0x15
    /* F76C 8001EF6C 6E0002A6 */  sh         $v0, 0x6E($s0)
    /* F770 8001EF70 2110A000 */  addu       $v0, $a1, $zero
    /* F774 8001EF74 700002A6 */  sh         $v0, 0x70($s0)
  .L8001EF78:
    /* F778 8001EF78 40200500 */  sll        $a0, $a1, 1
    /* F77C 8001EF7C FFFFA524 */  addiu      $a1, $a1, -0x1
    /* F780 8001EF80 40100500 */  sll        $v0, $a1, 1
    /* F784 8001EF84 21100202 */  addu       $v0, $s0, $v0
    /* F788 8001EF88 74004394 */  lhu        $v1, 0x74($v0)
    /* F78C 8001EF8C 21200402 */  addu       $a0, $s0, $a0
    /* F790 8001EF90 740083A4 */  sh         $v1, 0x74($a0)
    /* F794 8001EF94 7E004294 */  lhu        $v0, 0x7E($v0)
    /* F798 8001EF98 F7FFA01C */  bgtz       $a1, .L8001EF78
    /* F79C 8001EF9C 7E0082A4 */   sh        $v0, 0x7E($a0)
    /* F7A0 8001EFA0 0580023C */  lui        $v0, %hi(screenAudio)
    /* F7A4 8001EFA4 E828438C */  lw         $v1, %lo(screenAudio)($v0)
    /* F7A8 8001EFA8 740000A6 */  sh         $zero, 0x74($s0)
    /* F7AC 8001EFAC 7E0000A6 */  sh         $zero, 0x7E($s0)
    /* F7B0 8001EFB0 74006294 */  lhu        $v0, 0x74($v1)
    /* F7B4 8001EFB4 03000424 */  addiu      $a0, $zero, 0x3
    /* F7B8 8001EFB8 187C0008 */  j          .L8001F060
    /* F7BC 8001EFBC FFFF4224 */   addiu     $v0, $v0, -0x1
  .L8001EFC0:
    /* F7C0 8001EFC0 0580023C */  lui        $v0, %hi(screenAudio)
    /* F7C4 8001EFC4 E828438C */  lw         $v1, %lo(screenAudio)($v0)
    /* F7C8 8001EFC8 00000000 */  nop
    /* F7CC 8001EFCC 7800628C */  lw         $v0, 0x78($v1)
    /* F7D0 8001EFD0 00000000 */  nop
    /* F7D4 8001EFD4 0000428C */  lw         $v0, 0x0($v0)
    /* F7D8 8001EFD8 74006384 */  lh         $v1, 0x74($v1)
    /* F7DC 8001EFDC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* F7E0 8001EFE0 2A186200 */  slt        $v1, $v1, $v0
    /* F7E4 8001EFE4 21006010 */  beqz       $v1, .L8001F06C
    /* F7E8 8001EFE8 01000224 */   addiu     $v0, $zero, 0x1
    /* F7EC 8001EFEC 6E000286 */  lh         $v0, 0x6E($s0)
    /* F7F0 8001EFF0 00000000 */  nop
    /* F7F4 8001EFF4 1D004014 */  bnez       $v0, .L8001F06C
    /* F7F8 8001EFF8 01000224 */   addiu     $v0, $zero, 0x1
    /* F7FC 8001EFFC 21280000 */  addu       $a1, $zero, $zero
    /* F800 8001F000 15000224 */  addiu      $v0, $zero, 0x15
    /* F804 8001F004 6E0002A6 */  sh         $v0, 0x6E($s0)
    /* F808 8001F008 FCFF0224 */  addiu      $v0, $zero, -0x4
    /* F80C 8001F00C 700002A6 */  sh         $v0, 0x70($s0)
    /* F810 8001F010 40200500 */  sll        $a0, $a1, 1
  .L8001F014:
    /* F814 8001F014 0100A524 */  addiu      $a1, $a1, 0x1
    /* F818 8001F018 40100500 */  sll        $v0, $a1, 1
    /* F81C 8001F01C 21100202 */  addu       $v0, $s0, $v0
    /* F820 8001F020 74004394 */  lhu        $v1, 0x74($v0)
    /* F824 8001F024 21200402 */  addu       $a0, $s0, $a0
    /* F828 8001F028 740083A4 */  sh         $v1, 0x74($a0)
    /* F82C 8001F02C 7E004294 */  lhu        $v0, 0x7E($v0)
    /* F830 8001F030 00000000 */  nop
    /* F834 8001F034 7E0082A4 */  sh         $v0, 0x7E($a0)
    /* F838 8001F038 0400A228 */  slti       $v0, $a1, 0x4
    /* F83C 8001F03C F5FF4014 */  bnez       $v0, .L8001F014
    /* F840 8001F040 40200500 */   sll       $a0, $a1, 1
    /* F844 8001F044 0580023C */  lui        $v0, %hi(screenAudio)
    /* F848 8001F048 E828438C */  lw         $v1, %lo(screenAudio)($v0)
    /* F84C 8001F04C 7C0000A6 */  sh         $zero, 0x7C($s0)
    /* F850 8001F050 860000A6 */  sh         $zero, 0x86($s0)
    /* F854 8001F054 74006294 */  lhu        $v0, 0x74($v1)
    /* F858 8001F058 04000424 */  addiu      $a0, $zero, 0x4
    /* F85C 8001F05C 01004224 */  addiu      $v0, $v0, 0x1
  .L8001F060:
    /* F860 8001F060 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* F864 8001F064 740062A4 */   sh        $v0, 0x74($v1)
  .L8001F068:
    /* F868 8001F068 01000224 */  addiu      $v0, $zero, 0x1
  .L8001F06C:
    /* F86C 8001F06C 000022AE */  sw         $v0, 0x0($s1)
  .L8001F070:
    /* F870 8001F070 1800BF8F */  lw         $ra, 0x18($sp)
    /* F874 8001F074 1400B18F */  lw         $s1, 0x14($sp)
    /* F878 8001F078 1000B08F */  lw         $s0, 0x10($sp)
    /* F87C 8001F07C 0800E003 */  jr         $ra
    /* F880 8001F080 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
