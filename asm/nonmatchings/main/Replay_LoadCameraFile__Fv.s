.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_LoadCameraFile__Fv, 0x36C

glabel Replay_LoadCameraFile__Fv
    /* A5D00 800B5500 A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A5D04 800B5504 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* A5D08 800B5508 8C00BFAF */  sw         $ra, 0x8C($sp)
    /* A5D0C 800B550C D3004014 */  bnez       $v0, .L800B585C
    /* A5D10 800B5510 8800B0AF */   sw        $s0, 0x88($sp)
    /* A5D14 800B5514 1000A427 */  addiu      $a0, $sp, 0x10
    /* A5D18 800B5518 1180023C */  lui        $v0, %hi(D_80116488)
    /* A5D1C 800B551C 0580053C */  lui        $a1, %hi(D_8005654C)
    /* A5D20 800B5520 8864468C */  lw         $a2, %lo(D_80116488)($v0)
    /* A5D24 800B5524 4C65A524 */  addiu      $a1, $a1, %lo(D_8005654C)
    /* A5D28 800B5528 2F91030C */  jal        sprintf
    /* A5D2C 800B552C 8000A0AF */   sw        $zero, 0x80($sp)
    /* A5D30 800B5530 1000A427 */  addiu      $a0, $sp, 0x10
    /* A5D34 800B5534 10000524 */  addiu      $a1, $zero, 0x10
    /* A5D38 800B5538 64000624 */  addiu      $a2, $zero, 0x64
    /* A5D3C 800B553C 7EAA030C */  jal        FILE_addbigsync
    /* A5D40 800B5540 8000A727 */   addiu     $a3, $sp, 0x80
    /* A5D44 800B5544 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A5D48 800B5548 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* A5D4C 800B554C 3000628C */  lw         $v0, 0x30($v1)
    /* A5D50 800B5550 00000000 */  nop
    /* A5D54 800B5554 05004010 */  beqz       $v0, .L800B556C
    /* A5D58 800B5558 1000A427 */   addiu     $a0, $sp, 0x10
    /* A5D5C 800B555C 3C00668C */  lw         $a2, 0x3C($v1)
    /* A5D60 800B5560 0580053C */  lui        $a1, %hi(D_8005655C)
    /* A5D64 800B5564 5ED50208 */  j          .L800B5578
    /* A5D68 800B5568 5C65A524 */   addiu     $a1, $a1, %lo(D_8005655C)
  .L800B556C:
    /* A5D6C 800B556C 3C00668C */  lw         $a2, 0x3C($v1)
    /* A5D70 800B5570 0580053C */  lui        $a1, %hi(D_80056568)
    /* A5D74 800B5574 6865A524 */  addiu      $a1, $a1, %lo(D_80056568)
  .L800B5578:
    /* A5D78 800B5578 2F91030C */  jal        sprintf
    /* A5D7C 800B557C 00000000 */   nop
    /* A5D80 800B5580 1000A427 */  addiu      $a0, $sp, 0x10
    /* A5D84 800B5584 EA95030C */  jal        loadfileadrz
    /* A5D88 800B5588 21280000 */   addu      $a1, $zero, $zero
    /* A5D8C 800B558C 64000524 */  addiu      $a1, $zero, 0x64
    /* A5D90 800B5590 8000A48F */  lw         $a0, 0x80($sp)
    /* A5D94 800B5594 A40E80AF */  sw         $zero, %gp_rel(numValidCams)($gp)
    /* A5D98 800B5598 9CAA030C */  jal        FILE_delbigsync
    /* A5D9C 800B559C 21804000 */   addu      $s0, $v0, $zero
    /* A5DA0 800B55A0 21200000 */  addu       $a0, $zero, $zero
    /* A5DA4 800B55A4 02000724 */  addiu      $a3, $zero, 0x2
    /* A5DA8 800B55A8 FFF90624 */  addiu      $a2, $zero, -0x601
    /* A5DAC 800B55AC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* A5DB0 800B55B0 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A5DB4 800B55B4 DCDB4324 */  addiu      $v1, $v0, %lo(gReplayCameraSlots)
  .L800B55B8:
    /* A5DB8 800B55B8 000067A0 */  sb         $a3, 0x0($v1)
    /* A5DBC 800B55BC 0000628C */  lw         $v0, 0x0($v1)
    /* A5DC0 800B55C0 01008424 */  addiu      $a0, $a0, 0x1
    /* A5DC4 800B55C4 1E0065A4 */  sh         $a1, 0x1E($v1)
    /* A5DC8 800B55C8 24104600 */  and        $v0, $v0, $a2
    /* A5DCC 800B55CC 000062AC */  sw         $v0, 0x0($v1)
    /* A5DD0 800B55D0 20008228 */  slti       $v0, $a0, 0x20
    /* A5DD4 800B55D4 F8FF4014 */  bnez       $v0, .L800B55B8
    /* A5DD8 800B55D8 20006324 */   addiu     $v1, $v1, 0x20
    /* A5DDC 800B55DC 9F000012 */  beqz       $s0, .L800B585C
    /* A5DE0 800B55E0 1280023C */   lui       $v0, %hi(gReplayCameraSlots)
    /* A5DE4 800B55E4 DCDB4224 */  addiu      $v0, $v0, %lo(gReplayCameraSlots)
    /* A5DE8 800B55E8 21180002 */  addu       $v1, $s0, $zero
    /* A5DEC 800B55EC 00040426 */  addiu      $a0, $s0, 0x400
  .L800B55F0:
    /* A5DF0 800B55F0 00006B8C */  lw         $t3, 0x0($v1)
    /* A5DF4 800B55F4 04006C8C */  lw         $t4, 0x4($v1)
    /* A5DF8 800B55F8 08006D8C */  lw         $t5, 0x8($v1)
    /* A5DFC 800B55FC 0C006E8C */  lw         $t6, 0xC($v1)
    /* A5E00 800B5600 00004BAC */  sw         $t3, 0x0($v0)
    /* A5E04 800B5604 04004CAC */  sw         $t4, 0x4($v0)
    /* A5E08 800B5608 08004DAC */  sw         $t5, 0x8($v0)
    /* A5E0C 800B560C 0C004EAC */  sw         $t6, 0xC($v0)
    /* A5E10 800B5610 10006324 */  addiu      $v1, $v1, 0x10
    /* A5E14 800B5614 F6FF6414 */  bne        $v1, $a0, .L800B55F0
    /* A5E18 800B5618 10004224 */   addiu     $v0, $v0, 0x10
    /* A5E1C 800B561C 21380000 */  addu       $a3, $zero, $zero
    /* A5E20 800B5620 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* A5E24 800B5624 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A5E28 800B5628 DCDB4324 */  addiu      $v1, $v0, %lo(gReplayCameraSlots)
  .L800B562C:
    /* A5E2C 800B562C 02006284 */  lh         $v0, 0x2($v1)
    /* A5E30 800B5630 00000000 */  nop
    /* A5E34 800B5634 07004010 */  beqz       $v0, .L800B5654
    /* A5E38 800B5638 00000000 */   nop
    /* A5E3C 800B563C A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A5E40 800B5640 00000000 */  nop
    /* A5E44 800B5644 01004224 */  addiu      $v0, $v0, 0x1
    /* A5E48 800B5648 A40E82AF */  sw         $v0, %gp_rel(numValidCams)($gp)
    /* A5E4C 800B564C 97D50208 */  j          .L800B565C
    /* A5E50 800B5650 20006324 */   addiu     $v1, $v1, 0x20
  .L800B5654:
    /* A5E54 800B5654 1E0064A4 */  sh         $a0, 0x1E($v1)
    /* A5E58 800B5658 20006324 */  addiu      $v1, $v1, 0x20
  .L800B565C:
    /* A5E5C 800B565C 0100E724 */  addiu      $a3, $a3, 0x1
    /* A5E60 800B5660 2000E228 */  slti       $v0, $a3, 0x20
    /* A5E64 800B5664 F1FF4014 */  bnez       $v0, .L800B562C
    /* A5E68 800B5668 00000000 */   nop
    /* A5E6C 800B566C 5095030C */  jal        purgememadr
    /* A5E70 800B5670 21200002 */   addu      $a0, $s0, $zero
    /* A5E74 800B5674 21480000 */  addu       $t1, $zero, $zero
    /* A5E78 800B5678 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A5E7C 800B567C DCDB4A24 */  addiu      $t2, $v0, %lo(gReplayCameraSlots)
  .L800B5680:
    /* A5E80 800B5680 1F002229 */  slti       $v0, $t1, 0x1F
    /* A5E84 800B5684 46004010 */  beqz       $v0, .L800B57A0
    /* A5E88 800B5688 21380000 */   addu      $a3, $zero, $zero
    /* A5E8C 800B568C 21284001 */  addu       $a1, $t2, $zero
    /* A5E90 800B5690 20000824 */  addiu      $t0, $zero, 0x20
  .L800B5694:
    /* A5E94 800B5694 1F00E228 */  slti       $v0, $a3, 0x1F
    /* A5E98 800B5698 3F004010 */  beqz       $v0, .L800B5798
    /* A5E9C 800B569C 21300A01 */   addu      $a2, $t0, $t2
    /* A5EA0 800B56A0 1E00A384 */  lh         $v1, 0x1E($a1)
    /* A5EA4 800B56A4 1E00C484 */  lh         $a0, 0x1E($a2)
    /* A5EA8 800B56A8 00000000 */  nop
    /* A5EAC 800B56AC 2A108300 */  slt        $v0, $a0, $v1
    /* A5EB0 800B56B0 03004014 */  bnez       $v0, .L800B56C0
    /* A5EB4 800B56B4 00000000 */   nop
    /* A5EB8 800B56B8 33006104 */  bgez       $v1, .L800B5788
    /* A5EBC 800B56BC 00000000 */   nop
  .L800B56C0:
    /* A5EC0 800B56C0 31008004 */  bltz       $a0, .L800B5788
    /* A5EC4 800B56C4 00000000 */   nop
    /* A5EC8 800B56C8 0000AB8C */  lw         $t3, 0x0($a1)
    /* A5ECC 800B56CC 0400AC8C */  lw         $t4, 0x4($a1)
    /* A5ED0 800B56D0 0800AD8C */  lw         $t5, 0x8($a1)
    /* A5ED4 800B56D4 0C00AE8C */  lw         $t6, 0xC($a1)
    /* A5ED8 800B56D8 6000ABAF */  sw         $t3, 0x60($sp)
    /* A5EDC 800B56DC 6400ACAF */  sw         $t4, 0x64($sp)
    /* A5EE0 800B56E0 6800ADAF */  sw         $t5, 0x68($sp)
    /* A5EE4 800B56E4 6C00AEAF */  sw         $t6, 0x6C($sp)
    /* A5EE8 800B56E8 1000AB8C */  lw         $t3, 0x10($a1)
    /* A5EEC 800B56EC 1400AC8C */  lw         $t4, 0x14($a1)
    /* A5EF0 800B56F0 1800AD8C */  lw         $t5, 0x18($a1)
    /* A5EF4 800B56F4 1C00AE8C */  lw         $t6, 0x1C($a1)
    /* A5EF8 800B56F8 7000ABAF */  sw         $t3, 0x70($sp)
    /* A5EFC 800B56FC 7400ACAF */  sw         $t4, 0x74($sp)
    /* A5F00 800B5700 7800ADAF */  sw         $t5, 0x78($sp)
    /* A5F04 800B5704 7C00AEAF */  sw         $t6, 0x7C($sp)
    /* A5F08 800B5708 0000CB8C */  lw         $t3, 0x0($a2)
    /* A5F0C 800B570C 0400CC8C */  lw         $t4, 0x4($a2)
    /* A5F10 800B5710 0800CD8C */  lw         $t5, 0x8($a2)
    /* A5F14 800B5714 0C00CE8C */  lw         $t6, 0xC($a2)
    /* A5F18 800B5718 0000ABAC */  sw         $t3, 0x0($a1)
    /* A5F1C 800B571C 0400ACAC */  sw         $t4, 0x4($a1)
    /* A5F20 800B5720 0800ADAC */  sw         $t5, 0x8($a1)
    /* A5F24 800B5724 0C00AEAC */  sw         $t6, 0xC($a1)
    /* A5F28 800B5728 1000CB8C */  lw         $t3, 0x10($a2)
    /* A5F2C 800B572C 1400CC8C */  lw         $t4, 0x14($a2)
    /* A5F30 800B5730 1800CD8C */  lw         $t5, 0x18($a2)
    /* A5F34 800B5734 1C00CE8C */  lw         $t6, 0x1C($a2)
    /* A5F38 800B5738 1000ABAC */  sw         $t3, 0x10($a1)
    /* A5F3C 800B573C 1400ACAC */  sw         $t4, 0x14($a1)
    /* A5F40 800B5740 1800ADAC */  sw         $t5, 0x18($a1)
    /* A5F44 800B5744 1C00AEAC */  sw         $t6, 0x1C($a1)
    /* A5F48 800B5748 6000AB8F */  lw         $t3, 0x60($sp)
    /* A5F4C 800B574C 6400AC8F */  lw         $t4, 0x64($sp)
    /* A5F50 800B5750 6800AD8F */  lw         $t5, 0x68($sp)
    /* A5F54 800B5754 6C00AE8F */  lw         $t6, 0x6C($sp)
    /* A5F58 800B5758 0000CBAC */  sw         $t3, 0x0($a2)
    /* A5F5C 800B575C 0400CCAC */  sw         $t4, 0x4($a2)
    /* A5F60 800B5760 0800CDAC */  sw         $t5, 0x8($a2)
    /* A5F64 800B5764 0C00CEAC */  sw         $t6, 0xC($a2)
    /* A5F68 800B5768 7000AB8F */  lw         $t3, 0x70($sp)
    /* A5F6C 800B576C 7400AC8F */  lw         $t4, 0x74($sp)
    /* A5F70 800B5770 7800AD8F */  lw         $t5, 0x78($sp)
    /* A5F74 800B5774 7C00AE8F */  lw         $t6, 0x7C($sp)
    /* A5F78 800B5778 1000CBAC */  sw         $t3, 0x10($a2)
    /* A5F7C 800B577C 1400CCAC */  sw         $t4, 0x14($a2)
    /* A5F80 800B5780 1800CDAC */  sw         $t5, 0x18($a2)
    /* A5F84 800B5784 1C00CEAC */  sw         $t6, 0x1C($a2)
  .L800B5788:
    /* A5F88 800B5788 2000A524 */  addiu      $a1, $a1, 0x20
    /* A5F8C 800B578C 20000825 */  addiu      $t0, $t0, 0x20
    /* A5F90 800B5790 A5D50208 */  j          .L800B5694
    /* A5F94 800B5794 0100E724 */   addiu     $a3, $a3, 0x1
  .L800B5798:
    /* A5F98 800B5798 A0D50208 */  j          .L800B5680
    /* A5F9C 800B579C 01002925 */   addiu     $t1, $t1, 0x1
  .L800B57A0:
    /* A5FA0 800B57A0 1180023C */  lui        $v0, %hi(D_8011321C)
    /* A5FA4 800B57A4 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* A5FA8 800B57A8 00000000 */  nop
    /* A5FAC 800B57AC 18004010 */  beqz       $v0, .L800B5810
    /* A5FB0 800B57B0 00000000 */   nop
    /* A5FB4 800B57B4 A40E828F */  lw         $v0, %gp_rel(numValidCams)($gp)
    /* A5FB8 800B57B8 00000000 */  nop
    /* A5FBC 800B57BC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A5FC0 800B57C0 21384000 */  addu       $a3, $v0, $zero
    /* A5FC4 800B57C4 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A5FC8 800B57C8 DCDB4424 */  addiu      $a0, $v0, %lo(gReplayCameraSlots)
    /* A5FCC 800B57CC 40110700 */  sll        $v0, $a3, 5
    /* A5FD0 800B57D0 21184400 */  addu       $v1, $v0, $a0
    /* A5FD4 800B57D4 1E006684 */  lh         $a2, 0x1E($v1)
    /* A5FD8 800B57D8 0D00E004 */  bltz       $a3, .L800B5810
    /* A5FDC 800B57DC 21288000 */   addu      $a1, $a0, $zero
    /* A5FE0 800B57E0 E0FF4424 */  addiu      $a0, $v0, -0x20
  .L800B57E4:
    /* A5FE4 800B57E4 0300E014 */  bnez       $a3, .L800B57F4
    /* A5FE8 800B57E8 21108500 */   addu      $v0, $a0, $a1
    /* A5FEC 800B57EC 00D60208 */  j          .L800B5800
    /* A5FF0 800B57F0 1E00A6A4 */   sh        $a2, 0x1E($a1)
  .L800B57F4:
    /* A5FF4 800B57F4 1E004294 */  lhu        $v0, 0x1E($v0)
    /* A5FF8 800B57F8 00000000 */  nop
    /* A5FFC 800B57FC 1E0062A4 */  sh         $v0, 0x1E($v1)
  .L800B5800:
    /* A6000 800B5800 E0FF8424 */  addiu      $a0, $a0, -0x20
    /* A6004 800B5804 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* A6008 800B5808 F6FFE104 */  bgez       $a3, .L800B57E4
    /* A600C 800B580C E0FF6324 */   addiu     $v1, $v1, -0x20
  .L800B5810:
    /* A6010 800B5810 A40E858F */  lw         $a1, %gp_rel(numValidCams)($gp)
    /* A6014 800B5814 00000000 */  nop
    /* A6018 800B5818 1000A018 */  blez       $a1, .L800B585C
    /* A601C 800B581C 21380000 */   addu      $a3, $zero, $zero
    /* A6020 800B5820 1280023C */  lui        $v0, %hi(gReplayCameraSlots)
    /* A6024 800B5824 DCDB4424 */  addiu      $a0, $v0, %lo(gReplayCameraSlots)
  .L800B5828:
    /* A6028 800B5828 0100E724 */  addiu      $a3, $a3, 0x1
    /* A602C 800B582C 0400828C */  lw         $v0, 0x4($a0)
    /* A6030 800B5830 0C00838C */  lw         $v1, 0xC($a0)
    /* A6034 800B5834 80110200 */  sll        $v0, $v0, 6
    /* A6038 800B5838 040082AC */  sw         $v0, 0x4($a0)
    /* A603C 800B583C 0800828C */  lw         $v0, 0x8($a0)
    /* A6040 800B5840 80190300 */  sll        $v1, $v1, 6
    /* A6044 800B5844 0C0083AC */  sw         $v1, 0xC($a0)
    /* A6048 800B5848 80110200 */  sll        $v0, $v0, 6
    /* A604C 800B584C 080082AC */  sw         $v0, 0x8($a0)
    /* A6050 800B5850 2A10E500 */  slt        $v0, $a3, $a1
    /* A6054 800B5854 F4FF4014 */  bnez       $v0, .L800B5828
    /* A6058 800B5858 20008424 */   addiu     $a0, $a0, 0x20
  .L800B585C:
    /* A605C 800B585C 8C00BF8F */  lw         $ra, 0x8C($sp)
    /* A6060 800B5860 8800B08F */  lw         $s0, 0x88($sp)
    /* A6064 800B5864 0800E003 */  jr         $ra
    /* A6068 800B5868 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel Replay_LoadCameraFile__Fv
