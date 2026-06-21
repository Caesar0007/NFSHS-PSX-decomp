.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_BuyCar__FR12tMenuCommand, 0x154

glabel MenuExtended_BuyCar__FR12tMenuCommand
    /* 1DCF8 8002D4F8 60FEBD27 */  addiu      $sp, $sp, -0x1A0
    /* 1DCFC 8002D4FC 1180023C */  lui        $v0, %hi(carManager)
    /* 1DD00 8002D500 9001B2AF */  sw         $s2, 0x190($sp)
    /* 1DD04 8002D504 74425224 */  addiu      $s2, $v0, %lo(carManager)
    /* 1DD08 8002D508 21204002 */  addu       $a0, $s2, $zero
    /* 1DD0C 8002D50C 0580033C */  lui        $v1, %hi(FEApp)
    /* 1DD10 8002D510 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1DD14 8002D514 9401B3AF */  sw         $s3, 0x194($sp)
    /* 1DD18 8002D518 00465324 */  addiu      $s3, $v0, %lo(frontEnd)
    /* 1DD1C 8002D51C C014628C */  lw         $v0, %lo(FEApp)($v1)
    /* 1DD20 8002D520 1000A627 */  addiu      $a2, $sp, 0x10
    /* 1DD24 8002D524 9801BFAF */  sw         $ra, 0x198($sp)
    /* 1DD28 8002D528 8C01B1AF */  sw         $s1, 0x18C($sp)
    /* 1DD2C 8002D52C 8801B0AF */  sw         $s0, 0x188($sp)
    /* 1DD30 8002D530 28016592 */  lbu        $a1, 0x128($s3)
    /* 1DD34 8002D534 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 1DD38 8002D538 2C005024 */   addiu     $s0, $v0, 0x2C
    /* 1DD3C 8002D53C 21204002 */  addu       $a0, $s2, $zero
    /* 1DD40 8002D540 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1DD44 8002D544 21280000 */   addu      $a1, $zero, $zero
    /* 1DD48 8002D548 00140200 */  sll        $v0, $v0, 16
    /* 1DD4C 8002D54C 03140200 */  sra        $v0, $v0, 16
    /* 1DD50 8002D550 20004228 */  slti       $v0, $v0, 0x20
    /* 1DD54 8002D554 30004010 */  beqz       $v0, .L8002D618
    /* 1DD58 8002D558 21880002 */   addu      $s1, $s0, $zero
    /* 1DD5C 8002D55C 1180023C */  lui        $v0, %hi(tournamentManager)
    /* 1DD60 8002D560 D84A5124 */  addiu      $s1, $v0, %lo(tournamentManager)
    /* 1DD64 8002D564 1400228E */  lw         $v0, 0x14($s1)
    /* 1DD68 8002D568 3000A38F */  lw         $v1, 0x30($sp)
    /* 1DD6C 8002D56C 00000000 */  nop
    /* 1DD70 8002D570 2A104300 */  slt        $v0, $v0, $v1
    /* 1DD74 8002D574 21004014 */  bnez       $v0, .L8002D5FC
    /* 1DD78 8002D578 00000000 */   nop
    /* 1DD7C 8002D57C E000B027 */  addiu      $s0, $sp, 0xE0
    /* 1DD80 8002D580 A366000C */  jal        __12tDialogYesNo
    /* 1DD84 8002D584 21200002 */   addu      $a0, $s0, $zero
    /* 1DD88 8002D588 94E4020C */  jal        TextSys_Word__Fi
    /* 1DD8C 8002D58C A4000424 */   addiu     $a0, $zero, 0xA4
    /* 1DD90 8002D590 21200002 */  addu       $a0, $s0, $zero
    /* 1DD94 8002D594 7001A2AF */  sw         $v0, 0x170($sp)
    /* 1DD98 8002D598 21030224 */  addiu      $v0, $zero, 0x321
    /* 1DD9C 8002D59C A00002AE */  sw         $v0, 0xA0($s0)
    /* 1DDA0 8002D5A0 22030224 */  addiu      $v0, $zero, 0x322
    /* 1DDA4 8002D5A4 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1DDA8 8002D5A8 FA65000C */  jal        Run__18tDialogInteractive
    /* 1DDAC 8002D5AC 6801A0A7 */   sh        $zero, 0x168($sp)
    /* 1DDB0 8002D5B0 00140200 */  sll        $v0, $v0, 16
    /* 1DDB4 8002D5B4 0C004010 */  beqz       $v0, .L8002D5E8
    /* 1DDB8 8002D5B8 21204002 */   addu      $a0, $s2, $zero
    /* 1DDBC 8002D5BC 1000A583 */  lb         $a1, 0x10($sp)
    /* 1DDC0 8002D5C0 00000000 */  nop
    /* 1DDC4 8002D5C4 2110B300 */  addu       $v0, $a1, $s3
    /* 1DDC8 8002D5C8 60004690 */  lbu        $a2, 0x60($v0)
    /* 1DDCC 8002D5CC 1459000C */  jal        PurchaseCar__11tCarManagersss
    /* 1DDD0 8002D5D0 21380000 */   addu      $a3, $zero, $zero
    /* 1DDD4 8002D5D4 1400238E */  lw         $v1, 0x14($s1)
    /* 1DDD8 8002D5D8 1A000424 */  addiu      $a0, $zero, 0x1A
    /* 1DDDC 8002D5DC 23186200 */  subu       $v1, $v1, $v0
    /* 1DDE0 8002D5E0 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 1DDE4 8002D5E4 140023AE */   sw        $v1, 0x14($s1)
  .L8002D5E8:
    /* 1DDE8 8002D5E8 21200002 */  addu       $a0, $s0, $zero
    /* 1DDEC 8002D5EC 1E98000C */  jal        ___7tScreen
    /* 1DDF0 8002D5F0 02000524 */   addiu     $a1, $zero, 0x2
    /* 1DDF4 8002D5F4 8CB50008 */  j          .L8002D630
    /* 1DDF8 8002D5F8 00000000 */   nop
  .L8002D5FC:
    /* 1DDFC 8002D5FC 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 1DE00 8002D600 0A000424 */   addiu     $a0, $zero, 0xA
    /* 1DE04 8002D604 94E4020C */  jal        TextSys_Word__Fi
    /* 1DE08 8002D608 A7000424 */   addiu     $a0, $zero, 0xA7
    /* 1DE0C 8002D60C 900002AE */  sw         $v0, 0x90($s0)
    /* 1DE10 8002D610 8AB50008 */  j          .L8002D628
    /* 1DE14 8002D614 21200002 */   addu      $a0, $s0, $zero
  .L8002D618:
    /* 1DE18 8002D618 94E4020C */  jal        TextSys_Word__Fi
    /* 1DE1C 8002D61C 4B000424 */   addiu     $a0, $zero, 0x4B
    /* 1DE20 8002D620 900022AE */  sw         $v0, 0x90($s1)
    /* 1DE24 8002D624 21202002 */  addu       $a0, $s1, $zero
  .L8002D628:
    /* 1DE28 8002D628 1062000C */  jal        Display__11tDialogBase
    /* 1DE2C 8002D62C 00000000 */   nop
  .L8002D630:
    /* 1DE30 8002D630 9801BF8F */  lw         $ra, 0x198($sp)
    /* 1DE34 8002D634 9401B38F */  lw         $s3, 0x194($sp)
    /* 1DE38 8002D638 9001B28F */  lw         $s2, 0x190($sp)
    /* 1DE3C 8002D63C 8C01B18F */  lw         $s1, 0x18C($sp)
    /* 1DE40 8002D640 8801B08F */  lw         $s0, 0x188($sp)
    /* 1DE44 8002D644 0800E003 */  jr         $ra
    /* 1DE48 8002D648 A001BD27 */   addiu     $sp, $sp, 0x1A0
endlabel MenuExtended_BuyCar__FR12tMenuCommand
