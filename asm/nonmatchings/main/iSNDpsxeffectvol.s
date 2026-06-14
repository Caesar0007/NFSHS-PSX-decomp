.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxeffectvol, 0x28

glabel iSNDpsxeffectvol
    /* EFA10 800FF210 1480023C */  lui        $v0, %hi(sndpd)
    /* EFA14 800FF214 18794224 */  addiu      $v0, $v0, %lo(sndpd)
    /* EFA18 800FF218 1405438C */  lw         $v1, 0x514($v0)
    /* EFA1C 800FF21C 00000000 */  nop
    /* EFA20 800FF220 840164A4 */  sh         $a0, 0x184($v1)
    /* EFA24 800FF224 1405428C */  lw         $v0, 0x514($v0)
    /* EFA28 800FF228 00000000 */  nop
    /* EFA2C 800FF22C 860145A4 */  sh         $a1, 0x186($v0)
    /* EFA30 800FF230 0800E003 */  jr         $ra
    /* EFA34 800FF234 00000000 */   nop
endlabel iSNDpsxeffectvol
