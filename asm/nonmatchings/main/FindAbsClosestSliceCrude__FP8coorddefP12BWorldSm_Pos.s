.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos, 0xA4

glabel FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
    /* 6F170 8007E970 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6F174 8007E974 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6F178 8007E978 21A08000 */  addu       $s4, $a0, $zero
    /* 6F17C 8007E97C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 6F180 8007E980 21A8A000 */  addu       $s5, $a1, $zero
    /* 6F184 8007E984 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6F188 8007E988 FF7F113C */  lui        $s1, (0x7FFFFFFF >> 16)
    /* 6F18C 8007E98C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6F190 8007E990 7C02928F */  lw         $s2, %gp_rel(gNumSlices)($gp)
    /* 6F194 8007E994 FFFF3136 */  ori        $s1, $s1, (0x7FFFFFFF & 0xFFFF)
    /* 6F198 8007E998 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6F19C 8007E99C FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 6F1A0 8007E9A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6F1A4 8007E9A4 21800000 */  addu       $s0, $zero, $zero
    /* 6F1A8 8007E9A8 1000401A */  blez       $s2, .L8007E9EC
    /* 6F1AC 8007E9AC 2800BFAF */   sw        $ra, 0x28($sp)
  .L8007E9B0:
    /* 6F1B0 8007E9B0 7402828F */  lw         $v0, %gp_rel(BWorldSm_slices)($gp)
    /* 6F1B4 8007E9B4 40211000 */  sll        $a0, $s0, 5
    /* 6F1B8 8007E9B8 21288002 */  addu       $a1, $s4, $zero
    /* 6F1BC 8007E9BC 71F5010C */  jal        xzsquaredist32__FP8coorddefT0
    /* 6F1C0 8007E9C0 21204400 */   addu      $a0, $v0, $a0
    /* 6F1C4 8007E9C4 21184000 */  addu       $v1, $v0, $zero
    /* 6F1C8 8007E9C8 2A107100 */  slt        $v0, $v1, $s1
    /* 6F1CC 8007E9CC 03004010 */  beqz       $v0, .L8007E9DC
    /* 6F1D0 8007E9D0 00000000 */   nop
    /* 6F1D4 8007E9D4 21980002 */  addu       $s3, $s0, $zero
    /* 6F1D8 8007E9D8 21886000 */  addu       $s1, $v1, $zero
  .L8007E9DC:
    /* 6F1DC 8007E9DC 08001026 */  addiu      $s0, $s0, 0x8
    /* 6F1E0 8007E9E0 2A101202 */  slt        $v0, $s0, $s2
    /* 6F1E4 8007E9E4 F2FF4014 */  bnez       $v0, .L8007E9B0
    /* 6F1E8 8007E9E8 00000000 */   nop
  .L8007E9EC:
    /* 6F1EC 8007E9EC 0000B3A6 */  sh         $s3, 0x0($s5)
    /* 6F1F0 8007E9F0 2800BF8F */  lw         $ra, 0x28($sp)
    /* 6F1F4 8007E9F4 2400B58F */  lw         $s5, 0x24($sp)
    /* 6F1F8 8007E9F8 2000B48F */  lw         $s4, 0x20($sp)
    /* 6F1FC 8007E9FC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6F200 8007EA00 1800B28F */  lw         $s2, 0x18($sp)
    /* 6F204 8007EA04 1400B18F */  lw         $s1, 0x14($sp)
    /* 6F208 8007EA08 1000B08F */  lw         $s0, 0x10($sp)
    /* 6F20C 8007EA0C 0800E003 */  jr         $ra
    /* 6F210 8007EA10 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
