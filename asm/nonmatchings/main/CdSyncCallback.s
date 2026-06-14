.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdSyncCallback, 0x14

glabel CdSyncCallback
    /* E808C 800F788C 1480023C */  lui        $v0, %hi(CD_cbsync)
    /* E8090 800F7890 48BF428C */  lw         $v0, %lo(CD_cbsync)($v0)
    /* E8094 800F7894 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E8098 800F7898 0800E003 */  jr         $ra
    /* E809C 800F789C 48BF24AC */   sw        $a0, %lo(CD_cbsync)($at)
endlabel CdSyncCallback
