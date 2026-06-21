.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_StartBigfileRead__FPciiPi, 0x98

glabel FeAudio_StartBigfileRead__FPciiPi
    /* 6534 80015D34 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 6538 80015D38 1800B2AF */  sw         $s2, 0x18($sp)
    /* 653C 80015D3C 21908000 */  addu       $s2, $a0, $zero
    /* 6540 80015D40 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6544 80015D44 2198A000 */  addu       $s3, $a1, $zero
    /* 6548 80015D48 1400B1AF */  sw         $s1, 0x14($sp)
    /* 654C 80015D4C 2188C000 */  addu       $s1, $a2, $zero
    /* 6550 80015D50 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6554 80015D54 21A0E000 */  addu       $s4, $a3, $zero
    /* 6558 80015D58 2400BFAF */  sw         $ra, 0x24($sp)
    /* 655C 80015D5C 12002012 */  beqz       $s1, .L80015DA8
    /* 6560 80015D60 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6564 80015D64 0180043C */  lui        $a0, %hi(D_80010120)
    /* 6568 80015D68 20018424 */  addiu      $a0, $a0, %lo(D_80010120)
    /* 656C 80015D6C 21282002 */  addu       $a1, $s1, $zero
    /* 6570 80015D70 CF94030C */  jal        reservememadr
    /* 6574 80015D74 21300000 */   addu      $a2, $zero, $zero
    /* 6578 80015D78 21804000 */  addu       $s0, $v0, $zero
    /* 657C 80015D7C 0A000012 */  beqz       $s0, .L80015DA8
    /* 6580 80015D80 00000000 */   nop
    /* 6584 80015D84 17C5030C */  jal        setasyncfile
    /* 6588 80015D88 21204002 */   addu      $a0, $s2, $zero
    /* 658C 80015D8C 21206002 */  addu       $a0, $s3, $zero
    /* 6590 80015D90 21280002 */  addu       $a1, $s0, $zero
    /* 6594 80015D94 6CC5030C */  jal        asyncloadsegment
    /* 6598 80015D98 21302002 */   addu      $a2, $s1, $zero
    /* 659C 80015D9C 000082AE */  sw         $v0, 0x0($s4)
    /* 65A0 80015DA0 6B570008 */  j          .L80015DAC
    /* 65A4 80015DA4 21100002 */   addu      $v0, $s0, $zero
  .L80015DA8:
    /* 65A8 80015DA8 21100000 */  addu       $v0, $zero, $zero
  .L80015DAC:
    /* 65AC 80015DAC 2400BF8F */  lw         $ra, 0x24($sp)
    /* 65B0 80015DB0 2000B48F */  lw         $s4, 0x20($sp)
    /* 65B4 80015DB4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 65B8 80015DB8 1800B28F */  lw         $s2, 0x18($sp)
    /* 65BC 80015DBC 1400B18F */  lw         $s1, 0x14($sp)
    /* 65C0 80015DC0 1000B08F */  lw         $s0, 0x10($sp)
    /* 65C4 80015DC4 0800E003 */  jr         $ra
    /* 65C8 80015DC8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FeAudio_StartBigfileRead__FPciiPi
