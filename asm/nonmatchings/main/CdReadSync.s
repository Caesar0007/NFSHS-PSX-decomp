.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdReadSync, 0x104

glabel CdReadSync
    /* F9778 80108F78 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F977C 80108F7C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F9780 80108F80 21988000 */  addu       $s3, $a0, $zero
    /* F9784 80108F84 2000B4AF */  sw         $s4, 0x20($sp)
    /* F9788 80108F88 21A0A000 */  addu       $s4, $a1, $zero
    /* F978C 80108F8C 1400B1AF */  sw         $s1, 0x14($sp)
    /* F9790 80108F90 1480113C */  lui        $s1, %hi(D_8013C2AC)
    /* F9794 80108F94 ACC23126 */  addiu      $s1, $s1, %lo(D_8013C2AC)
    /* F9798 80108F98 1800B2AF */  sw         $s2, 0x18($sp)
    /* F979C 80108F9C 08003226 */  addiu      $s2, $s1, 0x8
    /* F97A0 80108FA0 2400BFAF */  sw         $ra, 0x24($sp)
    /* F97A4 80108FA4 1000B0AF */  sw         $s0, 0x10($sp)
  .L80108FA8:
    /* F97A8 80108FA8 C7C8030C */  jal        VSync
    /* F97AC 80108FAC FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F97B0 80108FB0 0000238E */  lw         $v1, 0x0($s1)
    /* F97B4 80108FB4 00000000 */  nop
    /* F97B8 80108FB8 B0046324 */  addiu      $v1, $v1, 0x4B0
    /* F97BC 80108FBC 2A186200 */  slt        $v1, $v1, $v0
    /* F97C0 80108FC0 13006014 */  bnez       $v1, .L80109010
    /* F97C4 80108FC4 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* F97C8 80108FC8 F8FF228E */  lw         $v0, -0x8($s1)
    /* F97CC 80108FCC 00000000 */  nop
    /* F97D0 80108FD0 09004004 */  bltz       $v0, .L80108FF8
    /* F97D4 80108FD4 00000000 */   nop
    /* F97D8 80108FD8 C7C8030C */  jal        VSync
    /* F97DC 80108FDC FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F97E0 80108FE0 FCFF238E */  lw         $v1, -0x4($s1)
    /* F97E4 80108FE4 00000000 */  nop
    /* F97E8 80108FE8 3C006324 */  addiu      $v1, $v1, 0x3C
    /* F97EC 80108FEC 2A186200 */  slt        $v1, $v1, $v0
    /* F97F0 80108FF0 06006010 */  beqz       $v1, .L8010900C
    /* F97F4 80108FF4 00000000 */   nop
  .L80108FF8:
    /* F97F8 80108FF8 FD22040C */  jal        _read_issue
    /* F97FC 80108FFC 01000424 */   addiu     $a0, $zero, 0x1
    /* F9800 80109000 E4FF308E */  lw         $s0, -0x1C($s1)
    /* F9804 80109004 04240408 */  j          .L80109010
    /* F9808 80109008 00000000 */   nop
  .L8010900C:
    /* F980C 8010900C F8FF308E */  lw         $s0, -0x8($s1)
  .L80109010:
    /* F9810 80109010 09006016 */  bnez       $s3, .L80109038
    /* F9814 80109014 01000424 */   addiu     $a0, $zero, 0x1
    /* F9818 80109018 0000428E */  lw         $v0, 0x0($s2)
    /* F981C 8010901C 00000000 */  nop
    /* F9820 80109020 03004010 */  beqz       $v0, .L80109030
    /* F9824 80109024 00000000 */   nop
    /* F9828 80109028 DFFF0012 */  beqz       $s0, .L80108FA8
    /* F982C 8010902C 00000000 */   nop
  .L80109030:
    /* F9830 80109030 DDFF001E */  bgtz       $s0, .L80108FA8
    /* F9834 80109034 01000424 */   addiu     $a0, $zero, 0x1
  .L80109038:
    /* F9838 80109038 1BDE030C */  jal        CdReady
    /* F983C 8010903C 21288002 */   addu      $a1, $s4, $zero
    /* F9840 80109040 0000428E */  lw         $v0, 0x0($s2)
    /* F9844 80109044 00000000 */  nop
    /* F9848 80109048 04004010 */  beqz       $v0, .L8010905C
    /* F984C 8010904C 21100002 */   addu      $v0, $s0, $zero
    /* F9850 80109050 02000016 */  bnez       $s0, .L8010905C
    /* F9854 80109054 01001024 */   addiu     $s0, $zero, 0x1
    /* F9858 80109058 21100002 */  addu       $v0, $s0, $zero
  .L8010905C:
    /* F985C 8010905C 2400BF8F */  lw         $ra, 0x24($sp)
    /* F9860 80109060 2000B48F */  lw         $s4, 0x20($sp)
    /* F9864 80109064 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F9868 80109068 1800B28F */  lw         $s2, 0x18($sp)
    /* F986C 8010906C 1400B18F */  lw         $s1, 0x14($sp)
    /* F9870 80109070 1000B08F */  lw         $s0, 0x10($sp)
    /* F9874 80109074 0800E003 */  jr         $ra
    /* F9878 80109078 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CdReadSync
