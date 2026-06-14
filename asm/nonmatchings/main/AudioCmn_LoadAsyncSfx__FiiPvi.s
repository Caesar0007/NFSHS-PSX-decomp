.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_LoadAsyncSfx__FiiPvi, 0x1A4

glabel AudioCmn_LoadAsyncSfx__FiiPvi
    /* 66F5C 8007675C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 66F60 80076760 2000B2AF */  sw         $s2, 0x20($sp)
    /* 66F64 80076764 21908000 */  addu       $s2, $a0, $zero
    /* 66F68 80076768 3000B6AF */  sw         $s6, 0x30($sp)
    /* 66F6C 8007676C 21B0A000 */  addu       $s6, $a1, $zero
    /* 66F70 80076770 3400B7AF */  sw         $s7, 0x34($sp)
    /* 66F74 80076774 21B8C000 */  addu       $s7, $a2, $zero
    /* 66F78 80076778 2400B3AF */  sw         $s3, 0x24($sp)
    /* 66F7C 8007677C 2198E000 */  addu       $s3, $a3, $zero
    /* 66F80 80076780 21180000 */  addu       $v1, $zero, $zero
    /* 66F84 80076784 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 66F88 80076788 FFFF1124 */  addiu      $s1, $zero, -0x1
    /* 66F8C 8007678C 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 66F90 80076790 02001524 */  addiu      $s5, $zero, 0x2
    /* 66F94 80076794 2800B4AF */  sw         $s4, 0x28($sp)
    /* 66F98 80076798 0580143C */  lui        $s4, %hi(D_800556D0)
    /* 66F9C 8007679C 1180023C */  lui        $v0, %hi(AudioCmn_gSfxSlot)
    /* 66FA0 800767A0 1800B0AF */  sw         $s0, 0x18($sp)
    /* 66FA4 800767A4 34EB5024 */  addiu      $s0, $v0, %lo(AudioCmn_gSfxSlot)
    /* 66FA8 800767A8 3800BFAF */  sw         $ra, 0x38($sp)
  .L800767AC:
    /* 66FAC 800767AC 0400028E */  lw         $v0, 0x4($s0)
    /* 66FB0 800767B0 00000000 */  nop
    /* 66FB4 800767B4 4300C216 */  bne        $s6, $v0, .L800768C4
    /* 66FB8 800767B8 00000000 */   nop
    /* 66FBC 800767BC 0000028E */  lw         $v0, 0x0($s0)
    /* 66FC0 800767C0 00000000 */  nop
    /* 66FC4 800767C4 3F004216 */  bne        $s2, $v0, .L800768C4
    /* 66FC8 800767C8 00000000 */   nop
    /* 66FCC 800767CC 0800028E */  lw         $v0, 0x8($s0)
    /* 66FD0 800767D0 00000000 */  nop
    /* 66FD4 800767D4 3B005114 */  bne        $v0, $s1, .L800768C4
    /* 66FD8 800767D8 00000000 */   nop
    /* 66FDC 800767DC 36006012 */  beqz       $s3, .L800768B8
    /* 66FE0 800767E0 00000000 */   nop
  .L800767E4:
    /* 66FE4 800767E4 3B9F030C */  jal        SNDmemlargestunused
    /* 66FE8 800767E8 1000A427 */   addiu     $a0, $sp, 0x10
    /* 66FEC 800767EC 00F04224 */  addiu      $v0, $v0, -0x1000
    /* 66FF0 800767F0 2A105300 */  slt        $v0, $v0, $s3
    /* 66FF4 800767F4 0B004010 */  beqz       $v0, .L80076824
    /* 66FF8 800767F8 08000426 */   addiu     $a0, $s0, 0x8
    /* 66FFC 800767FC 9DD9010C */  jal        AudioCmn_RemoveOldestAsyncSfx__Fi
    /* 67000 80076800 21204002 */   addu      $a0, $s2, $zero
    /* 67004 80076804 F7FF5114 */  bne        $v0, $s1, .L800767E4
    /* 67008 80076808 00000000 */   nop
    /* 6700C 8007680C 2A005516 */  bne        $s2, $s5, .L800768B8
    /* 67010 80076810 00000000 */   nop
    /* 67014 80076814 33A0030C */  jal        puts
    /* 67018 80076818 D0568426 */   addiu     $a0, $s4, %lo(D_800556D0)
    /* 6701C 8007681C 2FDA0108 */  j          .L800768BC
    /* 67020 80076820 080011AE */   sw        $s1, 0x8($s0)
  .L80076824:
    /* 67024 80076824 7B9F030C */  jal        SNDbankadd
    /* 67028 80076828 2128E002 */   addu      $a1, $s7, $zero
    /* 6702C 8007682C 07000324 */  addiu      $v1, $zero, 0x7
    /* 67030 80076830 13004314 */  bne        $v0, $v1, .L80076880
    /* 67034 80076834 1000A2AF */   sw        $v0, 0x10($sp)
    /* 67038 80076838 0800048E */  lw         $a0, 0x8($s0)
    /* 6703C 8007683C D99E030C */  jal        SNDbankheadersize
    /* 67040 80076840 00000000 */   nop
    /* 67044 80076844 1480043C */  lui        $a0, %hi(D_8013C67C)
    /* 67048 80076848 7CC68424 */  addiu      $a0, $a0, %lo(D_8013C67C)
    /* 6704C 8007684C 21284000 */  addu       $a1, $v0, $zero
    /* 67050 80076850 CF94030C */  jal        reservememadr
    /* 67054 80076854 10000624 */   addiu     $a2, $zero, 0x10
    /* 67058 80076858 09004010 */  beqz       $v0, .L80076880
    /* 6705C 8007685C 140002AE */   sw        $v0, 0x14($s0)
    /* 67060 80076860 0800058E */  lw         $a1, 0x8($s0)
    /* 67064 80076864 EA9E030C */  jal        SNDbankheadercopy
    /* 67068 80076868 21204000 */   addu      $a0, $v0, $zero
    /* 6706C 8007686C 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 67070 80076870 040016AE */  sw         $s6, 0x4($s0)
    /* 67074 80076874 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 67078 80076878 35DA0108 */  j          .L800768D4
    /* 6707C 8007687C 0C0002AE */   sw        $v0, 0xC($s0)
  .L80076880:
    /* 67080 80076880 03005516 */  bne        $s2, $s5, .L80076890
    /* 67084 80076884 0580043C */   lui       $a0, %hi(D_800556EC)
    /* 67088 80076888 33A0030C */  jal        puts
    /* 6708C 8007688C EC568424 */   addiu     $a0, $a0, %lo(D_800556EC)
  .L80076890:
    /* 67090 80076890 0800048E */  lw         $a0, 0x8($s0)
    /* 67094 80076894 D99E030C */  jal        SNDbankheadersize
    /* 67098 80076898 00000000 */   nop
    /* 6709C 8007689C 1000A28F */  lw         $v0, 0x10($sp)
    /* 670A0 800768A0 00000000 */  nop
    /* 670A4 800768A4 04004004 */  bltz       $v0, .L800768B8
    /* 670A8 800768A8 00000000 */   nop
    /* 670AC 800768AC 0800048E */  lw         $a0, 0x8($s0)
    /* 670B0 800768B0 9D99030C */  jal        SNDbankremove
    /* 670B4 800768B4 00000000 */   nop
  .L800768B8:
    /* 670B8 800768B8 080011AE */  sw         $s1, 0x8($s0)
  .L800768BC:
    /* 670BC 800768BC 35DA0108 */  j          .L800768D4
    /* 670C0 800768C0 040011AE */   sw        $s1, 0x4($s0)
  .L800768C4:
    /* 670C4 800768C4 01006324 */  addiu      $v1, $v1, 0x1
    /* 670C8 800768C8 20006228 */  slti       $v0, $v1, 0x20
    /* 670CC 800768CC B7FF4014 */  bnez       $v0, .L800767AC
    /* 670D0 800768D0 18001026 */   addiu     $s0, $s0, 0x18
  .L800768D4:
    /* 670D4 800768D4 3800BF8F */  lw         $ra, 0x38($sp)
    /* 670D8 800768D8 3400B78F */  lw         $s7, 0x34($sp)
    /* 670DC 800768DC 3000B68F */  lw         $s6, 0x30($sp)
    /* 670E0 800768E0 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 670E4 800768E4 2800B48F */  lw         $s4, 0x28($sp)
    /* 670E8 800768E8 2400B38F */  lw         $s3, 0x24($sp)
    /* 670EC 800768EC 2000B28F */  lw         $s2, 0x20($sp)
    /* 670F0 800768F0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 670F4 800768F4 1800B08F */  lw         $s0, 0x18($sp)
    /* 670F8 800768F8 0800E003 */  jr         $ra
    /* 670FC 800768FC 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel AudioCmn_LoadAsyncSfx__FiiPvi
