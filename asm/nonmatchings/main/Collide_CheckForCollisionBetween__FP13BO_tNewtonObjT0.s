.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0, 0x160

glabel Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
    /* 81B74 80091374 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 81B78 80091378 3400B1AF */  sw         $s1, 0x34($sp)
    /* 81B7C 8009137C 21888000 */  addu       $s1, $a0, $zero
    /* 81B80 80091380 3800B2AF */  sw         $s2, 0x38($sp)
    /* 81B84 80091384 2190A000 */  addu       $s2, $a1, $zero
    /* 81B88 80091388 1000A627 */  addiu      $a2, $sp, 0x10
    /* 81B8C 8009138C 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 81B90 80091390 2000B327 */  addiu      $s3, $sp, 0x20
    /* 81B94 80091394 21386002 */  addu       $a3, $s3, $zero
    /* 81B98 80091398 4400BFAF */  sw         $ra, 0x44($sp)
    /* 81B9C 8009139C 4000B4AF */  sw         $s4, 0x40($sp)
    /* 81BA0 800913A0 3000B0AF */  sw         $s0, 0x30($sp)
    /* 81BA4 800913A4 900120AE */  sw         $zero, 0x190($s1)
    /* 81BA8 800913A8 5140020C */  jal        Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
    /* 81BAC 800913AC 900140AE */   sw        $zero, 0x190($s2)
    /* 81BB0 800913B0 03004014 */  bnez       $v0, .L800913C0
    /* 81BB4 800913B4 21202002 */   addu      $a0, $s1, $zero
    /* 81BB8 800913B8 2D450208 */  j          .L800914B4
    /* 81BBC 800913BC 21100000 */   addu      $v0, $zero, $zero
  .L800913C0:
    /* 81BC0 800913C0 21284002 */  addu       $a1, $s2, $zero
    /* 81BC4 800913C4 1000A627 */  addiu      $a2, $sp, 0x10
    /* 81BC8 800913C8 7539020C */  jal        Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
    /* 81BCC 800913CC 21386002 */   addu      $a3, $s3, $zero
    /* 81BD0 800913D0 08001024 */  addiu      $s0, $zero, 0x8
    /* 81BD4 800913D4 ECA9020C */  jal        Physics_TestForBarrierCollision__FP8Car_tObj
    /* 81BD8 800913D8 21202002 */   addu      $a0, $s1, $zero
    /* 81BDC 800913DC ECA9020C */  jal        Physics_TestForBarrierCollision__FP8Car_tObj
    /* 81BE0 800913E0 21204002 */   addu      $a0, $s2, $zero
    /* 81BE4 800913E4 0F00143C */  lui        $s4, (0xF0000 >> 16)
  .L800913E8:
    /* 81BE8 800913E8 21202002 */  addu       $a0, $s1, $zero
  .L800913EC:
    /* 81BEC 800913EC 21284002 */  addu       $a1, $s2, $zero
  .L800913F0:
    /* 81BF0 800913F0 1000A627 */  addiu      $a2, $sp, 0x10
    /* 81BF4 800913F4 5140020C */  jal        Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
    /* 81BF8 800913F8 21386002 */   addu      $a3, $s3, $zero
    /* 81BFC 800913FC 2D004010 */  beqz       $v0, .L800914B4
    /* 81C00 80091400 01000224 */   addiu     $v0, $zero, 0x1
    /* 81C04 80091404 2B00001A */  blez       $s0, .L800914B4
    /* 81C08 80091408 FFFF1026 */   addiu     $s0, $s0, -0x1
    /* 81C0C 8009140C 21202002 */  addu       $a0, $s1, $zero
    /* 81C10 80091410 21284002 */  addu       $a1, $s2, $zero
    /* 81C14 80091414 1000A627 */  addiu      $a2, $sp, 0x10
    /* 81C18 80091418 7539020C */  jal        Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
    /* 81C1C 8009141C 21386002 */   addu      $a3, $s3, $zero
    /* 81C20 80091420 24004010 */  beqz       $v0, .L800914B4
    /* 81C24 80091424 01000224 */   addiu     $v0, $zero, 0x1
    /* 81C28 80091428 ECA9020C */  jal        Physics_TestForBarrierCollision__FP8Car_tObj
    /* 81C2C 8009142C 21202002 */   addu      $a0, $s1, $zero
    /* 81C30 80091430 ECA9020C */  jal        Physics_TestForBarrierCollision__FP8Car_tObj
    /* 81C34 80091434 21204002 */   addu      $a0, $s2, $zero
    /* 81C38 80091438 EBFF0016 */  bnez       $s0, .L800913E8
    /* 81C3C 8009143C 00000000 */   nop
    /* 81C40 80091440 EC03228E */  lw         $v0, 0x3EC($s1)
    /* 81C44 80091444 00000000 */  nop
    /* 81C48 80091448 0A004010 */  beqz       $v0, .L80091474
    /* 81C4C 8009144C 00000000 */   nop
    /* 81C50 80091450 C000228E */  lw         $v0, 0xC0($s1)
    /* 81C54 80091454 00000000 */  nop
    /* 81C58 80091458 2A108202 */  slt        $v0, $s4, $v0
    /* 81C5C 8009145C 05004010 */  beqz       $v0, .L80091474
    /* 81C60 80091460 21202002 */   addu      $a0, $s1, $zero
    /* 81C64 80091464 6400053C */  lui        $a1, (0x640000 >> 16)
    /* 81C68 80091468 08000624 */  addiu      $a2, $zero, 0x8
    /* 81C6C 8009146C CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 81C70 80091470 02000724 */   addiu     $a3, $zero, 0x2
  .L80091474:
    /* 81C74 80091474 EC03428E */  lw         $v0, 0x3EC($s2)
    /* 81C78 80091478 00000000 */  nop
    /* 81C7C 8009147C DBFF4010 */  beqz       $v0, .L800913EC
    /* 81C80 80091480 21202002 */   addu      $a0, $s1, $zero
    /* 81C84 80091484 C000428E */  lw         $v0, 0xC0($s2)
    /* 81C88 80091488 00000000 */  nop
    /* 81C8C 8009148C 2A108202 */  slt        $v0, $s4, $v0
    /* 81C90 80091490 D7FF4010 */  beqz       $v0, .L800913F0
    /* 81C94 80091494 21284002 */   addu      $a1, $s2, $zero
    /* 81C98 80091498 21204002 */  addu       $a0, $s2, $zero
    /* 81C9C 8009149C 6400053C */  lui        $a1, (0x640000 >> 16)
    /* 81CA0 800914A0 08000624 */  addiu      $a2, $zero, 0x8
    /* 81CA4 800914A4 CB7B020C */  jal        Newton_AddDamageZone__FP13BO_tNewtonObjiii
    /* 81CA8 800914A8 02000724 */   addiu     $a3, $zero, 0x2
    /* 81CAC 800914AC FB440208 */  j          .L800913EC
    /* 81CB0 800914B0 21202002 */   addu      $a0, $s1, $zero
  .L800914B4:
    /* 81CB4 800914B4 4400BF8F */  lw         $ra, 0x44($sp)
    /* 81CB8 800914B8 4000B48F */  lw         $s4, 0x40($sp)
    /* 81CBC 800914BC 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 81CC0 800914C0 3800B28F */  lw         $s2, 0x38($sp)
    /* 81CC4 800914C4 3400B18F */  lw         $s1, 0x34($sp)
    /* 81CC8 800914C8 3000B08F */  lw         $s0, 0x30($sp)
    /* 81CCC 800914CC 0800E003 */  jr         $ra
    /* 81CD0 800914D0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
