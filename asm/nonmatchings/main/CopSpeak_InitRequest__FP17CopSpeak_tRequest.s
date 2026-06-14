.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_InitRequest__FP17CopSpeak_tRequest, 0x30

glabel CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 89DF0 800995F0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 89DF4 800995F4 040082AC */  sw         $v0, 0x4($a0)
    /* 89DF8 800995F8 180082AC */  sw         $v0, 0x18($a0)
    /* 89DFC 800995FC 02000224 */  addiu      $v0, $zero, 0x2
    /* 89E00 80099600 000080AC */  sw         $zero, 0x0($a0)
    /* 89E04 80099604 080080AC */  sw         $zero, 0x8($a0)
    /* 89E08 80099608 0C0080AC */  sw         $zero, 0xC($a0)
    /* 89E0C 8009960C 1C0080A0 */  sb         $zero, 0x1C($a0)
    /* 89E10 80099610 1D0080A0 */  sb         $zero, 0x1D($a0)
    /* 89E14 80099614 1E0082A0 */  sb         $v0, 0x1E($a0)
    /* 89E18 80099618 0800E003 */  jr         $ra
    /* 89E1C 8009961C 1F0080A0 */   sb        $zero, 0x1F($a0)
endlabel CopSpeak_InitRequest__FP17CopSpeak_tRequest
