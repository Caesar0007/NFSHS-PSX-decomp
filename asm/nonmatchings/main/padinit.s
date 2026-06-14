.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching padinit, 0x70

glabel padinit
    /* D48E8 800E40E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D48EC 800E40EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D48F0 800E40F0 1480103C */  lui        $s0, %hi(gPadinfo)
    /* D48F4 800E40F4 9CE81026 */  addiu      $s0, $s0, %lo(gPadinfo)
    /* D48F8 800E40F8 1400BFAF */  sw         $ra, 0x14($sp)
    /* D48FC 800E40FC 0000028E */  lw         $v0, 0x0($s0)
    /* D4900 800E4100 00000000 */  nop
    /* D4904 800E4104 0F004014 */  bnez       $v0, .L800E4144
    /* D4908 800E4108 00000000 */   nop
    /* D490C 800E410C 1480043C */  lui        $a0, %hi(Padglobal)
    /* D4910 800E4110 F0E88424 */  addiu      $a0, $a0, %lo(Padglobal)
    /* D4914 800E4114 4AF7030C */  jal        PadInitDirect
    /* D4918 800E4118 08008524 */   addiu     $a1, $a0, 0x8
    /* D491C 800E411C 98BF030C */  jal        PadStartCom
    /* D4920 800E4120 00000000 */   nop
    /* D4924 800E4124 21200002 */  addu       $a0, $s0, $zero
    /* D4928 800E4128 E8C5030C */  jal        blockclear
    /* D492C 800E412C 54000524 */   addiu     $a1, $zero, 0x54
    /* D4930 800E4130 01000224 */  addiu      $v0, $zero, 0x1
    /* D4934 800E4134 0E80043C */  lui        $a0, %hi(PAD_update)
    /* D4938 800E4138 10428424 */  addiu      $a0, $a0, %lo(PAD_update)
    /* D493C 800E413C FAAB030C */  jal        addtimer
    /* D4940 800E4140 000002AE */   sw        $v0, 0x0($s0)
  .L800E4144:
    /* D4944 800E4144 1400BF8F */  lw         $ra, 0x14($sp)
    /* D4948 800E4148 1000B08F */  lw         $s0, 0x10($sp)
    /* D494C 800E414C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* D4950 800E4150 0800E003 */  jr         $ra
    /* D4954 800E4154 00000000 */   nop
endlabel padinit
