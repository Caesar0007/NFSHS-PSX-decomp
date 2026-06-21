.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PerformMenuDestruction__14tFEApplication, 0xA8

glabel PerformMenuDestruction__14tFEApplication
    /* 3A9C 8001329C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3AA0 800132A0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3AA4 800132A4 21908000 */  addu       $s2, $a0, $zero
    /* 3AA8 800132A8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3AAC 800132AC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3AB0 800132B0 902E020C */  jal        Clock_SystemCleanUp__Fv
    /* 3AB4 800132B4 1000B0AF */   sw        $s0, 0x10($sp)
    /* 3AB8 800132B8 21880000 */  addu       $s1, $zero, $zero
  .L800132BC:
    /* 3ABC 800132BC 00141100 */  sll        $v0, $s1, 16
    /* 3AC0 800132C0 83130200 */  sra        $v0, $v0, 14
    /* 3AC4 800132C4 21804202 */  addu       $s0, $s2, $v0
    /* 3AC8 800132C8 0C00038E */  lw         $v1, 0xC($s0)
    /* 3ACC 800132CC 00000000 */  nop
    /* 3AD0 800132D0 09006010 */  beqz       $v1, .L800132F8
    /* 3AD4 800132D4 01002226 */   addiu     $v0, $s1, 0x1
    /* 3AD8 800132D8 6000628C */  lw         $v0, 0x60($v1)
    /* 3ADC 800132DC 00000000 */  nop
    /* 3AE0 800132E0 38004484 */  lh         $a0, 0x38($v0)
    /* 3AE4 800132E4 3C00428C */  lw         $v0, 0x3C($v0)
    /* 3AE8 800132E8 00000000 */  nop
    /* 3AEC 800132EC 09F84000 */  jalr       $v0
    /* 3AF0 800132F0 21206400 */   addu      $a0, $v1, $a0
    /* 3AF4 800132F4 01002226 */  addiu      $v0, $s1, 0x1
  .L800132F8:
    /* 3AF8 800132F8 21884000 */  addu       $s1, $v0, $zero
    /* 3AFC 800132FC 00140200 */  sll        $v0, $v0, 16
    /* 3B00 80013300 03140200 */  sra        $v0, $v0, 16
    /* 3B04 80013304 02004228 */  slti       $v0, $v0, 0x2
    /* 3B08 80013308 ECFF4014 */  bnez       $v0, .L800132BC
    /* 3B0C 8001330C 0C0000AE */   sw        $zero, 0xC($s0)
    /* 3B10 80013310 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 3B14 80013314 E8030424 */   addiu     $a0, $zero, 0x3E8
    /* 3B18 80013318 1480023C */  lui        $v0, %hi(Draw_gDoVSync)
    /* 3B1C 8001331C 21200000 */  addu       $a0, $zero, $zero
    /* 3B20 80013320 21288000 */  addu       $a1, $a0, $zero
    /* 3B24 80013324 7A86000C */  jal        FETextRender_SetABR__Fib
    /* 3B28 80013328 A8D740AC */   sw        $zero, %lo(Draw_gDoVSync)($v0)
    /* 3B2C 8001332C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3B30 80013330 1800B28F */  lw         $s2, 0x18($sp)
    /* 3B34 80013334 1400B18F */  lw         $s1, 0x14($sp)
    /* 3B38 80013338 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B3C 8001333C 0800E003 */  jr         $ra
    /* 3B40 80013340 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PerformMenuDestruction__14tFEApplication
