.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_HandleShifting__FP8Car_tObj, 0x168

glabel AIPhysic_HandleShifting__FP8Car_tObj
    /* 59BCC 800693CC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 59BD0 800693D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 59BD4 800693D4 21888000 */  addu       $s1, $a0, $zero
    /* 59BD8 800693D8 2000BFAF */  sw         $ra, 0x20($sp)
    /* 59BDC 800693DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 59BE0 800693E0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 59BE4 800693E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59BE8 800693E8 8005238E */  lw         $v1, 0x580($s1)
    /* 59BEC 800693EC 00000000 */  nop
    /* 59BF0 800693F0 06006018 */  blez       $v1, .L8006940C
    /* 59BF4 800693F4 B80B1024 */   addiu     $s0, $zero, 0xBB8
    /* 59BF8 800693F8 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 59BFC 800693FC 00000000 */  nop
    /* 59C00 80069400 23106200 */  subu       $v0, $v1, $v0
    /* 59C04 80069404 32A50108 */  j          .L800694C8
    /* 59C08 80069408 800522AE */   sw        $v0, 0x580($s1)
  .L8006940C:
    /* 59C0C 8006940C 4DA5010C */  jal        AIPhysic_CalculateGear__FP8Car_tObj
    /* 59C10 80069410 21202002 */   addu      $a0, $s1, $zero
    /* 59C14 80069414 21202002 */  addu       $a0, $s1, $zero
    /* 59C18 80069418 21984000 */  addu       $s3, $v0, $zero
    /* 59C1C 8006941C 21286002 */  addu       $a1, $s3, $zero
    /* 59C20 80069420 6405308E */  lw         $s0, 0x564($s1)
    /* 59C24 80069424 00000000 */  nop
    /* 59C28 80069428 02000106 */  bgez       $s0, .L80069434
    /* 59C2C 8006942C 00000000 */   nop
    /* 59C30 80069430 23801000 */  negu       $s0, $s0
  .L80069434:
    /* 59C34 80069434 A2A5010C */  jal        AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
    /* 59C38 80069438 21900000 */   addu      $s2, $zero, $zero
    /* 59C3C 8006943C 23800202 */  subu       $s0, $s0, $v0
    /* 59C40 80069440 0300622A */  slti       $v0, $s3, 0x3
    /* 59C44 80069444 02004014 */  bnez       $v0, .L80069450
    /* 59C48 80069448 21202002 */   addu      $a0, $s1, $zero
    /* 59C4C 8006944C A00F123C */  lui        $s2, (0xFA00000 >> 16)
  .L80069450:
    /* 59C50 80069450 8EA5010C */  jal        AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
    /* 59C54 80069454 21286002 */   addu      $a1, $s3, $zero
    /* 59C58 80069458 02000106 */  bgez       $s0, .L80069464
    /* 59C5C 8006945C 00000000 */   nop
    /* 59C60 80069460 FF001026 */  addiu      $s0, $s0, 0xFF
  .L80069464:
    /* 59C64 80069464 02004104 */  bgez       $v0, .L80069470
    /* 59C68 80069468 03821000 */   sra       $s0, $s0, 8
    /* 59C6C 8006946C FF004224 */  addiu      $v0, $v0, 0xFF
  .L80069470:
    /* 59C70 80069470 03120200 */  sra        $v0, $v0, 8
    /* 59C74 80069474 18000202 */  mult       $s0, $v0
    /* 59C78 80069478 12800000 */  mflo       $s0
    /* 59C7C 8006947C 02000106 */  bgez       $s0, .L80069488
    /* 59C80 80069480 00000000 */   nop
    /* 59C84 80069484 FF001026 */  addiu      $s0, $s0, 0xFF
  .L80069488:
    /* 59C88 80069488 8405228E */  lw         $v0, 0x584($s1)
    /* 59C8C 8006948C 00000000 */  nop
    /* 59C90 80069490 23105200 */  subu       $v0, $v0, $s2
    /* 59C94 80069494 02004104 */  bgez       $v0, .L800694A0
    /* 59C98 80069498 03821000 */   sra       $s0, $s0, 8
    /* 59C9C 8006949C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800694A0:
    /* 59CA0 800694A0 03120200 */  sra        $v0, $v0, 8
    /* 59CA4 800694A4 18000202 */  mult       $s0, $v0
    /* 59CA8 800694A8 12300000 */  mflo       $a2
    /* 59CAC 800694AC 21804602 */  addu       $s0, $s2, $a2
    /* 59CB0 800694B0 03000106 */  bgez       $s0, .L800694C0
    /* 59CB4 800694B4 21100002 */   addu      $v0, $s0, $zero
    /* 59CB8 800694B8 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 59CBC 800694BC 21100202 */  addu       $v0, $s0, $v0
  .L800694C0:
    /* 59CC0 800694C0 03840200 */  sra        $s0, $v0, 16
    /* 59CC4 800694C4 420433A2 */  sb         $s3, 0x442($s1)
  .L800694C8:
    /* 59CC8 800694C8 6804238E */  lw         $v1, 0x468($s1)
    /* 59CCC 800694CC 00000000 */  nop
    /* 59CD0 800694D0 2A107000 */  slt        $v0, $v1, $s0
    /* 59CD4 800694D4 07004010 */  beqz       $v0, .L800694F4
    /* 59CD8 800694D8 23100302 */   subu      $v0, $s0, $v1
    /* 59CDC 800694DC 02004104 */  bgez       $v0, .L800694E8
    /* 59CE0 800694E0 00000000 */   nop
    /* 59CE4 800694E4 07004224 */  addiu      $v0, $v0, 0x7
  .L800694E8:
    /* 59CE8 800694E8 C3100200 */  sra        $v0, $v0, 3
    /* 59CEC 800694EC 45A50108 */  j          .L80069514
    /* 59CF0 800694F0 21106200 */   addu      $v0, $v1, $v0
  .L800694F4:
    /* 59CF4 800694F4 2A100302 */  slt        $v0, $s0, $v1
    /* 59CF8 800694F8 07004010 */  beqz       $v0, .L80069518
    /* 59CFC 800694FC 23107000 */   subu      $v0, $v1, $s0
    /* 59D00 80069500 02004104 */  bgez       $v0, .L8006950C
    /* 59D04 80069504 00000000 */   nop
    /* 59D08 80069508 07004224 */  addiu      $v0, $v0, 0x7
  .L8006950C:
    /* 59D0C 8006950C C3100200 */  sra        $v0, $v0, 3
    /* 59D10 80069510 23106200 */  subu       $v0, $v1, $v0
  .L80069514:
    /* 59D14 80069514 680422AE */  sw         $v0, 0x468($s1)
  .L80069518:
    /* 59D18 80069518 2000BF8F */  lw         $ra, 0x20($sp)
    /* 59D1C 8006951C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 59D20 80069520 1800B28F */  lw         $s2, 0x18($sp)
    /* 59D24 80069524 1400B18F */  lw         $s1, 0x14($sp)
    /* 59D28 80069528 1000B08F */  lw         $s0, 0x10($sp)
    /* 59D2C 8006952C 0800E003 */  jr         $ra
    /* 59D30 80069530 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AIPhysic_HandleShifting__FP8Car_tObj
