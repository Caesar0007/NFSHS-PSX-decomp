.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_KillTrackSouffle__Fv, 0x28

glabel Souffle_KillTrackSouffle__Fv
    /* A8730 800B7F30 FC0E848F */  lw         $a0, %gp_rel(gISouffle)($gp)
    /* A8734 800B7F34 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A8738 800B7F38 03008010 */  beqz       $a0, .L800B7F48
    /* A873C 800B7F3C 1000BFAF */   sw        $ra, 0x10($sp)
    /* A8740 800B7F40 5095030C */  jal        purgememadr
    /* A8744 800B7F44 00000000 */   nop
  .L800B7F48:
    /* A8748 800B7F48 1000BF8F */  lw         $ra, 0x10($sp)
    /* A874C 800B7F4C FC0E80AF */  sw         $zero, %gp_rel(gISouffle)($gp)
    /* A8750 800B7F50 0800E003 */  jr         $ra
    /* A8754 800B7F54 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Souffle_KillTrackSouffle__Fv
