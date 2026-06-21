.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PreLoad__7tScreen, 0x84

glabel PreLoad__7tScreen
    /* 16F80 80026780 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 16F84 80026784 2800B0AF */  sw         $s0, 0x28($sp)
    /* 16F88 80026788 21808000 */  addu       $s0, $a0, $zero
    /* 16F8C 8002678C 1800A527 */  addiu      $a1, $sp, 0x18
    /* 16F90 80026790 1A00A627 */  addiu      $a2, $sp, 0x1A
    /* 16F94 80026794 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 16F98 80026798 6000038E */  lw         $v1, 0x60($s0)
    /* 16F9C 8002679C 2000A227 */  addiu      $v0, $sp, 0x20
    /* 16FA0 800267A0 08006484 */  lh         $a0, 0x8($v1)
    /* 16FA4 800267A4 1C00A727 */  addiu      $a3, $sp, 0x1C
    /* 16FA8 800267A8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 16FAC 800267AC 0C00628C */  lw         $v0, 0xC($v1)
    /* 16FB0 800267B0 00000000 */  nop
    /* 16FB4 800267B4 09F84000 */  jalr       $v0
    /* 16FB8 800267B8 21200402 */   addu      $a0, $s0, $a0
    /* 16FBC 800267BC 21200002 */  addu       $a0, $s0, $zero
    /* 16FC0 800267C0 1800A687 */  lh         $a2, 0x18($sp)
    /* 16FC4 800267C4 FB98000C */  jal        InitializeShapes__7tScreenR17tShapeInformationUi
    /* 16FC8 800267C8 21280002 */   addu      $a1, $s0, $zero
    /* 16FCC 800267CC 21200002 */  addu       $a0, $s0, $zero
    /* 16FD0 800267D0 1A00A687 */  lh         $a2, 0x1A($sp)
    /* 16FD4 800267D4 FB98000C */  jal        InitializeShapes__7tScreenR17tShapeInformationUi
    /* 16FD8 800267D8 28000526 */   addiu     $a1, $s0, 0x28
    /* 16FDC 800267DC 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 16FE0 800267E0 6697000C */  jal        AsyncLoadPermanentShapeFile__7tScreenPc
    /* 16FE4 800267E4 21200002 */   addu      $a0, $s0, $zero
    /* 16FE8 800267E8 2000A58F */  lw         $a1, 0x20($sp)
    /* 16FEC 800267EC 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 16FF0 800267F0 21200002 */   addu      $a0, $s0, $zero
    /* 16FF4 800267F4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 16FF8 800267F8 2800B08F */  lw         $s0, 0x28($sp)
    /* 16FFC 800267FC 0800E003 */  jr         $ra
    /* 17000 80026800 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel PreLoad__7tScreen
