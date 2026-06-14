.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadOverlay__Fv, 0x6C

glabel LoadOverlay__Fv
    /* 94D4C 800A454C A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 94D50 800A4550 5400BFAF */  sw         $ra, 0x54($sp)
    /* 94D54 800A4554 3E91020C */  jal        LoadFrontendOverlay__Fv
    /* 94D58 800A4558 5000B0AF */   sw        $s0, 0x50($sp)
    /* 94D5C 800A455C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 94D60 800A4560 0580053C */  lui        $a1, %hi(D_80056030)
    /* 94D64 800A4564 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 94D68 800A4568 E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 94D6C 800A456C 2F91030C */  jal        sprintf
    /* 94D70 800A4570 3060A524 */   addiu     $a1, $a1, %lo(D_80056030)
    /* 94D74 800A4574 1280053C */  lui        $a1, %hi(CF_DVLC)
    /* 94D78 800A4578 3840A524 */  addiu      $a1, $a1, %lo(CF_DVLC)
    /* 94D7C 800A457C 0FC5030C */  jal        asyncloadfileat
    /* 94D80 800A4580 1000A427 */   addiu     $a0, $sp, 0x10
    /* 94D84 800A4584 21804000 */  addu       $s0, $v0, $zero
  .L800A4588:
    /* 94D88 800A4588 B6C5030C */  jal        getasyncreadstatus
    /* 94D8C 800A458C 21200002 */   addu      $a0, $s0, $zero
    /* 94D90 800A4590 05004014 */  bnez       $v0, .L800A45A8
    /* 94D94 800A4594 00000000 */   nop
    /* 94D98 800A4598 019B030C */  jal        systemtask
    /* 94D9C 800A459C 21200000 */   addu      $a0, $zero, $zero
    /* 94DA0 800A45A0 62910208 */  j          .L800A4588
    /* 94DA4 800A45A4 00000000 */   nop
  .L800A45A8:
    /* 94DA8 800A45A8 5400BF8F */  lw         $ra, 0x54($sp)
    /* 94DAC 800A45AC 5000B08F */  lw         $s0, 0x50($sp)
    /* 94DB0 800A45B0 0800E003 */  jr         $ra
    /* 94DB4 800A45B4 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel LoadOverlay__Fv
