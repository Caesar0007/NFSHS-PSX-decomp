.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawMoney__Fiiilii, 0x138

glabel DrawMoney__Fiiilii
    /* 29FF0 800397F0 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* 29FF4 800397F4 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* 29FF8 800397F8 21888000 */  addu       $s1, $a0, $zero
    /* 29FFC 800397FC 9400B3AF */  sw         $s3, 0x94($sp)
    /* 2A000 80039800 2198A000 */  addu       $s3, $a1, $zero
    /* 2A004 80039804 9000B2AF */  sw         $s2, 0x90($sp)
    /* 2A008 80039808 2190E000 */  addu       $s2, $a3, $zero
    /* 2A00C 8003980C 06000224 */  addiu      $v0, $zero, 0x6
    /* 2A010 80039810 9800BFAF */  sw         $ra, 0x98($sp)
    /* 2A014 80039814 1500C210 */  beq        $a2, $v0, .L8003986C
    /* 2A018 80039818 8800B0AF */   sw        $s0, 0x88($sp)
    /* 2A01C 8003981C 0700C228 */  slti       $v0, $a2, 0x7
    /* 2A020 80039820 05004010 */  beqz       $v0, .L80039838
    /* 2A024 80039824 03000224 */   addiu     $v0, $zero, 0x3
    /* 2A028 80039828 0800C210 */  beq        $a2, $v0, .L8003984C
    /* 2A02C 8003982C 5000B027 */   addiu     $s0, $sp, 0x50
    /* 2A030 80039830 2EE60008 */  j          .L800398B8
    /* 2A034 80039834 21200002 */   addu      $a0, $s0, $zero
  .L80039838:
    /* 2A038 80039838 09000224 */  addiu      $v0, $zero, 0x9
    /* 2A03C 8003983C 1400C210 */  beq        $a2, $v0, .L80039890
    /* 2A040 80039840 5000B027 */   addiu     $s0, $sp, 0x50
    /* 2A044 80039844 2EE60008 */  j          .L800398B8
    /* 2A048 80039848 21200002 */   addu      $a0, $s0, $zero
  .L8003984C:
    /* 2A04C 8003984C 94E4020C */  jal        TextSys_Word__Fi
    /* 2A050 80039850 86000424 */   addiu     $a0, $zero, 0x86
    /* 2A054 80039854 1800A427 */  addiu      $a0, $sp, 0x18
    /* 2A058 80039858 21284000 */  addu       $a1, $v0, $zero
    /* 2A05C 8003985C 2F91030C */  jal        sprintf
    /* 2A060 80039860 21300000 */   addu      $a2, $zero, $zero
    /* 2A064 80039864 2DE60008 */  j          .L800398B4
    /* 2A068 80039868 5000B027 */   addiu     $s0, $sp, 0x50
  .L8003986C:
    /* 2A06C 8003986C 94E4020C */  jal        TextSys_Word__Fi
    /* 2A070 80039870 87000424 */   addiu     $a0, $zero, 0x87
    /* 2A074 80039874 1800A427 */  addiu      $a0, $sp, 0x18
    /* 2A078 80039878 21284000 */  addu       $a1, $v0, $zero
    /* 2A07C 8003987C 21300000 */  addu       $a2, $zero, $zero
    /* 2A080 80039880 2F91030C */  jal        sprintf
    /* 2A084 80039884 2138C000 */   addu      $a3, $a2, $zero
    /* 2A088 80039888 2DE60008 */  j          .L800398B4
    /* 2A08C 8003988C 5000B027 */   addiu     $s0, $sp, 0x50
  .L80039890:
    /* 2A090 80039890 94E4020C */  jal        TextSys_Word__Fi
    /* 2A094 80039894 88000424 */   addiu     $a0, $zero, 0x88
    /* 2A098 80039898 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2A09C 8003989C 1800A427 */  addiu      $a0, $sp, 0x18
    /* 2A0A0 800398A0 21284000 */  addu       $a1, $v0, $zero
    /* 2A0A4 800398A4 21300000 */  addu       $a2, $zero, $zero
    /* 2A0A8 800398A8 2F91030C */  jal        sprintf
    /* 2A0AC 800398AC 2138C000 */   addu      $a3, $a2, $zero
    /* 2A0B0 800398B0 5000B027 */  addiu      $s0, $sp, 0x50
  .L800398B4:
    /* 2A0B4 800398B4 21200002 */  addu       $a0, $s0, $zero
  .L800398B8:
    /* 2A0B8 800398B8 389B000C */  jal        FeTools_FormatMoney__FPcl
    /* 2A0BC 800398BC 21284002 */   addu      $a1, $s2, $zero
    /* 2A0C0 800398C0 21200002 */  addu       $a0, $s0, $zero
    /* 2A0C4 800398C4 008C1100 */  sll        $s1, $s1, 16
    /* 2A0C8 800398C8 038C1100 */  sra        $s1, $s1, 16
    /* 2A0CC 800398CC 21282002 */  addu       $a1, $s1, $zero
    /* 2A0D0 800398D0 00841300 */  sll        $s0, $s3, 16
    /* 2A0D4 800398D4 03841000 */  sra        $s0, $s0, 16
    /* 2A0D8 800398D8 21300002 */  addu       $a2, $s0, $zero
    /* 2A0DC 800398DC B000A78F */  lw         $a3, 0xB0($sp)
    /* 2A0E0 800398E0 01001224 */  addiu      $s2, $zero, 0x1
    /* 2A0E4 800398E4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2A0E8 800398E8 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 2A0EC 800398EC 1400B2AF */   sw        $s2, 0x14($sp)
    /* 2A0F0 800398F0 1800A427 */  addiu      $a0, $sp, 0x18
    /* 2A0F4 800398F4 21282002 */  addu       $a1, $s1, $zero
    /* 2A0F8 800398F8 B400A78F */  lw         $a3, 0xB4($sp)
    /* 2A0FC 800398FC 21300002 */  addu       $a2, $s0, $zero
    /* 2A100 80039900 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2A104 80039904 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 2A108 80039908 1400B2AF */   sw        $s2, 0x14($sp)
    /* 2A10C 8003990C 9800BF8F */  lw         $ra, 0x98($sp)
    /* 2A110 80039910 9400B38F */  lw         $s3, 0x94($sp)
    /* 2A114 80039914 9000B28F */  lw         $s2, 0x90($sp)
    /* 2A118 80039918 8C00B18F */  lw         $s1, 0x8C($sp)
    /* 2A11C 8003991C 8800B08F */  lw         $s0, 0x88($sp)
    /* 2A120 80039920 0800E003 */  jr         $ra
    /* 2A124 80039924 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel DrawMoney__Fiiilii
