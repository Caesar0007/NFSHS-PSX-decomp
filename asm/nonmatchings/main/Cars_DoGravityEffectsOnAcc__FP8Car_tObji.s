.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_DoGravityEffectsOnAcc__FP8Car_tObji, 0x140

glabel Cars_DoGravityEffectsOnAcc__FP8Car_tObji
    /* 76584 80085D84 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 76588 80085D88 2000B0AF */  sw         $s0, 0x20($sp)
    /* 7658C 80085D8C 21808000 */  addu       $s0, $a0, $zero
    /* 76590 80085D90 2400BFAF */  sw         $ra, 0x24($sp)
    /* 76594 80085D94 6002028E */  lw         $v0, 0x260($s0)
    /* 76598 80085D98 00000000 */  nop
    /* 7659C 80085D9C 10004230 */  andi       $v0, $v0, 0x10
    /* 765A0 80085DA0 44004014 */  bnez       $v0, .L80085EB4
    /* 765A4 80085DA4 00000000 */   nop
    /* 765A8 80085DA8 0001058E */  lw         $a1, 0x100($s0)
    /* 765AC 80085DAC CA90030C */  jal        fixedmult
    /* 765B0 80085DB0 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 765B4 80085DB4 C1B50334 */  ori        $v1, $zero, 0xB5C1
    /* 765B8 80085DB8 2A186200 */  slt        $v1, $v1, $v0
    /* 765BC 80085DBC 1B006014 */  bnez       $v1, .L80085E2C
    /* 765C0 80085DC0 00000000 */   nop
    /* 765C4 80085DC4 F400058E */  lw         $a1, 0xF4($s0)
    /* 765C8 80085DC8 CA90030C */  jal        fixedmult
    /* 765CC 80085DCC F6FF043C */   lui       $a0, (0xFFF60000 >> 16)
    /* 765D0 80085DD0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 765D4 80085DD4 0001058E */  lw         $a1, 0x100($s0)
    /* 765D8 80085DD8 CA90030C */  jal        fixedmult
    /* 765DC 80085DDC F6FF043C */   lui       $a0, (0xFFF60000 >> 16)
    /* 765E0 80085DE0 1400A2AF */  sw         $v0, 0x14($sp)
    /* 765E4 80085DE4 0C01058E */  lw         $a1, 0x10C($s0)
    /* 765E8 80085DE8 CA90030C */  jal        fixedmult
    /* 765EC 80085DEC F6FF043C */   lui       $a0, (0xFFF60000 >> 16)
    /* 765F0 80085DF0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 765F4 80085DF4 0C04028E */  lw         $v0, 0x40C($s0)
    /* 765F8 80085DF8 1000A38F */  lw         $v1, 0x10($sp)
    /* 765FC 80085DFC 00000000 */  nop
    /* 76600 80085E00 21104300 */  addu       $v0, $v0, $v1
    /* 76604 80085E04 0C0402AE */  sw         $v0, 0x40C($s0)
    /* 76608 80085E08 1004028E */  lw         $v0, 0x410($s0)
    /* 7660C 80085E0C 1400A38F */  lw         $v1, 0x14($sp)
    /* 76610 80085E10 00000000 */  nop
    /* 76614 80085E14 21104300 */  addu       $v0, $v0, $v1
    /* 76618 80085E18 100402AE */  sw         $v0, 0x410($s0)
    /* 7661C 80085E1C 1404028E */  lw         $v0, 0x414($s0)
    /* 76620 80085E20 1800A38F */  lw         $v1, 0x18($sp)
    /* 76624 80085E24 AC170208 */  j          .L80085EB0
    /* 76628 80085E28 21104300 */   addu      $v0, $v0, $v1
  .L80085E2C:
    /* 7662C 80085E2C 40040292 */  lbu        $v0, 0x440($s0)
    /* 76630 80085E30 00000000 */  nop
    /* 76634 80085E34 4000422C */  sltiu      $v0, $v0, 0x40
    /* 76638 80085E38 1E004010 */  beqz       $v0, .L80085EB4
    /* 7663C 80085E3C 00000000 */   nop
    /* 76640 80085E40 0C01058E */  lw         $a1, 0x10C($s0)
    /* 76644 80085E44 CA90030C */  jal        fixedmult
    /* 76648 80085E48 F6FF043C */   lui       $a0, (0xFFF60000 >> 16)
    /* 7664C 80085E4C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 76650 80085E50 9400058E */  lw         $a1, 0x94($s0)
    /* 76654 80085E54 CA90030C */  jal        fixedmult
    /* 76658 80085E58 21204000 */   addu      $a0, $v0, $zero
    /* 7665C 80085E5C 21184000 */  addu       $v1, $v0, $zero
    /* 76660 80085E60 02006104 */  bgez       $v1, .L80085E6C
    /* 76664 80085E64 21106000 */   addu      $v0, $v1, $zero
    /* 76668 80085E68 23100200 */  negu       $v0, $v0
  .L80085E6C:
    /* 7666C 80085E6C CD0C4228 */  slti       $v0, $v0, 0xCCD
    /* 76670 80085E70 10004014 */  bnez       $v0, .L80085EB4
    /* 76674 80085E74 1800A3AF */   sw        $v1, 0x18($sp)
    /* 76678 80085E78 07006018 */  blez       $v1, .L80085E98
    /* 7667C 80085E7C 00000000 */   nop
    /* 76680 80085E80 1404048E */  lw         $a0, 0x414($s0)
    /* 76684 80085E84 00000000 */  nop
    /* 76688 80085E88 0800801C */  bgtz       $a0, .L80085EAC
    /* 7668C 80085E8C 43100300 */   sra       $v0, $v1, 1
    /* 76690 80085E90 AB170208 */  j          .L80085EAC
    /* 76694 80085E94 C3100300 */   sra       $v0, $v1, 3
  .L80085E98:
    /* 76698 80085E98 1404048E */  lw         $a0, 0x414($s0)
    /* 7669C 80085E9C 00000000 */  nop
    /* 766A0 80085EA0 0200801C */  bgtz       $a0, .L80085EAC
    /* 766A4 80085EA4 C3100300 */   sra       $v0, $v1, 3
    /* 766A8 80085EA8 43100300 */  sra        $v0, $v1, 1
  .L80085EAC:
    /* 766AC 80085EAC 21108200 */  addu       $v0, $a0, $v0
  .L80085EB0:
    /* 766B0 80085EB0 140402AE */  sw         $v0, 0x414($s0)
  .L80085EB4:
    /* 766B4 80085EB4 2400BF8F */  lw         $ra, 0x24($sp)
    /* 766B8 80085EB8 2000B08F */  lw         $s0, 0x20($sp)
    /* 766BC 80085EBC 0800E003 */  jr         $ra
    /* 766C0 80085EC0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Cars_DoGravityEffectsOnAcc__FP8Car_tObji
