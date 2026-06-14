.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_AddCustomSimObject__FP9SceneElemii, 0x1A8

glabel Object_AddCustomSimObject__FP9SceneElemii
    /* 95FB0 800A57B0 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 95FB4 800A57B4 B800B4AF */  sw         $s4, 0xB8($sp)
    /* 95FB8 800A57B8 21A08000 */  addu       $s4, $a0, $zero
    /* 95FBC 800A57BC BC00B5AF */  sw         $s5, 0xBC($sp)
    /* 95FC0 800A57C0 21A8A000 */  addu       $s5, $a1, $zero
    /* 95FC4 800A57C4 C400BFAF */  sw         $ra, 0xC4($sp)
    /* 95FC8 800A57C8 C000B6AF */  sw         $s6, 0xC0($sp)
    /* 95FCC 800A57CC B400B3AF */  sw         $s3, 0xB4($sp)
    /* 95FD0 800A57D0 B000B2AF */  sw         $s2, 0xB0($sp)
    /* 95FD4 800A57D4 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 95FD8 800A57D8 A800B0AF */  sw         $s0, 0xA8($sp)
    /* 95FDC 800A57DC 0000828E */  lw         $v0, 0x0($s4)
    /* 95FE0 800A57E0 00000000 */  nop
    /* 95FE4 800A57E4 4F004014 */  bnez       $v0, .L800A5924
    /* 95FE8 800A57E8 21B0C000 */   addu      $s6, $a2, $zero
    /* 95FEC 800A57EC 800D838F */  lw         $v1, %gp_rel(Object_customSimObjs)($gp)
    /* 95FF0 800A57F0 00000000 */  nop
    /* 95FF4 800A57F4 0000648C */  lw         $a0, 0x0($v1)
    /* 95FF8 800A57F8 04006324 */  addiu      $v1, $v1, 0x4
    /* 95FFC 800A57FC 80100400 */  sll        $v0, $a0, 2
    /* 96000 800A5800 21104400 */  addu       $v0, $v0, $a0
    /* 96004 800A5804 80100200 */  sll        $v0, $v0, 2
    /* 96008 800A5808 1000848E */  lw         $a0, 0x10($s4)
    /* 9600C 800A580C 21986200 */  addu       $s3, $v1, $v0
    /* 96010 800A5810 000064AE */  sw         $a0, 0x0($s3)
    /* 96014 800A5814 1400828E */  lw         $v0, 0x14($s4)
    /* 96018 800A5818 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9601C 800A581C 040062AE */  sw         $v0, 0x4($s3)
    /* 96020 800A5820 1800828E */  lw         $v0, 0x18($s4)
    /* 96024 800A5824 01000424 */  addiu      $a0, $zero, 0x1
    /* 96028 800A5828 59FB010C */  jal        BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* 9602C 800A582C 080062AE */   sw        $v0, 0x8($s3)
    /* 96030 800A5830 9800B127 */  addiu      $s1, $sp, 0x98
    /* 96034 800A5834 21202002 */  addu       $a0, $s1, $zero
    /* 96038 800A5838 1000878E */  lw         $a3, 0x10($s4)
    /* 9603C 800A583C 1400888E */  lw         $t0, 0x14($s4)
    /* 96040 800A5840 1800898E */  lw         $t1, 0x18($s4)
    /* 96044 800A5844 9800A7AF */  sw         $a3, 0x98($sp)
    /* 96048 800A5848 9C00A8AF */  sw         $t0, 0x9C($sp)
    /* 9604C 800A584C A000A9AF */  sw         $t1, 0xA0($sp)
    /* 96050 800A5850 CF95020C */  jal        SetCautionSurface__FP8coorddefP12BWorldSm_Pos
    /* 96054 800A5854 1000A527 */   addiu     $a1, $sp, 0x10
    /* 96058 800A5858 21202002 */  addu       $a0, $s1, $zero
    /* 9605C 800A585C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 96060 800A5860 9800A28F */  lw         $v0, 0x98($sp)
    /* 96064 800A5864 FCFF103C */  lui        $s0, (0xFFFC0000 >> 16)
    /* 96068 800A5868 21105000 */  addu       $v0, $v0, $s0
    /* 9606C 800A586C CF95020C */  jal        SetCautionSurface__FP8coorddefP12BWorldSm_Pos
    /* 96070 800A5870 9800A2AF */   sw        $v0, 0x98($sp)
    /* 96074 800A5874 21202002 */  addu       $a0, $s1, $zero
    /* 96078 800A5878 1000A527 */  addiu      $a1, $sp, 0x10
    /* 9607C 800A587C 9800A28F */  lw         $v0, 0x98($sp)
    /* 96080 800A5880 0800123C */  lui        $s2, (0x80000 >> 16)
    /* 96084 800A5884 21105200 */  addu       $v0, $v0, $s2
    /* 96088 800A5888 CF95020C */  jal        SetCautionSurface__FP8coorddefP12BWorldSm_Pos
    /* 9608C 800A588C 9800A2AF */   sw        $v0, 0x98($sp)
    /* 96090 800A5890 21202002 */  addu       $a0, $s1, $zero
    /* 96094 800A5894 1000A527 */  addiu      $a1, $sp, 0x10
    /* 96098 800A5898 9800A28F */  lw         $v0, 0x98($sp)
    /* 9609C 800A589C A000A38F */  lw         $v1, 0xA0($sp)
    /* 960A0 800A58A0 21105000 */  addu       $v0, $v0, $s0
    /* 960A4 800A58A4 21187000 */  addu       $v1, $v1, $s0
    /* 960A8 800A58A8 9800A2AF */  sw         $v0, 0x98($sp)
    /* 960AC 800A58AC CF95020C */  jal        SetCautionSurface__FP8coorddefP12BWorldSm_Pos
    /* 960B0 800A58B0 A000A3AF */   sw        $v1, 0xA0($sp)
    /* 960B4 800A58B4 21202002 */  addu       $a0, $s1, $zero
    /* 960B8 800A58B8 A000A28F */  lw         $v0, 0xA0($sp)
    /* 960BC 800A58BC 1000A527 */  addiu      $a1, $sp, 0x10
    /* 960C0 800A58C0 21105200 */  addu       $v0, $v0, $s2
    /* 960C4 800A58C4 CF95020C */  jal        SetCautionSurface__FP8coorddefP12BWorldSm_Pos
    /* 960C8 800A58C8 A000A2AF */   sw        $v0, 0xA0($sp)
    /* 960CC 800A58CC 1000A487 */  lh         $a0, 0x10($sp)
    /* 960D0 800A58D0 5000838E */  lw         $v1, 0x50($s4)
    /* 960D4 800A58D4 9001A226 */  addiu      $v0, $s5, 0x190
    /* 960D8 800A58D8 0E0062A6 */  sh         $v0, 0xE($s3)
    /* 960DC 800A58DC 80FFC226 */  addiu      $v0, $s6, -0x80
    /* 960E0 800A58E0 431A0300 */  sra        $v1, $v1, 9
    /* 960E4 800A58E4 880D84AF */  sw         $a0, %gp_rel(Object_customSliceNum)($gp)
    /* 960E8 800A58E8 0C0063A6 */  sh         $v1, 0xC($s3)
    /* 960EC 800A58EC 120062A2 */  sb         $v0, 0x12($s3)
    /* 960F0 800A58F0 4C00828E */  lw         $v0, 0x4C($s4)
    /* 960F4 800A58F4 00000000 */  nop
    /* 960F8 800A58F8 09004228 */  slti       $v0, $v0, 0x9
    /* 960FC 800A58FC 02004014 */  bnez       $v0, .L800A5908
    /* 96100 800A5900 02000224 */   addiu     $v0, $zero, 0x2
    /* 96104 800A5904 01000224 */  addiu      $v0, $zero, 0x1
  .L800A5908:
    /* 96108 800A5908 130062A2 */  sb         $v0, 0x13($s3)
    /* 9610C 800A590C 800D838F */  lw         $v1, %gp_rel(Object_customSimObjs)($gp)
    /* 96110 800A5910 00000000 */  nop
    /* 96114 800A5914 0000628C */  lw         $v0, 0x0($v1)
    /* 96118 800A5918 00000000 */  nop
    /* 9611C 800A591C 01004224 */  addiu      $v0, $v0, 0x1
    /* 96120 800A5920 000062AC */  sw         $v0, 0x0($v1)
  .L800A5924:
    /* 96124 800A5924 800D828F */  lw         $v0, %gp_rel(Object_customSimObjs)($gp)
    /* 96128 800A5928 C400BF8F */  lw         $ra, 0xC4($sp)
    /* 9612C 800A592C C000B68F */  lw         $s6, 0xC0($sp)
    /* 96130 800A5930 BC00B58F */  lw         $s5, 0xBC($sp)
    /* 96134 800A5934 B800B48F */  lw         $s4, 0xB8($sp)
    /* 96138 800A5938 B400B38F */  lw         $s3, 0xB4($sp)
    /* 9613C 800A593C B000B28F */  lw         $s2, 0xB0($sp)
    /* 96140 800A5940 AC00B18F */  lw         $s1, 0xAC($sp)
    /* 96144 800A5944 0000428C */  lw         $v0, 0x0($v0)
    /* 96148 800A5948 A800B08F */  lw         $s0, 0xA8($sp)
    /* 9614C 800A594C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 96150 800A5950 0800E003 */  jr         $ra
    /* 96154 800A5954 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel Object_AddCustomSimObject__FP9SceneElemii
