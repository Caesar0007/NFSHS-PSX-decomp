.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SentenceUsesParm, 0xC8

glabel iSPCH_SentenceUsesParm
    /* FB958 8010B158 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* FB95C 8010B15C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FB960 8010B160 21988000 */  addu       $s3, $a0, $zero
    /* FB964 8010B164 2000B4AF */  sw         $s4, 0x20($sp)
    /* FB968 8010B168 21A0A000 */  addu       $s4, $a1, $zero
    /* FB96C 8010B16C 2400BFAF */  sw         $ra, 0x24($sp)
    /* FB970 8010B170 1800B2AF */  sw         $s2, 0x18($sp)
    /* FB974 8010B174 1400B1AF */  sw         $s1, 0x14($sp)
    /* FB978 8010B178 402C040C */  jal        func_8010B100
    /* FB97C 8010B17C 1000B0AF */   sw        $s0, 0x10($sp)
    /* FB980 8010B180 21800000 */  addu       $s0, $zero, $zero
    /* FB984 8010B184 21904000 */  addu       $s2, $v0, $zero
    /* FB988 8010B188 1C00401A */  blez       $s2, .L8010B1FC
    /* FB98C 8010B18C 21880002 */   addu      $s1, $s0, $zero
  .L8010B190:
    /* FB990 8010B190 21206002 */  addu       $a0, $s3, $zero
    /* FB994 8010B194 04006526 */  addiu      $a1, $s3, 0x4
    /* FB998 8010B198 432C040C */  jal        func_8010B10C
    /* FB99C 8010B19C 21300002 */   addu      $a2, $s0, $zero
    /* FB9A0 8010B1A0 21204000 */  addu       $a0, $v0, $zero
    /* FB9A4 8010B1A4 02008290 */  lbu        $v0, 0x2($a0)
    /* FB9A8 8010B1A8 00000000 */  nop
    /* FB9AC 8010B1AC 0F004230 */  andi       $v0, $v0, 0xF
    /* FB9B0 8010B1B0 05005414 */  bne        $v0, $s4, .L8010B1C8
    /* FB9B4 8010B1B4 21180000 */   addu      $v1, $zero, $zero
    /* FB9B8 8010B1B8 7F2C0408 */  j          .L8010B1FC
    /* FB9BC 8010B1BC 01001124 */   addiu     $s1, $zero, 0x1
  .L8010B1C0:
    /* FB9C0 8010B1C0 7B2C0408 */  j          .L8010B1EC
    /* FB9C4 8010B1C4 01001124 */   addiu     $s1, $zero, 0x1
  .L8010B1C8:
    /* FB9C8 8010B1C8 21108300 */  addu       $v0, $a0, $v1
  .L8010B1CC:
    /* FB9CC 8010B1CC 04004290 */  lbu        $v0, 0x4($v0)
    /* FB9D0 8010B1D0 00000000 */  nop
    /* FB9D4 8010B1D4 0F004230 */  andi       $v0, $v0, 0xF
    /* FB9D8 8010B1D8 F9FF5410 */  beq        $v0, $s4, .L8010B1C0
    /* FB9DC 8010B1DC 01006324 */   addiu     $v1, $v1, 0x1
    /* FB9E0 8010B1E0 04006228 */  slti       $v0, $v1, 0x4
    /* FB9E4 8010B1E4 F9FF4014 */  bnez       $v0, .L8010B1CC
    /* FB9E8 8010B1E8 21108300 */   addu      $v0, $a0, $v1
  .L8010B1EC:
    /* FB9EC 8010B1EC 01001026 */  addiu      $s0, $s0, 0x1
    /* FB9F0 8010B1F0 2A101202 */  slt        $v0, $s0, $s2
    /* FB9F4 8010B1F4 E6FF4014 */  bnez       $v0, .L8010B190
    /* FB9F8 8010B1F8 00000000 */   nop
  .L8010B1FC:
    /* FB9FC 8010B1FC 21102002 */  addu       $v0, $s1, $zero
    /* FBA00 8010B200 2400BF8F */  lw         $ra, 0x24($sp)
    /* FBA04 8010B204 2000B48F */  lw         $s4, 0x20($sp)
    /* FBA08 8010B208 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FBA0C 8010B20C 1800B28F */  lw         $s2, 0x18($sp)
    /* FBA10 8010B210 1400B18F */  lw         $s1, 0x14($sp)
    /* FBA14 8010B214 1000B08F */  lw         $s0, 0x10($sp)
    /* FBA18 8010B218 0800E003 */  jr         $ra
    /* FBA1C 8010B21C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSPCH_SentenceUsesParm
