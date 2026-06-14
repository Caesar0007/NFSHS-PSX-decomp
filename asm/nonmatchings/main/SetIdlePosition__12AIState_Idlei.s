.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetIdlePosition__12AIState_Idlei, 0xC

glabel SetIdlePosition__12AIState_Idlei
    /* 603F0 8006FBF0 080085AC */  sw         $a1, 0x8($a0)
    /* 603F4 8006FBF4 0800E003 */  jr         $ra
    /* 603F8 8006FBF8 0C0080AC */   sw        $zero, 0xC($a0)
endlabel SetIdlePosition__12AIState_Idlei
