.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_KillTrackTexture__Fv, 0x8

glabel Texture_KillTrackTexture__Fv
    /* D104C 800E084C 0800E003 */  jr         $ra
    /* D1050 800E0850 00000000 */   nop
endlabel Texture_KillTrackTexture__Fv
