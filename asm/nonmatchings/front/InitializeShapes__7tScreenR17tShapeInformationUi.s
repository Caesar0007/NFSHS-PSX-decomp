.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeShapes__7tScreenR17tShapeInformationUi, 0xA8

glabel InitializeShapes__7tScreenR17tShapeInformationUi
    /* 16BEC 800263EC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 16BF0 800263F0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 16BF4 800263F4 2180A000 */  addu       $s0, $a1, $zero
    /* 16BF8 800263F8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 16BFC 800263FC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 16C00 80026400 0000048E */  lw         $a0, 0x0($s0)
    /* 16C04 80026404 00000000 */  nop
    /* 16C08 80026408 04008010 */  beqz       $a0, .L8002641C
    /* 16C0C 8002640C 2188C000 */   addu      $s1, $a2, $zero
    /* 16C10 80026410 5095030C */  jal        purgememadr
    /* 16C14 80026414 00000000 */   nop
    /* 16C18 80026418 000000AE */  sw         $zero, 0x0($s0)
  .L8002641C:
    /* 16C1C 8002641C 120000A6 */  sh         $zero, 0x12($s0)
    /* 16C20 80026420 100011A6 */  sh         $s1, 0x10($s0)
    /* 16C24 80026424 0C0000AE */  sw         $zero, 0xC($s0)
    /* 16C28 80026428 040000AE */  sw         $zero, 0x4($s0)
    /* 16C2C 8002642C 080000AE */  sw         $zero, 0x8($s0)
    /* 16C30 80026430 13002012 */  beqz       $s1, .L80026480
    /* 16C34 80026434 240000AE */   sw        $zero, 0x24($s0)
    /* 16C38 80026438 0180043C */  lui        $a0, %hi(D_8001140C)
    /* 16C3C 8002643C 0C148424 */  addiu      $a0, $a0, %lo(D_8001140C)
    /* 16C40 80026440 40291100 */  sll        $a1, $s1, 5
    /* 16C44 80026444 CF94030C */  jal        reservememadr
    /* 16C48 80026448 21300000 */   addu      $a2, $zero, $zero
    /* 16C4C 8002644C 000002AE */  sw         $v0, 0x0($s0)
    /* 16C50 80026450 0B002012 */  beqz       $s1, .L80026480
    /* 16C54 80026454 21200000 */   addu      $a0, $zero, $zero
    /* 16C58 80026458 FFFF8230 */  andi       $v0, $a0, 0xFFFF
  .L8002645C:
    /* 16C5C 8002645C 01008424 */  addiu      $a0, $a0, 0x1
    /* 16C60 80026460 0000038E */  lw         $v1, 0x0($s0)
    /* 16C64 80026464 40110200 */  sll        $v0, $v0, 5
    /* 16C68 80026468 21104300 */  addu       $v0, $v0, $v1
    /* 16C6C 8002646C 040040AC */  sw         $zero, 0x4($v0)
    /* 16C70 80026470 FFFF8230 */  andi       $v0, $a0, 0xFFFF
    /* 16C74 80026474 2B105100 */  sltu       $v0, $v0, $s1
    /* 16C78 80026478 F8FF4014 */  bnez       $v0, .L8002645C
    /* 16C7C 8002647C FFFF8230 */   andi      $v0, $a0, 0xFFFF
  .L80026480:
    /* 16C80 80026480 1800BF8F */  lw         $ra, 0x18($sp)
    /* 16C84 80026484 1400B18F */  lw         $s1, 0x14($sp)
    /* 16C88 80026488 1000B08F */  lw         $s0, 0x10($sp)
    /* 16C8C 8002648C 0800E003 */  jr         $ra
    /* 16C90 80026490 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel InitializeShapes__7tScreenR17tShapeInformationUi
