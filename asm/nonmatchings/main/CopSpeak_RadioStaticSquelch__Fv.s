.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_RadioStaticSquelch__Fv, 0x68

glabel CopSpeak_RadioStaticSquelch__Fv
    /* 89D88 80099588 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 89D8C 8009958C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 89D90 80099590 21880000 */  addu       $s1, $zero, $zero
    /* 89D94 80099594 1800B2AF */  sw         $s2, 0x18($sp)
    /* 89D98 80099598 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* 89D9C 8009959C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 89DA0 800995A0 1480103C */  lui        $s0, %hi(CopSpeak_gStaticHandle)
    /* 89DA4 800995A4 F0D01026 */  addiu      $s0, $s0, %lo(CopSpeak_gStaticHandle)
    /* 89DA8 800995A8 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800995AC:
    /* 89DAC 800995AC 0000048E */  lw         $a0, 0x0($s0)
    /* 89DB0 800995B0 00000000 */  nop
    /* 89DB4 800995B4 04009210 */  beq        $a0, $s2, .L800995C8
    /* 89DB8 800995B8 00000000 */   nop
    /* 89DBC 800995BC A09F030C */  jal        SNDstop
    /* 89DC0 800995C0 00000000 */   nop
    /* 89DC4 800995C4 000012AE */  sw         $s2, 0x0($s0)
  .L800995C8:
    /* 89DC8 800995C8 01003126 */  addiu      $s1, $s1, 0x1
    /* 89DCC 800995CC 0200222A */  slti       $v0, $s1, 0x2
    /* 89DD0 800995D0 F6FF4014 */  bnez       $v0, .L800995AC
    /* 89DD4 800995D4 04001026 */   addiu     $s0, $s0, 0x4
    /* 89DD8 800995D8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 89DDC 800995DC 1800B28F */  lw         $s2, 0x18($sp)
    /* 89DE0 800995E0 1400B18F */  lw         $s1, 0x14($sp)
    /* 89DE4 800995E4 1000B08F */  lw         $s0, 0x10($sp)
    /* 89DE8 800995E8 0800E003 */  jr         $ra
    /* 89DEC 800995EC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CopSpeak_RadioStaticSquelch__Fv
