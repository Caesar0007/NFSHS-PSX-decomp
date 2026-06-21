.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_DeInitCommentary__Fv, 0x38

glabel FeAudio_DeInitCommentary__Fv
    /* 6978 80016178 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 697C 8001617C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6980 80016180 0580103C */  lui        $s0, %hi(speechfileHeader)
    /* 6984 80016184 0C15048E */  lw         $a0, %lo(speechfileHeader)($s0)
    /* 6988 80016188 00000000 */  nop
    /* 698C 8001618C 04008010 */  beqz       $a0, .L800161A0
    /* 6990 80016190 1400BFAF */   sw        $ra, 0x14($sp)
    /* 6994 80016194 5095030C */  jal        purgememadr
    /* 6998 80016198 00000000 */   nop
    /* 699C 8001619C 0C1500AE */  sw         $zero, %lo(speechfileHeader)($s0)
  .L800161A0:
    /* 69A0 800161A0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 69A4 800161A4 1000B08F */  lw         $s0, 0x10($sp)
    /* 69A8 800161A8 0800E003 */  jr         $ra
    /* 69AC 800161AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FeAudio_DeInitCommentary__Fv
