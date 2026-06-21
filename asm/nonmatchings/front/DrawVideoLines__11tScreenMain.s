.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVideoLines__11tScreenMain, 0xA8

glabel DrawVideoLines__11tScreenMain
    /* 28118 80037918 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 2811C 8003791C 1800B0AF */  sw         $s0, 0x18($sp)
    /* 28120 80037920 F3001024 */  addiu      $s0, $zero, 0xF3
    /* 28124 80037924 2000B2AF */  sw         $s2, 0x20($sp)
    /* 28128 80037928 A9001224 */  addiu      $s2, $zero, 0xA9
    /* 2812C 8003792C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 28130 80037930 01001124 */  addiu      $s1, $zero, 0x1
    /* 28134 80037934 2400BFAF */  sw         $ra, 0x24($sp)
    /* 28138 80037938 3000043C */  lui        $a0, (0x303030 >> 16)
  .L8003793C:
    /* 2813C 8003793C 30308434 */  ori        $a0, $a0, (0x303030 & 0xFFFF)
    /* 28140 80037940 21280002 */  addu       $a1, $s0, $zero
    /* 28144 80037944 2A000624 */  addiu      $a2, $zero, 0x2A
    /* 28148 80037948 02000724 */  addiu      $a3, $zero, 0x2
    /* 2814C 8003794C 1000B2AF */  sw         $s2, 0x10($sp)
    /* 28150 80037950 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 28154 80037954 1400B1AF */   sw        $s1, 0x14($sp)
    /* 28158 80037958 50001026 */  addiu      $s0, $s0, 0x50
    /* 2815C 8003795C E301022A */  slti       $v0, $s0, 0x1E3
    /* 28160 80037960 F6FF4014 */  bnez       $v0, .L8003793C
    /* 28164 80037964 3000043C */   lui       $a0, (0x303030 >> 16)
    /* 28168 80037968 54001024 */  addiu      $s0, $zero, 0x54
    /* 2816C 8003796C 01001124 */  addiu      $s1, $zero, 0x1
    /* 28170 80037970 2000043C */  lui        $a0, (0x202020 >> 16)
  .L80037974:
    /* 28174 80037974 20208434 */  ori        $a0, $a0, (0x202020 & 0xFFFF)
    /* 28178 80037978 A3000524 */  addiu      $a1, $zero, 0xA3
    /* 2817C 8003797C 21300002 */  addu       $a2, $s0, $zero
    /* 28180 80037980 41010724 */  addiu      $a3, $zero, 0x141
    /* 28184 80037984 1000B1AF */  sw         $s1, 0x10($sp)
    /* 28188 80037988 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 2818C 8003798C 1400B1AF */   sw        $s1, 0x14($sp)
    /* 28190 80037990 2A001026 */  addiu      $s0, $s0, 0x2A
    /* 28194 80037994 D200022A */  slti       $v0, $s0, 0xD2
    /* 28198 80037998 F6FF4014 */  bnez       $v0, .L80037974
    /* 2819C 8003799C 2000043C */   lui       $a0, (0x202020 >> 16)
    /* 281A0 800379A0 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 281A4 800379A4 02000424 */   addiu     $a0, $zero, 0x2
    /* 281A8 800379A8 2400BF8F */  lw         $ra, 0x24($sp)
    /* 281AC 800379AC 2000B28F */  lw         $s2, 0x20($sp)
    /* 281B0 800379B0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 281B4 800379B4 1800B08F */  lw         $s0, 0x18($sp)
    /* 281B8 800379B8 0800E003 */  jr         $ra
    /* 281BC 800379BC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawVideoLines__11tScreenMain
