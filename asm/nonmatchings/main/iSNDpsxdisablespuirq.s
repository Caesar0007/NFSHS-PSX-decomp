.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxdisablespuirq, 0x24

glabel iSNDpsxdisablespuirq
    /* FC7A4 8010BFA4 1480023C */  lui        $v0, %hi(D_80147E2C)
    /* FC7A8 8010BFA8 2C7E438C */  lw         $v1, %lo(D_80147E2C)($v0)
    /* FC7AC 8010BFAC 00000000 */  nop
    /* FC7B0 8010BFB0 AA016294 */  lhu        $v0, 0x1AA($v1)
    /* FC7B4 8010BFB4 00000000 */  nop
    /* FC7B8 8010BFB8 BFFF4230 */  andi       $v0, $v0, 0xFFBF
    /* FC7BC 8010BFBC AA0162A4 */  sh         $v0, 0x1AA($v1)
    /* FC7C0 8010BFC0 0800E003 */  jr         $ra
    /* FC7C4 8010BFC4 00000000 */   nop
endlabel iSNDpsxdisablespuirq
