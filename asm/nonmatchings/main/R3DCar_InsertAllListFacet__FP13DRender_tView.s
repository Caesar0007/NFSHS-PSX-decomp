.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_InsertAllListFacet__FP13DRender_tView, 0x4B4

glabel R3DCar_InsertAllListFacet__FP13DRender_tView
    /* A33F8 800B2BF8 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A33FC 800B2BFC 3800BEAF */  sw         $fp, 0x38($sp)
    /* A3400 800B2C00 21F0A003 */  addu       $fp, $sp, $zero
    /* A3404 800B2C04 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* A3408 800B2C08 3400B7AF */  sw         $s7, 0x34($sp)
    /* A340C 800B2C0C 3000B6AF */  sw         $s6, 0x30($sp)
    /* A3410 800B2C10 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* A3414 800B2C14 2800B4AF */  sw         $s4, 0x28($sp)
    /* A3418 800B2C18 2400B3AF */  sw         $s3, 0x24($sp)
    /* A341C 800B2C1C 2000B2AF */  sw         $s2, 0x20($sp)
    /* A3420 800B2C20 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* A3424 800B2C24 1800B0AF */  sw         $s0, 0x18($sp)
    /* A3428 800B2C28 4000C4AF */  sw         $a0, 0x40($fp)
    /* A342C 800B2C2C 801F043C */  lui        $a0, (0x1F8003FC >> 16)
    /* A3430 800B2C30 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* A3434 800B2C34 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* A3438 800B2C38 FC038434 */  ori        $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A343C 800B2C3C 40110200 */  sll        $v0, $v0, 5
    /* A3440 800B2C40 C2180200 */  srl        $v1, $v0, 3
    /* A3444 800B2C44 07006324 */  addiu      $v1, $v1, 0x7
    /* A3448 800B2C48 C2180300 */  srl        $v1, $v1, 3
    /* A344C 800B2C4C C0180300 */  sll        $v1, $v1, 3
    /* A3450 800B2C50 23E8A303 */  subu       $sp, $sp, $v1
    /* A3454 800B2C54 1000B727 */  addiu      $s7, $sp, 0x10
    /* A3458 800B2C58 C2100200 */  srl        $v0, $v0, 3
    /* A345C 800B2C5C 07004224 */  addiu      $v0, $v0, 0x7
    /* A3460 800B2C60 C2100200 */  srl        $v0, $v0, 3
    /* A3464 800B2C64 C0100200 */  sll        $v0, $v0, 3
    /* A3468 800B2C68 23E8A203 */  subu       $sp, $sp, $v0
    /* A346C 800B2C6C 2B91030C */  jal        SetSp
    /* A3470 800B2C70 1000B627 */   addiu     $s6, $sp, 0x10
    /* A3474 800B2C74 4000D98F */  lw         $t9, 0x40($fp)
    /* A3478 800B2C78 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A347C 800B2C7C 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A3480 800B2C80 0400228F */  lw         $v0, 0x4($t9)
    /* A3484 800B2C84 01000424 */  addiu      $a0, $zero, 0x1
    /* A3488 800B2C88 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A348C 800B2C8C 1CD824AC */  sw         $a0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A3490 800B2C90 10004014 */  bnez       $v0, .L800B2CD4
    /* A3494 800B2C94 21900000 */   addu      $s2, $zero, $zero
    /* A3498 800B2C98 1480033C */  lui        $v1, %hi(generic128HzClock)
    /* A349C 800B2C9C 28C8638C */  lw         $v1, %lo(generic128HzClock)($v1)
    /* A34A0 800B2CA0 600E828F */  lw         $v0, %gp_rel(R3DCar_ClockLast)($gp)
    /* A34A4 800B2CA4 00000000 */  nop
    /* A34A8 800B2CA8 2A104300 */  slt        $v0, $v0, $v1
    /* A34AC 800B2CAC 08004010 */  beqz       $v0, .L800B2CD0
    /* A34B0 800B2CB0 00000000 */   nop
    /* A34B4 800B2CB4 1480023C */  lui        $v0, %hi(generic128HzClock)
    /* A34B8 800B2CB8 28C8428C */  lw         $v0, %lo(generic128HzClock)($v0)
    /* A34BC 800B2CBC 5C0E84AF */  sw         $a0, %gp_rel(R3DCar_Clock)($gp)
    /* A34C0 800B2CC0 06004224 */  addiu      $v0, $v0, 0x6
    /* A34C4 800B2CC4 600E82AF */  sw         $v0, %gp_rel(R3DCar_ClockLast)($gp)
    /* A34C8 800B2CC8 36CB0208 */  j          .L800B2CD8
    /* A34CC 800B2CCC 2188C002 */   addu      $s1, $s6, $zero
  .L800B2CD0:
    /* A34D0 800B2CD0 5C0E80AF */  sw         $zero, %gp_rel(R3DCar_Clock)($gp)
  .L800B2CD4:
    /* A34D4 800B2CD4 2188C002 */  addu       $s1, $s6, $zero
  .L800B2CD8:
    /* A34D8 800B2CD8 21A8E002 */  addu       $s5, $s7, $zero
    /* A34DC 800B2CDC 1180023C */  lui        $v0, %hi(R3DCar_PositionZ)
    /* A34E0 800B2CE0 886D5424 */  addiu      $s4, $v0, %lo(R3DCar_PositionZ)
    /* A34E4 800B2CE4 1180023C */  lui        $v0, %hi(Cars_gList)
    /* A34E8 800B2CE8 DCF95324 */  addiu      $s3, $v0, %lo(Cars_gList)
  .L800B2CEC:
    /* A34EC 800B2CEC 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* A34F0 800B2CF0 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* A34F4 800B2CF4 00000000 */  nop
    /* A34F8 800B2CF8 2A104202 */  slt        $v0, $s2, $v0
    /* A34FC 800B2CFC 17004010 */  beqz       $v0, .L800B2D5C
    /* A3500 800B2D00 01000E24 */   addiu     $t6, $zero, 0x1
    /* A3504 800B2D04 0000708E */  lw         $s0, 0x0($s3)
    /* A3508 800B2D08 4000C58F */  lw         $a1, 0x40($fp)
    /* A350C 800B2D0C D3BD020C */  jal        R3DCar_Visibilty__FP8Car_tObjP13DRender_tView
    /* A3510 800B2D10 21200002 */   addu      $a0, $s0, $zero
    /* A3514 800B2D14 000082AE */  sw         $v0, 0x0($s4)
    /* A3518 800B2D18 780800AE */  sw         $zero, 0x878($s0)
    /* A351C 800B2D1C 7C0800A6 */  sh         $zero, 0x87C($s0)
    /* A3520 800B2D20 0000A0AE */  sw         $zero, 0x0($s5)
    /* A3524 800B2D24 BC080386 */  lh         $v1, 0x8BC($s0)
    /* A3528 800B2D28 1C000224 */  addiu      $v0, $zero, 0x1C
    /* A352C 800B2D2C 04006210 */  beq        $v1, $v0, .L800B2D40
    /* A3530 800B2D30 A0010224 */   addiu     $v0, $zero, 0x1A0
    /* A3534 800B2D34 3C01028E */  lw         $v0, 0x13C($s0)
    /* A3538 800B2D38 00000000 */  nop
    /* A353C 800B2D3C 43120200 */  sra        $v0, $v0, 9
  .L800B2D40:
    /* A3540 800B2D40 000022AE */  sw         $v0, 0x0($s1)
    /* A3544 800B2D44 04003126 */  addiu      $s1, $s1, 0x4
    /* A3548 800B2D48 0400B526 */  addiu      $s5, $s5, 0x4
    /* A354C 800B2D4C 04009426 */  addiu      $s4, $s4, 0x4
    /* A3550 800B2D50 04007326 */  addiu      $s3, $s3, 0x4
    /* A3554 800B2D54 3BCB0208 */  j          .L800B2CEC
    /* A3558 800B2D58 01005226 */   addiu     $s2, $s2, 0x1
  .L800B2D5C:
    /* A355C 800B2D5C 21900000 */  addu       $s2, $zero, $zero
    /* A3560 800B2D60 2198C002 */  addu       $s3, $s6, $zero
    /* A3564 800B2D64 2188E002 */  addu       $s1, $s7, $zero
    /* A3568 800B2D68 1180023C */  lui        $v0, %hi(R3DCar_PositionZ)
    /* A356C 800B2D6C 886D5824 */  addiu      $t8, $v0, %lo(R3DCar_PositionZ)
    /* A3570 800B2D70 21680003 */  addu       $t5, $t8, $zero
    /* A3574 800B2D74 1480143C */  lui        $s4, %hi(Cars_gNumCars)
    /* A3578 800B2D78 F4C7948E */  lw         $s4, %lo(Cars_gNumCars)($s4)
    /* A357C 800B2D7C 1180023C */  lui        $v0, %hi(Cars_gList)
    /* A3580 800B2D80 DCF95524 */  addiu      $s5, $v0, %lo(Cars_gList)
    /* A3584 800B2D84 2178A002 */  addu       $t7, $s5, $zero
    /* A3588 800B2D88 FFFF9926 */  addiu      $t9, $s4, -0x1
    /* A358C 800B2D8C 1000D9AF */  sw         $t9, 0x10($fp)
  .L800B2D90:
    /* A3590 800B2D90 1000D98F */  lw         $t9, 0x10($fp)
    /* A3594 800B2D94 00000000 */  nop
    /* A3598 800B2D98 2A105902 */  slt        $v0, $s2, $t9
    /* A359C 800B2D9C 3F004010 */  beqz       $v0, .L800B2E9C
    /* A35A0 800B2DA0 0080023C */   lui       $v0, (0x80000000 >> 16)
    /* A35A4 800B2DA4 0000A38D */  lw         $v1, 0x0($t5)
    /* A35A8 800B2DA8 00000000 */  nop
    /* A35AC 800B2DAC 34006210 */  beq        $v1, $v0, .L800B2E80
    /* A35B0 800B2DB0 2150C001 */   addu      $t2, $t6, $zero
    /* A35B4 800B2DB4 0000E78D */  lw         $a3, 0x0($t7)
    /* A35B8 800B2DB8 2180A001 */  addu       $s0, $t5, $zero
    /* A35BC 800B2DBC 21602002 */  addu       $t4, $s1, $zero
    /* A35C0 800B2DC0 21586002 */  addu       $t3, $s3, $zero
    /* A35C4 800B2DC4 80100E00 */  sll        $v0, $t6, 2
    /* A35C8 800B2DC8 21485800 */  addu       $t1, $v0, $t8
    /* A35CC 800B2DCC 21405500 */  addu       $t0, $v0, $s5
  .L800B2DD0:
    /* A35D0 800B2DD0 2A105401 */  slt        $v0, $t2, $s4
    /* A35D4 800B2DD4 2A004010 */  beqz       $v0, .L800B2E80
    /* A35D8 800B2DD8 00000000 */   nop
    /* A35DC 800B2DDC 0000038E */  lw         $v1, 0x0($s0)
    /* A35E0 800B2DE0 0000228D */  lw         $v0, 0x0($t1)
    /* A35E4 800B2DE4 0000058D */  lw         $a1, 0x0($t0)
    /* A35E8 800B2DE8 3C01E48C */  lw         $a0, 0x13C($a3)
    /* A35EC 800B2DEC 23306200 */  subu       $a2, $v1, $v0
    /* A35F0 800B2DF0 3C01A28C */  lw         $v0, 0x13C($a1)
    /* A35F4 800B2DF4 7808E38C */  lw         $v1, 0x878($a3)
    /* A35F8 800B2DF8 00000000 */  nop
    /* A35FC 800B2DFC 1C006014 */  bnez       $v1, .L800B2E70
    /* A3600 800B2E00 21208200 */   addu      $a0, $a0, $v0
    /* A3604 800B2E04 7808A28C */  lw         $v0, 0x878($a1)
    /* A3608 800B2E08 00000000 */  nop
    /* A360C 800B2E0C 18004014 */  bnez       $v0, .L800B2E70
    /* A3610 800B2E10 00000000 */   nop
    /* A3614 800B2E14 0200C104 */  bgez       $a2, .L800B2E20
    /* A3618 800B2E18 2110C000 */   addu      $v0, $a2, $zero
    /* A361C 800B2E1C 23100200 */  negu       $v0, $v0
  .L800B2E20:
    /* A3620 800B2E20 2A104400 */  slt        $v0, $v0, $a0
    /* A3624 800B2E24 12004010 */  beqz       $v0, .L800B2E70
    /* A3628 800B2E28 00000000 */   nop
    /* A362C 800B2E2C 7808A7AC */  sw         $a3, 0x878($a1)
    /* A3630 800B2E30 7C08E294 */  lhu        $v0, 0x87C($a3)
    /* A3634 800B2E34 00000000 */  nop
    /* A3638 800B2E38 01004224 */  addiu      $v0, $v0, 0x1
    /* A363C 800B2E3C 0700C104 */  bgez       $a2, .L800B2E5C
    /* A3640 800B2E40 7C08E2A4 */   sh        $v0, 0x87C($a3)
    /* A3644 800B2E44 3C01A28C */  lw         $v0, 0x13C($a1)
    /* A3648 800B2E48 0000838D */  lw         $v1, 0x0($t4)
    /* A364C 800B2E4C 43120200 */  sra        $v0, $v0, 9
    /* A3650 800B2E50 23186200 */  subu       $v1, $v1, $v0
    /* A3654 800B2E54 9CCB0208 */  j          .L800B2E70
    /* A3658 800B2E58 000083AD */   sw        $v1, 0x0($t4)
  .L800B2E5C:
    /* A365C 800B2E5C 3C01A28C */  lw         $v0, 0x13C($a1)
    /* A3660 800B2E60 0000638D */  lw         $v1, 0x0($t3)
    /* A3664 800B2E64 43120200 */  sra        $v0, $v0, 9
    /* A3668 800B2E68 21186200 */  addu       $v1, $v1, $v0
    /* A366C 800B2E6C 000063AD */  sw         $v1, 0x0($t3)
  .L800B2E70:
    /* A3670 800B2E70 04002925 */  addiu      $t1, $t1, 0x4
    /* A3674 800B2E74 04000825 */  addiu      $t0, $t0, 0x4
    /* A3678 800B2E78 74CB0208 */  j          .L800B2DD0
    /* A367C 800B2E7C 01004A25 */   addiu     $t2, $t2, 0x1
  .L800B2E80:
    /* A3680 800B2E80 0100CE25 */  addiu      $t6, $t6, 0x1
    /* A3684 800B2E84 04007326 */  addiu      $s3, $s3, 0x4
    /* A3688 800B2E88 04003126 */  addiu      $s1, $s1, 0x4
    /* A368C 800B2E8C 0400AD25 */  addiu      $t5, $t5, 0x4
    /* A3690 800B2E90 0400EF25 */  addiu      $t7, $t7, 0x4
    /* A3694 800B2E94 64CB0208 */  j          .L800B2D90
    /* A3698 800B2E98 01005226 */   addiu     $s2, $s2, 0x1
  .L800B2E9C:
    /* A369C 800B2E9C 21900000 */  addu       $s2, $zero, $zero
    /* A36A0 800B2EA0 00800C3C */  lui        $t4, (0x80000000 >> 16)
    /* A36A4 800B2EA4 2140C002 */  addu       $t0, $s6, $zero
    /* A36A8 800B2EA8 2138E002 */  addu       $a3, $s7, $zero
    /* A36AC 800B2EAC 1180023C */  lui        $v0, %hi(Cars_gList)
    /* A36B0 800B2EB0 DCF94A24 */  addiu      $t2, $v0, %lo(Cars_gList)
    /* A36B4 800B2EB4 1180043C */  lui        $a0, %hi(R3DCar_subOtStart)
    /* A36B8 800B2EB8 AC6D8424 */  addiu      $a0, $a0, %lo(R3DCar_subOtStart)
    /* A36BC 800B2EBC 1180023C */  lui        $v0, %hi(D_80116F80)
    /* A36C0 800B2EC0 14800B3C */  lui        $t3, %hi(Cars_gNumCars)
    /* A36C4 800B2EC4 F4C76B8D */  lw         $t3, %lo(Cars_gNumCars)($t3)
    /* A36C8 800B2EC8 806F428C */  lw         $v0, %lo(D_80116F80)($v0)
    /* A36CC 800B2ECC 1480033C */  lui        $v1, %hi(gFlip)
    /* A36D0 800B2ED0 B4D7638C */  lw         $v1, %lo(gFlip)($v1)
    /* A36D4 800B2ED4 80100200 */  sll        $v0, $v0, 2
    /* A36D8 800B2ED8 C0180300 */  sll        $v1, $v1, 3
    /* A36DC 800B2EDC 21104300 */  addu       $v0, $v0, $v1
    /* A36E0 800B2EE0 21104400 */  addu       $v0, $v0, $a0
    /* A36E4 800B2EE4 1180033C */  lui        $v1, %hi(R3DCar_PositionZ)
    /* A36E8 800B2EE8 0000428C */  lw         $v0, 0x0($v0)
    /* A36EC 800B2EEC 886D6924 */  addiu      $t1, $v1, %lo(R3DCar_PositionZ)
    /* A36F0 800B2EF0 6C0E82AF */  sw         $v0, %gp_rel(R3DCar_subOt)($gp)
  .L800B2EF4:
    /* A36F4 800B2EF4 2A104B02 */  slt        $v0, $s2, $t3
    /* A36F8 800B2EF8 28004010 */  beqz       $v0, .L800B2F9C
    /* A36FC 800B2EFC 1280023C */   lui       $v0, %hi(DrawC_gScreenMat)
    /* A3700 800B2F00 0000228D */  lw         $v0, 0x0($t1)
    /* A3704 800B2F04 00000000 */  nop
    /* A3708 800B2F08 1E004C10 */  beq        $v0, $t4, .L800B2F84
    /* A370C 800B2F0C 00000000 */   nop
    /* A3710 800B2F10 0000E28C */  lw         $v0, 0x0($a3)
    /* A3714 800B2F14 0000458D */  lw         $a1, 0x0($t2)
    /* A3718 800B2F18 D0FF4224 */  addiu      $v0, $v0, -0x30
    /* A371C 800B2F1C 0000E2AC */  sw         $v0, 0x0($a3)
    /* A3720 800B2F20 0000028D */  lw         $v0, 0x0($t0)
    /* A3724 800B2F24 00000000 */  nop
    /* A3728 800B2F28 30004624 */  addiu      $a2, $v0, 0x30
    /* A372C 800B2F2C 000006AD */  sw         $a2, 0x0($t0)
    /* A3730 800B2F30 7808A28C */  lw         $v0, 0x878($a1)
    /* A3734 800B2F34 00000000 */  nop
    /* A3738 800B2F38 0F004014 */  bnez       $v0, .L800B2F78
    /* A373C 800B2F3C 00000000 */   nop
    /* A3740 800B2F40 0000E48C */  lw         $a0, 0x0($a3)
    /* A3744 800B2F44 6C0E838F */  lw         $v1, %gp_rel(R3DCar_subOt)($gp)
    /* A3748 800B2F48 2320C400 */  subu       $a0, $a2, $a0
    /* A374C 800B2F4C 80100400 */  sll        $v0, $a0, 2
    /* A3750 800B2F50 6C08A3AC */  sw         $v1, 0x86C($a1)
    /* A3754 800B2F54 21186200 */  addu       $v1, $v1, $v0
    /* A3758 800B2F58 3C01A28C */  lw         $v0, 0x13C($a1)
    /* A375C 800B2F5C 6C0E83AF */  sw         $v1, %gp_rel(R3DCar_subOt)($gp)
    /* A3760 800B2F60 7008A4AC */  sw         $a0, 0x870($a1)
    /* A3764 800B2F64 0000038D */  lw         $v1, 0x0($t0)
    /* A3768 800B2F68 83120200 */  sra        $v0, $v0, 10
    /* A376C 800B2F6C 23186200 */  subu       $v1, $v1, $v0
    /* A3770 800B2F70 E1CB0208 */  j          .L800B2F84
    /* A3774 800B2F74 7408A3AC */   sw        $v1, 0x874($a1)
  .L800B2F78:
    /* A3778 800B2F78 6C08A0AC */  sw         $zero, 0x86C($a1)
    /* A377C 800B2F7C 7008A0AC */  sw         $zero, 0x870($a1)
    /* A3780 800B2F80 7408A0AC */  sw         $zero, 0x874($a1)
  .L800B2F84:
    /* A3784 800B2F84 04000825 */  addiu      $t0, $t0, 0x4
    /* A3788 800B2F88 0400E724 */  addiu      $a3, $a3, 0x4
    /* A378C 800B2F8C 04004A25 */  addiu      $t2, $t2, 0x4
    /* A3790 800B2F90 04002925 */  addiu      $t1, $t1, 0x4
    /* A3794 800B2F94 BDCB0208 */  j          .L800B2EF4
    /* A3798 800B2F98 01005226 */   addiu     $s2, $s2, 0x1
  .L800B2F9C:
    /* A379C 800B2F9C 21900000 */  addu       $s2, $zero, $zero
    /* A37A0 800B2FA0 00100524 */  addiu      $a1, $zero, 0x1000
    /* A37A4 800B2FA4 C8F445A4 */  sh         $a1, %lo(DrawC_gScreenMat)($v0)
    /* A37A8 800B2FA8 C8F44224 */  addiu      $v0, $v0, %lo(DrawC_gScreenMat)
    /* A37AC 800B2FAC 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* A37B0 800B2FB0 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* A37B4 800B2FB4 00F00324 */  addiu      $v1, $zero, -0x1000
    /* A37B8 800B2FB8 060040A4 */  sh         $zero, 0x6($v0)
    /* A37BC 800B2FBC 0C0040A4 */  sh         $zero, 0xC($v0)
    /* A37C0 800B2FC0 020040A4 */  sh         $zero, 0x2($v0)
    /* A37C4 800B2FC4 080043A4 */  sh         $v1, 0x8($v0)
    /* A37C8 800B2FC8 0E0040A4 */  sh         $zero, 0xE($v0)
    /* A37CC 800B2FCC 040040A4 */  sh         $zero, 0x4($v0)
    /* A37D0 800B2FD0 0A0040A4 */  sh         $zero, 0xA($v0)
    /* A37D4 800B2FD4 100045A4 */  sh         $a1, 0x10($v0)
    /* A37D8 800B2FD8 140040AC */  sw         $zero, 0x14($v0)
    /* A37DC 800B2FDC 180040AC */  sw         $zero, 0x18($v0)
    /* A37E0 800B2FE0 2B91030C */  jal        SetSp
    /* A37E4 800B2FE4 1C0040AC */   sw        $zero, 0x1C($v0)
    /* A37E8 800B2FE8 1180033C */  lui        $v1, %hi(Cars_gList)
    /* A37EC 800B2FEC DCF97124 */  addiu      $s1, $v1, %lo(Cars_gList)
    /* A37F0 800B2FF0 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A37F4 800B2FF4 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A37F8 800B2FF8 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A37FC 800B2FFC 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
  .L800B3000:
    /* A3800 800B3000 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* A3804 800B3004 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* A3808 800B3008 00000000 */  nop
    /* A380C 800B300C 2A104202 */  slt        $v0, $s2, $v0
    /* A3810 800B3010 19004010 */  beqz       $v0, .L800B3078
    /* A3814 800B3014 801F043C */   lui       $a0, (0x1F8003FC >> 16)
    /* A3818 800B3018 0000308E */  lw         $s0, 0x0($s1)
    /* A381C 800B301C 2B91030C */  jal        SetSp
    /* A3820 800B3020 FC038434 */   ori       $a0, $a0, (0x1F8003FC & 0xFFFF)
    /* A3824 800B3024 4000C58F */  lw         $a1, 0x40($fp)
    /* A3828 800B3028 04003126 */  addiu      $s1, $s1, 0x4
    /* A382C 800B302C 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A3830 800B3030 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A3834 800B3034 01000224 */  addiu      $v0, $zero, 0x1
    /* A3838 800B3038 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A383C 800B303C 1CD822AC */  sw         $v0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A3840 800B3040 F6CA020C */  jal        R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView
    /* A3844 800B3044 21200002 */   addu      $a0, $s0, $zero
    /* A3848 800B3048 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* A384C 800B304C 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* A3850 800B3050 2B91030C */  jal        SetSp
    /* A3854 800B3054 01005226 */   addiu     $s2, $s2, 0x1
    /* A3858 800B3058 1480013C */  lui        $at, %hi(gWSavePtr)
    /* A385C 800B305C 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* A3860 800B3060 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* A3864 800B3064 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* A3868 800B3068 5DC8020C */  jal        R3DCar_InsertCarFacetII__FP8Car_tObj
    /* A386C 800B306C 21200002 */   addu      $a0, $s0, $zero
    /* A3870 800B3070 00CC0208 */  j          .L800B3000
    /* A3874 800B3074 00000000 */   nop
  .L800B3078:
    /* A3878 800B3078 21E8C003 */  addu       $sp, $fp, $zero
    /* A387C 800B307C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* A3880 800B3080 3800BE8F */  lw         $fp, 0x38($sp)
    /* A3884 800B3084 3400B78F */  lw         $s7, 0x34($sp)
    /* A3888 800B3088 3000B68F */  lw         $s6, 0x30($sp)
    /* A388C 800B308C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* A3890 800B3090 2800B48F */  lw         $s4, 0x28($sp)
    /* A3894 800B3094 2400B38F */  lw         $s3, 0x24($sp)
    /* A3898 800B3098 2000B28F */  lw         $s2, 0x20($sp)
    /* A389C 800B309C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* A38A0 800B30A0 1800B08F */  lw         $s0, 0x18($sp)
    /* A38A4 800B30A4 0800E003 */  jr         $ra
    /* A38A8 800B30A8 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel R3DCar_InsertAllListFacet__FP13DRender_tView
