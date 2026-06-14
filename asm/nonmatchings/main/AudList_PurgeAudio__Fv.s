.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudList_PurgeAudio__Fv, 0x28

glabel AudList_PurgeAudio__Fv
    /* 6BD2C 8007B52C E401848F */  lw         $a0, %gp_rel(gGameAudioList)($gp)
    /* 6BD30 8007B530 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6BD34 8007B534 03008010 */  beqz       $a0, .L8007B544
    /* 6BD38 8007B538 1000BFAF */   sw        $ra, 0x10($sp)
    /* 6BD3C 8007B53C 5095030C */  jal        purgememadr
    /* 6BD40 8007B540 00000000 */   nop
  .L8007B544:
    /* 6BD44 8007B544 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6BD48 8007B548 00000000 */  nop
    /* 6BD4C 8007B54C 0800E003 */  jr         $ra
    /* 6BD50 8007B550 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudList_PurgeAudio__Fv
