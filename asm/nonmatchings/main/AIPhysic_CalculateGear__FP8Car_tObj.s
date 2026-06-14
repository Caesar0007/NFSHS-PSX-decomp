.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CalculateGear__FP8Car_tObj, 0x104

glabel AIPhysic_CalculateGear__FP8Car_tObj
    /* 59D34 80069534 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 59D38 80069538 1800B2AF */  sw         $s2, 0x18($sp)
    /* 59D3C 8006953C 21908000 */  addu       $s2, $a0, $zero
    /* 59D40 80069540 0100023C */  lui        $v0, (0x1FFFF >> 16)
    /* 59D44 80069544 FFFF4234 */  ori        $v0, $v0, (0x1FFFF & 0xFFFF)
    /* 59D48 80069548 2400BFAF */  sw         $ra, 0x24($sp)
    /* 59D4C 8006954C 2000B4AF */  sw         $s4, 0x20($sp)
    /* 59D50 80069550 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 59D54 80069554 1400B1AF */  sw         $s1, 0x14($sp)
    /* 59D58 80069558 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59D5C 8006955C 6405438E */  lw         $v1, 0x564($s2)
    /* 59D60 80069560 42045192 */  lbu        $s1, 0x442($s2)
    /* 59D64 80069564 02006104 */  bgez       $v1, .L80069570
    /* 59D68 80069568 21A06000 */   addu      $s4, $v1, $zero
    /* 59D6C 8006956C 23A01400 */  negu       $s4, $s4
  .L80069570:
    /* 59D70 80069570 2A105400 */  slt        $v0, $v0, $s4
    /* 59D74 80069574 03004014 */  bnez       $v0, .L80069584
    /* 59D78 80069578 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 59D7C 8006957C 85A50108 */  j          .L80069614
    /* 59D80 80069580 01001124 */   addiu     $s1, $zero, 0x1
  .L80069584:
    /* 59D84 80069584 F006438E */  lw         $v1, 0x6F0($s2)
    /* 59D88 80069588 00000000 */  nop
    /* 59D8C 8006958C 04006214 */  bne        $v1, $v0, .L800695A0
    /* 59D90 80069590 21980000 */   addu      $s3, $zero, $zero
    /* 59D94 80069594 85A50108 */  j          .L80069614
    /* 59D98 80069598 21880000 */   addu      $s1, $zero, $zero
  .L8006959C:
    /* 59D9C 8006959C 21980000 */  addu       $s3, $zero, $zero
  .L800695A0:
    /* 59DA0 800695A0 21204002 */  addu       $a0, $s2, $zero
    /* 59DA4 800695A4 98A5010C */  jal        AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
    /* 59DA8 800695A8 21282002 */   addu      $a1, $s1, $zero
    /* 59DAC 800695AC 2A805400 */  slt        $s0, $v0, $s4
    /* 59DB0 800695B0 06000016 */  bnez       $s0, .L800695CC
    /* 59DB4 800695B4 21204002 */   addu      $a0, $s2, $zero
    /* 59DB8 800695B8 A2A5010C */  jal        AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
    /* 59DBC 800695BC 21282002 */   addu      $a1, $s1, $zero
    /* 59DC0 800695C0 2A108202 */  slt        $v0, $s4, $v0
    /* 59DC4 800695C4 02004010 */  beqz       $v0, .L800695D0
    /* 59DC8 800695C8 00000000 */   nop
  .L800695CC:
    /* 59DCC 800695CC 01001324 */  addiu      $s3, $zero, 0x1
  .L800695D0:
    /* 59DD0 800695D0 11006012 */  beqz       $s3, .L80069618
    /* 59DD4 800695D4 21102002 */   addu      $v0, $s1, $zero
    /* 59DD8 800695D8 0A000012 */  beqz       $s0, .L80069604
    /* 59DDC 800695DC 21204002 */   addu      $a0, $s2, $zero
    /* 59DE0 800695E0 01003026 */  addiu      $s0, $s1, 0x1
    /* 59DE4 800695E4 98A5010C */  jal        AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
    /* 59DE8 800695E8 21280002 */   addu      $a1, $s0, $zero
    /* 59DEC 800695EC 0A004010 */  beqz       $v0, .L80069618
    /* 59DF0 800695F0 21102002 */   addu      $v0, $s1, $zero
    /* 59DF4 800695F4 7C05428E */  lw         $v0, 0x57C($s2)
    /* 59DF8 800695F8 21880002 */  addu       $s1, $s0, $zero
    /* 59DFC 800695FC 67A50108 */  j          .L8006959C
    /* 59E00 80069600 800542AE */   sw        $v0, 0x580($s2)
  .L80069604:
    /* 59E04 80069604 7C05428E */  lw         $v0, 0x57C($s2)
    /* 59E08 80069608 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* 59E0C 8006960C 67A50108 */  j          .L8006959C
    /* 59E10 80069610 800542AE */   sw        $v0, 0x580($s2)
  .L80069614:
    /* 59E14 80069614 21102002 */  addu       $v0, $s1, $zero
  .L80069618:
    /* 59E18 80069618 2400BF8F */  lw         $ra, 0x24($sp)
    /* 59E1C 8006961C 2000B48F */  lw         $s4, 0x20($sp)
    /* 59E20 80069620 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 59E24 80069624 1800B28F */  lw         $s2, 0x18($sp)
    /* 59E28 80069628 1400B18F */  lw         $s1, 0x14($sp)
    /* 59E2C 8006962C 1000B08F */  lw         $s0, 0x10($sp)
    /* 59E30 80069630 0800E003 */  jr         $ra
    /* 59E34 80069634 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AIPhysic_CalculateGear__FP8Car_tObj
