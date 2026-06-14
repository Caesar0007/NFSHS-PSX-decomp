.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_LoadFESamples__Fv, 0x44

glabel AudioCmn_LoadFESamples__Fv
    /* 67F38 80077738 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* 67F3C 8007773C 1180023C */  lui        $v0, %hi(D_801164D8)
    /* 67F40 80077740 D864458C */  lw         $a1, %lo(D_801164D8)($v0)
    /* 67F44 80077744 7800BFAF */  sw         $ra, 0x78($sp)
    /* 67F48 80077748 CA96030C */  jal        strcpy
    /* 67F4C 8007774C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 67F50 80077750 1000A427 */  addiu      $a0, $sp, 0x10
    /* 67F54 80077754 1480053C */  lui        $a1, %hi(D_8013C684)
    /* 67F58 80077758 3A9E030C */  jal        strcat
    /* 67F5C 8007775C 84C6A524 */   addiu     $a1, $a1, %lo(D_8013C684)
    /* 67F60 80077760 1000A427 */  addiu      $a0, $sp, 0x10
    /* 67F64 80077764 A3EF020C */  jal        AudioCmn_LoadBank__FPci
    /* 67F68 80077768 21280000 */   addu      $a1, $zero, $zero
    /* 67F6C 8007776C 7800BF8F */  lw         $ra, 0x78($sp)
    /* 67F70 80077770 00000000 */  nop
    /* 67F74 80077774 0800E003 */  jr         $ra
    /* 67F78 80077778 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel AudioCmn_LoadFESamples__Fv
