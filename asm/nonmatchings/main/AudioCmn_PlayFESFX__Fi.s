.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayFESFX__Fi, 0x20

glabel AudioCmn_PlayFESFX__Fi
    /* 69E04 80079604 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 69E08 80079608 1000BFAF */  sw         $ra, 0x10($sp)
    /* 69E0C 8007960C 89E5010C */  jal        AudioCmn_PlayFESFXVol__Fii
    /* 69E10 80079610 7F000524 */   addiu     $a1, $zero, 0x7F
    /* 69E14 80079614 1000BF8F */  lw         $ra, 0x10($sp)
    /* 69E18 80079618 00000000 */  nop
    /* 69E1C 8007961C 0800E003 */  jr         $ra
    /* 69E20 80079620 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_PlayFESFX__Fi
