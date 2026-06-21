.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Setup__14tCreditManager, 0x10

glabel Setup__14tCreditManager
    /* 262E8 80035AE8 100080AC */  sw         $zero, 0x10($a0)
    /* 262EC 80035AEC 140080AC */  sw         $zero, 0x14($a0)
    /* 262F0 80035AF0 0800E003 */  jr         $ra
    /* 262F4 80035AF4 040080AC */   sw        $zero, 0x4($a0)
endlabel Setup__14tCreditManager
