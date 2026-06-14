.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDesiredSpeed__19AIHigh_BTC_HumanCop, 0x60

glabel SetDesiredSpeed__19AIHigh_BTC_HumanCop
    /* 4E84C 8005E04C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4E850 8005E050 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4E854 8005E054 21808000 */  addu       $s0, $a0, $zero
    /* 4E858 8005E058 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4E85C 8005E05C 0000048E */  lw         $a0, 0x0($s0)
    /* 4E860 8005E060 00000000 */  nop
    /* 4E864 8005E064 6004828C */  lw         $v0, 0x460($a0)
    /* 4E868 8005E068 00000000 */  nop
    /* 4E86C 8005E06C 0B004010 */  beqz       $v0, .L8005E09C
    /* 4E870 8005E070 00000000 */   nop
    /* 4E874 8005E074 FFBC010C */  jal        AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
    /* 4E878 8005E078 00000000 */   nop
    /* 4E87C 8005E07C 21184000 */  addu       $v1, $v0, $zero
    /* 4E880 8005E080 8800058E */  lw         $a1, 0x88($s0)
    /* 4E884 8005E084 0000048E */  lw         $a0, 0x0($s0)
    /* 4E888 8005E088 2A10A300 */  slt        $v0, $a1, $v1
    /* 4E88C 8005E08C 02004010 */  beqz       $v0, .L8005E098
    /* 4E890 8005E090 00000000 */   nop
    /* 4E894 8005E094 2118A000 */  addu       $v1, $a1, $zero
  .L8005E098:
    /* 4E898 8005E098 5C0583AC */  sw         $v1, 0x55C($a0)
  .L8005E09C:
    /* 4E89C 8005E09C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4E8A0 8005E0A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 4E8A4 8005E0A4 0800E003 */  jr         $ra
    /* 4E8A8 8005E0A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetDesiredSpeed__19AIHigh_BTC_HumanCop
