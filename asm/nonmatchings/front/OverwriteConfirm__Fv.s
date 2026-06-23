.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching OverwriteConfirm__Fv, 0x2C

glabel OverwriteConfirm__Fv
    /* 24DEC 800345EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24DF0 800345F0 0580023C */  lui        $v0, %hi(CURRENTPLAYER)
    /* 24DF4 800345F4 681A448C */  lw         $a0, %lo(CURRENTPLAYER)($v0)
    /* 24DF8 800345F8 8F020524 */  addiu      $a1, $zero, 0x28F
    /* 24DFC 800345FC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 24E00 80034600 0ED1000C */  jal        Confirm__Fii
    /* 24E04 80034604 23038424 */   addiu     $a0, $a0, 0x323
    /* 24E08 80034608 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24E0C 8003460C 00000000 */  nop
    /* 24E10 80034610 0800E003 */  jr         $ra
    /* 24E14 80034614 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel OverwriteConfirm__Fv
