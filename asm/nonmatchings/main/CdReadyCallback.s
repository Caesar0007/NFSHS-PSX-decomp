.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdReadyCallback, 0x14

glabel CdReadyCallback
    /* E80A0 800F78A0 1480023C */  lui        $v0, %hi(CD_cbready)
    /* E80A4 800F78A4 4CBF428C */  lw         $v0, %lo(CD_cbready)($v0)
    /* E80A8 800F78A8 1480013C */  lui        $at, %hi(CD_cbready)
    /* E80AC 800F78AC 0800E003 */  jr         $ra
    /* E80B0 800F78B0 4CBF24AC */   sw        $a0, %lo(CD_cbready)($at)
endlabel CdReadyCallback
