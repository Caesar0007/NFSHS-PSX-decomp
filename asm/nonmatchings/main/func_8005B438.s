.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005B438, 0x28

glabel func_8005B438
    /* 4BC38 8005B438 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4BC3C 8005B43C 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 4BC40 8005B440 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 4BC44 8005B444 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4BC48 8005B448 F16C010C */  jal        ___11AIHigh_Base
    /* 4BC4C 8005B44C 140082AC */   sw        $v0, 0x14($a0)
    /* 4BC50 8005B450 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4BC54 8005B454 00000000 */  nop
    /* 4BC58 8005B458 0800E003 */  jr         $ra
    /* 4BC5C 8005B45C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8005B438
