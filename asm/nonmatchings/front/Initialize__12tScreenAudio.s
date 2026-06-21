.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__12tScreenAudio, 0x60

glabel Initialize__12tScreenAudio
    /* 369A4 800461A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 369A8 800461A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 369AC 800461AC 21808000 */  addu       $s0, $a0, $zero
    /* 369B0 800461B0 0580023C */  lui        $v0, %hi(menuDefs)
    /* 369B4 800461B4 581A468C */  lw         $a2, %lo(menuDefs)($v0)
    /* 369B8 800461B8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 369BC 800461BC 01000524 */  addiu      $a1, $zero, 0x1
    /* 369C0 800461C0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 369C4 800461C4 700002A6 */  sh         $v0, 0x70($s0)
    /* 369C8 800461C8 1027C424 */  addiu      $a0, $a2, 0x2710
    /* 369CC 800461CC 4A77000C */  jal        SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
    /* 369D0 800461D0 5827C624 */   addiu     $a2, $a2, 0x2758
    /* 369D4 800461D4 2B98000C */  jal        Initialize__7tScreen
    /* 369D8 800461D8 21200002 */   addu      $a0, $s0, $zero
    /* 369DC 800461DC 1180023C */  lui        $v0, %hi(D_80114946)
    /* 369E0 800461E0 46494290 */  lbu        $v0, %lo(D_80114946)($v0)
    /* 369E4 800461E4 680000A6 */  sh         $zero, 0x68($s0)
    /* 369E8 800461E8 6C0000AE */  sw         $zero, 0x6C($s0)
    /* 369EC 800461EC 780000AE */  sw         $zero, 0x78($s0)
    /* 369F0 800461F0 660002A2 */  sb         $v0, 0x66($s0)
    /* 369F4 800461F4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 369F8 800461F8 1000B08F */  lw         $s0, 0x10($sp)
    /* 369FC 800461FC 0800E003 */  jr         $ra
    /* 36A00 80046200 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__12tScreenAudio
