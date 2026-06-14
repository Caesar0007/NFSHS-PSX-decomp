.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CalcFutureLateralVel__FP8Car_tObji, 0x118

glabel AIWorld_CalcFutureLateralVel__FP8Car_tObji
    /* 63FBC 800737BC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 63FC0 800737C0 2400B1AF */  sw         $s1, 0x24($sp)
    /* 63FC4 800737C4 21888000 */  addu       $s1, $a0, $zero
    /* 63FC8 800737C8 2800BFAF */  sw         $ra, 0x28($sp)
    /* 63FCC 800737CC 2000B0AF */  sw         $s0, 0x20($sp)
    /* 63FD0 800737D0 6002228E */  lw         $v0, 0x260($s1)
    /* 63FD4 800737D4 00000000 */  nop
    /* 63FD8 800737D8 10004230 */  andi       $v0, $v0, 0x10
    /* 63FDC 800737DC 0A004010 */  beqz       $v0, .L80073808
    /* 63FE0 800737E0 1300033C */   lui       $v1, (0x13FFFF >> 16)
    /* 63FE4 800737E4 6405228E */  lw         $v0, 0x564($s1)
    /* 63FE8 800737E8 FFFF6334 */  ori        $v1, $v1, (0x13FFFF & 0xFFFF)
    /* 63FEC 800737EC 02004104 */  bgez       $v0, .L800737F8
    /* 63FF0 800737F0 00000000 */   nop
    /* 63FF4 800737F4 23100200 */  negu       $v0, $v0
  .L800737F8:
    /* 63FF8 800737F8 2A186200 */  slt        $v1, $v1, $v0
    /* 63FFC 800737FC 02006014 */  bnez       $v1, .L80073808
    /* 64000 80073800 00000000 */   nop
    /* 64004 80073804 21280000 */  addu       $a1, $zero, $zero
  .L80073808:
    /* 64008 80073808 08002286 */  lh         $v0, 0x8($s1)
    /* 6400C 8007380C 0900A004 */  bltz       $a1, .L80073834
    /* 64010 80073810 21184500 */   addu      $v1, $v0, $a1
    /* 64014 80073814 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 64018 80073818 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 6401C 8007381C 00000000 */  nop
    /* 64020 80073820 2A106400 */  slt        $v0, $v1, $a0
    /* 64024 80073824 09004014 */  bnez       $v0, .L8007384C
    /* 64028 80073828 00000000 */   nop
    /* 6402C 8007382C 13CE0108 */  j          .L8007384C
    /* 64030 80073830 23186400 */   subu      $v1, $v1, $a0
  .L80073834:
    /* 64034 80073834 05006104 */  bgez       $v1, .L8007384C
    /* 64038 80073838 00000000 */   nop
    /* 6403C 8007383C 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 64040 80073840 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 64044 80073844 00000000 */  nop
    /* 64048 80073848 21186200 */  addu       $v1, $v1, $v0
  .L8007384C:
    /* 6404C 8007384C 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 64050 80073850 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 64054 80073854 40190300 */  sll        $v1, $v1, 5
    /* 64058 80073858 21186200 */  addu       $v1, $v1, $v0
    /* 6405C 8007385C 12006580 */  lb         $a1, 0x12($v1)
    /* 64060 80073860 00000000 */  nop
    /* 64064 80073864 402A0500 */  sll        $a1, $a1, 9
    /* 64068 80073868 1000A5AF */  sw         $a1, 0x10($sp)
    /* 6406C 8007386C 13006280 */  lb         $v0, 0x13($v1)
    /* 64070 80073870 00000000 */  nop
    /* 64074 80073874 40120200 */  sll        $v0, $v0, 9
    /* 64078 80073878 1400A2AF */  sw         $v0, 0x14($sp)
    /* 6407C 8007387C 14006280 */  lb         $v0, 0x14($v1)
    /* 64080 80073880 00000000 */  nop
    /* 64084 80073884 40120200 */  sll        $v0, $v0, 9
    /* 64088 80073888 1800A2AF */  sw         $v0, 0x18($sp)
    /* 6408C 8007388C AC00248E */  lw         $a0, 0xAC($s1)
    /* 64090 80073890 CA90030C */  jal        fixedmult
    /* 64094 80073894 00000000 */   nop
    /* 64098 80073898 B000248E */  lw         $a0, 0xB0($s1)
    /* 6409C 8007389C 1400A58F */  lw         $a1, 0x14($sp)
    /* 640A0 800738A0 CA90030C */  jal        fixedmult
    /* 640A4 800738A4 21804000 */   addu      $s0, $v0, $zero
    /* 640A8 800738A8 B400248E */  lw         $a0, 0xB4($s1)
    /* 640AC 800738AC 1800A58F */  lw         $a1, 0x18($sp)
    /* 640B0 800738B0 CA90030C */  jal        fixedmult
    /* 640B4 800738B4 21884000 */   addu      $s1, $v0, $zero
    /* 640B8 800738B8 21801102 */  addu       $s0, $s0, $s1
    /* 640BC 800738BC 21100202 */  addu       $v0, $s0, $v0
    /* 640C0 800738C0 2800BF8F */  lw         $ra, 0x28($sp)
    /* 640C4 800738C4 2400B18F */  lw         $s1, 0x24($sp)
    /* 640C8 800738C8 2000B08F */  lw         $s0, 0x20($sp)
    /* 640CC 800738CC 0800E003 */  jr         $ra
    /* 640D0 800738D0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIWorld_CalcFutureLateralVel__FP8Car_tObji
