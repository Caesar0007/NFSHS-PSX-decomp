.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand, 0xCC

glabel ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* A4CC 80019CCC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A4D0 80019CD0 1000B0AF */  sw         $s0, 0x10($sp)
    /* A4D4 80019CD4 21808000 */  addu       $s0, $a0, $zero
    /* A4D8 80019CD8 1400BFAF */  sw         $ra, 0x14($sp)
    /* A4DC 80019CDC 64000386 */  lh         $v1, 0x64($s0)
    /* A4E0 80019CE0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* A4E4 80019CE4 03006210 */  beq        $v1, $v0, .L80019CF4
    /* A4E8 80019CE8 00000000 */   nop
    /* A4EC 80019CEC 2600A314 */  bne        $a1, $v1, .L80019D88
    /* A4F0 80019CF0 00000000 */   nop
  .L80019CF4:
    /* A4F4 80019CF4 8400028E */  lw         $v0, 0x84($s0)
    /* A4F8 80019CF8 00000000 */  nop
    /* A4FC 80019CFC 01004238 */  xori       $v0, $v0, 0x1
    /* A500 80019D00 21004014 */  bnez       $v0, .L80019D88
    /* A504 80019D04 00080224 */   addiu     $v0, $zero, 0x800
    /* A508 80019D08 0000C68C */  lw         $a2, 0x0($a2)
    /* A50C 80019D0C 00000000 */  nop
    /* A510 80019D10 0E00C210 */  beq        $a2, $v0, .L80019D4C
    /* A514 80019D14 0108C228 */   slti      $v0, $a2, 0x801
    /* A518 80019D18 05004010 */  beqz       $v0, .L80019D30
    /* A51C 80019D1C 02000224 */   addiu     $v0, $zero, 0x2
    /* A520 80019D20 1300C210 */  beq        $a2, $v0, .L80019D70
    /* A524 80019D24 00000000 */   nop
    /* A528 80019D28 62670008 */  j          .L80019D88
    /* A52C 80019D2C 00000000 */   nop
  .L80019D30:
    /* A530 80019D30 00100224 */  addiu      $v0, $zero, 0x1000
    /* A534 80019D34 0A00C210 */  beq        $a2, $v0, .L80019D60
    /* A538 80019D38 00200224 */   addiu     $v0, $zero, 0x2000
    /* A53C 80019D3C 0C00C210 */  beq        $a2, $v0, .L80019D70
    /* A540 80019D40 00000000 */   nop
    /* A544 80019D44 62670008 */  j          .L80019D88
    /* A548 80019D48 00000000 */   nop
  .L80019D4C:
    /* A54C 80019D4C 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* A550 80019D50 05000424 */   addiu     $a0, $zero, 0x5
    /* A554 80019D54 01000224 */  addiu      $v0, $zero, 0x1
    /* A558 80019D58 62670008 */  j          .L80019D88
    /* A55C 80019D5C 8A0002A6 */   sh        $v0, 0x8A($s0)
  .L80019D60:
    /* A560 80019D60 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* A564 80019D64 06000424 */   addiu     $a0, $zero, 0x6
    /* A568 80019D68 62670008 */  j          .L80019D88
    /* A56C 80019D6C 8A0000A6 */   sh        $zero, 0x8A($s0)
  .L80019D70:
    /* A570 80019D70 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* A574 80019D74 21200000 */   addu      $a0, $zero, $zero
    /* A578 80019D78 01000224 */  addiu      $v0, $zero, 0x1
    /* A57C 80019D7C 980002AE */  sw         $v0, 0x98($s0)
    /* A580 80019D80 4162000C */  jal        Hide__11tDialogBase
    /* A584 80019D84 21200002 */   addu      $a0, $s0, $zero
  .L80019D88:
    /* A588 80019D88 1400BF8F */  lw         $ra, 0x14($sp)
    /* A58C 80019D8C 1000B08F */  lw         $s0, 0x10($sp)
    /* A590 80019D90 0800E003 */  jr         $ra
    /* A594 80019D94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
