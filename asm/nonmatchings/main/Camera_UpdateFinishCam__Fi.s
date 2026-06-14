.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_UpdateFinishCam__Fi, 0x128

glabel Camera_UpdateFinishCam__Fi
    /* 72A54 80082254 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 72A58 80082258 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 72A5C 8008225C 6400B3AF */  sw         $s3, 0x64($sp)
    /* 72A60 80082260 ACF25324 */  addiu      $s3, $v0, %lo(Camera_gInfo)
    /* 72A64 80082264 00110400 */  sll        $v0, $a0, 4
    /* 72A68 80082268 21104400 */  addu       $v0, $v0, $a0
    /* 72A6C 8008226C 6000B2AF */  sw         $s2, 0x60($sp)
    /* 72A70 80082270 00910200 */  sll        $s2, $v0, 4
    /* 72A74 80082274 5800B0AF */  sw         $s0, 0x58($sp)
    /* 72A78 80082278 21805302 */  addu       $s0, $s2, $s3
    /* 72A7C 8008227C 6800BFAF */  sw         $ra, 0x68($sp)
    /* 72A80 80082280 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 72A84 80082284 7D000382 */  lb         $v1, 0x7D($s0)
    /* 72A88 80082288 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 72A8C 8008228C 04006214 */  bne        $v1, $v0, .L800822A0
    /* 72A90 80082290 00000000 */   nop
    /* 72A94 80082294 3ACF010C */  jal        Anim_Handle__Fi
    /* 72A98 80082298 01000424 */   addiu     $a0, $zero, 0x1
    /* 72A9C 8008229C 7D0002A2 */  sb         $v0, 0x7D($s0)
  .L800822A0:
    /* 72AA0 800822A0 7D000482 */  lb         $a0, 0x7D($s0)
    /* 72AA4 800822A4 7BCF010C */  jal        Anim_GetAnim__Fi
    /* 72AA8 800822A8 00000000 */   nop
    /* 72AAC 800822AC 21204000 */  addu       $a0, $v0, $zero
    /* 72AB0 800822B0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 72AB4 800822B4 3000B127 */  addiu      $s1, $sp, 0x30
    /* 72AB8 800822B8 7ED1010C */  jal        GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef
    /* 72ABC 800822BC 21302002 */   addu      $a2, $s1, $zero
    /* 72AC0 800822C0 0700401C */  bgtz       $v0, .L800822E0
    /* 72AC4 800822C4 1000A427 */   addiu     $a0, $sp, 0x10
    /* 72AC8 800822C8 01000424 */  addiu      $a0, $zero, 0x1
    /* 72ACC 800822CC 06000524 */  addiu      $a1, $zero, 0x6
    /* 72AD0 800822D0 1000A627 */  addiu      $a2, $sp, 0x10
    /* 72AD4 800822D4 A0CF010C */  jal        Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef
    /* 72AD8 800822D8 21382002 */   addu      $a3, $s1, $zero
    /* 72ADC 800822DC 1000A427 */  addiu      $a0, $sp, 0x10
  .L800822E0:
    /* 72AE0 800822E0 0000058E */  lw         $a1, 0x0($s0)
    /* 72AE4 800822E4 2000A627 */  addiu      $a2, $sp, 0x20
    /* 72AE8 800822E8 B6AB030C */  jal        transform
    /* 72AEC 800822EC F000A524 */   addiu     $a1, $a1, 0xF0
    /* 72AF0 800822F0 21202002 */  addu       $a0, $s1, $zero
    /* 72AF4 800822F4 30006626 */  addiu      $a2, $s3, 0x30
    /* 72AF8 800822F8 0000028E */  lw         $v0, 0x0($s0)
    /* 72AFC 800822FC 2000A38F */  lw         $v1, 0x20($sp)
    /* 72B00 80082300 A000428C */  lw         $v0, 0xA0($v0)
    /* 72B04 80082304 0000058E */  lw         $a1, 0x0($s0)
    /* 72B08 80082308 21104300 */  addu       $v0, $v0, $v1
    /* 72B0C 8008230C 080002AE */  sw         $v0, 0x8($s0)
    /* 72B10 80082310 A400A28C */  lw         $v0, 0xA4($a1)
    /* 72B14 80082314 2400A38F */  lw         $v1, 0x24($sp)
    /* 72B18 80082318 21304602 */  addu       $a2, $s2, $a2
    /* 72B1C 8008231C 21104300 */  addu       $v0, $v0, $v1
    /* 72B20 80082320 0C0002AE */  sw         $v0, 0xC($s0)
    /* 72B24 80082324 A800A28C */  lw         $v0, 0xA8($a1)
    /* 72B28 80082328 2800A38F */  lw         $v1, 0x28($sp)
    /* 72B2C 8008232C F000A524 */  addiu      $a1, $a1, 0xF0
    /* 72B30 80082330 21104300 */  addu       $v0, $v0, $v1
    /* 72B34 80082334 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 72B38 80082338 100002AE */   sw        $v0, 0x10($s0)
    /* 72B3C 8008233C 7400028E */  lw         $v0, 0x74($s0)
    /* 72B40 80082340 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* 72B44 80082344 24104300 */  and        $v0, $v0, $v1
    /* 72B48 80082348 FBFF0324 */  addiu      $v1, $zero, -0x5
    /* 72B4C 8008234C 24104300 */  and        $v0, $v0, $v1
    /* 72B50 80082350 F7FF0324 */  addiu      $v1, $zero, -0x9
    /* 72B54 80082354 24104300 */  and        $v0, $v0, $v1
    /* 72B58 80082358 70004234 */  ori        $v0, $v0, 0x70
    /* 72B5C 8008235C 740002AE */  sw         $v0, 0x74($s0)
    /* 72B60 80082360 6800BF8F */  lw         $ra, 0x68($sp)
    /* 72B64 80082364 6400B38F */  lw         $s3, 0x64($sp)
    /* 72B68 80082368 6000B28F */  lw         $s2, 0x60($sp)
    /* 72B6C 8008236C 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 72B70 80082370 5800B08F */  lw         $s0, 0x58($sp)
    /* 72B74 80082374 0800E003 */  jr         $ra
    /* 72B78 80082378 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel Camera_UpdateFinishCam__Fi
