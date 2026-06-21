.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching syncblockio, 0xC0

glabel syncblockio
    /* DAFE8 800EA7E8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* DAFEC 800EA7EC 5800A38F */  lw         $v1, 0x58($sp)
    /* DAFF0 800EA7F0 5C00A88F */  lw         $t0, 0x5C($sp)
    /* DAFF4 800EA7F4 1800A3AF */  sw         $v1, 0x18($sp)
    /* DAFF8 800EA7F8 1C00A4AF */  sw         $a0, 0x1C($sp)
    /* DAFFC 800EA7FC 2000A5AF */  sw         $a1, 0x20($sp)
    /* DB000 800EA800 2400A7AF */  sw         $a3, 0x24($sp)
    /* DB004 800EA804 2800A0AF */  sw         $zero, 0x28($sp)
    /* DB008 800EA808 2C00A7AF */  sw         $a3, 0x2C($sp)
    /* DB00C 800EA80C 2C00A28F */  lw         $v0, 0x2C($sp)
    /* DB010 800EA810 4000BFAF */  sw         $ra, 0x40($sp)
    /* DB014 800EA814 3000A6AF */  sw         $a2, 0x30($sp)
    /* DB018 800EA818 01204228 */  slti       $v0, $v0, 0x2001
    /* DB01C 800EA81C 03004014 */  bnez       $v0, .L800EA82C
    /* DB020 800EA820 3400A8AF */   sw        $t0, 0x34($sp)
    /* DB024 800EA824 00200224 */  addiu      $v0, $zero, 0x2000
    /* DB028 800EA828 2C00A2AF */  sw         $v0, 0x2C($sp)
  .L800EA82C:
    /* DB02C 800EA82C 1800A227 */  addiu      $v0, $sp, 0x18
    /* DB030 800EA830 1000A3AF */  sw         $v1, 0x10($sp)
    /* DB034 800EA834 1400A2AF */  sw         $v0, 0x14($sp)
    /* DB038 800EA838 3000A68F */  lw         $a2, 0x30($sp)
    /* DB03C 800EA83C 2C00A78F */  lw         $a3, 0x2C($sp)
    /* DB040 800EA840 09F80001 */  jalr       $t0
    /* DB044 800EA844 00000000 */   nop
    /* DB048 800EA848 12004010 */  beqz       $v0, .L800EA894
    /* DB04C 800EA84C 3800A2AF */   sw        $v0, 0x38($sp)
    /* DB050 800EA850 21204000 */  addu       $a0, $v0, $zero
    /* DB054 800EA854 0F80053C */  lui        $a1, %hi(synccallback)
    /* DB058 800EA858 93AF030C */  jal        FILE_callbackop
    /* DB05C 800EA85C CCA6A524 */   addiu     $a1, $a1, %lo(synccallback)
    /* DB060 800EA860 1DAA0308 */  j          .L800EA874
    /* DB064 800EA864 00000000 */   nop
  .L800EA868:
    /* DB068 800EA868 3800A48F */  lw         $a0, 0x38($sp)
    /* DB06C 800EA86C 6FB0030C */  jal        FILE_waitop
    /* DB070 800EA870 00000000 */   nop
  .L800EA874:
    /* DB074 800EA874 2400A28F */  lw         $v0, 0x24($sp)
    /* DB078 800EA878 00000000 */  nop
    /* DB07C 800EA87C FAFF4014 */  bnez       $v0, .L800EA868
    /* DB080 800EA880 00000000 */   nop
    /* DB084 800EA884 3800A28F */  lw         $v0, 0x38($sp)
    /* DB088 800EA888 00000000 */  nop
    /* DB08C 800EA88C F6FF4014 */  bnez       $v0, .L800EA868
    /* DB090 800EA890 00000000 */   nop
  .L800EA894:
    /* DB094 800EA894 2800A28F */  lw         $v0, 0x28($sp)
    /* DB098 800EA898 4000BF8F */  lw         $ra, 0x40($sp)
    /* DB09C 800EA89C 00000000 */  nop
    /* DB0A0 800EA8A0 0800E003 */  jr         $ra
    /* DB0A4 800EA8A4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel syncblockio
