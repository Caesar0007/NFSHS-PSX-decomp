.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Dispatch__6Speech, 0x38

glabel Dispatch__6Speech
    /* 866F0 80095EF0 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 866F4 80095EF4 00000000 */  nop
    /* 866F8 80095EF8 05006010 */  beqz       $v1, .L80095F10
    /* 866FC 80095EFC 00000000 */   nop
    /* 86700 80095F00 6C03628C */  lw         $v0, 0x36C($v1)
    /* 86704 80095F04 00000000 */  nop
    /* 86708 80095F08 04004014 */  bnez       $v0, .L80095F1C
    /* 8670C 80095F0C 00000000 */   nop
  .L80095F10:
    /* 86710 80095F10 3C08828F */  lw         $v0, %gp_rel(_6Speech_fgUndefined)($gp)
    /* 86714 80095F14 0800E003 */  jr         $ra
    /* 86718 80095F18 00000000 */   nop
  .L80095F1C:
    /* 8671C 80095F1C A003628C */  lw         $v0, 0x3A0($v1)
    /* 86720 80095F20 0800E003 */  jr         $ra
    /* 86724 80095F24 00000000 */   nop
endlabel Dispatch__6Speech
