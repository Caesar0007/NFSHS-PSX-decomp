.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxkeyon, 0x28

glabel iSNDpsxkeyon
    /* EF940 800FF140 1480023C */  lui        $v0, %hi(sndpd)
    /* EF944 800FF144 18794224 */  addiu      $v0, $v0, %lo(sndpd)
    /* EF948 800FF148 1405438C */  lw         $v1, 0x514($v0)
    /* EF94C 800FF14C 00000000 */  nop
    /* EF950 800FF150 880164A4 */  sh         $a0, 0x188($v1)
    /* EF954 800FF154 1405428C */  lw         $v0, 0x514($v0)
    /* EF958 800FF158 03240400 */  sra        $a0, $a0, 16
    /* EF95C 800FF15C 8A0144A4 */  sh         $a0, 0x18A($v0)
    /* EF960 800FF160 0800E003 */  jr         $ra
    /* EF964 800FF164 00000000 */   nop
endlabel iSNDpsxkeyon
