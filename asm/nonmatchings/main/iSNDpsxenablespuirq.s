.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDpsxenablespuirq, 0x24

glabel iSNDpsxenablespuirq
    /* FC780 8010BF80 1480023C */  lui        $v0, %hi(D_80147E2C)
    /* FC784 8010BF84 2C7E438C */  lw         $v1, %lo(D_80147E2C)($v0)
    /* FC788 8010BF88 00000000 */  nop
    /* FC78C 8010BF8C AA016294 */  lhu        $v0, 0x1AA($v1)
    /* FC790 8010BF90 00000000 */  nop
    /* FC794 8010BF94 40004234 */  ori        $v0, $v0, 0x40
    /* FC798 8010BF98 AA0162A4 */  sh         $v0, 0x1AA($v1)
    /* FC79C 8010BF9C 0800E003 */  jr         $ra
    /* FC7A0 8010BFA0 00000000 */   nop
endlabel iSNDpsxenablespuirq
