.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_KillSkidmark__Fv, 0x28

glabel Skidmark_KillSkidmark__Fv
    /* CFD8C 800DF58C 7C15848F */  lw         $a0, %gp_rel(gSm)($gp)
    /* CFD90 800DF590 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CFD94 800DF594 03008010 */  beqz       $a0, .L800DF5A4
    /* CFD98 800DF598 1000BFAF */   sw        $ra, 0x10($sp)
    /* CFD9C 800DF59C 5095030C */  jal        purgememadr
    /* CFDA0 800DF5A0 00000000 */   nop
  .L800DF5A4:
    /* CFDA4 800DF5A4 1000BF8F */  lw         $ra, 0x10($sp)
    /* CFDA8 800DF5A8 7C1580AF */  sw         $zero, %gp_rel(gSm)($gp)
    /* CFDAC 800DF5AC 0800E003 */  jr         $ra
    /* CFDB0 800DF5B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Skidmark_KillSkidmark__Fv
