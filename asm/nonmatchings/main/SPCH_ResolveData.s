.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_ResolveData, 0x20

glabel SPCH_ResolveData
    /* DC3D4 800EBBD4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DC3D8 800EBBD8 1000BFAF */  sw         $ra, 0x10($sp)
    /* DC3DC 800EBBDC E1AE030C */  jal        iSPCH_BindData
    /* DC3E0 800EBBE0 00000000 */   nop
    /* DC3E4 800EBBE4 1000BF8F */  lw         $ra, 0x10($sp)
    /* DC3E8 800EBBE8 00000000 */  nop
    /* DC3EC 800EBBEC 0800E003 */  jr         $ra
    /* DC3F0 800EBBF0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SPCH_ResolveData
