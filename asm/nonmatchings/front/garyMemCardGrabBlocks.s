.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching garyMemCardGrabBlocks, 0x88

glabel garyMemCardGrabBlocks
    /* 40ABC 800502BC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 40AC0 800502C0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 40AC4 800502C4 2188A000 */  addu       $s1, $a1, $zero
    /* 40AC8 800502C8 2000BFAF */  sw         $ra, 0x20($sp)
    /* 40ACC 800502CC 9140010C */  jal        MCRD_getcard
    /* 40AD0 800502D0 1800B0AF */   sw        $s0, 0x18($sp)
    /* 40AD4 800502D4 0580033C */  lui        $v1, %hi(D_80052DA4)
    /* 40AD8 800502D8 10005024 */  addiu      $s0, $v0, 0x10
    /* 40ADC 800502DC A42D648C */  lw         $a0, %lo(D_80052DA4)($v1)
    /* 40AE0 800502E0 0F000324 */  addiu      $v1, $zero, 0xF
    /* 40AE4 800502E4 0180053C */  lui        $a1, %hi(D_80012884)
    /* 40AE8 800502E8 8428A524 */  addiu      $a1, $a1, %lo(D_80012884)
    /* 40AEC 800502EC 21300002 */  addu       $a2, $s0, $zero
    /* 40AF0 800502F0 08004724 */  addiu      $a3, $v0, 0x8
    /* 40AF4 800502F4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 40AF8 800502F8 22EE030C */  jal        MemCardGetDirentry
    /* 40AFC 800502FC 1400A3AF */   sw        $v1, 0x14($sp)
    /* 40B00 80050300 0500201A */  blez       $s1, .L80050318
    /* 40B04 80050304 21180000 */   addu      $v1, $zero, $zero
  .L80050308:
    /* 40B08 80050308 01006324 */  addiu      $v1, $v1, 0x1
    /* 40B0C 8005030C 2A107100 */  slt        $v0, $v1, $s1
    /* 40B10 80050310 FDFF4014 */  bnez       $v0, .L80050308
    /* 40B14 80050314 28001026 */   addiu     $s0, $s0, 0x28
  .L80050318:
    /* 40B18 80050318 1800028E */  lw         $v0, 0x18($s0)
    /* 40B1C 8005031C 00000000 */  nop
    /* 40B20 80050320 02004104 */  bgez       $v0, .L8005032C
    /* 40B24 80050324 00000000 */   nop
    /* 40B28 80050328 FF1F4224 */  addiu      $v0, $v0, 0x1FFF
  .L8005032C:
    /* 40B2C 8005032C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 40B30 80050330 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 40B34 80050334 1800B08F */  lw         $s0, 0x18($sp)
    /* 40B38 80050338 43130200 */  sra        $v0, $v0, 13
    /* 40B3C 8005033C 0800E003 */  jr         $ra
    /* 40B40 80050340 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel garyMemCardGrabBlocks
