.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseDescription__13tTrackManager, 0x40

glabel ReleaseDescription__13tTrackManager
    /* 1244C 80021C4C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 12450 80021C50 1000B0AF */  sw         $s0, 0x10($sp)
    /* 12454 80021C54 21808000 */  addu       $s0, $a0, $zero
    /* 12458 80021C58 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1245C 80021C5C 0400048E */  lw         $a0, 0x4($s0)
    /* 12460 80021C60 00000000 */  nop
    /* 12464 80021C64 03008010 */  beqz       $a0, .L80021C74
    /* 12468 80021C68 00000000 */   nop
    /* 1246C 80021C6C 5095030C */  jal        purgememadr
    /* 12470 80021C70 00000000 */   nop
  .L80021C74:
    /* 12474 80021C74 040000AE */  sw         $zero, 0x4($s0)
    /* 12478 80021C78 000000AE */  sw         $zero, 0x0($s0)
    /* 1247C 80021C7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 12480 80021C80 1000B08F */  lw         $s0, 0x10($sp)
    /* 12484 80021C84 0800E003 */  jr         $ra
    /* 12488 80021C88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ReleaseDescription__13tTrackManager
