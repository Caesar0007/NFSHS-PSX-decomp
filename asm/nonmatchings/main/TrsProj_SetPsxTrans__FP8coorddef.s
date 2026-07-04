.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrsProj_SetPsxTrans__FP8coorddef, 0x50

glabel TrsProj_SetPsxTrans__FP8coorddef
    /* D234C 800E1B4C 0000828C */  lw         $v0, 0x0($a0)
    /* D2350 800E1B50 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D2354 800E1B54 83120200 */  sra        $v0, $v0, 10
    /* D2358 800E1B58 1400A2AF */  sw         $v0, 0x14($sp)
    /* D235C 800E1B5C 0400828C */  lw         $v0, 0x4($a0)
    /* D2360 800E1B60 00000000 */  nop
    /* D2364 800E1B64 83120200 */  sra        $v0, $v0, 10
    /* D2368 800E1B68 1800A2AF */  sw         $v0, 0x18($sp)
    /* D236C 800E1B6C 0800828C */  lw         $v0, 0x8($a0)
    /* D2370 800E1B70 00000000 */  nop
    /* D2374 800E1B74 83120200 */  sra        $v0, $v0, 10
    /* D2378 800E1B78 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* D237C 800E1B7C 1400AC8F */  lw         $t4, 0x14($sp)
    /* D2380 800E1B80 1800AD8F */  lw         $t5, 0x18($sp)
    /* D2384 800E1B84 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* D2388 800E1B88 1C00AE8F */  lw         $t6, 0x1C($sp)
    /* D238C 800E1B8C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* D2390 800E1B90 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* D2394 800E1B94 0800E003 */  jr         $ra
    /* D2398 800E1B98 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TrsProj_SetPsxTrans__FP8coorddef
