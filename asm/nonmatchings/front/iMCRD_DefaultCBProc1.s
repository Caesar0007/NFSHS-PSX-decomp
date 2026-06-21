.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_DefaultCBProc1, 0x8

glabel iMCRD_DefaultCBProc1
    /* 40EE8 800506E8 0800E003 */  jr         $ra
    /* 40EEC 800506EC 01000224 */   addiu     $v0, $zero, 0x1
endlabel iMCRD_DefaultCBProc1
