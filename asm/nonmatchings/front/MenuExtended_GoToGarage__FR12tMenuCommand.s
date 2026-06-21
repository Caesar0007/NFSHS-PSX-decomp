.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToGarage__FR12tMenuCommand, 0xA8

glabel MenuExtended_GoToGarage__FR12tMenuCommand
    /* 1E89C 8002E09C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1E8A0 8002E0A0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1E8A4 8002E0A4 21888000 */  addu       $s1, $a0, $zero
    /* 1E8A8 8002E0A8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1E8AC 8002E0AC 1180033C */  lui        $v1, %hi(D_8011472A)
    /* 1E8B0 8002E0B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1E8B4 8002E0B4 0580103C */  lui        $s0, %hi(menuDefs)
    /* 1E8B8 8002E0B8 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1E8BC 8002E0BC 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E8C0 8002E0C0 2A4762A0 */  sb         $v0, %lo(D_8011472A)($v1)
    /* 1E8C4 8002E0C4 40000224 */  addiu      $v0, $zero, 0x40
    /* 1E8C8 8002E0C8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 1E8CC 8002E0CC CC128424 */  addiu      $a0, $a0, 0x12CC
    /* 1E8D0 8002E0D0 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1E8D4 8002E0D4 100082AC */   sw        $v0, 0x10($a0)
    /* 1E8D8 8002E0D8 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1E8DC 8002E0DC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1E8E0 8002E0E0 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1E8E4 8002E0E4 CC128424 */   addiu     $a0, $a0, 0x12CC
    /* 1E8E8 8002E0E8 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E8EC 8002E0EC 000022AE */  sw         $v0, 0x0($s1)
    /* 1E8F0 8002E0F0 1180023C */  lui        $v0, %hi(D_80114AE4)
    /* 1E8F4 8002E0F4 E44A428C */  lw         $v0, %lo(D_80114AE4)($v0)
    /* 1E8F8 8002E0F8 00000000 */  nop
    /* 1E8FC 8002E0FC 04004014 */  bnez       $v0, .L8002E110
    /* 1E900 8002E100 00000000 */   nop
    /* 1E904 8002E104 581A028E */  lw         $v0, %lo(menuDefs)($s0)
    /* 1E908 8002E108 47B80008 */  j          .L8002E11C
    /* 1E90C 8002E10C 68134224 */   addiu     $v0, $v0, 0x1368
  .L8002E110:
    /* 1E910 8002E110 581A028E */  lw         $v0, %lo(menuDefs)($s0)
    /* 1E914 8002E114 00000000 */  nop
    /* 1E918 8002E118 E4134224 */  addiu      $v0, $v0, 0x13E4
  .L8002E11C:
    /* 1E91C 8002E11C 040022AE */  sw         $v0, 0x4($s1)
    /* 1E920 8002E120 0580023C */  lui        $v0, %hi(screenCarSelect)
    /* 1E924 8002E124 3C20448C */  lw         $a0, %lo(screenCarSelect)($v0)
    /* 1E928 8002E128 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1E92C 8002E12C 01000524 */   addiu     $a1, $zero, 0x1
    /* 1E930 8002E130 1800BF8F */  lw         $ra, 0x18($sp)
    /* 1E934 8002E134 1400B18F */  lw         $s1, 0x14($sp)
    /* 1E938 8002E138 1000B08F */  lw         $s0, 0x10($sp)
    /* 1E93C 8002E13C 0800E003 */  jr         $ra
    /* 1E940 8002E140 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MenuExtended_GoToGarage__FR12tMenuCommand
