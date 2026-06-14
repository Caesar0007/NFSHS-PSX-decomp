.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_StartUp__Fv, 0xC4

glabel Input_StartUp__Fv
    /* 8CB44 8009C344 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8CB48 8009C348 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8CB4C 8009C34C 6EF5020C */  jal        Device_StartUp__Fv
    /* 8CB50 8009C350 00000000 */   nop
    /* 8CB54 8009C354 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* 8CB58 8009C358 143C4224 */  addiu      $v0, $v0, %lo(Input_gHandler)
    /* 8CB5C 8009C35C B7000524 */  addiu      $a1, $zero, 0xB7
  .L8009C360:
    /* 8CB60 8009C360 000040AC */  sw         $zero, 0x0($v0)
    /* 8CB64 8009C364 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* 8CB68 8009C368 FDFFA104 */  bgez       $a1, .L8009C360
    /* 8CB6C 8009C36C 04004224 */   addiu     $v0, $v0, 0x4
    /* 8CB70 8009C370 21280000 */  addu       $a1, $zero, $zero
    /* 8CB74 8009C374 1180023C */  lui        $v0, %hi(Input_gPressTime)
    /* 8CB78 8009C378 943F4924 */  addiu      $t1, $v0, %lo(Input_gPressTime)
    /* 8CB7C 8009C37C 2140A000 */  addu       $t0, $a1, $zero
    /* 8CB80 8009C380 1480073C */  lui        $a3, %hi(Input_gMode)
    /* 8CB84 8009C384 38D2E724 */  addiu      $a3, $a3, %lo(Input_gMode)
    /* 8CB88 8009C388 1180023C */  lui        $v0, %hi(Input_gDBFlags)
    /* 8CB8C 8009C38C F43E4624 */  addiu      $a2, $v0, %lo(Input_gDBFlags)
  .L8009C390:
    /* 8CB90 8009C390 0200A228 */  slti       $v0, $a1, 0x2
    /* 8CB94 8009C394 0F004010 */  beqz       $v0, .L8009C3D4
    /* 8CB98 8009C398 21200000 */   addu      $a0, $zero, $zero
    /* 8CB9C 8009C39C 21180001 */  addu       $v1, $t0, $zero
    /* 8CBA0 8009C3A0 0000C0AC */  sw         $zero, 0x0($a2)
    /* 8CBA4 8009C3A4 0000E0AC */  sw         $zero, 0x0($a3)
  .L8009C3A8:
    /* 8CBA8 8009C3A8 21106900 */  addu       $v0, $v1, $t1
    /* 8CBAC 8009C3AC 000040AC */  sw         $zero, 0x0($v0)
    /* 8CBB0 8009C3B0 01008424 */  addiu      $a0, $a0, 0x1
    /* 8CBB4 8009C3B4 11008228 */  slti       $v0, $a0, 0x11
    /* 8CBB8 8009C3B8 FBFF4014 */  bnez       $v0, .L8009C3A8
    /* 8CBBC 8009C3BC 04006324 */   addiu     $v1, $v1, 0x4
    /* 8CBC0 8009C3C0 44000825 */  addiu      $t0, $t0, 0x44
    /* 8CBC4 8009C3C4 0400E724 */  addiu      $a3, $a3, 0x4
    /* 8CBC8 8009C3C8 0400C624 */  addiu      $a2, $a2, 0x4
    /* 8CBCC 8009C3CC E4700208 */  j          .L8009C390
    /* 8CBD0 8009C3D0 0100A524 */   addiu     $a1, $a1, 0x1
  .L8009C3D4:
    /* 8CBD4 8009C3D4 1F000524 */  addiu      $a1, $zero, 0x1F
    /* 8CBD8 8009C3D8 1180023C */  lui        $v0, %hi(Input_gInterfaceResults)
    /* 8CBDC 8009C3DC 143F4224 */  addiu      $v0, $v0, %lo(Input_gInterfaceResults)
    /* 8CBE0 8009C3E0 7C004224 */  addiu      $v0, $v0, 0x7C
  .L8009C3E4:
    /* 8CBE4 8009C3E4 000040AC */  sw         $zero, 0x0($v0)
    /* 8CBE8 8009C3E8 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* 8CBEC 8009C3EC FDFFA104 */  bgez       $a1, .L8009C3E4
    /* 8CBF0 8009C3F0 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8CBF4 8009C3F4 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* 8CBF8 8009C3F8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8CBFC 8009C3FC 143C4224 */  addiu      $v0, $v0, %lo(Input_gHandler)
    /* 8CC00 8009C400 0800E003 */  jr         $ra
    /* 8CC04 8009C404 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Input_StartUp__Fv
