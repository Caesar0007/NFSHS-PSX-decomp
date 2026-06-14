.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_InsertDepthOfField__Fv, 0x1E0

glabel Render_InsertDepthOfField__Fv
    /* A426C 800B3A6C 7C0E838F */  lw         $v1, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A4270 800B3A70 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* A4274 800B3A74 2800BFAF */  sw         $ra, 0x28($sp)
    /* A4278 800B3A78 2400B3AF */  sw         $s3, 0x24($sp)
    /* A427C 800B3A7C 2000B2AF */  sw         $s2, 0x20($sp)
    /* A4280 800B3A80 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* A4284 800B3A84 01006230 */  andi       $v0, $v1, 0x1
    /* A4288 800B3A88 69004010 */  beqz       $v0, .L800B3C30
    /* A428C 800B3A8C 1800B0AF */   sw        $s0, 0x18($sp)
    /* A4290 800B3A90 08006230 */  andi       $v0, $v1, 0x8
    /* A4294 800B3A94 04004010 */  beqz       $v0, .L800B3AA8
    /* A4298 800B3A98 00000000 */   nop
    /* A429C 800B3A9C 740E858F */  lw         $a1, %gp_rel(Render_gBlurEffectDepth1)($gp)
    /* A42A0 800B3AA0 2ACE020C */  jal        StampImage__Fii
    /* A42A4 800B3AA4 01000424 */   addiu     $a0, $zero, 0x1
  .L800B3AA8:
    /* A42A8 800B3AA8 7C0E828F */  lw         $v0, %gp_rel(Render_gBlurEffectMode)($gp)
    /* A42AC 800B3AAC 00000000 */  nop
    /* A42B0 800B3AB0 10004230 */  andi       $v0, $v0, 0x10
    /* A42B4 800B3AB4 05004010 */  beqz       $v0, .L800B3ACC
    /* A42B8 800B3AB8 801F133C */   lui       $s3, (0x1F800004 >> 16)
    /* A42BC 800B3ABC 780E858F */  lw         $a1, %gp_rel(Render_gBlurEffectDepth2)($gp)
    /* A42C0 800B3AC0 2ACE020C */  jal        StampImage__Fii
    /* A42C4 800B3AC4 02000424 */   addiu     $a0, $zero, 0x2
    /* A42C8 800B3AC8 801F133C */  lui        $s3, (0x1F800004 >> 16)
  .L800B3ACC:
    /* A42CC 800B3ACC 04007336 */  ori        $s3, $s3, (0x1F800004 & 0xFFFF)
    /* A42D0 800B3AD0 FF00113C */  lui        $s1, (0xFFFFFF >> 16)
    /* A42D4 800B3AD4 FFFF3136 */  ori        $s1, $s1, (0xFFFFFF & 0xFFFF)
    /* A42D8 800B3AD8 01000524 */  addiu      $a1, $zero, 0x1
    /* A42DC 800B3ADC 801F103C */  lui        $s0, (0x1F800000 >> 16)
    /* A42E0 800B3AE0 00FF123C */  lui        $s2, (0xFF000000 >> 16)
    /* A42E4 800B3AE4 740E848F */  lw         $a0, %gp_rel(Render_gBlurEffectDepth1)($gp)
    /* A42E8 800B3AE8 0000028E */  lw         $v0, (0x1F800000 & 0xFFFF)($s0)
    /* A42EC 800B3AEC 0000668E */  lw         $a2, 0x0($s3)
    /* A42F0 800B3AF0 80200400 */  sll        $a0, $a0, 2
    /* A42F4 800B3AF4 21208200 */  addu       $a0, $a0, $v0
    /* A42F8 800B3AF8 0000C38C */  lw         $v1, 0x0($a2)
    /* A42FC 800B3AFC 0000828C */  lw         $v0, 0x0($a0)
    /* A4300 800B3B00 24187200 */  and        $v1, $v1, $s2
    /* A4304 800B3B04 24105100 */  and        $v0, $v0, $s1
    /* A4308 800B3B08 25186200 */  or         $v1, $v1, $v0
    /* A430C 800B3B0C 0000C3AC */  sw         $v1, 0x0($a2)
    /* A4310 800B3B10 0000828C */  lw         $v0, 0x0($a0)
    /* A4314 800B3B14 1800C324 */  addiu      $v1, $a2, 0x18
    /* A4318 800B3B18 000063AE */  sw         $v1, 0x0($s3)
    /* A431C 800B3B1C 2418D100 */  and        $v1, $a2, $s1
    /* A4320 800B3B20 24105200 */  and        $v0, $v0, $s2
    /* A4324 800B3B24 25104300 */  or         $v0, $v0, $v1
    /* A4328 800B3B28 000082AC */  sw         $v0, 0x0($a0)
    /* A432C 800B3B2C 05000224 */  addiu      $v0, $zero, 0x5
    /* A4330 800B3B30 0300C2A0 */  sb         $v0, 0x3($a2)
    /* A4334 800B3B34 2A000224 */  addiu      $v0, $zero, 0x2A
    /* A4338 800B3B38 40010324 */  addiu      $v1, $zero, 0x140
    /* A433C 800B3B3C 0700C2A0 */  sb         $v0, 0x7($a2)
    /* A4340 800B3B40 0800C0A4 */  sh         $zero, 0x8($a2)
    /* A4344 800B3B44 0A00C0A4 */  sh         $zero, 0xA($a2)
    /* A4348 800B3B48 0C00C3A4 */  sh         $v1, 0xC($a2)
    /* A434C 800B3B4C 0E00C0A4 */  sh         $zero, 0xE($a2)
    /* A4350 800B3B50 1000C0A4 */  sh         $zero, 0x10($a2)
    /* A4354 800B3B54 0400C0A0 */  sb         $zero, 0x4($a2)
    /* A4358 800B3B58 0500C0A0 */  sb         $zero, 0x5($a2)
    /* A435C 800B3B5C 0600C0A0 */  sb         $zero, 0x6($a2)
    /* A4360 800B3B60 0000648E */  lw         $a0, 0x0($s3)
    /* A4364 800B3B64 F0000224 */  addiu      $v0, $zero, 0xF0
    /* A4368 800B3B68 1200C2A4 */  sh         $v0, 0x12($a2)
    /* A436C 800B3B6C 1400C3A4 */  sh         $v1, 0x14($a2)
    /* A4370 800B3B70 1600C2A4 */  sh         $v0, 0x16($a2)
    /* A4374 800B3B74 740E868F */  lw         $a2, %gp_rel(Render_gBlurEffectDepth1)($gp)
    /* A4378 800B3B78 0000028E */  lw         $v0, (0x1F800000 & 0xFFFF)($s0)
    /* A437C 800B3B7C 80300600 */  sll        $a2, $a2, 2
    /* A4380 800B3B80 2130C200 */  addu       $a2, $a2, $v0
    /* A4384 800B3B84 0000838C */  lw         $v1, 0x0($a0)
    /* A4388 800B3B88 0000C28C */  lw         $v0, 0x0($a2)
    /* A438C 800B3B8C 24187200 */  and        $v1, $v1, $s2
    /* A4390 800B3B90 24105100 */  and        $v0, $v0, $s1
    /* A4394 800B3B94 25186200 */  or         $v1, $v1, $v0
    /* A4398 800B3B98 000083AC */  sw         $v1, 0x0($a0)
    /* A439C 800B3B9C 0000C28C */  lw         $v0, 0x0($a2)
    /* A43A0 800B3BA0 0C008324 */  addiu      $v1, $a0, 0xC
    /* A43A4 800B3BA4 000063AE */  sw         $v1, 0x0($s3)
    /* A43A8 800B3BA8 24189100 */  and        $v1, $a0, $s1
    /* A43AC 800B3BAC 24105200 */  and        $v0, $v0, $s2
    /* A43B0 800B3BB0 25104300 */  or         $v0, $v0, $v1
    /* A43B4 800B3BB4 E5B8030C */  jal        SetDrawStp
    /* A43B8 800B3BB8 0000C2AC */   sw        $v0, 0x0($a2)
    /* A43BC 800B3BBC 02000424 */  addiu      $a0, $zero, 0x2
    /* A43C0 800B3BC0 01000524 */  addiu      $a1, $zero, 0x1
    /* A43C4 800B3BC4 21300000 */  addu       $a2, $zero, $zero
    /* A43C8 800B3BC8 00010724 */  addiu      $a3, $zero, 0x100
    /* A43CC 800B3BCC 740E888F */  lw         $t0, %gp_rel(Render_gBlurEffectDepth1)($gp)
    /* A43D0 800B3BD0 0000028E */  lw         $v0, (0x1F800000 & 0xFFFF)($s0)
    /* A43D4 800B3BD4 0000708E */  lw         $s0, 0x0($s3)
    /* A43D8 800B3BD8 04408800 */  sllv       $t0, $t0, $a0
    /* A43DC 800B3BDC 21400201 */  addu       $t0, $t0, $v0
    /* A43E0 800B3BE0 0000038E */  lw         $v1, 0x0($s0)
    /* A43E4 800B3BE4 0000028D */  lw         $v0, 0x0($t0)
    /* A43E8 800B3BE8 24187200 */  and        $v1, $v1, $s2
    /* A43EC 800B3BEC 24105100 */  and        $v0, $v0, $s1
    /* A43F0 800B3BF0 25186200 */  or         $v1, $v1, $v0
    /* A43F4 800B3BF4 000003AE */  sw         $v1, 0x0($s0)
    /* A43F8 800B3BF8 0C000326 */  addiu      $v1, $s0, 0xC
    /* A43FC 800B3BFC 0000028D */  lw         $v0, 0x0($t0)
    /* A4400 800B3C00 24881102 */  and        $s1, $s0, $s1
    /* A4404 800B3C04 000063AE */  sw         $v1, 0x0($s3)
    /* A4408 800B3C08 24105200 */  and        $v0, $v0, $s2
    /* A440C 800B3C0C 25105100 */  or         $v0, $v0, $s1
    /* A4410 800B3C10 FFC6030C */  jal        GetTPage
    /* A4414 800B3C14 000002AD */   sw        $v0, 0x0($t0)
    /* A4418 800B3C18 21200002 */  addu       $a0, $s0, $zero
    /* A441C 800B3C1C 21280000 */  addu       $a1, $zero, $zero
    /* A4420 800B3C20 2130A000 */  addu       $a2, $a1, $zero
    /* A4424 800B3C24 FFFF4730 */  andi       $a3, $v0, 0xFFFF
    /* A4428 800B3C28 EFB8030C */  jal        SetDrawMode
    /* A442C 800B3C2C 1000A0AF */   sw        $zero, 0x10($sp)
  .L800B3C30:
    /* A4430 800B3C30 2800BF8F */  lw         $ra, 0x28($sp)
    /* A4434 800B3C34 2400B38F */  lw         $s3, 0x24($sp)
    /* A4438 800B3C38 2000B28F */  lw         $s2, 0x20($sp)
    /* A443C 800B3C3C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* A4440 800B3C40 1800B08F */  lw         $s0, 0x18($sp)
    /* A4444 800B3C44 0800E003 */  jr         $ra
    /* A4448 800B3C48 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Render_InsertDepthOfField__Fv
