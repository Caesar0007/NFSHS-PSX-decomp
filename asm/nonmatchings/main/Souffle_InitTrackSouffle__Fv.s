.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_InitTrackSouffle__Fv, 0x40

glabel Souffle_InitTrackSouffle__Fv
    /* A86D4 800B7ED4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A86D8 800B7ED8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A86DC 800B7EDC 1480043C */  lui        $a0, %hi(D_8013D440)
    /* A86E0 800B7EE0 40D48424 */  addiu      $a0, $a0, %lo(D_8013D440)
    /* A86E4 800B7EE4 F00F0524 */  addiu      $a1, $zero, 0xFF0
    /* A86E8 800B7EE8 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* A86EC 800B7EEC 1000BFAF */  sw         $ra, 0x10($sp)
    /* A86F0 800B7EF0 080F80AF */  sw         $zero, %gp_rel(gWindDir)($gp)
    /* A86F4 800B7EF4 000F80AF */  sw         $zero, %gp_rel(gCISouffle)($gp)
    /* A86F8 800B7EF8 040F82AF */  sw         $v0, %gp_rel(gTMoveSouffle)($gp)
    /* A86FC 800B7EFC CF94030C */  jal        reservememadr
    /* A8700 800B7F00 21300000 */   addu      $a2, $zero, $zero
    /* A8704 800B7F04 1000BF8F */  lw         $ra, 0x10($sp)
    /* A8708 800B7F08 FC0E82AF */  sw         $v0, %gp_rel(gISouffle)($gp)
    /* A870C 800B7F0C 0800E003 */  jr         $ra
    /* A8710 800B7F10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Souffle_InitTrackSouffle__Fv
