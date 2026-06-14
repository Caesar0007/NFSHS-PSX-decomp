.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_UnloadWords__Fv, 0x28

glabel TextSys_UnloadWords__Fv
    /* A9AD0 800B92D0 0C0F848F */  lw         $a0, %gp_rel(wordFile)($gp)
    /* A9AD4 800B92D4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A9AD8 800B92D8 03008010 */  beqz       $a0, .L800B92E8
    /* A9ADC 800B92DC 1000BFAF */   sw        $ra, 0x10($sp)
    /* A9AE0 800B92E0 5095030C */  jal        purgememadr
    /* A9AE4 800B92E4 00000000 */   nop
  .L800B92E8:
    /* A9AE8 800B92E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* A9AEC 800B92EC 0C0F80AF */  sw         $zero, %gp_rel(wordFile)($gp)
    /* A9AF0 800B92F0 0800E003 */  jr         $ra
    /* A9AF4 800B92F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextSys_UnloadWords__Fv
