.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadFrontendOverlay__Fv, 0x54

glabel LoadFrontendOverlay__Fv
    /* 94CF8 800A44F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 94CFC 800A44FC 0580043C */  lui        $a0, %hi(D_80056024)
    /* 94D00 800A4500 24608424 */  addiu      $a0, $a0, %lo(D_80056024)
    /* 94D04 800A4504 0180053C */  lui        $a1, %hi(_front_obj)
    /* 94D08 800A4508 0000A524 */  addiu      $a1, $a1, %lo(_front_obj)
    /* 94D0C 800A450C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 94D10 800A4510 0FC5030C */  jal        asyncloadfileat
    /* 94D14 800A4514 1000B0AF */   sw        $s0, 0x10($sp)
    /* 94D18 800A4518 21804000 */  addu       $s0, $v0, $zero
  .L800A451C:
    /* 94D1C 800A451C B6C5030C */  jal        getasyncreadstatus
    /* 94D20 800A4520 21200002 */   addu      $a0, $s0, $zero
    /* 94D24 800A4524 05004014 */  bnez       $v0, .L800A453C
    /* 94D28 800A4528 00000000 */   nop
    /* 94D2C 800A452C 019B030C */  jal        systemtask
    /* 94D30 800A4530 21200000 */   addu      $a0, $zero, $zero
    /* 94D34 800A4534 47910208 */  j          .L800A451C
    /* 94D38 800A4538 00000000 */   nop
  .L800A453C:
    /* 94D3C 800A453C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 94D40 800A4540 1000B08F */  lw         $s0, 0x10($sp)
    /* 94D44 800A4544 0800E003 */  jr         $ra
    /* 94D48 800A4548 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel LoadFrontendOverlay__Fv
