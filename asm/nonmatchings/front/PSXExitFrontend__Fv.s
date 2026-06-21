.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXExitFrontend__Fv, 0x58

glabel PSXExitFrontend__Fv
    /* 3E470 8004DC70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3E474 8004DC74 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3E478 8004DC78 7336010C */  jal        CleanupSpinningCars__Fv
    /* 3E47C 8004DC7C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3E480 8004DC80 0E80043C */  lui        $a0, %hi(PAD_update)
    /* 3E484 8004DC84 12AC030C */  jal        deltimer
    /* 3E488 8004DC88 10428424 */   addiu     $a0, $a0, %lo(PAD_update)
    /* 3E48C 8004DC8C 19EF020C */  jal        Audio_DeInitDriver__Fv
    /* 3E490 8004DC90 0580103C */   lui       $s0, %hi(gHelpShapes)
    /* 3E494 8004DC94 642A048E */  lw         $a0, %lo(gHelpShapes)($s0)
    /* 3E498 8004DC98 00000000 */  nop
    /* 3E49C 8004DC9C 04008010 */  beqz       $a0, .L8004DCB0
    /* 3E4A0 8004DCA0 00000000 */   nop
    /* 3E4A4 8004DCA4 5095030C */  jal        purgememadr
    /* 3E4A8 8004DCA8 00000000 */   nop
    /* 3E4AC 8004DCAC 642A00AE */  sw         $zero, %lo(gHelpShapes)($s0)
  .L8004DCB0:
    /* 3E4B0 8004DCB0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3E4B4 8004DCB4 1000B08F */  lw         $s0, 0x10($sp)
    /* 3E4B8 8004DCB8 0580023C */  lui        $v0, %hi(ComingIntoTheFrontEndTheVeryFirstTime)
    /* 3E4BC 8004DCBC EC1740AC */  sw         $zero, %lo(ComingIntoTheFrontEndTheVeryFirstTime)($v0)
    /* 3E4C0 8004DCC0 0800E003 */  jr         $ra
    /* 3E4C4 8004DCC4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PSXExitFrontend__Fv
