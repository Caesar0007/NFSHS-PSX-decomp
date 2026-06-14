.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching restoregp, 0x8

glabel restoregp
    /* DB8A4 800EB0A4 0800E003 */  jr         $ra
    /* DB8A8 800EB0A8 25E00400 */   or        $gp, $zero, $a0
endlabel restoregp
