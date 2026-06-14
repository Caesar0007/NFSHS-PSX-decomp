.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand, 0x11C

glabel ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
    /* 980AC 800A78AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 980B0 800A78B0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 980B4 800A78B4 0000A38C */  lw         $v1, 0x0($a1)
    /* 980B8 800A78B8 00080224 */  addiu      $v0, $zero, 0x800
    /* 980BC 800A78BC 06006210 */  beq        $v1, $v0, .L800A78D8
    /* 980C0 800A78C0 21300000 */   addu      $a2, $zero, $zero
    /* 980C4 800A78C4 00100224 */  addiu      $v0, $zero, 0x1000
    /* 980C8 800A78C8 1B006210 */  beq        $v1, $v0, .L800A7938
    /* 980CC 800A78CC 00000000 */   nop
    /* 980D0 800A78D0 6A9E0208 */  j          .L800A79A8
    /* 980D4 800A78D4 00000000 */   nop
  .L800A78D8:
    /* 980D8 800A78D8 0C00828C */  lw         $v0, 0xC($a0)
    /* 980DC 800A78DC 00000000 */  nop
    /* 980E0 800A78E0 0000428C */  lw         $v0, 0x0($v0)
    /* 980E4 800A78E4 00000000 */  nop
    /* 980E8 800A78E8 2D004018 */  blez       $v0, .L800A79A0
    /* 980EC 800A78EC 01000224 */   addiu     $v0, $zero, 0x1
    /* 980F0 800A78F0 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* 980F4 800A78F4 40D222AC */  sw         $v0, %lo(gMPauseUpdateNextTime)($at)
    /* 980F8 800A78F8 10008390 */  lbu        $v1, 0x10($a0)
    /* 980FC 800A78FC 8888023C */  lui        $v0, (0x88888889 >> 16)
    /* 98100 800A7900 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* 98104 800A7904 19006200 */  multu      $v1, $v0
    /* 98108 800A7908 0C00848C */  lw         $a0, 0xC($a0)
    /* 9810C 800A790C 00000000 */  nop
    /* 98110 800A7910 0000838C */  lw         $v1, 0x0($a0)
    /* 98114 800A7914 10380000 */  mfhi       $a3
    /* 98118 800A7918 02110700 */  srl        $v0, $a3, 4
    /* 9811C 800A791C FF004230 */  andi       $v0, $v0, 0xFF
    /* 98120 800A7920 23186200 */  subu       $v1, $v1, $v0
    /* 98124 800A7924 02006104 */  bgez       $v1, .L800A7930
    /* 98128 800A7928 00000000 */   nop
    /* 9812C 800A792C 21180000 */  addu       $v1, $zero, $zero
  .L800A7930:
    /* 98130 800A7930 679E0208 */  j          .L800A799C
    /* 98134 800A7934 000083AC */   sw        $v1, 0x0($a0)
  .L800A7938:
    /* 98138 800A7938 0C00828C */  lw         $v0, 0xC($a0)
    /* 9813C 800A793C 10008390 */  lbu        $v1, 0x10($a0)
    /* 98140 800A7940 0000428C */  lw         $v0, 0x0($v0)
    /* 98144 800A7944 00000000 */  nop
    /* 98148 800A7948 2A104300 */  slt        $v0, $v0, $v1
    /* 9814C 800A794C 14004010 */  beqz       $v0, .L800A79A0
    /* 98150 800A7950 01000224 */   addiu     $v0, $zero, 0x1
    /* 98154 800A7954 1480013C */  lui        $at, %hi(gMPauseUpdateNextTime)
    /* 98158 800A7958 40D222AC */  sw         $v0, %lo(gMPauseUpdateNextTime)($at)
    /* 9815C 800A795C 10008390 */  lbu        $v1, 0x10($a0)
    /* 98160 800A7960 8888023C */  lui        $v0, (0x88888889 >> 16)
    /* 98164 800A7964 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* 98168 800A7968 19006200 */  multu      $v1, $v0
    /* 9816C 800A796C 0C00848C */  lw         $a0, 0xC($a0)
    /* 98170 800A7970 21306000 */  addu       $a2, $v1, $zero
    /* 98174 800A7974 0000838C */  lw         $v1, 0x0($a0)
    /* 98178 800A7978 10380000 */  mfhi       $a3
    /* 9817C 800A797C 02110700 */  srl        $v0, $a3, 4
    /* 98180 800A7980 FF004230 */  andi       $v0, $v0, 0xFF
    /* 98184 800A7984 21186200 */  addu       $v1, $v1, $v0
    /* 98188 800A7988 2A10C300 */  slt        $v0, $a2, $v1
    /* 9818C 800A798C 02004014 */  bnez       $v0, .L800A7998
    /* 98190 800A7990 00000000 */   nop
    /* 98194 800A7994 21306000 */  addu       $a2, $v1, $zero
  .L800A7998:
    /* 98198 800A7998 000086AC */  sw         $a2, 0x0($a0)
  .L800A799C:
    /* 9819C 800A799C 01000624 */  addiu      $a2, $zero, 0x1
  .L800A79A0:
    /* 981A0 800A79A0 01000224 */  addiu      $v0, $zero, 0x1
    /* 981A4 800A79A4 0000A2AC */  sw         $v0, 0x0($a1)
  .L800A79A8:
    /* 981A8 800A79A8 0300C010 */  beqz       $a2, .L800A79B8
    /* 981AC 800A79AC 00000000 */   nop
    /* 981B0 800A79B0 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 981B4 800A79B4 05000424 */   addiu     $a0, $zero, 0x5
  .L800A79B8:
    /* 981B8 800A79B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 981BC 800A79BC 00000000 */  nop
    /* 981C0 800A79C0 0800E003 */  jr         $ra
    /* 981C4 800A79C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
