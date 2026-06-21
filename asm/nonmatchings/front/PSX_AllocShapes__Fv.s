.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSX_AllocShapes__Fv, 0x44

glabel PSX_AllocShapes__Fv
    /* 3E4C8 8004DCC8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3E4CC 8004DCCC 0180043C */  lui        $a0, %hi(D_80012830)
    /* 3E4D0 8004DCD0 30288424 */  addiu      $a0, $a0, %lo(D_80012830)
    /* 3E4D4 8004DCD4 60070524 */  addiu      $a1, $zero, 0x760
    /* 3E4D8 8004DCD8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3E4DC 8004DCDC 0580103C */  lui        $s0, %hi(gHelpShapes)
    /* 3E4E0 8004DCE0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3E4E4 8004DCE4 CF94030C */  jal        reservememadr
    /* 3E4E8 8004DCE8 21300000 */   addu      $a2, $zero, $zero
    /* 3E4EC 8004DCEC 21204000 */  addu       $a0, $v0, $zero
    /* 3E4F0 8004DCF0 60070524 */  addiu      $a1, $zero, 0x760
    /* 3E4F4 8004DCF4 E8C5030C */  jal        blockclear
    /* 3E4F8 8004DCF8 642A02AE */   sw        $v0, %lo(gHelpShapes)($s0)
    /* 3E4FC 8004DCFC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3E500 8004DD00 1000B08F */  lw         $s0, 0x10($sp)
    /* 3E504 8004DD04 0800E003 */  jr         $ra
    /* 3E508 8004DD08 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PSX_AllocShapes__Fv
