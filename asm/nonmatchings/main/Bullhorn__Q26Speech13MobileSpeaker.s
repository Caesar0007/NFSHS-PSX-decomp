.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Bullhorn__Q26Speech13MobileSpeaker, 0x34

glabel Bullhorn__Q26Speech13MobileSpeaker
    /* 896E4 80098EE4 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 896E8 80098EE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 896EC 80098EEC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 896F0 80098EF0 6000828C */  lw         $v0, 0x60($a0)
    /* 896F4 80098EF4 50008424 */  addiu      $a0, $a0, 0x50
    /* 896F8 80098EF8 204F020C */  jal        SPCHNFS_C_P_BULLHORN_SPEECH
    /* 896FC 80098EFC 8C0362AC */   sw        $v0, 0x38C($v1)
    /* 89700 80098F00 919D030C */  jal        SPCH_PlaySpeech
    /* 89704 80098F04 00000000 */   nop
    /* 89708 80098F08 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8970C 80098F0C 00000000 */  nop
    /* 89710 80098F10 0800E003 */  jr         $ra
    /* 89714 80098F14 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Bullhorn__Q26Speech13MobileSpeaker
