.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x1F8

glabel ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* E744 8001DF44 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E748 8001DF48 1400B1AF */  sw         $s1, 0x14($sp)
    /* E74C 8001DF4C 21888000 */  addu       $s1, $a0, $zero
    /* E750 8001DF50 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E754 8001DF54 2198A000 */  addu       $s3, $a1, $zero
    /* E758 8001DF58 1800B2AF */  sw         $s2, 0x18($sp)
    /* E75C 8001DF5C 2190C000 */  addu       $s2, $a2, $zero
    /* E760 8001DF60 2000B4AF */  sw         $s4, 0x20($sp)
    /* E764 8001DF64 2400BFAF */  sw         $ra, 0x24($sp)
    /* E768 8001DF68 1000B0AF */  sw         $s0, 0x10($sp)
    /* E76C 8001DF6C 0000438E */  lw         $v1, 0x0($s2)
    /* E770 8001DF70 02000224 */  addiu      $v0, $zero, 0x2
    /* E774 8001DF74 26006210 */  beq        $v1, $v0, .L8001E010
    /* E778 8001DF78 21A0E000 */   addu      $s4, $a3, $zero
    /* E77C 8001DF7C 10000224 */  addiu      $v0, $zero, 0x10
    /* E780 8001DF80 41006214 */  bne        $v1, $v0, .L8001E088
    /* E784 8001DF84 00000000 */   nop
    /* E788 8001DF88 4400228E */  lw         $v0, 0x44($s1)
    /* E78C 8001DF8C 00000000 */  nop
    /* E790 8001DF90 3D004010 */  beqz       $v0, .L8001E088
    /* E794 8001DF94 00000000 */   nop
    /* E798 8001DF98 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* E79C 8001DF9C 01000424 */   addiu     $a0, $zero, 0x1
    /* E7A0 8001DFA0 14000424 */  addiu      $a0, $zero, 0x14
    /* E7A4 8001DFA4 01000224 */  addiu      $v0, $zero, 0x1
    /* E7A8 8001DFA8 440020AE */  sw         $zero, 0x44($s1)
    /* E7AC 8001DFAC 81EB010C */  jal        AudioMus_StopSong__Fi
    /* E7B0 8001DFB0 000042AE */   sw        $v0, 0x0($s2)
    /* E7B4 8001DFB4 0580103C */  lui        $s0, %hi(screenAudio)
    /* E7B8 8001DFB8 E828028E */  lw         $v0, %lo(screenAudio)($s0)
    /* E7BC 8001DFBC 00000000 */  nop
    /* E7C0 8001DFC0 7800448C */  lw         $a0, 0x78($v0)
    /* E7C4 8001DFC4 00000000 */  nop
    /* E7C8 8001DFC8 04008010 */  beqz       $a0, .L8001DFDC
    /* E7CC 8001DFCC 00000000 */   nop
    /* E7D0 8001DFD0 5095030C */  jal        purgememadr
    /* E7D4 8001DFD4 00000000 */   nop
    /* E7D8 8001DFD8 E828028E */  lw         $v0, %lo(screenAudio)($s0)
  .L8001DFDC:
    /* E7DC 8001DFDC 63EB010C */  jal        AudioMus_SysCleanUp__Fv
    /* E7E0 8001DFE0 780040AC */   sw        $zero, 0x78($v0)
    /* E7E4 8001DFE4 00D80434 */  ori        $a0, $zero, 0xD800
    /* E7E8 8001DFE8 0100053C */  lui        $a1, (0x18000 >> 16)
    /* E7EC 8001DFEC 0080A534 */  ori        $a1, $a1, (0x18000 & 0xFFFF)
    /* E7F0 8001DFF0 0180063C */  lui        $a2, %hi(D_8001096C)
    /* E7F4 8001DFF4 06EB010C */  jal        AudioMus_SysStartUp__FiiPc
    /* E7F8 8001DFF8 6C09C624 */   addiu     $a2, $a2, %lo(D_8001096C)
    /* E7FC 8001DFFC 0180043C */  lui        $a0, %hi(D_80010974)
    /* E800 8001E000 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* E804 8001E004 74098424 */   addiu     $a0, $a0, %lo(D_80010974)
    /* E808 8001E008 22780008 */  j          .L8001E088
    /* E80C 8001E00C 00000000 */   nop
  .L8001E010:
    /* E810 8001E010 4400228E */  lw         $v0, 0x44($s1)
    /* E814 8001E014 00000000 */  nop
    /* E818 8001E018 1B004014 */  bnez       $v0, .L8001E088
    /* E81C 8001E01C 00000000 */   nop
    /* E820 8001E020 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* E824 8001E024 21200000 */   addu      $a0, $zero, $zero
    /* E828 8001E028 14000424 */  addiu      $a0, $zero, 0x14
    /* E82C 8001E02C 01000224 */  addiu      $v0, $zero, 0x1
    /* E830 8001E030 440022AE */  sw         $v0, 0x44($s1)
    /* E834 8001E034 81EB010C */  jal        AudioMus_StopSong__Fi
    /* E838 8001E038 000042AE */   sw        $v0, 0x0($s2)
    /* E83C 8001E03C 63EB010C */  jal        AudioMus_SysCleanUp__Fv
    /* E840 8001E040 00000000 */   nop
    /* E844 8001E044 00C00434 */  ori        $a0, $zero, 0xC000
    /* E848 8001E048 0100053C */  lui        $a1, (0x18000 >> 16)
    /* E84C 8001E04C 0080A534 */  ori        $a1, $a1, (0x18000 & 0xFFFF)
    /* E850 8001E050 0180063C */  lui        $a2, %hi(D_8001097C)
    /* E854 8001E054 06EB010C */  jal        AudioMus_SysStartUp__FiiPc
    /* E858 8001E058 7C09C624 */   addiu     $a2, $a2, %lo(D_8001097C)
    /* E85C 8001E05C 0180043C */  lui        $a0, %hi(D_80010984)
    /* E860 8001E060 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* E864 8001E064 84098424 */   addiu     $a0, $a0, %lo(D_80010984)
    /* E868 8001E068 0180043C */  lui        $a0, %hi(D_8001098C)
    /* E86C 8001E06C 8C098424 */  addiu      $a0, $a0, %lo(D_8001098C)
    /* E870 8001E070 20EA010C */  jal        AudioMus_GetSongList__FPci
    /* E874 8001E074 21280000 */   addu      $a1, $zero, $zero
    /* E878 8001E078 0580033C */  lui        $v1, %hi(screenAudio)
    /* E87C 8001E07C E828638C */  lw         $v1, %lo(screenAudio)($v1)
    /* E880 8001E080 00000000 */  nop
    /* E884 8001E084 780062AC */  sw         $v0, 0x78($v1)
  .L8001E088:
    /* E888 8001E088 2A002286 */  lh         $v0, 0x2A($s1)
    /* E88C 8001E08C 00000000 */  nop
    /* E890 8001E090 11004014 */  bnez       $v0, .L8001E0D8
    /* E894 8001E094 00000000 */   nop
    /* E898 8001E098 4400228E */  lw         $v0, 0x44($s1)
    /* E89C 8001E09C 00000000 */  nop
    /* E8A0 8001E0A0 1A004010 */  beqz       $v0, .L8001E10C
    /* E8A4 8001E0A4 21202002 */   addu      $a0, $s1, $zero
    /* E8A8 8001E0A8 1C00238E */  lw         $v1, 0x1C($s1)
    /* E8AC 8001E0AC 00000000 */  nop
    /* E8B0 8001E0B0 0A006010 */  beqz       $v1, .L8001E0DC
    /* E8B4 8001E0B4 21286002 */   addu      $a1, $s3, $zero
    /* E8B8 8001E0B8 21304002 */  addu       $a2, $s2, $zero
    /* E8BC 8001E0BC 6800628C */  lw         $v0, 0x68($v1)
    /* E8C0 8001E0C0 21388002 */  addu       $a3, $s4, $zero
    /* E8C4 8001E0C4 18004484 */  lh         $a0, 0x18($v0)
    /* E8C8 8001E0C8 1C00428C */  lw         $v0, 0x1C($v0)
    /* E8CC 8001E0CC 00000000 */  nop
    /* E8D0 8001E0D0 09F84000 */  jalr       $v0
    /* E8D4 8001E0D4 21206400 */   addu      $a0, $v1, $a0
  .L8001E0D8:
    /* E8D8 8001E0D8 4400228E */  lw         $v0, 0x44($s1)
  .L8001E0DC:
    /* E8DC 8001E0DC 00000000 */  nop
    /* E8E0 8001E0E0 09004010 */  beqz       $v0, .L8001E108
    /* E8E4 8001E0E4 00020224 */   addiu     $v0, $zero, 0x200
    /* E8E8 8001E0E8 0000438E */  lw         $v1, 0x0($s2)
    /* E8EC 8001E0EC 00000000 */  nop
    /* E8F0 8001E0F0 03006210 */  beq        $v1, $v0, .L8001E100
    /* E8F4 8001E0F4 00040224 */   addiu     $v0, $zero, 0x400
    /* E8F8 8001E0F8 04006214 */  bne        $v1, $v0, .L8001E10C
    /* E8FC 8001E0FC 21202002 */   addu      $a0, $s1, $zero
  .L8001E100:
    /* E900 8001E100 01000224 */  addiu      $v0, $zero, 0x1
    /* E904 8001E104 000042AE */  sw         $v0, 0x0($s2)
  .L8001E108:
    /* E908 8001E108 21202002 */  addu       $a0, $s1, $zero
  .L8001E10C:
    /* E90C 8001E10C 21286002 */  addu       $a1, $s3, $zero
    /* E910 8001E110 21304002 */  addu       $a2, $s2, $zero
    /* E914 8001E114 E891000C */  jal        ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* E918 8001E118 21388002 */   addu      $a3, $s4, $zero
    /* E91C 8001E11C 2400BF8F */  lw         $ra, 0x24($sp)
    /* E920 8001E120 2000B48F */  lw         $s4, 0x20($sp)
    /* E924 8001E124 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E928 8001E128 1800B28F */  lw         $s2, 0x18($sp)
    /* E92C 8001E12C 1400B18F */  lw         $s1, 0x14($sp)
    /* E930 8001E130 1000B08F */  lw         $s0, 0x10($sp)
    /* E934 8001E134 0800E003 */  jr         $ra
    /* E938 8001E138 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand
