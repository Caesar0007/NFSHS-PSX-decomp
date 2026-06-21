.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __17tUserNameMenuItemUi, 0x74

glabel __17tUserNameMenuItemUi
    /* 10438 8001FC38 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1043C 8001FC3C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 10440 8001FC40 1400BFAF */  sw         $ra, 0x14($sp)
    /* 10444 8001FC44 CD91000C */  jal        __9tMenuItemUi
    /* 10448 8001FC48 21808000 */   addu      $s0, $a0, $zero
    /* 1044C 8001FC4C 21200000 */  addu       $a0, $zero, $zero
    /* 10450 8001FC50 0180023C */  lui        $v0, %hi(_vt_17tUserNameMenuItem)
    /* 10454 8001FC54 180B4224 */  addiu      $v0, $v0, %lo(_vt_17tUserNameMenuItem)
    /* 10458 8001FC58 180002AE */  sw         $v0, 0x18($s0)
    /* 1045C 8001FC5C 240000A6 */  sh         $zero, 0x24($s0)
    /* 10460 8001FC60 220000A6 */  sh         $zero, 0x22($s0)
  .L8001FC64:
    /* 10464 8001FC64 001C0400 */  sll        $v1, $a0, 16
    /* 10468 8001FC68 031C0300 */  sra        $v1, $v1, 16
    /* 1046C 8001FC6C C0100300 */  sll        $v0, $v1, 3
    /* 10470 8001FC70 21104300 */  addu       $v0, $v0, $v1
    /* 10474 8001FC74 21100202 */  addu       $v0, $s0, $v0
    /* 10478 8001FC78 260040A0 */  sb         $zero, 0x26($v0)
    /* 1047C 8001FC7C 01008224 */  addiu      $v0, $a0, 0x1
    /* 10480 8001FC80 21204000 */  addu       $a0, $v0, $zero
    /* 10484 8001FC84 00140200 */  sll        $v0, $v0, 16
    /* 10488 8001FC88 03140200 */  sra        $v0, $v0, 16
    /* 1048C 8001FC8C 0A004228 */  slti       $v0, $v0, 0xA
    /* 10490 8001FC90 F4FF4014 */  bnez       $v0, .L8001FC64
    /* 10494 8001FC94 21100002 */   addu      $v0, $s0, $zero
    /* 10498 8001FC98 1C0000AE */  sw         $zero, 0x1C($s0)
    /* 1049C 8001FC9C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 104A0 8001FCA0 1000B08F */  lw         $s0, 0x10($sp)
    /* 104A4 8001FCA4 0800E003 */  jr         $ra
    /* 104A8 8001FCA8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __17tUserNameMenuItemUi
