.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDresetpatch, 0x8

glabel iSNDresetpatch
    /* F22BC 80101ABC 0800E003 */  jr         $ra
    /* F22C0 80101AC0 900080AC */   sw        $zero, 0x90($a0)
endlabel iSNDresetpatch
