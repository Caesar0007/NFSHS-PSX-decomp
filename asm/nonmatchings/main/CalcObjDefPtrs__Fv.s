.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcObjDefPtrs__Fv, 0x64

glabel CalcObjDefPtrs__Fv
    /* AADC8 800BA5C8 01000524 */  addiu      $a1, $zero, 0x1
    /* AADCC 800BA5CC 700F828F */  lw         $v0, %gp_rel(gPersistObjDef)($gp)
    /* AADD0 800BA5D0 940F838F */  lw         $v1, %gp_rel(gObjDefOffsetsGroup)($gp)
    /* AADD4 800BA5D4 21304000 */  addu       $a2, $v0, $zero
    /* AADD8 800BA5D8 08006424 */  addiu      $a0, $v1, 0x8
    /* AADDC 800BA5DC 0400C224 */  addiu      $v0, $a2, 0x4
    /* AADE0 800BA5E0 040062AC */  sw         $v0, 0x4($v1)
  .L800BA5E4:
    /* AADE4 800BA5E4 0000C28C */  lw         $v0, 0x0($a2)
    /* AADE8 800BA5E8 00000000 */  nop
    /* AADEC 800BA5EC 2A10A200 */  slt        $v0, $a1, $v0
    /* AADF0 800BA5F0 08004010 */  beqz       $v0, .L800BA614
    /* AADF4 800BA5F4 0100A524 */   addiu     $a1, $a1, 0x1
    /* AADF8 800BA5F8 FCFF828C */  lw         $v0, -0x4($a0)
    /* AADFC 800BA5FC 0000838C */  lw         $v1, 0x0($a0)
    /* AAE00 800BA600 00000000 */  nop
    /* AAE04 800BA604 21104300 */  addu       $v0, $v0, $v1
    /* AAE08 800BA608 000082AC */  sw         $v0, 0x0($a0)
    /* AAE0C 800BA60C 79E90208 */  j          .L800BA5E4
    /* AAE10 800BA610 04008424 */   addiu     $a0, $a0, 0x4
  .L800BA614:
    /* AAE14 800BA614 940F828F */  lw         $v0, %gp_rel(gObjDefOffsetsGroup)($gp)
    /* AAE18 800BA618 00000000 */  nop
    /* AAE1C 800BA61C 04004224 */  addiu      $v0, $v0, 0x4
    /* AAE20 800BA620 880F82AF */  sw         $v0, %gp_rel(Track_gObjDefs)($gp)
    /* AAE24 800BA624 0800E003 */  jr         $ra
    /* AAE28 800BA628 00000000 */   nop
endlabel CalcObjDefPtrs__Fv
