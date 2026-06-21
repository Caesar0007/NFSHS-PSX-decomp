.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToBestOfThree__FR12tMenuCommand, 0x5C

glabel MenuExtended_GoToBestOfThree__FR12tMenuCommand
    /* 1D3E0 8002CBE0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1D3E4 8002CBE4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1D3E8 8002CBE8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1D3EC 8002CBEC AFB2000C */  jal        PinkSlipsPreSave__Fv
    /* 1D3F0 8002CBF0 21808000 */   addu      $s0, $a0, $zero
    /* 1D3F4 8002CBF4 07004010 */  beqz       $v0, .L8002CC14
    /* 1D3F8 8002CBF8 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1D3FC 8002CBFC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1D400 8002CC00 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D404 8002CC04 000003AE */  sw         $v1, 0x0($s0)
    /* 1D408 8002CC08 900B4224 */  addiu      $v0, $v0, 0xB90
    /* 1D40C 8002CC0C 06B30008 */  j          .L8002CC18
    /* 1D410 8002CC10 040002AE */   sw        $v0, 0x4($s0)
  .L8002CC14:
    /* 1D414 8002CC14 000000AE */  sw         $zero, 0x0($s0)
  .L8002CC18:
    /* 1D418 8002CC18 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1D41C 8002CC1C 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 1D420 8002CC20 03000324 */  addiu      $v1, $zero, 0x3
    /* 1D424 8002CC24 460040A0 */  sb         $zero, 0x46($v0)
    /* 1D428 8002CC28 470043A0 */  sb         $v1, 0x47($v0)
    /* 1D42C 8002CC2C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1D430 8002CC30 1000B08F */  lw         $s0, 0x10($sp)
    /* 1D434 8002CC34 0800E003 */  jr         $ra
    /* 1D438 8002CC38 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_GoToBestOfThree__FR12tMenuCommand
