.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1, 0xDC

glabel Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
    /* 9196C 800A116C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 91970 800A1170 2800B2AF */  sw         $s2, 0x28($sp)
    /* 91974 800A1174 21908000 */  addu       $s2, $a0, $zero
    /* 91978 800A1178 2400B1AF */  sw         $s1, 0x24($sp)
    /* 9197C 800A117C 2188A000 */  addu       $s1, $a1, $zero
    /* 91980 800A1180 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 91984 800A1184 2000B0AF */  sw         $s0, 0x20($sp)
    /* 91988 800A1188 A000458E */  lw         $a1, 0xA0($s2)
    /* 9198C 800A118C 0000C28C */  lw         $v0, 0x0($a2)
    /* 91990 800A1190 00000000 */  nop
    /* 91994 800A1194 2328A200 */  subu       $a1, $a1, $v0
    /* 91998 800A1198 1000A5AF */  sw         $a1, 0x10($sp)
    /* 9199C 800A119C A400428E */  lw         $v0, 0xA4($s2)
    /* 919A0 800A11A0 0400C38C */  lw         $v1, 0x4($a2)
    /* 919A4 800A11A4 00000000 */  nop
    /* 919A8 800A11A8 23104300 */  subu       $v0, $v0, $v1
    /* 919AC 800A11AC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 919B0 800A11B0 A800428E */  lw         $v0, 0xA8($s2)
    /* 919B4 800A11B4 0800C38C */  lw         $v1, 0x8($a2)
    /* 919B8 800A11B8 00000000 */  nop
    /* 919BC 800A11BC 23104300 */  subu       $v0, $v0, $v1
    /* 919C0 800A11C0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 919C4 800A11C4 0000248E */  lw         $a0, 0x0($s1)
    /* 919C8 800A11C8 CA90030C */  jal        fixedmult
    /* 919CC 800A11CC 00000000 */   nop
    /* 919D0 800A11D0 0400248E */  lw         $a0, 0x4($s1)
    /* 919D4 800A11D4 1400A58F */  lw         $a1, 0x14($sp)
    /* 919D8 800A11D8 CA90030C */  jal        fixedmult
    /* 919DC 800A11DC 21804000 */   addu      $s0, $v0, $zero
    /* 919E0 800A11E0 0800248E */  lw         $a0, 0x8($s1)
    /* 919E4 800A11E4 1800A58F */  lw         $a1, 0x18($sp)
    /* 919E8 800A11E8 CA90030C */  jal        fixedmult
    /* 919EC 800A11EC 21884000 */   addu      $s1, $v0, $zero
    /* 919F0 800A11F0 21801102 */  addu       $s0, $s0, $s1
    /* 919F4 800A11F4 21800202 */  addu       $s0, $s0, $v0
    /* 919F8 800A11F8 2C01438E */  lw         $v1, 0x12C($s2)
    /* 919FC 800A11FC 33B30234 */  ori        $v0, $zero, 0xB333
    /* 91A00 800A1200 02006104 */  bgez       $v1, .L800A120C
    /* 91A04 800A1204 00000000 */   nop
    /* 91A08 800A1208 23180300 */  negu       $v1, $v1
  .L800A120C:
    /* 91A0C 800A120C 2A104300 */  slt        $v0, $v0, $v1
    /* 91A10 800A1210 04004014 */  bnez       $v0, .L800A1224
    /* 91A14 800A1214 00000000 */   nop
    /* 91A18 800A1218 3401428E */  lw         $v0, 0x134($s2)
    /* 91A1C 800A121C 8C840208 */  j          .L800A1230
    /* 91A20 800A1220 23100202 */   subu      $v0, $s0, $v0
  .L800A1224:
    /* 91A24 800A1224 3801428E */  lw         $v0, 0x138($s2)
    /* 91A28 800A1228 00000000 */  nop
    /* 91A2C 800A122C 23100202 */  subu       $v0, $s0, $v0
  .L800A1230:
    /* 91A30 800A1230 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 91A34 800A1234 2800B28F */  lw         $s2, 0x28($sp)
    /* 91A38 800A1238 2400B18F */  lw         $s1, 0x24($sp)
    /* 91A3C 800A123C 2000B08F */  lw         $s0, 0x20($sp)
    /* 91A40 800A1240 0800E003 */  jr         $ra
    /* 91A44 800A1244 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
