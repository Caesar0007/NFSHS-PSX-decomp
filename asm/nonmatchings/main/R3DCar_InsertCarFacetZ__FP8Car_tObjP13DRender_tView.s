.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView, 0x20

glabel R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView
    /* A33D8 800B2BD8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A33DC 800B2BDC 1000BFAF */  sw         $ra, 0x10($sp)
    /* A33E0 800B2BE0 F4BE020C */  jal        R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView
    /* A33E4 800B2BE4 00000000 */   nop
    /* A33E8 800B2BE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* A33EC 800B2BEC 00000000 */  nop
    /* A33F0 800B2BF0 0800E003 */  jr         $ra
    /* A33F4 800B2BF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView
