.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_DeInitAICar__FP8Car_tObj, 0x80

glabel AIInit_DeInitAICar__FP8Car_tObj
    /* 57CE8 800674E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57CEC 800674EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 57CF0 800674F0 21808000 */  addu       $s0, $a0, $zero
    /* 57CF4 800674F4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 57CF8 800674F8 B406038E */  lw         $v1, 0x6B4($s0)
    /* 57CFC 800674FC 00000000 */  nop
    /* 57D00 80067500 09006010 */  beqz       $v1, .L80067528
    /* 57D04 80067504 03000524 */   addiu     $a1, $zero, 0x3
    /* 57D08 80067508 5400628C */  lw         $v0, 0x54($v1)
    /* 57D0C 8006750C 00000000 */  nop
    /* 57D10 80067510 08004484 */  lh         $a0, 0x8($v0)
    /* 57D14 80067514 0C00428C */  lw         $v0, 0xC($v0)
    /* 57D18 80067518 00000000 */  nop
    /* 57D1C 8006751C 09F84000 */  jalr       $v0
    /* 57D20 80067520 21206400 */   addu      $a0, $v1, $a0
    /* 57D24 80067524 B40600AE */  sw         $zero, 0x6B4($s0)
  .L80067528:
    /* 57D28 80067528 B006038E */  lw         $v1, 0x6B0($s0)
    /* 57D2C 8006752C 00000000 */  nop
    /* 57D30 80067530 09006010 */  beqz       $v1, .L80067558
    /* 57D34 80067534 03000524 */   addiu     $a1, $zero, 0x3
    /* 57D38 80067538 5400628C */  lw         $v0, 0x54($v1)
    /* 57D3C 8006753C 00000000 */  nop
    /* 57D40 80067540 08004484 */  lh         $a0, 0x8($v0)
    /* 57D44 80067544 0C00428C */  lw         $v0, 0xC($v0)
    /* 57D48 80067548 00000000 */  nop
    /* 57D4C 8006754C 09F84000 */  jalr       $v0
    /* 57D50 80067550 21206400 */   addu      $a0, $v1, $a0
    /* 57D54 80067554 B00600AE */  sw         $zero, 0x6B0($s0)
  .L80067558:
    /* 57D58 80067558 1400BF8F */  lw         $ra, 0x14($sp)
    /* 57D5C 8006755C 1000B08F */  lw         $s0, 0x10($sp)
    /* 57D60 80067560 0800E003 */  jr         $ra
    /* 57D64 80067564 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIInit_DeInitAICar__FP8Car_tObj
