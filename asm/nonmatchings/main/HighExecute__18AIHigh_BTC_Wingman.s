.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HighExecute__18AIHigh_BTC_Wingman, 0xA8C

glabel HighExecute__18AIHigh_BTC_Wingman
    /* 4EB3C 8005E33C 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* 4EB40 8005E340 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 4EB44 8005E344 21888000 */  addu       $s1, $a0, $zero
    /* 4EB48 8005E348 6400BFAF */  sw         $ra, 0x64($sp)
    /* 4EB4C 8005E34C 6000B2AF */  sw         $s2, 0x60($sp)
    /* 4EB50 8005E350 7B70010C */  jal        CheckSpikeBelt__15AIHigh_BasicCop
    /* 4EB54 8005E354 5800B0AF */   sw        $s0, 0x58($sp)
    /* 4EB58 8005E358 727B010C */  jal        CheckForActivation__18AIHigh_BTC_Wingman
    /* 4EB5C 8005E35C 21202002 */   addu      $a0, $s1, $zero
    /* 4EB60 8005E360 0800238E */  lw         $v1, 0x8($s1)
    /* 4EB64 8005E364 00000000 */  nop
    /* 4EB68 8005E368 0B00622C */  sltiu      $v0, $v1, 0xB
    /* 4EB6C 8005E36C 8D024010 */  beqz       $v0, .L8005EDA4
    /* 4EB70 8005E370 0580023C */   lui       $v0, %hi(jtbl_80054F64)
    /* 4EB74 8005E374 644F4224 */  addiu      $v0, $v0, %lo(jtbl_80054F64)
    /* 4EB78 8005E378 80180300 */  sll        $v1, $v1, 2
    /* 4EB7C 8005E37C 21186200 */  addu       $v1, $v1, $v0
    /* 4EB80 8005E380 0000628C */  lw         $v0, 0x0($v1)
    /* 4EB84 8005E384 00000000 */  nop
    /* 4EB88 8005E388 08004000 */  jr         $v0
    /* 4EB8C 8005E38C 00000000 */   nop
  jlabel .L8005E390
    /* 4EB90 8005E390 0000258E */  lw         $a1, 0x0($s1)
    /* 4EB94 8005E394 08000424 */  addiu      $a0, $zero, 0x8
    /* 4EB98 8005E398 7005A28C */  lw         $v0, 0x570($a1)
    /* 4EB9C 8005E39C FDFF0324 */  addiu      $v1, $zero, -0x3
    /* 4EBA0 8005E3A0 24104300 */  and        $v0, $v0, $v1
    /* 4EBA4 8005E3A4 578F020C */  jal        __builtin_new
    /* 4EBA8 8005E3A8 7005A2AC */   sw        $v0, 0x570($a1)
    /* 4EBAC 8005E3AC 21904000 */  addu       $s2, $v0, $zero
    /* 4EBB0 8005E3B0 0000308E */  lw         $s0, 0x0($s1)
    /* 4EBB4 8005E3B4 21204002 */  addu       $a0, $s2, $zero
    /* 4EBB8 8005E3B8 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4EBBC 8005E3BC 21280002 */   addu      $a1, $s0, $zero
    /* 4EBC0 8005E3C0 2800A427 */  addiu      $a0, $sp, 0x28
    /* 4EBC4 8005E3C4 21280000 */  addu       $a1, $zero, $zero
    /* 4EBC8 8005E3C8 0C000624 */  addiu      $a2, $zero, 0xC
    /* 4EBCC 8005E3CC 0580023C */  lui        $v0, %hi(D_80054F24)
    /* 4EBD0 8005E3D0 244F4224 */  addiu      $v0, $v0, %lo(D_80054F24)
    /* 4EBD4 8005E3D4 C690030C */  jal        memset
    /* 4EBD8 8005E3D8 040042AE */   sw        $v0, 0x4($s2)
    /* 4EBDC 8005E3DC 21280000 */  addu       $a1, $zero, $zero
    /* 4EBE0 8005E3E0 5402038E */  lw         $v1, 0x254($s0)
    /* 4EBE4 8005E3E4 2800A627 */  addiu      $a2, $sp, 0x28
    /* 4EBE8 8005E3E8 80100300 */  sll        $v0, $v1, 2
    /* 4EBEC 8005E3EC 21104300 */  addu       $v0, $v0, $v1
    /* 4EBF0 8005E3F0 40140200 */  sll        $v0, $v0, 17
    /* 4EBF4 8005E3F4 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 4EBF8 8005E3F8 0000448E */  lw         $a0, 0x0($s2)
    /* 4EBFC 8005E3FC E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 4EC00 8005E400 01000724 */   addiu     $a3, $zero, 0x1
    /* 4EC04 8005E404 0000428E */  lw         $v0, 0x0($s2)
    /* 4EC08 8005E408 00000000 */  nop
    /* 4EC0C 8005E40C 910040A0 */  sb         $zero, 0x91($v0)
    /* 4EC10 8005E410 0400238E */  lw         $v1, 0x4($s1)
    /* 4EC14 8005E414 00000000 */  nop
    /* 4EC18 8005E418 08006010 */  beqz       $v1, .L8005E43C
    /* 4EC1C 8005E41C 03000524 */   addiu     $a1, $zero, 0x3
    /* 4EC20 8005E420 0400628C */  lw         $v0, 0x4($v1)
    /* 4EC24 8005E424 00000000 */  nop
    /* 4EC28 8005E428 10004484 */  lh         $a0, 0x10($v0)
    /* 4EC2C 8005E42C 1400428C */  lw         $v0, 0x14($v0)
    /* 4EC30 8005E430 00000000 */  nop
    /* 4EC34 8005E434 09F84000 */  jalr       $v0
    /* 4EC38 8005E438 21206400 */   addu      $a0, $v1, $a0
  .L8005E43C:
    /* 4EC3C 8005E43C 07000224 */  addiu      $v0, $zero, 0x7
    /* 4EC40 8005E440 687B0108 */  j          .L8005EDA0
    /* 4EC44 8005E444 040032AE */   sw        $s2, 0x4($s1)
  jlabel .L8005E448
    /* 4EC48 8005E448 0000248E */  lw         $a0, 0x0($s1)
    /* 4EC4C 8005E44C 00000000 */  nop
    /* 4EC50 8005E450 7005828C */  lw         $v0, 0x570($a0)
    /* 4EC54 8005E454 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* 4EC58 8005E458 24104300 */  and        $v0, $v0, $v1
    /* 4EC5C 8005E45C 700582AC */  sw         $v0, 0x570($a0)
    /* 4EC60 8005E460 6800238E */  lw         $v1, 0x68($s1)
    /* 4EC64 8005E464 6400228E */  lw         $v0, 0x64($s1)
    /* 4EC68 8005E468 00000000 */  nop
    /* 4EC6C 8005E46C 33006210 */  beq        $v1, $v0, .L8005E53C
    /* 4EC70 8005E470 FEFF6224 */   addiu     $v0, $v1, -0x2
    /* 4EC74 8005E474 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4EC78 8005E478 30004010 */  beqz       $v0, .L8005E53C
    /* 4EC7C 8005E47C 00000000 */   nop
    /* 4EC80 8005E480 0000248E */  lw         $a0, 0x0($s1)
    /* 4EC84 8005E484 FBA1010C */  jal        AILife_IsCarInAnyVisibleArea__FP8Car_tObj
    /* 4EC88 8005E488 00000000 */   nop
    /* 4EC8C 8005E48C 54004014 */  bnez       $v0, .L8005E5E0
    /* 4EC90 8005E490 00000000 */   nop
    /* 4EC94 8005E494 0000248E */  lw         $a0, 0x0($s1)
    /* 4EC98 8005E498 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4EC9C 8005E49C 00000000 */   nop
    /* 4ECA0 8005E4A0 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4ECA4 8005E4A4 00000000 */  nop
    /* 4ECA8 8005E4A8 80006484 */  lh         $a0, 0x80($v1)
    /* 4ECAC 8005E4AC 8400638C */  lw         $v1, 0x84($v1)
    /* 4ECB0 8005E4B0 00000000 */  nop
    /* 4ECB4 8005E4B4 09F86000 */  jalr       $v1
    /* 4ECB8 8005E4B8 21204400 */   addu      $a0, $v0, $a0
    /* 4ECBC 8005E4BC 21202002 */  addu       $a0, $s1, $zero
    /* 4ECC0 8005E4C0 6800268E */  lw         $a2, 0x68($s1)
    /* 4ECC4 8005E4C4 6C00258E */  lw         $a1, 0x6C($s1)
    /* 4ECC8 8005E4C8 6800228E */  lw         $v0, 0x68($s1)
    /* 4ECCC 8005E4CC 0300C638 */  xori       $a2, $a2, 0x3
    /* 4ECD0 8005E4D0 0100C62C */  sltiu      $a2, $a2, 0x1
    /* 4ECD4 8005E4D4 1D7C010C */  jal        SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
    /* 4ECD8 8005E4D8 640022AE */   sw        $v0, 0x64($s1)
    /* 4ECDC 8005E4DC 578F020C */  jal        __builtin_new
    /* 4ECE0 8005E4E0 10000424 */   addiu     $a0, $zero, 0x10
    /* 4ECE4 8005E4E4 21804000 */  addu       $s0, $v0, $zero
    /* 4ECE8 8005E4E8 0000258E */  lw         $a1, 0x0($s1)
    /* 4ECEC 8005E4EC 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4ECF0 8005E4F0 21200002 */   addu      $a0, $s0, $zero
    /* 4ECF4 8005E4F4 0580023C */  lui        $v0, %hi(_vt_12AIState_Idle)
    /* 4ECF8 8005E4F8 00564224 */  addiu      $v0, $v0, %lo(_vt_12AIState_Idle)
    /* 4ECFC 8005E4FC 040002AE */  sw         $v0, 0x4($s0)
    /* 4ED00 8005E500 01000224 */  addiu      $v0, $zero, 0x1
    /* 4ED04 8005E504 0C0002AE */  sw         $v0, 0xC($s0)
    /* 4ED08 8005E508 0400238E */  lw         $v1, 0x4($s1)
    /* 4ED0C 8005E50C 00000000 */  nop
    /* 4ED10 8005E510 08006010 */  beqz       $v1, .L8005E534
    /* 4ED14 8005E514 03000524 */   addiu     $a1, $zero, 0x3
    /* 4ED18 8005E518 0400628C */  lw         $v0, 0x4($v1)
    /* 4ED1C 8005E51C 00000000 */  nop
    /* 4ED20 8005E520 10004484 */  lh         $a0, 0x10($v0)
    /* 4ED24 8005E524 1400428C */  lw         $v0, 0x14($v0)
    /* 4ED28 8005E528 00000000 */  nop
    /* 4ED2C 8005E52C 09F84000 */  jalr       $v0
    /* 4ED30 8005E530 21206400 */   addu      $a0, $v1, $a0
  .L8005E534:
    /* 4ED34 8005E534 76790108 */  j          .L8005E5D8
    /* 4ED38 8005E538 03000224 */   addiu     $v0, $zero, 0x3
  .L8005E53C:
    /* 4ED3C 8005E53C 2E73010C */  jal        CheckForNewTarget__14AIHigh_BTC_Cop
    /* 4ED40 8005E540 21202002 */   addu      $a0, $s1, $zero
    /* 4ED44 8005E544 5800228E */  lw         $v0, 0x58($s1)
    /* 4ED48 8005E548 00000000 */  nop
    /* 4ED4C 8005E54C 24004010 */  beqz       $v0, .L8005E5E0
    /* 4ED50 8005E550 21202002 */   addu      $a0, $s1, $zero
    /* 4ED54 8005E554 0773010C */  jal        GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
    /* 4ED58 8005E558 2800A527 */   addiu     $a1, $sp, 0x28
    /* 4ED5C 8005E55C 578F020C */  jal        __builtin_new
    /* 4ED60 8005E560 94000424 */   addiu     $a0, $zero, 0x94
    /* 4ED64 8005E564 21204000 */  addu       $a0, $v0, $zero
    /* 4ED68 8005E568 5800228E */  lw         $v0, 0x58($s1)
    /* 4ED6C 8005E56C 00000000 */  nop
    /* 4ED70 8005E570 0000468C */  lw         $a2, 0x0($v0)
    /* 4ED74 8005E574 00020224 */  addiu      $v0, $zero, 0x200
    /* 4ED78 8005E578 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4ED7C 8005E57C 3C00023C */  lui        $v0, (0x3C0000 >> 16)
    /* 4ED80 8005E580 1400A2AF */  sw         $v0, 0x14($sp)
    /* 4ED84 8005E584 1900023C */  lui        $v0, (0x190000 >> 16)
    /* 4ED88 8005E588 1800A2AF */  sw         $v0, 0x18($sp)
    /* 4ED8C 8005E58C 02000224 */  addiu      $v0, $zero, 0x2
    /* 4ED90 8005E590 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 4ED94 8005E594 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 4ED98 8005E598 2000A2AF */  sw         $v0, 0x20($sp)
    /* 4ED9C 8005E59C 0000258E */  lw         $a1, 0x0($s1)
    /* 4EDA0 8005E5A0 FFBE010C */  jal        __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
    /* 4EDA4 8005E5A4 2800A727 */   addiu     $a3, $sp, 0x28
    /* 4EDA8 8005E5A8 0400238E */  lw         $v1, 0x4($s1)
    /* 4EDAC 8005E5AC 00000000 */  nop
    /* 4EDB0 8005E5B0 08006010 */  beqz       $v1, .L8005E5D4
    /* 4EDB4 8005E5B4 21804000 */   addu      $s0, $v0, $zero
    /* 4EDB8 8005E5B8 0400628C */  lw         $v0, 0x4($v1)
    /* 4EDBC 8005E5BC 03000524 */  addiu      $a1, $zero, 0x3
    /* 4EDC0 8005E5C0 10004484 */  lh         $a0, 0x10($v0)
    /* 4EDC4 8005E5C4 1400428C */  lw         $v0, 0x14($v0)
    /* 4EDC8 8005E5C8 00000000 */  nop
    /* 4EDCC 8005E5CC 09F84000 */  jalr       $v0
    /* 4EDD0 8005E5D0 21206400 */   addu      $a0, $v1, $a0
  .L8005E5D4:
    /* 4EDD4 8005E5D4 04000224 */  addiu      $v0, $zero, 0x4
  .L8005E5D8:
    /* 4EDD8 8005E5D8 040030AE */  sw         $s0, 0x4($s1)
    /* 4EDDC 8005E5DC 080022AE */  sw         $v0, 0x8($s1)
  .L8005E5E0:
    /* 4EDE0 8005E5E0 BE7B010C */  jal        UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
    /* 4EDE4 8005E5E4 21202002 */   addu      $a0, $s1, $zero
    /* 4EDE8 8005E5E8 EE014010 */  beqz       $v0, .L8005EDA4
    /* 4EDEC 8005E5EC 21202002 */   addu      $a0, $s1, $zero
    /* 4EDF0 8005E5F0 EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4EDF4 8005E5F4 21280000 */   addu      $a1, $zero, $zero
    /* 4EDF8 8005E5F8 578F020C */  jal        __builtin_new
    /* 4EDFC 8005E5FC 08000424 */   addiu     $a0, $zero, 0x8
    /* 4EE00 8005E600 21904000 */  addu       $s2, $v0, $zero
    /* 4EE04 8005E604 0000308E */  lw         $s0, 0x0($s1)
    /* 4EE08 8005E608 21204002 */  addu       $a0, $s2, $zero
    /* 4EE0C 8005E60C 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4EE10 8005E610 21280002 */   addu      $a1, $s0, $zero
    /* 4EE14 8005E614 2800A427 */  addiu      $a0, $sp, 0x28
    /* 4EE18 8005E618 21280000 */  addu       $a1, $zero, $zero
    /* 4EE1C 8005E61C 0C000624 */  addiu      $a2, $zero, 0xC
    /* 4EE20 8005E620 0580023C */  lui        $v0, %hi(D_80054F24)
    /* 4EE24 8005E624 244F4224 */  addiu      $v0, $v0, %lo(D_80054F24)
    /* 4EE28 8005E628 C690030C */  jal        memset
    /* 4EE2C 8005E62C 040042AE */   sw        $v0, 0x4($s2)
    /* 4EE30 8005E630 21280000 */  addu       $a1, $zero, $zero
    /* 4EE34 8005E634 5402038E */  lw         $v1, 0x254($s0)
    /* 4EE38 8005E638 2800A627 */  addiu      $a2, $sp, 0x28
    /* 4EE3C 8005E63C 80100300 */  sll        $v0, $v1, 2
    /* 4EE40 8005E640 21104300 */  addu       $v0, $v0, $v1
    /* 4EE44 8005E644 40140200 */  sll        $v0, $v0, 17
    /* 4EE48 8005E648 037B0108 */  j          .L8005EC0C
    /* 4EE4C 8005E64C 2C00A2AF */   sw        $v0, 0x2C($sp)
  jlabel .L8005E650
    /* 4EE50 8005E650 0000238E */  lw         $v1, 0x0($s1)
    /* 4EE54 8005E654 21202002 */  addu       $a0, $s1, $zero
    /* 4EE58 8005E658 7005628C */  lw         $v0, 0x570($v1)
    /* 4EE5C 8005E65C 0400328E */  lw         $s2, 0x4($s1)
    /* 4EE60 8005E660 02004234 */  ori        $v0, $v0, 0x2
    /* 4EE64 8005E664 8A72010C */  jal        HandleBlockadeSpeech__15AIHigh_BasicCop
    /* 4EE68 8005E668 700562AC */   sw        $v0, 0x570($v1)
    /* 4EE6C 8005E66C 21202002 */  addu       $a0, $s1, $zero
    /* 4EE70 8005E670 0773010C */  jal        GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
    /* 4EE74 8005E674 2800A527 */   addiu     $a1, $sp, 0x28
    /* 4EE78 8005E678 06004010 */  beqz       $v0, .L8005E694
    /* 4EE7C 8005E67C 21204002 */   addu      $a0, $s2, $zero
    /* 4EE80 8005E680 5800228E */  lw         $v0, 0x58($s1)
    /* 4EE84 8005E684 00000000 */  nop
    /* 4EE88 8005E688 0000458C */  lw         $a1, 0x0($v0)
    /* 4EE8C 8005E68C 63BF010C */  jal        SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
    /* 4EE90 8005E690 2800A627 */   addiu     $a2, $sp, 0x28
  .L8005E694:
    /* 4EE94 8005E694 9000428E */  lw         $v0, 0x90($s2)
    /* 4EE98 8005E698 00000000 */  nop
    /* 4EE9C 8005E69C A1004228 */  slti       $v0, $v0, 0xA1
    /* 4EEA0 8005E6A0 19004014 */  bnez       $v0, .L8005E708
    /* 4EEA4 8005E6A4 00000000 */   nop
    /* 4EEA8 8005E6A8 45C3010C */  jal        FindBarrierEndSlice__13AIState_Chase
    /* 4EEAC 8005E6AC 21204002 */   addu      $a0, $s2, $zero
    /* 4EEB0 8005E6B0 10000424 */  addiu      $a0, $zero, 0x10
    /* 4EEB4 8005E6B4 578F020C */  jal        __builtin_new
    /* 4EEB8 8005E6B8 21804000 */   addu      $s0, $v0, $zero
    /* 4EEBC 8005E6BC 21204000 */  addu       $a0, $v0, $zero
    /* 4EEC0 8005E6C0 21300002 */  addu       $a2, $s0, $zero
    /* 4EEC4 8005E6C4 0000258E */  lw         $a1, 0x0($s1)
    /* 4EEC8 8005E6C8 DBC8010C */  jal        __17AIState_GotoSliceP8Car_tObjii
    /* 4EECC 8005E6CC 21380000 */   addu      $a3, $zero, $zero
    /* 4EED0 8005E6D0 0400238E */  lw         $v1, 0x4($s1)
    /* 4EED4 8005E6D4 00000000 */  nop
    /* 4EED8 8005E6D8 08006010 */  beqz       $v1, .L8005E6FC
    /* 4EEDC 8005E6DC 21804000 */   addu      $s0, $v0, $zero
    /* 4EEE0 8005E6E0 0400628C */  lw         $v0, 0x4($v1)
    /* 4EEE4 8005E6E4 03000524 */  addiu      $a1, $zero, 0x3
    /* 4EEE8 8005E6E8 10004484 */  lh         $a0, 0x10($v0)
    /* 4EEEC 8005E6EC 1400428C */  lw         $v0, 0x14($v0)
    /* 4EEF0 8005E6F0 00000000 */  nop
    /* 4EEF4 8005E6F4 09F84000 */  jalr       $v0
    /* 4EEF8 8005E6F8 21206400 */   addu      $a0, $v1, $a0
  .L8005E6FC:
    /* 4EEFC 8005E6FC 09000224 */  addiu      $v0, $zero, 0x9
    /* 4EF00 8005E700 040030AE */  sw         $s0, 0x4($s1)
    /* 4EF04 8005E704 080022AE */  sw         $v0, 0x8($s1)
  .L8005E708:
    /* 4EF08 8005E708 2E73010C */  jal        CheckForNewTarget__14AIHigh_BTC_Cop
    /* 4EF0C 8005E70C 21202002 */   addu      $a0, $s1, $zero
    /* 4EF10 8005E710 09004010 */  beqz       $v0, .L8005E738
    /* 4EF14 8005E714 21202002 */   addu      $a0, $s1, $zero
    /* 4EF18 8005E718 3800B027 */  addiu      $s0, $sp, 0x38
    /* 4EF1C 8005E71C 0773010C */  jal        GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
    /* 4EF20 8005E720 21280002 */   addu      $a1, $s0, $zero
    /* 4EF24 8005E724 5800228E */  lw         $v0, 0x58($s1)
    /* 4EF28 8005E728 21204002 */  addu       $a0, $s2, $zero
    /* 4EF2C 8005E72C 0000458C */  lw         $a1, 0x0($v0)
    /* 4EF30 8005E730 63BF010C */  jal        SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
    /* 4EF34 8005E734 21300002 */   addu      $a2, $s0, $zero
  .L8005E738:
    /* 4EF38 8005E738 7800438E */  lw         $v1, 0x78($s2)
    /* 4EF3C 8005E73C 08000224 */  addiu      $v0, $zero, 0x8
    /* 4EF40 8005E740 2A104300 */  slt        $v0, $v0, $v1
    /* 4EF44 8005E744 0F004010 */  beqz       $v0, .L8005E784
    /* 4EF48 8005E748 21200000 */   addu      $a0, $zero, $zero
    /* 4EF4C 8005E74C 6C00428E */  lw         $v0, 0x6C($s2)
    /* 4EF50 8005E750 0E00033C */  lui        $v1, (0xE0000 >> 16)
    /* 4EF54 8005E754 02004104 */  bgez       $v0, .L8005E760
    /* 4EF58 8005E758 00000000 */   nop
    /* 4EF5C 8005E75C 23100200 */  negu       $v0, $v0
  .L8005E760:
    /* 4EF60 8005E760 2A104300 */  slt        $v0, $v0, $v1
    /* 4EF64 8005E764 07004010 */  beqz       $v0, .L8005E784
    /* 4EF68 8005E768 0F00033C */   lui       $v1, (0xF0000 >> 16)
    /* 4EF6C 8005E76C 6800428E */  lw         $v0, 0x68($s2)
    /* 4EF70 8005E770 00000000 */  nop
    /* 4EF74 8005E774 02004104 */  bgez       $v0, .L8005E780
    /* 4EF78 8005E778 00000000 */   nop
    /* 4EF7C 8005E77C 23100200 */  negu       $v0, $v0
  .L8005E780:
    /* 4EF80 8005E780 2A204300 */  slt        $a0, $v0, $v1
  .L8005E784:
    /* 4EF84 8005E784 04008010 */  beqz       $a0, .L8005E798
    /* 4EF88 8005E788 21204002 */   addu      $a0, $s2, $zero
    /* 4EF8C 8005E78C 01000524 */  addiu      $a1, $zero, 0x1
    /* 4EF90 8005E790 9BBF010C */  jal        SetMurderMode__13AIState_Chaseii
    /* 4EF94 8005E794 00030624 */   addiu     $a2, $zero, 0x300
  .L8005E798:
    /* 4EF98 8005E798 5800228E */  lw         $v0, 0x58($s1)
    /* 4EF9C 8005E79C 00000000 */  nop
    /* 4EFA0 8005E7A0 17004014 */  bnez       $v0, .L8005E800
    /* 4EFA4 8005E7A4 00000000 */   nop
    /* 4EFA8 8005E7A8 21202002 */  addu       $a0, $s1, $zero
    /* 4EFAC 8005E7AC EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4EFB0 8005E7B0 21280000 */   addu      $a1, $zero, $zero
    /* 4EFB4 8005E7B4 578F020C */  jal        __builtin_new
    /* 4EFB8 8005E7B8 08000424 */   addiu     $a0, $zero, 0x8
    /* 4EFBC 8005E7BC 0000258E */  lw         $a1, 0x0($s1)
    /* 4EFC0 8005E7C0 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 4EFC4 8005E7C4 21204000 */   addu      $a0, $v0, $zero
    /* 4EFC8 8005E7C8 0400238E */  lw         $v1, 0x4($s1)
    /* 4EFCC 8005E7CC 00000000 */  nop
    /* 4EFD0 8005E7D0 08006010 */  beqz       $v1, .L8005E7F4
    /* 4EFD4 8005E7D4 21804000 */   addu      $s0, $v0, $zero
    /* 4EFD8 8005E7D8 0400628C */  lw         $v0, 0x4($v1)
    /* 4EFDC 8005E7DC 03000524 */  addiu      $a1, $zero, 0x3
    /* 4EFE0 8005E7E0 10004484 */  lh         $a0, 0x10($v0)
    /* 4EFE4 8005E7E4 1400428C */  lw         $v0, 0x14($v0)
    /* 4EFE8 8005E7E8 00000000 */  nop
    /* 4EFEC 8005E7EC 09F84000 */  jalr       $v0
    /* 4EFF0 8005E7F0 21206400 */   addu      $a0, $v1, $a0
  .L8005E7F4:
    /* 4EFF4 8005E7F4 02000224 */  addiu      $v0, $zero, 0x2
    /* 4EFF8 8005E7F8 040030AE */  sw         $s0, 0x4($s1)
    /* 4EFFC 8005E7FC 080022AE */  sw         $v0, 0x8($s1)
  .L8005E800:
    /* 4F000 8005E800 6800238E */  lw         $v1, 0x68($s1)
    /* 4F004 8005E804 6400228E */  lw         $v0, 0x64($s1)
    /* 4F008 8005E808 00000000 */  nop
    /* 4F00C 8005E80C 27006210 */  beq        $v1, $v0, .L8005E8AC
    /* 4F010 8005E810 FEFF6224 */   addiu     $v0, $v1, -0x2
    /* 4F014 8005E814 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4F018 8005E818 24004010 */  beqz       $v0, .L8005E8AC
    /* 4F01C 8005E81C 21202002 */   addu      $a0, $s1, $zero
    /* 4F020 8005E820 0000238E */  lw         $v1, 0x0($s1)
    /* 4F024 8005E824 00000000 */  nop
    /* 4F028 8005E828 5005628C */  lw         $v0, 0x550($v1)
    /* 4F02C 8005E82C 21280000 */  addu       $a1, $zero, $zero
    /* 4F030 8005E830 23100200 */  negu       $v0, $v0
    /* 4F034 8005E834 EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4F038 8005E838 500562AC */   sw        $v0, 0x550($v1)
    /* 4F03C 8005E83C 578F020C */  jal        __builtin_new
    /* 4F040 8005E840 08000424 */   addiu     $a0, $zero, 0x8
    /* 4F044 8005E844 0000258E */  lw         $a1, 0x0($s1)
    /* 4F048 8005E848 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 4F04C 8005E84C 21204000 */   addu      $a0, $v0, $zero
    /* 4F050 8005E850 0400238E */  lw         $v1, 0x4($s1)
    /* 4F054 8005E854 00000000 */  nop
    /* 4F058 8005E858 08006010 */  beqz       $v1, .L8005E87C
    /* 4F05C 8005E85C 21804000 */   addu      $s0, $v0, $zero
    /* 4F060 8005E860 0400628C */  lw         $v0, 0x4($v1)
    /* 4F064 8005E864 03000524 */  addiu      $a1, $zero, 0x3
    /* 4F068 8005E868 10004484 */  lh         $a0, 0x10($v0)
    /* 4F06C 8005E86C 1400428C */  lw         $v0, 0x14($v0)
    /* 4F070 8005E870 00000000 */  nop
    /* 4F074 8005E874 09F84000 */  jalr       $v0
    /* 4F078 8005E878 21206400 */   addu      $a0, $v1, $a0
  .L8005E87C:
    /* 4F07C 8005E87C 0000248E */  lw         $a0, 0x0($s1)
    /* 4F080 8005E880 02000224 */  addiu      $v0, $zero, 0x2
    /* 4F084 8005E884 040030AE */  sw         $s0, 0x4($s1)
    /* 4F088 8005E888 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4F08C 8005E88C 080022AE */   sw        $v0, 0x8($s1)
    /* 4F090 8005E890 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4F094 8005E894 00000000 */  nop
    /* 4F098 8005E898 38006484 */  lh         $a0, 0x38($v1)
    /* 4F09C 8005E89C 3C00638C */  lw         $v1, 0x3C($v1)
    /* 4F0A0 8005E8A0 00000000 */  nop
    /* 4F0A4 8005E8A4 09F86000 */  jalr       $v1
    /* 4F0A8 8005E8A8 21204400 */   addu      $a0, $v0, $a0
  .L8005E8AC:
    /* 4F0AC 8005E8AC BE7B010C */  jal        UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
    /* 4F0B0 8005E8B0 21202002 */   addu      $a0, $s1, $zero
    /* 4F0B4 8005E8B4 3B014010 */  beqz       $v0, .L8005EDA4
    /* 4F0B8 8005E8B8 21202002 */   addu      $a0, $s1, $zero
    /* 4F0BC 8005E8BC EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4F0C0 8005E8C0 21280000 */   addu      $a1, $zero, $zero
    /* 4F0C4 8005E8C4 578F020C */  jal        __builtin_new
    /* 4F0C8 8005E8C8 08000424 */   addiu     $a0, $zero, 0x8
    /* 4F0CC 8005E8CC 21904000 */  addu       $s2, $v0, $zero
    /* 4F0D0 8005E8D0 0000308E */  lw         $s0, 0x0($s1)
    /* 4F0D4 8005E8D4 21204002 */  addu       $a0, $s2, $zero
    /* 4F0D8 8005E8D8 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4F0DC 8005E8DC 21280002 */   addu      $a1, $s0, $zero
    /* 4F0E0 8005E8E0 4800A427 */  addiu      $a0, $sp, 0x48
    /* 4F0E4 8005E8E4 21280000 */  addu       $a1, $zero, $zero
    /* 4F0E8 8005E8E8 0C000624 */  addiu      $a2, $zero, 0xC
    /* 4F0EC 8005E8EC 0580023C */  lui        $v0, %hi(D_80054F24)
    /* 4F0F0 8005E8F0 244F4224 */  addiu      $v0, $v0, %lo(D_80054F24)
    /* 4F0F4 8005E8F4 C690030C */  jal        memset
    /* 4F0F8 8005E8F8 040042AE */   sw        $v0, 0x4($s2)
    /* 4F0FC 8005E8FC 21280000 */  addu       $a1, $zero, $zero
    /* 4F100 8005E900 5402038E */  lw         $v1, 0x254($s0)
    /* 4F104 8005E904 4800A627 */  addiu      $a2, $sp, 0x48
    /* 4F108 8005E908 80100300 */  sll        $v0, $v1, 2
    /* 4F10C 8005E90C 21104300 */  addu       $v0, $v0, $v1
    /* 4F110 8005E910 40140200 */  sll        $v0, $v0, 17
    /* 4F114 8005E914 037B0108 */  j          .L8005EC0C
    /* 4F118 8005E918 4C00A2AF */   sw        $v0, 0x4C($sp)
  jlabel .L8005E91C
    /* 4F11C 8005E91C 0000228E */  lw         $v0, 0x0($s1)
    /* 4F120 8005E920 00000000 */  nop
    /* 4F124 8005E924 7005438C */  lw         $v1, 0x570($v0)
    /* 4F128 8005E928 21202002 */  addu       $a0, $s1, $zero
    /* 4F12C 8005E92C 02006334 */  ori        $v1, $v1, 0x2
    /* 4F130 8005E930 2E73010C */  jal        CheckForNewTarget__14AIHigh_BTC_Cop
    /* 4F134 8005E934 700543AC */   sw        $v1, 0x570($v0)
    /* 4F138 8005E938 5800228E */  lw         $v0, 0x58($s1)
    /* 4F13C 8005E93C 00000000 */  nop
    /* 4F140 8005E940 18004014 */  bnez       $v0, .L8005E9A4
    /* 4F144 8005E944 21800000 */   addu      $s0, $zero, $zero
    /* 4F148 8005E948 08000424 */  addiu      $a0, $zero, 0x8
    /* 4F14C 8005E94C 01000224 */  addiu      $v0, $zero, 0x1
    /* 4F150 8005E950 680022AE */  sw         $v0, 0x68($s1)
    /* 4F154 8005E954 578F020C */  jal        __builtin_new
    /* 4F158 8005E958 640022AE */   sw        $v0, 0x64($s1)
    /* 4F15C 8005E95C 0000258E */  lw         $a1, 0x0($s1)
    /* 4F160 8005E960 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 4F164 8005E964 21204000 */   addu      $a0, $v0, $zero
    /* 4F168 8005E968 0400238E */  lw         $v1, 0x4($s1)
    /* 4F16C 8005E96C 00000000 */  nop
    /* 4F170 8005E970 08006010 */  beqz       $v1, .L8005E994
    /* 4F174 8005E974 21804000 */   addu      $s0, $v0, $zero
    /* 4F178 8005E978 0400628C */  lw         $v0, 0x4($v1)
    /* 4F17C 8005E97C 03000524 */  addiu      $a1, $zero, 0x3
    /* 4F180 8005E980 10004484 */  lh         $a0, 0x10($v0)
    /* 4F184 8005E984 1400428C */  lw         $v0, 0x14($v0)
    /* 4F188 8005E988 00000000 */  nop
    /* 4F18C 8005E98C 09F84000 */  jalr       $v0
    /* 4F190 8005E990 21206400 */   addu      $a0, $v1, $a0
  .L8005E994:
    /* 4F194 8005E994 02000224 */  addiu      $v0, $zero, 0x2
    /* 4F198 8005E998 040030AE */  sw         $s0, 0x4($s1)
    /* 4F19C 8005E99C 6C7B0108 */  j          .L8005EDB0
    /* 4F1A0 8005E9A0 080022AE */   sw        $v0, 0x8($s1)
  .L8005E9A4:
    /* 4F1A4 8005E9A4 21202002 */  addu       $a0, $s1, $zero
    /* 4F1A8 8005E9A8 0773010C */  jal        GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
    /* 4F1AC 8005E9AC 2800A527 */   addiu     $a1, $sp, 0x28
    /* 4F1B0 8005E9B0 7000228E */  lw         $v0, 0x70($s1)
    /* 4F1B4 8005E9B4 00000000 */  nop
    /* 4F1B8 8005E9B8 0A004010 */  beqz       $v0, .L8005E9E4
    /* 4F1BC 8005E9BC 1180023C */   lui       $v0, %hi(AICop_spikeBelt)
    /* 4F1C0 8005E9C0 4CD54424 */  addiu      $a0, $v0, %lo(AICop_spikeBelt)
    /* 4F1C4 8005E9C4 0400838C */  lw         $v1, 0x4($a0)
    /* 4F1C8 8005E9C8 7400228E */  lw         $v0, 0x74($s1)
    /* 4F1CC 8005E9CC 00000000 */  nop
    /* 4F1D0 8005E9D0 04006214 */  bne        $v1, $v0, .L8005E9E4
    /* 4F1D4 8005E9D4 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4F1D8 8005E9D8 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4F1DC 8005E9DC 00000000 */  nop
    /* 4F1E0 8005E9E0 100082AC */  sw         $v0, 0x10($a0)
  .L8005E9E4:
    /* 4F1E4 8005E9E4 5800228E */  lw         $v0, 0x58($s1)
    /* 4F1E8 8005E9E8 0000248E */  lw         $a0, 0x0($s1)
    /* 4F1EC 8005E9EC 0000458C */  lw         $a1, 0x0($v0)
    /* 4F1F0 8005E9F0 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4F1F4 8005E9F4 00000000 */   nop
    /* 4F1F8 8005E9F8 3100033C */  lui        $v1, (0x31FFFF >> 16)
    /* 4F1FC 8005E9FC FFFF6334 */  ori        $v1, $v1, (0x31FFFF & 0xFFFF)
    /* 4F200 8005EA00 21204000 */  addu       $a0, $v0, $zero
    /* 4F204 8005EA04 02008104 */  bgez       $a0, .L8005EA10
    /* 4F208 8005EA08 21288000 */   addu      $a1, $a0, $zero
    /* 4F20C 8005EA0C 23280500 */  negu       $a1, $a1
  .L8005EA10:
    /* 4F210 8005EA10 2A186500 */  slt        $v1, $v1, $a1
    /* 4F214 8005EA14 21006010 */  beqz       $v1, .L8005EA9C
    /* 4F218 8005EA18 2B01023C */   lui       $v0, (0x12BFFFF >> 16)
    /* 4F21C 8005EA1C FFFF4234 */  ori        $v0, $v0, (0x12BFFFF & 0xFFFF)
    /* 4F220 8005EA20 2A104500 */  slt        $v0, $v0, $a1
    /* 4F224 8005EA24 1E004014 */  bnez       $v0, .L8005EAA0
    /* 4F228 8005EA28 00000000 */   nop
    /* 4F22C 8005EA2C 5800228E */  lw         $v0, 0x58($s1)
    /* 4F230 8005EA30 00000000 */  nop
    /* 4F234 8005EA34 0000428C */  lw         $v0, 0x0($v0)
    /* 4F238 8005EA38 00000000 */  nop
    /* 4F23C 8005EA3C 6405438C */  lw         $v1, 0x564($v0)
    /* 4F240 8005EA40 00000000 */  nop
    /* 4F244 8005EA44 0200601C */  bgtz       $v1, .L8005EA50
    /* 4F248 8005EA48 0400023C */   lui       $v0, (0x471C7 >> 16)
    /* 4F24C 8005EA4C 23180300 */  negu       $v1, $v1
  .L8005EA50:
    /* 4F250 8005EA50 C7714234 */  ori        $v0, $v0, (0x471C7 & 0xFFFF)
    /* 4F254 8005EA54 2A184300 */  slt        $v1, $v0, $v1
    /* 4F258 8005EA58 11006010 */  beqz       $v1, .L8005EAA0
    /* 4F25C 8005EA5C 00000000 */   nop
    /* 4F260 8005EA60 5800228E */  lw         $v0, 0x58($s1)
    /* 4F264 8005EA64 00000000 */  nop
    /* 4F268 8005EA68 0000428C */  lw         $v0, 0x0($v0)
    /* 4F26C 8005EA6C 00000000 */  nop
    /* 4F270 8005EA70 6405458C */  lw         $a1, 0x564($v0)
    /* 4F274 8005EA74 0191030C */  jal        rdiv
    /* 4F278 8005EA78 00000000 */   nop
    /* 4F27C 8005EA7C 21184000 */  addu       $v1, $v0, $zero
    /* 4F280 8005EA80 07006018 */  blez       $v1, .L8005EAA0
    /* 4F284 8005EA84 00000000 */   nop
    /* 4F288 8005EA88 7800228E */  lw         $v0, 0x78($s1)
    /* 4F28C 8005EA8C 00000000 */  nop
    /* 4F290 8005EA90 2A106200 */  slt        $v0, $v1, $v0
    /* 4F294 8005EA94 02004010 */  beqz       $v0, .L8005EAA0
    /* 4F298 8005EA98 00000000 */   nop
  .L8005EA9C:
    /* 4F29C 8005EA9C 01001024 */  addiu      $s0, $zero, 0x1
  .L8005EAA0:
    /* 4F2A0 8005EAA0 25000012 */  beqz       $s0, .L8005EB38
    /* 4F2A4 8005EAA4 01000224 */   addiu     $v0, $zero, 0x1
    /* 4F2A8 8005EAA8 94000424 */  addiu      $a0, $zero, 0x94
    /* 4F2AC 8005EAAC 700020AE */  sw         $zero, 0x70($s1)
    /* 4F2B0 8005EAB0 680022AE */  sw         $v0, 0x68($s1)
    /* 4F2B4 8005EAB4 578F020C */  jal        __builtin_new
    /* 4F2B8 8005EAB8 640022AE */   sw        $v0, 0x64($s1)
    /* 4F2BC 8005EABC 21204000 */  addu       $a0, $v0, $zero
    /* 4F2C0 8005EAC0 5800228E */  lw         $v0, 0x58($s1)
    /* 4F2C4 8005EAC4 00000000 */  nop
    /* 4F2C8 8005EAC8 0000468C */  lw         $a2, 0x0($v0)
    /* 4F2CC 8005EACC 00020224 */  addiu      $v0, $zero, 0x200
    /* 4F2D0 8005EAD0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4F2D4 8005EAD4 3C00023C */  lui        $v0, (0x3C0000 >> 16)
    /* 4F2D8 8005EAD8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 4F2DC 8005EADC 1900023C */  lui        $v0, (0x190000 >> 16)
    /* 4F2E0 8005EAE0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 4F2E4 8005EAE4 02000224 */  addiu      $v0, $zero, 0x2
    /* 4F2E8 8005EAE8 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 4F2EC 8005EAEC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 4F2F0 8005EAF0 2000A2AF */  sw         $v0, 0x20($sp)
    /* 4F2F4 8005EAF4 0000258E */  lw         $a1, 0x0($s1)
    /* 4F2F8 8005EAF8 FFBE010C */  jal        __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
    /* 4F2FC 8005EAFC 2800A727 */   addiu     $a3, $sp, 0x28
    /* 4F300 8005EB00 0400238E */  lw         $v1, 0x4($s1)
    /* 4F304 8005EB04 00000000 */  nop
    /* 4F308 8005EB08 08006010 */  beqz       $v1, .L8005EB2C
    /* 4F30C 8005EB0C 21804000 */   addu      $s0, $v0, $zero
    /* 4F310 8005EB10 0400628C */  lw         $v0, 0x4($v1)
    /* 4F314 8005EB14 03000524 */  addiu      $a1, $zero, 0x3
    /* 4F318 8005EB18 10004484 */  lh         $a0, 0x10($v0)
    /* 4F31C 8005EB1C 1400428C */  lw         $v0, 0x14($v0)
    /* 4F320 8005EB20 00000000 */  nop
    /* 4F324 8005EB24 09F84000 */  jalr       $v0
    /* 4F328 8005EB28 21206400 */   addu      $a0, $v1, $a0
  .L8005EB2C:
    /* 4F32C 8005EB2C 04000224 */  addiu      $v0, $zero, 0x4
    /* 4F330 8005EB30 040030AE */  sw         $s0, 0x4($s1)
    /* 4F334 8005EB34 080022AE */  sw         $v0, 0x8($s1)
  .L8005EB38:
    /* 4F338 8005EB38 6800238E */  lw         $v1, 0x68($s1)
    /* 4F33C 8005EB3C 6400228E */  lw         $v0, 0x64($s1)
    /* 4F340 8005EB40 00000000 */  nop
    /* 4F344 8005EB44 16006210 */  beq        $v1, $v0, .L8005EBA0
    /* 4F348 8005EB48 01000224 */   addiu     $v0, $zero, 0x1
    /* 4F34C 8005EB4C 14006214 */  bne        $v1, $v0, .L8005EBA0
    /* 4F350 8005EB50 08000424 */   addiu     $a0, $zero, 0x8
    /* 4F354 8005EB54 578F020C */  jal        __builtin_new
    /* 4F358 8005EB58 640023AE */   sw        $v1, 0x64($s1)
    /* 4F35C 8005EB5C 0000258E */  lw         $a1, 0x0($s1)
    /* 4F360 8005EB60 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 4F364 8005EB64 21204000 */   addu      $a0, $v0, $zero
    /* 4F368 8005EB68 0400238E */  lw         $v1, 0x4($s1)
    /* 4F36C 8005EB6C 00000000 */  nop
    /* 4F370 8005EB70 08006010 */  beqz       $v1, .L8005EB94
    /* 4F374 8005EB74 21804000 */   addu      $s0, $v0, $zero
    /* 4F378 8005EB78 0400628C */  lw         $v0, 0x4($v1)
    /* 4F37C 8005EB7C 03000524 */  addiu      $a1, $zero, 0x3
    /* 4F380 8005EB80 10004484 */  lh         $a0, 0x10($v0)
    /* 4F384 8005EB84 1400428C */  lw         $v0, 0x14($v0)
    /* 4F388 8005EB88 00000000 */  nop
    /* 4F38C 8005EB8C 09F84000 */  jalr       $v0
    /* 4F390 8005EB90 21206400 */   addu      $a0, $v1, $a0
  .L8005EB94:
    /* 4F394 8005EB94 02000224 */  addiu      $v0, $zero, 0x2
    /* 4F398 8005EB98 040030AE */  sw         $s0, 0x4($s1)
    /* 4F39C 8005EB9C 080022AE */  sw         $v0, 0x8($s1)
  .L8005EBA0:
    /* 4F3A0 8005EBA0 BE7B010C */  jal        UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
    /* 4F3A4 8005EBA4 21202002 */   addu      $a0, $s1, $zero
    /* 4F3A8 8005EBA8 7E004010 */  beqz       $v0, .L8005EDA4
    /* 4F3AC 8005EBAC 21202002 */   addu      $a0, $s1, $zero
    /* 4F3B0 8005EBB0 EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4F3B4 8005EBB4 21280000 */   addu      $a1, $zero, $zero
    /* 4F3B8 8005EBB8 578F020C */  jal        __builtin_new
    /* 4F3BC 8005EBBC 08000424 */   addiu     $a0, $zero, 0x8
    /* 4F3C0 8005EBC0 21904000 */  addu       $s2, $v0, $zero
    /* 4F3C4 8005EBC4 0000308E */  lw         $s0, 0x0($s1)
    /* 4F3C8 8005EBC8 21204002 */  addu       $a0, $s2, $zero
    /* 4F3CC 8005EBCC 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4F3D0 8005EBD0 21280002 */   addu      $a1, $s0, $zero
    /* 4F3D4 8005EBD4 3800A427 */  addiu      $a0, $sp, 0x38
    /* 4F3D8 8005EBD8 21280000 */  addu       $a1, $zero, $zero
    /* 4F3DC 8005EBDC 0C000624 */  addiu      $a2, $zero, 0xC
    /* 4F3E0 8005EBE0 0580023C */  lui        $v0, %hi(D_80054F24)
    /* 4F3E4 8005EBE4 244F4224 */  addiu      $v0, $v0, %lo(D_80054F24)
    /* 4F3E8 8005EBE8 C690030C */  jal        memset
    /* 4F3EC 8005EBEC 040042AE */   sw        $v0, 0x4($s2)
    /* 4F3F0 8005EBF0 21280000 */  addu       $a1, $zero, $zero
    /* 4F3F4 8005EBF4 5402038E */  lw         $v1, 0x254($s0)
    /* 4F3F8 8005EBF8 3800A627 */  addiu      $a2, $sp, 0x38
    /* 4F3FC 8005EBFC 80100300 */  sll        $v0, $v1, 2
    /* 4F400 8005EC00 21104300 */  addu       $v0, $v0, $v1
    /* 4F404 8005EC04 40140200 */  sll        $v0, $v0, 17
    /* 4F408 8005EC08 3C00A2AF */  sw         $v0, 0x3C($sp)
  .L8005EC0C:
    /* 4F40C 8005EC0C 0000448E */  lw         $a0, 0x0($s2)
    /* 4F410 8005EC10 E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 4F414 8005EC14 01000724 */   addiu     $a3, $zero, 0x1
    /* 4F418 8005EC18 0000428E */  lw         $v0, 0x0($s2)
    /* 4F41C 8005EC1C 00000000 */  nop
    /* 4F420 8005EC20 910040A0 */  sb         $zero, 0x91($v0)
    /* 4F424 8005EC24 0400238E */  lw         $v1, 0x4($s1)
    /* 4F428 8005EC28 00000000 */  nop
    /* 4F42C 8005EC2C 08006010 */  beqz       $v1, .L8005EC50
    /* 4F430 8005EC30 03000524 */   addiu     $a1, $zero, 0x3
    /* 4F434 8005EC34 0400628C */  lw         $v0, 0x4($v1)
    /* 4F438 8005EC38 00000000 */  nop
    /* 4F43C 8005EC3C 10004484 */  lh         $a0, 0x10($v0)
    /* 4F440 8005EC40 1400428C */  lw         $v0, 0x14($v0)
    /* 4F444 8005EC44 00000000 */  nop
    /* 4F448 8005EC48 09F84000 */  jalr       $v0
    /* 4F44C 8005EC4C 21206400 */   addu      $a0, $v1, $a0
  .L8005EC50:
    /* 4F450 8005EC50 07000224 */  addiu      $v0, $zero, 0x7
    /* 4F454 8005EC54 040032AE */  sw         $s2, 0x4($s1)
    /* 4F458 8005EC58 080022AE */  sw         $v0, 0x8($s1)
    /* 4F45C 8005EC5C 680020AE */  sw         $zero, 0x68($s1)
    /* 4F460 8005EC60 697B0108 */  j          .L8005EDA4
    /* 4F464 8005EC64 640020AE */   sw        $zero, 0x64($s1)
  jlabel .L8005EC68
    /* 4F468 8005EC68 0000248E */  lw         $a0, 0x0($s1)
    /* 4F46C 8005EC6C 00000000 */  nop
    /* 4F470 8005EC70 7005828C */  lw         $v0, 0x570($a0)
    /* 4F474 8005EC74 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* 4F478 8005EC78 24104300 */  and        $v0, $v0, $v1
    /* 4F47C 8005EC7C 700582AC */  sw         $v0, 0x570($a0)
    /* 4F480 8005EC80 6400228E */  lw         $v0, 0x64($s1)
    /* 4F484 8005EC84 6800238E */  lw         $v1, 0x68($s1)
    /* 4F488 8005EC88 00000000 */  nop
    /* 4F48C 8005EC8C 45004310 */  beq        $v0, $v1, .L8005EDA4
    /* 4F490 8005EC90 01001224 */   addiu     $s2, $zero, 0x1
    /* 4F494 8005EC94 07007214 */  bne        $v1, $s2, .L8005ECB4
    /* 4F498 8005EC98 FEFF6224 */   addiu     $v0, $v1, -0x2
    /* 4F49C 8005EC9C 6C00258E */  lw         $a1, 0x6C($s1)
    /* 4F4A0 8005ECA0 21202002 */  addu       $a0, $s1, $zero
    /* 4F4A4 8005ECA4 CE7B010C */  jal        SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
    /* 4F4A8 8005ECA8 640032AE */   sw        $s2, 0x64($s1)
    /* 4F4AC 8005ECAC 567B0108 */  j          .L8005ED58
    /* 4F4B0 8005ECB0 00000000 */   nop
  .L8005ECB4:
    /* 4F4B4 8005ECB4 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4F4B8 8005ECB8 3A004010 */  beqz       $v0, .L8005EDA4
    /* 4F4BC 8005ECBC 21202002 */   addu      $a0, $s1, $zero
    /* 4F4C0 8005ECC0 6C00258E */  lw         $a1, 0x6C($s1)
    /* 4F4C4 8005ECC4 6800268E */  lw         $a2, 0x68($s1)
    /* 4F4C8 8005ECC8 640023AE */  sw         $v1, 0x64($s1)
    /* 4F4CC 8005ECCC 0300C638 */  xori       $a2, $a2, 0x3
    /* 4F4D0 8005ECD0 1D7C010C */  jal        SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
    /* 4F4D4 8005ECD4 0100C62C */   sltiu     $a2, $a2, 0x1
    /* 4F4D8 8005ECD8 578F020C */  jal        __builtin_new
    /* 4F4DC 8005ECDC 10000424 */   addiu     $a0, $zero, 0x10
    /* 4F4E0 8005ECE0 21804000 */  addu       $s0, $v0, $zero
    /* 4F4E4 8005ECE4 0000258E */  lw         $a1, 0x0($s1)
    /* 4F4E8 8005ECE8 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 4F4EC 8005ECEC 21200002 */   addu      $a0, $s0, $zero
    /* 4F4F0 8005ECF0 0580023C */  lui        $v0, %hi(_vt_12AIState_Idle)
    /* 4F4F4 8005ECF4 00564224 */  addiu      $v0, $v0, %lo(_vt_12AIState_Idle)
    /* 4F4F8 8005ECF8 040002AE */  sw         $v0, 0x4($s0)
    /* 4F4FC 8005ECFC 0C0012AE */  sw         $s2, 0xC($s0)
    /* 4F500 8005ED00 0400238E */  lw         $v1, 0x4($s1)
    /* 4F504 8005ED04 00000000 */  nop
    /* 4F508 8005ED08 08006010 */  beqz       $v1, .L8005ED2C
    /* 4F50C 8005ED0C 03000524 */   addiu     $a1, $zero, 0x3
    /* 4F510 8005ED10 0400628C */  lw         $v0, 0x4($v1)
    /* 4F514 8005ED14 00000000 */  nop
    /* 4F518 8005ED18 10004484 */  lh         $a0, 0x10($v0)
    /* 4F51C 8005ED1C 1400428C */  lw         $v0, 0x14($v0)
    /* 4F520 8005ED20 00000000 */  nop
    /* 4F524 8005ED24 09F84000 */  jalr       $v0
    /* 4F528 8005ED28 21206400 */   addu      $a0, $v1, $a0
  .L8005ED2C:
    /* 4F52C 8005ED2C 677B0108 */  j          .L8005ED9C
    /* 4F530 8005ED30 03000224 */   addiu     $v0, $zero, 0x3
  jlabel .L8005ED34
    /* 4F534 8005ED34 21202002 */  addu       $a0, $s1, $zero
    /* 4F538 8005ED38 0400308E */  lw         $s0, 0x4($s1)
    /* 4F53C 8005ED3C EB72010C */  jal        AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4F540 8005ED40 21280000 */   addu      $a1, $zero, $zero
    /* 4F544 8005ED44 0A00053C */  lui        $a1, (0xA0000 >> 16)
    /* 4F548 8005ED48 36C9010C */  jal        InTargetSliceRange__17AIState_GotoSlicei
    /* 4F54C 8005ED4C 21200002 */   addu      $a0, $s0, $zero
    /* 4F550 8005ED50 14004010 */  beqz       $v0, .L8005EDA4
    /* 4F554 8005ED54 00000000 */   nop
  .L8005ED58:
    /* 4F558 8005ED58 578F020C */  jal        __builtin_new
    /* 4F55C 8005ED5C 08000424 */   addiu     $a0, $zero, 0x8
    /* 4F560 8005ED60 0000258E */  lw         $a1, 0x0($s1)
    /* 4F564 8005ED64 B7BE010C */  jal        __14AIState_NormalP8Car_tObj
    /* 4F568 8005ED68 21204000 */   addu      $a0, $v0, $zero
    /* 4F56C 8005ED6C 0400238E */  lw         $v1, 0x4($s1)
    /* 4F570 8005ED70 00000000 */  nop
    /* 4F574 8005ED74 08006010 */  beqz       $v1, .L8005ED98
    /* 4F578 8005ED78 21804000 */   addu      $s0, $v0, $zero
    /* 4F57C 8005ED7C 0400628C */  lw         $v0, 0x4($v1)
    /* 4F580 8005ED80 03000524 */  addiu      $a1, $zero, 0x3
    /* 4F584 8005ED84 10004484 */  lh         $a0, 0x10($v0)
    /* 4F588 8005ED88 1400428C */  lw         $v0, 0x14($v0)
    /* 4F58C 8005ED8C 00000000 */  nop
    /* 4F590 8005ED90 09F84000 */  jalr       $v0
    /* 4F594 8005ED94 21206400 */   addu      $a0, $v1, $a0
  .L8005ED98:
    /* 4F598 8005ED98 02000224 */  addiu      $v0, $zero, 0x2
  .L8005ED9C:
    /* 4F59C 8005ED9C 040030AE */  sw         $s0, 0x4($s1)
  .L8005EDA0:
    /* 4F5A0 8005EDA0 080022AE */  sw         $v0, 0x8($s1)
  jlabel .L8005EDA4
    /* 4F5A4 8005EDA4 0400248E */  lw         $a0, 0x4($s1)
    /* 4F5A8 8005EDA8 7BBE010C */  jal        StateExecute__12AIState_Base
    /* 4F5AC 8005EDAC 00000000 */   nop
  .L8005EDB0:
    /* 4F5B0 8005EDB0 6400BF8F */  lw         $ra, 0x64($sp)
    /* 4F5B4 8005EDB4 6000B28F */  lw         $s2, 0x60($sp)
    /* 4F5B8 8005EDB8 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 4F5BC 8005EDBC 5800B08F */  lw         $s0, 0x58($sp)
    /* 4F5C0 8005EDC0 0800E003 */  jr         $ra
    /* 4F5C4 8005EDC4 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel HighExecute__18AIHigh_BTC_Wingman
