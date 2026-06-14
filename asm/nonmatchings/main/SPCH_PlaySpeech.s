.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_PlaySpeech, 0x40

glabel SPCH_PlaySpeech
    /* D7E44 800E7644 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D7E48 800E7648 1000BFAF */  sw         $ra, 0x10($sp)
    /* D7E4C 800E764C A905040C */  jal        iSPCH_OneChosen
    /* D7E50 800E7650 00000000 */   nop
    /* D7E54 800E7654 05004014 */  bnez       $v0, .L800E766C
    /* D7E58 800E7658 00000000 */   nop
    /* D7E5C 800E765C A19D030C */  jal        SPCH_ChooseSpeech
    /* D7E60 800E7660 00000000 */   nop
    /* D7E64 800E7664 03004010 */  beqz       $v0, .L800E7674
    /* D7E68 800E7668 00000000 */   nop
  .L800E766C:
    /* D7E6C 800E766C AD05040C */  jal        iSPCH_PlayChosen
    /* D7E70 800E7670 00000000 */   nop
  .L800E7674:
    /* D7E74 800E7674 1000BF8F */  lw         $ra, 0x10($sp)
    /* D7E78 800E7678 00000000 */  nop
    /* D7E7C 800E767C 0800E003 */  jr         $ra
    /* D7E80 800E7680 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SPCH_PlaySpeech
