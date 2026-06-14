.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_CleanUp__Fv, 0x188

glabel Cars_CleanUp__Fv
    /* 7B240 8008AA40 A802828F */  lw         $v0, %gp_rel(Cars_gNumCars)($gp)
    /* 7B244 8008AA44 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7B248 8008AA48 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7B24C 8008AA4C 21900000 */  addu       $s2, $zero, $zero
    /* 7B250 8008AA50 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 7B254 8008AA54 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7B258 8008AA58 55004018 */  blez       $v0, .L8008ABB0
    /* 7B25C 8008AA5C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 7B260 8008AA60 1280023C */  lui        $v0, %hi(simGlobal)
    /* 7B264 8008AA64 ACE05124 */  addiu      $s1, $v0, %lo(simGlobal)
    /* 7B268 8008AA68 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 7B26C 8008AA6C DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L8008AA70:
    /* 7B270 8008AA70 0000068E */  lw         $a2, 0x0($s0)
    /* 7B274 8008AA74 1000248E */  lw         $a0, 0x10($s1)
    /* 7B278 8008AA78 C404C58C */  lw         $a1, 0x4C4($a2)
    /* 7B27C 8008AA7C 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B280 8008AA80 00000000 */   nop
    /* 7B284 8008AA84 0000068E */  lw         $a2, 0x0($s0)
    /* 7B288 8008AA88 1000248E */  lw         $a0, 0x10($s1)
    /* 7B28C 8008AA8C CC04C58C */  lw         $a1, 0x4CC($a2)
    /* 7B290 8008AA90 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B294 8008AA94 00000000 */   nop
    /* 7B298 8008AA98 0000068E */  lw         $a2, 0x0($s0)
    /* 7B29C 8008AA9C 00000000 */  nop
    /* 7B2A0 8008AAA0 6002C28C */  lw         $v0, 0x260($a2)
    /* 7B2A4 8008AAA4 00000000 */  nop
    /* 7B2A8 8008AAA8 01004230 */  andi       $v0, $v0, 0x1
    /* 7B2AC 8008AAAC 06004010 */  beqz       $v0, .L8008AAC8
    /* 7B2B0 8008AAB0 00000000 */   nop
    /* 7B2B4 8008AAB4 0C00248E */  lw         $a0, 0xC($s1)
    /* 7B2B8 8008AAB8 D004C58C */  lw         $a1, 0x4D0($a2)
    /* 7B2BC 8008AABC 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B2C0 8008AAC0 00000000 */   nop
    /* 7B2C4 8008AAC4 0000068E */  lw         $a2, 0x0($s0)
  .L8008AAC8:
    /* 7B2C8 8008AAC8 1000248E */  lw         $a0, 0x10($s1)
    /* 7B2CC 8008AACC D404C58C */  lw         $a1, 0x4D4($a2)
    /* 7B2D0 8008AAD0 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B2D4 8008AAD4 00000000 */   nop
    /* 7B2D8 8008AAD8 0000068E */  lw         $a2, 0x0($s0)
    /* 7B2DC 8008AADC 1000248E */  lw         $a0, 0x10($s1)
    /* 7B2E0 8008AAE0 D804C58C */  lw         $a1, 0x4D8($a2)
    /* 7B2E4 8008AAE4 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B2E8 8008AAE8 00000000 */   nop
    /* 7B2EC 8008AAEC 0000068E */  lw         $a2, 0x0($s0)
    /* 7B2F0 8008AAF0 0C00248E */  lw         $a0, 0xC($s1)
    /* 7B2F4 8008AAF4 DC04C58C */  lw         $a1, 0x4DC($a2)
    /* 7B2F8 8008AAF8 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B2FC 8008AAFC 00000000 */   nop
    /* 7B300 8008AB00 0000068E */  lw         $a2, 0x0($s0)
    /* 7B304 8008AB04 1000248E */  lw         $a0, 0x10($s1)
    /* 7B308 8008AB08 E404C58C */  lw         $a1, 0x4E4($a2)
    /* 7B30C 8008AB0C 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B310 8008AB10 00000000 */   nop
    /* 7B314 8008AB14 0000068E */  lw         $a2, 0x0($s0)
    /* 7B318 8008AB18 1000248E */  lw         $a0, 0x10($s1)
    /* 7B31C 8008AB1C E804C58C */  lw         $a1, 0x4E8($a2)
    /* 7B320 8008AB20 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B324 8008AB24 00000000 */   nop
    /* 7B328 8008AB28 0000048E */  lw         $a0, 0x0($s0)
    /* 7B32C 8008AB2C 562C030C */  jal        Force_IsForceOn__FP8Car_tObj
    /* 7B330 8008AB30 00000000 */   nop
    /* 7B334 8008AB34 05004010 */  beqz       $v0, .L8008AB4C
    /* 7B338 8008AB38 0D80053C */   lui       $a1, %hi(Force_Update__FP8Car_tObj)
    /* 7B33C 8008AB3C 1000248E */  lw         $a0, 0x10($s1)
    /* 7B340 8008AB40 0000068E */  lw         $a2, 0x0($s0)
    /* 7B344 8008AB44 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B348 8008AB48 C0ABA524 */   addiu     $a1, $a1, %lo(Force_Update__FP8Car_tObj)
  .L8008AB4C:
    /* 7B34C 8008AB4C 0000068E */  lw         $a2, 0x0($s0)
    /* 7B350 8008AB50 00000000 */  nop
    /* 7B354 8008AB54 6002C28C */  lw         $v0, 0x260($a2)
    /* 7B358 8008AB58 00000000 */  nop
    /* 7B35C 8008AB5C 04004230 */  andi       $v0, $v0, 0x4
    /* 7B360 8008AB60 04004010 */  beqz       $v0, .L8008AB74
    /* 7B364 8008AB64 00000000 */   nop
    /* 7B368 8008AB68 0C00248E */  lw         $a0, 0xC($s1)
    /* 7B36C 8008AB6C DE2A0208 */  j          .L8008AB78
    /* 7B370 8008AB70 00000000 */   nop
  .L8008AB74:
    /* 7B374 8008AB74 1400248E */  lw         $a0, 0x14($s1)
  .L8008AB78:
    /* 7B378 8008AB78 E004C58C */  lw         $a1, 0x4E0($a2)
    /* 7B37C 8008AB7C 0DD9020C */  jal        Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* 7B380 8008AB80 01005226 */   addiu     $s2, $s2, 0x1
    /* 7B384 8008AB84 0000048E */  lw         $a0, 0x0($s0)
    /* 7B388 8008AB88 2129020C */  jal        Cars_DeInitCar__FP8Car_tObj
    /* 7B38C 8008AB8C 00000000 */   nop
    /* 7B390 8008AB90 0000048E */  lw         $a0, 0x0($s0)
    /* 7B394 8008AB94 5095030C */  jal        purgememadr
    /* 7B398 8008AB98 04001026 */   addiu     $s0, $s0, 0x4
    /* 7B39C 8008AB9C A802828F */  lw         $v0, %gp_rel(Cars_gNumCars)($gp)
    /* 7B3A0 8008ABA0 00000000 */  nop
    /* 7B3A4 8008ABA4 2A104202 */  slt        $v0, $s2, $v0
    /* 7B3A8 8008ABA8 B1FF4014 */  bnez       $v0, .L8008AA70
    /* 7B3AC 8008ABAC 00000000 */   nop
  .L8008ABB0:
    /* 7B3B0 8008ABB0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 7B3B4 8008ABB4 1800B28F */  lw         $s2, 0x18($sp)
    /* 7B3B8 8008ABB8 1400B18F */  lw         $s1, 0x14($sp)
    /* 7B3BC 8008ABBC 1000B08F */  lw         $s0, 0x10($sp)
    /* 7B3C0 8008ABC0 0800E003 */  jr         $ra
    /* 7B3C4 8008ABC4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Cars_CleanUp__Fv
