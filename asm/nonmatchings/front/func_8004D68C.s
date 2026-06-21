.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8004D68C, 0x48

glabel func_8004D68C
    /* 3DE8C 8004D68C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3DE90 8004D690 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3DE94 8004D694 21808000 */  addu       $s0, $a0, $zero
    /* 3DE98 8004D698 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3DE9C 8004D69C 15000424 */  addiu      $a0, $zero, 0x15
  .L8004D6A0:
    /* 3DEA0 8004D6A0 21280002 */  addu       $a1, $s0, $zero
    /* 3DEA4 8004D6A4 2DDE030C */  jal        CdControl
    /* 3DEA8 8004D6A8 21300000 */   addu      $a2, $zero, $zero
    /* 3DEAC 8004D6AC FCFF4010 */  beqz       $v0, .L8004D6A0
    /* 3DEB0 8004D6B0 15000424 */   addiu     $a0, $zero, 0x15
  .L8004D6B4:
    /* 3DEB4 8004D6B4 D2E3030C */  jal        CdRead2
    /* 3DEB8 8004D6B8 C0010424 */   addiu     $a0, $zero, 0x1C0
    /* 3DEBC 8004D6BC FDFF4010 */  beqz       $v0, .L8004D6B4
    /* 3DEC0 8004D6C0 00000000 */   nop
    /* 3DEC4 8004D6C4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3DEC8 8004D6C8 1000B08F */  lw         $s0, 0x10($sp)
    /* 3DECC 8004D6CC 0800E003 */  jr         $ra
    /* 3DED0 8004D6D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8004D68C
    /* 3DED4 8004D6D4 00000000 */  nop
