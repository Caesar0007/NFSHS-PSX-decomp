.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Speech_Server__Fv, 0x3C

glabel Speech_Server__Fv
    /* 865F8 80095DF8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 865FC 80095DFC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 86600 80095E00 BC57020C */  jal        Dispatch__6Speech
    /* 86604 80095E04 00000000 */   nop
    /* 86608 80095E08 4C00438C */  lw         $v1, 0x4C($v0)
    /* 8660C 80095E0C 00000000 */  nop
    /* 86610 80095E10 10006484 */  lh         $a0, 0x10($v1)
    /* 86614 80095E14 1400638C */  lw         $v1, 0x14($v1)
    /* 86618 80095E18 00000000 */  nop
    /* 8661C 80095E1C 09F86000 */  jalr       $v1
    /* 86620 80095E20 21204400 */   addu      $a0, $v0, $a0
    /* 86624 80095E24 1000BF8F */  lw         $ra, 0x10($sp)
    /* 86628 80095E28 00000000 */  nop
    /* 8662C 80095E2C 0800E003 */  jr         $ra
    /* 86630 80095E30 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Speech_Server__Fv
