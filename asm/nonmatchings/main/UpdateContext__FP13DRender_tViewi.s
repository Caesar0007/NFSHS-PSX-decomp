.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateContext__FP13DRender_tViewi, 0xB8

glabel UpdateContext__FP13DRender_tViewi
    /* 6DE08 8007D608 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6DE0C 8007D60C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6DE10 8007D610 21888000 */  addu       $s1, $a0, $zero
    /* 6DE14 8007D614 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6DE18 8007D618 2180A000 */  addu       $s0, $a1, $zero
    /* 6DE1C 8007D61C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 6DE20 8007D620 20F9010C */  jal        SetContext__Fi
    /* 6DE24 8007D624 21200002 */   addu      $a0, $s0, $zero
    /* 6DE28 8007D628 06000016 */  bnez       $s0, .L8007D644
    /* 6DE2C 8007D62C 08003026 */   addiu     $s0, $s1, 0x8
    /* 6DE30 8007D630 4402828F */  lw         $v0, %gp_rel(gCurrContext)($gp)
    /* 6DE34 8007D634 00000000 */  nop
    /* 6DE38 8007D638 04004284 */  lh         $v0, 0x4($v0)
    /* 6DE3C 8007D63C 00000000 */  nop
    /* 6DE40 8007D640 580282AF */  sw         $v0, %gp_rel(gBWSlice)($gp)
  .L8007D644:
    /* 6DE44 8007D644 21200002 */  addu       $a0, $s0, $zero
    /* 6DE48 8007D648 4402858F */  lw         $a1, %gp_rel(gCurrContext)($gp)
    /* 6DE4C 8007D64C 01000624 */  addiu      $a2, $zero, 0x1
    /* 6DE50 8007D650 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 6DE54 8007D654 0400A524 */   addiu     $a1, $a1, 0x4
    /* 6DE58 8007D658 4402858F */  lw         $a1, %gp_rel(gCurrContext)($gp)
    /* 6DE5C 8007D65C 00000000 */  nop
    /* 6DE60 8007D660 5E00A280 */  lb         $v0, 0x5E($a1)
    /* 6DE64 8007D664 00000000 */  nop
    /* 6DE68 8007D668 08004010 */  beqz       $v0, .L8007D68C
    /* 6DE6C 8007D66C 21200002 */   addu      $a0, $s0, $zero
    /* 6DE70 8007D670 5CFA010C */  jal        FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
    /* 6DE74 8007D674 0400A524 */   addiu     $a1, $a1, 0x4
    /* 6DE78 8007D678 21200002 */  addu       $a0, $s0, $zero
    /* 6DE7C 8007D67C 4402858F */  lw         $a1, %gp_rel(gCurrContext)($gp)
    /* 6DE80 8007D680 01000624 */  addiu      $a2, $zero, 0x1
    /* 6DE84 8007D684 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 6DE88 8007D688 0400A524 */   addiu     $a1, $a1, 0x4
  .L8007D68C:
    /* 6DE8C 8007D68C 4402838F */  lw         $v1, %gp_rel(gCurrContext)($gp)
    /* 6DE90 8007D690 00000000 */  nop
    /* 6DE94 8007D694 79006490 */  lbu        $a0, 0x79($v1)
    /* 6DE98 8007D698 8800628C */  lw         $v0, 0x88($v1)
    /* 6DE9C 8007D69C 00000000 */  nop
    /* 6DEA0 8007D6A0 02004410 */  beq        $v0, $a0, .L8007D6AC
    /* 6DEA4 8007D6A4 00000000 */   nop
    /* 6DEA8 8007D6A8 880064AC */  sw         $a0, 0x88($v1)
  .L8007D6AC:
    /* 6DEAC 8007D6AC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 6DEB0 8007D6B0 1400B18F */  lw         $s1, 0x14($sp)
    /* 6DEB4 8007D6B4 1000B08F */  lw         $s0, 0x10($sp)
    /* 6DEB8 8007D6B8 0800E003 */  jr         $ra
    /* 6DEBC 8007D6BC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateContext__FP13DRender_tViewi
