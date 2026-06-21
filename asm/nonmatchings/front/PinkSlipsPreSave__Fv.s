.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PinkSlipsPreSave__Fv, 0xC8

glabel PinkSlipsPreSave__Fv
    /* 1D2BC 8002CABC 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 1D2C0 8002CAC0 C000BFAF */  sw         $ra, 0xC0($sp)
    /* 1D2C4 8002CAC4 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 1D2C8 8002CAC8 F48D000C */  jal        FECheat_IsTheUserACryBabyCheater__Fv
    /* 1D2CC 8002CACC B800B0AF */   sw        $s0, 0xB8($sp)
    /* 1D2D0 8002CAD0 01004238 */  xori       $v0, $v0, 0x1
    /* 1D2D4 8002CAD4 25004010 */  beqz       $v0, .L8002CB6C
    /* 1D2D8 8002CAD8 01001124 */   addiu     $s1, $zero, 0x1
    /* 1D2DC 8002CADC 1000B027 */  addiu      $s0, $sp, 0x10
    /* 1D2E0 8002CAE0 A366000C */  jal        __12tDialogYesNo
    /* 1D2E4 8002CAE4 21200002 */   addu      $a0, $s0, $zero
    /* 1D2E8 8002CAE8 73020424 */  addiu      $a0, $zero, 0x273
    /* 1D2EC 8002CAEC 0180023C */  lui        $v0, %hi(_vt_15tDialogYesNoTri)
    /* 1D2F0 8002CAF0 B0024224 */  addiu      $v0, $v0, %lo(_vt_15tDialogYesNoTri)
    /* 1D2F4 8002CAF4 94E4020C */  jal        TextSys_Word__Fi
    /* 1D2F8 8002CAF8 600002AE */   sw        $v0, 0x60($s0)
    /* 1D2FC 8002CAFC 21200002 */  addu       $a0, $s0, $zero
    /* 1D300 8002CB00 900002AE */  sw         $v0, 0x90($s0)
    /* 1D304 8002CB04 21030224 */  addiu      $v0, $zero, 0x321
    /* 1D308 8002CB08 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1D30C 8002CB0C 22030224 */  addiu      $v0, $zero, 0x322
    /* 1D310 8002CB10 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1D314 8002CB14 FA65000C */  jal        Run__18tDialogInteractive
    /* 1D318 8002CB18 880000A6 */   sh        $zero, 0x88($s0)
    /* 1D31C 8002CB1C 00140200 */  sll        $v0, $v0, 16
    /* 1D320 8002CB20 031C0200 */  sra        $v1, $v0, 16
    /* 1D324 8002CB24 09007110 */  beq        $v1, $s1, .L8002CB4C
    /* 1D328 8002CB28 00000000 */   nop
    /* 1D32C 8002CB2C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 1D330 8002CB30 0A006214 */  bne        $v1, $v0, .L8002CB5C
    /* 1D334 8002CB34 1000A427 */   addiu     $a0, $sp, 0x10
    /* 1D338 8002CB38 21200002 */  addu       $a0, $s0, $zero
    /* 1D33C 8002CB3C 1E98000C */  jal        ___7tScreen
    /* 1D340 8002CB40 02000524 */   addiu     $a1, $zero, 0x2
    /* 1D344 8002CB44 DCB20008 */  j          .L8002CB70
    /* 1D348 8002CB48 21100000 */   addu      $v0, $zero, $zero
  .L8002CB4C:
    /* 1D34C 8002CB4C 68B2000C */  jal        GenericMenuSaveGame__Fi
    /* 1D350 8002CB50 01000424 */   addiu     $a0, $zero, 0x1
    /* 1D354 8002CB54 21884000 */  addu       $s1, $v0, $zero
    /* 1D358 8002CB58 1000A427 */  addiu      $a0, $sp, 0x10
  .L8002CB5C:
    /* 1D35C 8002CB5C 1E98000C */  jal        ___7tScreen
    /* 1D360 8002CB60 02000524 */   addiu     $a1, $zero, 0x2
    /* 1D364 8002CB64 DCB20008 */  j          .L8002CB70
    /* 1D368 8002CB68 21102002 */   addu      $v0, $s1, $zero
  .L8002CB6C:
    /* 1D36C 8002CB6C 01000224 */  addiu      $v0, $zero, 0x1
  .L8002CB70:
    /* 1D370 8002CB70 C000BF8F */  lw         $ra, 0xC0($sp)
    /* 1D374 8002CB74 BC00B18F */  lw         $s1, 0xBC($sp)
    /* 1D378 8002CB78 B800B08F */  lw         $s0, 0xB8($sp)
    /* 1D37C 8002CB7C 0800E003 */  jr         $ra
    /* 1D380 8002CB80 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel PinkSlipsPreSave__Fv
