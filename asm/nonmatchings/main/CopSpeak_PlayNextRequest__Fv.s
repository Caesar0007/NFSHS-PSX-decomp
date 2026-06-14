.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_PlayNextRequest__Fv, 0x11C

glabel CopSpeak_PlayNextRequest__Fv
    /* 8B028 8009A828 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8B02C 8009A82C 1180033C */  lui        $v1, %hi(CopSpeak_gQueue)
    /* 8B030 8009A830 800B848F */  lw         $a0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B034 8009A834 241F6324 */  addiu      $v1, $v1, %lo(CopSpeak_gQueue)
    /* 8B038 8009A838 1400BFAF */  sw         $ra, 0x14($sp)
    /* 8B03C 8009A83C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8B040 8009A840 40110400 */  sll        $v0, $a0, 5
    /* 8B044 8009A844 21804300 */  addu       $s0, $v0, $v1
    /* 8B048 8009A848 1E000282 */  lb         $v0, 0x1E($s0)
    /* 8B04C 8009A84C 00000000 */  nop
    /* 8B050 8009A850 34004004 */  bltz       $v0, .L8009A924
    /* 8B054 8009A854 3F008228 */   slti      $v0, $a0, 0x3F
    /* 8B058 8009A858 1D000292 */  lbu        $v0, 0x1D($s0)
    /* 8B05C 8009A85C 00000000 */  nop
    /* 8B060 8009A860 2B004014 */  bnez       $v0, .L8009A910
    /* 8B064 8009A864 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 8B068 8009A868 840B838F */  lw         $v1, %gp_rel(CopSpeak_gSpchHandle)($gp)
    /* 8B06C 8009A86C 00000000 */  nop
    /* 8B070 8009A870 30006214 */  bne        $v1, $v0, .L8009A934
    /* 8B074 8009A874 1180023C */   lui       $v0, %hi(CopSpeak_gCurrent)
    /* 8B078 8009A878 041F4A24 */  addiu      $t2, $v0, %lo(CopSpeak_gCurrent)
    /* 8B07C 8009A87C 0000078E */  lw         $a3, 0x0($s0)
    /* 8B080 8009A880 0400088E */  lw         $t0, 0x4($s0)
    /* 8B084 8009A884 0800098E */  lw         $t1, 0x8($s0)
    /* 8B088 8009A888 000047AD */  sw         $a3, 0x0($t2)
    /* 8B08C 8009A88C 040048AD */  sw         $t0, 0x4($t2)
    /* 8B090 8009A890 080049AD */  sw         $t1, 0x8($t2)
    /* 8B094 8009A894 0C00078E */  lw         $a3, 0xC($s0)
    /* 8B098 8009A898 1000088E */  lw         $t0, 0x10($s0)
    /* 8B09C 8009A89C 1400098E */  lw         $t1, 0x14($s0)
    /* 8B0A0 8009A8A0 0C0047AD */  sw         $a3, 0xC($t2)
    /* 8B0A4 8009A8A4 100048AD */  sw         $t0, 0x10($t2)
    /* 8B0A8 8009A8A8 140049AD */  sw         $t1, 0x14($t2)
    /* 8B0AC 8009A8AC 1800078E */  lw         $a3, 0x18($s0)
    /* 8B0B0 8009A8B0 1C00088E */  lw         $t0, 0x1C($s0)
    /* 8B0B4 8009A8B4 180047AD */  sw         $a3, 0x18($t2)
    /* 8B0B8 8009A8B8 1C0048AD */  sw         $t0, 0x1C($t2)
    /* 8B0BC 8009A8BC 1800058E */  lw         $a1, 0x18($s0)
    /* 8B0C0 8009A8C0 00000000 */  nop
    /* 8B0C4 8009A8C4 0500A314 */  bne        $a1, $v1, .L8009A8DC
    /* 8B0C8 8009A8C8 01000624 */   addiu     $a2, $zero, 0x1
    /* 8B0CC 8009A8CC 0800058E */  lw         $a1, 0x8($s0)
    /* 8B0D0 8009A8D0 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8B0D4 8009A8D4 386A0208 */  j          .L8009A8E0
    /* 8B0D8 8009A8D8 0040A524 */   addiu     $a1, $a1, 0x4000
  .L8009A8DC:
    /* 8B0DC 8009A8DC 1E000482 */  lb         $a0, 0x1E($s0)
  .L8009A8E0:
    /* 8B0E0 8009A8E0 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8B0E4 8009A8E4 00000000 */   nop
    /* 8B0E8 8009A8E8 21284000 */  addu       $a1, $v0, $zero
    /* 8B0EC 8009A8EC 0500A104 */  bgez       $a1, .L8009A904
    /* 8B0F0 8009A8F0 03000224 */   addiu     $v0, $zero, 0x3
    /* 8B0F4 8009A8F4 1E000382 */  lb         $v1, 0x1E($s0)
    /* 8B0F8 8009A8F8 00000000 */  nop
    /* 8B0FC 8009A8FC 04006214 */  bne        $v1, $v0, .L8009A910
    /* 8B100 8009A900 00000000 */   nop
  .L8009A904:
    /* 8B104 8009A904 C168020C */  jal        CopSpeak_Play__FP17CopSpeak_tRequesti
    /* 8B108 8009A908 21200002 */   addu      $a0, $s0, $zero
    /* 8B10C 8009A90C 840B82AF */  sw         $v0, %gp_rel(CopSpeak_gSpchHandle)($gp)
  .L8009A910:
    /* 8B110 8009A910 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 8B114 8009A914 21200002 */   addu      $a0, $s0, $zero
    /* 8B118 8009A918 800B848F */  lw         $a0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B11C 8009A91C 00000000 */  nop
    /* 8B120 8009A920 3F008228 */  slti       $v0, $a0, 0x3F
  .L8009A924:
    /* 8B124 8009A924 02004010 */  beqz       $v0, .L8009A930
    /* 8B128 8009A928 21180000 */   addu      $v1, $zero, $zero
    /* 8B12C 8009A92C 01008324 */  addiu      $v1, $a0, 0x1
  .L8009A930:
    /* 8B130 8009A930 800B83AF */  sw         $v1, %gp_rel(CopSpeak_gQueuePlay)($gp)
  .L8009A934:
    /* 8B134 8009A934 1400BF8F */  lw         $ra, 0x14($sp)
    /* 8B138 8009A938 1000B08F */  lw         $s0, 0x10($sp)
    /* 8B13C 8009A93C 0800E003 */  jr         $ra
    /* 8B140 8009A940 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_PlayNextRequest__Fv
