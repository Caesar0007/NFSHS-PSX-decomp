.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVerticalLine__14tScreenMemcardssss, 0xB4

glabel DrawVerticalLine__14tScreenMemcardssss
    /* 37098 80046898 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3709C 8004689C 2140A000 */  addu       $t0, $a1, $zero
    /* 370A0 800468A0 00140700 */  sll        $v0, $a3, 16
    /* 370A4 800468A4 3800A597 */  lhu        $a1, 0x38($sp)
    /* 370A8 800468A8 031C0200 */  sra        $v1, $v0, 16
    /* 370AC 800468AC 04006018 */  blez       $v1, .L800468C0
    /* 370B0 800468B0 2000BFAF */   sw        $ra, 0x20($sp)
    /* 370B4 800468B4 40006228 */  slti       $v0, $v1, 0x40
    /* 370B8 800468B8 05004010 */  beqz       $v0, .L800468D0
    /* 370BC 800468BC 7800043C */   lui       $a0, (0x785A5A >> 16)
  .L800468C0:
    /* 370C0 800468C0 04006104 */  bgez       $v1, .L800468D4
    /* 370C4 800468C4 7800043C */   lui       $a0, (0x785A5A >> 16)
    /* 370C8 800468C8 351A0108 */  j          .L800468D4
    /* 370CC 800468CC 21380000 */   addu      $a3, $zero, $zero
  .L800468D0:
    /* 370D0 800468D0 40000724 */  addiu      $a3, $zero, 0x40
  .L800468D4:
    /* 370D4 800468D4 5A5A8434 */  ori        $a0, $a0, (0x785A5A & 0xFFFF)
    /* 370D8 800468D8 00140500 */  sll        $v0, $a1, 16
    /* 370DC 800468DC 0100422C */  sltiu      $v0, $v0, 0x1
    /* 370E0 800468E0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 370E4 800468E4 00140700 */  sll        $v0, $a3, 16
    /* 370E8 800468E8 C3130200 */  sra        $v0, $v0, 15
    /* 370EC 800468EC 1800A2AF */  sw         $v0, 0x18($sp)
    /* 370F0 800468F0 0580023C */  lui        $v0, %hi(GRIDMEMCARDGOURAUDBIT_Y)
    /* 370F4 800468F4 0580033C */  lui        $v1, %hi(GRIDMEMCARD_HEIGHT)
    /* 370F8 800468F8 1C294594 */  lhu        $a1, %lo(GRIDMEMCARDGOURAUDBIT_Y)($v0)
    /* 370FC 800468FC 0580023C */  lui        $v0, %hi(EXTRAYATTOP)
    /* 37100 80046900 00340600 */  sll        $a2, $a2, 16
    /* 37104 80046904 03340600 */  sra        $a2, $a2, 16
    /* 37108 80046908 14296394 */  lhu        $v1, %lo(GRIDMEMCARD_HEIGHT)($v1)
    /* 3710C 8004690C 0C294294 */  lhu        $v0, %lo(EXTRAYATTOP)($v0)
    /* 37110 80046910 02000724 */  addiu      $a3, $zero, 0x2
    /* 37114 80046914 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 37118 80046918 40280500 */  sll        $a1, $a1, 1
    /* 3711C 8004691C 21186500 */  addu       $v1, $v1, $a1
    /* 37120 80046920 21104300 */  addu       $v0, $v0, $v1
    /* 37124 80046924 00140200 */  sll        $v0, $v0, 16
    /* 37128 80046928 03140200 */  sra        $v0, $v0, 16
    /* 3712C 8004692C 002C0800 */  sll        $a1, $t0, 16
    /* 37130 80046930 032C0500 */  sra        $a1, $a1, 16
    /* 37134 80046934 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 37138 80046938 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3713C 8004693C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 37140 80046940 00000000 */  nop
    /* 37144 80046944 0800E003 */  jr         $ra
    /* 37148 80046948 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawVerticalLine__14tScreenMemcardssss
