.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_InitSkidmark__Fv, 0x74

glabel Skidmark_InitSkidmark__Fv
    /* CFD04 800DF504 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CFD08 800DF508 10000224 */  addiu      $v0, $zero, 0x10
    /* CFD0C 800DF50C 881582AF */  sw         $v0, %gp_rel(gMaxSChunk)($gp)
    /* CFD10 800DF510 1180023C */  lui        $v0, %hi(D_801131F8)
    /* CFD14 800DF514 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* CFD18 800DF518 01000224 */  addiu      $v0, $zero, 0x1
    /* CFD1C 800DF51C 03006214 */  bne        $v1, $v0, .L800DF52C
    /* CFD20 800DF520 1000BFAF */   sw        $ra, 0x10($sp)
    /* CFD24 800DF524 08000224 */  addiu      $v0, $zero, 0x8
    /* CFD28 800DF528 881582AF */  sw         $v0, %gp_rel(gMaxSChunk)($gp)
  .L800DF52C:
    /* CFD2C 800DF52C 0580043C */  lui        $a0, %hi(D_80056A14)
    /* CFD30 800DF530 146A8424 */  addiu      $a0, $a0, %lo(D_80056A14)
    /* CFD34 800DF534 8815828F */  lw         $v0, %gp_rel(gMaxSChunk)($gp)
    /* CFD38 800DF538 21300000 */  addu       $a2, $zero, $zero
    /* CFD3C 800DF53C 40280200 */  sll        $a1, $v0, 1
    /* CFD40 800DF540 2128A200 */  addu       $a1, $a1, $v0
    /* CFD44 800DF544 80280500 */  sll        $a1, $a1, 2
    /* CFD48 800DF548 2328A200 */  subu       $a1, $a1, $v0
    /* CFD4C 800DF54C 80280500 */  sll        $a1, $a1, 2
    /* CFD50 800DF550 2328A200 */  subu       $a1, $a1, $v0
    /* CFD54 800DF554 CF94030C */  jal        reservememadr
    /* CFD58 800DF558 00290500 */   sll       $a1, $a1, 4
    /* CFD5C 800DF55C 0C0040A4 */  sh         $zero, 0xC($v0)
    /* CFD60 800DF560 1000BF8F */  lw         $ra, 0x10($sp)
    /* CFD64 800DF564 7C1582AF */  sw         $v0, %gp_rel(gSm)($gp)
    /* CFD68 800DF568 801580AF */  sw         $zero, %gp_rel(gCountSm)($gp)
    /* CFD6C 800DF56C 841580AF */  sw         $zero, %gp_rel(gUseSm)($gp)
    /* CFD70 800DF570 0800E003 */  jr         $ra
    /* CFD74 800DF574 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Skidmark_InitSkidmark__Fv
