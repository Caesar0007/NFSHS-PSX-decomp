.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdRead, 0x19C

glabel CdRead
    /* F95DC 80108DDC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F95E0 80108DE0 2000B4AF */  sw         $s4, 0x20($sp)
    /* F95E4 80108DE4 21A08000 */  addu       $s4, $a0, $zero
    /* F95E8 80108DE8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F95EC 80108DEC 2198A000 */  addu       $s3, $a1, $zero
    /* F95F0 80108DF0 1000B0AF */  sw         $s0, 0x10($sp)
    /* F95F4 80108DF4 1480103C */  lui        $s0, %hi(D_8013C2B4)
    /* F95F8 80108DF8 B4C21026 */  addiu      $s0, $s0, %lo(D_8013C2B4)
    /* F95FC 80108DFC 2400BFAF */  sw         $ra, 0x24($sp)
    /* F9600 80108E00 1800B2AF */  sw         $s2, 0x18($sp)
    /* F9604 80108E04 1400B1AF */  sw         $s1, 0x14($sp)
    /* F9608 80108E08 0000028E */  lw         $v0, 0x0($s0)
    /* F960C 80108E0C 00000000 */  nop
    /* F9610 80108E10 11004010 */  beqz       $v0, .L80108E58
    /* F9614 80108E14 2190C000 */   addu      $s2, $a2, $zero
    /* F9618 80108E18 C7C8030C */  jal        VSync
    /* F961C 80108E1C FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9620 80108E20 0000038E */  lw         $v1, 0x0($s0)
    /* F9624 80108E24 00000000 */  nop
    /* F9628 80108E28 0B006010 */  beqz       $v1, .L80108E58
    /* F962C 80108E2C 21884000 */   addu      $s1, $v0, $zero
  .L80108E30:
    /* F9630 80108E30 C7C8030C */  jal        VSync
    /* F9634 80108E34 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9638 80108E38 23105100 */  subu       $v0, $v0, $s1
    /* F963C 80108E3C 7900422C */  sltiu      $v0, $v0, 0x79
    /* F9640 80108E40 11004010 */  beqz       $v0, .L80108E88
    /* F9644 80108E44 00000000 */   nop
    /* F9648 80108E48 0000028E */  lw         $v0, 0x0($s0)
    /* F964C 80108E4C 00000000 */  nop
    /* F9650 80108E50 F7FF4014 */  bnez       $v0, .L80108E30
    /* F9654 80108E54 00000000 */   nop
  .L80108E58:
    /* F9658 80108E58 1480043C */  lui        $a0, %hi(D_8013C290)
    /* F965C 80108E5C 90C28424 */  addiu      $a0, $a0, %lo(D_8013C290)
    /* F9660 80108E60 0C0092AC */  sw         $s2, 0xC($a0)
    /* F9664 80108E64 0C00828C */  lw         $v0, 0xC($a0)
    /* F9668 80108E68 00000000 */  nop
    /* F966C 80108E6C 30004330 */  andi       $v1, $v0, 0x30
    /* F9670 80108E70 0D006010 */  beqz       $v1, .L80108EA8
    /* F9674 80108E74 20000224 */   addiu     $v0, $zero, 0x20
    /* F9678 80108E78 0E006210 */  beq        $v1, $v0, .L80108EB4
    /* F967C 80108E7C 46020224 */   addiu     $v0, $zero, 0x246
    /* F9680 80108E80 B0230408 */  j          .L80108EC0
    /* F9684 80108E84 00000000 */   nop
  .L80108E88:
    /* F9688 80108E88 1480103C */  lui        $s0, %hi(D_8013C2B8)
    /* F968C 80108E8C B8C21026 */  addiu      $s0, $s0, %lo(D_8013C2B8)
    /* F9690 80108E90 0000048E */  lw         $a0, 0x0($s0)
    /* F9694 80108E94 23DE030C */  jal        CdSyncCallback
    /* F9698 80108E98 D8FF1026 */   addiu     $s0, $s0, -0x28
    /* F969C 80108E9C 240000AE */  sw         $zero, 0x24($s0)
    /* F96A0 80108EA0 96230408 */  j          .L80108E58
    /* F96A4 80108EA4 00000000 */   nop
  .L80108EA8:
    /* F96A8 80108EA8 00020224 */  addiu      $v0, $zero, 0x200
    /* F96AC 80108EAC B3230408 */  j          .L80108ECC
    /* F96B0 80108EB0 100082AC */   sw        $v0, 0x10($a0)
  .L80108EB4:
    /* F96B4 80108EB4 49020224 */  addiu      $v0, $zero, 0x249
    /* F96B8 80108EB8 B3230408 */  j          .L80108ECC
    /* F96BC 80108EBC 100082AC */   sw        $v0, 0x10($a0)
  .L80108EC0:
    /* F96C0 80108EC0 1480033C */  lui        $v1, %hi(D_8013C290)
    /* F96C4 80108EC4 90C26324 */  addiu      $v1, $v1, %lo(D_8013C290)
    /* F96C8 80108EC8 100062AC */  sw         $v0, 0x10($v1)
  .L80108ECC:
    /* F96CC 80108ECC 1480103C */  lui        $s0, %hi(D_8013C290)
    /* F96D0 80108ED0 90C21026 */  addiu      $s0, $s0, %lo(D_8013C290)
    /* F96D4 80108ED4 0C00028E */  lw         $v0, 0xC($s0)
    /* F96D8 80108ED8 21200000 */  addu       $a0, $zero, $zero
    /* F96DC 80108EDC 20004234 */  ori        $v0, $v0, 0x20
    /* F96E0 80108EE0 0C0002AE */  sw         $v0, 0xC($s0)
    /* F96E4 80108EE4 040013AE */  sw         $s3, 0x4($s0)
    /* F96E8 80108EE8 23DE030C */  jal        CdSyncCallback
    /* F96EC 80108EEC 000014AE */   sw        $s4, 0x0($s0)
    /* F96F0 80108EF0 21200000 */  addu       $a0, $zero, $zero
    /* F96F4 80108EF4 28DE030C */  jal        CdReadyCallback
    /* F96F8 80108EF8 280002AE */   sw        $v0, 0x28($s0)
    /* F96FC 80108EFC 1480033C */  lui        $v1, %hi(CD_read_dma_mode)
    /* F9700 80108F00 D4C2638C */  lw         $v1, %lo(CD_read_dma_mode)($v1)
    /* F9704 80108F04 2C0002AE */  sw         $v0, 0x2C($s0)
    /* F9708 80108F08 01006330 */  andi       $v1, $v1, 0x1
    /* F970C 80108F0C 04006010 */  beqz       $v1, .L80108F20
    /* F9710 80108F10 00000000 */   nop
    /* F9714 80108F14 2CDF030C */  jal        CdDataCallback
    /* F9718 80108F18 21200000 */   addu      $a0, $zero, $zero
    /* F971C 80108F1C 300002AE */  sw         $v0, 0x30($s0)
  .L80108F20:
    /* F9720 80108F20 C7C8030C */  jal        VSync
    /* F9724 80108F24 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F9728 80108F28 1C0002AE */  sw         $v0, 0x1C($s0)
    /* F972C 80108F2C E0DD030C */  jal        CdStatus
    /* F9730 80108F30 00000000 */   nop
    /* F9734 80108F34 E0004230 */  andi       $v0, $v0, 0xE0
    /* F9738 80108F38 04004010 */  beqz       $v0, .L80108F4C
    /* F973C 80108F3C 09000424 */   addiu     $a0, $zero, 0x9
    /* F9740 80108F40 21280000 */  addu       $a1, $zero, $zero
    /* F9744 80108F44 C9DE030C */  jal        CdControlB
    /* F9748 80108F48 21300000 */   addu      $a2, $zero, $zero
  .L80108F4C:
    /* F974C 80108F4C FD22040C */  jal        func_80108BF4
    /* F9750 80108F50 21200000 */   addu      $a0, $zero, $zero
    /* F9754 80108F54 2A100200 */  slt        $v0, $zero, $v0
    /* F9758 80108F58 2400BF8F */  lw         $ra, 0x24($sp)
    /* F975C 80108F5C 2000B48F */  lw         $s4, 0x20($sp)
    /* F9760 80108F60 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F9764 80108F64 1800B28F */  lw         $s2, 0x18($sp)
    /* F9768 80108F68 1400B18F */  lw         $s1, 0x14($sp)
    /* F976C 80108F6C 1000B08F */  lw         $s0, 0x10($sp)
    /* F9770 80108F70 0800E003 */  jr         $ra
    /* F9774 80108F74 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CdRead
