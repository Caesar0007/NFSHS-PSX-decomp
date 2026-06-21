.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80034620, 0x2C

glabel func_80034620
    /* 24E20 80034620 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24E24 80034624 0580023C */  lui        $v0, %hi(CURRENTPLAYER)
    /* 24E28 80034628 681A448C */  lw         $a0, %lo(CURRENTPLAYER)($v0)
    /* 24E2C 8003462C 90020524 */  addiu      $a1, $zero, 0x290
    /* 24E30 80034630 1000BFAF */  sw         $ra, 0x10($sp)
    /* 24E34 80034634 0ED1000C */  jal        func_80034438
    /* 24E38 80034638 27038424 */   addiu     $a0, $a0, 0x327
    /* 24E3C 8003463C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24E40 80034640 00000000 */  nop
    /* 24E44 80034644 0800E003 */  jr         $ra
    /* 24E48 80034648 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80034620
