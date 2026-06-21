.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DeInit__14tCreditManager, 0xC

glabel DeInit__14tCreditManager
    /* 263D8 80035BD8 01000224 */  addiu      $v0, $zero, 0x1
    /* 263DC 80035BDC 0800E003 */  jr         $ra
    /* 263E0 80035BE0 140082AC */   sw        $v0, 0x14($a0)
endlabel DeInit__14tCreditManager
