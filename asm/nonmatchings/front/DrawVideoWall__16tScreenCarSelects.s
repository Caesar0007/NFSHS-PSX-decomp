.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVideoWall__16tScreenCarSelects, 0x10C

glabel DrawVideoWall__16tScreenCarSelects
    /* 2C918 8003C118 08FFBD27 */  addiu      $sp, $sp, -0xF8
    /* 2C91C 8003C11C E800B0AF */  sw         $s0, 0xE8($sp)
    /* 2C920 8003C120 21808000 */  addu       $s0, $a0, $zero
    /* 2C924 8003C124 F000BFAF */  sw         $ra, 0xF0($sp)
    /* 2C928 8003C128 EC00B1AF */  sw         $s1, 0xEC($sp)
    /* 2C92C 8003C12C 6000028E */  lw         $v0, 0x60($s0)
    /* 2C930 8003C130 1800A527 */  addiu      $a1, $sp, 0x18
    /* 2C934 8003C134 68004484 */  lh         $a0, 0x68($v0)
    /* 2C938 8003C138 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2C93C 8003C13C 00000000 */  nop
    /* 2C940 8003C140 09F84000 */  jalr       $v0
    /* 2C944 8003C144 21200402 */   addu      $a0, $s0, $a0
    /* 2C948 8003C148 21200002 */  addu       $a0, $s0, $zero
    /* 2C94C 8003C14C 21280000 */  addu       $a1, $zero, $zero
    /* 2C950 8003C150 1C000624 */  addiu      $a2, $zero, 0x1C
    /* 2C954 8003C154 96000324 */  addiu      $v1, $zero, 0x96
    /* 2C958 8003C158 1000A3AF */  sw         $v1, 0x10($sp)
    /* 2C95C 8003C15C 0000078E */  lw         $a3, 0x0($s0)
    /* 2C960 8003C160 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 2C964 8003C164 21884000 */   addu      $s1, $v0, $zero
    /* 2C968 8003C168 0C01058E */  lw         $a1, 0x10C($s0)
    /* 2C96C 8003C16C 40EB000C */  jal        DrawOverlay__16tScreenCarSelectP8tOverlay
    /* 2C970 8003C170 21200002 */   addu      $a0, $s0, $zero
    /* 2C974 8003C174 3A000296 */  lhu        $v0, 0x3A($s0)
    /* 2C978 8003C178 00000000 */  nop
    /* 2C97C 8003C17C 01004230 */  andi       $v0, $v0, 0x1
    /* 2C980 8003C180 09004010 */  beqz       $v0, .L8003C1A8
    /* 2C984 8003C184 00000000 */   nop
    /* 2C988 8003C188 8403028E */  lw         $v0, 0x384($s0)
    /* 2C98C 8003C18C 00000000 */  nop
    /* 2C990 8003C190 05004014 */  bnez       $v0, .L8003C1A8
    /* 2C994 8003C194 00000000 */   nop
    /* 2C998 8003C198 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2C99C 8003C19C 04030426 */   addiu     $a0, $s0, 0x304
    /* 2C9A0 8003C1A0 01000224 */  addiu      $v0, $zero, 0x1
    /* 2C9A4 8003C1A4 840302AE */  sw         $v0, 0x384($s0)
  .L8003C1A8:
    /* 2C9A8 8003C1A8 5C000286 */  lh         $v0, 0x5C($s0)
    /* 2C9AC 8003C1AC 00000000 */  nop
    /* 2C9B0 8003C1B0 0B004018 */  blez       $v0, .L8003C1E0
    /* 2C9B4 8003C1B4 00000000 */   nop
    /* 2C9B8 8003C1B8 5400028E */  lw         $v0, 0x54($s0)
    /* 2C9BC 8003C1BC 00000000 */  nop
    /* 2C9C0 8003C1C0 07004010 */  beqz       $v0, .L8003C1E0
    /* 2C9C4 8003C1C4 00000000 */   nop
    /* 2C9C8 8003C1C8 9FDB000C */  jal        TurnOffInstant__10tVideoWall
    /* 2C9CC 8003C1CC 04030426 */   addiu     $a0, $s0, 0x304
    /* 2C9D0 8003C1D0 21200002 */  addu       $a0, $s0, $zero
    /* 2C9D4 8003C1D4 21280000 */  addu       $a1, $zero, $zero
    /* 2C9D8 8003C1D8 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2C9DC 8003C1DC 2130A000 */   addu      $a2, $a1, $zero
  .L8003C1E0:
    /* 2C9E0 8003C1E0 04031026 */  addiu      $s0, $s0, 0x304
    /* 2C9E4 8003C1E4 79DA000C */  jal        UpdateTransition__10tVideoWall
    /* 2C9E8 8003C1E8 21200002 */   addu      $a0, $s0, $zero
    /* 2C9EC 8003C1EC 21200002 */  addu       $a0, $s0, $zero
    /* 2C9F0 8003C1F0 002C1100 */  sll        $a1, $s1, 16
    /* 2C9F4 8003C1F4 77DA000C */  jal        SetValid__10tVideoWalls
    /* 2C9F8 8003C1F8 032C0500 */   sra       $a1, $a1, 16
    /* 2C9FC 8003C1FC 1F00A593 */  lbu        $a1, 0x1F($sp)
    /* 2CA00 8003C200 75DA000C */  jal        SetAvailable__10tVideoWalls
    /* 2CA04 8003C204 21200002 */   addu      $a0, $s0, $zero
    /* 2CA08 8003C208 EDDA000C */  jal        Draw__10tVideoWall
    /* 2CA0C 8003C20C 21200002 */   addu      $a0, $s0, $zero
    /* 2CA10 8003C210 F000BF8F */  lw         $ra, 0xF0($sp)
    /* 2CA14 8003C214 EC00B18F */  lw         $s1, 0xEC($sp)
    /* 2CA18 8003C218 E800B08F */  lw         $s0, 0xE8($sp)
    /* 2CA1C 8003C21C 0800E003 */  jr         $ra
    /* 2CA20 8003C220 F800BD27 */   addiu     $sp, $sp, 0xF8
endlabel DrawVideoWall__16tScreenCarSelects
