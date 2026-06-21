.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawHorizontalLine__14tScreenMemcardssss, 0xC0

glabel DrawHorizontalLine__14tScreenMemcardssss
    /* 3714C 8004694C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 37150 80046950 00140700 */  sll        $v0, $a3, 16
    /* 37154 80046954 3800A497 */  lhu        $a0, 0x38($sp)
    /* 37158 80046958 031C0200 */  sra        $v1, $v0, 16
    /* 3715C 8004695C 04006018 */  blez       $v1, .L80046970
    /* 37160 80046960 2000BFAF */   sw        $ra, 0x20($sp)
    /* 37164 80046964 40006228 */  slti       $v0, $v1, 0x40
    /* 37168 80046968 05004010 */  beqz       $v0, .L80046980
    /* 3716C 8004696C 01000224 */   addiu     $v0, $zero, 0x1
  .L80046970:
    /* 37170 80046970 04006104 */  bgez       $v1, .L80046984
    /* 37174 80046974 01000224 */   addiu     $v0, $zero, 0x1
    /* 37178 80046978 611A0108 */  j          .L80046984
    /* 3717C 8004697C 21380000 */   addu      $a3, $zero, $zero
  .L80046980:
    /* 37180 80046980 40000724 */  addiu      $a3, $zero, 0x40
  .L80046984:
    /* 37184 80046984 2140E000 */  addu       $t0, $a3, $zero
    /* 37188 80046988 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3718C 8004698C 0580023C */  lui        $v0, %hi(GRIDMEMCARDGOURAUDBIT_X)
    /* 37190 80046990 0580033C */  lui        $v1, %hi(GRIDMEMCARD_WIDTH)
    /* 37194 80046994 18294294 */  lhu        $v0, %lo(GRIDMEMCARDGOURAUDBIT_X)($v0)
    /* 37198 80046998 10296394 */  lhu        $v1, %lo(GRIDMEMCARD_WIDTH)($v1)
    /* 3719C 8004699C 40100200 */  sll        $v0, $v0, 1
    /* 371A0 800469A0 02004224 */  addiu      $v0, $v0, 0x2
    /* 371A4 800469A4 21186200 */  addu       $v1, $v1, $v0
    /* 371A8 800469A8 00140500 */  sll        $v0, $a1, 16
    /* 371AC 800469AC 032C0200 */  sra        $a1, $v0, 16
    /* 371B0 800469B0 00140600 */  sll        $v0, $a2, 16
    /* 371B4 800469B4 03340200 */  sra        $a2, $v0, 16
    /* 371B8 800469B8 001C0300 */  sll        $v1, $v1, 16
    /* 371BC 800469BC 00140400 */  sll        $v0, $a0, 16
    /* 371C0 800469C0 03004010 */  beqz       $v0, .L800469D0
    /* 371C4 800469C4 033C0300 */   sra       $a3, $v1, 16
    /* 371C8 800469C8 751A0108 */  j          .L800469D4
    /* 371CC 800469CC 03000224 */   addiu     $v0, $zero, 0x3
  .L800469D0:
    /* 371D0 800469D0 02000224 */  addiu      $v0, $zero, 0x2
  .L800469D4:
    /* 371D4 800469D4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 371D8 800469D8 7800043C */  lui        $a0, (0x785A5A >> 16)
    /* 371DC 800469DC 5A5A8434 */  ori        $a0, $a0, (0x785A5A & 0xFFFF)
    /* 371E0 800469E0 00140800 */  sll        $v0, $t0, 16
    /* 371E4 800469E4 0580033C */  lui        $v1, %hi(GRIDMEMCARDGOURAUDBIT_X)
    /* 371E8 800469E8 1829638C */  lw         $v1, %lo(GRIDMEMCARDGOURAUDBIT_X)($v1)
    /* 371EC 800469EC C3130200 */  sra        $v0, $v0, 15
    /* 371F0 800469F0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 371F4 800469F4 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 371F8 800469F8 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* 371FC 800469FC 2000BF8F */  lw         $ra, 0x20($sp)
    /* 37200 80046A00 00000000 */  nop
    /* 37204 80046A04 0800E003 */  jr         $ra
    /* 37208 80046A08 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawHorizontalLine__14tScreenMemcardssss
