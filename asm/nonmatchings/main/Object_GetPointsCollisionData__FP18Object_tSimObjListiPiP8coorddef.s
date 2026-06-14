.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef, 0x13C

glabel Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
    /* 958F4 800A50F4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 958F8 800A50F8 21108000 */  addu       $v0, $a0, $zero
    /* 958FC 800A50FC 2120A000 */  addu       $a0, $a1, $zero
    /* 95900 800A5100 21284000 */  addu       $a1, $v0, $zero
    /* 95904 800A5104 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 95908 800A5108 2188C000 */  addu       $s1, $a2, $zero
    /* 9590C 800A510C 1000A627 */  addiu      $a2, $sp, 0x10
    /* 95910 800A5110 2000B2AF */  sw         $s2, 0x20($sp)
    /* 95914 800A5114 2190E000 */  addu       $s2, $a3, $zero
    /* 95918 800A5118 2400BFAF */  sw         $ra, 0x24($sp)
    /* 9591C 800A511C C593020C */  jal        GetSimObj__FiP18Object_tSimObjListPi
    /* 95920 800A5120 1800B0AF */   sw        $s0, 0x18($sp)
    /* 95924 800A5124 21804000 */  addu       $s0, $v0, $zero
    /* 95928 800A5128 3A000012 */  beqz       $s0, .L800A5214
    /* 9592C 800A512C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 95930 800A5130 1000A38F */  lw         $v1, 0x10($sp)
    /* 95934 800A5134 00000000 */  nop
    /* 95938 800A5138 04006214 */  bne        $v1, $v0, .L800A514C
    /* 9593C 800A513C C0100300 */   sll       $v0, $v1, 3
    /* 95940 800A5140 12000592 */  lbu        $a1, 0x12($s0)
    /* 95944 800A5144 5A940208 */  j          .L800A5168
    /* 95948 800A5148 21200000 */   addu      $a0, $zero, $zero
  .L800A514C:
    /* 9594C 800A514C 23104300 */  subu       $v0, $v0, $v1
    /* 95950 800A5150 00110200 */  sll        $v0, $v0, 4
    /* 95954 800A5154 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 95958 800A5158 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 9595C 800A515C 12000592 */  lbu        $a1, 0x12($s0)
    /* 95960 800A5160 21104300 */  addu       $v0, $v0, $v1
    /* 95964 800A5164 4000448C */  lw         $a0, 0x40($v0)
  .L800A5168:
    /* 95968 800A5168 2393020C */  jal        FindObjInstanceFromSerialNum__FP5Groupi
    /* 9596C 800A516C 00000000 */   nop
    /* 95970 800A5170 21384000 */  addu       $a3, $v0, $zero
    /* 95974 800A5174 1E00E010 */  beqz       $a3, .L800A51F0
    /* 95978 800A5178 05000424 */   addiu     $a0, $zero, 0x5
    /* 9597C 800A517C 0600E284 */  lh         $v0, 0x6($a3)
    /* 95980 800A5180 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* 95984 800A5184 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* 95988 800A5188 80100200 */  sll        $v0, $v0, 2
    /* 9598C 800A518C 21104300 */  addu       $v0, $v0, $v1
    /* 95990 800A5190 0200E390 */  lbu        $v1, 0x2($a3)
    /* 95994 800A5194 0000458C */  lw         $a1, 0x0($v0)
    /* 95998 800A5198 0D006414 */  bne        $v1, $a0, .L800A51D0
    /* 9599C 800A519C 01000224 */   addiu     $v0, $zero, 0x1
    /* 959A0 800A51A0 2300E290 */  lbu        $v0, 0x23($a3)
    /* 959A4 800A51A4 00000000 */  nop
    /* 959A8 800A51A8 09004014 */  bnez       $v0, .L800A51D0
    /* 959AC 800A51AC 01000224 */   addiu     $v0, $zero, 0x1
    /* 959B0 800A51B0 21200002 */  addu       $a0, $s0, $zero
    /* 959B4 800A51B4 0400A524 */  addiu      $a1, $a1, 0x4
    /* 959B8 800A51B8 21304002 */  addu       $a2, $s2, $zero
    /* 959BC 800A51BC C792020C */  jal        CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
    /* 959C0 800A51C0 1400E724 */   addiu     $a3, $a3, 0x14
    /* 959C4 800A51C4 03000224 */  addiu      $v0, $zero, 0x3
    /* 959C8 800A51C8 86940208 */  j          .L800A5218
    /* 959CC 800A51CC 000022AE */   sw        $v0, 0x0($s1)
  .L800A51D0:
    /* 959D0 800A51D0 0000088E */  lw         $t0, 0x0($s0)
    /* 959D4 800A51D4 0400098E */  lw         $t1, 0x4($s0)
    /* 959D8 800A51D8 08000A8E */  lw         $t2, 0x8($s0)
    /* 959DC 800A51DC 000048AE */  sw         $t0, 0x0($s2)
    /* 959E0 800A51E0 040049AE */  sw         $t1, 0x4($s2)
    /* 959E4 800A51E4 08004AAE */  sw         $t2, 0x8($s2)
    /* 959E8 800A51E8 86940208 */  j          .L800A5218
    /* 959EC 800A51EC 000022AE */   sw        $v0, 0x0($s1)
  .L800A51F0:
    /* 959F0 800A51F0 01000224 */  addiu      $v0, $zero, 0x1
    /* 959F4 800A51F4 000022AE */  sw         $v0, 0x0($s1)
    /* 959F8 800A51F8 0000088E */  lw         $t0, 0x0($s0)
    /* 959FC 800A51FC 0400098E */  lw         $t1, 0x4($s0)
    /* 95A00 800A5200 08000A8E */  lw         $t2, 0x8($s0)
    /* 95A04 800A5204 000048AE */  sw         $t0, 0x0($s2)
    /* 95A08 800A5208 040049AE */  sw         $t1, 0x4($s2)
    /* 95A0C 800A520C 86940208 */  j          .L800A5218
    /* 95A10 800A5210 08004AAE */   sw        $t2, 0x8($s2)
  .L800A5214:
    /* 95A14 800A5214 000020AE */  sw         $zero, 0x0($s1)
  .L800A5218:
    /* 95A18 800A5218 2400BF8F */  lw         $ra, 0x24($sp)
    /* 95A1C 800A521C 2000B28F */  lw         $s2, 0x20($sp)
    /* 95A20 800A5220 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 95A24 800A5224 1800B08F */  lw         $s0, 0x18($sp)
    /* 95A28 800A5228 0800E003 */  jr         $ra
    /* 95A2C 800A522C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
