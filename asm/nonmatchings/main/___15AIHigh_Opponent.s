.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15AIHigh_Opponent, 0x28

glabel ___15AIHigh_Opponent
    /* 543D8 80063BD8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 543DC 80063BDC 0580023C */  lui        $v0, %hi(_vt_16AIHigh_BasicPerp)
    /* 543E0 80063BE0 6C4E4224 */  addiu      $v0, $v0, %lo(_vt_16AIHigh_BasicPerp)
    /* 543E4 80063BE4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 543E8 80063BE8 F16C010C */  jal        ___11AIHigh_Base
    /* 543EC 80063BEC 140082AC */   sw        $v0, 0x14($a0)
    /* 543F0 80063BF0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 543F4 80063BF4 00000000 */  nop
    /* 543F8 80063BF8 0800E003 */  jr         $ra
    /* 543FC 80063BFC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15AIHigh_Opponent
