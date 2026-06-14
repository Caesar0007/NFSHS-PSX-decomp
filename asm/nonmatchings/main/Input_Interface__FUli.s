.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_Interface__FUli, 0xA4

glabel Input_Interface__FUli
    /* 8DB18 8009D318 1700A010 */  beqz       $a1, .L8009D378
    /* 8DB1C 8009D31C 21308000 */   addu      $a2, $a0, $zero
    /* 8DB20 8009D320 1180053C */  lui        $a1, %hi(Input_gInterfaceResults)
    /* 8DB24 8009D324 1280023C */  lui        $v0, %hi(D_8011E0B4)
    /* 8DB28 8009D328 143FA524 */  addiu      $a1, $a1, %lo(Input_gInterfaceResults)
    /* 8DB2C 8009D32C 01000424 */  addiu      $a0, $zero, 0x1
    /* 8DB30 8009D330 B4E0428C */  lw         $v0, %lo(D_8011E0B4)($v0)
    /* 8DB34 8009D334 0420C400 */  sllv       $a0, $a0, $a2
    /* 8DB38 8009D338 1F004330 */  andi       $v1, $v0, 0x1F
    /* 8DB3C 8009D33C 80180300 */  sll        $v1, $v1, 2
    /* 8DB40 8009D340 21186500 */  addu       $v1, $v1, $a1
    /* 8DB44 8009D344 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 8DB48 8009D348 1F004230 */  andi       $v0, $v0, 0x1F
    /* 8DB4C 8009D34C 80100200 */  sll        $v0, $v0, 2
    /* 8DB50 8009D350 21104500 */  addu       $v0, $v0, $a1
    /* 8DB54 8009D354 0000638C */  lw         $v1, 0x0($v1)
    /* 8DB58 8009D358 0000428C */  lw         $v0, 0x0($v0)
    /* 8DB5C 8009D35C 24186400 */  and        $v1, $v1, $a0
    /* 8DB60 8009D360 27100200 */  nor        $v0, $zero, $v0
    /* 8DB64 8009D364 24186200 */  and        $v1, $v1, $v0
    /* 8DB68 8009D368 12006010 */  beqz       $v1, .L8009D3B4
    /* 8DB6C 8009D36C 21100000 */   addu      $v0, $zero, $zero
    /* 8DB70 8009D370 0800E003 */  jr         $ra
    /* 8DB74 8009D374 01000224 */   addiu     $v0, $zero, 0x1
  .L8009D378:
    /* 8DB78 8009D378 01000224 */  addiu      $v0, $zero, 0x1
    /* 8DB7C 8009D37C 1180043C */  lui        $a0, %hi(Input_gInterfaceResults)
    /* 8DB80 8009D380 1280033C */  lui        $v1, %hi(D_8011E0B4)
    /* 8DB84 8009D384 B4E0638C */  lw         $v1, %lo(D_8011E0B4)($v1)
    /* 8DB88 8009D388 143F8424 */  addiu      $a0, $a0, %lo(Input_gInterfaceResults)
    /* 8DB8C 8009D38C 1F006330 */  andi       $v1, $v1, 0x1F
    /* 8DB90 8009D390 80180300 */  sll        $v1, $v1, 2
    /* 8DB94 8009D394 21186400 */  addu       $v1, $v1, $a0
    /* 8DB98 8009D398 21204000 */  addu       $a0, $v0, $zero
    /* 8DB9C 8009D39C 0000638C */  lw         $v1, 0x0($v1)
    /* 8DBA0 8009D3A0 0420C400 */  sllv       $a0, $a0, $a2
    /* 8DBA4 8009D3A4 24186400 */  and        $v1, $v1, $a0
    /* 8DBA8 8009D3A8 02006014 */  bnez       $v1, .L8009D3B4
    /* 8DBAC 8009D3AC 00000000 */   nop
    /* 8DBB0 8009D3B0 21100000 */  addu       $v0, $zero, $zero
  .L8009D3B4:
    /* 8DBB4 8009D3B4 0800E003 */  jr         $ra
    /* 8DBB8 8009D3B8 00000000 */   nop
endlabel Input_Interface__FUli
