.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1, 0x11C

glabel AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
    /* 64178 80073978 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6417C 8007397C 2000B4AF */  sw         $s4, 0x20($sp)
    /* 64180 80073980 21A08000 */  addu       $s4, $a0, $zero
    /* 64184 80073984 2800BFAF */  sw         $ra, 0x28($sp)
    /* 64188 80073988 2400B5AF */  sw         $s5, 0x24($sp)
    /* 6418C 8007398C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 64190 80073990 1800B2AF */  sw         $s2, 0x18($sp)
    /* 64194 80073994 1400B1AF */  sw         $s1, 0x14($sp)
    /* 64198 80073998 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6419C 8007399C 5405838E */  lw         $v1, 0x554($s4)
    /* 641A0 800739A0 1480023C */  lui        $v0, %hi(AITune_driveSide)
    /* 641A4 800739A4 F4C5428C */  lw         $v0, %lo(AITune_driveSide)($v0)
    /* 641A8 800739A8 00000000 */  nop
    /* 641AC 800739AC 18006200 */  mult       $v1, $v0
    /* 641B0 800739B0 2190A000 */  addu       $s2, $a1, $zero
    /* 641B4 800739B4 21A8C000 */  addu       $s5, $a2, $zero
    /* 641B8 800739B8 01000224 */  addiu      $v0, $zero, 0x1
    /* 641BC 800739BC 12980000 */  mflo       $s3
    /* 641C0 800739C0 0B006216 */  bne        $s3, $v0, .L800739F0
    /* 641C4 800739C4 21800000 */   addu      $s0, $zero, $zero
    /* 641C8 800739C8 07000224 */  addiu      $v0, $zero, 0x7
    /* 641CC 800739CC 000042AE */  sw         $v0, 0x0($s2)
    /* 641D0 800739D0 08008286 */  lh         $v0, 0x8($s4)
    /* 641D4 800739D4 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 641D8 800739D8 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 641DC 800739DC 40110200 */  sll        $v0, $v0, 5
    /* 641E0 800739E0 21104300 */  addu       $v0, $v0, $v1
    /* 641E4 800739E4 1F004290 */  lbu        $v0, 0x1F($v0)
    /* 641E8 800739E8 86CE0108 */  j          .L80073A18
    /* 641EC 800739EC C08B0200 */   sll       $s1, $v0, 15
  .L800739F0:
    /* 641F0 800739F0 06000224 */  addiu      $v0, $zero, 0x6
    /* 641F4 800739F4 000042AE */  sw         $v0, 0x0($s2)
    /* 641F8 800739F8 08008286 */  lh         $v0, 0x8($s4)
    /* 641FC 800739FC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 64200 80073A00 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 64204 80073A04 40110200 */  sll        $v0, $v0, 5
    /* 64208 80073A08 21104300 */  addu       $v0, $v0, $v1
    /* 6420C 80073A0C 1E004290 */  lbu        $v0, 0x1E($v0)
    /* 64210 80073A10 00000000 */  nop
    /* 64214 80073A14 C08B0200 */  sll        $s1, $v0, 15
  .L80073A18:
    /* 64218 80073A18 0300022A */  slti       $v0, $s0, 0x3
    /* 6421C 80073A1C 0E004010 */  beqz       $v0, .L80073A58
    /* 64220 80073A20 18003002 */   mult      $s1, $s0
  .L80073A24:
    /* 64224 80073A24 08008486 */  lh         $a0, 0x8($s4)
    /* 64228 80073A28 0000458E */  lw         $a1, 0x0($s2)
    /* 6422C 80073A2C EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 64230 80073A30 00000000 */   nop
    /* 64234 80073A34 08004014 */  bnez       $v0, .L80073A58
    /* 64238 80073A38 18003002 */   mult      $s1, $s0
    /* 6423C 80073A3C 0000428E */  lw         $v0, 0x0($s2)
    /* 64240 80073A40 01001026 */  addiu      $s0, $s0, 0x1
    /* 64244 80073A44 21105300 */  addu       $v0, $v0, $s3
    /* 64248 80073A48 000042AE */  sw         $v0, 0x0($s2)
    /* 6424C 80073A4C 0300022A */  slti       $v0, $s0, 0x3
    /* 64250 80073A50 F4FF4014 */  bnez       $v0, .L80073A24
    /* 64254 80073A54 18003002 */   mult      $s1, $s0
  .L80073A58:
    /* 64258 80073A58 12380000 */  mflo       $a3
    /* 6425C 80073A5C 42101100 */  srl        $v0, $s1, 1
    /* 64260 80073A60 2110E200 */  addu       $v0, $a3, $v0
    /* 64264 80073A64 18006202 */  mult       $s3, $v0
    /* 64268 80073A68 12380000 */  mflo       $a3
    /* 6426C 80073A6C 0000A7AE */  sw         $a3, 0x0($s5)
    /* 64270 80073A70 2800BF8F */  lw         $ra, 0x28($sp)
    /* 64274 80073A74 2400B58F */  lw         $s5, 0x24($sp)
    /* 64278 80073A78 2000B48F */  lw         $s4, 0x20($sp)
    /* 6427C 80073A7C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 64280 80073A80 1800B28F */  lw         $s2, 0x18($sp)
    /* 64284 80073A84 1400B18F */  lw         $s1, 0x14($sp)
    /* 64288 80073A88 1000B08F */  lw         $s0, 0x10($sp)
    /* 6428C 80073A8C 0800E003 */  jr         $ra
    /* 64290 80073A90 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
