.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_LoadFileAdr__FPc, 0x48

glabel R3DCar_LoadFileAdr__FPc
    /* 9F650 800AEE50 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9F654 800AEE54 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9F658 800AEE58 1400BFAF */  sw         $ra, 0x14($sp)
    /* 9F65C 800AEE5C 9B95030C */  jal        filesize
    /* 9F660 800AEE60 21808000 */   addu      $s0, $a0, $zero
    /* 9F664 800AEE64 21204000 */  addu       $a0, $v0, $zero
    /* 9F668 800AEE68 1480053C */  lui        $a1, %hi(D_8013D348)
    /* 9F66C 800AEE6C CD70030C */  jal        Platform_TempReserveMemory__FiPc
    /* 9F670 800AEE70 48D3A524 */   addiu     $a1, $a1, %lo(D_8013D348)
    /* 9F674 800AEE74 21200002 */  addu       $a0, $s0, $zero
    /* 9F678 800AEE78 21804000 */  addu       $s0, $v0, $zero
    /* 9F67C 800AEE7C 3C96030C */  jal        loadfileatadr
    /* 9F680 800AEE80 21280002 */   addu      $a1, $s0, $zero
    /* 9F684 800AEE84 21100002 */  addu       $v0, $s0, $zero
    /* 9F688 800AEE88 1400BF8F */  lw         $ra, 0x14($sp)
    /* 9F68C 800AEE8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 9F690 800AEE90 0800E003 */  jr         $ra
    /* 9F694 800AEE94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel R3DCar_LoadFileAdr__FPc
