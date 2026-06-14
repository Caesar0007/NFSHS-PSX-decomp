.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardEnd, 0x20

glabel MemCardEnd
    /* EB2D8 800FAAD8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EB2DC 800FAADC 1000BFAF */  sw         $ra, 0x10($sp)
    /* EB2E0 800FAAE0 FF25040C */  jal        _card_close
    /* EB2E4 800FAAE4 00000000 */   nop
    /* EB2E8 800FAAE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* EB2EC 800FAAEC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* EB2F0 800FAAF0 0800E003 */  jr         $ra
    /* EB2F4 800FAAF4 00000000 */   nop
endlabel MemCardEnd
