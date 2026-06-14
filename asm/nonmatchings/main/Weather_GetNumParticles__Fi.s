.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_GetNumParticles__Fi, 0x10

glabel Weather_GetNumParticles__Fi
    /* D25C0 800E1DC0 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D25C4 800E1DC4 0834428C */  lw         $v0, %lo(Weather_gSys)($v0)
    /* D25C8 800E1DC8 0800E003 */  jr         $ra
    /* D25CC 800E1DCC 00000000 */   nop
endlabel Weather_GetNumParticles__Fi
