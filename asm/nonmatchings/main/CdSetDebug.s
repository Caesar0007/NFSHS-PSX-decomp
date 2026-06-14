.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdSetDebug, 0x14

glabel CdSetDebug
    /* E8038 800F7838 1480023C */  lui        $v0, %hi(CD_debug)
    /* E803C 800F783C 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E8040 800F7840 1480013C */  lui        $at, %hi(CD_debug)
    /* E8044 800F7844 0800E003 */  jr         $ra
    /* E8048 800F7848 50BF24AC */   sw        $a0, %lo(CD_debug)($at)
endlabel CdSetDebug
