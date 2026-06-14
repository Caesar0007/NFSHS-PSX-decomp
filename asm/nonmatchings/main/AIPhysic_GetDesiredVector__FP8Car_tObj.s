.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_GetDesiredVector__FP8Car_tObj, 0x5E8

glabel AIPhysic_GetDesiredVector__FP8Car_tObj
    /* 5B43C 8006AC3C A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 5B440 8006AC40 4800B2AF */  sw         $s2, 0x48($sp)
    /* 5B444 8006AC44 21908000 */  addu       $s2, $a0, $zero
    /* 5B448 8006AC48 5000B4AF */  sw         $s4, 0x50($sp)
    /* 5B44C 8006AC4C 5400BFAF */  sw         $ra, 0x54($sp)
    /* 5B450 8006AC50 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* 5B454 8006AC54 4400B1AF */  sw         $s1, 0x44($sp)
    /* 5B458 8006AC58 4000B0AF */  sw         $s0, 0x40($sp)
    /* 5B45C 8006AC5C 0807428E */  lw         $v0, 0x708($s2)
    /* 5B460 8006AC60 08005386 */  lh         $s3, 0x8($s2)
    /* 5B464 8006AC64 09004014 */  bnez       $v0, .L8006AC8C
    /* 5B468 8006AC68 21A00000 */   addu      $s4, $zero, $zero
    /* 5B46C 8006AC6C 0C07428E */  lw         $v0, 0x70C($s2)
    /* 5B470 8006AC70 00000000 */  nop
    /* 5B474 8006AC74 05004014 */  bnez       $v0, .L8006AC8C
    /* 5B478 8006AC78 00000000 */   nop
    /* 5B47C 8006AC7C 1007428E */  lw         $v0, 0x710($s2)
    /* 5B480 8006AC80 00000000 */  nop
    /* 5B484 8006AC84 05004010 */  beqz       $v0, .L8006AC9C
    /* 5B488 8006AC88 33B30534 */   ori       $a1, $zero, 0xB333
  .L8006AC8C:
    /* 5B48C 8006AC8C 89AC010C */  jal        AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
    /* 5B490 8006AC90 21204002 */   addu      $a0, $s2, $zero
    /* 5B494 8006AC94 81AC0108 */  j          .L8006B204
    /* 5B498 8006AC98 00000000 */   nop
  .L8006AC9C:
    /* 5B49C 8006AC9C 6405428E */  lw         $v0, 0x564($s2)
    /* 5B4A0 8006ACA0 00000000 */  nop
    /* 5B4A4 8006ACA4 02004104 */  bgez       $v0, .L8006ACB0
    /* 5B4A8 8006ACA8 21804000 */   addu      $s0, $v0, $zero
    /* 5B4AC 8006ACAC 23801000 */  negu       $s0, $s0
  .L8006ACB0:
    /* 5B4B0 8006ACB0 CA90030C */  jal        fixedmult
    /* 5B4B4 8006ACB4 21200002 */   addu      $a0, $s0, $zero
    /* 5B4B8 8006ACB8 AA2A043C */  lui        $a0, (0x2AAAAAAB >> 16)
    /* 5B4BC 8006ACBC ABAA8434 */  ori        $a0, $a0, (0x2AAAAAAB & 0xFFFF)
    /* 5B4C0 8006ACC0 0300033C */  lui        $v1, (0x30000 >> 16)
    /* 5B4C4 8006ACC4 21104300 */  addu       $v0, $v0, $v1
    /* 5B4C8 8006ACC8 18004400 */  mult       $v0, $a0
    /* 5B4CC 8006ACCC C3170200 */  sra        $v0, $v0, 31
    /* 5B4D0 8006ACD0 10400000 */  mfhi       $t0
    /* 5B4D4 8006ACD4 031C0800 */  sra        $v1, $t0, 16
    /* 5B4D8 8006ACD8 23886200 */  subu       $s1, $v1, $v0
    /* 5B4DC 8006ACDC 0D002006 */  bltz       $s1, .L8006AD14
    /* 5B4E0 8006ACE0 1180023C */   lui       $v0, %hi(D_8010DC78)
    /* 5B4E4 8006ACE4 78DC428C */  lw         $v0, %lo(D_8010DC78)($v0)
    /* 5B4E8 8006ACE8 00000000 */  nop
    /* 5B4EC 8006ACEC 18004400 */  mult       $v0, $a0
    /* 5B4F0 8006ACF0 C3170200 */  sra        $v0, $v0, 31
    /* 5B4F4 8006ACF4 10400000 */  mfhi       $t0
    /* 5B4F8 8006ACF8 23180201 */  subu       $v1, $t0, $v0
    /* 5B4FC 8006ACFC 2A102302 */  slt        $v0, $s1, $v1
    /* 5B500 8006AD00 04004010 */  beqz       $v0, .L8006AD14
    /* 5B504 8006AD04 00000000 */   nop
    /* 5B508 8006AD08 02000006 */  bltz       $s0, .L8006AD14
    /* 5B50C 8006AD0C 00000000 */   nop
    /* 5B510 8006AD10 21886000 */  addu       $s1, $v1, $zero
  .L8006AD14:
    /* 5B514 8006AD14 AA2A033C */  lui        $v1, (0x2AAAAAAB >> 16)
    /* 5B518 8006AD18 1180023C */  lui        $v0, %hi(D_8010DC7C)
    /* 5B51C 8006AD1C 7CDC428C */  lw         $v0, %lo(D_8010DC7C)($v0)
    /* 5B520 8006AD20 ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* 5B524 8006AD24 18004300 */  mult       $v0, $v1
    /* 5B528 8006AD28 C3170200 */  sra        $v0, $v0, 31
    /* 5B52C 8006AD2C 10400000 */  mfhi       $t0
    /* 5B530 8006AD30 23180201 */  subu       $v1, $t0, $v0
    /* 5B534 8006AD34 2A107100 */  slt        $v0, $v1, $s1
    /* 5B538 8006AD38 02004010 */  beqz       $v0, .L8006AD44
    /* 5B53C 8006AD3C 00000000 */   nop
    /* 5B540 8006AD40 21886000 */  addu       $s1, $v1, $zero
  .L8006AD44:
    /* 5B544 8006AD44 F006428E */  lw         $v0, 0x6F0($s2)
    /* 5B548 8006AD48 00000000 */  nop
    /* 5B54C 8006AD4C 18002202 */  mult       $s1, $v0
    /* 5B550 8006AD50 12180000 */  mflo       $v1
    /* 5B554 8006AD54 5405428E */  lw         $v0, 0x554($s2)
    /* 5B558 8006AD58 00000000 */  nop
    /* 5B55C 8006AD5C 18006200 */  mult       $v1, $v0
    /* 5B560 8006AD60 12280000 */  mflo       $a1
    /* 5B564 8006AD64 0900A004 */  bltz       $a1, .L8006AD8C
    /* 5B568 8006AD68 21186502 */   addu      $v1, $s3, $a1
    /* 5B56C 8006AD6C 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 5B570 8006AD70 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 5B574 8006AD74 00000000 */  nop
    /* 5B578 8006AD78 2A106400 */  slt        $v0, $v1, $a0
    /* 5B57C 8006AD7C 09004014 */  bnez       $v0, .L8006ADA4
    /* 5B580 8006AD80 00000000 */   nop
    /* 5B584 8006AD84 69AB0108 */  j          .L8006ADA4
    /* 5B588 8006AD88 23186400 */   subu      $v1, $v1, $a0
  .L8006AD8C:
    /* 5B58C 8006AD8C 05006104 */  bgez       $v1, .L8006ADA4
    /* 5B590 8006AD90 00000000 */   nop
    /* 5B594 8006AD94 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5B598 8006AD98 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5B59C 8006AD9C 00000000 */  nop
    /* 5B5A0 8006ADA0 21186200 */  addu       $v1, $v1, $v0
  .L8006ADA4:
    /* 5B5A4 8006ADA4 580743AE */  sw         $v1, 0x758($s2)
    /* 5B5A8 8006ADA8 B8CD010C */  jal        AIWorld_CalcRoadBend__FP8Car_tObji
    /* 5B5AC 8006ADAC 21204002 */   addu      $a0, $s2, $zero
    /* 5B5B0 8006ADB0 5807438E */  lw         $v1, 0x758($s2)
    /* 5B5B4 8006ADB4 1480043C */  lui        $a0, %hi(BWorldSm_slices)
    /* 5B5B8 8006ADB8 C0C7848C */  lw         $a0, %lo(BWorldSm_slices)($a0)
    /* 5B5BC 8006ADBC 40190300 */  sll        $v1, $v1, 5
    /* 5B5C0 8006ADC0 21186400 */  addu       $v1, $v1, $a0
    /* 5B5C4 8006ADC4 1E006490 */  lbu        $a0, 0x1E($v1)
    /* 5B5C8 8006ADC8 1D006690 */  lbu        $a2, 0x1D($v1)
    /* 5B5CC 8006ADCC C0230400 */  sll        $a0, $a0, 15
    /* 5B5D0 8006ADD0 02290600 */  srl        $a1, $a2, 4
    /* 5B5D4 8006ADD4 18008500 */  mult       $a0, $a1
    /* 5B5D8 8006ADD8 1F006390 */  lbu        $v1, 0x1F($v1)
    /* 5B5DC 8006ADDC 12280000 */  mflo       $a1
    /* 5B5E0 8006ADE0 C01B0300 */  sll        $v1, $v1, 15
    /* 5B5E4 8006ADE4 0F00C630 */  andi       $a2, $a2, 0xF
    /* 5B5E8 8006ADE8 18006600 */  mult       $v1, $a2
    /* 5B5EC 8006ADEC 02004104 */  bgez       $v0, .L8006ADF8
    /* 5B5F0 8006ADF0 21204000 */   addu      $a0, $v0, $zero
    /* 5B5F4 8006ADF4 23200400 */  negu       $a0, $a0
  .L8006ADF8:
    /* 5B5F8 8006ADF8 1100033C */  lui        $v1, (0x11FFFF >> 16)
    /* 5B5FC 8006ADFC FFFF6334 */  ori        $v1, $v1, (0x11FFFF & 0xFFFF)
    /* 5B600 8006AE00 12300000 */  mflo       $a2
    /* 5B604 8006AE04 2110A600 */  addu       $v0, $a1, $a2
    /* 5B608 8006AE08 2A186200 */  slt        $v1, $v1, $v0
    /* 5B60C 8006AE0C 42006014 */  bnez       $v1, .L8006AF18
    /* 5B610 8006AE10 33F30234 */   ori       $v0, $zero, 0xF333
    /* 5B614 8006AE14 2A104400 */  slt        $v0, $v0, $a0
    /* 5B618 8006AE18 0F004010 */  beqz       $v0, .L8006AE58
    /* 5B61C 8006AE1C C0101100 */   sll       $v0, $s1, 3
    /* 5B620 8006AE20 23105100 */  subu       $v0, $v0, $s1
    /* 5B624 8006AE24 40190200 */  sll        $v1, $v0, 5
    /* 5B628 8006AE28 21104300 */  addu       $v0, $v0, $v1
    /* 5B62C 8006AE2C C0100200 */  sll        $v0, $v0, 3
    /* 5B630 8006AE30 21105100 */  addu       $v0, $v0, $s1
    /* 5B634 8006AE34 C0180200 */  sll        $v1, $v0, 3
    /* 5B638 8006AE38 23186200 */  subu       $v1, $v1, $v0
    /* 5B63C 8006AE3C 80180300 */  sll        $v1, $v1, 2
    /* 5B640 8006AE40 21187100 */  addu       $v1, $v1, $s1
    /* 5B644 8006AE44 04006104 */  bgez       $v1, .L8006AE58
    /* 5B648 8006AE48 038C0300 */   sra       $s1, $v1, 16
    /* 5B64C 8006AE4C FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5B650 8006AE50 21186200 */  addu       $v1, $v1, $v0
    /* 5B654 8006AE54 038C0300 */  sra        $s1, $v1, 16
  .L8006AE58:
    /* 5B658 8006AE58 66E60234 */  ori        $v0, $zero, 0xE666
    /* 5B65C 8006AE5C 2A104400 */  slt        $v0, $v0, $a0
    /* 5B660 8006AE60 0C004010 */  beqz       $v0, .L8006AE94
    /* 5B664 8006AE64 C0101100 */   sll       $v0, $s1, 3
    /* 5B668 8006AE68 23105100 */  subu       $v0, $v0, $s1
    /* 5B66C 8006AE6C 80100200 */  sll        $v0, $v0, 2
    /* 5B670 8006AE70 23105100 */  subu       $v0, $v0, $s1
    /* 5B674 8006AE74 C0100200 */  sll        $v0, $v0, 3
    /* 5B678 8006AE78 23105100 */  subu       $v0, $v0, $s1
    /* 5B67C 8006AE7C 40110200 */  sll        $v0, $v0, 5
    /* 5B680 8006AE80 21105100 */  addu       $v0, $v0, $s1
    /* 5B684 8006AE84 80100200 */  sll        $v0, $v0, 2
    /* 5B688 8006AE88 21105100 */  addu       $v0, $v0, $s1
    /* 5B68C 8006AE8C C1AB0108 */  j          .L8006AF04
    /* 5B690 8006AE90 40180200 */   sll       $v1, $v0, 1
  .L8006AE94:
    /* 5B694 8006AE94 CCCC0234 */  ori        $v0, $zero, 0xCCCC
    /* 5B698 8006AE98 2A104400 */  slt        $v0, $v0, $a0
    /* 5B69C 8006AE9C 0C004010 */  beqz       $v0, .L8006AED0
    /* 5B6A0 8006AEA0 40111100 */   sll       $v0, $s1, 5
    /* 5B6A4 8006AEA4 21105100 */  addu       $v0, $v0, $s1
    /* 5B6A8 8006AEA8 C0100200 */  sll        $v0, $v0, 3
    /* 5B6AC 8006AEAC 23105100 */  subu       $v0, $v0, $s1
    /* 5B6B0 8006AEB0 80100200 */  sll        $v0, $v0, 2
    /* 5B6B4 8006AEB4 21105100 */  addu       $v0, $v0, $s1
    /* 5B6B8 8006AEB8 80100200 */  sll        $v0, $v0, 2
    /* 5B6BC 8006AEBC 21105100 */  addu       $v0, $v0, $s1
    /* 5B6C0 8006AEC0 C0180200 */  sll        $v1, $v0, 3
    /* 5B6C4 8006AEC4 23186200 */  subu       $v1, $v1, $v0
    /* 5B6C8 8006AEC8 C1AB0108 */  j          .L8006AF04
    /* 5B6CC 8006AECC 40180300 */   sll       $v1, $v1, 1
  .L8006AED0:
    /* 5B6D0 8006AED0 00C00234 */  ori        $v0, $zero, 0xC000
    /* 5B6D4 8006AED4 2A104400 */  slt        $v0, $v0, $a0
    /* 5B6D8 8006AED8 0F004010 */  beqz       $v0, .L8006AF18
    /* 5B6DC 8006AEDC 80101100 */   sll       $v0, $s1, 2
    /* 5B6E0 8006AEE0 21105100 */  addu       $v0, $v0, $s1
    /* 5B6E4 8006AEE4 00110200 */  sll        $v0, $v0, 4
    /* 5B6E8 8006AEE8 21105100 */  addu       $v0, $v0, $s1
    /* 5B6EC 8006AEEC 00110200 */  sll        $v0, $v0, 4
    /* 5B6F0 8006AEF0 21105100 */  addu       $v0, $v0, $s1
    /* 5B6F4 8006AEF4 00110200 */  sll        $v0, $v0, 4
    /* 5B6F8 8006AEF8 21105100 */  addu       $v0, $v0, $s1
    /* 5B6FC 8006AEFC 80180200 */  sll        $v1, $v0, 2
    /* 5B700 8006AF00 23186200 */  subu       $v1, $v1, $v0
  .L8006AF04:
    /* 5B704 8006AF04 04006104 */  bgez       $v1, .L8006AF18
    /* 5B708 8006AF08 038C0300 */   sra       $s1, $v1, 16
    /* 5B70C 8006AF0C FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5B710 8006AF10 21186200 */  addu       $v1, $v1, $v0
    /* 5B714 8006AF14 038C0300 */  sra        $s1, $v1, 16
  .L8006AF18:
    /* 5B718 8006AF18 F006428E */  lw         $v0, 0x6F0($s2)
    /* 5B71C 8006AF1C 00000000 */  nop
    /* 5B720 8006AF20 18002202 */  mult       $s1, $v0
    /* 5B724 8006AF24 12180000 */  mflo       $v1
    /* 5B728 8006AF28 5405428E */  lw         $v0, 0x554($s2)
    /* 5B72C 8006AF2C 00000000 */  nop
    /* 5B730 8006AF30 18006200 */  mult       $v1, $v0
    /* 5B734 8006AF34 12280000 */  mflo       $a1
    /* 5B738 8006AF38 0900A004 */  bltz       $a1, .L8006AF60
    /* 5B73C 8006AF3C 00000000 */   nop
    /* 5B740 8006AF40 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 5B744 8006AF44 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 5B748 8006AF48 21286502 */  addu       $a1, $s3, $a1
    /* 5B74C 8006AF4C 2A10A300 */  slt        $v0, $a1, $v1
    /* 5B750 8006AF50 0A004014 */  bnez       $v0, .L8006AF7C
    /* 5B754 8006AF54 00000000 */   nop
    /* 5B758 8006AF58 DFAB0108 */  j          .L8006AF7C
    /* 5B75C 8006AF5C 2328A300 */   subu      $a1, $a1, $v1
  .L8006AF60:
    /* 5B760 8006AF60 21286502 */  addu       $a1, $s3, $a1
    /* 5B764 8006AF64 0500A104 */  bgez       $a1, .L8006AF7C
    /* 5B768 8006AF68 00000000 */   nop
    /* 5B76C 8006AF6C 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 5B770 8006AF70 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 5B774 8006AF74 00000000 */  nop
    /* 5B778 8006AF78 2128A200 */  addu       $a1, $a1, $v0
  .L8006AF7C:
    /* 5B77C 8006AF7C 580745AE */  sw         $a1, 0x758($s2)
    /* 5B780 8006AF80 5807428E */  lw         $v0, 0x758($s2)
    /* 5B784 8006AF84 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 5B788 8006AF88 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 5B78C 8006AF8C 40110200 */  sll        $v0, $v0, 5
    /* 5B790 8006AF90 21104300 */  addu       $v0, $v0, $v1
    /* 5B794 8006AF94 0000488C */  lw         $t0, 0x0($v0)
    /* 5B798 8006AF98 0400498C */  lw         $t1, 0x4($v0)
    /* 5B79C 8006AF9C 08004A8C */  lw         $t2, 0x8($v0)
    /* 5B7A0 8006AFA0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 5B7A4 8006AFA4 1400A9AF */  sw         $t1, 0x14($sp)
    /* 5B7A8 8006AFA8 1800AAAF */  sw         $t2, 0x18($sp)
    /* 5B7AC 8006AFAC 5807428E */  lw         $v0, 0x758($s2)
    /* 5B7B0 8006AFB0 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 5B7B4 8006AFB4 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 5B7B8 8006AFB8 40110200 */  sll        $v0, $v0, 5
    /* 5B7BC 8006AFBC 21104300 */  addu       $v0, $v0, $v1
    /* 5B7C0 8006AFC0 12004580 */  lb         $a1, 0x12($v0)
    /* 5B7C4 8006AFC4 00000000 */  nop
    /* 5B7C8 8006AFC8 402A0500 */  sll        $a1, $a1, 9
    /* 5B7CC 8006AFCC 3000A5AF */  sw         $a1, 0x30($sp)
    /* 5B7D0 8006AFD0 5807428E */  lw         $v0, 0x758($s2)
    /* 5B7D4 8006AFD4 00000000 */  nop
    /* 5B7D8 8006AFD8 40110200 */  sll        $v0, $v0, 5
    /* 5B7DC 8006AFDC 21104300 */  addu       $v0, $v0, $v1
    /* 5B7E0 8006AFE0 13004280 */  lb         $v0, 0x13($v0)
    /* 5B7E4 8006AFE4 00000000 */  nop
    /* 5B7E8 8006AFE8 40120200 */  sll        $v0, $v0, 9
    /* 5B7EC 8006AFEC 3400A2AF */  sw         $v0, 0x34($sp)
    /* 5B7F0 8006AFF0 5807428E */  lw         $v0, 0x758($s2)
    /* 5B7F4 8006AFF4 00000000 */  nop
    /* 5B7F8 8006AFF8 40110200 */  sll        $v0, $v0, 5
    /* 5B7FC 8006AFFC 21104300 */  addu       $v0, $v0, $v1
    /* 5B800 8006B000 14004280 */  lb         $v0, 0x14($v0)
    /* 5B804 8006B004 00000000 */  nop
    /* 5B808 8006B008 40120200 */  sll        $v0, $v0, 9
    /* 5B80C 8006B00C 3800A2AF */  sw         $v0, 0x38($sp)
    /* 5B810 8006B010 1807448E */  lw         $a0, 0x718($s2)
    /* 5B814 8006B014 CA90030C */  jal        fixedmult
    /* 5B818 8006B018 00000000 */   nop
    /* 5B81C 8006B01C 2000A2AF */  sw         $v0, 0x20($sp)
    /* 5B820 8006B020 1807448E */  lw         $a0, 0x718($s2)
    /* 5B824 8006B024 3400A58F */  lw         $a1, 0x34($sp)
    /* 5B828 8006B028 CA90030C */  jal        fixedmult
    /* 5B82C 8006B02C 00000000 */   nop
    /* 5B830 8006B030 2400A2AF */  sw         $v0, 0x24($sp)
    /* 5B834 8006B034 1807448E */  lw         $a0, 0x718($s2)
    /* 5B838 8006B038 3800A58F */  lw         $a1, 0x38($sp)
    /* 5B83C 8006B03C CA90030C */  jal        fixedmult
    /* 5B840 8006B040 00000000 */   nop
    /* 5B844 8006B044 2000A427 */  addiu      $a0, $sp, 0x20
    /* 5B848 8006B048 2000A38F */  lw         $v1, 0x20($sp)
    /* 5B84C 8006B04C 1000A68F */  lw         $a2, 0x10($sp)
    /* 5B850 8006B050 1800A78F */  lw         $a3, 0x18($sp)
    /* 5B854 8006B054 21286002 */  addu       $a1, $s3, $zero
    /* 5B858 8006B058 2800A2AF */  sw         $v0, 0x28($sp)
    /* 5B85C 8006B05C 21186600 */  addu       $v1, $v1, $a2
    /* 5B860 8006B060 2000A3AF */  sw         $v1, 0x20($sp)
    /* 5B864 8006B064 2400A38F */  lw         $v1, 0x24($sp)
    /* 5B868 8006B068 1400A68F */  lw         $a2, 0x14($sp)
    /* 5B86C 8006B06C 21104700 */  addu       $v0, $v0, $a3
    /* 5B870 8006B070 2800A2AF */  sw         $v0, 0x28($sp)
    /* 5B874 8006B074 21186600 */  addu       $v1, $v1, $a2
    /* 5B878 8006B078 C7AA010C */  jal        AIPhysic_CalculateRoadPosition__FP8coorddefi
    /* 5B87C 8006B07C 2400A3AF */   sw        $v1, 0x24($sp)
    /* 5B880 8006B080 1480043C */  lui        $a0, %hi(BWorldSm_slices)
    /* 5B884 8006B084 C0C7848C */  lw         $a0, %lo(BWorldSm_slices)($a0)
    /* 5B888 8006B088 40191300 */  sll        $v1, $s3, 5
    /* 5B88C 8006B08C 21286400 */  addu       $a1, $v1, $a0
    /* 5B890 8006B090 1F00A490 */  lbu        $a0, 0x1F($a1)
    /* 5B894 8006B094 1D00A690 */  lbu        $a2, 0x1D($a1)
    /* 5B898 8006B098 C0230400 */  sll        $a0, $a0, 15
    /* 5B89C 8006B09C 0F00C330 */  andi       $v1, $a2, 0xF
    /* 5B8A0 8006B0A0 18008300 */  mult       $a0, $v1
    /* 5B8A4 8006B0A4 21204000 */  addu       $a0, $v0, $zero
    /* 5B8A8 8006B0A8 12400000 */  mflo       $t0
    /* 5B8AC 8006B0AC 2A100401 */  slt        $v0, $t0, $a0
    /* 5B8B0 8006B0B0 06004010 */  beqz       $v0, .L8006B0CC
    /* 5B8B4 8006B0B4 00000000 */   nop
    /* 5B8B8 8006B0B8 7405428E */  lw         $v0, 0x574($s2)
    /* 5B8BC 8006B0BC 00000000 */  nop
    /* 5B8C0 8006B0C0 2A104400 */  slt        $v0, $v0, $a0
    /* 5B8C4 8006B0C4 0F004014 */  bnez       $v0, .L8006B104
    /* 5B8C8 8006B0C8 00000000 */   nop
  .L8006B0CC:
    /* 5B8CC 8006B0CC 1E00A290 */  lbu        $v0, 0x1E($a1)
    /* 5B8D0 8006B0D0 02190600 */  srl        $v1, $a2, 4
    /* 5B8D4 8006B0D4 C0130200 */  sll        $v0, $v0, 15
    /* 5B8D8 8006B0D8 18004300 */  mult       $v0, $v1
    /* 5B8DC 8006B0DC 12400000 */  mflo       $t0
    /* 5B8E0 8006B0E0 23100800 */  negu       $v0, $t0
    /* 5B8E4 8006B0E4 2A108200 */  slt        $v0, $a0, $v0
    /* 5B8E8 8006B0E8 20004010 */  beqz       $v0, .L8006B16C
    /* 5B8EC 8006B0EC 00000000 */   nop
    /* 5B8F0 8006B0F0 7405428E */  lw         $v0, 0x574($s2)
    /* 5B8F4 8006B0F4 00000000 */  nop
    /* 5B8F8 8006B0F8 2A108200 */  slt        $v0, $a0, $v0
    /* 5B8FC 8006B0FC 1B004010 */  beqz       $v0, .L8006B16C
    /* 5B900 8006B100 00000000 */   nop
  .L8006B104:
    /* 5B904 8006B104 7405438E */  lw         $v1, 0x574($s2)
    /* 5B908 8006B108 00000000 */  nop
    /* 5B90C 8006B10C 2A108300 */  slt        $v0, $a0, $v1
    /* 5B910 8006B110 02004010 */  beqz       $v0, .L8006B11C
    /* 5B914 8006B114 01001024 */   addiu     $s0, $zero, 0x1
    /* 5B918 8006B118 FFFF1024 */  addiu      $s0, $zero, -0x1
  .L8006B11C:
    /* 5B91C 8006B11C 21206002 */  addu       $a0, $s3, $zero
    /* 5B920 8006B120 C02C1000 */  sll        $a1, $s0, 19
    /* 5B924 8006B124 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 5B928 8006B128 21286500 */   addu      $a1, $v1, $a1
    /* 5B92C 8006B12C 21206002 */  addu       $a0, $s3, $zero
    /* 5B930 8006B130 EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 5B934 8006B134 21284000 */   addu      $a1, $v0, $zero
    /* 5B938 8006B138 0A004010 */  beqz       $v0, .L8006B164
    /* 5B93C 8006B13C 21206002 */   addu      $a0, $s3, $zero
    /* 5B940 8006B140 7405428E */  lw         $v0, 0x574($s2)
    /* 5B944 8006B144 802C1000 */  sll        $a1, $s0, 18
    /* 5B948 8006B148 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 5B94C 8006B14C 21284500 */   addu      $a1, $v0, $a1
    /* 5B950 8006B150 21206002 */  addu       $a0, $s3, $zero
    /* 5B954 8006B154 EACC010C */  jal        AIWorld_IsDriveableLane__Fii
    /* 5B958 8006B158 21284000 */   addu      $a1, $v0, $zero
    /* 5B95C 8006B15C 5CAC0108 */  j          .L8006B170
    /* 5B960 8006B160 2B200200 */   sltu      $a0, $zero, $v0
  .L8006B164:
    /* 5B964 8006B164 5CAC0108 */  j          .L8006B170
    /* 5B968 8006B168 21200000 */   addu      $a0, $zero, $zero
  .L8006B16C:
    /* 5B96C 8006B16C 01000424 */  addiu      $a0, $zero, 0x1
  .L8006B170:
    /* 5B970 8006B170 01009426 */  addiu      $s4, $s4, 0x1
    /* 5B974 8006B174 40101100 */  sll        $v0, $s1, 1
    /* 5B978 8006B178 21105100 */  addu       $v0, $v0, $s1
    /* 5B97C 8006B17C 00190200 */  sll        $v1, $v0, 4
    /* 5B980 8006B180 21104300 */  addu       $v0, $v0, $v1
    /* 5B984 8006B184 001A0200 */  sll        $v1, $v0, 8
    /* 5B988 8006B188 21104300 */  addu       $v0, $v0, $v1
    /* 5B98C 8006B18C 80880200 */  sll        $s1, $v0, 2
    /* 5B990 8006B190 03002106 */  bgez       $s1, .L8006B1A0
    /* 5B994 8006B194 21102002 */   addu      $v0, $s1, $zero
    /* 5B998 8006B198 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 5B99C 8006B19C 21102202 */  addu       $v0, $s1, $v0
  .L8006B1A0:
    /* 5B9A0 8006B1A0 038C0200 */  sra        $s1, $v0, 16
    /* 5B9A4 8006B1A4 04000324 */  addiu      $v1, $zero, 0x4
    /* 5B9A8 8006B1A8 2A102302 */  slt        $v0, $s1, $v1
    /* 5B9AC 8006B1AC 02004014 */  bnez       $v0, .L8006B1B8
    /* 5B9B0 8006B1B0 0500822A */   slti      $v0, $s4, 0x5
    /* 5B9B4 8006B1B4 21182002 */  addu       $v1, $s1, $zero
  .L8006B1B8:
    /* 5B9B8 8006B1B8 03004010 */  beqz       $v0, .L8006B1C8
    /* 5B9BC 8006B1BC 21886000 */   addu      $s1, $v1, $zero
    /* 5B9C0 8006B1C0 55FF8010 */  beqz       $a0, .L8006AF18
    /* 5B9C4 8006B1C4 00000000 */   nop
  .L8006B1C8:
    /* 5B9C8 8006B1C8 2000A28F */  lw         $v0, 0x20($sp)
    /* 5B9CC 8006B1CC A000438E */  lw         $v1, 0xA0($s2)
    /* 5B9D0 8006B1D0 00000000 */  nop
    /* 5B9D4 8006B1D4 23104300 */  subu       $v0, $v0, $v1
    /* 5B9D8 8006B1D8 D00642AE */  sw         $v0, 0x6D0($s2)
    /* 5B9DC 8006B1DC 2400A28F */  lw         $v0, 0x24($sp)
    /* 5B9E0 8006B1E0 A400438E */  lw         $v1, 0xA4($s2)
    /* 5B9E4 8006B1E4 00000000 */  nop
    /* 5B9E8 8006B1E8 23104300 */  subu       $v0, $v0, $v1
    /* 5B9EC 8006B1EC D40642AE */  sw         $v0, 0x6D4($s2)
    /* 5B9F0 8006B1F0 2800A28F */  lw         $v0, 0x28($sp)
    /* 5B9F4 8006B1F4 A800438E */  lw         $v1, 0xA8($s2)
    /* 5B9F8 8006B1F8 00000000 */  nop
    /* 5B9FC 8006B1FC 23104300 */  subu       $v0, $v0, $v1
    /* 5BA00 8006B200 D80642AE */  sw         $v0, 0x6D8($s2)
  .L8006B204:
    /* 5BA04 8006B204 5400BF8F */  lw         $ra, 0x54($sp)
    /* 5BA08 8006B208 5000B48F */  lw         $s4, 0x50($sp)
    /* 5BA0C 8006B20C 4C00B38F */  lw         $s3, 0x4C($sp)
    /* 5BA10 8006B210 4800B28F */  lw         $s2, 0x48($sp)
    /* 5BA14 8006B214 4400B18F */  lw         $s1, 0x44($sp)
    /* 5BA18 8006B218 4000B08F */  lw         $s0, 0x40($sp)
    /* 5BA1C 8006B21C 0800E003 */  jr         $ra
    /* 5BA20 8006B220 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel AIPhysic_GetDesiredVector__FP8Car_tObj
