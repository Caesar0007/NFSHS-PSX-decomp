.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_ActivateBonus__F10tCheatCode, 0x3C

glabel FECheat_ActivateBonus__F10tCheatCode
    /* 13DD8 800235D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 13DDC 800235DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 13DE0 800235E0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 13DE4 800235E4 908C000C */  jal        func_80023240
    /* 13DE8 800235E8 21808000 */   addu      $s0, $a0, $zero
    /* 13DEC 800235EC 1480043C */  lui        $a0, %hi(gFEBonus)
    /* 13DF0 800235F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 13DF4 800235F4 04100202 */  sllv       $v0, $v0, $s0
    /* 13DF8 800235F8 7CD2838C */  lw         $v1, %lo(gFEBonus)($a0)
    /* 13DFC 800235FC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 13E00 80023600 1000B08F */  lw         $s0, 0x10($sp)
    /* 13E04 80023604 25186200 */  or         $v1, $v1, $v0
    /* 13E08 80023608 7CD283AC */  sw         $v1, %lo(gFEBonus)($a0)
    /* 13E0C 8002360C 0800E003 */  jr         $ra
    /* 13E10 80023610 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FECheat_ActivateBonus__F10tCheatCode
