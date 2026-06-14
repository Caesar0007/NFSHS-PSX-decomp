.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ChooseLoopedSample__F6s_typeT0, 0xBC

glabel ChooseLoopedSample__F6s_typeT0
    /* 68494 80077C94 02000224 */  addiu      $v0, $zero, 0x2
    /* 68498 80077C98 13008214 */  bne        $a0, $v0, .L80077CE8
    /* 6849C 80077C9C 2C000324 */   addiu     $v1, $zero, 0x2C
    /* 684A0 80077CA0 0200A014 */  bnez       $a1, .L80077CAC
    /* 684A4 80077CA4 10000224 */   addiu     $v0, $zero, 0x10
    /* 684A8 80077CA8 2A000324 */  addiu      $v1, $zero, 0x2A
  .L80077CAC:
    /* 684AC 80077CAC 0200A214 */  bne        $a1, $v0, .L80077CB8
    /* 684B0 80077CB0 11000224 */   addiu     $v0, $zero, 0x11
    /* 684B4 80077CB4 2D000324 */  addiu      $v1, $zero, 0x2D
  .L80077CB8:
    /* 684B8 80077CB8 0200A214 */  bne        $a1, $v0, .L80077CC4
    /* 684BC 80077CBC 12000224 */   addiu     $v0, $zero, 0x12
    /* 684C0 80077CC0 2E000324 */  addiu      $v1, $zero, 0x2E
  .L80077CC4:
    /* 684C4 80077CC4 0200A214 */  bne        $a1, $v0, .L80077CD0
    /* 684C8 80077CC8 0B000224 */   addiu     $v0, $zero, 0xB
    /* 684CC 80077CCC 2F000324 */  addiu      $v1, $zero, 0x2F
  .L80077CD0:
    /* 684D0 80077CD0 0200A214 */  bne        $a1, $v0, .L80077CDC
    /* 684D4 80077CD4 0C000224 */   addiu     $v0, $zero, 0xC
    /* 684D8 80077CD8 2B000324 */  addiu      $v1, $zero, 0x2B
  .L80077CDC:
    /* 684DC 80077CDC 0300A214 */  bne        $a1, $v0, .L80077CEC
    /* 684E0 80077CE0 01000224 */   addiu     $v0, $zero, 0x1
    /* 684E4 80077CE4 2C000324 */  addiu      $v1, $zero, 0x2C
  .L80077CE8:
    /* 684E8 80077CE8 01000224 */  addiu      $v0, $zero, 0x1
  .L80077CEC:
    /* 684EC 80077CEC 0B008214 */  bne        $a0, $v0, .L80077D1C
    /* 684F0 80077CF0 02000224 */   addiu     $v0, $zero, 0x2
    /* 684F4 80077CF4 0700A010 */  beqz       $a1, .L80077D14
    /* 684F8 80077CF8 10000224 */   addiu     $v0, $zero, 0x10
    /* 684FC 80077CFC 0500A210 */  beq        $a1, $v0, .L80077D14
    /* 68500 80077D00 03000224 */   addiu     $v0, $zero, 0x3
    /* 68504 80077D04 0300A210 */  beq        $a1, $v0, .L80077D14
    /* 68508 80077D08 0B000224 */   addiu     $v0, $zero, 0xB
    /* 6850C 80077D0C 0300A214 */  bne        $a1, $v0, .L80077D1C
    /* 68510 80077D10 02000224 */   addiu     $v0, $zero, 0x2
  .L80077D14:
    /* 68514 80077D14 28000324 */  addiu      $v1, $zero, 0x28
    /* 68518 80077D18 02000224 */  addiu      $v0, $zero, 0x2
  .L80077D1C:
    /* 6851C 80077D1C 05008214 */  bne        $a0, $v0, .L80077D34
    /* 68520 80077D20 01000224 */   addiu     $v0, $zero, 0x1
    /* 68524 80077D24 03000224 */  addiu      $v0, $zero, 0x3
    /* 68528 80077D28 0200A214 */  bne        $a1, $v0, .L80077D34
    /* 6852C 80077D2C 01000224 */   addiu     $v0, $zero, 0x1
    /* 68530 80077D30 29000324 */  addiu      $v1, $zero, 0x29
  .L80077D34:
    /* 68534 80077D34 04008214 */  bne        $a0, $v0, .L80077D48
    /* 68538 80077D38 0C000224 */   addiu     $v0, $zero, 0xC
    /* 6853C 80077D3C 0200A214 */  bne        $a1, $v0, .L80077D48
    /* 68540 80077D40 00000000 */   nop
    /* 68544 80077D44 2C000324 */  addiu      $v1, $zero, 0x2C
  .L80077D48:
    /* 68548 80077D48 0800E003 */  jr         $ra
    /* 6854C 80077D4C 21106000 */   addu      $v0, $v1, $zero
endlabel ChooseLoopedSample__F6s_typeT0
