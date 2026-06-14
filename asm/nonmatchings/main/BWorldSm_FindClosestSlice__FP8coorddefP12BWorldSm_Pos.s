.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos, 0x9C

glabel BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 6F214 8007EA14 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6F218 8007EA18 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6F21C 8007EA1C 21888000 */  addu       $s1, $a0, $zero
    /* 6F220 8007EA20 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6F224 8007EA24 2180A000 */  addu       $s0, $a1, $zero
    /* 6F228 8007EA28 21282002 */  addu       $a1, $s1, $zero
    /* 6F22C 8007EA2C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6F230 8007EA30 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6F234 8007EA34 00001286 */  lh         $s2, 0x0($s0)
    /* 6F238 8007EA38 7402828F */  lw         $v0, %gp_rel(BWorldSm_slices)($gp)
    /* 6F23C 8007EA3C 40211200 */  sll        $a0, $s2, 5
    /* 6F240 8007EA40 F974020C */  jal        Math_DistXZ__FP8coorddefT0
    /* 6F244 8007EA44 21204400 */   addu      $a0, $v0, $a0
    /* 6F248 8007EA48 8000033C */  lui        $v1, (0x800000 >> 16)
    /* 6F24C 8007EA4C 2A186200 */  slt        $v1, $v1, $v0
    /* 6F250 8007EA50 03006010 */  beqz       $v1, .L8007EA60
    /* 6F254 8007EA54 21202002 */   addu      $a0, $s1, $zero
    /* 6F258 8007EA58 5CFA010C */  jal        FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
    /* 6F25C 8007EA5C 21280002 */   addu      $a1, $s0, $zero
  .L8007EA60:
    /* 6F260 8007EA60 21202002 */  addu       $a0, $s1, $zero
    /* 6F264 8007EA64 ACFA010C */  jal        RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 6F268 8007EA68 21280002 */   addu      $a1, $s0, $zero
    /* 6F26C 8007EA6C 00000386 */  lh         $v1, 0x0($s0)
    /* 6F270 8007EA70 7402848F */  lw         $a0, %gp_rel(BWorldSm_slices)($gp)
    /* 6F274 8007EA74 00000286 */  lh         $v0, 0x0($s0)
    /* 6F278 8007EA78 40190300 */  sll        $v1, $v1, 5
    /* 6F27C 8007EA7C 21186400 */  addu       $v1, $v1, $a0
    /* 6F280 8007EA80 26105200 */  xor        $v0, $v0, $s2
    /* 6F284 8007EA84 1C006390 */  lbu        $v1, 0x1C($v1)
    /* 6F288 8007EA88 2B100200 */  sltu       $v0, $zero, $v0
    /* 6F28C 8007EA8C 590002A2 */  sb         $v0, 0x59($s0)
    /* 6F290 8007EA90 580002A2 */  sb         $v0, 0x58($s0)
    /* 6F294 8007EA94 750003A2 */  sb         $v1, 0x75($s0)
    /* 6F298 8007EA98 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6F29C 8007EA9C 1800B28F */  lw         $s2, 0x18($sp)
    /* 6F2A0 8007EAA0 1400B18F */  lw         $s1, 0x14($sp)
    /* 6F2A4 8007EAA4 1000B08F */  lw         $s0, 0x10($sp)
    /* 6F2A8 8007EAA8 0800E003 */  jr         $ra
    /* 6F2AC 8007EAAC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
