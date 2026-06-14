.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching savegp, 0x14

glabel savegp
    /* DB890 800EB090 00009CAC */  sw         $gp, 0x0($a0)
    /* DB894 800EB094 12801C3C */  lui        $gp, (0x80120000 >> 16)
    /* DB898 800EB098 E8349C8F */  lw         $gp, 0x34E8($gp)
    /* DB89C 800EB09C 0800E003 */  jr         $ra
    /* DB8A0 800EB0A0 00000000 */   nop
endlabel savegp
