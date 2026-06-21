.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand, 0x114

glabel MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand
    /* 1CA88 8002C288 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 1CA8C 8002C28C BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 1CA90 8002C290 21888000 */  addu       $s1, $a0, $zero
    /* 1CA94 8002C294 B800B0AF */  sw         $s0, 0xB8($sp)
    /* 1CA98 8002C298 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1CA9C 8002C29C C000BFAF */  sw         $ra, 0xC0($sp)
    /* 1CAA0 8002C2A0 A366000C */  jal        __12tDialogYesNo
    /* 1CAA4 8002C2A4 21200002 */   addu      $a0, $s0, $zero
    /* 1CAA8 8002C2A8 0180023C */  lui        $v0, %hi(_vt_15tDialogYesNoTri)
    /* 1CAAC 8002C2AC B0024224 */  addiu      $v0, $v0, %lo(_vt_15tDialogYesNoTri)
    /* 1CAB0 8002C2B0 1180043C */  lui        $a0, %hi(carManager)
    /* 1CAB4 8002C2B4 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1CAB8 8002C2B8 21280000 */  addu       $a1, $zero, $zero
    /* 1CABC 8002C2BC CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1CAC0 8002C2C0 600002AE */   sw        $v0, 0x60($s0)
    /* 1CAC4 8002C2C4 00140200 */  sll        $v0, $v0, 16
    /* 1CAC8 8002C2C8 2400401C */  bgtz       $v0, .L8002C35C
    /* 1CACC 8002C2CC 00000000 */   nop
    /* 1CAD0 8002C2D0 94E4020C */  jal        TextSys_Word__Fi
    /* 1CAD4 8002C2D4 42000424 */   addiu     $a0, $zero, 0x42
    /* 1CAD8 8002C2D8 21200002 */  addu       $a0, $s0, $zero
    /* 1CADC 8002C2DC 900082AC */  sw         $v0, 0x90($a0)
    /* 1CAE0 8002C2E0 21030224 */  addiu      $v0, $zero, 0x321
    /* 1CAE4 8002C2E4 A00082AC */  sw         $v0, 0xA0($a0)
    /* 1CAE8 8002C2E8 22030224 */  addiu      $v0, $zero, 0x322
    /* 1CAEC 8002C2EC A40082AC */  sw         $v0, 0xA4($a0)
    /* 1CAF0 8002C2F0 FA65000C */  jal        Run__18tDialogInteractive
    /* 1CAF4 8002C2F4 880080A4 */   sh        $zero, 0x88($a0)
    /* 1CAF8 8002C2F8 00140200 */  sll        $v0, $v0, 16
    /* 1CAFC 8002C2FC 031C0200 */  sra        $v1, $v0, 16
    /* 1CB00 8002C300 01000224 */  addiu      $v0, $zero, 0x1
    /* 1CB04 8002C304 1D006214 */  bne        $v1, $v0, .L8002C37C
    /* 1CB08 8002C308 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 1CB0C 8002C30C 0580103C */  lui        $s0, %hi(menuDefs)
    /* 1CB10 8002C310 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CB14 8002C314 1180023C */  lui        $v0, %hi(D_80114604)
    /* 1CB18 8002C318 044640A0 */  sb         $zero, %lo(D_80114604)($v0)
    /* 1CB1C 8002C31C 000023AE */  sw         $v1, 0x0($s1)
    /* 1CB20 8002C320 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1CB24 8002C324 641C8424 */   addiu     $a0, $a0, 0x1C64
    /* 1CB28 8002C328 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CB2C 8002C32C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1CB30 8002C330 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1CB34 8002C334 641C8424 */   addiu     $a0, $a0, 0x1C64
    /* 1CB38 8002C338 02000524 */  addiu      $a1, $zero, 0x2
    /* 1CB3C 8002C33C 0580033C */  lui        $v1, %hi(screenCarSelect)
    /* 1CB40 8002C340 581A028E */  lw         $v0, %lo(menuDefs)($s0)
    /* 1CB44 8002C344 3C20648C */  lw         $a0, %lo(screenCarSelect)($v1)
    /* 1CB48 8002C348 481D4224 */  addiu      $v0, $v0, 0x1D48
    /* 1CB4C 8002C34C 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1CB50 8002C350 040022AE */   sw        $v0, 0x4($s1)
    /* 1CB54 8002C354 E0B00008 */  j          .L8002C380
    /* 1CB58 8002C358 1000A427 */   addiu     $a0, $sp, 0x10
  .L8002C35C:
    /* 1CB5C 8002C35C 9AB0000C */  jal        MenuExtended_SetSoloRace__FR12tMenuCommand
    /* 1CB60 8002C360 21202002 */   addu      $a0, $s1, $zero
    /* 1CB64 8002C364 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1CB68 8002C368 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CB6C 8002C36C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1CB70 8002C370 000023AE */  sw         $v1, 0x0($s1)
    /* 1CB74 8002C374 200D4224 */  addiu      $v0, $v0, 0xD20
    /* 1CB78 8002C378 040022AE */  sw         $v0, 0x4($s1)
  .L8002C37C:
    /* 1CB7C 8002C37C 1000A427 */  addiu      $a0, $sp, 0x10
  .L8002C380:
    /* 1CB80 8002C380 1E98000C */  jal        ___7tScreen
    /* 1CB84 8002C384 02000524 */   addiu     $a1, $zero, 0x2
    /* 1CB88 8002C388 C000BF8F */  lw         $ra, 0xC0($sp)
    /* 1CB8C 8002C38C BC00B18F */  lw         $s1, 0xBC($sp)
    /* 1CB90 8002C390 B800B08F */  lw         $s0, 0xB8($sp)
    /* 1CB94 8002C394 0800E003 */  jr         $ra
    /* 1CB98 8002C398 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand
