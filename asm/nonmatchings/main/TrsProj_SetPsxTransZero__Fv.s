.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_SetPsxTransZero__Fv, 0x30

glabel TrsProj_SetPsxTransZero__Fv
    /* D239C 800E1B9C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D23A0 800E1BA0 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* D23A4 800E1BA4 1800A0AF */  sw         $zero, 0x18($sp)
    /* D23A8 800E1BA8 1400A0AF */  sw         $zero, 0x14($sp)
    /* D23AC 800E1BAC 1400AC8F */  lw         $t4, 0x14($sp)
    /* D23B0 800E1BB0 1800AD8F */  lw         $t5, 0x18($sp)
    /* D23B4 800E1BB4 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* D23B8 800E1BB8 1C00AE8F */  lw         $t6, 0x1C($sp)
    /* D23BC 800E1BBC 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* D23C0 800E1BC0 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* D23C4 800E1BC4 0800E003 */  jr         $ra
    /* D23C8 800E1BC8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TrsProj_SetPsxTransZero__Fv
