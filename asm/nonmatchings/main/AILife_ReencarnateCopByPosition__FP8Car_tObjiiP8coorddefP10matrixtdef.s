.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef, 0x1B0

glabel AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
    /* 58B24 80068324 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 58B28 80068328 3400B1AF */  sw         $s1, 0x34($sp)
    /* 58B2C 8006832C 21888000 */  addu       $s1, $a0, $zero
    /* 58B30 80068330 3000B0AF */  sw         $s0, 0x30($sp)
    /* 58B34 80068334 2180A000 */  addu       $s0, $a1, $zero
    /* 58B38 80068338 3800B2AF */  sw         $s2, 0x38($sp)
    /* 58B3C 8006833C 2190C000 */  addu       $s2, $a2, $zero
    /* 58B40 80068340 4000B4AF */  sw         $s4, 0x40($sp)
    /* 58B44 80068344 21A0E000 */  addu       $s4, $a3, $zero
    /* 58B48 80068348 1000A427 */  addiu      $a0, $sp, 0x10
    /* 58B4C 8006834C 21280000 */  addu       $a1, $zero, $zero
    /* 58B50 80068350 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 58B54 80068354 5800B38F */  lw         $s3, 0x58($sp)
    /* 58B58 80068358 4400BFAF */  sw         $ra, 0x44($sp)
    /* 58B5C 8006835C C690030C */  jal        memset
    /* 58B60 80068360 0C000624 */   addiu     $a2, $zero, 0xC
    /* 58B64 80068364 2000A427 */  addiu      $a0, $sp, 0x20
    /* 58B68 80068368 21280000 */  addu       $a1, $zero, $zero
    /* 58B6C 8006836C C690030C */  jal        memset
    /* 58B70 80068370 0C000624 */   addiu     $a2, $zero, 0xC
    /* 58B74 80068374 1480023C */  lui        $v0, %hi(AITune_oneWay)
    /* 58B78 80068378 F0C5428C */  lw         $v0, %lo(AITune_oneWay)($v0)
    /* 58B7C 8006837C 00000000 */  nop
    /* 58B80 80068380 07004010 */  beqz       $v0, .L800683A0
    /* 58B84 80068384 080030A6 */   sh        $s0, 0x8($s1)
    /* 58B88 80068388 1180023C */  lui        $v0, %hi(D_8011321C)
    /* 58B8C 8006838C 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* 58B90 80068390 00000000 */  nop
    /* 58B94 80068394 02004014 */  bnez       $v0, .L800683A0
    /* 58B98 80068398 FFFF1224 */   addiu     $s2, $zero, -0x1
    /* 58B9C 8006839C 01001224 */  addiu      $s2, $zero, 0x1
  .L800683A0:
    /* 58BA0 800683A0 21202002 */  addu       $a0, $s1, $zero
    /* 58BA4 800683A4 540532AE */  sw         $s2, 0x554($s1)
    /* 58BA8 800683A8 500532AE */  sw         $s2, 0x550($s1)
    /* 58BAC 800683AC 5C0520AE */  sw         $zero, 0x55C($s1)
    /* 58BB0 800683B0 15B3010C */  jal        AIPhysic_ResetCar__FP8Car_tObj
    /* 58BB4 800683B4 640520AE */   sw        $zero, 0x564($s1)
    /* 58BB8 800683B8 21202002 */  addu       $a0, $s1, $zero
    /* 58BBC 800683BC 08002586 */  lh         $a1, 0x8($s1)
    /* 58BC0 800683C0 5405278E */  lw         $a3, 0x554($s1)
    /* 58BC4 800683C4 E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 58BC8 800683C8 2000A627 */   addiu     $a2, $sp, 0x20
    /* 58BCC 800683CC F0002326 */  addiu      $v1, $s1, 0xF0
    /* 58BD0 800683D0 21106002 */  addu       $v0, $s3, $zero
    /* 58BD4 800683D4 20006426 */  addiu      $a0, $s3, 0x20
    /* 58BD8 800683D8 0000888E */  lw         $t0, 0x0($s4)
    /* 58BDC 800683DC 0400898E */  lw         $t1, 0x4($s4)
    /* 58BE0 800683E0 08008A8E */  lw         $t2, 0x8($s4)
    /* 58BE4 800683E4 A00028AE */  sw         $t0, 0xA0($s1)
    /* 58BE8 800683E8 A40029AE */  sw         $t1, 0xA4($s1)
    /* 58BEC 800683EC A8002AAE */  sw         $t2, 0xA8($s1)
  .L800683F0:
    /* 58BF0 800683F0 0000488C */  lw         $t0, 0x0($v0)
    /* 58BF4 800683F4 0400498C */  lw         $t1, 0x4($v0)
    /* 58BF8 800683F8 08004A8C */  lw         $t2, 0x8($v0)
    /* 58BFC 800683FC 0C004B8C */  lw         $t3, 0xC($v0)
    /* 58C00 80068400 000068AC */  sw         $t0, 0x0($v1)
    /* 58C04 80068404 040069AC */  sw         $t1, 0x4($v1)
    /* 58C08 80068408 08006AAC */  sw         $t2, 0x8($v1)
    /* 58C0C 8006840C 0C006BAC */  sw         $t3, 0xC($v1)
    /* 58C10 80068410 10004224 */  addiu      $v0, $v0, 0x10
    /* 58C14 80068414 F6FF4414 */  bne        $v0, $a0, .L800683F0
    /* 58C18 80068418 10006324 */   addiu     $v1, $v1, 0x10
    /* 58C1C 8006841C 0000488C */  lw         $t0, 0x0($v0)
    /* 58C20 80068420 00000000 */  nop
    /* 58C24 80068424 000068AC */  sw         $t0, 0x0($v1)
    /* 58C28 80068428 C4012326 */  addiu      $v1, $s1, 0x1C4
    /* 58C2C 8006842C 21106002 */  addu       $v0, $s3, $zero
    /* 58C30 80068430 20004424 */  addiu      $a0, $v0, 0x20
  .L80068434:
    /* 58C34 80068434 0000488C */  lw         $t0, 0x0($v0)
    /* 58C38 80068438 0400498C */  lw         $t1, 0x4($v0)
    /* 58C3C 8006843C 08004A8C */  lw         $t2, 0x8($v0)
    /* 58C40 80068440 0C004B8C */  lw         $t3, 0xC($v0)
    /* 58C44 80068444 000068AC */  sw         $t0, 0x0($v1)
    /* 58C48 80068448 040069AC */  sw         $t1, 0x4($v1)
    /* 58C4C 8006844C 08006AAC */  sw         $t2, 0x8($v1)
    /* 58C50 80068450 0C006BAC */  sw         $t3, 0xC($v1)
    /* 58C54 80068454 10004224 */  addiu      $v0, $v0, 0x10
    /* 58C58 80068458 F6FF4414 */  bne        $v0, $a0, .L80068434
    /* 58C5C 8006845C 10006324 */   addiu     $v1, $v1, 0x10
    /* 58C60 80068460 0000488C */  lw         $t0, 0x0($v0)
    /* 58C64 80068464 00000000 */  nop
    /* 58C68 80068468 000068AC */  sw         $t0, 0x0($v1)
    /* 58C6C 8006846C 1000A88F */  lw         $t0, 0x10($sp)
    /* 58C70 80068470 1400A98F */  lw         $t1, 0x14($sp)
    /* 58C74 80068474 1800AA8F */  lw         $t2, 0x18($sp)
    /* 58C78 80068478 AC0028AE */  sw         $t0, 0xAC($s1)
    /* 58C7C 8006847C B00029AE */  sw         $t1, 0xB0($s1)
    /* 58C80 80068480 B4002AAE */  sw         $t2, 0xB4($s1)
    /* 58C84 80068484 5D9C010C */  jal        AIInit_ClearAICar__FP8Car_tObj
    /* 58C88 80068488 21202002 */   addu      $a0, $s1, $zero
    /* 58C8C 8006848C B22B020C */  jal        Cars_CalculateRoadPosition__FP8Car_tObj
    /* 58C90 80068490 21202002 */   addu      $a0, $s1, $zero
    /* 58C94 80068494 21202002 */  addu       $a0, $s1, $zero
    /* 58C98 80068498 180722AE */  sw         $v0, 0x718($s1)
    /* 58C9C 8006849C 580522AE */  sw         $v0, 0x558($s1)
    /* 58CA0 800684A0 202B020C */  jal        Cars_CalculateRoadSpan__FP8Car_tObj
    /* 58CA4 800684A4 740522AE */   sw        $v0, 0x574($s1)
    /* 58CA8 800684A8 21202002 */  addu       $a0, $s1, $zero
    /* 58CAC 800684AC 65CD010C */  jal        AIWorld_CalculateLaneInfo__FP8Car_tObj
    /* 58CB0 800684B0 6C0282AC */   sw        $v0, 0x26C($a0)
    /* 58CB4 800684B4 4400BF8F */  lw         $ra, 0x44($sp)
    /* 58CB8 800684B8 4000B48F */  lw         $s4, 0x40($sp)
    /* 58CBC 800684BC 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 58CC0 800684C0 3800B28F */  lw         $s2, 0x38($sp)
    /* 58CC4 800684C4 3400B18F */  lw         $s1, 0x34($sp)
    /* 58CC8 800684C8 3000B08F */  lw         $s0, 0x30($sp)
    /* 58CCC 800684CC 0800E003 */  jr         $ra
    /* 58CD0 800684D0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
