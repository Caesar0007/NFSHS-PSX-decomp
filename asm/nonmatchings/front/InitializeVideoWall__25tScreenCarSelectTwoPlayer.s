.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeVideoWall__25tScreenCarSelectTwoPlayer, 0x7C

glabel InitializeVideoWall__25tScreenCarSelectTwoPlayer
    /* 2F544 8003ED44 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 2F548 8003ED48 2000B0AF */  sw         $s0, 0x20($sp)
    /* 2F54C 8003ED4C 21808000 */  addu       $s0, $a0, $zero
    /* 2F550 8003ED50 2400B1AF */  sw         $s1, 0x24($sp)
    /* 2F554 8003ED54 04031126 */  addiu      $s1, $s0, 0x304
    /* 2F558 8003ED58 21202002 */  addu       $a0, $s1, $zero
    /* 2F55C 8003ED5C 05000224 */  addiu      $v0, $zero, 0x5
    /* 2F560 8003ED60 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2F564 8003ED64 0580023C */  lui        $v0, %hi(D_80051F98)
    /* 2F568 8003ED68 981F4224 */  addiu      $v0, $v0, %lo(D_80051F98)
    /* 2F56C 8003ED6C 24010526 */  addiu      $a1, $s0, 0x124
    /* 2F570 8003ED70 2800BFAF */  sw         $ra, 0x28($sp)
    /* 2F574 8003ED74 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2F578 8003ED78 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2F57C 8003ED7C 2800068E */  lw         $a2, 0x28($s0)
    /* 2F580 8003ED80 E4D9000C */  jal        Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 2F584 8003ED84 21380000 */   addu      $a3, $zero, $zero
    /* 2F588 8003ED88 3A000296 */  lhu        $v0, 0x3A($s0)
    /* 2F58C 8003ED8C 00000000 */  nop
    /* 2F590 8003ED90 01004230 */  andi       $v0, $v0, 0x1
    /* 2F594 8003ED94 05004010 */  beqz       $v0, .L8003EDAC
    /* 2F598 8003ED98 00000000 */   nop
    /* 2F59C 8003ED9C 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2F5A0 8003EDA0 21202002 */   addu      $a0, $s1, $zero
    /* 2F5A4 8003EDA4 01000224 */  addiu      $v0, $zero, 0x1
    /* 2F5A8 8003EDA8 840302AE */  sw         $v0, 0x384($s0)
  .L8003EDAC:
    /* 2F5AC 8003EDAC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 2F5B0 8003EDB0 2400B18F */  lw         $s1, 0x24($sp)
    /* 2F5B4 8003EDB4 2000B08F */  lw         $s0, 0x20($sp)
    /* 2F5B8 8003EDB8 0800E003 */  jr         $ra
    /* 2F5BC 8003EDBC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel InitializeVideoWall__25tScreenCarSelectTwoPlayer
