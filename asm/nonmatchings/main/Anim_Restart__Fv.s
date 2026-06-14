.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_Restart__Fv, 0x88

glabel Anim_Restart__Fv
    /* 64294 80073A94 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 64298 80073A98 1180023C */  lui        $v0, %hi(animSlots)
    /* 6429C 80073A9C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 642A0 80073AA0 4CE15124 */  addiu      $s1, $v0, %lo(animSlots)
    /* 642A4 80073AA4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 642A8 80073AA8 80003226 */  addiu      $s2, $s1, 0x80
    /* 642AC 80073AAC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 642B0 80073AB0 1000B0AF */  sw         $s0, 0x10($sp)
  .L80073AB4:
    /* 642B4 80073AB4 2A103202 */  slt        $v0, $s1, $s2
    /* 642B8 80073AB8 10004010 */  beqz       $v0, .L80073AFC
    /* 642BC 80073ABC 00000000 */   nop
    /* 642C0 80073AC0 0000308E */  lw         $s0, 0x0($s1)
    /* 642C4 80073AC4 00000000 */  nop
    /* 642C8 80073AC8 09000012 */  beqz       $s0, .L80073AF0
    /* 642CC 80073ACC 00000000 */   nop
    /* 642D0 80073AD0 1000048E */  lw         $a0, 0x10($s0)
    /* 642D4 80073AD4 00000000 */  nop
    /* 642D8 80073AD8 03008010 */  beqz       $a0, .L80073AE8
    /* 642DC 80073ADC 00000000 */   nop
    /* 642E0 80073AE0 738F020C */  jal        __builtin_vec_delete
    /* 642E4 80073AE4 00000000 */   nop
  .L80073AE8:
    /* 642E8 80073AE8 6B8F020C */  jal        __builtin_delete
    /* 642EC 80073AEC 21200002 */   addu      $a0, $s0, $zero
  .L80073AF0:
    /* 642F0 80073AF0 000020AE */  sw         $zero, 0x0($s1)
    /* 642F4 80073AF4 ADCE0108 */  j          .L80073AB4
    /* 642F8 80073AF8 04003126 */   addiu     $s1, $s1, 0x4
  .L80073AFC:
    /* 642FC 80073AFC 871D030C */  jal        DrawW_ResetAnimationTimer__Fv
    /* 64300 80073B00 00000000 */   nop
    /* 64304 80073B04 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 64308 80073B08 1800B28F */  lw         $s2, 0x18($sp)
    /* 6430C 80073B0C 1400B18F */  lw         $s1, 0x14($sp)
    /* 64310 80073B10 1000B08F */  lw         $s0, 0x10($sp)
    /* 64314 80073B14 0800E003 */  jr         $ra
    /* 64318 80073B18 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Anim_Restart__Fv
