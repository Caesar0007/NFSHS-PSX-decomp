.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80061348, 0x28

glabel func_80061348
    /* 51B48 80061348 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 51B4C 8006134C 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 51B50 80061350 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 51B54 80061354 1000BFAF */  sw         $ra, 0x10($sp)
    /* 51B58 80061358 F16C010C */  jal        ___11AIHigh_Base
    /* 51B5C 8006135C 140082AC */   sw        $v0, 0x14($a0)
    /* 51B60 80061360 1000BF8F */  lw         $ra, 0x10($sp)
    /* 51B64 80061364 00000000 */  nop
    /* 51B68 80061368 0800E003 */  jr         $ra
    /* 51B6C 8006136C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80061348
