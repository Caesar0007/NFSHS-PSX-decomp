.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_DeInitCustomObjects__Fv, 0x60

glabel Object_DeInitCustomObjects__Fv
    /* 95E0C 800A560C 7C0D848F */  lw         $a0, %gp_rel(Object_customObjInst)($gp)
    /* 95E10 800A5610 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 95E14 800A5614 03008010 */  beqz       $a0, .L800A5624
    /* 95E18 800A5618 1000BFAF */   sw        $ra, 0x10($sp)
    /* 95E1C 800A561C 5095030C */  jal        purgememadr
    /* 95E20 800A5620 00000000 */   nop
  .L800A5624:
    /* 95E24 800A5624 840D848F */  lw         $a0, %gp_rel(Object_customSFXInst)($gp)
    /* 95E28 800A5628 00000000 */  nop
    /* 95E2C 800A562C 03008010 */  beqz       $a0, .L800A563C
    /* 95E30 800A5630 00000000 */   nop
    /* 95E34 800A5634 5095030C */  jal        purgememadr
    /* 95E38 800A5638 00000000 */   nop
  .L800A563C:
    /* 95E3C 800A563C 800D848F */  lw         $a0, %gp_rel(Object_customSimObjs)($gp)
    /* 95E40 800A5640 00000000 */  nop
    /* 95E44 800A5644 03008010 */  beqz       $a0, .L800A5654
    /* 95E48 800A5648 00000000 */   nop
    /* 95E4C 800A564C 5095030C */  jal        purgememadr
    /* 95E50 800A5650 00000000 */   nop
  .L800A5654:
    /* 95E54 800A5654 1000BF8F */  lw         $ra, 0x10($sp)
    /* 95E58 800A5658 7C0D80AF */  sw         $zero, %gp_rel(Object_customObjInst)($gp)
    /* 95E5C 800A565C 840D80AF */  sw         $zero, %gp_rel(Object_customSFXInst)($gp)
    /* 95E60 800A5660 800D80AF */  sw         $zero, %gp_rel(Object_customSimObjs)($gp)
    /* 95E64 800A5664 0800E003 */  jr         $ra
    /* 95E68 800A5668 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Object_DeInitCustomObjects__Fv
