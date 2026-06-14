.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_InitBanks, 0x14

glabel iSPCH_InitBanks
    /* DB9E0 800EB1E0 1380023C */  lui        $v0, %hi(gVoxBanks)
    /* DB9E4 800EB1E4 B47040AC */  sw         $zero, %lo(gVoxBanks)($v0)
    /* DB9E8 800EB1E8 1380023C */  lui        $v0, %hi(gNumBanks)
    /* DB9EC 800EB1EC 0800E003 */  jr         $ra
    /* DB9F0 800EB1F0 B87040AC */   sw        $zero, %lo(gNumBanks)($v0)
endlabel iSPCH_InitBanks
