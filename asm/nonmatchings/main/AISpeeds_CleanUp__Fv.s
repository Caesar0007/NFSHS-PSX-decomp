.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CleanUp__Fv, 0x2C

glabel AISpeeds_CleanUp__Fv
    /* 5E070 8006D870 6400848F */  lw         $a0, %gp_rel(D_8013C5B0)($gp)
    /* 5E074 8006D874 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5E078 8006D878 04008010 */  beqz       $a0, .L8006D88C
    /* 5E07C 8006D87C 1000BFAF */   sw        $ra, 0x10($sp)
    /* 5E080 8006D880 5095030C */  jal        purgememadr
    /* 5E084 8006D884 00000000 */   nop
    /* 5E088 8006D888 640080AF */  sw         $zero, %gp_rel(D_8013C5B0)($gp)
  .L8006D88C:
    /* 5E08C 8006D88C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5E090 8006D890 00000000 */  nop
    /* 5E094 8006D894 0800E003 */  jr         $ra
    /* 5E098 8006D898 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AISpeeds_CleanUp__Fv
