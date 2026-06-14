.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___20AIHigh_BTC_HumanPerp, 0x28

glabel ___20AIHigh_BTC_HumanPerp
    /* 51B20 80061320 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 51B24 80061324 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 51B28 80061328 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 51B2C 8006132C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 51B30 80061330 F16C010C */  jal        ___11AIHigh_Base
    /* 51B34 80061334 140082AC */   sw        $v0, 0x14($a0)
    /* 51B38 80061338 1000BF8F */  lw         $ra, 0x10($sp)
    /* 51B3C 8006133C 00000000 */  nop
    /* 51B40 80061340 0800E003 */  jr         $ra
    /* 51B44 80061344 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___20AIHigh_BTC_HumanPerp
