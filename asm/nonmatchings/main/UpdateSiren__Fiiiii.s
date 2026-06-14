.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateSiren__Fiiiii, 0x204

glabel UpdateSiren__Fiiiii
    /* 6A15C 8007995C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6A160 80079960 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6A164 80079964 21888000 */  addu       $s1, $a0, $zero
    /* 6A168 80079968 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6A16C 8007996C 2190A000 */  addu       $s2, $a1, $zero
    /* 6A170 80079970 2400B5AF */  sw         $s5, 0x24($sp)
    /* 6A174 80079974 21A8C000 */  addu       $s5, $a2, $zero
    /* 6A178 80079978 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6A17C 8007997C 1180023C */  lui        $v0, %hi(bSirenOn)
    /* 6A180 80079980 90E74224 */  addiu      $v0, $v0, %lo(bSirenOn)
    /* 6A184 80079984 80181100 */  sll        $v1, $s1, 2
    /* 6A188 80079988 21186200 */  addu       $v1, $v1, $v0
    /* 6A18C 8007998C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 6A190 80079990 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6A194 80079994 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6A198 80079998 0000628C */  lw         $v0, 0x0($v1)
    /* 6A19C 8007999C 4000B08F */  lw         $s0, 0x40($sp)
    /* 6A1A0 800799A0 66004010 */  beqz       $v0, .L80079B3C
    /* 6A1A4 800799A4 21A0E000 */   addu      $s4, $a3, $zero
    /* 6A1A8 800799A8 1180033C */  lui        $v1, %hi(gaChannel)
    /* 6A1AC 800799AC FCE86324 */  addiu      $v1, $v1, %lo(gaChannel)
    /* 6A1B0 800799B0 2B002226 */  addiu      $v0, $s1, 0x2B
    /* 6A1B4 800799B4 C0100200 */  sll        $v0, $v0, 3
    /* 6A1B8 800799B8 21104300 */  addu       $v0, $v0, $v1
    /* 6A1BC 800799BC 0000448C */  lw         $a0, 0x0($v0)
    /* 6A1C0 800799C0 C59E030C */  jal        SNDover
    /* 6A1C4 800799C4 00000000 */   nop
    /* 6A1C8 800799C8 0A004010 */  beqz       $v0, .L800799F4
    /* 6A1CC 800799CC 1180033C */   lui       $v1, %hi(quickSirenTimeCount)
    /* 6A1D0 800799D0 05000012 */  beqz       $s0, .L800799E8
    /* 6A1D4 800799D4 00000000 */   nop
    /* 6A1D8 800799D8 E4E5010C */  jal        SuperCopSirenOn__Fi
    /* 6A1DC 800799DC 21202002 */   addu      $a0, $s1, $zero
    /* 6A1E0 800799E0 7DE60108 */  j          .L800799F4
    /* 6A1E4 800799E4 1180033C */   lui       $v1, %hi(quickSirenTimeCount)
  .L800799E8:
    /* 6A1E8 800799E8 C7E5010C */  jal        quickSirenOn__Fi
    /* 6A1EC 800799EC 21202002 */   addu      $a0, $s1, $zero
    /* 6A1F0 800799F0 1180033C */  lui        $v1, %hi(quickSirenTimeCount)
  .L800799F4:
    /* 6A1F4 800799F4 50E86324 */  addiu      $v1, $v1, %lo(quickSirenTimeCount)
    /* 6A1F8 800799F8 80981100 */  sll        $s3, $s1, 2
    /* 6A1FC 800799FC 21186302 */  addu       $v1, $s3, $v1
    /* 6A200 80079A00 0000628C */  lw         $v0, 0x0($v1)
    /* 6A204 80079A04 2130A002 */  addu       $a2, $s5, $zero
    /* 6A208 80079A08 01004224 */  addiu      $v0, $v0, 0x1
    /* 6A20C 80079A0C 0200C104 */  bgez       $a2, .L80079A18
    /* 6A210 80079A10 000062AC */   sw        $v0, 0x0($v1)
    /* 6A214 80079A14 FF03C624 */  addiu      $a2, $a2, 0x3FF
  .L80079A18:
    /* 6A218 80079A18 83320600 */  sra        $a2, $a2, 10
    /* 6A21C 80079A1C 0200C104 */  bgez       $a2, .L80079A28
    /* 6A220 80079A20 2110C000 */   addu      $v0, $a2, $zero
    /* 6A224 80079A24 21100000 */  addu       $v0, $zero, $zero
  .L80079A28:
    /* 6A228 80079A28 21304000 */  addu       $a2, $v0, $zero
    /* 6A22C 80079A2C 8000C228 */  slti       $v0, $a2, 0x80
    /* 6A230 80079A30 02004010 */  beqz       $v0, .L80079A3C
    /* 6A234 80079A34 7F000524 */   addiu     $a1, $zero, 0x7F
    /* 6A238 80079A38 2128C000 */  addu       $a1, $a2, $zero
  .L80079A3C:
    /* 6A23C 80079A3C 1180033C */  lui        $v1, %hi(gaChannel)
    /* 6A240 80079A40 FCE86324 */  addiu      $v1, $v1, %lo(gaChannel)
    /* 6A244 80079A44 2B002226 */  addiu      $v0, $s1, 0x2B
    /* 6A248 80079A48 C0100200 */  sll        $v0, $v0, 3
    /* 6A24C 80079A4C 21804300 */  addu       $s0, $v0, $v1
    /* 6A250 80079A50 0000048E */  lw         $a0, 0x0($s0)
    /* 6A254 80079A54 749E030C */  jal        SNDpitchbend
    /* 6A258 80079A58 00000000 */   nop
    /* 6A25C 80079A5C 1180023C */  lui        $v0, %hi(sirenCount)
    /* 6A260 80079A60 20E84224 */  addiu      $v0, $v0, %lo(sirenCount)
    /* 6A264 80079A64 21106202 */  addu       $v0, $s3, $v0
    /* 6A268 80079A68 0000438C */  lw         $v1, 0x0($v0)
    /* 6A26C 80079A6C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6A270 80079A70 06006214 */  bne        $v1, $v0, .L80079A8C
    /* 6A274 80079A74 C0101200 */   sll       $v0, $s2, 3
    /* 6A278 80079A78 21105200 */  addu       $v0, $v0, $s2
    /* 6A27C 80079A7C 80100200 */  sll        $v0, $v0, 2
    /* 6A280 80079A80 1401838F */  lw         $v1, %gp_rel(gMasterAmbientLevel)($gp)
    /* 6A284 80079A84 A8E60108 */  j          .L80079AA0
    /* 6A288 80079A88 21105200 */   addu      $v0, $v0, $s2
  .L80079A8C:
    /* 6A28C 80079A8C 40101200 */  sll        $v0, $s2, 1
    /* 6A290 80079A90 21105200 */  addu       $v0, $v0, $s2
    /* 6A294 80079A94 00110200 */  sll        $v0, $v0, 4
    /* 6A298 80079A98 1401838F */  lw         $v1, %gp_rel(gMasterAmbientLevel)($gp)
    /* 6A29C 80079A9C 23105200 */  subu       $v0, $v0, $s2
  .L80079AA0:
    /* 6A2A0 80079AA0 18006200 */  mult       $v1, $v0
    /* 6A2A4 80079AA4 0000048E */  lw         $a0, 0x0($s0)
    /* 6A2A8 80079AA8 12400000 */  mflo       $t0
    /* 6A2AC 80079AAC A59A030C */  jal        SNDvol
    /* 6A2B0 80079AB0 832B0800 */   sra       $a1, $t0, 14
    /* 6A2B4 80079AB4 1480023C */  lui        $v0, %hi(Audio_direct3davail)
    /* 6A2B8 80079AB8 FCD4428C */  lw         $v0, %lo(Audio_direct3davail)($v0)
    /* 6A2BC 80079ABC 00000000 */  nop
    /* 6A2C0 80079AC0 0B004010 */  beqz       $v0, .L80079AF0
    /* 6A2C4 80079AC4 1180033C */   lui       $v1, %hi(gaChannel)
    /* 6A2C8 80079AC8 FCE86324 */  addiu      $v1, $v1, %lo(gaChannel)
    /* 6A2CC 80079ACC 2B002226 */  addiu      $v0, $s1, 0x2B
    /* 6A2D0 80079AD0 C0100200 */  sll        $v0, $v0, 3
    /* 6A2D4 80079AD4 21104300 */  addu       $v0, $v0, $v1
    /* 6A2D8 80079AD8 0000448C */  lw         $a0, 0x0($v0)
    /* 6A2DC 80079ADC 21288002 */  addu       $a1, $s4, $zero
    /* 6A2E0 80079AE0 39A0030C */  jal        SND3dpos
    /* 6A2E4 80079AE4 21300000 */   addu      $a2, $zero, $zero
    /* 6A2E8 80079AE8 CFE60108 */  j          .L80079B3C
    /* 6A2EC 80079AEC 00000000 */   nop
  .L80079AF0:
    /* 6A2F0 80079AF0 2801828F */  lw         $v0, %gp_rel(gStereoMode)($gp)
    /* 6A2F4 80079AF4 00000000 */  nop
    /* 6A2F8 80079AF8 10004010 */  beqz       $v0, .L80079B3C
    /* 6A2FC 80079AFC FCE86324 */   addiu     $v1, $v1, %lo(gaChannel)
    /* 6A300 80079B00 2B002226 */  addiu      $v0, $s1, 0x2B
    /* 6A304 80079B04 C0100200 */  sll        $v0, $v0, 3
    /* 6A308 80079B08 21204300 */  addu       $a0, $v0, $v1
    /* 6A30C 80079B0C 00C08326 */  addiu      $v1, $s4, -0x4000
    /* 6A310 80079B10 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* 6A314 80079B14 2B104300 */  sltu       $v0, $v0, $v1
    /* 6A318 80079B18 03004014 */  bnez       $v0, .L80079B28
    /* 6A31C 80079B1C FFBF0234 */   ori       $v0, $zero, 0xBFFF
    /* 6A320 80079B20 CCE60108 */  j          .L80079B30
    /* 6A324 80079B24 23105400 */   subu      $v0, $v0, $s4
  .L80079B28:
    /* 6A328 80079B28 00408226 */  addiu      $v0, $s4, 0x4000
    /* 6A32C 80079B2C FFFF4230 */  andi       $v0, $v0, 0xFFFF
  .L80079B30:
    /* 6A330 80079B30 0000848C */  lw         $a0, 0x0($a0)
    /* 6A334 80079B34 219A030C */  jal        SNDpan
    /* 6A338 80079B38 032A0200 */   sra       $a1, $v0, 8
  .L80079B3C:
    /* 6A33C 80079B3C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 6A340 80079B40 2400B58F */  lw         $s5, 0x24($sp)
    /* 6A344 80079B44 2000B48F */  lw         $s4, 0x20($sp)
    /* 6A348 80079B48 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6A34C 80079B4C 1800B28F */  lw         $s2, 0x18($sp)
    /* 6A350 80079B50 1400B18F */  lw         $s1, 0x14($sp)
    /* 6A354 80079B54 1000B08F */  lw         $s0, 0x10($sp)
    /* 6A358 80079B58 0800E003 */  jr         $ra
    /* 6A35C 80079B5C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel UpdateSiren__Fiiiii
