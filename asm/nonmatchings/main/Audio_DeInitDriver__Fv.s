.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Audio_DeInitDriver__Fv, 0x5C

glabel Audio_DeInitDriver__Fv
    /* AC464 800BBC64 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC468 800BBC68 1000BFAF */  sw         $ra, 0x10($sp)
    /* AC46C 800BBC6C 63EB010C */  jal        AudioMus_SysCleanUp__Fv
    /* AC470 800BBC70 00000000 */   nop
    /* AC474 800BBC74 1480023C */  lui        $v0, %hi(AudioCmn_kAudioOn)
    /* AC478 800BBC78 44C6428C */  lw         $v0, %lo(AudioCmn_kAudioOn)($v0)
    /* AC47C 800BBC7C 00000000 */  nop
    /* AC480 800BBC80 06004014 */  bnez       $v0, .L800BBC9C
    /* AC484 800BBC84 00000000 */   nop
    /* AC488 800BBC88 1480023C */  lui        $v0, %hi(AudioCmn_kAudioStreamingOn)
    /* AC48C 800BBC8C 48C6428C */  lw         $v0, %lo(AudioCmn_kAudioStreamingOn)($v0)
    /* AC490 800BBC90 00000000 */  nop
    /* AC494 800BBC94 06004010 */  beqz       $v0, .L800BBCB0
    /* AC498 800BBC98 00000000 */   nop
  .L800BBC9C:
    /* AC49C 800BBC9C 13C8030C */  jal        SNDSYS_restore
    /* AC4A0 800BBCA0 00000000 */   nop
    /* AC4A4 800BBCA4 B40F848F */  lw         $a0, %gp_rel(Audio_gHeap)($gp)
    /* AC4A8 800BBCA8 5095030C */  jal        purgememadr
    /* AC4AC 800BBCAC 00000000 */   nop
  .L800BBCB0:
    /* AC4B0 800BBCB0 1000BF8F */  lw         $ra, 0x10($sp)
    /* AC4B4 800BBCB4 00000000 */  nop
    /* AC4B8 800BBCB8 0800E003 */  jr         $ra
    /* AC4BC 800BBCBC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Audio_DeInitDriver__Fv
