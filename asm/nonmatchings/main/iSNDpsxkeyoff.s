.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxkeyoff, 0x28

glabel iSNDpsxkeyoff
    /* EF968 800FF168 1480023C */  lui        $v0, %hi(sndpd)
    /* EF96C 800FF16C 18794224 */  addiu      $v0, $v0, %lo(sndpd)
    /* EF970 800FF170 1405438C */  lw         $v1, 0x514($v0)
    /* EF974 800FF174 00000000 */  nop
    /* EF978 800FF178 8C0164A4 */  sh         $a0, 0x18C($v1)
    /* EF97C 800FF17C 1405428C */  lw         $v0, 0x514($v0)
    /* EF980 800FF180 03240400 */  sra        $a0, $a0, 16
    /* EF984 800FF184 8E0144A4 */  sh         $a0, 0x18E($v0)
    /* EF988 800FF188 0800E003 */  jr         $ra
    /* EF98C 800FF18C 00000000 */   nop
endlabel iSNDpsxkeyoff
